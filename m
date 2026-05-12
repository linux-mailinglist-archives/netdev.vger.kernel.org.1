Return-Path: <netdev+bounces-287047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKYRARv5AmokzQEAu9opvQ
	(envelope-from <netdev+bounces-287047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:55:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9630751E1D9
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7959C3075BC1
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8B24C0421;
	Tue, 12 May 2026 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIFKg3dO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AE04BCADE
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579658; cv=none; b=hYJuyQZNH31nozpbLm6cX+KAI2dRYZr2x9ybvIy6nIMVXCKnwx8fw3wZQ/3fNLBFa0NGdj9L20F3oymghCQ5cY+vKAhXkrJo8f8IEzi8llECf/xqbh7GBXNaHIAemw/DsHHwnpPcb/SIGIUjiwK3ijQtv42mk0wfTIUiJywPQrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579658; c=relaxed/simple;
	bh=gk31GoeyOV70vW14uaTwUGY44YS4re54PPvnoSab0wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcTycNiBKbiulq42anm/4j43mvkV46p/mgtVLZ0tfChYvH6UUV/7ei0/gKcwpBBiNeo5CYURWqjod682onX7G2RWSv2ec2ILPDasICLzT4Ka1lYbrEmbaI136B+NRg9BxnODx8SnknYISW237oRHs5wkWp/BBz+6A3Zs8APuYy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bIFKg3dO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778579656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMVmVPrvFZoTcvZ9i5IDb4SwoK3BXH864RzSeHiCq68=;
	b=bIFKg3dOHS6jgIyJEWL3PmbWp5fzBJMbZbXGoJNggkHpgD+jswv8kdv9aqgwQmuAZ9wSKB
	JXb0eRZZteFpDVJUe1Qk924yriAolF6F/KRX492s8B/nSgyrnbY5BiNzkL/l5hDKBHnSYd
	nE42uxIPvMiiDZ0OSbdgtku50t1V+mU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-2k0qWvnEPrC4BjshRW6bYg-1; Tue,
 12 May 2026 05:54:12 -0400
X-MC-Unique: 2k0qWvnEPrC4BjshRW6bYg-1
X-Mimecast-MFC-AGG-ID: 2k0qWvnEPrC4BjshRW6bYg_1778579651
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF24D1955F38;
	Tue, 12 May 2026 09:54:10 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.142])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 88F0A1955D84;
	Tue, 12 May 2026 09:54:07 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 6/9] net: atlantic: implement AQC113 L2/L3/L4 RX filter management filter management management
Date: Tue, 12 May 2026 11:54:00 +0200
Message-ID: <20260512095400.134912-1-pabeni@redhat.com>
In-Reply-To: <20260506135706.2834-7-sukhdeeps@marvell.com>
References: <20260506135706.2834-7-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 9630751E1D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-287047-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.989];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Action: no action

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
Now I have enough context to produce the report.

commit ba73e7cd3452a0a57ac522b11a156ea2b727e473
Author: Sukhdeep Singh <sukhdeeps@marvell.com>
Subject: net: atlantic: implement AQC113 L2/L3/L4 RX filter management filter management management

This commit wires up L2/L3/L4 RX filter management for AQC113 hardware,
introducing reference-counted tag sharing of L3 and L4 filters, a combined
L3L4 configuration path that drives Action Resolver Table entries, an L2
ethertype set/clear pair, and a MAC-setup routine keyed off a firmware
reported L2 filter base index. It also rewires several entries in
hw_atl2_ops and updates the initialization of the new RX filter path.

> net: atlantic: implement AQC113 L2/L3/L4 RX filter management filter management management

The subject line appears to have a copy/paste slip: "filter management"
is repeated and "management" is tripled.

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

Is hw_get_version used anywhere in this series?  A grep across the driver
shows only the ops vtable assignment and this struct field; no ethtool,
debugfs, or regs-dump code calls self->aq_hw_ops->hw_get_version().
Should this op be introduced together with its consumer, or dropped from
this patch?

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> index 0ce9caae8799..e58bfff38670 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c

[ ... ]

