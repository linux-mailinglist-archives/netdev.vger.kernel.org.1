Return-Path: <netdev+bounces-31412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A512578D69D
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 16:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508B5281035
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 14:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775686AA4;
	Wed, 30 Aug 2023 14:46:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFC663CD
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 14:46:51 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3C6D1
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 07:46:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 29A8B5C00D5;
	Wed, 30 Aug 2023 10:46:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 30 Aug 2023 10:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1693406809; x=1693493209; bh=Nzvn9aN33ZViQ
	TYBZ9qkGbM2QDbWSPzsKh0wTweHrWY=; b=msBtvNuV6Ai6RPI8UMDB66/oFkdzV
	l5EcN517Y1WtZm2NtyX+r8n8aZU/huZXSrTFpvzLQ/KZ+qD0RTpztnUy4r0USQxt
	ezTncETDsgzmDFyFLsV0rxEAkyyITxfwS255L3tRMCrXJvooOvy0LW6GSY45MVPV
	3cWnN14A3CKgk0SYR/FrWHGMYBI5KaUvRZ4qYeB7xwrrkC0kedo5XZBy9Ay6lTI3
	jHcDel2INmhTP3Wcmi9zpfnpJf8fIdNw2yNTCBMxf+FZbvpSXAZqeKnoJADqS33N
	gMpFcm4FvOwcg3lT+T3nkeSaMOH9E0IsudLA6GiIRl22Sx1mkq+bj+8Yw==
X-ME-Sender: <xms:WFbvZHmd95H_Ff-lHsJT1mdZgW2TcIEntpAJQIl7yFiFeTNkgPN24A>
    <xme:WFbvZK3eav8M0_WPTsCn5As4T5dKwps2KpZsw8OfIEkR-eDJPdieA-TtodHg6kMVp
    -1GYKclfF1lqPo>
X-ME-Received: <xmr:WFbvZNqVbAkjitguf4dcjB5-8_KTNTMLleRT9G3nUtEhmU30Yt_bVJGhuXYpA3CcHk2pY3Q931l8NEJERnTQORSIOYtRFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefkedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhephefhtdejvdeiffefudduvdffgeetieeigeeugfduffdvffdtfeehieejtdfh
    jeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:WFbvZPkVuQfasZJyJev30Yv2kJpFeRPuU6O7bWRZh6mRj0txtwXY9g>
    <xmx:WFbvZF3VW_8G6oUqr3NqUyLegL4AG_bH3dfo4KuMpv3Tp0O7Drnzhw>
    <xmx:WFbvZOsCbhTJ_QZe9H-PRO4hILFClxWpEQ-47vCnfWtrOtYFnImAyA>
    <xmx:WVbvZDBRl0pDwqyK7mnNqfoN41BlYjxdAlcioheFm7E6UCHq5a8neQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Aug 2023 10:46:48 -0400 (EDT)
Date: Wed, 30 Aug 2023 17:46:44 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net] net: fib: avoid warn splat in flow dissector
Message-ID: <ZO9WVHlbL7a0qwxx@shredder>
References: <20230830110043.30497-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830110043.30497-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 01:00:37PM +0200, Florian Westphal wrote:
> New skbs allocated via nf_send_reset() have skb->dev == NULL.
> 
> fib*_rules_early_flow_dissect helpers already have a 'struct net'
> argument but its not passed down to the flow dissector core, which
> will then WARN as it can't derive a net namespace to use:
> 
>  WARNING: CPU: 0 PID: 0 at net/core/flow_dissector.c:1016 __skb_flow_dissect+0xa91/0x1cd0
>  [..]
>   ip_route_me_harder+0x143/0x330
>   nf_send_reset+0x17c/0x2d0 [nf_reject_ipv4]
>   nft_reject_inet_eval+0xa9/0xf2 [nft_reject_inet]
>   nft_do_chain+0x198/0x5d0 [nf_tables]
>   nft_do_chain_inet+0xa4/0x110 [nf_tables]
>   nf_hook_slow+0x41/0xc0
>   ip_local_deliver+0xce/0x110
>   ..
> 
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Fixes: 812fa71f0d96 ("netfilter: Dissect flow after packet mangling")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217826
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks!

