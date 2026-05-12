Return-Path: <netdev+bounces-287045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOkzF974AmqvzAEAu9opvQ
	(envelope-from <netdev+bounces-287045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:54:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC2451E1A5
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35A4730121E9
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0674C042F;
	Tue, 12 May 2026 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlRwYRAr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC14BCADE
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579649; cv=none; b=fKsUCAolKwvF31XBZ+y6ZiTCZzZxbPhFJVA2E2NrjabxK6gq4I3W75dE3RTrwMd+q1Ibe9aPEGpNHQvsUvlIcSTly+Crg4TXYsn2iQtcjLI1bg18nibaEBzxb+b/3lyq+xFJYtO3JT0PXQeMCHi/aNW+29xH9NPnMRuSmM/4zyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579649; c=relaxed/simple;
	bh=GhcbWShvWu0HBoL4vJTJZaZ4YXcm4LYzQBrJroNK88g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufMgP2CemBxT3/WaPSfzVoLmh0H5K2pRjuZGtOS/OVFyZ+PcujXJ6ffTS/8sGxKTXCQY+nARc1sIDWeBXBhl9egn40jjh5k8Xvlz3dIX9uKPPtBihtMBwzH3JrHbWnq2iRLyl9IKQKJyL1ARebgJWL7T/UJ5OGk/dd5/J7WHxtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BlRwYRAr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778579645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QE9d9z2R7mk3rN0owPm0GllpWfqewHyaYRZUy3W9Hc=;
	b=BlRwYRArrvGArQWEwA1FfwyuAbHvUz78ztv6SQWaCL1pEF7B+Igoy5CYQH16RmMh4d4JwH
	VF4ncd4hJwk9Jr8FdQNhNWri4EjjlqstbUmCVjiz9ADnkPBwA4B64TErw+rhAUJSo5P8xa
	Sh+fbKs3duwiJS8HuAtsavDo/77DI9A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-j6uhMd5cM3q75A7lfzPjSg-1; Tue,
 12 May 2026 05:54:02 -0400
X-MC-Unique: j6uhMd5cM3q75A7lfzPjSg-1
X-Mimecast-MFC-AGG-ID: j6uhMd5cM3q75A7lfzPjSg_1778579640
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 683AE18005B3;
	Tue, 12 May 2026 09:54:00 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.142])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0665519560A2;
	Tue, 12 May 2026 09:53:56 +0000 (UTC)
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
Subject: Re: [PATCH net-next 5/9] net: atlantic: add AQC113 filter data structures and firmware query and firmware query firmware query
Date: Tue, 12 May 2026 11:53:49 +0200
Message-ID: <20260512095354.134894-1-pabeni@redhat.com>
In-Reply-To: <20260506135706.2834-6-sukhdeeps@marvell.com>
References: <20260506135706.2834-6-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 5AC2451E1A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-287045-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Action: no action

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: atlantic: add AQC113 filter data structures and firmware query and firmware query firmware query

This patch adds filter data structures, RPF L3/L4 command bits, filter
count constants, and a firmware capability query used to populate filter
base indices and counts stored in hw_atl2_priv. It also adds a MAC
register dump helper for debug support.

> net: atlantic: add AQC113 filter data structures and firmware query and firmware query firmware query

The subject line has "firmware query" repeated three times.  Similar
duplication appears on other subjects in this series (for example
"filter management filter management management", "(Antigua) (Antigua)",
"TX path setup TX path setup").  Would it be possible to regenerate the
series so each subject reads cleanly?

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
> index 5a89bb8722f9..fc086d84fb91 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h

[ ... ]

