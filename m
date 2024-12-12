Return-Path: <netdev+bounces-151339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9AA9EE3E2
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 11:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1A9287C1B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 10:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F432101AC;
	Thu, 12 Dec 2024 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRaN0tjv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860AF210193
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733998487; cv=none; b=fn5iuDY/yxlYaWRUaYPbOxvoeH2I4lPjmmOZEOCH/tL0KtgaTH/R/bdZ9fWMXC3LvGyLaqC9p30PDhCjY1s5HVbLdWpclP6QGBrr7cpZxKzLFrNX/6CXMEsR99xLAR+lEQhzratCMbDfPfQx0ht9mxvNHR07RkRmCvoNNyFwtQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733998487; c=relaxed/simple;
	bh=dPJlrC0+Jhk9NiwSQ8LbuqnxqAKOsUMEP0RwwnRfpPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dt4Eq11gisZg6kPHKQ4dmCwMI6+SS/AZa1zWSaFoJ5K6gKnCkpW6zcg5v6LBUw/CXcPquS4cx1wzRr4b+FryZDc6nQQW1c5Gprupvo4i2jWNAsD7202E8ay8QD4I1tMhd+G5+gdgnprDwe4HROiOwdzroQ6y9VrbukLFc77Qw+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRaN0tjv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733998484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpHSyOxtQohKmJgFBeyw/J2jZHV20wshmDowPduh11Y=;
	b=eRaN0tjvXlEm5XuKmOPJrUVzoxfyCZr8Ds4vjCaPoiAtFprPgHsihmxdTo/HaGFSnKo68r
	BEE51XR2tSHR2LYsg+Ocejnf1c2xbi5sdk1KjmryZcd+fLWbiZXyZpjPQqNc0dGG6f+a3c
	FsVmyvyo9GUNU2b28JK7JE0pFl9Bg/I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-wFoJ4I7WMgmHQIGPmA0jHQ-1; Thu, 12 Dec 2024 05:14:43 -0500
X-MC-Unique: wFoJ4I7WMgmHQIGPmA0jHQ-1
X-Mimecast-MFC-AGG-ID: wFoJ4I7WMgmHQIGPmA0jHQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434fb9646efso3879605e9.1
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 02:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998482; x=1734603282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DpHSyOxtQohKmJgFBeyw/J2jZHV20wshmDowPduh11Y=;
        b=NNR+qK3wn+4+RykKnPTzYOxfewDt9k7QjDJ8Vap3cUd/WUNsmZLtrNFIwASwEnu9Ja
         8PAQfffDwoGwBwtHp/1KO+44dZoHfnlVxtiEvVcxKUvR0XV/6SAdWzNCMVhsjTCKvLYT
         OCIjLLk8MCXU2GfIGu4sxP3/fO8yA+lkLiqO8RNaVOJkIwEubqEmCLhN5I+r5B2mLSbL
         NSDLKUh9Df6mhczNsPd361HOo6sB3WRaRsoSuglWRv4IdkXKfiT/KSbKzmMPjQw3RPJo
         cgFSP9OJY+Dr0NKjLk6G/+nY15N1BZWmAeDvVROc3jk9gM3+KCyQGQ6X8BuuRZBhWCrt
         TR9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9CIpA8vs6oYwNyeJQWYIvp8GkY8QQanw9UcPdBK3+27AeERJ1b1XU7GylsA6ZwGpo6vfmwEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxJDQ3Whs+DsXzaYG0VQeEq3XriCdAak0/9DmCZ2G1yGkxh8Rr
	LoXx+2pHI1QbOvjzJgdxlgda79weyMwu3B35SLyss/E07ZJDpi4SLm+HTMJ9p6VBnyzAkXXYFha
	9PcFf1ZThgkXbE36g/vo0BXrhlchj4lJGWBOV/DR8aTslU+vpnCE+tg==
