Return-Path: <netdev+bounces-243666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE45CA5113
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 20:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E8C0321CB30
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 19:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90DF3559EC;
	Thu,  4 Dec 2025 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/TdZ+0j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE34355810;
	Thu,  4 Dec 2025 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873461; cv=none; b=FvER9nQv0qnP8jKRgDiBmjzQiwRy71M8z+wND3ebshMNzjC5QwJ1XrBAfJJF5rJ8jGLmPn/rSWFtSRkIneNHk1ANSHlgW2YeRBpy+Ke0Qw2pHOz9cFSw3TfMPGgGXJegniw29w6DBuCroJj4Atmo9E5qEEN+Qqr+nZz3gY46dpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873461; c=relaxed/simple;
	bh=bYWLSgF9p7Y5PVUDIPslbzBPgg5NlyMtulDnw+w6ZEc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R519iaYAJHZOJ5cRRzZqIUJZaUPMI/vGY53srgiRa89Y4UI/58FkUsD/CwdF+X94J6IgkXDXy4q/C8vYj2ZzPDcN9lKB2tUeI6EVQtCzOrm4w2JLfWL5qq69JRz/SNDGzYYxnNQUtGJZ6vMWULscwhly9FacGRrNOCQItVpYtKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/TdZ+0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640D6C116C6;
	Thu,  4 Dec 2025 18:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764873461;
	bh=bYWLSgF9p7Y5PVUDIPslbzBPgg5NlyMtulDnw+w6ZEc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C/TdZ+0jKLvwtqzuLmY578EyageX500aWx4B97L2AGETjMz0TJtXQNw3NqF331SYg
	 HQvqoIsdo+CZr3PFCYlyJ5B9EmQWdx26dms+p64N7yKDON3EFAG0pK0HFLYeUZmNg5
	 9NUNkf7CzSG2+Y5NhPqGR3USJaQ6FH90zPwG3Ois3qUAjV1Vqy+2YHm2KgUq3z+Q78
	 QH8XEqDETRW4EAqdOcfN7O8+T8hnzi/ADTvHqBZPtfpdze5TrVACCXuZZ9vDli5zay
	 ZYHoDohjEzZZ7aQLOJeM2Xpje6kziAgtH+cRLIhw53JRfGDYCV3h68D6YQvaOzJ9r3
	 e0W5KIg1Vc/Zw==
Date: Thu, 4 Dec 2025 10:37:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Russell King
 <linux@armlinux.org.uk>, Frank Wunderlich <frank-w@public-files.de>, Daniel
 Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Mason Chang
 <mason-cw.chang@mediatek.com>
Subject: Re: [RFC v2 2/3] net: ethernet: mtk_eth_soc: Add RSS support
Message-ID: <20251204103739.013d053b@kernel.org>
In-Reply-To: <20251204165849.8214-3-linux@fw-web.de>
References: <20251204165849.8214-1-linux@fw-web.de>
	<20251204165849.8214-3-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Dec 2025 17:58:44 +0100 Frank Wunderlich wrote:
> +static int mtk_rss_init(struct mtk_eth *eth)
> +{
> +	const struct mtk_soc_data *soc = eth->soc;
> +	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
> +	struct mtk_rss_params *rss_params = &eth->rss_params;
> +	static u8 hash_key[MTK_RSS_HASH_KEYSIZE] = {
> +		0xfa, 0x01, 0xac, 0xbe, 0x3b, 0xb7, 0x42, 0x6a,
> +		0x0c, 0xf2, 0x30, 0x80, 0xa3, 0x2d, 0xcb, 0x77,
> +		0xb4, 0x30, 0x7b, 0xae, 0xcb, 0x2b, 0xca, 0xd0,
> +		0xb0, 0x8f, 0xa3, 0x43, 0x3d, 0x25, 0x67, 0x41,
> +		0xc2, 0x0e, 0x5b, 0x25, 0xda, 0x56, 0x5a, 0x6d};
> +	u32 val;
> +	int i;
> +
> +	memcpy(rss_params->hash_key, hash_key, MTK_RSS_HASH_KEYSIZE);

netdev_rss_key_fill()

> +	for (i = 0; i < MTK_RSS_MAX_INDIRECTION_TABLE; i++)
> +		rss_params->indirection_table[i] = i % eth->soc->rss_num;

ethtool_rxfh_indir_default()

> +static int mtk_get_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxfh)
> +{
> +	struct mtk_mac *mac = netdev_priv(dev);
> +	struct mtk_eth *eth = mac->hw;
> +	struct mtk_rss_params *rss_params = &eth->rss_params;
> +	int i;
> +
> +	if (rxfh->hfunc)
> +		rxfh->hfunc = ETH_RSS_HASH_TOP;	/* Toeplitz */

hfunc is not a pointer, you should just set it?

> +	if (rxfh->key) {
> +		memcpy(rxfh->key, rss_params->hash_key,
> +		       sizeof(rss_params->hash_key));
> +	}
> +
> +	if (rxfh->indir) {
> +		for (i = 0; i < MTK_RSS_MAX_INDIRECTION_TABLE; i++)
> +			rxfh->indir[i] = rss_params->indirection_table[i];
> +	}
> +
> +	return 0;
> +}

