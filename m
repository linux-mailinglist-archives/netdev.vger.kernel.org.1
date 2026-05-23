Return-Path: <netdev+bounces-291000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PNQH2ECEWq2gQYAu9opvQ
	(envelope-from <netdev+bounces-291000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 03:26:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DED065BC501
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 03:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B3223015C95
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A785D243956;
	Sat, 23 May 2026 01:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3J1TePY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D035239E7E;
	Sat, 23 May 2026 01:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779499561; cv=none; b=UPbxuxtc7Por1KuIZJSCkN0BSE9YkVh3C3OGmBsbbIp1EbfQX9Nre5MgEmezV/ube0kP+AMKcTkqkd4gZgVEXKUvwArMdkCUXAazM+Btxs47gzWFBXEqGhRRs53adzlKNUfodJRQwr3LtYIngnPobZdE/P1pEM7qCCT9UAPToKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779499561; c=relaxed/simple;
	bh=43sYSN2UwySyP9BQQo89nQKsxKiV7irWc4KHSaPIqzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=no82BAYpptBvUG34vWYzUoFf0XegcNfg/0+ssZyxbBrmVbwdMdRrkARhG2t5lPQE/b6eNy1Uj8dur6OEeqaveSrBUyIBLgW7ply70kdGW8YyOPQIPXyawlXY1vtvE3polhMsF7bcbmLxE4prkd9kgslwdzHJdpHTYoLJ0/WtiyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3J1TePY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE7E1F00A3A;
	Sat, 23 May 2026 01:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779499559;
	bh=35mJYujbv4OHdqzH2CAqjx9LOk9c3AmSw5ckBoYoHOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F3J1TePYTzfCk6goZwqOuDE0d+JzGH5kbw1DWzoQ0hC6wfK4LvQ6wdRxcohDHG/K9
	 mPB8/66xbVLQ9gvqPQ7DtorMNiYoXrjzT5hssSbBdjRAzQnd26H4OBGrPK2EdTLWAq
	 A+eStos6pKSV5SPwCkYeuZf9k5zjwUHZp0/Pll2ijx93tZe1gMN5do2fuQKga5maUs
	 WYQ230bB5Ui8+RX4iaZMmPYba8N7lvqzG9IrL49jpT3IzppgyNHFDaJaLvE7e3zulp
	 ikGsKUoMS3SLiD1XoASLeIQdltCObzdobAG/kV4Ue8j1ofSosdUuH+OuTl8i7hcO3M
	 7Yv238BMRtWPw==
From: Jakub Kicinski <kuba@kernel.org>
To: sukhdeeps@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v3 12/12] net: atlantic: add AQC113 PTP support in aq_ptp and driver core
Date: Fri, 22 May 2026 18:25:43 -0700
Message-ID: <20260523012542.1823843-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520141046.2151-13-sukhdeeps@marvell.com>
References: <20260520141046.2151-13-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291000-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DED065BC501
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: atlantic: add AQC113 PTP support in aq_ptp and driver core

This commit adds PTP support for the AQC113 hardware. It updates PTP state
initialization, refactors hardware filter configurations to support L3/L4 PTP
multicast rules, and registers new per-instance offset tables.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> index ef94478100716..f1ce11c6a3d1e 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c

[ ... ]