X-Gm-Gg: ASbGncu7e5LZwTqUUEgfMiinTxzvHvI5NrL9jcnVAt610n90GF/tam3pi2owfPY1YfY
	RbKuMgLV/wVSiCNJrAiOtXJFv3mDV0C4D3nEUBV+AD8dQSEKYTHcmbgVnZT7YhyIfpL7K8WTc51
	UWqhUp2kxecf0bojGO9oiNWCNA1d0I30sJL6TWWnYBlTkhTgjK124ylxhKL6joE1MhdKnlrXpc6
	6zZ7DirL2MAWGzOYPislRJ5rObPVkw7TfMp/sQp6Or/gtYy0Qntx8AqckYm5ABYunsIk0e+JYt0
	X67C2gw=
X-Received: by 2002:a05:600c:3b9b:b0:434:f739:7ce2 with SMTP id 5b1f17b1804b1-4361c35d6c4mr46710645e9.8.1733998482051;
        Thu, 12 Dec 2024 02:14:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEsX3O0Hfg1jRugC8f5c/WQkf6oIWVvo0UAEqsvB2EY/Z8iH8jEcRdeah9+o2qIVO0rli0UQ==
X-Received: by 2002:a05:600c:3b9b:b0:434:f739:7ce2 with SMTP id 5b1f17b1804b1-4361c35d6c4mr46710325e9.8.1733998481640;
        Thu, 12 Dec 2024 02:14:41 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b42c8sm11897405e9.29.2024.12.12.02.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 02:14:41 -0800 (PST)
Message-ID: <bcb32d21-b3c8-4d37-842a-1acdcd78a995@redhat.com>
Date: Thu, 12 Dec 2024 11:14:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/5] net: phy: microchip_rds_ptp : Add rds ptp
 library for Microchip phys
To: Divya Koppera <divya.koppera@microchip.com>, andrew@lunn.ch,
 arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, richardcochran@gmail.com,
 vadim.fedorenko@linux.dev
References: <20241209151742.9128-1-divya.koppera@microchip.com>
 <20241209151742.9128-3-divya.koppera@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241209151742.9128-3-divya.koppera@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/24 16:17, Divya Koppera wrote:
> diff --git a/drivers/net/phy/microchip_rds_ptp.c b/drivers/net/phy/microchip_rds_ptp.c
> new file mode 100644
> index 000000000000..d1c91c0f5e03
> --- /dev/null
> +++ b/drivers/net/phy/microchip_rds_ptp.c
> @@ -0,0 +1,1009 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2024 Microchip Technology
> +
> +#include "microchip_rds_ptp.h"
> +
> +static int mchp_rds_ptp_flush_fifo(struct mchp_rds_ptp_clock *clock,
> +				   enum mchp_rds_ptp_fifo_dir dir)

If you pass as 2nd argument the relevant fifo to flush compute 'dir'
from such value and call skb_queue_purge(), you can avoid a bit of
duplicate code.

