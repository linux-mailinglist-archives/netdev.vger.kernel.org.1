Return-Path: <netdev+bounces-158657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 183D7A12DFF
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 23:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6532D1889AC4
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 22:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29001D7E37;
	Wed, 15 Jan 2025 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTXpjadQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28E5132C38;
	Wed, 15 Jan 2025 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736978444; cv=none; b=bBvxV5x2c5aq050sNu0zAkjz6UUWlnct+7YbfszxNSDn7/wgHSz4QQc0rxDE/gbJkK5NNOVp/09/w8tN8NK5Pwm5lpkSXG5dK/lMN2Nzzc6fiRR958d44AFKAvp4G4KPJ/3E1WepUbjZ4Xw64XrbEB208xacuivjEiSZkMPOnn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736978444; c=relaxed/simple;
	bh=keIMQnDJxBzpB6xvALOz2UCHABne6y4Z0KtjLyVep5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJp4vSzvY0VtLLovCF8uORFYCWaHacKD6BfvVNn33Nmh6WMWmCvEteCYlqJ76zjllbPBIZ4kbML3r6XNhpMEhQ2e3ZlkcDG8Z8KzFiZkfiD4wgET1r2wXs4HGMoFS9T/eIgWhZ4O41ffPn1foOtqVzkN+h1rP2CATomLJ99CJBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTXpjadQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8036C4CED1;
	Wed, 15 Jan 2025 22:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736978444;
	bh=keIMQnDJxBzpB6xvALOz2UCHABne6y4Z0KtjLyVep5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iTXpjadQmUDeZ0NqHYPMeKUPWl24TTEJXe90UuH6alD/w/TPayh70MuTKNekAjDpE
	 VGaAvz6OaUPLF0gYbwFfqs3Xd4uEmc48PeR/UoQPsV4n250F/RWAQki2ObaYjqcPYq
	 O+RzY4z2xcBfcqbW+GeD6YSHEKOu9peWXnnroxkmpscbMb2QKCcb3Xzw3KXEmLhg6c
	 lYL8gXVsXX+uw4/geqD076j9LVuyxGKNgps2oga2SmyKeqatBNNxe6N/Bb7kRVKmVr
	 TO5Z2iE3Fv23C0VuB7qyn0RbbhU5cOWNsIh3hiT8SOTUibQ6kRClU7wGMO9EOQ85sr
	 n0Zdppzc/cuNg==
Date: Wed, 15 Jan 2025 14:00:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, christophe.leroy@csgroup.eu, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 net-next 07/13] net: enetc: add RSS support for
 i.MX95 ENETC PF
Message-ID: <20250115140042.63b99c4f@kernel.org>
In-Reply-To: <20250113082245.2332775-8-wei.fang@nxp.com>
References: <20250113082245.2332775-1-wei.fang@nxp.com>
	<20250113082245.2332775-8-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 16:22:39 +0800 Wei Fang wrote:
> Add Receive side scaling (RSS) support for i.MX95 ENETC PF to improve the
> network performance and balance the CPU loading. In addition, since both
> ENETC v1 and ENETC v4 only support the toeplitz algorithm, so a check for
> hfunc was added.

This and previous commits are a bi hard to follow. You plumb some
stuff thru in the previous commit. In this one you reshuffle things,
again. Try to separate code movement / restructuring in one commit. 
And new additions more clearly in the next.

> +static void enetc4_set_rss_key(struct enetc_hw *hw, const u8 *key)
> +{
> +	int i;
> +
> +	for (i = 0; i < ENETC_RSSHASH_KEY_SIZE / 4; i++)
> +		enetc_port_wr(hw, ENETC4_PRSSKR(i), ((u32 *)key)[i]);
> +}
> +
> +static void enetc4_get_rss_key(struct enetc_hw *hw, u8 *key)
> +{
> +	int i;
> +
> +	for (i = 0; i < ENETC_RSSHASH_KEY_SIZE / 4; i++)
> +		((u32 *)key)[i] = enetc_port_rd(hw, ENETC4_PRSSKR(i));
> +}

Isn't the only difference between the chips the register offset?
Why create full ops for something this trivial?

> +static int enetc4_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *rxnfc,
> +			    u32 *rule_locs)
> +{
> +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +
> +	switch (rxnfc->cmd) {
> +	case ETHTOOL_GRXRINGS:
> +		rxnfc->data = priv->num_rx_rings;
> +		break;
> +	case ETHTOOL_GRXFH:
> +		return enetc_get_rsshash(rxnfc);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}

Why add a new function instead of returning EOPNOTSUPP for new chips 
in the existing one?

> @@ -712,6 +730,12 @@ static int enetc_set_rxfh(struct net_device *ndev,
>  	struct enetc_hw *hw = &si->hw;
>  	int err = 0;
>  
> +	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
> +	    rxfh->hfunc != ETH_RSS_HASH_TOP) {
> +		netdev_err(ndev, "Only toeplitz hash function is supported\n");
> +		return -EOPNOTSUPP;

Should be a separate commit.
-- 
pw-bot: cr

