Return-Path: <netdev+bounces-287051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGSNKIL6AmokzQEAu9opvQ
	(envelope-from <netdev+bounces-287051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:01:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8312E51E30D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D026930117F9
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3944C6EED;
	Tue, 12 May 2026 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MREnB8P2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7C3304BDE
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580088; cv=none; b=pm22QiXuX65Tn+L5zYO/pJU3X3b297utuiLdOE+XNWY4GEUxlgo5HaVmZTePeAw4A3uVVdGz+8ZTkiGqs4PH6xLCeG3UlhaaYvq8P5j0XA5qYqOj4+YKIyOgVsTB5MO41I1Ku7CTBoIYHlCUvqMKj0U3rsvoQAIDL7IpVqkZyxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580088; c=relaxed/simple;
	bh=XDiXCCYz8LsiXXVxGeSwpm0AHVxwfCdcSkWTyv5VV0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsQHx42eeic88jp67lsVG3iAigV+a9DqtLVXI4+jTgoNHrVyMP6Q3yDDtvVy6zv/j8GKpiClWmHTgGKdHYbr8+haULL4R/76/Svxg0Cbxi6HgIekkFxPr9rT9tXantGaAg3Bmq9zKNOB91FA+VS0Ory+0HvlqS7UapFo6ia0dFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MREnB8P2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778580086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exP7eBNqUy8NJjUq2TNl/He/yWYPuz1eQGDLBsqU/s0=;
	b=MREnB8P2tvrFdveodNoq9PKX/RpVAQWwbol9lzyDzTIxGg4b/GMweERRl3V9VLM/2hpwWp
	cHQIoxsimSbBa+MeXnIqtfSjt+tjpcSB135ZCasRtBCv1yvnJkHkcqGg5BKog09EuxY0+I
	eR1cAModBk2MNnerlXpHWNUovEu4KHY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-kKJ9JRfnPeCitJLOdJksCQ-1; Tue,
 12 May 2026 06:01:19 -0400
X-MC-Unique: kKJ9JRfnPeCitJLOdJksCQ-1
X-Mimecast-MFC-AGG-ID: kKJ9JRfnPeCitJLOdJksCQ_1778580074
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3DF11955D87;
	Tue, 12 May 2026 10:01:13 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.142])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 37BA418004A3;
	Tue, 12 May 2026 10:01:09 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: sukhdeeps@marvell.com
Cc: netdev@vger.kernel.org,
	irusskikh@marvell.com,
	epomozov@marvell.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/9] net: atlantic: implement AQC113 L2/L3/L4 RX filter management filter management management
Date: Tue, 12 May 2026 12:00:38 +0200
Message-ID: <20260512100038.143274-1-pabeni@redhat.com>
In-Reply-To: <20260508120156.3060-7-sukhdeeps@marvell.com>
References: <20260508120156.3060-7-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 8312E51E30D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[linux.dev:query timed out];
	TAGGED_FROM(0.00)[bounces-287051-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.989];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: atlantic: implement AQC113 L2/L3/L4 RX filter management filter management management

This change implements RX filter management for the AQC113, adding
reference-counted sharing of L3/L4 hardware slots, L2 ethertype
programming with ART tags, firmware-reported base/count usage, and a
MAC address helper that targets the FW-supplied l2_filters_base_index.