> +{
> +	struct phy_device *phydev = clock->phydev;
> +	int rc;
> +
> +	for (int i = 0; i < MCHP_RDS_PTP_FIFO_SIZE; ++i) {
> +		rc = phy_read_mmd(phydev, PTP_MMD(clock),
> +				  dir == MCHP_RDS_PTP_EGRESS_FIFO ?
> +				  MCHP_RDS_PTP_TX_MSG_HDR2(BASE_PORT(clock)) :
> +				  MCHP_RDS_PTP_RX_MSG_HDR2(BASE_PORT(clock)));
> +		if (rc < 0)
> +			return rc;
> +	}
> +	return phy_read_mmd(phydev, PTP_MMD(clock),
> +			    MCHP_RDS_PTP_INT_STS(BASE_PORT(clock)));
> +}
> +
> +static int mchp_rds_ptp_config_intr(struct mchp_rds_ptp_clock *clock,
> +				    bool enable)
> +{
> +	struct phy_device *phydev = clock->phydev;
> +
> +	/* Enable  or disable ptp interrupts */
> +	return phy_write_mmd(phydev, PTP_MMD(clock),
> +			     MCHP_RDS_PTP_INT_EN(BASE_PORT(clock)),
> +			     enable ? MCHP_RDS_PTP_INT_ALL_MSK : 0);
> +}
> +
> +static void mchp_rds_ptp_txtstamp(struct mii_timestamper *mii_ts,
> +				  struct sk_buff *skb, int type)
> +{
> +	struct mchp_rds_ptp_clock *clock = container_of(mii_ts,
> +						      struct mchp_rds_ptp_clock,
> +						      mii_ts);
> +
> +	switch (clock->hwts_tx_type) {
> +	case HWTSTAMP_TX_ONESTEP_SYNC:
> +		if (ptp_msg_is_sync(skb, type)) {
> +			kfree_skb(skb);
> +			return;
> +		}
> +		fallthrough;
> +	case HWTSTAMP_TX_ON:
> +		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> +		skb_queue_tail(&clock->tx_queue, skb);
> +		break;
> +	case HWTSTAMP_TX_OFF:
> +	default:
> +		kfree_skb(skb);
> +		break;
> +	}
> +}
> +
> +static bool mchp_rds_ptp_get_sig_rx(struct sk_buff *skb, u16 *sig)
> +{
> +	struct ptp_header *ptp_header;
> +	int type;
> +
> +	skb_push(skb, ETH_HLEN);
> +	type = ptp_classify_raw(skb);
> +	if (type == PTP_CLASS_NONE)
> +		return false;
> +
> +	ptp_header = ptp_parse_header(skb, type);
> +	if (!ptp_header)
> +		return false;
> +
> +	skb_pull_inline(skb, ETH_HLEN);
> +
> +	*sig = (__force u16)(ntohs(ptp_header->sequence_id));
> +
> +	return true;
> +}
> +
> +static bool mchp_rds_ptp_match_skb(struct mchp_rds_ptp_clock *clock,
> +				   struct mchp_rds_ptp_rx_ts *rx_ts)
> +{
> +	struct skb_shared_hwtstamps *shhwtstamps;
> +	struct sk_buff *skb, *skb_tmp;
> +	unsigned long flags;
> +	bool rc = false;
> +	u16 skb_sig;
> +
> +	spin_lock_irqsave(&clock->rx_queue.lock, flags);
> +	skb_queue_walk_safe(&clock->rx_queue, skb, skb_tmp) {
> +		if (!mchp_rds_ptp_get_sig_rx(skb, &skb_sig))
> +			continue;
> +
> +		if (skb_sig != rx_ts->seq_id)
> +			continue;
> +
> +		__skb_unlink(skb, &clock->rx_queue);
> +
> +		rc = true;
> +		break;
> +	}
> +	spin_unlock_irqrestore(&clock->rx_queue.lock, flags);
> +
> +	if (rc) {
> +		shhwtstamps = skb_hwtstamps(skb);
> +		shhwtstamps->hwtstamp = ktime_set(rx_ts->seconds, rx_ts->nsec);
> +		netif_rx(skb);
> +	}
> +
> +	return rc;
> +}
> +
> +static void mchp_rds_ptp_match_rx_ts(struct mchp_rds_ptp_clock *clock,
> +				     struct mchp_rds_ptp_rx_ts *rx_ts)
> +{
> +	unsigned long flags;
> +
> +	/* If we failed to match the skb add it to the queue for when
> +	 * the frame will come
> +	 */
> +	if (!mchp_rds_ptp_match_skb(clock, rx_ts)) {
> +		spin_lock_irqsave(&clock->rx_ts_lock, flags);
> +		list_add(&rx_ts->list, &clock->rx_ts_list);
> +		spin_unlock_irqrestore(&clock->rx_ts_lock, flags);
> +	} else {
> +		kfree(rx_ts);
> +	}
> +}
> +
> +static void mchp_rds_ptp_match_rx_skb(struct mchp_rds_ptp_clock *clock,
> +				      struct sk_buff *skb)
> +{
> +	struct mchp_rds_ptp_rx_ts *rx_ts, *tmp, *rx_ts_var = NULL;
> +	struct skb_shared_hwtstamps *shhwtstamps;
> +	unsigned long flags;
> +	u16 skb_sig;
> +
> +	if (!mchp_rds_ptp_get_sig_rx(skb, &skb_sig))
> +		return;
> +
> +	/* Iterate over all RX timestamps and match it with the received skbs */
> +	spin_lock_irqsave(&clock->rx_ts_lock, flags);
> +	list_for_each_entry_safe(rx_ts, tmp, &clock->rx_ts_list, list) {
> +		/* Check if we found the signature we were looking for. */
> +		if (skb_sig != rx_ts->seq_id)
> +			continue;
> +
> +		shhwtstamps = skb_hwtstamps(skb);
> +		shhwtstamps->hwtstamp = ktime_set(rx_ts->seconds, rx_ts->nsec);
> +		netif_rx(skb);
> +
> +		rx_ts_var = rx_ts;
> +
> +		break;
> +	}
> +	spin_unlock_irqrestore(&clock->rx_ts_lock, flags);
> +
> +	if (rx_ts_var) {
> +		list_del(&rx_ts_var->list);
> +		kfree(rx_ts_var);
> +	} else {
> +		skb_queue_tail(&clock->rx_queue, skb);
> +	}
> +}
> +
> +static bool mchp_rds_ptp_rxtstamp(struct mii_timestamper *mii_ts,
> +				  struct sk_buff *skb, int type)
> +{
> +	struct mchp_rds_ptp_clock *clock = container_of(mii_ts,
> +						      struct mchp_rds_ptp_clock,
> +						      mii_ts);
> +
> +	if (clock->rx_filter == HWTSTAMP_FILTER_NONE ||
> +	    type == PTP_CLASS_NONE)
> +		return false;
> +
> +	if ((type & clock->version) == 0 || (type & clock->layer) == 0)
> +		return false;
> +
> +	/* Here if match occurs skb is sent to application, If not skb is added
> +	 * to queue and sending skb to application will get handled when
> +	 * interrupt occurs i.e., it get handles in interrupt handler. By
> +	 * any means skb will reach the application so we should not return
> +	 * false here if skb doesn't matches.
> +	 */
> +	mchp_rds_ptp_match_rx_skb(clock, skb);
> +
> +	return true;
> +}
> +
> +static int mchp_rds_ptp_hwtstamp(struct mii_timestamper *mii_ts,
> +				 struct kernel_hwtstamp_config *config,
> +				 struct netlink_ext_ack *extack)
> +{
> +	struct mchp_rds_ptp_clock *clock =
> +				container_of(mii_ts, struct mchp_rds_ptp_clock,
> +					     mii_ts);
> +	struct phy_device *phydev = clock->phydev;
> +	struct mchp_rds_ptp_rx_ts *rx_ts, *tmp;
> +	int txcfg = 0, rxcfg = 0;
> +	unsigned long flags;
> +	int rc;
> +
> +	clock->hwts_tx_type = config->tx_type;
> +	clock->rx_filter = config->rx_filter;
> +
> +	switch (config->rx_filter) {
> +	case HWTSTAMP_FILTER_NONE:
> +		clock->layer = 0;
> +		clock->version = 0;
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> +		clock->layer = PTP_CLASS_L4;
> +		clock->version = PTP_CLASS_V2;
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
> +		clock->layer = PTP_CLASS_L2;
> +		clock->version = PTP_CLASS_V2;
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> +		clock->layer = PTP_CLASS_L4 | PTP_CLASS_L2;
> +		clock->version = PTP_CLASS_V2;
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	/* Setup parsing of the frames and enable the timestamping for ptp
> +	 * frames
> +	 */
> +	if (clock->layer & PTP_CLASS_L2) {
> +		rxcfg = MCHP_RDS_PTP_PARSE_CONFIG_LAYER2_EN;
> +		txcfg = MCHP_RDS_PTP_PARSE_CONFIG_LAYER2_EN;
> +	}
> +	if (clock->layer & PTP_CLASS_L4) {
> +		rxcfg |= MCHP_RDS_PTP_PARSE_CONFIG_IPV4_EN |
> +			 MCHP_RDS_PTP_PARSE_CONFIG_IPV6_EN;
> +		txcfg |= MCHP_RDS_PTP_PARSE_CONFIG_IPV4_EN |
> +			 MCHP_RDS_PTP_PARSE_CONFIG_IPV6_EN;
> +	}
> +	rc = phy_write_mmd(phydev, PTP_MMD(clock),
> +			   MCHP_RDS_PTP_RX_PARSE_CONFIG(BASE_PORT(clock)),
> +			   rxcfg);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = phy_write_mmd(phydev, PTP_MMD(clock),
> +			   MCHP_RDS_PTP_TX_PARSE_CONFIG(BASE_PORT(clock)),
> +			   txcfg);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = phy_write_mmd(phydev, PTP_MMD(clock),
> +			   MCHP_RDS_PTP_RX_TIMESTAMP_EN(BASE_PORT(clock)),
> +			   MCHP_RDS_PTP_TIMESTAMP_EN_ALL);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = phy_write_mmd(phydev, PTP_MMD(clock),
> +			   MCHP_RDS_PTP_TX_TIMESTAMP_EN(BASE_PORT(clock)),
> +			   MCHP_RDS_PTP_TIMESTAMP_EN_ALL);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (clock->hwts_tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
> +		/* Enable / disable of the TX timestamp in the SYNC frames */
> +		rc = phy_modify_mmd(phydev, PTP_MMD(clock),
> +				    MCHP_RDS_PTP_TX_MOD(BASE_PORT(clock)),
> +				    MCHP_RDS_PTP_TX_MOD_PTP_SYNC_TS_INSERT,
> +				    MCHP_RDS_PTP_TX_MOD_PTP_SYNC_TS_INSERT);
> +	else
> +		rc = phy_modify_mmd(phydev, PTP_MMD(clock),
> +				    MCHP_RDS_PTP_TX_MOD(BASE_PORT(clock)),
> +				    MCHP_RDS_PTP_TX_MOD_PTP_SYNC_TS_INSERT,
> +				(u16)~MCHP_RDS_PTP_TX_MOD_PTP_SYNC_TS_INSERT);
> +
> +	if (rc < 0)
> +		return rc;
> +
> +	/* Now enable the timestamping interrupts */
> +	rc = mchp_rds_ptp_config_intr(clock,
> +				      config->rx_filter !=
> +				      HWTSTAMP_FILTER_NONE);
> +	if (rc < 0)
> +		return rc;

At this point the H/W can trigger ptp interruts and
mchp_rds_ptp_handle_interrupt() right?

> +
> +	/* In case of multiple starts and stops, these needs to be cleared */
> +	spin_lock_irqsave(&clock->rx_ts_lock, flags);
> +	list_for_each_entry_safe(rx_ts, tmp, &clock->rx_ts_list, list) {
> +		list_del(&rx_ts->list);
> +		kfree(rx_ts);
> +	}
> +	spin_unlock_irqrestore(&clock->rx_ts_lock, flags);
> +	skb_queue_purge(&clock->rx_queue);
> +	skb_queue_purge(&clock->tx_queue);
> +
> +	rc = mchp_rds_ptp_flush_fifo(clock, MCHP_RDS_PTP_INGRESS_FIFO);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = mchp_rds_ptp_flush_fifo(clock, MCHP_RDS_PTP_EGRESS_FIFO);
Should the above moved bedore enabling the irqs?

Thanks!

Paolo


