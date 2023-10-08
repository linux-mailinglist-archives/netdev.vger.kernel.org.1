Return-Path: <netdev+bounces-38903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9767BCF4B
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 18:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6133F281668
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 16:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D39156FE;
	Sun,  8 Oct 2023 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dd+JVcqs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83332111BE
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 16:53:14 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9459FB3
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=s4zdCWtHJkvvcGUYbRF5C1v1GrxTx3mEYvzjCimSyKY=; b=dd+JVcqszhblUcudR62pZwrQUF
	sAfa0/zSrt+3J+tkcA9PEdeE6HStoMv6auUjy0yx+5KvAZxaHvm9Esr0Dw/HKFHEQtfG5QL0K4lG/
	5YxxSsZnjf/tyA8Y8Oi7NBo8Vo9W32tJwktj9WXdtkExo5+YkjssFbKbrZDsU8r79aIc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qpX1d-000cjr-Rw; Sun, 08 Oct 2023 18:53:05 +0200
Date: Sun, 8 Oct 2023 18:53:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vlad Buslov <vladbu@nvidia.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org,
	deb.chatterjee@intel.com, anjali.singhai@intel.com,
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com,
	jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, kernel@mojatatu.com, khalidm@nvidia.com,
	toke@redhat.com, mattyk@nvidia.com
Subject: Re: [PATCH RFC v6 net-next 13/17] p4tc: add table entry create,
 update, get, delete, flush and dump
Message-ID: <a57b639c-dd5c-4e16-9943-2c0aec724c5d@lunn.ch>
References: <20230930143542.101000-1-jhs@mojatatu.com>
 <20230930143542.101000-14-jhs@mojatatu.com>
 <87edi5ysun.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edi5ysun.fsf@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > +/* Invoked from both control and data path  */
> > +static int __p4tc_table_entry_update(struct p4tc_pipeline *pipeline,
> > +				     struct p4tc_table *table,
> > +				     struct p4tc_table_entry *entry,
> > +				     struct p4tc_table_entry_mask *mask,
> > +				     u16 whodunnit, bool from_control)
> > +__must_hold(RCU)
> > +{
> > +	struct p4tc_table_entry_mask *mask_found = NULL;
> > +	struct p4tc_table_entry_work *entry_work;
> > +	struct p4tc_table_entry_value *value_old;
> > +	struct p4tc_table_entry_value *value;
> > +	struct p4tc_table_entry *entry_old;
> > +	struct p4tc_table_entry_tm *tm_old;
> > +	struct p4tc_table_entry_tm *tm;
> > +	int ret;
> > +
> > +	value = p4tc_table_entry_value(entry);
> > +	/* We set it to zero on create an update to avoid having entry
> > +	 * deletion in parallel before we report to user space.
> > +	 */
> > +	refcount_set(&value->entries_ref, 0);
> 
> TBH I already commented on one of the previous versions of this series
> that it is very hard to understand and review tons of different atomic
> reference counters, especially when they are modified with functions
> like refcount_dec_not_one() or unconditional set like in this place.

Hi Vlad

Please always trim replies to just the relevant text. This is a 3000
line patch, which i think you made one comment in, but maybe i missed
others will paging down again, again and again....

       Andrew

