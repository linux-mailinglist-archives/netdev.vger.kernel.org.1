Return-Path: <netdev+bounces-287044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD12ALn4AmqvzAEAu9opvQ
	(envelope-from <netdev+bounces-287044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:54:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9725F51E189
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8408B300AB3F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8844BCAC3;
	Tue, 12 May 2026 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAfDxPPN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8447349250D
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579637; cv=none; b=qqP1nDS0YWlmkVp2szy+8SBAPy8i86wClc0F2aJtpKE7rgTrxiLEM2bah3t4tJOVotsZkIFZ65Z2XUn7w1gNnZbI8ipcgHfcwNFn0GfAvDhI8xWKRzBkVPi1LUaT7FBRqr9Zh38HqSnd/+oO7SqnEGvaLuezpgsysNaRj8a7iFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579637; c=relaxed/simple;
	bh=q9UFIGH2TFyvxqrySWxohYUwuY3EZ77lFKUOAZJOgME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edbnCFkC8s0ozTHPSxDLlnI5FbZuV4UTUdR1Nx5fa0RTiHT/PcwnrdMdN1YG0Rkhp1PCQd56Kd5Km2hKzc1rQJ4336/Xm3KjtLsbuQOApICLYoS55pWEi2ykCghmOel+f4mp6GI/bc7zt6i+dRTdh8bFp10ZvF7cTVIEcYvinBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WAfDxPPN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778579634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+wQWXx5MVHKxpx3NSTHnfj/VmgVwD/333uvQQPjns28=;
	b=WAfDxPPNZ8JKpoWKhhQRmIPAtDrPs6KozPpjL+QpnDf+Kps2hL63qxVu7XWWwt+KW6YrZr
	h9L5z3rggdLpPNZdzh0qxXZhZXH0pixXD1skt48m9IWslDtk1BnaeL9SURDap5+pLMqSOG
	jqh7Phko0Pc9cYFaUoekG4S8JM6HHeI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-x1yydIMMOvqUfzjcilPG6Q-1; Tue,
 12 May 2026 05:53:50 -0400
X-MC-Unique: x1yydIMMOvqUfzjcilPG6Q-1
X-Mimecast-MFC-AGG-ID: x1yydIMMOvqUfzjcilPG6Q_1778579629
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4FF9180034C;
	Tue, 12 May 2026 09:53:48 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.142])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5224418004A3;
	Tue, 12 May 2026 09:53:45 +0000 (UTC)
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
Subject: Re: [PATCH net-next 2/9] net: atlantic: move active_ipv4/ipv6 bitmap updates after HW write updates after HW write
Date: Tue, 12 May 2026 11:53:31 +0200
Message-ID: <20260512095339.134878-1-pabeni@redhat.com>
In-Reply-To: <20260506135706.2834-3-sukhdeeps@marvell.com>
References: <20260506135706.2834-3-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 9725F51E189
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-287044-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: atlantic: move active_ipv4/ipv6 bitmap updates after HW write updates after HW write

This change moves the active_ipv4/active_ipv6 bitmap updates out of
aq_set_data_fl3l4() and into aq_add_del_fl3l4() after the HW write, and
removes the bitmap manipulation from aq_nic_reserve_filter() and
aq_nic_release_filter().

> net: atlantic: move active_ipv4/ipv6 bitmap updates after HW write updates after HW write

The subject line repeats "updates after HW write" twice.  Was this
intended, or should it read "net: atlantic: move active_ipv4/ipv6 bitmap
updates after HW write"?

A few other subjects in this series look like they have the same
copy-paste pattern (for example "masking and IPv6 handling masking and
IPv6 handling", "driver internals driver internals", "TX path setup TX
path setup", "(Antigua) (Antigua)") and may want the same cleanup.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> index ef9447810071..3cec853e9fad 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> @@ -1522,8 +1522,6 @@ u8 aq_nic_reserve_filter(struct aq_nic_s *self, enum aq_rx_filter_type type)
>  	case aq_rx_filter_l3l4:
>  		fltr_cnt = AQ_RX_LAST_LOC_FL3L4 - AQ_RX_FIRST_LOC_FL3L4;
>  		n_bit = fltr_cnt - self->aq_hw_rx_fltrs.fl3l4.reserved_count;
> -
> -		self->aq_hw_rx_fltrs.fl3l4.active_ipv4 |= BIT(n_bit);
>  		self->aq_hw_rx_fltrs.fl3l4.reserved_count++;
>  		location = n_bit;
>  		break;

Could dropping the active_ipv4 update here regress PTP's IPv4/IPv6
collision protection?

The PTP path calls aq_nic_reserve_filter(aq_rx_filter_l3l4) from
aq_ptp_init() to grab a single L3L4 slot, and then programs its IPv4 UDP
filter by calling hw_ops->hw_filter_l3l4_set() directly from
aq_ptp_hwtstamp_config_set() / aq_ptp_prepare_filters() — it never goes
through aq_add_del_fl3l4() where the new bitmap update now lives.

Before this change, aq_nic_reserve_filter() set:

    self->aq_hw_rx_fltrs.fl3l4.active_ipv4 |= BIT(n_bit);

which caused aq_check_approve_fl3l4() to reject any later IPv6 L3L4 rule,
protecting PTP's reserved slot.

After this change, active_ipv4 stays zero while PTP is actively filtering
IPv4 in hardware.  Can a user now add an IPv6 L3L4 rule at
AQ_RX_FIRST_LOC_FL3L4 + 4 (still within AQ_RX_LAST_LOC_FL3L4) and have
the IPv6 filter program HW slots 4..7, silently overwriting PTP's IPv4
filter at HW slot 7?

I looked through the rest of the series including the AQC113 PTP patches
(aq_ptp_dpath_enable / aq_ptp_add_a2_filter) and they also call
hw_filter_l3l4_set() directly rather than going through
aq_add_del_fl3l4(), so the reserved PTP slot does not get re-reflected
into active_ipv4 by a later patch.

> @@ -1543,7 +1541,6 @@ void aq_nic_release_filter(struct aq_nic_s *self, enum aq_rx_filter_type type,
>  		break;
>  	case aq_rx_filter_l3l4:
>  		self->aq_hw_rx_fltrs.fl3l4.reserved_count--;
> -		self->aq_hw_rx_fltrs.fl3l4.active_ipv4 &= ~BIT(location);
>  		break;

Would it be worth keeping these updates (or adding equivalent ones on the
PTP reserve/release path) so that aq_check_approve_fl3l4() continues to
see PTP's reserved slot as active_ipv4?
-- 
This is an AI-generated review.


