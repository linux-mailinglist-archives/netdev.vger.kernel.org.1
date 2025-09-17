Return-Path: <netdev+bounces-223963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D98B7F85F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179203A6E73
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 10:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB77534F462;
	Wed, 17 Sep 2025 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8Igic/o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DD4309F12
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758105812; cv=none; b=nfAIivLUV4I4aVEViR+i03hCt67KXMtDgoUvGz2EACFLTBMQHfc5TWGBwGdPeo2SXhxpR5UiwRR9Vzakjd8mqGh8q5uqHu5LDWZklxLW2H5c6FM5HSfTpZ28tWEWw4Y/e3nZ4XD1ohEvc/5lwsLOb4K/kc4QXIYl9kOe4N6J0jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758105812; c=relaxed/simple;
	bh=7I53Ykw1eFryroVQTuUQXnFZzr85bDzFPt1fAEv0b6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btstctlyKNc4sYfmdV2Jnr1X651cEQEeMtyy8ZTnK+vvwmi474EmSoOedny4pRl4dqmeNVWm2kmvH5CvyoX/hkAuOcb4aqin9CL7oN26jvTGsj/997MnZ9wpvW4yiYiSWr6mi55aJO2g1u/l3gfi/3cZ0zEN+pv+CtxzIpFHj14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8Igic/o; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b07da72aff2so77821966b.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 03:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758105809; x=1758710609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Yyh8Hkqs7GqsXIM+okxGaGUnlxOgHFmx9rSotm4MB8=;
        b=A8Igic/oEB//tu0k72oof6mGPZKpfAXvaJzlLQERXXttCRaly8afI5OKULJcaaJaZ7
         dNbwam/HPx8EPMjfZpF6yyLbmCOy9FN3DKXxMbpqiw1EFttv/bAYFupFlhzOi2ppEMMJ
         iuD/703qij7BsKIETYwzlXvbbu54Yt9gxzHhoYZY94yhEHDrDckuyJAn7+CV+4qdHqta
         1olTqp5HmMy25UZVhMExyd7K6bSEKuk195o/BKMRCv7YUvYryYvwpC1DqAEyi6XBR1Va
         MecsB6oRtPUD1kDqkVNfIy0+X9nsHtA+E9dM6Xddn15/+7GAHSFtkae/pPfYVtpUpHGm
         ZYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758105809; x=1758710609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Yyh8Hkqs7GqsXIM+okxGaGUnlxOgHFmx9rSotm4MB8=;
        b=Mw7DJ4Z01wiOxQjMORzXa20ODIw5vQ3HaKXzdSUzKcBirSo4p+/m2W7+/oaXH/rz9h
         txxj/8zz/IB/QDR3P+jXKdmqtSonsuZ+rQl6EQhN7FwRmJoGuXsd33sRdfFFnyNpot55
         cNZ6/oV6dvh5yKeXSxkKGlgjL4DT9xSEuSik3alfbLzsjIA69C3vvP89lPIULzc3NFYf
         x16h8PDRggNu0x+o5IJcBTqYTE7MwiIEcX4ds7zPq9PW/Cuji19R+F1nx52Zl88ZdYaR
         Zg6dJukN4gmU1OzmGipRwDXeX2pKFc8pB1oRF0DHHsAxXZMp6HPApK79Gkyr+4KQJmwg
         qqHw==
X-Forwarded-Encrypted: i=1; AJvYcCVlBkhCtjAjdCwJflRGC9T5S+Z+deBlqwHz+9cbwhzwvD04EB+K+O0Amecff1d0QpZ0uyBvG/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCJlGh4/lV6ZJd0wnObsSec7/aAf9JXX61BW9Mp3uD2tKVmh+j
	zo2U61N/8UZtyOFFtIqq/7GAnAULy/YzAw+TIDv2zQdC3e9LjmhAhzl/
