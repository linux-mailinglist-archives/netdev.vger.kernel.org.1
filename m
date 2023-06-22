Return-Path: <netdev+bounces-12998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD12739A23
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5531C21085
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8E83AA9C;
	Thu, 22 Jun 2023 08:35:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6443AA98
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576EEC433C8;
	Thu, 22 Jun 2023 08:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687422904;
	bh=KDLQ9xNp31dS/nV7cvQenvg1kyXNS/C6eSlL62wcYek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUEPP3uzZD2b4Iuyy+QW4+pC/WJ0i/sUPw/NOYXywuomx0+9I6d0jD7/hPoLSObNB
	 3xqezGHqBlnFnHBNOY3IL30zS7JtXMIb0pNI5wtyOHgJaxhfT34jj2N9I1P+8gFiSZ
	 nTp9lLE4s367nJPsA5VTCf3vJWr8vCXuZYjzPOcCcgaVZE60BBKAJlrERgdkP50ktS
	 2QiE/bYuEKkYMx3ExMt0BQgdSzsq42AkngAm3XAZKx82uujkxk1N3DO3phlvzPjhE7
	 mLI3pxfZZ33RNpCAZnepshr8wwkwGiYNVeWL7Bgi1EinMFgyMo4M4iK4GdbbUrnOiI
	 exu4PkwDS9XvA==
Date: Thu, 22 Jun 2023 11:35:00 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Setting security path with IPsec packet offload mode
Message-ID: <20230622083500.GA234767@unreal>
References: <DM5PR1801MB18831A63ED0689236ED2506FE322A@DM5PR1801MB1883.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR1801MB18831A63ED0689236ED2506FE322A@DM5PR1801MB1883.namprd18.prod.outlook.com>

On Thu, Jun 22, 2023 at 06:58:06AM +0000, Bharat Bhushan wrote:
> Hi All,
> 
> Have a query related to security patch (secpath_set()) with packet offload mode on egress side. Working to enable ipsec packet offload while Crypto offload is working.
> For packet offload xfrm_offload(*skb) returns false in driver. While looking in xfrm framework, cannot find where security patch (secpath_set()) is set with packet offload mode on egress side.

The idea of packet offload is to take plain text packets and perform all needed magic
in HW without need from driver and stack to make anything.

We don't set secpath in TX path as such packets exit from XFRM as "plain" ones toward HW.
It is different in RX, we set there, as XFRM core still needs to perform some code on
the arrived packets, before forwarding them to stack.

Thanks

> 
> For sure I might be missing something here and looking for help to understand same. Meantime just tried below hack:
> 
> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> index ff114d68cc43..8499c0e74a5a 100644
> --- a/net/xfrm/xfrm_output.c
> +++ b/net/xfrm/xfrm_output.c
> @@ -718,12 +718,24 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
>         }
>  
>         if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET) {
> +               struct sec_path *sp;
>                 if (!xfrm_dev_offload_ok(skb, x)) {
>                         XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
>                         kfree_skb(skb);
>                         return -EHOSTUNREACH;
>                 }
>  
> +               sp = secpath_set(skb);
> +               if (!sp) {
> +                       XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> +                       kfree_skb(skb);
> +                       return -ENOMEM;
> +               }
> +
> +               sp->olen++;
> +               sp->xvec[sp->len++] = x;
> +               xfrm_state_hold(x);
> +
>                 return xfrm_output_resume(sk, skb, 0);
>         }
>  
> 
> Thanks in advance,
> -Bharat
> 

