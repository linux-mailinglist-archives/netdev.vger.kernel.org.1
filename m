Return-Path: <netdev+bounces-301519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AuDSFtAZO2pmQggAu9opvQ
	(envelope-from <netdev+bounces-301519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 01:42:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AE36BA9BB
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 01:42:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bynar.io header.s=google header.b=DJOQipYY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301519-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301519-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bynar.io;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 773B3304C610
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 23:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9733CFF71;
	Tue, 23 Jun 2026 23:41:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28253CF68B
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 23:41:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782258114; cv=none; b=lFOOj7gBTb0ADl3eHBKaWLnh6SxgAWfY8AytvIt8FsNDUKOkrD3oFU/I5J3CTSf25MZHcd4WyvTbVc4op/QfetTAgy8jS70E0xRQodNsp0qNqJ+BWkC7GpYaNOu1+uM2z6trVe3gThwVNb8b2NLqHAzrWVTVr6/5Rqn1mI8m/lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782258114; c=relaxed/simple;
	bh=Q0OR99yi2KTeQqBV6zSKr/IxWlEosp13yzQoJ9jbwdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VSyokKnupnixF4kUyFca7x/HX0dNOLnqyiOF8wR9xtP5g2SMLhzOGhrEHqcaWpwX2beq8oTfVdJgH3P7eeevSTWYbBUxdP2muRWy2haCSefjshPCRBt3BZ6184lgSQ3Ol8SjT8gOLFJkLBjGYgaNxtzMgnbkKTSAp5Ab36hoYhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=DJOQipYY; arc=none smtp.client-ip=209.85.218.45
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c07d76ffd0fso45432266b.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 16:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782258111; x=1782862911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nOj4ZzoO0fd8cVdfzVSBt6Auoi0sws5oiKgIpomRCU4=;
        b=DJOQipYYly18FrthmR6swX7UcCIXFkKhPNgyr8wuWWtrU0FTBSihz3/JKOQUX6CaKB
         YoS+IBVSzHVPlvX1WSKpEEBJZhCHR0jA8d/Pr1r7z6ROc3ceT22WfgP60o0QAQPDubX+
         3Rwyg8NMQjDYIWxSjmCxYFF9w6QIk54CiWm1WB5SDAu3O+TQf8PW7fp9td9BlFEGqiMR
         8nYE2FaRHTeyp/Wswc57owlyUqUXqOx14e8AsWdRMzpZFUtf0b2VJMUCxtlQ+JJnsIqB
         shJiz+L5aVjm7tY3I/4w1nGrVQdLHPPDIbPNinmUHThlE3BzrtygJsXODtRbxz1XOBia
         mCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782258111; x=1782862911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOj4ZzoO0fd8cVdfzVSBt6Auoi0sws5oiKgIpomRCU4=;
        b=hOn0lfPAtwgF6maXTT9kOjsuFnygkrD8E/TN5/TbJF6y6JexlVTqLMFOiz2RED3rN5
         afFY7MJRW8/m9VQv685Ts8F1yuqPNnC0v96AYx0w4FGNo4THLd/wBDyFxi9cetHHgq3n
         3TpxtrgIpD5srafdWXJSSE1UYU7b0ycmF4gby90YWVUyUv7WlDnZueS5W/szPdxRKqF8
         ajxJNC+pbcTgF8bKKT047JMm+eiVhWt3Tilx7FvMGF2NA8zLfw3CQmc4WR/cwaFjxhH+
         Ak4sPiki5i4UaFXa/czCGHc5s559D3VMU82TKQnKRxkzqZinWWyMHs0w/4zNZHVK0Ys3
         12ew==
X-Forwarded-Encrypted: i=1; AFNElJ8w4s0zh32b1JrWb5HPhJM1WxCjAFJ9Ag6b2MSitvGJwuERJ6idrQHjqPlu62vn1UiqvThpTn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+l8ioN8M98ij83ji6CnIh+YqvbbFv0ApbucEd8zH3WEerYAI
	kOhhz0pUMUOtz0U6iAQDjJrKw+Y1JP5giWg/blcNQQHYpOgiSsw0aHPjEEL0L1BYCAwf
X-Gm-Gg: AfdE7cm3Wqz1A3D+tF+gwfxEJMKL8p+XoS3eHYq0GErbmrvuRnnRt/6O+D5dwMOc2+J
	s5LHL2LipNqWfZEqfh/1MohiPD9Cp4YexNl5Wzrn663JrMDpJDrBW/EIGuee6vx53TamdNqvqpT
	8l0OZ04cRO03fiCHQmDNTH6DPGLpgJ+SnDYbbmNeAuaSWtv/fSy+w2fgE0YSnRx/NUEFpgrJzJb
	7oMOgMH/PXYzOTJz3rBgeSC6Qc98I1oYG3e4Pqogc37WF1xdNlmUkXuHoc++nOo4mKlns/1Dzvx
	nd0LQyTuUb2VfIe5a27txnxY0xsNzaGMU/CFcMDBSgyYWHNonydHGpvBfTmDDnZqwA9u0tlbcuL
	CyvsRHuSa/RFBrIVROd8pSKlO61KdqpVcb4YP6ytZK3ShA16DJYKpwzKG5RQV6Pyv0NxPFFEG38
	37Jn6h/xYGvnE=
X-Received: by 2002:a17:907:3ea6:b0:c08:59dd:3fea with SMTP id a640c23a62f3a-c107efc1f64mr260781666b.27.1782258110366;
        Tue, 23 Jun 2026 16:41:50 -0700 (PDT)
Received: from localhost ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c61610bacsm591936366b.58.2026.06.23.16.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 16:41:50 -0700 (PDT)
From: Samuel Page <sam@bynar.io>
To: David Heidelberg <david@ixit.cz>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] nfc: nci: fix uninit-value in the RF discover/activated NTF handlers
Date: Wed, 24 Jun 2026 00:41:26 +0100
Message-ID: <20260623234126.214667-1-sam@bynar.io>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bynar.io,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bynar.io:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301519-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[bynar.io:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bynar.io:dkim,bynar.io:email,bynar.io:mid,bynar.io:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9AE36BA9BB

nci_rf_discover_ntf_packet() and nci_rf_intf_activated_ntf_packet() each
parse a notification into an on-stack struct (nci_rf_discover_ntf /
nci_rf_intf_activated_ntf) that is not initialised. The technology- and
activation-specific parameters are only extracted when the corresponding
length field is non-zero, so a notification that reports a zero length
leaves the relevant union uninitialised - and the handlers then read it:

 - discover: with rf_tech_specific_params_len == 0, nci_add_new_protocol()
   reads the uninitialised rf_tech_specific_params union (nfca_poll->
   nfcid1_len is used as a branch condition and a memcpy length) into
   ndev->targets;
 - activated: with rf_tech_specific_params_len == 0 the same union is read
   via nci_target_auto_activated(); with activation_params_len == 0 the
   activation_params union is read by nci_store_ats_nfc_iso_dep() into
   ndev->target_ats.

In each case the uninitialised bytes are subsequently exposed to user
space (NFC_CMD_GET_TARGET / NFC_ATTR_TARGET_ATS).

  BUG: KMSAN: uninit-value in nci_add_new_protocol+0x624/0x6c0
   nci_add_new_protocol+0x624/0x6c0
   nci_ntf_packet+0x25b2/0x3c30
   nci_rx_work+0x318/0x5d0
   process_scheduled_works+0x84b/0x17a0
   worker_thread+0xc10/0x11b0
   kthread+0x376/0x500
  Local variable ntf.i created at:
   nci_ntf_packet+0xbc2/0x3c30

Zero-initialise both on-stack notifications so the unions read back as
zero when the corresponding parameters are absent.

Fixes: 019c4fbaa790 ("NFC: Add NCI multiple targets support")
Fixes: e8c0dacd9836 ("NFC: Update names and structs to NCI spec 1.0 d18")
Link: https://lore.kernel.org/netdev/20260623172109.1105965-2-horms@kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
---
 net/nfc/nci/ntf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index c96512bb8653..274d9a4202c9 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -440,7 +440,7 @@ void nci_clear_target_list(struct nci_dev *ndev)
 static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
 				      const struct sk_buff *skb)
 {
-	struct nci_rf_discover_ntf ntf;
+	struct nci_rf_discover_ntf ntf = {};
 	const __u8 *data;
 	bool add_target = true;
 
@@ -688,7 +688,7 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 					    const struct sk_buff *skb)
 {
 	struct nci_conn_info *conn_info;
-	struct nci_rf_intf_activated_ntf ntf;
+	struct nci_rf_intf_activated_ntf ntf = {};
 	const __u8 *data;
 	int err = NCI_STATUS_OK;
 

base-commit: a986fde914d88af47eb78fd29c5d1af7952c3500
-- 
2.54.0