> @@ -119,9 +137,54 @@ enum HW_ATL2_RPF_RSS_HASH_TYPE {
>  
>  #define HW_ATL_MCAST_FLT_ANY_TO_HOST 0x00010FFFU
>  
> +struct hw_atl2_l3_filter {
> +	u8 proto;
> +	u8 usage;
> +	u32 cmd;
> +	u32 srcip[4];
> +	u32 dstip[4];
> +};

[ ... ]

>  struct hw_atl2_priv {
> +	struct hw_atl2_l3_filter l3_v4_filters[HW_ATL2_RPF_L3L4_FILTERS];
> +	struct hw_atl2_l3_filter l3_v6_filters[HW_ATL2_RPF_L3L4_FILTERS];
> +	struct hw_atl2_l4_filter l4_filters[HW_ATL2_RPF_L3L4_FILTERS];
> +	struct hw_atl2_l3l4_filter l3l4_filters[HW_ATL2_RPF_L3L4_FILTERS];
> +	struct hw_atl2_tag_policy etype_policy[HW_ATL2_RPF_ETYPE_FILTERS];
>  	struct statistics_s last_stats;
>  	unsigned int art_base_index;
> +	unsigned int art_count;
> +	unsigned int l2_filters_base_index;
> +	unsigned int l2_filter_count;
> +	unsigned int etype_filter_base_index;
> +	unsigned int etype_filter_count;
> +	unsigned int etype_filter_tag_top;
> +	unsigned int vlan_filter_base_index;
> +	unsigned int vlan_filter_count;
> +	unsigned int l3_v4_filter_base_index;
> +	unsigned int l3_v4_filter_count;
> +	unsigned int l3_v6_filter_base_index;
> +	unsigned int l3_v6_filter_count;
> +	unsigned int l4_filter_base_index;
> +	unsigned int l4_filter_count;
>  };

The backing arrays l3_v4_filters[], l3_v6_filters[], l4_filters[] and
etype_policy[] are fixed-size (HW_ATL2_RPF_L3L4_FILTERS == 8, and
HW_ATL2_RPF_ETYPE_FILTERS == 16), but the *_count and *_base_index
fields are populated from firmware below.  See the next comment in
hw_atl2_utils_get_filter_caps() about validation.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.c
> index 0fe6257d9c08..ffd723dcfb63 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.c
> @@ -128,3 +128,36 @@ int hw_atl2_utils_soft_reset(struct aq_hw_s *self)
>  err_exit:
>  	return err;
>  }
> +
> +static const u32 hw_atl2_utils_hw_mac_regs[] = {
> +	0x00005580U, 0x00005590U, 0x000055B0U, 0x000055B4U,

[ ... array of 72 entries ... ]

> +	0x00007CD0U, 0x00007CD4U, 0x00007CD8U, 0x00007CDCU,
> +};
> +
> +int hw_atl2_utils_hw_get_regs(struct aq_hw_s *self,
> +			      const struct aq_hw_caps_s *aq_hw_caps,
> +			      u32 *regs_buff)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < aq_hw_caps->mac_regs_count; i++)
> +		regs_buff[i] = aq_hw_read_reg(self,
> +					      hw_atl2_utils_hw_mac_regs[i]);
> +	return 0;
> +}

This isn't a bug today, since hw_atl2_caps_aqc113.mac_regs_count is 72
and hw_atl2_utils_hw_mac_regs[] has 72 entries, but would a
BUILD_BUG_ON() or a runtime min_t() tying the loop bound to
ARRAY_SIZE(hw_atl2_utils_hw_mac_regs) be worth adding?  If a future
variant bumps mac_regs_count without updating the table, the loop
would read past the rodata array and issue readl() on unintended
register offsets.

Also, hw_atl2_utils_hw_get_regs() only ever returns 0.  Does it need
to be declared as returning int, or could it be void?

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
> index 7370e3f76b62..546b48f897d3 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c

[ ... ]

