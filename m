Return-Path: <netdev+bounces-303554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GYdABpTgRGoC2goAu9opvQ
	(envelope-from <netdev+bounces-303554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 11:40:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8026EBAC5
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 11:40:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=hXKLDF1Q;
	dkim=pass header.d=redhat.com header.s=google header.b="QcAQB/6N";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303554-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303554-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97B263048933
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 09:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71123F482D;
	Wed,  1 Jul 2026 09:39:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B433A1A3F
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 09:39:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898761; cv=none; b=WL10Vtzq8VJrf5oyfRD3GiJXoxp5hubzhflDvwPYit+Vf00QJHu6n/YXt4qkta4r7cGvYcYD5gj2OU48YerRtzGwCFopOdM9fpY1FKUsSsikfoLqOhDWkmmw398Qh4uPFSzRe8M+6KJLpbJZJGPlsrEPs4OTwwlTIQk4Jp/aGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898761; c=relaxed/simple;
	bh=b2W3DwZRfD5JATV8cRVSobXYTOoBBA9FTUIiQPy8xVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jyf8Wl1F0TIHKLMMEKcrz3C4n2w3ITZLO6sNDNrlSMYmWiKJK2lmXAmaN5oK2Rjh/bGnDSelnW6iRWZQhZYQKR0z3tJnWcdYq2Zuje6SPBMcdQeXXnuoT2HmYUUm1UtMJ9VdmPNT042rfwIy26PLUHvgyd6BGjlDvez9Z81wSW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXKLDF1Q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcAQB/6N; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782898759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UsmnL53bdoWENsxk2WAeV5ns8uuB8IT32cQO3WodAQY=;
	b=hXKLDF1QvqCmnt9v9KSJVEs54LecBC2U02JvHSW8TZBEc4Ps6TTlSw0fLndcq3VhqDOQ6I
	Le7GymfCBXFHH45pUjBefcLy0bfXF1kPnkvmq31xbIHhjgvY9pBl7Vf/wt7442EA9TooW9
	fszNsRlk+7oYkfRi/GMaHm5Ojpnm/3I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-pv28DKZOP8C22QTQdVv12w-1; Wed, 01 Jul 2026 05:39:18 -0400
X-MC-Unique: pv28DKZOP8C22QTQdVv12w-1
X-Mimecast-MFC-AGG-ID: pv28DKZOP8C22QTQdVv12w_1782898757
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-475e540a0ffso286207f8f.3
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 02:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782898757; x=1783503557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UsmnL53bdoWENsxk2WAeV5ns8uuB8IT32cQO3WodAQY=;
        b=QcAQB/6NkCaeUiLSnuRHF8jg4//tUWW5bWB2Njxbb5l1y7FsrduTCkdoxyfaXxjefr
         qBq8ZaJRKhGmyIaW/stDpQQrzquRMY4H6c/NHLGob7ZSuefgO0pKjcw5UKhD8s5XO3eb
         fTktNaxhc7y2C3oKvWjmqajIwAxOD5UoAJi6ht32CWHzaRCzfLgvAZ1t+0+Dmv8d3854
         XYm6mZqfxxUxu0xsWQD3AFtbN1Z6Zzek56JZdNxz5KmIEjQQxC4Jz4IZSH3oLBk16wP9
         37QqFMgf6VHMNGCdJa05eq7nEd8ji8ifLQtu2EEvxmmdrdikMyaMWmoInq9gwR8e+K2c
         StSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782898757; x=1783503557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsmnL53bdoWENsxk2WAeV5ns8uuB8IT32cQO3WodAQY=;
        b=nYQ1HlOwFaOlPrjvnmPA5knVHPsVwcJRnHNATuUCXi9TbIxh7rcMXIIBtL86swKYbP
         bvDfTFtBSDWbgK2R59q5VRkxjN6tZJyYGhBuN3eYJJA/SEaFspxh/TN6fOxpIT3+jRHw
         oX7nC6UBi7XUzgh9CZP53AMBFhjHdzRLDVra7hsZJPwFJD8UVFuFwX02raxhZg960snF
         LL0eMbgsfhQmRAShJA7e2T+6XdceLhwJTT2jyvXHI7SdvfY6mbSOub0kBpKa2Hbe4zco
         4mOWQnQp3cpJmv09aW9+juTBVibRQUCX3/qHPwmlzoc0m/U02DWG9FXQK44crE/Whomp
         n4cw==
X-Gm-Message-State: AOJu0Yyo+NeaZ0o2j2RXKefJOBAlI+avYYb+o30HM5pzrPtTIUWqhJ75
	2T27gCvp1mRCiWLH7ymOhE3OjTHUh6+g/t0ubCsi/IUBb+QDJfXLN5zmpmQovBEV/9DHNaAkGfg
	94yqvwkq9aNnlMtwdTTb3M3tpyi4IN8UlCEN6jEpgIFoP3a/eHt55G0+zJg==
X-Gm-Gg: AfdE7cn8ca6IEjOWlqVp6bb6h6APlOefcLema+wMtHyrD/A0GSCgj37GXvg22L/CQE6
	Tm6BPUzg4zEopVyxpewBFYWWGMqnbcd4mZ1h0J44+Nc7tmw/LEzYCZLgw+LudfNNuJ+jD1JLXmX
	pN2XSUCTa0SzKbqKRkUjQ3XQn3qW6O4X/FE6sS4LNIdhBtQDpphQshLduYd5nZTAO1gzufIISFn
	z2fxzeyXEqB2MYr/0nwpvxoT5ezCKmSdd9KTY4QmzU6KGOzc2tvi62g5JXG0gWn5ePlTu+Oi6cK
	x1DW0QRkw5hcXPSDiqIw05zf3sIJZCgLIjDDqoMmBQr1HZzrbW7FDkbEZbw6s/MP6gpiwrn+RJK
	i/PtNtgHemWowbHVjjPIHYana
X-Received: by 2002:a05:6000:29d7:b0:473:a74d:34d7 with SMTP id ffacd0b85a97d-47757f4d0b8mr1100274f8f.2.1782898757021;
        Wed, 01 Jul 2026 02:39:17 -0700 (PDT)
X-Received: by 2002:a05:6000:29d7:b0:473:a74d:34d7 with SMTP id ffacd0b85a97d-47757f4d0b8mr1100244f8f.2.1782898756540;
        Wed, 01 Jul 2026 02:39:16 -0700 (PDT)
Received: from fedora.redhat.com ([216.128.14.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4cdesm16547001f8f.13.2026.07.01.02.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:39:16 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH iwl-next v2 1/2] i40e: move ATR sample rate from ring to PF level
Date: Wed,  1 Jul 2026 12:38:29 +0300
Message-ID: <20260701093830.948756-1-mheib@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303554-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mheib@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:mheib@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mheib@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC8026EBAC5

From: Mohammad Heib <mheib@redhat.com>

The ATR sample rate is currently stored per-ring and initialized when each
TX ring is configured. Since the sample rate is a global policy that
applies uniformly across all rings, it makes more sense to store it at
the PF level.

Move atr_sample_rate from struct i40e_ring to struct i40e_pf and initialize
it once during i40e_sw_init(). Update i40e_atr() to reference the PF-level
field. Change atr_count from u8 to u32 to match the sample rate type.

Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h | 3 +--
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 1b6a8fbaa648..88eb40ee45f0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -487,6 +487,7 @@ struct i40e_pf {
 	u16 rss_size_max;          /* HW defined max RSS queues */
 	u16 fdir_pf_filter_count;  /* num of guaranteed filters for this PF */
 	u16 num_alloc_vsi;         /* num VSIs this driver supports */
+	u32 atr_sample_rate;
 	bool wol_en;
 
 	struct hlist_head fdir_filter_list;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1fb86bd1af8e..3834af6c09be 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3457,12 +3457,7 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
 		ring->xsk_pool = i40e_xsk_pool(ring);
 
 	/* some ATR related tx ring init */
-	if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags)) {
-		ring->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
-		ring->atr_count = 0;
-	} else {
-		ring->atr_sample_rate = 0;
-	}
+	ring->atr_count = 0;
 
 	/* configure XPS */
 	i40e_config_xps_tx_ring(ring);
@@ -12745,6 +12740,8 @@ static int i40e_sw_init(struct i40e_pf *pf)
 		}
 	}
 