X-Gm-Gg: ASbGncsL0c1r0PZoYc2ew10EIz7MY46b/Ro0f9dNSn0BFuSfKwtuCL1XLJZ6zmmYEUY
	ash3fBsvl20ZOxmnsLYRjKqC48R3FZDCdGhY0StT5QjvRXyquG1+vrlEup2iasDVUzOdzmEctgv
	kqqNTwqhHcnNDHk140GmsfW5H66ifPEIF60bmatbLvUhFBCdtkoSPJCSQJ/43Lt+0z/S7Oh9+2p
	PP7ejLQkpuGXaG/BHlaEzltkSGucNP5Jp3honbhPK5RClgE7hIQ1dn2WK1FxgKjryBFTHMPxH8P
	J9ZbiKzezDPX1WUfQd5f3Wq/gWhHO5+TbLzHz9jmou1jRR1BFhoYZ5FRftLPO/uC5Mu7mbf90vd
	SQDcAjBUFsfDY3hQ=
X-Google-Smtp-Source: AGHT+IF0bGu8coGo8S13flYMunWY6PoCzFUDuD7l8SY41Vuc7seAVPH3vRAusBx3pRQ3RA9KkKbEpA==
X-Received: by 2002:a17:907:7e93:b0:b04:669f:e70f with SMTP id a640c23a62f3a-b1bb7f2a4f5mr112464766b.2.1758105808719;
        Wed, 17 Sep 2025 03:43:28 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:8bcc:b603:fee7:a273])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07c6110c27sm1132722066b.66.2025.09.17.03.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:43:28 -0700 (PDT)
Date: Wed, 17 Sep 2025 13:43:25 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v18 5/8] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <20250917104325.j5je2jtachee7thw@skbuf>
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
 <20250915104545.1742-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915104545.1742-6-ansuelsmth@gmail.com>

