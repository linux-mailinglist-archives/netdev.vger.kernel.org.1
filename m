Return-Path: <netdev+bounces-261679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MsDAcwAoWlVpQQAu9opvQ
	(envelope-from <netdev+bounces-261679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:26:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B66061B2022
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE8AB3029A6D
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68AD2EAB83;
	Fri, 27 Feb 2026 02:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATvHhXBl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8352D1D8E01;
	Fri, 27 Feb 2026 02:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772159175; cv=none; b=MDINLv/Gfv1QgoxvqAzIBfOrmHz1Lz8BwNPbN7/uI4FztjX3GS0lvuESijoPlwgkdHqUQxr9Wg00QIIPHZvWG7MrIshk6McMrTwRouZALQcrGksLmL3zE5Dko0l+lWXlYTQN6dzSnYIhxF0LYh7VqyeEBCtK2045zR3gwLLbDZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772159175; c=relaxed/simple;
	bh=0IYP4GX5VXqbYmfFB40wFF4sTxRzfD79ZHXy7meu0qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1uD5Oc7bFngfMMaJpi/59iA9sobTUoqwUXVBOnkLsYaQt3M1ftw0DK+++Io6ksx/TVasyH4sLC3Z5XmrSiOtxUAn8hNhc0VVw8ZM1L39XEQXKJqthgcE7Hqrxf+0fJm8CBl7t9xl4atZv345wSZcCBEl3B2iNhMO3SGbr2zgUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATvHhXBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB786C116C6;
	Fri, 27 Feb 2026 02:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772159175;
	bh=0IYP4GX5VXqbYmfFB40wFF4sTxRzfD79ZHXy7meu0qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ATvHhXBlxaCETEaAEyBXPrVRj0CZqqHgZ8raKZXFm2l8LY6P5bf45foFu3YVokYuF
	 xto+pEP/aG+/FpDB6LRUUBg1/QUubZ+MzlGl5+l5oPJ7hZXlLGJvZHLTYC7QpaR0bU
	 6GSdQb2QJp64+mOYwA8bgHj1sMJSG3LRH8H7QaNY2hXjcyFPimeLK/jw1hErbKlpCS
	 nUXuhZ1L/aUjixTI5Nj4nuCjkIEn/AlENmDeq9hm93FYySedaeWaG4ywgqRERxO8en
	 5l0q9JNg9+7/CLVrq1alUCecCshjdLM7x1Bw9swADB7IvrDBFncNSxPCQQn4PDudEO
	 FWM5rS+n8CRhQ==
From: Jakub Kicinski <kuba@kernel.org>
To: ioana.ciornei@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [net-next,2/5] net: dpaa2-mac: retrieve MAC statistics in one firmware command
Date: Thu, 26 Feb 2026 18:26:13 -0800
Message-ID: <20260227022613.2519224-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225150648.1542206-3-ioana.ciornei@nxp.com>
References: <20260225150648.1542206-3-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261679-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: B66061B2022
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dpaa2-mac: retrieve MAC statistics in one firmware command

The latest MC firmware version added a new command to retrieve all DPMAC
counters in a single firmware call. Use this new command, when possible,
in dpaa2-mac as well. In order to use the dpmac_get_statistics() API,
two DMA memory areas are used: one to transmit what counters the driver
is requesting and one to receive the values of those counters. These
memory areas are allocated and DMA mapped at probe time so that we don't
waste time at runtime.

> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
> index 422ce13a7c94..63dc597dbd7c 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c

[ ... ]

> @@ -15,7 +15,121 @@
>  #define DPMAC_PROTOCOL_CHANGE_VER_MAJOR		4
>  #define DPMAC_PROTOCOL_CHANGE_VER_MINOR		8
>
> +#define DPMAC_STATS_BUNDLE_VER_MAJOR		4
> +#define DPMAC_STATS_BUNDLE_VER_MINOR		10
> +
>  #define DPAA2_MAC_FEATURE_PROTOCOL_CHANGE	BIT(0)
> +#define DPAA2_MAC_FEATURE_STATS_BUNDLE		BIT(1)
> +
> +struct dpmac_counter {
> +	enum dpmac_counter_id id;
> +	const char *name;
> +};
> +
> +#define DPMAC_UNSTRUCTURED_COUNTER(counter_id, counter_name)	\
> +	{							\
> +		.id = counter_id,				\
> +		.name = counter_name,				\
> +	}
> +
> +static const struct dpmac_counter dpaa2_mac_ethtool_stats[] = {
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_ALL_FRAME,  "[mac] rx all frames"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_GOOD_FRAME,  "[mac] rx frames ok"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_ERR_FRAME, "[mac] rx frame errors"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_DISCARD, "[mac] rx frame discards"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_UCAST_FRAME, "[mac] rx u-cast"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_BCAST_FRAME, "[mac] rx b-cast"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_MCAST_FRAME, "[mac] rx m-cast"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_64, "[mac] rx 64 bytes"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_127, "[mac] rx 65-127 bytes"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_255, "[mac] rx 128-255 bytes"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_511, "[mac] rx 256-511 bytes"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_1023, "[mac] rx 512-1023 bytes"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_1518, "[mac] rx 1024-1518 bytes"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_1519_MAX, "[mac] rx 1519-max bytes"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAG, "[mac] rx frags"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_JABBER, "[mac] rx jabber"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_ALIGN_ERR, "[mac] rx align errors"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_OVERSIZED, "[mac] rx oversized"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_VALID_PAUSE_FRAME, "[mac] rx pause"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_BYTE, "[mac] rx bytes"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_GOOD_FRAME, "[mac] tx frames ok"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_UCAST_FRAME, "[mac] tx u-cast"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_MCAST_FRAME, "[mac] tx m-cast"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_BCAST_FRAME, "[mac] tx b-cast"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_ERR_FRAME, "[mac] tx frame errors"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_UNDERSIZED, "[mac] tx undersized"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_VALID_PAUSE_FRAME, "[mac] tx b-pause"),
> +	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_BYTE, "[mac] tx bytes"),
> +};
> +
> +#define DPAA2_MAC_NUM_ETHTOOL_STATS	ARRAY_SIZE(dpaa2_mac_ethtool_stats)

