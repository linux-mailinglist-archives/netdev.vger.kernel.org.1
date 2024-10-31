Return-Path: <netdev+bounces-140753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538219B7D57
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 15:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FAEE1C2140C
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE351A01C6;
	Thu, 31 Oct 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="cgSvOKn8"
X-Original-To: netdev@vger.kernel.org
Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF72419D07E
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386468; cv=pass; b=tOpn4ZPj9CHYd9LTZAuouMk/yHwm1xji55NXWAJyL0yQWFY3KNkiFnGovtNU0OxTc7hdOSck+aX3utxBpmAIU4uvX7DOqzlSsijKrZU3cmpnHWJkwgv/+Fm951LOPbqY7hz3vUyvtAwcelXlt39k0BtNRkiUu97WN6j3QNZXJdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386468; c=relaxed/simple;
	bh=HljB6nzfIzF/FjGp4E34pWP2yvPZ6Qdp7++nyo2w8JI=;
	h=Message-ID:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Date; b=H/Dd2A606K+aKm6ktSG49PBDdPZsuPIcKkwhvbs/iUmeZ0CxxSCYFIsjDaeBNYU8Ga5rTBULxxL2g0uIBFCv8KPQdXVGcAg3GUarE2g7548TQIzIa5YvGAIKOFfOd/YnyqlALxDpNfVAL9Hj6ASO41AQ2S7erontdiYNqxKJ7mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=cgSvOKn8; arc=pass smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
X-Sender-Id: hostingeremail|x-authuser|arinc.unal@arinc9.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0DDFE44354
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 14:54:25 +0000 (UTC)
Received: from fr-int-smtpout1.hostinger.io (100-103-228-150.trex-nlb.outbound.svc.cluster.local [100.103.228.150])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4858D43A0E
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 14:54:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1730386464; a=rsa-sha256;
	cv=none;
	b=XZ4K4VW5hQmxcyXHW7V+e6cjq7zTQ6MFYSfHDxiEsYq9STG+Z/1+tmtqgiqTrsm5/NSOT9
	JF0OXSvxX4ZX8H/RdRBK9jDA4U6SGeTHWmtAqaYuBjohq/rT4IddCD1jhKMPAu7BEMCN8u
	2Dmvy3MDrT+vMnAzQ7PlQ1JnbkC8RdbjeuqrobrNKUjAbBHZOT5FHRrpD94OcBE58i+1S6
	warY1Q/IHkPY7XGWAZAtuN5FnsnTpmgRTWYcS9QsfDVwvoqhN4IqpjxqZzdsTvHyC+BxAB
	i7dIyVpy9fbkxl3Uv7TrNnF269vuHiN9IAkwXv3eXfdKUMs9h4XqTsbFjZRAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1730386464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cO+z33cWuDyc7Z/mkMvchv3UD3kchPb5M+ORYHQBzvg=;
	b=AJl2CWpaZhHFc4vEf0SUEsUxKkPl+fFY4yOlhWGStlFOQrEAoaG0o9a5cV3rcWr3SKO+CG
	jY8eCFcJJiW0HdnuY5g4qzBsjHfDdG+zC9h8WVmnSccn8FOpB8BKoRpXe9L49w+BA7ekFA
	tUqj1aNn1gRI1Aw3kDQk0MMkER28S93W8bHQYS/Lqr8swgZpyg0wSFOBjMGzyiOZxewchF
	hvibxq4NDHDxeiNDNNvunqovRX5yLl/w5b1pzKOHT/hymsRR3sI5ipzeez9M+Zijnv0RRc
	Zlo3kLXeoBaRXmPcnqKQvx1rHn4bKvlO7iusjQmFic6X+DL2e+6YVML2cs08jQ==
ARC-Authentication-Results: i=1;
	rspamd-65cf4487d9-jml7x;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=arinc.unal@arinc9.com
