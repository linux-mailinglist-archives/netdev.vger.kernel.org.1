Return-Path: <netdev+bounces-236589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E99AC3E2FF
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 03:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA46918891C5
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 02:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA031E1DFC;
	Fri,  7 Nov 2025 02:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkafNwPD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC63E2AE90
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 02:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480874; cv=none; b=NxRhQeUftZGX/8UZl1320YkSt8uY+Uf0Uc9De5cu2D0NZjCgX8/i6A/5U3hvrHunqFmceZpW+nkfD1lAFYQJAvrScJUPjSW3/bTcLhiYJDNW1iuyVuB2bIeWLyjUEAFQjpWvl6xKLsoyra6U9LiqCUrNdPyuyZe33wrIrYtHsvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480874; c=relaxed/simple;
	bh=F1hq3UfBXeSsLIglZk7jVRG7XeUABC0zzge07J/ZNFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nn2p1eZ3C39PYVKSRBsShyGk34Ddwzq6NG+lGORdjvPjzjp6/SVvuF14o5IDHYrX5yeHfCAmw5JGs1g3n7p6nI6mWpKnxRQdo8132xx7MpNTNZphsqdTLW0U0YUdP2VR/xuHq64/9HFiBmj/3tONhfgwM1eeTMm761g36aVzMmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkafNwPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9580AC19421;
	Fri,  7 Nov 2025 02:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762480873;
	bh=F1hq3UfBXeSsLIglZk7jVRG7XeUABC0zzge07J/ZNFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TkafNwPDsabhxh5LZp8f78BxYE1sKX+X+FPGXpP7fArD40rQ4PQLBIOqB1K+pRhyI
	 niDbiSUTyHOpcHgfXMbNBBXEpPP6LJJrl+Ylm8G6RVFw6b/NkYtR+/qTfCR/4z1kNr
	 8jDgHeZ8/4FJc6u7qKBgDfhoe/LKmjrW1Iyg76G2XO/CdsdDO0IbS+8kKAQfE6mhbs
	 rNwuplL4VGdhC2bdyyY3Mq4B3iV3Wu8vGFadSmVELR4GMBOIGw20JrdjXFv6jv5lwg
	 AfSm7WP/bYa85R89ANEmyiOdl5YOBRgJv92EHV17XUVYFjCgUJC4C1rYnPz9qarRpD
	 IxDaw1uBGoYvw==
Date: Thu, 6 Nov 2025 18:01:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, Philo Lu
 <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Lukas Bulwahn
 <lukas.bulwahn@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>, Troy Mitchell
 <troy.mitchell@linux.spacemit.com>, Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v10 3/5] eea: probe the netdevice and create
 adminq
Message-ID: <20251106180111.1a71c2ea@kernel.org>
In-Reply-To: <20251105013419.10296-4-xuanzhuo@linux.alibaba.com>
References: <20251105013419.10296-1-xuanzhuo@linux.alibaba.com>
	<20251105013419.10296-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Nov 2025 09:34:17 +0800 Xuan Zhuo wrote:
> +		if (rep->has_reply) {
> +			rep->reply_str[EEA_HINFO_MAX_REP_LEN - 1] = '\0';
> +			dev_warn(dev, "Device replied in host_info config: %s",

nit: missing \n ?

> +				 rep->reply_str);
> +		}
> +	}
> +
> +	kfree(rep);
> +err_free_cfg:
> +	kfree(cfg);
> +	return rc;
> +}

> +static int eea_netdev_init_features(struct net_device *netdev,
> +				    struct eea_net *enet,
> +				    struct eea_device *edev)
> +{
> +	struct eea_aq_cfg *cfg __free(kfree) = NULL;
> +	int err;
> +	u32 mtu;
> +
> +	cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
> +	if (!cfg)
> +		return -ENOMEM;
> +
> +	err = eea_adminq_query_cfg(enet, cfg);
> +	if (err)
> +		return err;

AFAICT this is leaking cfg

> +	mtu = le16_to_cpu(cfg->mtu);
> +	if (mtu < ETH_MIN_MTU) {
> +		dev_err(edev->dma_dev, "The device gave us an invalid MTU. Here we can only exit the initialization. %d < %d",
> +			mtu, ETH_MIN_MTU);
> +		return -EINVAL;

and here? perhaps cfg is always leaked..

> +void eea_net_remove(struct eea_device *edev)
> +{
> +	struct net_device *netdev;
> +	struct eea_net *enet;
> +
> +	enet = edev->enet;
> +	netdev = enet->netdev;
> +
> +	unregister_netdev(netdev);
> +	netdev_dbg(enet->netdev, "eea removed.\n");
> +
> +	eea_device_reset(edev);
> +
> +	eea_destroy_adminq(enet);

missing free_netdev(), looks transient but each patch must be correct..
-- 
pw-bot: cr