[Low]
The subject line contains a duplicated/triplicated phrase:

  net: atlantic: implement AQC113 L2/L3/L4 RX filter management filter management management

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
> index 57ea59026a2c..04fb87d4e56d 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
> @@ -236,6 +236,8 @@ struct aq_hw_ops {
>  
>  	int (*hw_stop)(struct aq_hw_s *self);
>  
> +	u32 (*hw_get_version)(struct aq_hw_s *self);
> +

[Low]
Is there any in-tree caller of ->hw_get_version()?  A search across the
atlantic driver and the rest of the tree does not show one, and the other
chip ops tables (hw_atl_a0, hw_atl_b0) leave this slot NULL.  If no caller
is introduced in this series, would it make sense to drop this hook for
now, or add it together with the consumer?

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> index 0ce9caae8799..7abf7fe6e32c 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c

[ ... ]

> @@ -380,6 +422,9 @@ static void hw_atl2_hw_init_new_rx_filters(struct aq_hw_s *self)
>  {
>  	u8 *prio_tc_map = self->aq_nic_cfg->prio_tc_map;
>  	struct hw_atl2_priv *priv = self->priv;
> +	u32 art_first_sec, art_last_sec;
> +	u32 art_sections;
> +	u32 art_mask;
>  	u16 action;
>  	u8 index;
>  	int i;
> @@ -394,9 +439,14 @@ static void hw_atl2_hw_init_new_rx_filters(struct aq_hw_s *self)
>  	 * REC entry is used for further processing. If multiple entries match,
>  	 * the lowest REC entry, Action field will be selected.
>  	 */
> -	hw_atl2_rpf_act_rslvr_section_en_set(self, 0xFFFF);
> +	art_last_sec = priv->art_base_index / 8 + priv->art_count / 8;
> +	art_first_sec = priv->art_base_index / 8;
> +	art_mask = (BIT(art_last_sec) - 1) - (BIT(art_first_sec) - 1);
> +	art_sections = hw_atl2_rpf_act_rslvr_section_en_get(self) | art_mask;
> +	hw_atl2_rpf_act_rslvr_section_en_set(self, art_sections);
> +	hw_atl2_rpf_l3_v6_v4_select_set(self, 1);
>  	hw_atl2_rpfl2_uc_flr_tag_set(self, HW_ATL2_RPF_TAG_BASE_UC,
> -				     HW_ATL2_MAC_UC);
> +				     priv->l2_filters_base_index);
>  	hw_atl2_rpfl2_bc_flr_tag_set(self, HW_ATL2_RPF_TAG_BASE_UC);

[ ... ]

> @@ -530,6 +580,35 @@ static int hw_atl2_hw_init_rx_path(struct aq_hw_s *self)
>  	return aq_hw_err_from_flags(self);
>  }
>  
> +static int hw_atl2_hw_mac_addr_set(struct aq_hw_s *self, const u8 *mac_addr)
> +{
> +	struct hw_atl2_priv *priv = self->priv;
> +	u32 location = priv->l2_filters_base_index;

[High]
Does the initial MAC programming still land on the right slot when
firmware reports a non-zero l2_filters_base_index?

The new .hw_set_mac_address and hw_atl2_hw_init_new_rx_filters() both
operate on priv->l2_filters_base_index.  However, hw_atl2_hw_init() still
calls hw_atl_b0_hw_mac_addr_set(self, mac_addr) directly, and that helper
hardcodes HW_ATL_B0_MAC (= 0).  At the same time hw_atl2_hw_init_rx_path()
enables only slot 0 via:

    for (i = HW_ATL2_MAC_MAX; i--;) {
        hw_atl_rpfl2_uc_flr_en_set(self, (i == 0U) ? 1U : 0U, i);
        ...
    }

If FW reports l2_filters_base_index != 0, the tagged slot has no MAC
programmed and the enabled slot (0) carries the wrong tag.  Should
hw_atl2_hw_init() call hw_atl2_hw_mac_addr_set() instead, or should the
enable/base bookkeeping be reconciled?

[ ... ]

> @@ -767,6 +846,496 @@ static struct aq_stats_s *hw_atl2_utils_get_hw_stats(struct aq_hw_s *self)
>  	return &self->curr_stats;
>  }
>  

[ ... ]

