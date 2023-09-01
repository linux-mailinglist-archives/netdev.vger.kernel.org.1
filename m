Return-Path: <netdev+bounces-31732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BD778FD3F
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 14:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695BB1C20C8D
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 12:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3703FBA56;
	Fri,  1 Sep 2023 12:30:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282D5A94B
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 12:30:00 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0321310F3;
	Fri,  1 Sep 2023 05:29:51 -0700 (PDT)
Received: from [78.30.34.192] (port=58402 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1qc3HV-00B3Nr-Vc; Fri, 01 Sep 2023 14:29:48 +0200
Date: Fri, 1 Sep 2023 14:29:44 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC] netfilter: nf_tables: ignore -EOPNOTSUPP on flowtable
 device offload setup
Message-ID: <ZPHZOKwPFflnqfFz@calendula>
References: <20230831201420.63178-1-nbd@nbd.name>
 <ZPGjVl7jmLhMhgBP@calendula>
 <2575f329-7d95-46f8-ab88-2bcdf8b87d66@nbd.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2575f329-7d95-46f8-ab88-2bcdf8b87d66@nbd.name>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 01, 2023 at 12:30:37PM +0200, Felix Fietkau wrote:
> On 01.09.23 10:39, Pablo Neira Ayuso wrote:
> > Hi Felix,
> > 
> > On Thu, Aug 31, 2023 at 10:14:20PM +0200, Felix Fietkau wrote:
> > > On many embedded devices, it is common to configure flowtable offloading for
> > > a mix of different devices, some of which have hardware offload support and
> > > some of which don't.
> > > The current code limits the ability of user space to properly set up such a
> > > configuration by only allowing adding devices with hardware offload support to
> > > a offload-enabled flowtable.
> > > Given that offload-enabled flowtables also imply fallback to pure software
> > > offloading, this limitation makes little sense.
> > > Fix it by not bailing out when the offload setup returns -EOPNOTSUPP
> > 
> > Would you send a v2 to untoggle the offload flag when listing the
> > ruleset if EOPNOTSUPP is reported? Thus, the user knows that no
> > hardware offload is being used.
> 
> Wouldn't that mess up further updates to the flowtable? From what I can
> tell, when updating a flow table, changing its offload flag is not
> supported.

The flag would be untoggled if hardware offload is not supported. What
problematic scenario are you having in mind that might break?

In any case, there is a need to provide a way to tell the user if the
hardware offload is actually happening or not, if not what I suggest,
then propose a different way. But user really needs to know if it runs
software or hardware plane to debug issues.