> @@ -380,6 +422,9 @@ static void hw_atl2_hw_init_new_rx_filters(struct aq_hw_s *self)
>  {
>  	u8 *prio_tc_map = self->aq_nic_cfg->prio_tc_map;
>  	struct hw_atl2_priv *priv = self->priv;
> +	u32 art_first_sec, art_last_sec;
> +	u32 art_sections;
> +	u32 art_mask = 0;
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

Are art_first_sec and art_last_sec bounded before being passed to BIT()?

priv->art_base_index and priv->art_count come from firmware via
hw_atl2_utils_get_action_resolve_table_caps() (rslv_tbl_base_index and
rslv_tbl_count are 8-bit firmware fields).  BIT(nr) expands to
UL(1) << nr, so values that make art_last_sec >= BITS_PER_LONG are C
undefined behavior.

The consumer register RPF_REC_TAB_EN is 16 bits wide
(HW_ATL2_RPF_REC_TAB_EN_MSK = 0xFFFF), so values beyond 16 also silently
produce a bogus mask even if the shift does not invoke UB.

Could the firmware-reported caps be validated or clamped here?

> +	art_sections = hw_atl2_rpf_act_rslvr_section_en_get(self) | art_mask;
> +	hw_atl2_rpf_act_rslvr_section_en_set(self, art_sections);
> +	hw_atl2_rpf_l3_v6_v4_select_set(self, 1);
>  	hw_atl2_rpfl2_uc_flr_tag_set(self, HW_ATL2_RPF_TAG_BASE_UC,
> -				     HW_ATL2_MAC_UC);
> +				     priv->l2_filters_base_index);
>  	hw_atl2_rpfl2_bc_flr_tag_set(self, HW_ATL2_RPF_TAG_BASE_UC);

[ ... ]

> +static int hw_atl2_hw_mac_addr_set(struct aq_hw_s *self, const u8 *mac_addr)
> +{
> +	struct hw_atl2_priv *priv = self->priv;
> +	u32 location = priv->l2_filters_base_index;
> +	unsigned int h = 0U;
> +	unsigned int l = 0U;
> +	int err = 0;
> +
> +	if (!mac_addr) {
> +		err = -EINVAL;
> +		goto err_exit;
> +	}
> +	h = (mac_addr[0] << 8) | (mac_addr[1]);
> +	l = (mac_addr[2] << 24) | (mac_addr[3] << 16) |
> +		(mac_addr[4] << 8) | mac_addr[5];
> +
> +	hw_atl_rpfl2_uc_flr_en_set(self, 0U, location);
> +	hw_atl_rpfl2unicast_dest_addresslsw_set(self, l, location);
> +	hw_atl_rpfl2unicast_dest_addressmsw_set(self, h, location);
> +	hw_atl_rpfl2unicast_flr_act_set(self, 1U, location);
> +	hw_atl2_rpfl2_uc_flr_tag_set(self, HW_ATL2_RPF_TAG_BASE_UC, location);
> +	hw_atl_rpfl2_uc_flr_en_set(self, 1U, location);
> +
> +	err = aq_hw_err_from_flags(self);
> +
> +err_exit:
> +	return err;
> +}

Is the MAC-address programming path self-consistent at init when
priv->l2_filters_base_index != 0?

hw_atl2_hw_init() continues to call hw_atl_b0_hw_mac_addr_set(self,
mac_addr), which writes slot HW_ATL_B0_MAC (=0) with no UC tag.

hw_atl2_hw_init_new_rx_filters() tags slot priv->l2_filters_base_index
with HW_ATL2_RPF_TAG_BASE_UC but does not write a MAC into it.

The new hw_atl2_hw_mac_addr_set() only runs when userspace issues
ndo_set_mac_address.

Does this leave the device with slot 0 enabled and carrying the initial
MAC but no UC tag, while slot priv->l2_filters_base_index has the UC tag
but no address?  The commit message describes this as "Add MAC address
setup using firmware-provided L2 filter base index" but
hw_atl2_hw_init() still routes to the hardcoded slot.