+	pf->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
+
 	if ((pf->hw.func_caps.fd_filters_guaranteed > 0) ||
 	    (pf->hw.func_caps.fd_filters_best_effort > 0)) {
 		set_bit(I40E_FLAG_FD_ATR_ENA, pf->flags);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 61525ab7d21e..da94cb2ce94d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2882,7 +2882,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		return;
 
 	/* if sampling is disabled do nothing */
-	if (!tx_ring->atr_sample_rate)
+	if (!pf->atr_sample_rate)
 		return;
 
 	/* Currently only IPv4/IPv6 with TCP is supported */
@@ -2934,7 +2934,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	if (!th->fin &&
 	    !th->syn &&
 	    !th->rst &&
-	    (tx_ring->atr_count < tx_ring->atr_sample_rate))
+	    (tx_ring->atr_count < pf->atr_sample_rate))
 		return;
 
 	tx_ring->atr_count = 0;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index bb741ff3e5f2..be587f804e7a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -372,8 +372,7 @@ struct i40e_ring {
 	u16 next_to_clean;
 	u16 xdp_tx_active;
 
-	u8 atr_sample_rate;
-	u8 atr_count;
+	u32 atr_count;
 
 	bool ring_active;		/* is ring online or not */
 	bool arm_wb;		/* do something to arm write back */
-- 
2.53.0