> +static int hw_atl2_new_fl3l4_find_l3(struct aq_hw_s *self,
> +				     struct hw_atl2_l3_filter *l3)
> +{
> +	struct hw_atl2_priv *priv = self->priv;
> +	struct hw_atl2_l3_filter *l3_filters;
> +	int i, first, last;
> +
> +	if (l3->cmd & HW_ATL2_RPF_L3_V6_CMD_EN) {
> +		l3_filters = priv->l3_v6_filters;
> +		first = priv->l3_v6_filter_base_index;
> +		last = priv->l3_v6_filter_base_index +
> +		       priv->l3_v6_filter_count;
> +	} else {
> +		l3_filters = priv->l3_v4_filters;
> +		first = priv->l3_v4_filter_base_index;
> +		last = priv->l3_v4_filter_base_index +
> +		       priv->l3_v4_filter_count;
> +	}
> +	for (i = first; i < last; i++) {
> +		if (hw_atl2_rxf_l3_is_equal(&l3_filters[i], l3))
> +			return i;
> +	}
> +
> +	for (i = first; i < last; i++) {
> +		u32 l3_enable_mask = HW_ATL2_RPF_L3_CMD_EN |
> +				     HW_ATL2_RPF_L3_V6_CMD_EN;
> +
> +		if (!(l3_filters[i].cmd & l3_enable_mask))
> +			return i;
> +	}
> +
> +	return -ENOSPC;
> +}

[High]
Can this walk off the end of the fixed-size arrays?

priv->l3_v4_filters, priv->l3_v6_filters, and priv->l4_filters are all
sized HW_ATL2_RPF_L3L4_FILTERS (= 8).  first/last come from the
firmware-reported filter_caps_s, where base_index is a 4-bit field (0..15)
and the counts are also 4 bits.

Looking at hw_atl2_utils_get_filter_caps(), l3_v4_filter_count and
l4_filter_count are clamped with min_t(..., HW_ATL2_RPF_L3{V4,4}_FILTERS
- 1), but l3_v6_filter_count does not appear to be clamped at all, and
none of the *_base_index fields are clamped.  A FW image reporting
l3_v6_filter_count >= 8, or any base_index such that base + count > 8,
would make this loop read priv->l3_v6_filters[i].cmd past the end, and
hw_atl2_rxf_l3_get() / hw_atl2_rxf_l4_get() would write cmd/srcip/dstip/
sport/dport past the end.

Should all three counts be clamped to HW_ATL2_RPF_L3L4_FILTERS, and
base_index + count bounded to HW_ATL2_RPF_L3L4_FILTERS?

> +
> +static void hw_atl2_rxf_l3_get(struct aq_hw_s *self,
> +			       struct hw_atl2_l3_filter *l3, int idx,
> +			       const struct hw_atl2_l3_filter *_l3)
> +{
> +	int i;
> +
> +	l3->usage++;
> +	if (l3->usage == 1) {
> +		l3->cmd = _l3->cmd;
> +		for (i = 0; i < 4; i++) {
> +			l3->srcip[i] = _l3->srcip[i];
> +			l3->dstip[i] = _l3->dstip[i];
> +		}
> +		l3->proto = _l3->proto;
> +
> +		if (l3->cmd & HW_ATL2_RPF_L3_CMD_EN) {
> +			hw_atl2_rpf_l3_v4_cmd_set(self, l3->cmd, idx);
> +			hw_atl2_rpf_l3_v4_tag_set(self, idx + 1, idx);

[High]
Can the per-filter tag value be silently truncated here?

HW_ATL2_RPF_L3_V{4,6}_TAG_MSK and HW_ATL2_RPF_L4_TAG_MSK are 3-bit fields
(max value 7), and the helpers aq_hw_write_reg_bit() mask the value to
the field width.  idx is in [base_index, base_index + count), and with
l3_v6_filter_count unclamped (and no clamp on any base_index), idx + 1
can exceed 7 and quietly collapse to a tag used by another slot.

When two slots end up with the same 3-bit tag, the ART input_tag/mask
comparison can pick the lowest matching record, so a drop rule could
match traffic intended to be forwarded (or vice versa) without any
diagnostic.  Should idx + 1 be range-checked against the mask width, or
the counts clamped so idx + 1 <= 7?

> +			hw_atl2_rpf_l3_v4_dest_addr_set(self,
> +							idx,
> +							l3->dstip[0]);
> +			hw_atl2_rpf_l3_v4_src_addr_set(self,
> +						       idx,
> +						       l3->srcip[0]);
> +		} else {
> +			hw_atl2_rpf_l3_v6_cmd_set(self, l3->cmd, idx);
> +			hw_atl2_rpf_l3_v6_tag_set(self, idx + 1, idx);
> +			hw_atl2_rpf_l3_v6_dest_addr_set(self,
> +							idx,
> +							l3->dstip);
> +			hw_atl2_rpf_l3_v6_src_addr_set(self,
> +						       idx,
> +						       l3->srcip);
> +		}
> +	}
> +}