On Mon, Sep 15, 2025 at 12:45:41PM +0200, Christian Marangi wrote:
> +static const struct an8855_mib_desc an8855_mib[] = {
> +	MIB_DESC(1, AN8855_PORT_MIB_TX_DROP, "TxDrop"),
> +	MIB_DESC(1, AN8855_PORT_MIB_TX_CRC_ERR, "TxCrcErr"),
> +	MIB_DESC(1, AN8855_PORT_MIB_TX_COLLISION, "TxCollision"),
> +	MIB_DESC(1, AN8855_PORT_MIB_TX_OVERSIZE_DROP, "TxOversizeDrop"),
> +	MIB_DESC(2, AN8855_PORT_MIB_TX_BAD_PKT_BYTES, "TxBadPktBytes"),
> +	MIB_DESC(1, AN8855_PORT_MIB_RX_DROP, "RxDrop"),
> +	MIB_DESC(1, AN8855_PORT_MIB_RX_FILTERING, "RxFiltering"),
> +	MIB_DESC(1, AN8855_PORT_MIB_RX_CRC_ERR, "RxCrcErr"),
> +	MIB_DESC(1, AN8855_PORT_MIB_RX_CTRL_DROP, "RxCtrlDrop"),
> +	MIB_DESC(1, AN8855_PORT_MIB_RX_INGRESS_DROP, "RxIngressDrop"),
> +	MIB_DESC(1, AN8855_PORT_MIB_RX_ARL_DROP, "RxArlDrop"),
> +	MIB_DESC(1, AN8855_PORT_MIB_FLOW_CONTROL_DROP, "FlowControlDrop"),
> +	MIB_DESC(1, AN8855_PORT_MIB_WRED_DROP, "WredDrop"),
> +	MIB_DESC(1, AN8855_PORT_MIB_MIRROR_DROP, "MirrorDrop"),
> +	MIB_DESC(2, AN8855_PORT_MIB_RX_BAD_PKT_BYTES, "RxBadPktBytes"),
> +	MIB_DESC(1, AN8855_PORT_MIB_RXS_FLOW_SAMPLING_PKT_DROP, "RxsFlowSamplingPktDrop"),
> +	MIB_DESC(1, AN8855_PORT_MIB_RXS_FLOW_TOTAL_PKT_DROP, "RxsFlowTotalPktDrop"),
> +	MIB_DESC(1, AN8855_PORT_MIB_PORT_CONTROL_DROP, "PortControlDrop"),
> +};
> +
> +static int
> +an8855_mib_init(struct an8855_priv *priv)
> +{
> +	int ret;
> +
> +	ret = regmap_write(priv->regmap, AN8855_MIB_CCR,
> +			   AN8855_CCR_MIB_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(priv->regmap, AN8855_MIB_CCR,
> +			    AN8855_CCR_MIB_ACTIVATE);
> +}
> +
> +static void an8855_get_strings(struct dsa_switch *ds, int port,
> +			       u32 stringset, uint8_t *data)
> +{
> +	int i;
> +
> +	if (stringset != ETH_SS_STATS)
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(an8855_mib); i++)
> +		ethtool_puts(&data, an8855_mib[i].name);

Same feedback as for yt921x. For new drivers we want in unstructured
ethtool -S only those statistics which are not exposed through standard
variants (to force the adoption of the new interfaces).

> +}
> +
> +static void an8855_read_port_stats(struct an8855_priv *priv, int port,
> +				   u32 offset, u8 size, uint64_t *data)
> +{
> +	u32 val, reg = AN8855_PORT_MIB_COUNTER(port) + offset;
> +
> +	regmap_read(priv->regmap, reg, &val);
> +	*data = val;
> +
> +	if (size == 2) {
> +		regmap_read(priv->regmap, reg + 4, &val);
> +		*data |= (u64)val << 32;
> +	}
> +}
> +
> +static void an8855_get_ethtool_stats(struct dsa_switch *ds, int port,
> +				     uint64_t *data)
> +{
> +	struct an8855_priv *priv = ds->priv;
> +	const struct an8855_mib_desc *mib;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(an8855_mib); i++) {
> +		mib = &an8855_mib[i];
> +
> +		an8855_read_port_stats(priv, port, mib->offset, mib->size,
> +				       data + i);
> +	}
> +}
> +
> +static int an8855_get_sset_count(struct dsa_switch *ds, int port,
> +				 int sset)
> +{
> +	if (sset != ETH_SS_STATS)
> +		return 0;
> +
> +	return ARRAY_SIZE(an8855_mib);
> +}
> +
> +static void an8855_get_eth_mac_stats(struct dsa_switch *ds, int port,
> +				     struct ethtool_eth_mac_stats *mac_stats)
> +{
> +	struct an8855_priv *priv = ds->priv;
> +
> +	/* MIB counter doesn't provide a FramesTransmittedOK but instead
> +	 * provide stats for Unicast, Broadcast and Multicast frames separately.
> +	 * To simulate a global frame counter, read Unicast and addition Multicast
> +	 * and Broadcast later
> +	 */
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_UNICAST, 1,
> +			       &mac_stats->FramesTransmittedOK);
> +
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_SINGLE_COLLISION, 1,
> +			       &mac_stats->SingleCollisionFrames);
> +
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_MULTIPLE_COLLISION, 1,
> +			       &mac_stats->MultipleCollisionFrames);
> +
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_UNICAST, 1,
> +			       &mac_stats->FramesReceivedOK);
> +
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_BYTES, 2,
> +			       &mac_stats->OctetsTransmittedOK);
> +
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_ALIGN_ERR, 1,
> +			       &mac_stats->AlignmentErrors);
> +
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_DEFERRED, 1,
> +			       &mac_stats->FramesWithDeferredXmissions);
> +
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_LATE_COLLISION, 1,
> +			       &mac_stats->LateCollisions);
> +
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_EXCESSIVE_COLLISION, 1,
> +			       &mac_stats->FramesAbortedDueToXSColls);
> +
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_BYTES, 2,
> +			       &mac_stats->OctetsReceivedOK);
> +
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_MULTICAST, 1,
> +			       &mac_stats->MulticastFramesXmittedOK);
> +	mac_stats->FramesTransmittedOK += mac_stats->MulticastFramesXmittedOK;
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_BROADCAST, 1,
> +			       &mac_stats->BroadcastFramesXmittedOK);
> +	mac_stats->FramesTransmittedOK += mac_stats->BroadcastFramesXmittedOK;
> +
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_MULTICAST, 1,
> +			       &mac_stats->MulticastFramesReceivedOK);
> +	mac_stats->FramesReceivedOK += mac_stats->MulticastFramesReceivedOK;
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_BROADCAST, 1,
> +			       &mac_stats->BroadcastFramesReceivedOK);
> +	mac_stats->FramesReceivedOK += mac_stats->BroadcastFramesReceivedOK;
> +}
> +
> +static const struct ethtool_rmon_hist_range an8855_rmon_ranges[] = {
> +	{ 0, 64 },
> +	{ 65, 127 },
> +	{ 128, 255 },
> +	{ 256, 511 },
> +	{ 512, 1023 },
> +	{ 1024, 1518 },
> +	{ 1519, AN8855_MAX_MTU },
> +	{}
> +};
> +
> +static void an8855_get_rmon_stats(struct dsa_switch *ds, int port,
> +				  struct ethtool_rmon_stats *rmon_stats,
> +				  const struct ethtool_rmon_hist_range **ranges)
> +{
> +	struct an8855_priv *priv = ds->priv;
> +
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_UNDER_SIZE_ERR, 1,
> +			       &rmon_stats->undersize_pkts);
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_OVER_SZ_ERR, 1,
> +			       &rmon_stats->oversize_pkts);
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_FRAG_ERR, 1,
> +			       &rmon_stats->fragments);
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_JABBER_ERR, 1,
> +			       &rmon_stats->jabbers);
> +
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_PKT_SZ_64, 1,
> +			       &rmon_stats->hist[0]);
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_PKT_SZ_65_TO_127, 1,
> +			       &rmon_stats->hist[1]);
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_PKT_SZ_128_TO_255, 1,
> +			       &rmon_stats->hist[2]);
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_PKT_SZ_256_TO_511, 1,
> +			       &rmon_stats->hist[3]);
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_PKT_SZ_512_TO_1023, 1,
> +			       &rmon_stats->hist[4]);
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_PKT_SZ_1024_TO_1518, 1,
> +			       &rmon_stats->hist[5]);
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_PKT_SZ_1519_TO_MAX, 1,
> +			       &rmon_stats->hist[6]);
> +
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_PKT_SZ_64, 1,
> +			       &rmon_stats->hist_tx[0]);
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_PKT_SZ_65_TO_127, 1,
> +			       &rmon_stats->hist_tx[1]);
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_PKT_SZ_128_TO_255, 1,
> +			       &rmon_stats->hist_tx[2]);
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_PKT_SZ_256_TO_511, 1,
> +			       &rmon_stats->hist_tx[3]);
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_PKT_SZ_512_TO_1023, 1,
> +			       &rmon_stats->hist_tx[4]);
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_PKT_SZ_1024_TO_1518, 1,
> +			       &rmon_stats->hist_tx[5]);
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_PKT_SZ_1519_TO_MAX, 1,
> +			       &rmon_stats->hist_tx[6]);
> +
> +	*ranges = an8855_rmon_ranges;
> +}
> +
> +static void an8855_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
> +				      struct ethtool_eth_ctrl_stats *ctrl_stats)
> +{
> +	struct an8855_priv *priv = ds->priv;
> +
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_PAUSE, 1,
> +			       &ctrl_stats->MACControlFramesTransmitted);
> +
> +	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_PAUSE, 1,
> +			       &ctrl_stats->MACControlFramesReceived);
> +}

