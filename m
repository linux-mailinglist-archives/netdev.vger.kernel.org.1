Return-Path: <netdev+bounces-302419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t89uMkGPQWqbsAkAu9opvQ
	(envelope-from <netdev+bounces-302419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 23:16:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A7E6D4F64
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 23:16:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=R10uOHed;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302419-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302419-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19D22301186B
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 21:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E29372B41;
	Sun, 28 Jun 2026 21:16:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942692FA0C4
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 21:16:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782681400; cv=none; b=gGY8QIIhgpJU0tU4mQA4QwxTRhmlYa5pnuihssLZqsSJQtCmdRhxbPcqBHu3+jkBQokv4iF+5wSAhY/gsRDUtpHdomZREoiAQt+psp/SFG3UYgAoc52L7wnPoGkQOX9aaSk6wkYXhmFRQnexTDaFU4QnXxzDhUk2wl9x5akklio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782681400; c=relaxed/simple;
	bh=wq9vbsRd4z1aEUNzFLhJHF4nnkcAgJGHkCTxiXCvGUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JOpq23fkLZZr6U0wiqV9FrTE0hCjBO4znNt43GcKi+p4jt4KpCS9+dfebdhVD/hPpyDb5l1b7oh34Di6ACWgPkuk9ToOHed3KQI4NiKPCMVlXkwYxRuFP5BobJT8gLmWCBKKoq5+IOEpf3aTtIDn7jhFJqBKTvIsvdde2KG33j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R10uOHed; arc=none smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-37f816d01e3so1751298a91.2
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 14:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782681398; x=1783286198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=52R9zl6QfbAW5HIolSvFCYHUPFuJm6lr9c2cx/FRyQM=;
        b=R10uOHedbbWc/3cowbzQqANuxqvAgtfj+9QRkuKyRo3c7GMWy1/nidnwwTiWuad8cd
         50fKhXFDcZApx7di6vujkazXlndw5i/x6hl50OhFcWfLG3s/yNHf+AS7xC0OFMV8/KFJ
         5xHU0ErE8y+cEGBxr53NEOJ8IJpiTJKeRatzjKOjz9SOfMgbBux8zM801a/PnF2mghFr
         D8ke6mZYGVTBaAq28qjME2i5GC0PS6rAw3D0amH5z3EpwyGQdh5tNlm9hl+KXcQqiOJW
         jNEPOBE45OjlUPIcofFneYFjAOkRJPA4YjJcBSEQV2b8RuRE9et5cJptE/BPLJIGRGz3
         Enwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782681398; x=1783286198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52R9zl6QfbAW5HIolSvFCYHUPFuJm6lr9c2cx/FRyQM=;
        b=YwbaUo7J+rBs5PN4MgdlbPEToGAWoxKYBr2dPSaj1R255mpJappdZzNDeI4Wer7ZXZ
         S7nw278/Qv2ZPoHvMe/m3+TwH1X9YPAI/z4EHockaxm/fPOd5wdojY14sZleHGUL1DHy
         Pm4a0C7eA3wT299HEzjeYCS294Z/YWw33ObcEmU+UnbA2T8ScVljgRSoKSOnOaYCbOHD
         Fo6d6DxdEb7FCdfSBnYnpfM2QWQtvb0zrQiemFtN91tsxc9g22OQj+v4E7sfaqP+hPS6
         EXeCPz/IwIG5s5CCdmuhQ8rZHwPbnWGxT8lx2MQDPFcl98jKUzotytURlF+ztZvOaVH5
         /abQ==
X-Forwarded-Encrypted: i=1; AHgh+RrT8dmaUHsyoezOIEkm28ctTBC8w6AO3y7lV6IAyLBDfccC/LFlaGHfM3yvZi4CVHDyLDHDghk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXygbDCA0N6FNIBt9QMlElsbNn+rZZibF+jgk/0yIWp+Cn0w/1
	03VTtajFRZjR9EOVRPCHQJ66H6WE65cjBjBpgHbJVhQo2pj4g/M1OGCG
X-Gm-Gg: AfdE7cltB7blh6UeTsaI+/RmzWdNcUYzd24EhX2HgA0W/QTYlLJzxuK1M9WjkeyINZ4
	gLdg2zIO7JfHsiO92OJRUPZbgw3m7vhMj+zbO/2hGnUQa/hV8uNpswsCSPUGSzsvTsDjoNDsrAn
	uVb/8vB/8ZZY3r1gQkEFyeqQpBe9IgqR98j/IvU4fIMdV3C2ONW8M3RSCCYrZfQqRuaG8elCd5F
	VveprgfZxRP0KF2L2w4AWoVnklaEZ1wXJ+mqm+AUC69anDuAXrbLaq/Glpehsz9O6X5UYY9E5gD
	UXVe0Nhki3ucuaGqbMzRXUEcM2KAE7MSxTj2tsbNohzwUfxEV8giFOxWdb78q2A5DB56mwCONjj
	XMnLeAUAnK85sfdf3S29iBmXPSComyImpY28txt6T/LYE9/ytwGn658WzMv1hYwH3p4mewcerK3
	czdH5JjkSIXr7pxFZFPkokx/kW7ynaLY0e4tVUdaQm4MFYjbRAB+IF5MjkCCI6oA==
X-Received: by 2002:a17:90b:5548:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-37fed7e7f5emr2136383a91.14.1782681397840;
        Sun, 28 Jun 2026 14:16:37 -0700 (PDT)
Received: from node ([149.40.62.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37fd2bd0e49sm2403592a91.0.2026.06.28.14.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 14:16:36 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] nfc: nci: fix use of uninitialized memory in NFC-DEP general bytes
Date: Mon, 29 Jun 2026 02:16:27 +0500
Message-ID: <20260628211627.131617-1-meatuni001@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302419-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[meatuni001@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27A7E6D4F64

nci_store_general_bytes_nfc_dep() derives the length of the NFC-DEP
general bytes by subtracting the fixed general-bytes offset from the ATR
length:

  atr_res_len - NFC_ATR_RES_GT_OFFSET   (poll, offset 15)
  atr_req_len - NFC_ATR_REQ_GT_OFFSET   (listen, offset 14)

It never checks that the ATR is at least that long.  When a
RF_INTF_ACTIVATED_NTF reports an ATR shorter than the offset the
subtraction is negative; because min_t() casts its arguments to __u8 the
negative value becomes large and is then capped at
NFC_ATR_RES_GB_MAXSIZE / NFC_ATR_REQ_GB_MAXSIZE.  remote_gb_len is thus
set to up to 47/48 even though only atr_res_len/atr_req_len bytes of the
on-stack atr_res/atr_req buffer were copied from the packet, and the
following memcpy() reads the uninitialized remainder into
ndev->remote_gb.

Skip storing the general bytes (leaving remote_gb_len at 0) when the ATR
is shorter than the general-bytes offset.

Fixes: a99903ec4566 ("NFC: NCI: Handle Target mode activation")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/nfc/nci/ntf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index 63aa0a78472b1..802928ca4d51e 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -653,6 +653,9 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 	switch (ntf->activation_rf_tech_and_mode) {
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
 	case NCI_NFC_F_PASSIVE_POLL_MODE:
+		if (ntf->activation_params.poll_nfc_dep.atr_res_len <
+		    NFC_ATR_RES_GT_OFFSET)
+			break;
 		ndev->remote_gb_len = min_t(__u8,
 			(ntf->activation_params.poll_nfc_dep.atr_res_len
 						- NFC_ATR_RES_GT_OFFSET),
@@ -665,6 +668,9 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 
 	case NCI_NFC_A_PASSIVE_LISTEN_MODE:
 	case NCI_NFC_F_PASSIVE_LISTEN_MODE:
+		if (ntf->activation_params.listen_nfc_dep.atr_req_len <
+		    NFC_ATR_REQ_GT_OFFSET)
+			break;
 		ndev->remote_gb_len = min_t(__u8,
 			(ntf->activation_params.listen_nfc_dep.atr_req_len
 						- NFC_ATR_REQ_GT_OFFSET),
-- 
2.54.0