> @@ -606,6 +610,54 @@ u32 hw_atl2_utils_get_fw_version(struct aq_hw_s *self)
>  	       version.bundle.build;
>  }
>  
> +int hw_atl2_utils_get_filter_caps(struct aq_hw_s *self)
> +{
> +	struct hw_atl2_priv *priv = self->priv;
> +	struct filter_caps_s filter_caps;
> +	u32 tag_top;
> +	int err;
> +
> +	err = hw_atl2_shared_buffer_read_safe(self, filter_caps, &filter_caps);
> +	if (err)
> +		return err;
> +
> +	priv->art_base_index = filter_caps.rslv_tbl_base_index * 8;
> +	priv->art_count = filter_caps.rslv_tbl_count * 8;
> +	if (priv->art_count == 0)
> +		priv->art_count = 128;
> +	priv->l2_filters_base_index = filter_caps.l2_filters_base_index;
> +	priv->l2_filter_count = filter_caps.l2_filter_count;
> +	priv->etype_filter_base_index = filter_caps.ethertype_filter_base_index;
> +	priv->etype_filter_count = filter_caps.ethertype_filter_count;

Should priv->l2_filter_count and priv->etype_filter_count also be
clamped against their backing arrays the way the v4/L4 paths below
are?  The etype_policy[] array is sized HW_ATL2_RPF_ETYPE_FILTERS
(16), and the base indices are accepted verbatim from firmware
without any check that base_index + count stays within the array.

> +	priv->etype_filter_tag_top =
> +		(priv->etype_filter_count >= HW_ATL2_RPF_ETYPE_TAGS) ?
> +		 (HW_ATL2_RPF_ETYPE_TAGS) : (HW_ATL2_RPF_ETYPE_TAGS >> 1);
> +	priv->vlan_filter_base_index = filter_caps.vlan_filter_base_index;
> +	/* 0 - no tag, 1 - reserved for vlan-filter-offload filters */
> +	tag_top =
> +		  (filter_caps.vlan_filter_count == HW_ATL2_RPF_VLAN_FILTERS) ?
> +		  (HW_ATL2_RPF_VLAN_FILTERS - 2) :
> +		  (HW_ATL2_RPF_VLAN_FILTERS / 2 - 2);
> +
> +	if (filter_caps.vlan_filter_count > 2)
> +		priv->vlan_filter_count = min_t(u32,
> +						filter_caps.vlan_filter_count - 2,
> +						tag_top);
> +	else
> +		priv->vlan_filter_count = 0;
> +
> +	priv->l3_v4_filter_base_index = filter_caps.l3_ip4_filter_base_index;
> +	priv->l3_v4_filter_count = min_t(u32, filter_caps.l3_ip4_filter_count,
> +					 HW_ATL2_RPF_L3V4_FILTERS - 1);
> +	priv->l3_v6_filter_base_index = filter_caps.l3_ip6_filter_base_index;
> +	priv->l3_v6_filter_count = filter_caps.l3_ip6_filter_count;

Can priv->l3_v6_filter_count overflow l3_v6_filters[]?  The l3_v4 and
l4 counts just above/below are clamped:

    priv->l3_v4_filter_count = min_t(u32, filter_caps.l3_ip4_filter_count,
                                     HW_ATL2_RPF_L3V4_FILTERS - 1);
    ...
    priv->l4_filter_count = min_t(u32, filter_caps.l4_filter_count,
                                  HW_ATL2_RPF_L4_FILTERS - 1);

but l3_v6_filter_count takes filter_caps.l3_ip6_filter_count directly.
The backing array is

    struct hw_atl2_l3_filter l3_v6_filters[HW_ATL2_RPF_L3L4_FILTERS];

and HW_ATL2_RPF_L3L4_FILTERS is 8.  The l3_ip6_filter_count field in
struct filter_caps_s is wider than 3 bits, so the firmware can report
a count above 8.

The consumer added in the follow-up patch in this series then walks
priv->l3_v6_filters[] using the unclamped count:

    first = priv->l3_v6_filter_base_index;
    last  = priv->l3_v6_filter_base_index + priv->l3_v6_filter_count;
    for (i = first; i < last; i++)
        if (hw_atl2_rxf_l3_is_equal(&l3_filters[i], l3))
            return i;

and hw_atl2_rxf_l3_get() writes through &l3_filters[idx]
(l3->usage++, l3->cmd = ...).  If firmware reports an oversized
l3_ip6_filter_count, or any non-zero base_index that pushes the
window past slot 7, doesn't this read and write past
priv->l3_v6_filters[] into the adjacent priv fields?

The same question applies to priv->l3_v4_filter_base_index and
priv->l3_v6_filter_base_index — they are stored verbatim from
firmware with no check that base_index + count stays within the
corresponding backing array.  Would it make sense to validate the
full window for every filter category?

> +	priv->l4_filter_base_index = filter_caps.l4_filter_base_index;
> +	priv->l4_filter_count = min_t(u32, filter_caps.l4_filter_count,
> +				      HW_ATL2_RPF_L4_FILTERS - 1);
> +
> +	return 0;
> +}
-- 
This is an AI-generated review.