> @@ -793,6 +822,17 @@ unsigned int aq_nic_map_skb(struct aq_nic_s *self, struct sk_buff *skb,
>  
>  	first->eop_index = dx;
>  	dx_buff->is_eop = 1U;
> +	if (skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
> +	    self->aq_hw_ops->enable_ptp &&
> +	    self->aq_hw_ops->hw_get_clk_sel &&
> +	    aq_ptp_ring(self, ring)) {
> +		clk_sel = (s32)self->aq_hw_ops->hw_get_clk_sel(self->aq_hw);
> +		if (clk_sel < 0)
> +			goto exit;

[Severity: High]
If hw_get_clk_sel() returns a negative value, this skips setting dx_buff->skb
and dx_buff->xdpf to NULL because of the early exit. Since the descriptors
are reused, dx_buff->skb might contain a stale pointer.

Could this cause a use-after-free when aq_ring_tx_clean() tries to free the
stale skb? Also, does this leak the current skb since it was DMA mapped but
not stored?

> +		dx_buff->request_ts = 1U;
> +		dx_buff->clk_sel = (u32)clk_sel;
> +		ring->ptp_ts_deadline = jiffies + HZ;
> +	}
>  	dx_buff->skb = skb;
>  	dx_buff->xdpf = NULL;
>  	goto exit;

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> index 7486a28d7ff8f..31373c20782cc 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c

[ ... ]

> +static int aq_ptp_dpath_enable(struct aq_ptp_s *aq_ptp,
> +			       int enable_flags, u16 rx_queue)
> +{

[ ... ]

> +	if (enable_flags) {
> +		if (enable_flags & (AQ_HW_PTP_L4_ENABLE)) {
> +			if (aq_ptp->a1_ptp) {

[ ... ]

> +		if (enable_flags & AQ_HW_PTP_L2_ENABLE) {
> +			aq_ptp->eth_type_filter.ethertype = ETH_P_1588;
> +			aq_ptp->eth_type_filter.queue = rx_queue;
> +		}
> +
> +		if (hw_ops->hw_filter_l3l4_set) {

[ ... ]

> +		if (!err && (enable_flags & AQ_HW_PTP_L2_ENABLE) &&
> +		    hw_ops->hw_filter_l2_set) {

[Severity: Medium]
If userspace initially requests both L2 and L4 filters, and later changes the
configuration to L2-only, the enable_flags will only have AQ_HW_PTP_L2_ENABLE
set.

This executes the if (enable_flags) branch and updates the L2 filters, but
skips clearing the L4 hardware filters.

Will this leave stale L4 filters active in the hardware?

> +			err = hw_ops->hw_filter_l2_set(aq_nic->aq_hw,
> +					&aq_ptp->eth_type_filter);

[ ... ]

>  int aq_ptp_hwtstamp_config_set(struct aq_ptp_s *aq_ptp,
>  			       struct kernel_hwtstamp_config *config)
>  {
> +	unsigned int ptp_en_flags = aq_ptp_parse_rx_filters(config->rx_filter);
>  	struct aq_nic_s *aq_nic = aq_ptp->aq_nic;
> -	const struct aq_hw_ops *hw_ops;
>  	int err = 0;
>  
> -	hw_ops = aq_nic->aq_hw_ops;
> -	if (config->tx_type == HWTSTAMP_TX_ON ||
> -	    config->rx_filter == HWTSTAMP_FILTER_PTP_V2_EVENT) {
> -		aq_ptp_prepare_filters(aq_ptp);
> -		if (hw_ops->hw_filter_l3l4_set) {
> -			err = hw_ops->hw_filter_l3l4_set(aq_nic->aq_hw,
> -							 &aq_ptp->udp_filter);
> -		}
> -		if (!err && hw_ops->hw_filter_l2_set) {
> -			err = hw_ops->hw_filter_l2_set(aq_nic->aq_hw,
> -						       &aq_ptp->eth_type_filter);
> -		}
> +	if (aq_ptp->hwtstamp_config.rx_filter != config->rx_filter) {
> +		mutex_lock(&aq_ptp->ptp_filter_lock);

[Severity: Medium]
Is it possible for the hardware and software states to become out of sync here?

The new ptp_filter_lock protects the hardware configuration, but the software
state (aq_ptp->hwtstamp_config.rx_filter) doesn't seem to be updated under this
lock.

If a link status change occurs concurrently:

aq_ptp_clock_init() {
    ...
    aq_ptp_dpath_enable(aq_ptp, ptp_en_flags, aq_ptp->ptp_rx.idx);
}

Could aq_ptp_clock_init() read the old software state and restore stale filters
right after the ioctl configures the new ones?

> +		err = aq_ptp_dpath_enable(aq_ptp,
> +					  ptp_en_flags,
> +					  aq_ptp->ptp_rx.idx);
> +		mutex_unlock(&aq_ptp->ptp_filter_lock);
> +	}
> +
> +	if (ptp_en_flags != AQ_HW_PTP_DISABLE)
>  		aq_utils_obj_set(&aq_nic->flags, AQ_NIC_PTP_DPATH_UP);
> -	} else {

[Severity: High]
Does this break TX hardware timestamping if RX filtering is disabled?

If a user configures pure TX timestamping (tx_type = HWTSTAMP_TX_ON) but
rx_filter = HWTSTAMP_FILTER_NONE, ptp_en_flags evaluates to AQ_HW_PTP_DISABLE.
This clears AQ_NIC_PTP_DPATH_UP, which will prevent the datapath from routing
packets to the PTP TX ring.

The old code correctly preserved this flag by checking
config->tx_type == HWTSTAMP_TX_ON.

> -		aq_ptp->udp_filter.cmd &= ~HW_ATL_RX_ENABLE_FLTR_L3L4;
> -		if (hw_ops->hw_filter_l3l4_set) {
> -			err = hw_ops->hw_filter_l3l4_set(aq_nic->aq_hw,
> -							 &aq_ptp->udp_filter);
> -		}
> -		if (!err && hw_ops->hw_filter_l2_clear) {
> -			err = hw_ops->hw_filter_l2_clear(aq_nic->aq_hw,
> -							&aq_ptp->eth_type_filter);
> -		}
> +	else
>  		aq_utils_obj_clear(&aq_nic->flags, AQ_NIC_PTP_DPATH_UP);
> -	}

