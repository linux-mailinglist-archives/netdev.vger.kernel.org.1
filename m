Return-Path: <netdev+bounces-44298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C387C7D781C
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 00:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 474B2B21173
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 22:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E112410A1D;
	Wed, 25 Oct 2023 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8l6OsMG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CC479CD
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 22:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3367C433C7;
	Wed, 25 Oct 2023 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698273625;
	bh=qfels1GYMTPfnHoxUp0H97xy17t+4MpcMZslcbdXlTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z8l6OsMGIrBIB1ROCA2X/RxkK0jc9MA4OXyVteCFe/oFT+HDvYrQMymtXnhMDxFva
	 kls3WJ1IEuuleQujkDmi9oe7qwd4Fd/dakjSeOeavZjGyp8ovUwnt4sABCeg/uBxuP
	 8/ARvVtNmeq1Insw+oAdbJg3x4p3NsOC87W2FdHMAblx0DShIzvY6COZnO84N37XAF
	 717r/5Ihc4yHEvzZHit/YnaUbUJFTbpYJerrXB0tCrzuL/MlhDqjN8Z8i7FOjVuTjF
	 iks7d6HCVAhdiBRSzZxxSsZmnvP3Sfzl7+ITC8IThqdBm9c/sO8pJirlMUrzTPW0Vk
	 2IUXy2kn8noWQ==
Date: Wed, 25 Oct 2023 15:40:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, richardcochran@gmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 sebastian.tobuschat@oss.nxp.com
Subject: Re: [PATCH net-next v8 4/7] net: macsec: introduce
 mdo_insert_tx_tag
Message-ID: <20231025154023.576a2f7b@kernel.org>
In-Reply-To: <20231023094327.565297-5-radu-nicolae.pirea@oss.nxp.com>
References: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
	<20231023094327.565297-5-radu-nicolae.pirea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 12:43:24 +0300 Radu Pirea (NXP OSS) wrote:
> +	if (unlikely(skb_headroom(skb) < ops->needed_headroom ||
> +		     skb_tailroom(skb) < ops->needed_tailroom)) {

This sort of "if head / tail room is to small, realloc" helper would 
be more widely applicable, we should factor it out.

> +		struct sk_buff *nskb = skb_copy_expand(skb,

And this should perhaps be pskb_expand_head().

> +						       ops->needed_headroom,
> +						       ops->needed_tailroom,
> +						       GFP_ATOMIC);
> +		if (likely(nskb)) {
> +			consume_skb(skb);
> +			skb = nskb;
> +		} else {
> +			err = -ENOMEM;
> +			goto cleanup;
> +		}
> +	} else {
> +		skb = skb_unshare(skb, GFP_ATOMIC);

You don't need to unshare if tailroom is 0, you just need to call
skb_cow_head(). 

I think we have this sort of code in DSA already, IIRC Vladimir wrote
it. dsa_realloc_skb() ? Can we factor out / reuse that?

> +		if (!skb)
> +			return ERR_PTR(-ENOMEM);
> +	}
> +
> +	err = ops->mdo_insert_tx_tag(phydev, skb);
> +	if (unlikely(err))
> +		goto cleanup;
> +
> +	if (unlikely(skb->len - ETH_HLEN > macsec_priv(dev)->real_dev->mtu)) {

You can check that first, if the packet is going to be dropped no point
doing the expansions.

> +		err = -EINVAL;
> +		goto cleanup;
> +	}