[ ... ]

> +static int hw_atl2_new_fl3l4_configure(struct aq_hw_s *self,
> +				       struct aq_rx_filter_l3l4 *data)
> +{
> +	struct hw_atl2_priv *priv = self->priv;
> +	s8 old_l3_index = priv->l3l4_filters[data->location].l3_index;
> +	s8 old_l4_index = priv->l3l4_filters[data->location].l4_index;
> +	u8 old_ipv6 = priv->l3l4_filters[data->location].ipv6;

[ ... ]

> +	/* find L3 and L4 filters */
> +	if (l3.cmd & (HW_ATL2_RPF_L3_CMD_EN | HW_ATL2_RPF_L3_V6_CMD_EN)) {
> +		l3_idx = hw_atl2_new_fl3l4_find_l3(self, &l3);
> +		if (l3_idx < 0)
> +			return l3_idx;
> +
> +		if (l3.cmd & HW_ATL2_RPF_L3_V6_CMD_EN)
> +			l3_filters = priv->l3_v6_filters;
> +		else
> +			l3_filters = priv->l3_v4_filters;
> +
> +		if (priv->l3l4_filters[data->location].l3_index != l3_idx)
> +			hw_atl2_rxf_l3_get(self, &l3_filters[l3_idx],
> +					   l3_idx, &l3);
> +	}

[High]
Does this guard correctly handle a family switch at the same location?

priv->l3_v4_filters[] and priv->l3_v6_filters[] are separate 8-entry
arrays.  When an existing v4 rule at data->location is reconfigured to
v6 (or the reverse), hw_atl2_new_fl3l4_find_l3() searches the new
family's array and is likely to return 0 as the first free slot.  If
the previously stored l3_index was also 0, then:

    if (priv->l3l4_filters[data->location].l3_index != l3_idx)  /* 0 != 0 */
        hw_atl2_rxf_l3_get(...);   /* skipped */

hw_atl2_rxf_l3_get() is skipped, so priv->l3_v6_filters[0].cmd stays 0
and no v6 HW registers are written.  Later, hw_atl2_hw_fl3l4_set() reads
ipv6 = 1 and l3_index = 0, picks l3 = &priv->l3_v6_filters[0], finds
(l3->cmd & V6_CMD_EN) == 0, and programs the ART tag down the V4 path
while the user asked for V6.

Would it be correct to include the family in the guard, or to just
call hw_atl2_rxf_l3_get() unconditionally (it is already idempotent via
the usage == 1 check)?

> +
> +	if (old_l3_index != -1) {
> +		if (old_ipv6)
> +			l3_filters = priv->l3_v6_filters;
> +		else
> +			l3_filters = priv->l3_v4_filters;
> +
> +		if (!(hw_atl2_rxf_l3_is_equal(&l3,
> +					      &l3_filters[old_l3_index]))) {
> +			hw_atl2_rxf_l3_put(self,
> +					   &l3_filters[old_l3_index],
> +					   old_l3_index);
> +		}
> +	}
> +	if (l3.cmd & HW_ATL2_RPF_L3_V6_CMD_EN)
> +		priv->l3l4_filters[data->location].ipv6 = 1;
> +	else
> +		priv->l3l4_filters[data->location].ipv6 = 0;
> +	priv->l3l4_filters[data->location].l3_index = l3_idx;
> +
> +	if (l4.cmd & HW_ATL2_RPF_L4_CMD_EN) {
> +		l4_idx = hw_atl2_new_fl3l4_find_l4(self, &l4);
> +		if (l4_idx < 0) {
> +			/* Undo L3 acquisition */
> +			if (l3_idx >= 0) {
> +				hw_atl2_rxf_l3_put(self, &l3_filters[l3_idx], l3_idx);
> +				priv->l3l4_filters[data->location].l3_index = old_l3_index;
> +				priv->l3l4_filters[data->location].ipv6 = old_ipv6;
> +			}
> +			return -EINVAL;
> +		}

[High, High]
Does the L4-failure undo path correctly unwind L3 state in two distinct
ways?

First, cross-family pointer aliasing.  Before the L4 find, l3_filters
points to the new family's array (from the earlier block).  The
intermediate "if (old_l3_index != -1)" block unconditionally reassigns
l3_filters to the old family based on old_ipv6.  By the time the undo
runs, l3_filters still points to the old family's array, but l3_idx is
a new-family index:

    hw_atl2_rxf_l3_put(self, &l3_filters[l3_idx], l3_idx);

For a cross-family reconfigure this decrements the wrong filter (and
may clear its HW via hw_atl2_rpf_l3_v{4,6}_cmd_set(self, 0, idx)) while
the actually-acquired new-family filter's refcount is leaked.  Should
the undo re-derive l3_filters from the new family before calling put?

Second, the old L3 filter is not re-acquired.  Earlier in the function,
if old_l3_index != -1 and !is_equal(new, old), the old filter has
already had hw_atl2_rxf_l3_put() called on it, potentially dropping
usage to 0 and clearing HW.  The undo block restores l3_index = old and
ipv6 = old_ipv6, but does not restore the refcount or HW state of the
old filter.  Would the old filter need a matching rxf_l3_get() call
here to keep priv->l3l4_filters[location] consistent with the actual
HW/refcount state?

[ ... ]

> +static int hw_atl2_hw_fl3l4_set(struct aq_hw_s *self,
> +				struct aq_rx_filter_l3l4 *data)
> +{

[ ... ]

> +	res = hw_atl2_new_fl3l4_configure(self, data);
> +	if (res)
> +		return res;
> +

[ ... ]

> +	if (!(data->cmd & HW_ATL_RX_ENABLE_FLTR_L3L4)) {

[ ... ]

> +		return 0;
> +	}
> +

[ ... ]

> +	if (data->cmd & (HW_ATL_RX_HOST << HW_ATL2_RPF_L3_L4_ACTF_SHIFT))
> +		action = HW_ATL2_ACTION_ASSIGN_QUEUE((data->cmd  &
> +						      HW_ATL2_RPF_L3_L4_RXQF_MSK) >>
> +						     HW_ATL2_RPF_L3_L4_RXQF_SHIFT);
> +	else if (data->cmd)
> +		action = HW_ATL2_ACTION_DROP;
> +	else
> +		action = HW_ATL2_ACTION_DISABLE;

[Low]
Can the final "else action = HW_ATL2_ACTION_DISABLE" branch actually be
reached?  The function has already returned early for the case where
HW_ATL_RX_ENABLE_FLTR_L3L4 is clear, so at this point data->cmd always
has at least that bit set and is non-zero, which means "else if
(data->cmd)" always fires.  Was a different condition intended here?

[ ... ]

> @@ -825,7 +1394,7 @@ static int hw_atl2_hw_vlan_ctrl(struct aq_hw_s *self, bool enable)
>  const struct aq_hw_ops hw_atl2_ops = {
>  	.hw_soft_reset        = hw_atl2_utils_soft_reset,
>  	.hw_prepare           = hw_atl2_utils_initfw,
> -	.hw_set_mac_address   = hw_atl_b0_hw_mac_addr_set,
> +	.hw_set_mac_address   = hw_atl2_hw_mac_addr_set,

[ ... ]
-- 
This is an AI-generated review.


