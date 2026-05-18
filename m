Return-Path: <netdev+bounces-288823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDpHABB+CmoS2AQAu9opvQ
	(envelope-from <netdev+bounces-288823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 04:48:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD805652CC
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 04:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBAAB3008A46
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 02:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B79363089;
	Mon, 18 May 2026 02:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZHWbZvGc"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456D823A566
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 02:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779072525; cv=none; b=ORvojuTHwXqOvgL8VBzKPWGuf2xUEoDCu4EcVQt4u1kbCSa7GoVmtEU9nhqhfMQ2UYMxTBaUw6x1C7R/jN7syuWPJUnQyh+/fEpy+oQxMMVlTMrlqNizWveP1s+lU7xK4TcYLAQPIGij4nsGUKtkGdUSO+InIrSgzKICyhEFbTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779072525; c=relaxed/simple;
	bh=uF9pr5mKyx2rz1uHwB17VsuzpkzR7MClZIcAa9OPzcI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=rHCv3exlW+XjabTTI/o9FBaTNYQy3RMtnKmGwORy8fhWnilnx2+AtcDSDUXNP8/FFTaLnToNf6XeuZFIfvluMI0YQ9aP5lSJWCVEHv6f+Vi9hcolvAMeHvPsw+zOZvJGj8fgZ8vzpGUJaxxFtLxFIUeclsTkVfzigbxbKqgqNYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZHWbZvGc; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779072514; h=Message-ID:Subject:Date:From:To;
	bh=kfLMUafdmWTQ81Im23cXKucv6JenYWT5gr1L40Pj0hQ=;
	b=ZHWbZvGc50YwDL4QtWXg/b21JwyKfoLfWq3OnB7rUIlJpwZB5lHIlRVcDMo30OaIiHiwPkgmKMNn2NjICKK7KmyBH/Aa9QX1lenHGQlsq1LDZj4tIprG7laisebVdoNKikXFa1AWoLC3q8V45QFuH6YJ4y1pj06s9HN+E/6Vjck=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X32zyMA_1779072512;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X32zyMA_1779072512 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 10:48:32 +0800
Message-ID: <1779072425.0877278-7-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v43 6/8] eea: implement packet transmit logic
Date: Mon, 18 May 2026 10:47:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Dong Yibo <dong100@mucse.com>,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Dust Li <dust.li@linux.alibaba.com>,
 netdev@vger.kernel.org
References: <20260514095138.80680-1-xuanzhuo@linux.alibaba.com>
 <20260514095138.80680-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20260514095138.80680-7-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 1CD805652CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,stu.xidian.edu.cn,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288823-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email]
X-Rspamd-Action: no action

From sashiko:


commit cffb539ce8b8ad9935febc105007a1405d95169b
Author: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
eea: implement packet transmit logic
This commit fills in the previously stubbed eea_tx_xmit() and
eea_poll_tx() with the full TX path: building descriptors from skbs,
handling DMA mapping/unmapping, GSO and checksum offload setup, and
completion processing.
> diff --git a/drivers/net/ethernet/alibaba/eea/eea_tx.c b/drivers/net/ethernet/alibaba/eea/eea_tx.c
> index 5a8babfce5de..8b7fc75ead8a 100644
> --- a/drivers/net/ethernet/alibaba/eea/eea_tx.c
> +++ b/drivers/net/ethernet/alibaba/eea/eea_tx.c
[ ... ]
> +static int eea_fill_desc_from_skb(const struct sk_buff *skb,
> +				  struct eea_tx_desc *desc)
> +{
> +	if (skb_is_gso(skb)) {
> +		struct skb_shared_info *sinfo = skb_shinfo(skb);
> +
> +		desc->gso_size = cpu_to_le16(sinfo->gso_size);
> +		if (sinfo->gso_type & SKB_GSO_TCPV4)
> +			desc->gso_type = EEA_TX_GSO_TCPV4;
> +
> +		else if (sinfo->gso_type & SKB_GSO_TCPV6)
> +			desc->gso_type = EEA_TX_GSO_TCPV6;
> +
> +		else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> +			desc->gso_type = EEA_TX_GSO_UDP_L4;
> +
> +		else
> +			return -EINVAL;
> +
> +		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
> +			desc->gso_type |= EEA_TX_GSO_ECN;
> +	} else {
> +		desc->gso_type = EEA_TX_GSO_NONE;
> +	}
> +
> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> +		desc->csum_start = cpu_to_le16(skb_checksum_start_offset(skb));
> +		desc->csum_offset = cpu_to_le16(skb->csum_offset);
> +	}
> +
> +	return 0;
> +}
Can stale fields in a reused descriptor slot be sent to the device?
The SQ ring slots are reused as the ring wraps. Several eea_tx_desc
fields are only conditionally written:
  - csum_start and csum_offset are only set when
    skb->ip_summed == CHECKSUM_PARTIAL
  - gso_size is only set when skb_is_gso(skb)
  - gso_type is set here for the head descriptor, but
    eea_tx_add_skb_frag() and the >USHRT_MAX split path in
    eea_tx_desc_fill() never write gso_type, gso_size, csum_start
    or csum_offset on continuation descriptors
  - reserved1, reserved2 and reserved3 are never written