X-Sender-Id: hostingeremail|x-authuser|arinc.unal@arinc9.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|arinc.unal@arinc9.com
X-MailChannels-Auth-Id: hostingeremail
X-Suffer-Harbor: 144bcc996e09b33e_1730386464952_1386676134
X-MC-Loop-Signature: 1730386464952:4048889549
X-MC-Ingress-Time: 1730386464952
Received: from fr-int-smtpout1.hostinger.io (fr-int-smtpout1.hostinger.io
 [89.116.146.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.228.150 (trex/7.0.2);
	Thu, 31 Oct 2024 14:54:24 +0000
Message-ID: <1c91ef22-3aec-425d-a0cc-bc553e2d506e@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com;
	s=hostingermail-a; t=1730386462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cO+z33cWuDyc7Z/mkMvchv3UD3kchPb5M+ORYHQBzvg=;
	b=cgSvOKn8DA5jZ387GpsuQNvBEaVgXBS9uynmq8dKc+y9Eo1NS4ii4uKoUHfInQT0OEexQU
	eIodhn3vqrWJTuvWFYsWoHvw+0Z0XZEeG0CJ+ILE7TQDz2lC4Mq17udzqzATmh8gpej4nm
	+wLWryyo1lf8ztTXPhM2ecUIYKh1e+S557PZ82BWq3QNXtgsc0Yby55xvrDvSP2AaJPOuC
	S0p9MWnH5BtQn7xiPo20hES2qYMF2SQbAXvZ62iIIk0m/VykjRgWISMaHWLIWcZb5aWSfa
	WeCk7jZcqKN0A5SZbDj8YZW1gyemh7njumLfZJjzkNOrdI48WorntJylH8EqrA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: dsa: mt7530: Add TBF qdisc offload
 support
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241031-mt7530-tc-offload-v2-1-cb242ad954a0@kernel.org>
Content-Language: en-GB
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20241031-mt7530-tc-offload-v2-1-cb242ad954a0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Date: Thu, 31 Oct 2024 14:54:19 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=Z6G+H2RA c=1 sm=1 tr=0 ts=67239a1e a=aGj/nXfi4qz2iMxz7h0kJQ==:117 a=aGj/nXfi4qz2iMxz7h0kJQ==:17 a=IkcTkHD0fZMA:10 a=M51BFTxLslgA:10 a=GvHEsTVZAAAA:8 a=VwQbUJbxAAAA:8 a=hCiPA77iXPllxYcOKgQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=aajZ2D0djhd3YR65f-bR:22
X-CM-Envelope: MS4xfF/Vnhe/QPETqgQvGh8k4C2x76Y3I8c/kiq9SG/kQaVjayLEQUBVkDgXnSPoFIsAPb+4hJP6EomAqZ3zuWP8ljq491WrRl2k+eQgP5PheaXluTEG0ppl XlShcH/nxOB/JXtWVvDw7igE/08cc+4RBznkJNsL9Liqi4X8vhHWEWAtdKGPRgvL7C8T/oPmXcOuoRM+Xfek46dioCeP/iYcsVw4Z7UsgipjY9KCS3A40f1f 8/liUksjz18WX58AGbsljA9Aflb8SnkRP5Yju6hVjHFh2xdTtCvfWHRPmANX9k5zQ+YMLuCF3QgXGgooWQor4uTSV2+LQykHPNGADb8/WpOTUgJzzcdkeqgD Omz/qtcdjEmtkSX4yRVCHNYfYM3/PWtS1haCl+nwtNsTSqJHQWsINKNqP9XrskZP+9LuFlL9FiVeV5fcLWGr+4XMiOvhe+yTmDz0/Mk52BuR+ByebSXudzP6 Z8ra6V5ApRR0VqXQzi/3jUjovyRkGelqcEbNarL1c+77I3n3LNC+9BImkDN4+MT6h/jjx6knOiFfPEDoxcajqGsrz/WCUQDMXaBR3BqBSi424hbyx6Bg/kGH bjWFM5Nv/q0uFrZyJjttCcgxmxyhf+ZVDCLY8KiL491NO+ec/JOITgQirogiM1ToZjuywnqKfqVQAjnSWT/UR2vh2l4wy9BUp82XHBejBy087PEGO4XzFlm9 ogHrZBwEdq4=
X-AuthUser: arinc.unal@arinc9.com

This is a very nice addition, thanks for working on this!

Arınç

On 31/10/2024 17:28, Lorenzo Bianconi wrote:
> Introduce port_setup_tc callback in mt7530 dsa driver in order to enable
> dsa ports rate shaping via hw Token Bucket Filter (TBF) for hw switched
> traffic.
> 
> Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - remove device id limitation and allow tbf qdisc configuration on each mt7530
>    compliant devices
> - rename MT7530_ERLCR_P in MT753X_ERLCR_P and MT7530_GERLCR in
>    MT753X_GERLCR
> - Link to v1: https://lore.kernel.org/r/20241030-mt7530-tc-offload-v1-1-f7eeffaf3d9e@kernel.org
> ---
>   drivers/net/dsa/mt7530.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/net/dsa/mt7530.h | 12 ++++++++++++
>   2 files changed, 61 insertions(+)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index d84ee1b419a614dda5f440e6571cff5f4f27bf21..086b8b3d5b40f776815967492914bd46a04b6886 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -21,6 +21,7 @@
>   #include <linux/gpio/consumer.h>
>   #include <linux/gpio/driver.h>
>   #include <net/dsa.h>
> +#include <net/pkt_cls.h>
>   
>   #include "mt7530.h"
>   
> @@ -3146,6 +3147,53 @@ mt753x_conduit_state_change(struct dsa_switch *ds,
>   	mt7530_rmw(priv, MT753X_MFC, MT7530_CPU_EN | MT7530_CPU_PORT_MASK, val);
>   }
>   
> +static int mt753x_tc_setup_qdisc_tbf(struct dsa_switch *ds, int port,
> +				     struct tc_tbf_qopt_offload *qopt)
> +{
> +	struct tc_tbf_qopt_offload_replace_params *p = &qopt->replace_params;
> +	struct mt7530_priv *priv = ds->priv;
> +	u32 rate = 0;
> +
> +	switch (qopt->command) {
> +	case TC_TBF_REPLACE:
> +		rate = div_u64(p->rate.rate_bytes_ps, 1000) << 3; /* kbps */
> +		fallthrough;
> +	case TC_TBF_DESTROY: {
> +		u32 val, tick;
> +
> +		mt7530_rmw(priv, MT753X_GERLCR, EGR_BC_MASK,
> +			   EGR_BC_CRC_IPG_PREAMBLE);
> +
> +		/* if rate is greater than 10Mbps tick is 1/32 ms,
> +		 * 1ms otherwise
> +		 */
> +		tick = rate > 10000 ? 2 : 7;
> +		val = FIELD_PREP(ERLCR_CIR_MASK, (rate >> 5)) |
> +		      FIELD_PREP(ERLCR_EN_MASK, !!rate) |
> +		      FIELD_PREP(ERLCR_EXP_MASK, tick) |
> +		      ERLCR_TBF_MODE_MASK |
> +		      FIELD_PREP(ERLCR_MANT_MASK, 0xf);
> +		mt7530_write(priv, MT753X_ERLCR_P(port), val);
> +		break;
> +	}
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mt753x_setup_tc(struct dsa_switch *ds, int port,
> +			   enum tc_setup_type type, void *type_data)
> +{
> +	switch (type) {
> +	case TC_SETUP_QDISC_TBF:
> +		return mt753x_tc_setup_qdisc_tbf(ds, port, type_data);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>   static int mt7988_setup(struct dsa_switch *ds)
>   {
>   	struct mt7530_priv *priv = ds->priv;
> @@ -3193,6 +3241,7 @@ const struct dsa_switch_ops mt7530_switch_ops = {
>   	.get_mac_eee		= mt753x_get_mac_eee,
>   	.set_mac_eee		= mt753x_set_mac_eee,
>   	.conduit_state_change	= mt753x_conduit_state_change,
> +	.port_setup_tc		= mt753x_setup_tc,
>   };
>   EXPORT_SYMBOL_GPL(mt7530_switch_ops);
>   
> diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
> index 6ad33a9f6b1dff3a423baa668a8a2ca158f72b91..448200689f492dcb73ef056d7284090c1c662e67 100644
> --- a/drivers/net/dsa/mt7530.h
> +++ b/drivers/net/dsa/mt7530.h
> @@ -248,6 +248,18 @@ enum mt7530_vlan_egress_attr {
>   #define  AGE_UNIT_MAX			0xfff
>   #define  AGE_UNIT(x)			(AGE_UNIT_MASK & (x))
>   
> +#define MT753X_ERLCR_P(x)		(0x1040 + ((x) * 0x100))
> +#define  ERLCR_CIR_MASK			GENMASK(31, 16)
> +#define  ERLCR_EN_MASK			BIT(15)
> +#define  ERLCR_EXP_MASK			GENMASK(11, 8)
> +#define  ERLCR_TBF_MODE_MASK		BIT(7)
> +#define  ERLCR_MANT_MASK		GENMASK(6, 0)
> +
> +#define MT753X_GERLCR			0x10e0
> +#define  EGR_BC_MASK			GENMASK(7, 0)
> +#define  EGR_BC_CRC			0x4	/* crc */
> +#define  EGR_BC_CRC_IPG_PREAMBLE	0x18	/* crc + ipg + preamble */
> +
>   /* Register for port STP state control */
>   #define MT7530_SSP_P(x)			(0x2000 + ((x) * 0x100))
>   #define  FID_PST(fid, state)		(((state) & 0x3) << ((fid) * 2))
> 
> ---
> base-commit: 157a4881225bd0af5444aab9510e7b6da28f2469
> change-id: 20241030-mt7530-tc-offload-05e204441500
> 
> Best regards,


