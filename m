Return-Path: <netdev+bounces-18819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DF4758BE5
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 05:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C488928177B
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 03:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD525185E;
	Wed, 19 Jul 2023 03:13:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28B617D5
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 03:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED166C433C8;
	Wed, 19 Jul 2023 03:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689736420;
	bh=MCNEIFzz4msIUUVp+c7YBHexyIq1QAdwhHAR+zf0V5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EyWkvphXPFcKR57nmr5tlsi5Ph2StInamVTxD9/Po4hVqVnsfZlongWBI+wxIfTY9
	 kfb4kb/ZNTDYE9hbck3nw9HTowtRw+nIQHkz6JrXACRK4jRvMe8AiDr+Ax8P90YOPt
	 JaFbbpXTOL29fBMgw68Xww8wQNMtV61K6yd9Cbsqcdgl91AHzWSr8ozy4XP5lWCywt
	 ikgv0EsgGJYS+VhvezIzHtHPHw2489vmrwPF3RWL9HpXCu5QpyMPVCM/3CG56Zn+vO
	 7ajMd2h0UipH9k+s7JAIfOANfldjhfplhli/HcMxZFWij73uiCXeAwxsMBllHwbake
	 sIsKQ8VJNtIaQ==
Date: Tue, 18 Jul 2023 20:13:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, Pablo Neira Ayuso
 <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org
Subject: Re: [PATCH nf-next 1/2] netlink: allow be16 and be32 types in all
 uint policy checks
Message-ID: <20230718201338.3a4c5a05@kernel.org>
In-Reply-To: <20230719025323.GA27896@breakpoint.cc>
References: <20230718075234.3863-1-fw@strlen.de>
	<20230718075234.3863-2-fw@strlen.de>
	<20230718115633.3a15062d@kernel.org>
	<20230719025323.GA27896@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jul 2023 04:53:23 +0200 Florian Westphal wrote:
> > On a quick grep we were using it in the kernel -> user
> > direction but not validating on input. Is that right?  
> 
> Looks like ipset is the only user, it sets it for kernel->user
> dir.
> 
> I see ipset userspace even sets it on user -> kernel dir but
> like you say, its not checked and BE encoding is assumed on
> kernel side.
> 
> From a quick glance in ipset all Uxx types are always treated as
> bigendian, which would mean things should not fall apart if ipset
> stops announcing NLA_F_NET_BYTEORDER.  Not sure its worth risking
> any breakage though.
> 
> I suspect that in practice, given both producer and consumer need
> to agree of the meaning of type "12345" anyway its easier to just
> agree on the byte ordering as well.
> 
> Was there a specific reason for the question?

I was wondering what we should do with it going forward. Looks like it
was added by 8f4c1f9b049d ("[NETLINK]: Introduce nested and byteorder
flag to netlink attribute") which says:

    The byte-order flag is yet unused, it's intended use is to
    allow automatic byte order convertions for all atomic types.

That idea clearly never gained traction. If nobody knows of any use of
the flag outside of ipset I'm tempted to send a patch to officially
deprecate it and possibly reuse that bit for something else later on?

