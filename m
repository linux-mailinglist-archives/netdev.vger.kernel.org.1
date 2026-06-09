Return-Path: <netdev+bounces-297349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bw5UHT2hKGrVGwMAu9opvQ
	(envelope-from <netdev+bounces-297349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:26:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 70421664C71
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:26:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=MSksUcZ+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297349-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297349-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52581300BCA4
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 23:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C393EAC86;
	Tue,  9 Jun 2026 23:26:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC8554654
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 23:26:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781047607; cv=none; b=sreLnad51hBRyw6zM2ffnB3WVFW7p5+xpS/v1VYAaT/m4VlOf5/1LDTtHbRNJBDyis66sj4cWzCYWQHob9/91ECU7N7Xny8phTMO+H0VntKBatuyifoH0vLXTfeX7nYe4KeWnwa1eq8YsZZ/Qrwa6L1TLKYCxk1KT3IOthlJQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781047607; c=relaxed/simple;
	bh=VD7dY7vSDCEpcauIsd4v/+QlmpscfEX+f4uoEaVEBx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQMEwMykLXaT09kOgWn24+ZLvIuxketcUrpb1+oP4sz1zg6xL6S+yB2k3+f3w3MK5ld/4312il9j8f0tkq/CbaBDCUnEg97tjXvBsS2xVSomKQ0AsJzT73VIBjvOP7mEi/3rNUysEpt3fA9k4lwEN7rW/2cZSeeV8qhKum3+YjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=MSksUcZ+; arc=none smtp.client-ip=209.85.219.45
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ccef9eabccso68380386d6.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 16:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781047606; x=1781652406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8FSs80YlaqSNhhsNPLd7CnSfhWZyco7BKdP2zbQFlWQ=;
        b=MSksUcZ+PZEAuBmOpalC5eWjJvSxEJSghgKAysFplaIlBTBW+QUR6LBuExIOCGrKDD
         3N4OAg35eUMJPHJCBrDxNctSQwIGxvIxa7O+klniu+WPYWC3EkjN5CVDn/jHrH5tMcFN
         HwCq3r8wf4h6gucP++phPJxIpTG28CHwujMhjvpStRc1RfKi4ab6GGPyged6kGZQtBiI
         yWgJsQdTPuvJg/AYeaNBHOfTPPcPDO+qhq+sw5pwz/2Bk7usj8KQtqluyk9IB0nYEvHf
         jKYErypEuuT1p/cfbgH9EbfHJ3mTLAtplSnLKQYerG9ds/2rnqsG7CuFmG5F9TQz/nJB
         NMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781047606; x=1781652406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FSs80YlaqSNhhsNPLd7CnSfhWZyco7BKdP2zbQFlWQ=;
        b=Qzu3TF+CB/RJhbvErJFyCNCLj8A4XMXVvPhFPoEo2kst1RLaG4BElihBPtRA359ntT
         TFH4sgGn33CF8QLvMkZrHR2C5cCLqv3FxwkJ5bG1KRjpyd2Pqu4VCB01I84hHZxFVIoY
         wVoPACXNO0EscofVue4YUxKxvmoRurqgtWZ9SX/fml9yLhbNzJ66RziwDPFQn/Xhuusz
         pkG0tWGh3b/0TT2Kb7ZLb4AtXKW+JNevtKrE6dsCnbW3m9+H1BlcqpIZHqrYTGUJRog3
         ofXpeUYPDwRSasgBfjVzddAhwvC7A+raJuSg8cXyroAmTj3XSrpb02zmnG2py1k0Ih+/
         2D7g==
X-Forwarded-Encrypted: i=1; AFNElJ+yIQgmSL3MwQ/yBjE/EJXBiPC7ZDqbnLH5qgln5ytrBkDsL4trpCZdhYVlAte3ov0yQqeYFsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfGoTst8ZQRazNva9rHShUSayIiX0VzFwLQP5MLRTT0h22LeQz
	SwgS2XJdDIcGjGA3E8KqJdm8vaB1tKcJ1czeLxpaf0/CuMWJHdWguqDXczGo4KuQ5oo=
X-Gm-Gg: Acq92OG+4sWdfywHcvjBiouNvdfbgKSsaDyLALYFXvlJD5qQkDcufYVAwnA0jNSgmfx
	jlZowa6wwOdohoQ7KXapQCDaYU5V6NJdr3n97VEvEPF3feIALGaZ5Vr1tZ0uoup76P/C+FhzQMD
	YHs60zR+d0mAE1ttxnrKPNyoAONKKJ0lCd+mlTWP9Dn9F4BLAUKMeiWcj+zLnCrjpcaB1iIX1gw
	VkmDgSfC4in/73jorNEX11MD5BurBJ9+XgmpSz6NH+hhZMA5OPEKuLY5sbl0SG5Co2WBkOQBhkE
	g99fJyN02O9Ij7zxA6UwxRjpOlOgIQoG5tNzGNp3lTRdMSXxn6p+TQddD06isjPOUSJp+H2P+lC
	0Z8ShHnTpoTTT+GUucLdvlbb7jPOkHcuCx4AohI5Of18UXWPAjCTSLbN+cbaA3BVhusnJYXou4f
	I2zF8sJDZ41eppVAT0/6v/sZK8SGDW6jA3679j4w==
X-Received: by 2002:a05:6214:4a03:b0:8cc:e17:7d16 with SMTP id 6a1803df08f44-8cee8b0b68amr275892086d6.7.1781047605719;
        Tue, 09 Jun 2026 16:26:45 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8cecd055181sm215524426d6.30.2026.06.09.16.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 16:26:44 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>,
	Olga Albisser <olga@albisser.org>,
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] net/sched: dualpi2: clear stale classification on filter miss
Date: Tue,  9 Jun 2026 23:25:21 +0000
Message-ID: <20260609232521.1602334.0764789957e4.dualpi2-filter-no-match@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297349-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:sam.moelius@trailofbits.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:koen.de_schepper@nokia-bell-labs.com,m:chia-yu.chang@nokia-bell-labs.com,m:ij@kernel.org,m:olga@albisser.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trailofbits.com:dkim,trailofbits.com:email,trailofbits.com:mid,trailofbits.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70421664C71

DualPI2 leaves previous classification state attached to an skb when
filter classification returns no match.  The enqueue path can then act
on stale state from an earlier classification attempt.

A filter miss should fall back to the default path without reusing old
per-packet classification data.

Clear the classification result when the filter lookup does not match.

Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
Changes in v2:
  - Add fixes tag

 net/sched/sch_dualpi2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index a22489c14458..8d345a8ee4e9 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -378,6 +378,8 @@ static int dualpi2_skb_classify(struct dualpi2_sched_data *q,
 #endif
 		cb->classified = TC_H_MIN(res.classid) < __DUALPI2_C_MAX ?
 			TC_H_MIN(res.classid) : DUALPI2_C_CLASSIC;
+	} else {
+		cb->classified = DUALPI2_C_CLASSIC;
 	}
 	return NET_XMIT_SUCCESS;
 }
-- 
2.43.0