After the first ring wrap each reused slot will carry whatever values
the previous occupant wrote. Does correctness here rely on the device
gating each optional field on EEA_DESC_F_DO_CSUM and on the
"more descriptors" flag, and ignoring all reserved bits?
If so, would it be worth either zeroing the descriptor at fill time
(for example a memset before populating it) or adding a comment that
documents the hardware contract being relied on?
What is the silent drop signal when an unsupported gso_type appears?
When skb_is_gso(skb) is true but the type is none of TCPV4, TCPV6 or
UDP_L4, this returns -EINVAL, which propagates up through
eea_tx_post_skb() into err_cancel and ultimately to
dev_kfree_skb_any() in eea_tx_xmit(). There is no kfree_skb_reason(),
no per-queue counter and no log message.
Today the four supported types match what is advertised in
hw_features and features, so this branch should be unreachable. If a
future feature flag is advertised without updating this switch (for
example a tunnel GSO type), would the resulting drops be observable
from userspace at all?
Would kfree_skb_reason() with a specific drop reason, or restructuring
so the unsupported case is structurally unreachable, make this easier
to debug?
> +static int eea_tx_check_free_num(struct eea_net_tx *tx,
> +				 struct netdev_queue *txq)
> +{
> +	int n;
> +
> +	/* MAX_SKB_FRAGS + 1: Covers the skb linear head and all paged fragments
> +	 * 1: Extra slot for a head or fragment that exceeds 64KB.
> +	 */
> +	n = MAX_SKB_FRAGS + 2;
> +	return netif_txq_maybe_stop(txq, tx->ering->num_free, n, n);
>  }
>
>  netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev)
>  {
> -	/* Empty function; will be implemented in a subsequent commit. */
> -	dev_kfree_skb_any(skb);
> +	struct eea_net *enet = netdev_priv(netdev);
> +	int qnum = skb_get_queue_mapping(skb);
> +	struct eea_net_tx *tx = &enet->tx[qnum];
> +	struct netdev_queue *txq;
> +	int err, enable;
> +
> +	txq = netdev_get_tx_queue(netdev, qnum);
> +
> +	enable = eea_tx_check_free_num(tx, txq);
> +	if (!enable)
> +		return NETDEV_TX_BUSY;
> +
> +	err = eea_tx_post_skb(tx, skb);
> +	if (unlikely(err)) {
> +		dev_kfree_skb_any(skb);
> +	} else {
> +		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
> +			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> +		skb_tx_timestamp(skb);
> +	}
> +
> +	/* NETDEV_TX_BUSY is expensive. So stop advancing the TX queue. */
> +	eea_tx_check_free_num(tx, txq);
> +
> +	if (!netdev_xmit_more() || netif_xmit_stopped(txq))
> +		eea_tx_kick(tx);
> +
>  	return NETDEV_TX_OK;
>  }
Is BQL intended to be wired up here?
eea_tx_check_free_num() uses netif_txq_maybe_stop(), which is the
BQL-aware helper, but the xmit path never calls
netdev_tx_sent_queue() and the completion path in eea_clean_tx() /
eea_poll_tx() never calls netdev_tx_completed_queue(). Without the
paired byte updates, BQL has no view of in-flight bytes.
Also, the stop and start thresholds passed to netif_txq_maybe_stop()
are both MAX_SKB_FRAGS + 2, so there is no hysteresis between
queue-stop and queue-wake. eea_poll_tx() uses the same threshold for
its wake check:
	if (netif_tx_queue_stopped(txq) &&
	    tx->ering->num_free >= MAX_SKB_FRAGS + 2)
		netif_tx_wake_queue(txq);
Was a stop/start gap (e.g. start at 2 * stop) considered to dampen
wake/stop oscillation under sustained pressure?

