Return-Path: <netdev+bounces-281496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KlWSM3HT72mOGgEAu9opvQ
	(envelope-from <netdev+bounces-281496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:21:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C0C47A95B
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 337B4301A402
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 21:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2C535F603;
	Mon, 27 Apr 2026 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hX+MPwU+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6F02EC0A2
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777324909; cv=none; b=XwKM/d10vhTOt4MeQZLvfHuwWIUIvebyRrQKfhicwCksbnjnQTefwk+TEVPiLwB2DdNshuM5UCwOtCtsQ9AyRdYHVTm3w3WoaHBL2DpOHJj5BXliyjweZ5L4ftcREkBBwj0zcmuBPSUHXeeFJB/fCeTZ6s3wdwaF4F7NhtZ1KIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777324909; c=relaxed/simple;
	bh=7YSMzEyxS1XNA4OBd14hMPN7WNfoLFoSVpTmZlsj0jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NAUsZyonLxX1lOvPaYeJYhHR0Yj1mfTOJjp8N6thB+vynXZVKZhBicjRCMwYHafxlzj2BZhkanoIfTxUe/2OOD2APIk3KHIRTGyrhAp2v8oltMaQ1ymnFF4X97p+X2Uh1t40U71V0vknFgf5dNkNWhOge7Ie7iXhxQnt5Gny/Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hX+MPwU+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48374014a77so139009295e9.3
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 14:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777324906; x=1777929706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IOWA3FfEMJaIeIa8gNPCWVPUoEq8yr4UhXyR3DmFLRs=;
        b=hX+MPwU+HmelqluGEgcNK4J30c4UrHagU27t7Vj/TAjU/n1vibaosVfmTDgRTjb9B2
         A4GyelrEVQnCf0QOeMlrWZ6eBJDqUdasrqcWzFnbHEPlonc586dUQKf+n8p83eghrVGJ
         +tqDoUcvJogOek2ux8HXZvtL4vj1jvyvgXg+pB9C1kvXuF9++2Pr//xbJLIXA5Pv+0SU
         DvOOOd7sdT4hfwcvK2WXqvwKx6SGfXgCfyLwXR+WMExG8Gt/7Zl5MoB1/+VPSiPBxCn4
         5q3Q9hIR2u2KUjy4D1tRedAP47G09t+bodbcH7okoGBtRzbZPfVoi7OFpsK5rNr847ws
         fsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777324906; x=1777929706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOWA3FfEMJaIeIa8gNPCWVPUoEq8yr4UhXyR3DmFLRs=;
        b=AYBbdJXqOhWLtXR1seVX4+RMlj7O1OwESA/gsMm25PLVZ+d/ie4Xk1QjJLv31+0FB8
         /78ipshFYziI61r5hnz1wWzXEpwuhhn4RjLnUe9qaslmOgsDGD8E/QCrA2fq5P827CQE
         W8OQc0QoULVQNkJJOAdQeugWm4PE2yDbTiY5XGc0htK75+pHx1cRoRt2PDbN7r7GCfQi
         Yx+CGhGvX0qUxuHC68If43xRnHX7HWtXZCC3CtUboW7kHnDs8Pl7x8vihccye8X2ePOs
         d87dUzVI8mEBymJFUHhv+nVtceXlP467TXL6F+tBdZvwQt5gJMa8iVcdqKBReWy/fcJ1
         15zQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kuD2Kg0PUOx7mA6lFUOE2qCPmxGQ4am+TpenOFkzXTFJKU1Dj/QFyogL3+DAFAK/34BETMuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5IX1hfRx4+JQnjEG6L2e7MVgIK+EPMxI2RZ9rn38ZYddbJrSX
	6BEBXj1GhO5KCHAbZUTro/N2U4Ww7tUvhSck6xlxy3G1dD96gwJGaE8N
X-Gm-Gg: AeBDies03llwN05po91jArcwmLrhLYcr4l6rIZjXbCYokLqmSphvGPf34QJEg5PT/nF
	laxav3TjUHiyD93wYNchAKwrqVvTbEq08aF6hTekTBA2x7EkMiJHXVe9ch/DjxkBsDIMsFURK0T
	ulgBinhNpgVWdlyNnxGX+zaLGpszXTw3pTSjc/mK0UM/ZwBRaxQT/Hi9e4xetTljXBs6ITESan7
	4p3Xjl1wZQ9zhenFEBSu4KBgJcSeE9kYd3mpJzBP10zrO1memokTsdzJVIcIFFy1UsLUpgrwQnG
	tiC5FbcHuub2Y+4GSBgeMkNbKL38iYhy/oHdwALmfR7HCwuVCe0rrRcsqCLu7EVdrURsy1yRBRX
	YBXeeMH+GmNSUleLIB3UZC+LgWQNiNw5tSOv8AORq0DNBhyy6MlGywIoP8Uxjadyd+cvtk50/PX
	8T3G7onEXkhBrHQG+ol7qhh5j+F8sFjg6mKOwX2JBAE+u/itKRGdzrIxvGcSaDvWNRN1kXppZ5h
	gme1eNbaUlMFnneb1q4lyrKX0OXv+rEJLrGAPTOQl+3cJcNhbG9sIIVcxOg3cjzSiDj2hrJCw==
X-Received: by 2002:a05:600c:1d20:b0:48a:7676:30bc with SMTP id 5b1f17b1804b1-48a77b0a3d6mr5438235e9.14.1777324905841;
        Mon, 27 Apr 2026 14:21:45 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f37:e300:169:47c9:df3d:396c? (p200300ea8f37e300016947c9df3d396c.dip0.t-ipconnect.de. [2003:ea:8f37:e300:169:47c9:df3d:396c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a76f7f483sm19496465e9.0.2026.04.27.14.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:21:45 -0700 (PDT)
Message-ID: <a7b8a496-baf9-4e0e-b1c0-510e24d0bbaa@gmail.com>
Date: Mon, 27 Apr 2026 23:21:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] r8169: expose software counters through
 netdev qstats
To: Gustavo Arantes <dev.gustavoa@gmail.com>, nic_swsd@realtek.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Javen Xu <javen_xu@realsil.com.cn>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260427205931.5884-1-dev.gustavoa@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260427205931.5884-1-dev.gustavoa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 41C0C47A95B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281496-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 27.04.2026 22:59, Gustavo Arantes wrote:
> r8169 maintains synchronized per-CPU software counters for packet and
> byte accounting and exposes them through ndo_get_stats64(), but
> userspace using the structured netdev qstats API cannot retrieve them from
> this driver.
> 
> Expose the same counters through netdev_stat_ops. r8169 has a single Rx
> and Tx queue, so report the accumulated counters on queue 0. Use zero
> base stats so device-scope qstats are derived from the queue counters
> and match the packet and byte values reported through RTNL.

What do you mean with RTNL here?

> 
> This does not add new accounting and does not touch the data path. It
> only makes the existing counters available through the common qstats
> interface, which lets generic userspace tooling query r8169 the same way
> it queries other drivers with qstats support.
> 
Counters are exposed to userspace already. So what's the benefit of
duplicating this functionality? To me the patch looks like AI slop.

> Signed-off-by: Gustavo Arantes <dev.gustavoa@gmail.com>
> ---
> v2:
>   - Submit again now that net-next has reopened.
>   - Expand commit message to explain the qstats userspace benefit.
> 
> Tested on a Realtek RTL8111/8168/8211/8411 PCIe Gigabit Ethernet
> controller using the r8169 driver.
> 
> v1: https://lore.kernel.org/netdev/20260418021232.5425-1-dev.gustavoa@gmail.com/
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 70 +++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 791277e750ba..9d833b446383 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5175,6 +5175,75 @@ rtl8169_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
>  	pm_runtime_put_noidle(&pdev->dev);
>  }
> 
> +static void rtl8169_fetch_sw_stats(struct net_device *dev,
> +				   struct netdev_queue_stats_rx *rx,
> +				   struct netdev_queue_stats_tx *tx)
> +{
> +	const struct pcpu_sw_netstats *stats;
> +	unsigned int start;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		u64 rx_packets, rx_bytes, tx_packets, tx_bytes;
> +
> +		stats = per_cpu_ptr(dev->tstats, cpu);
> +		do {
> +			start = u64_stats_fetch_begin(&stats->syncp);
> +			rx_packets = u64_stats_read(&stats->rx_packets);
> +			rx_bytes = u64_stats_read(&stats->rx_bytes);
> +			tx_packets = u64_stats_read(&stats->tx_packets);
> +			tx_bytes = u64_stats_read(&stats->tx_bytes);
> +		} while (u64_stats_fetch_retry(&stats->syncp, start));
> +
> +		rx->packets += rx_packets;
> +		rx->bytes += rx_bytes;
> +		tx->packets += tx_packets;
> +		tx->bytes += tx_bytes;
> +	}
> +}