> +static int hw_atl2_new_fl3l4_configure(struct aq_hw_s *self,
> +				       struct aq_rx_filter_l3l4 *data)
> +{
> +	struct hw_atl2_priv *priv = self->priv;
> +	s8 old_l3_index = priv->l3l4_filters[data->location].l3_index;
> +	s8 old_l4_index = priv->l3l4_filters[data->location].l4_index;
> +	u8 old_ipv6 = priv->l3l4_filters[data->location].ipv6;
> +	struct hw_atl2_l3_filter *l3_filters;

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

Note that l3_filters has been reassigned here based on old_ipv6.

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

Can this rollback corrupt the L3 refcounts?

If the new filter is IPv4 and the old one was IPv6 (or vice versa),
l3_filters points at the old family's array by the time this undo runs,
but l3_idx was allocated from the new family:

    if (l3.cmd & HW_ATL2_RPF_L3_V6_CMD_EN)
        l3_filters = priv->l3_v6_filters;
    else
        l3_filters = priv->l3_v4_filters;
    ...
    /* later overwritten using old_ipv6 */
    if (old_ipv6)
        l3_filters = priv->l3_v6_filters;
    else
        l3_filters = priv->l3_v4_filters;
    ...
    hw_atl2_rxf_l3_put(self, &l3_filters[l3_idx], l3_idx);

This decrements usage in the wrong array and, on reaching zero, clears
the wrong hardware register via hw_atl2_rpf_l3_v{4,6}_cmd_set().

Also, earlier in the function the old L3 may already have been put when
its content differed from the new L3.  The rollback does not re-get() the
old L3, so priv->l3l4_filters[data->location].l3_index is restored to
old_l3_index while the corresponding slot has already been cleared if
its usage was 1.

Finally, the new L3 get() is conditional:

    if (priv->l3l4_filters[data->location].l3_index != l3_idx)
        hw_atl2_rxf_l3_get(self, &l3_filters[l3_idx], l3_idx, &l3);

but the rollback's put() is unconditional on l3_idx >= 0.  Re-submitting
the same filter to the same location would skip the get(); a subsequent
L4 failure then puts a reference the call never took, potentially
underflowing the shared slot's usage count and clearing a filter another
location still relies on.

Could this rollback path track whether get() was actually performed, and
either hold on to the matched l3_filters pointer from the new family or
re-derive it from the new l3.cmd instead of old_ipv6?

> +
> +		if (priv->l3l4_filters[data->location].l4_index != l4_idx)
> +			hw_atl2_rxf_l4_get(self, &priv->l4_filters[l4_idx],
> +					   l4_idx, &l4);
> +	}

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

Can this index the static arrays out of bounds?

The backing arrays are fixed size:

    struct hw_atl2_l3_filter l3_v4_filters[HW_ATL2_RPF_L3L4_FILTERS];
    struct hw_atl2_l3_filter l3_v6_filters[HW_ATL2_RPF_L3L4_FILTERS];
    struct hw_atl2_l4_filter l4_filters[HW_ATL2_RPF_L3L4_FILTERS];

but l3_v4_filter_base_index, l3_v6_filter_base_index, l4_filter_base_index
and the corresponding counts come from firmware.  Looking at
hw_atl2_utils_get_filter_caps() (referenced elsewhere in the series),
l3_v6_filter_count is not clamped at all, unlike l3_v4_filter_count and
l4_filter_count which get reduced by one against
HW_ATL2_RPF_L3V4_FILTERS / HW_ATL2_RPF_L4_FILTERS.  None of the
base_index fields are validated against the fixed-size arrays either.

A firmware value that places first+count past HW_ATL2_RPF_L3L4_FILTERS
yields out-of-bounds reads here and out-of-bounds writes via
hw_atl2_rxf_l3_get() / _put().  The same concern applies to
hw_atl2_new_fl3l4_find_l4().

Could these indices be sanitized at probe time?

[ ... ]