[ ... ]

>  void dpaa2_mac_close(struct dpaa2_mac *mac)
>  {
>  	struct fsl_mc_device *dpmac_dev = mac->mc_dev;
>
> +	if (mac->features & DPAA2_MAC_FEATURE_STATS_BUNDLE)
> +		dpaa2_mac_clear_stats(mac, &mac->ethtool_stats, DPAA2_MAC_NUM_ETHTOOL_STATS);
> +
>  	dpmac_close(mac->mc_io, 0, dpmac_dev->mc_handle);
>  	if (mac->fw_node)
>  		fwnode_handle_put(mac->fw_node);
>  }
>
> -static char dpaa2_mac_ethtool_stats[][ETH_GSTRING_LEN] = {
> -	[DPMAC_CNT_ING_ALL_FRAME]		= "[mac] rx all frames",
> -	[DPMAC_CNT_ING_GOOD_FRAME]		= "[mac] rx frames ok",
> -	[DPMAC_CNT_ING_ERR_FRAME]		= "[mac] rx frame errors",
> -	[DPMAC_CNT_ING_FRAME_DISCARD]		= "[mac] rx frame discards",
> -	[DPMAC_CNT_ING_UCAST_FRAME]		= "[mac] rx u-cast",
> -	[DPMAC_CNT_ING_BCAST_FRAME]		= "[mac] rx b-cast",
> -	[DPMAC_CNT_ING_MCAST_FRAME]		= "[mac] rx m-cast",
> -	[DPMAC_CNT_ING_FRAME_64]		= "[mac] rx 64 bytes",
> -	[DPMAC_CNT_ING_FRAME_127]		= "[mac] rx 65-127 bytes",
> -	[DPMAC_CNT_ING_FRAME_255]		= "[mac] rx 128-255 bytes",
> -	[DPMAC_CNT_ING_FRAME_511]		= "[mac] rx 256-511 bytes",
> -	[DPMAC_CNT_ING_FRAME_1023]		= "[mac] rx 512-1023 bytes",
> -	[DPMAC_CNT_ING_FRAME_1518]		= "[mac] rx 1024-1518 bytes",
> -	[DPMAC_CNT_ING_FRAME_1519_MAX]		= "[mac] rx 1519-max bytes",
> -	[DPMAC_CNT_ING_FRAG]			= "[mac] rx frags",
> -	[DPMAC_CNT_ING_JABBER]			= "[mac] rx jabber",
> -	[DPMAC_CNT_ING_ALIGN_ERR]		= "[mac] rx align errors",
> -	[DPMAC_CNT_ING_OVERSIZED]		= "[mac] rx oversized",
> -	[DPMAC_CNT_ING_VALID_PAUSE_FRAME]	= "[mac] rx pause",
> -	[DPMAC_CNT_ING_BYTE]			= "[mac] rx bytes",
> -	[DPMAC_CNT_EGR_GOOD_FRAME]		= "[mac] tx frames ok",
> -	[DPMAC_CNT_EGR_UCAST_FRAME]		= "[mac] tx u-cast",
> -	[DPMAC_CNT_EGR_MCAST_FRAME]		= "[mac] tx m-cast",
> -	[DPMAC_CNT_EGR_BCAST_FRAME]		= "[mac] tx b-cast",
> -	[DPMAC_CNT_EGR_ERR_FRAME]		= "[mac] tx frame errors",
> -	[DPMAC_CNT_EGR_UNDERSIZED]		= "[mac] tx undersized",
> -	[DPMAC_CNT_EGR_VALID_PAUSE_FRAME]	= "[mac] tx b-pause",
> -	[DPMAC_CNT_EGR_BYTE]			= "[mac] tx bytes",
> -};
> -
> -#define DPAA2_MAC_NUM_STATS	ARRAY_SIZE(dpaa2_mac_ethtool_stats)
> -
>  int dpaa2_mac_get_sset_count(void)
>  {
> -	return DPAA2_MAC_NUM_STATS;
> +	return DPAA2_MAC_NUM_ETHTOOL_STATS;
>  }
>
>  void dpaa2_mac_get_strings(u8 **data)
>  {
>  	int i;
>
> -	for (i = 0; i < DPAA2_MAC_NUM_STATS; i++)
> -		ethtool_puts(data, dpaa2_mac_ethtool_stats[i]);
> +	for (i = 0; i < DPAA2_MAC_NUM_ETHTOOL_STATS; i++)
> +		ethtool_puts(data, dpaa2_mac_ethtool_stats[i].name);
>  }
>
>  void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data)
>  {
> +	struct device *dev = mac->net_dev->dev.parent;
>  	struct fsl_mc_device *dpmac_dev = mac->mc_dev;
> +	u64 *cnt_values;
>  	int i, err;
>  	u64 value;
>
> -	for (i = 0; i < DPAA2_MAC_NUM_STATS; i++) {
> +	if (!(mac->features & DPAA2_MAC_FEATURE_STATS_BUNDLE))
> +		goto fallback;
> +
> +	if (!mac->ethtool_stats.idx_dma_mem || !mac->ethtool_stats.values_dma_mem)
> +		goto fallback;
> +
> +	err = dpmac_get_statistics(mac->mc_io, 0, dpmac_dev->mc_handle,
> +				   mac->ethtool_stats.idx_iova, mac->ethtool_stats.values_iova,
> +				   DPAA2_MAC_NUM_ETHTOOL_STATS);
> +	if (err)
> +		goto fallback;
> +
> +	dma_sync_single_for_cpu(dev, mac->ethtool_stats.values_iova,
> +				DPAA2_MAC_NUM_ETHTOOL_STATS * sizeof(u64),
> +				DMA_FROM_DEVICE);
> +
> +	cnt_values = mac->ethtool_stats.values_dma_mem;
> +	for (i = 0; i < DPAA2_MAC_NUM_ETHTOOL_STATS; i++)
> +		*(data + i) = le64_to_cpu(*cnt_values++);
> +
> +	return;
> +
> +fallback:
> +
> +	/* Fallback and retrieve each counter one by one */
> +	for (i = 0; i < DPAA2_MAC_NUM_ETHTOOL_STATS; i++) {
>  		err = dpmac_get_counter(mac->mc_io, 0, dpmac_dev->mc_handle,
>  					i, &value);
                                        ^

Does the fallback path need to pass dpaa2_mac_ethtool_stats[i].id instead
of i here?

The old code used a sparse array indexed by enum dpmac_counter_id values:

    static char dpaa2_mac_ethtool_stats[][ETH_GSTRING_LEN] = {
        [DPMAC_CNT_ING_ALL_FRAME] = "[mac] rx all frames",
        ...
    };

where the loop index i directly corresponded to the enum value passed to
dpmac_get_counter(). The new code uses a compact array where array index 0
contains DPMAC_CNT_ING_ALL_FRAME (enum value 18), but the fallback code
still passes i (sequential 0, 1, 2...) instead of the stored enum value.

When i=0, the code requests counter 0 (DPMAC_CNT_ING_FRAME_64) but the
name is "[mac] rx all frames" (DPMAC_CNT_ING_ALL_FRAME). This would cause
all statistics to report wrong values for their labels.

>  		if (err) {
>  			netdev_err(mac->net_dev,
>  				   "dpmac_get_counter(%d) failed\n", i);

[ ... ]
-- 
pw-bot: cr