This is generic, driver-independent code. If exposing dev->tstats this
way makes sense, then this should go to net core.

> +
> +static void rtl8169_get_queue_stats_rx(struct net_device *dev, int idx,
> +				       struct netdev_queue_stats_rx *rx)
> +{
> +	struct netdev_queue_stats_tx tx = {};
> +
> +	if (idx)
> +		return;
> +
> +	rx->packets = 0;
> +	rx->bytes = 0;
> +	rtl8169_fetch_sw_stats(dev, rx, &tx);
> +}
> +
> +static void rtl8169_get_queue_stats_tx(struct net_device *dev, int idx,
> +				       struct netdev_queue_stats_tx *tx)
> +{
> +	struct netdev_queue_stats_rx rx = {};
> +
> +	if (idx)
> +		return;
> +
> +	tx->packets = 0;
> +	tx->bytes = 0;
> +	rtl8169_fetch_sw_stats(dev, &rx, tx);
> +}
> +
> +static void rtl8169_get_base_stats(struct net_device *dev,
> +				   struct netdev_queue_stats_rx *rx,
> +				   struct netdev_queue_stats_tx *tx)
> +{
> +	rx->packets = 0;
> +	rx->bytes = 0;
> +	tx->packets = 0;
> +	tx->bytes = 0;
> +}
> +
> +static const struct netdev_stat_ops rtl8169_stat_ops = {
> +	.get_queue_stats_rx	= rtl8169_get_queue_stats_rx,
> +	.get_queue_stats_tx	= rtl8169_get_queue_stats_tx,
> +	.get_base_stats		= rtl8169_get_base_stats,
> +};
> +
>  static void rtl8169_net_suspend(struct rtl8169_private *tp)
>  {
>  	netif_device_detach(tp->dev);
> @@ -5615,6 +5684,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> 
>  	SET_NETDEV_DEV(dev, &pdev->dev);
>  	dev->netdev_ops = &rtl_netdev_ops;
> +	dev->stat_ops = &rtl8169_stat_ops;
>  	tp = netdev_priv(dev);
>  	tp->dev = dev;
>  	tp->pci_dev = pdev;
> --
> 2.54.0
> 


