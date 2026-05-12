Return-Path: <netdev+bounces-287048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAg0Fxz5AmokzQEAu9opvQ
	(envelope-from <netdev+bounces-287048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:55:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 667AB51E1E6
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C60B301FB02
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666A34C042A;
	Tue, 12 May 2026 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8YHLkyw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1DC4C0436
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579668; cv=none; b=olFwiO6kF4YuuSaubV4xT93TxEOeJW9Yxl2QMXx/YQVhtyos8rxjs8qwEIHr2ALMAxXAS/0yg4qSyooUsbXgxafeJCujOmVgSB1kIUmZ8QDQoE/hq9TR0KMRAxzk8FFq45zIzAcRFpBNeoPxZvU1hVDOipCkbQuc4SfhKY78YNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579668; c=relaxed/simple;
	bh=pFN1JmXkNbFQZJ1AElA5ANTMrKdb3kre5VHAM4tfR8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hm1NrL4241Oz1wU//2PlHLyy3RW0I/w6kLrLhcYu0Smabp70rGCOGgDvsj6r5QurJszy7K/kxnUPXvMV6psMYXwuwiUPG3LuNs8EqoZoQIEkgE0miCdNKD4/yXCn4toS+n/CWpsOesvWwRS8HJBaBenz9hL2jmbwpNek0riLg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8YHLkyw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778579666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bghJSs73+jOMvM+1mhx5O7OptVOoMLWKhKrrzmyK3Do=;
	b=e8YHLkywWvgXM3CcgxJGzcpryxWenbIhTlEzvAtC1PhPSXPu4FR7NoWyTPqpKVdkjfh3q/
	xEw2YhqzKAiqiLSb+xbTBO4PD/j/dzWYlKVVF272aXnpC7o+xE9xhWW15r9wGt119xgfP9
	yNWeETFQf90r9uV5sl/ZsoP7iQ9+mMg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-xK9ej_xBO0yfom8wlXR4-g-1; Tue,
 12 May 2026 05:54:22 -0400
X-MC-Unique: xK9ej_xBO0yfom8wlXR4-g-1
X-Mimecast-MFC-AGG-ID: xK9ej_xBO0yfom8wlXR4-g_1778579660
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35A7918005BE;
	Tue, 12 May 2026 09:54:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.142])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E11C9180058F;
	Tue, 12 May 2026 09:54:16 +0000 (UTC)
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
Subject: Re: [PATCH net-next 7/9] net: atlantic: add AQC113 PTP traffic class and TX path setup TX path setup
Date: Tue, 12 May 2026 11:54:11 +0200
Message-ID: <20260512095411.134924-1-pabeni@redhat.com>
In-Reply-To: <20260506135706.2834-8-sukhdeeps@marvell.com>
References: <20260506135706.2834-8-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 667AB51E1E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-287048-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Action: no action

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: atlantic: add AQC113 PTP traffic class and TX path setup TX path setup

Reserves PTP TX/RX buffer space, configures the PTP traffic class
with no flow control and highest priority, enables multicast frame
tagging for ART-based PTP steering, and bumps TX read-request limits
when the PCIe extended-tag bit is already set.

> net: atlantic: add AQC113 PTP traffic class and TX path setup TX path setup

The subject contains the phrase "TX path setup" twice. Is that
intentional?

The patch also bundles several unrelated changes into a single commit:
PTP TC buffer reservation, an unconditional accept-all-multicast
enable, PCIe-extended-tag-gated TX read-request limit bumps, and a
non-functional RSS refactor. Would it be reasonable to split these
into separate commits so each can be reviewed, tested, and bisected
independently?

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> index e58bfff38670..c71e8d1adfc9 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c

[ ... ]

> @@ -415,9 +441,20 @@ static int hw_atl2_hw_init_tx_path(struct aq_hw_s *self)
>  
>  	hw_atl2_tpb_tx_buf_clk_gate_en_set(self, 0U);
>  
> +	if (hw_atl2_phi_ext_tag_get(self)) {
> +		hw_atl2_tdm_tx_data_read_req_limit_set(self, 0x7F);
> +		hw_atl2_tdm_tx_desc_read_req_limit_set(self, 0x0F);
> +	}
> +
>  	return aq_hw_err_from_flags(self);
>  }

The commit message says:

    Enable extended PCIe tag mode (32-255) when hardware supports it,
    with increased TX data and descriptor read request limits for
    improved throughput.

Does the code actually enable extended PCIe tag mode? The call here is
hw_atl2_phi_ext_tag_get(), a read accessor via aq_hw_read_reg_bit().
The corresponding setter hw_atl2_phi_ext_tag_set() exists in
hw_atl2_llh.c but does not appear to be invoked in this patch or
elsewhere. The code path only raises the TX read-request limits when
the bit is already set by firmware/BIOS. Should the commit message be
reworded to reflect that behavior?

>  
> +/* Initialise new rx filters
> + * L2 promisc OFF
> + * VLAN promisc OFF
> + *
> + * User priority to TC
> + */
>  static void hw_atl2_hw_init_new_rx_filters(struct aq_hw_s *self)
>  {
>  	u8 *prio_tc_map = self->aq_nic_cfg->prio_tc_map;
> @@ -429,6 +466,9 @@ static void hw_atl2_hw_init_new_rx_filters(struct aq_hw_s *self)
>  	u8 index;
>  	int i;
>  
> +	/* tag MC frames always */
> +	hw_atl_rpfl2_accept_all_mc_packets_set(self, 1);
> +

Is the "tag MC frames always" intent actually durable?

The same hardware bit is rewritten unconditionally by the packet
filter path. In hw_atl_b0_hw_packet_filter_set() (shared by atl2
through hw_atl_b0.c):

    hw_atl_rpfl2_accept_all_mc_packets_set(self,
                          IS_FILTER_ENABLED(IFF_ALLMULTI) &&
                          IS_FILTER_ENABLED(IFF_MULTICAST));

ndo_set_rx_mode runs as part of normal interface bring-up and on every
multicast-list change, so the init-time write to 1 would be cleared to
0 for any interface not in allmulticast mode. Does this mean the ART
cannot match PTP multicast traffic once rx_mode has been programmed,
which is the commit's stated purpose of this write?

If the intent is to keep the bit set whenever PTP is enabled, should
the packet-filter path OR in cfg->is_ptp, rather than (or in addition
to) writing the bit once at init?

The write is also not gated by cfg->is_ptp. While it is briefly in
effect, does enabling accept_all_mc change multicast filtering
behavior for non-PTP users in a way that needs justification in the
commit log?

[ ... ]
-- 
This is an AI-generated review.