> +static int hw_atl2_hw_fl2_set(struct aq_hw_s *self,
> +			      struct aq_rx_filter_l2 *data)
> +{
> +	struct hw_atl2_priv *priv = self->priv;
> +	u32 mask = HW_ATL2_RPF_TAG_ET_MASK;
> +	u32 req_tag = 0;
> +	u16 action = 0;
> +	u32 location;
> +	u8 index;
> +	int tag;
> +
> +	location = priv->etype_filter_base_index + data->location;
> +	hw_atl_rpf_etht_flr_set(self, data->ethertype, location);
> +	hw_atl_rpf_etht_user_priority_en_set(self,
> +					     !!data->user_priority_en,
> +					     location);
> +	if (data->user_priority_en) {
> +		hw_atl_rpf_etht_user_priority_set(self,
> +						  data->user_priority,
> +						  location);
> +		req_tag |= data->user_priority << HW_ATL2_RPF_TAG_PCP_OFFSET;
> +		mask |= HW_ATL2_RPF_TAG_PCP_MASK;
> +	}
> +
> +	if (data->queue < 0) {
> +		hw_atl_rpf_etht_flr_act_set(self, 0U, location);
> +		hw_atl_rpf_etht_rx_queue_en_set(self, 0U, location);
> +		action = HW_ATL2_ACTION_DROP;
> +	} else {
> +		hw_atl_rpf_etht_flr_act_set(self, 1U, location);
> +		hw_atl_rpf_etht_rx_queue_en_set(self, 1U, location);
> +		hw_atl_rpf_etht_rx_queue_set(self, data->queue, location);
> +		action = HW_ATL2_ACTION_ASSIGN_QUEUE(data->queue);
> +	}
> +
> +	tag = hw_atl2_filter_tag_get(priv->etype_policy,
> +				     priv->etype_filter_tag_top,
> +				     action);
> +
> +	if (tag < 0)
> +		return -ENOSPC;

Two concerns about this path:

First, if location already held an ethertype filter with a previous tag,
is that tag ever released?

aq_add_del_fether() in aq_filters.c calls hw_filter_l2_set() directly on
replacement (without an intervening hw_filter_l2_clear()), so each
overwrite of an existing location invokes hw_atl2_filter_tag_get() for
the new action but never hw_atl2_filter_tag_put() for the old one.  The
etype_policy[] usage counters will diverge from the set of tags actually
live in hardware, and after a small number of changes with distinct
actions the pool (bounded by etype_filter_tag_top) is exhausted and
set() starts returning -ENOSPC.

Second, on the -ENOSPC path above, the per-location ethertype,
user_priority_en/user_priority, flr_act, rx_queue_en and rx_queue
registers have already been written for the new filter while the old
etht_flr_en bit and the old tag are still set in hardware.  Should this
error path leave the hardware state unchanged, or disable the filter
before returning?

> +
> +	req_tag |= tag << HW_ATL2_RPF_TAG_ET_OFFSET;
> +	hw_atl2_rpf_etht_flr_tag_set(self, tag, location);
> +	index = priv->art_base_index + HW_ATL2_RPF_ET_PCP_USER_INDEX +
> +		data->location;
> +	hw_atl2_act_rslvr_table_set(self, index, req_tag, mask, action);
> +
> +	hw_atl_rpf_etht_flr_en_set(self, 1U, location);
> +
> +	return aq_hw_err_from_flags(self);
> +}

[ ... ]

> @@ -825,7 +1394,7 @@ static int hw_atl2_hw_vlan_ctrl(struct aq_hw_s *self, bool enable)
>  const struct aq_hw_ops hw_atl2_ops = {
>  	.hw_soft_reset        = hw_atl2_utils_soft_reset,
>  	.hw_prepare           = hw_atl2_utils_initfw,
> -	.hw_set_mac_address   = hw_atl_b0_hw_mac_addr_set,
> +	.hw_set_mac_address   = hw_atl2_hw_mac_addr_set,
>  	.hw_init              = hw_atl2_hw_init,
>  	.hw_reset             = hw_atl2_hw_reset,
>  	.hw_start             = hw_atl_b0_hw_start,
> @@ -834,6 +1403,7 @@ const struct aq_hw_ops hw_atl2_ops = {
>  	.hw_ring_rx_start     = hw_atl_b0_hw_ring_rx_start,
>  	.hw_ring_rx_stop      = hw_atl_b0_hw_ring_rx_stop,
>  	.hw_stop              = hw_atl2_hw_stop,
> +	.hw_get_version       = hw_atl2_get_hw_version,

See the earlier note; hw_get_version does not appear to have any caller
in this series.
-- 
This is an AI-generated review.


