Return-Path: <netdev+bounces-290995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNsxOq4AEWprgQYAu9opvQ
	(envelope-from <netdev+bounces-290995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 03:19:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 749765BC4A5
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 03:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1E5F3011844
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABCD1624C5;
	Sat, 23 May 2026 01:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSlhQQ/7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CE6145355;
	Sat, 23 May 2026 01:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779499162; cv=none; b=h8OEzAygFWtRMnsmqyaMtBYSumA0ayAvs5F6u6fK+/aRIuuUsb0+EFEFBuQJCulWfo+dic1VsWs2EStgYk6djqhHA/OJzusuu56oqBJm3S43g30bdXPvbc64fZoeAyhPAPAp/ltUXoboi+5B2LcwilvlKRz19XD28CTwyDS3Dwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779499162; c=relaxed/simple;
	bh=6Cj5Uh2F9BsK+CHr90n7God9xQKs9Fp9g85EpctZ03M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3HLfzieW2sOAr+FZnbqWeNhSnt4Rf415ve4T864YMtjr5qmhUJ8ED1RJdlipffWusz7DBK7AZ2V8wcgXob6l7olvBtP/oe4tA5xBaFN7yE1VHf96ATwLAt4nPAI1xguSiZHRpfjk1Ubs88gsaRrBPt16DEAtELW6QYWW77rCUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSlhQQ/7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE2D1F000E9;
	Sat, 23 May 2026 01:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779499161;
	bh=JAm14CvezJITRP24kh+/RiF4LTfdAgBaAbQDOITexd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eSlhQQ/72BUy1nUgm78aZtqVY+iEWQgVr3SDY3TFLI+iBMlcVyoyXOiJ47A/CggEg
	 ghxhRGa0VhSL32Fp1EuuiD005MH8RPH4pgxfnC3YKq7ZkTe8ziOfyCfglCEx4xqo9N
	 cUalAdS4QcpiRimx7+t9heVIkvkJZN91Qcp9xIC+tQg9fi9lpTK2xnpVv+0iZlo3V/
	 hzWhCk/1NgpUoMIqky5G71sjPH9YhsCEDLGsDEPe7gJ7eJMkZ2i4jSFmNwR/TKd8kF
	 TBedjDoHPZh8nxc+yFjoBBQiAluNmxRz21qshY1pLRyz7DKZAz0WNdROvF8saEuYXs
	 wELiZaqtUtRXg==
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
Subject: Re: [PATCH net-next v3 6/12] net: atlantic: fix AQC113 HW init: ART sections, L2 filter slot, MAC address
Date: Fri, 22 May 2026 18:19:19 -0700
Message-ID: <20260523011919.1819994-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520141046.2151-7-sukhdeeps@marvell.com>
References: <20260520141046.2151-7-sukhdeeps@marvell.com>
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
	TAGGED_FROM(0.00)[bounces-290995-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 749765BC4A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: atlantic: fix AQC113 HW init: ART sections, L2 filter slot, MAC address

This patch reworks hw_atl2 init to use firmware-reported filter layout
fields (art_base_index, art_count, l2_filters_base_index) instead of
hardcoded constants, adds a hw_atl2-specific MAC address setter that
programs the FW-assigned L2 filter slot, and wires .hw_get_regs into
hw_atl2_ops.

A few questions inline.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> index 0ce9caae8799..db0035fb04c7 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> @@ -95,12 +96,21 @@ static int hw_atl2_hw_reset(struct aq_hw_s *self)
>  {
>  	struct hw_atl2_priv *priv = self->priv;
>  	int err;
> +	int i;
>  
>  	err = hw_atl2_utils_soft_reset(self);
>  	if (err)
>  		return err;
>  
> -	memset(priv, 0, sizeof(*priv));
> +	memset(&priv->last_stats, 0, sizeof(priv->last_stats));
> +	memset(priv->l3_v4_filters, 0, sizeof(priv->l3_v4_filters));
> +	memset(priv->l3_v6_filters, 0, sizeof(priv->l3_v6_filters));
> +	memset(priv->l4_filters, 0, sizeof(priv->l4_filters));
> +	memset(priv->etype_policy, 0, sizeof(priv->etype_policy));
> +	for (i = 0; i < HW_ATL2_RPF_L3L4_FILTERS; i++) {
> +		priv->l3l4_filters[i].l3_index = -1;
> +		priv->l3l4_filters[i].l4_index = -1;
> +	}

[Low]
The commit message says the change replaces the unconditional priv memset
with selective field clears "to preserve firmware-reported layout
(art_base_index, l2_filters_base_index, etc.) across resets".

Is that description accurate?

hw_atl2_hw_reset() runs hw_atl2_utils_soft_reset() right above this hunk,
which calls aq_fw_ops->init() = aq_a2_fw_init(), which ends up calling
hw_atl2_utils_get_filter_caps() and unconditionally repopulates
art_base_index, art_count, l2_filters_base_index, l2_filter_count, the
etype_filter_*, vlan_filter_*, l3_v4_filter_*, l3_v6_filter_* and
l4_filter_* fields from the FW shared buffer.

The full memset was therefore harmless for those fields. The durable
behavioral change here looks like the new -1 sentinel for
l3l4_filters[i].l3_index/l4_index (since 0 is a valid filter index).

Could the changelog be reworded to say what the fix actually is?

> @@ -380,6 +390,9 @@ static void hw_atl2_hw_init_new_rx_filters(struct aq_hw_s *self)
>  {
>  	u8 *prio_tc_map = self->aq_nic_cfg->prio_tc_map;
>  	struct hw_atl2_priv *priv = self->priv;
> +	u32 art_first_sec, art_last_sec;
> +	u32 art_sections;
> +	u32 art_mask;
>  	u16 action;
>  	u8 index;
>  	int i;
> @@ -394,9 +407,16 @@ static void hw_atl2_hw_init_new_rx_filters(struct aq_hw_s *self)
>  	 * REC entry is used for further processing. If multiple entries match,
>  	 * the lowest REC entry, Action field will be selected.
>  	 */
> -	hw_atl2_rpf_act_rslvr_section_en_set(self, 0xFFFF);
> +	art_last_sec = min_t(u32,
> +			     priv->art_base_index / 8 + priv->art_count / 8,
> +			     16U);
> +	art_first_sec = min_t(u32, priv->art_base_index / 8, 16U);
> +	art_mask = (BIT(art_last_sec) - 1) - (BIT(art_first_sec) - 1);
> +	art_sections = hw_atl2_rpf_act_rslvr_section_en_get(self) | art_mask;
> +	hw_atl2_rpf_act_rslvr_section_en_set(self, art_sections);

[Medium]
Can art_mask collapse to zero here?

If FW reports rslv_tbl_base_index >= 16 (so priv->art_base_index =
8 * rslv_tbl_base_index >= 128), then both clamped values become 16:

    art_last_sec  = min_t(u32, 16+something, 16U) = 16
    art_first_sec = min_t(u32, 16, 16U)           = 16
    art_mask      = (BIT(16) - 1) - (BIT(16) - 1) = 0

Since this code runs after a soft reset, the read-back of
HW_ATL2_RPF_REC_TAB_EN via hw_atl2_rpf_act_rslvr_section_en_get() is
typically 0, so art_sections = 0 | 0 = 0 and the entire Action Resolver
Table ends up disabled.

hw_atl2_utils_get_filter_caps() does not validate rslv_tbl_base_index
(only art_count == 0 is clamped to 128), so nothing else catches this.

Should there be a fallback path (warn and write 0xFFFF, or refuse to
proceed) when the computed mask is 0? The previous unconditional 0xFFFF
write was immune to this case.

> +	hw_atl2_rpf_l3_v6_v4_select_set(self, 1);
>  	hw_atl2_rpfl2_uc_flr_tag_set(self, HW_ATL2_RPF_TAG_BASE_UC,
> -				     HW_ATL2_MAC_UC);
> +				     priv->l2_filters_base_index);
>  	hw_atl2_rpfl2_bc_flr_tag_set(self, HW_ATL2_RPF_TAG_BASE_UC);

[High]
Is priv->l2_filters_base_index validated anywhere before being used as a
filter slot index?

filter_caps_s::l2_filters_base_index is a 6-bit field (encodable values
0..63), and hw_atl2_utils_get_filter_caps() copies it verbatim into
priv->l2_filters_base_index without clamping. The same function does
clamp the L3/L4 base/count fields against HW_ATL2_RPF_L3L4_FILTERS, so
the omission here looks unintentional.

Two failure modes follow from FW-supplied values:

  - If FW reports a value in [HW_ATL2_MAC_MIN, HW_ATL2_MAC_MAX-1]
    (i.e. [1, 37]), the UC slot collides with the multicast slot range
    used by hw_atl2_hw_multicast_list_set() and the host MAC entry and a
    multicast entry overwrite each other.

  - If FW reports a value >= HW_ATL2_MAC_MAX (38), the loop in
    hw_atl2_hw_init_rx_path() never matches, so no UC slot is enabled
    and the device cannot accept its own MAC.

The previous code used the literal HW_ATL2_MAC_UC (0), which was always
in range. Should hw_atl2_utils_get_filter_caps() (or this site) bound
priv->l2_filters_base_index against HW_ATL2_MAC_MAX before it is used?

> @@ -484,6 +504,7 @@ static int hw_atl2_act_rslvr_table_set(struct aq_hw_s *self, u8 location,
>  static int hw_atl2_hw_init_rx_path(struct aq_hw_s *self)
>  {
>  	struct aq_nic_cfg_s *cfg = self->aq_nic_cfg;
> +	struct hw_atl2_priv *priv = self->priv;
>  	int i;
>  
> @@ -499,7 +520,9 @@ static int hw_atl2_hw_init_rx_path(struct aq_hw_s *self)
>  
>  	/* Multicast filters */
>  	for (i = HW_ATL2_MAC_MAX; i--;) {
> -		hw_atl_rpfl2_uc_flr_en_set(self, (i == 0U) ? 1U : 0U, i);
> +		hw_atl_rpfl2_uc_flr_en_set(self,
> +					   (i == priv->l2_filters_base_index) ?
> +					   1U : 0U, i);
>  		hw_atl_rpfl2unicast_flr_act_set(self, 1U, i);
>  	}

[High]
This is the second consumer of the unvalidated priv->l2_filters_base_index
referenced above. If FW reports a value outside [0, HW_ATL2_MAC_MAX), the
(i == priv->l2_filters_base_index) condition never holds for any i in the
loop and no UC slot is enabled at all.

> @@ -530,6 +553,35 @@ static int hw_atl2_hw_init_rx_path(struct aq_hw_s *self)
>  	return aq_hw_err_from_flags(self);
>  }
>  
> +static int hw_atl2_hw_mac_addr_set(struct aq_hw_s *self, const u8 *mac_addr)
> +{
> +	struct hw_atl2_priv *priv = self->priv;
> +	u32 location = priv->l2_filters_base_index;
> +	unsigned int h;
> +	unsigned int l;
> +	int err;
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

[High]
Same concern here: location = priv->l2_filters_base_index is used directly
in HW_ATL_RPFL2UC_DAFLSW_ADR(filter) / HW_ATL_RPFL2UC_DAFMSW_ADR(filter),
which compute base + filter * stride. With a FW-supplied value beyond the
L2 UC filter array, these writes will land at MMIO offsets outside the
intended register range.

Should location be bounds-checked against HW_ATL2_MAC_MAX (or whatever the
hardware's actual L2 UC filter count is) before being used as an MMIO
index?

> @@ -825,7 +877,7 @@ static int hw_atl2_hw_vlan_ctrl(struct aq_hw_s *self, bool enable)
>  const struct aq_hw_ops hw_atl2_ops = {
>  	.hw_soft_reset        = hw_atl2_utils_soft_reset,
>  	.hw_prepare           = hw_atl2_utils_initfw,
> -	.hw_set_mac_address   = hw_atl_b0_hw_mac_addr_set,
> +	.hw_set_mac_address   = hw_atl2_hw_mac_addr_set,
>  	.hw_init              = hw_atl2_hw_init,
>  	.hw_reset             = hw_atl2_hw_reset,

[Low]
Could this patch be split, and could each piece carry a Fixes: tag?

There appear to be five logically independent fixes folded together:

  - selective memset plus the l3l4_filters l3_index/l4_index = -1 sentinel
  - ART section enable computation from FW-reported base/count
  - rpf_l3_v6_v4_select enable
  - replacing the A1 hw_atl_b0_hw_mac_addr_set with a hw_atl2-specific
    setter that targets the FW-assigned slot
  - wiring .hw_get_regs into hw_atl2_ops

The .hw_set_mac_address swap in particular is a runtime behavioral change
for any FW reporting l2_filters_base_index != 0 (the host MAC moves slots,
and hw_atl2_hw_init_rx_path() now enables only that slot instead of
slot 0), so it would seem to deserve its own commit and Fixes: tag for
backporting and bisection purposes.

