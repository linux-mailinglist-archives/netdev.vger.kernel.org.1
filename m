Return-Path: <netdev+bounces-42286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4CB7CE0D2
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB36280F2F
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB3B38BA8;
	Wed, 18 Oct 2023 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PEPpTwem"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C45338BA7
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:11:46 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8384D112
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mrmpxsOgh3KQun1Pjxkm03h8ie97yj/4GaPK5+66v0A=; b=PEPpTwemWKCLZlN83+RWsq8oTy
	5PAYe+0XU2Gea0Y39GSRPZfEPFucRWUu74he0HPY/cBh1fGVU1+1sGUA8etofQNZouaMD3na09vPs
	Wx3/1qT4Dta6XdliC7jnyZJJNOZuzTTLoRlougr1j03CqhyH6kCjZg7YuQBN/pC7GKbA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qt8Cx-002aym-Q8; Wed, 18 Oct 2023 17:11:39 +0200
Date: Wed, 18 Oct 2023 17:11:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Coco Li <lixiaoyan@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Mubashir Adnan Qureshi <mubashirq@google.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>
Subject: Re: [PATCH v2 net-next 2/5] net-smnp: reorganize SNMP fast path
 variables
Message-ID: <b9ac3b26-fe48-46bc-8a10-89c682e71322@lunn.ch>
References: <20231017014716.3944813-1-lixiaoyan@google.com>
 <20231017014716.3944813-3-lixiaoyan@google.com>
 <a666cea7-078d-4dc0-bad9-87fa15e44036@lunn.ch>
 <CANn89iJVGQ0hpX8aSXjyfubntfy_a9xrZ5gGrx+ekY0THZ4p+Q@mail.gmail.com>
 <353dcd1e-a191-488c-8802-fede2a644453@lunn.ch>
 <CANn89iKfXxaLr0b-rp0_+X7QY82pK21zeLCVjqxNipfKkwOnDg@mail.gmail.com>
 <0e826d9b-cdb6-b0a3-195e-25ead1faf484@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e826d9b-cdb6-b0a3-195e-25ead1faf484@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 08:55:44AM -0600, David Ahern wrote:
> On 10/17/23 1:15 PM, Eric Dumazet wrote:
> > Perhaps add a big comment in the file itself, instead of repeating it
> > on future commit changelogs ?
> 
> I think a comment in the file would be better. I spent a fair amount of
> time reviewing code double checking the impact of the moves; a comment
> in that header file would have been helpful.

We probably want both.

A patch to a uapi file is something which as a reviewer immediately
triggers questions about is it going to break backwards
compatibility. Having it clearly mentioned in the commit message
immediately answers those questions. I would say it is best practice
to do so.

Patching the header itself makes a lot of sense if we actually think
it is useless being in uapi.

   Andrew

