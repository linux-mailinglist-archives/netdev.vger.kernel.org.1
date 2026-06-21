Return-Path: <netdev+bounces-300878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iSb9EJzfN2rzUwcAu9opvQ
	(envelope-from <netdev+bounces-300878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 14:57:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5AB6AAC7A
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 14:56:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=iuquq5aM;
	dkim=pass header.d=redhat.com header.s=google header.b="rZ9ze/Dt";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300878-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300878-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48376300C5AF
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 12:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCA0366074;
	Sun, 21 Jun 2026 12:56:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308403659FB
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 12:56:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782046617; cv=none; b=n2OmpwkN9WC0XqYSZgxXWAsmCG++54LNNy7ZdDZqx66epYsg1nUTIdYmKuQcBmMXtczPZujWMeP7LhLhx3Cq7bAsRcouFPtNe4MEAEeV8GSbg7IJbaFIOtodjHVGspWAsmh/diYChUHtRK4SI9DGww7PKmDGy/FGdb5PGIuCukY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782046617; c=relaxed/simple;
	bh=4mdoIS+PRXU7Yw2Z47tyvR7+inQFCTHWKWgY+rf4kRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I1Ygx52EYIYd8netO3FMqS/jYChOdXKLfXu65mDoalYXRtdkF3IzFhQBdU8OsJE6wsUyWpMjvRmGpY4whDJQUnZrXD8GDgFtDPhYhX5zGirmu5dDK49gxev4WXkSn6noVZ5eC6ASBJepOR7kZ6kNavkcalhIpeo5Fxv9LhsiMpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iuquq5aM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rZ9ze/Dt; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782046615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OzuDjTBVZnVblzhpPthtqKRuK4UuaGylmLKeDqO4kyA=;
	b=iuquq5aMHVCX35lPKogj3SlB892l9jx0+D8sQpLEnbyoxDnPzPy8CYA20h3hVhpdAZytIR
	PKm5rNRyxMmRMe3G8IVoTD9XTnHoK+tMGemiNaBRb3WYVtYvircQt3MFvighwn1yfWtEVE
	W8vEFqZmwu02F7Vztwqkbu4eVR8iMrU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-csUwN6CmMf2vwzlgUPPTHw-1; Sun, 21 Jun 2026 08:56:54 -0400
X-MC-Unique: csUwN6CmMf2vwzlgUPPTHw-1
X-Mimecast-MFC-AGG-ID: csUwN6CmMf2vwzlgUPPTHw_1782046613
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-462c1cf9003so3241111f8f.1
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 05:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782046613; x=1782651413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OzuDjTBVZnVblzhpPthtqKRuK4UuaGylmLKeDqO4kyA=;
        b=rZ9ze/DtBUZCvaE6ELvW+hAAmONRPdnbW1wnCM0g/BzlnMD9YAqZOOvRquXwrdXeLK
         A5rxUjxaZzlR0sExxocKAxpMO2tJE1VemoAFqNpSzvymNKjUFztlEv/HEO3reHvGhI4p
         0D+BVAdl9VYczvPUUa7bUrydwvEOjiGO3K53B4NOYK2LvrZjJy6dpHMGlT91C5ROJ7Dw
         wkeHleqjQaotyv/xPC/c/0XG43kxIS6+PpAqQ9Z+8m7YhX4cLjqplASZAgoyhLIeVdEt
         aT/MzYrEKKftpr+q0G1ev5U3g2bSJRUBSLKa7RR2mRn+4pJK2aId9HoIBzSOr3+cFrjk
         IPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782046613; x=1782651413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzuDjTBVZnVblzhpPthtqKRuK4UuaGylmLKeDqO4kyA=;
        b=kyU5iP7UtfjHnQ5H1qXhnzEAOd8iJz0nMwkktS3IBnwXkWZwRiEIyNbGY0mpua7En+
         caZANCjuuKdWSTQtdymlVCUGZZfFrcBdrsm4KB3ih7ZJWSSdLKtllQsb0A/0SWWRtfEV
         1/VswhZfyFEDu4DejMPIhiumQXBlxum7e2rHNp9YZ0kl13O0ureBZVEg5OqoozZ69wDO
         ctsrTR9AqnyZy9nKnqxC5aZYd3eWt5ENVyE67HbMJ9f5DL2Sp52840swOXky5gxu7mg8
         A4vI8LgWZwZJ9DO8jQljtI82nxItwgeT8wNrF1+pOb9RdU3ff6Cuar/D6jiY0ox3WhFd
         RvCA==
X-Gm-Message-State: AOJu0YwyV8tdl5RkVAVV7TctJCXR/x5hT3WJlYFQqeo2dOPlfLfuutza
	A/5kLTDz22B1FDv+ZLAIJVDwfVgoNIGjvJ4Zf7ZNVX1BHUfy33BuuxVfoMg6csUlO2VauWOI8AB
	OAV1HyZRrX/YqEv8X4lFBFPAXJc6T1EMGqVNKqrOgS6RDl0jHsscUAI0/glSfA9E0/M9L
X-Gm-Gg: AfdE7ck7fVZ8os0gatf3oscVC9MUfbnMi/W9lKTpRM6jVSuYP+Hlt9VH8Qm+xxAePGc
	X8VmXekqRTyBceAN7sDeaMcuevh27GIIEZYskCGhHasn6mlMlGh7yoIAk4dqWqzLSHwxVrK0LW7
	x8zK1EtV0mxLqCCJK3oePp1wrz/F0/tfRTiapM22pM+JtswvKwhgtLiGdUGzTw2llazFPPEZpjk
	bdEghfQVaoCLEBvhCrqrbz9vosrb+qa2xaTyJN7ZalrM5KNt+mW/Vvjw7h3dTWsT2ldSELZxWqr
	BlLqD5ds0f5kPijdIwL/5NJsdsEs06VVQBtV3hLP/wGBFpzE7Ju6bTFnKlm8sc1sbQ62oxPtc+3
	6FpLDAbT59EvcYCifVuDyHpI=
X-Received: by 2002:a05:6000:461e:b0:464:b8d7:e5d8 with SMTP id ffacd0b85a97d-4656c69b646mr15818560f8f.14.1782046612801;
        Sun, 21 Jun 2026 05:56:52 -0700 (PDT)
X-Received: by 2002:a05:6000:461e:b0:464:b8d7:e5d8 with SMTP id ffacd0b85a97d-4656c69b646mr15818536f8f.14.1782046612468;
        Sun, 21 Jun 2026 05:56:52 -0700 (PDT)
Received: from fedora.redhat.com ([216.128.14.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c4f01sm17884258f8f.9.2026.06.21.05.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 05:56:51 -0700 (PDT)
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
Subject: [PATCH 1/2 net-next,v1] i40e: move ATR sample rate from ring to PF level
Date: Sun, 21 Jun 2026 15:56:43 +0300
Message-ID: <20260621125644.253844-1-mheib@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300878-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D5AB6AAC7A

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
index d59750c490f4..9695d160bc59 100644
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


