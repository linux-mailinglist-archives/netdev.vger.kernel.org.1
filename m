Return-Path: <netdev+bounces-301513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nIfOGKMHO2qJOwgAu9opvQ
	(envelope-from <netdev+bounces-301513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 00:24:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAF16BA66C
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 00:24:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bynar.io header.s=google header.b="ay/YrN4Q";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301513-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301513-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bynar.io;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F98630380E9
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EED23C4546;
	Tue, 23 Jun 2026 22:24:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583543B27E9
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 22:24:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782253471; cv=none; b=Xavs9zcYRgsk8VznUMOh+/vCHB2en3VwBLVrcwcY6vILUHyfdlk5lT0Zrvq+nDYil78fDxLlvRsUlaImnUPJiI5nFwe0xUvlK39BOD1tnPdPnNxLIQ/jgvZxtdZupWF1PNp6dZLJT2LwSCiJUhPBORglJFam7tT01Ryk7K9kAiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782253471; c=relaxed/simple;
	bh=1YhKA2IR2noap56s+wFYYMoqh9rUzZYHvDIQPXPdHYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QnRvxEf58etdQMqPHTBUSBpNur7hR7eRb95YaFvooCWo3F17E2xg2EVV0mRWgZ/LuzVvdZUmboxfF63wtWm2QOVFqQFvq5ddZlzC4wc6AD2iU31GbLGgBx2G9gTrK/TohT3e2JiraP5yi/SKBuwj2zew2MQXsWz1cQVfJGJb+SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=ay/YrN4Q; arc=none smtp.client-ip=209.85.208.54
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-691c5776f35so575554a12.3
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 15:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782253468; x=1782858268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9EL/E+9kbwK4PLUI4WhiNWopf73sV8df3AbcMljHGbw=;
        b=ay/YrN4QBCYx5PotKUvMHbOwy57zt0NzJ11m4iZxT/zdFOr4jVMOd9xAC0Y+NJunlQ
         urf7uTe1bQEoBmtW1tgtXh+ejovbnltBe3gqKdwKh5t+/3vOZ8tyFjVq4maN10oeRmpl
         oxtpHJy1zMHcqnMu+FAJlJhf5BpQHEcNpTvwOGA/5wN0rOi20EjyMQmTHMQZJN4YJVR1
         BfJQS0fsDW2O+5/Dgjnps3k6JUlfi7r9atKZtoRYOLtwqDQRLDtG1FeR4UCumXlmXvgo
         t4dbwrNT7UyLNefLQxMhrSITyOG7DB9Cm9G2VBPA2NFFROcvp7zMWyzQt+iG8LhU/DDY
         iUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782253468; x=1782858268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EL/E+9kbwK4PLUI4WhiNWopf73sV8df3AbcMljHGbw=;
        b=ilP4XD2keTs653nKgsk1RZZYOVFXlxtbn5GxzsaWtZqvFdWEcMRI34bxuqWfJc2DN5
         RMiuf2ky8K5wUdK3HKOjScw8p0OeRHFAFStcidITyoJow2bfKTSF9kYTUn5wXmxxahK2
         W0SXlOIad59/Sis1JtDFHzr3NsyfjDh/JtP8r5idK1uztz300vQbCmI+GFpc4yq5qtlX
         n7aUdetwSTL80Ojwc8vgxwukt4LWyU+SwyogJhVB6LLYiFgaJFF4BcdvbtSHq2qBKyY+
         n2Jjnz6D2riX/LjggntPFIjSULC3oP7bmPVbLzGItOmSfs5RAeuszYIXrKP/F6XFPtU6
         RyXg==
X-Forwarded-Encrypted: i=1; AFNElJ+7eZf6NPAj1CNO0YKZ2mjNI8HVBw1Gq73hNbgsJ+leiB9r/FJPTdWFG9CLlz7ftiT+Gw2Wvkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH67XpIgh2gWWUlNBphDPAfJnon4zl1eBbRiNZ3IXmnUi1+YNW
	AbruByeA32vUyopRPBN0SwV6UfhbY08seBXQdm0CR7rKBURe6PM67OuzHs7Fw0htdET2
X-Gm-Gg: AfdE7cnqm1uYNRKzzz/kW35CELghFK3pkrtaAUxVLZHA9Q4Ef/jiI5DqPgx5nlX5i51
	7A5q7AetGmUDrIpgcFiG7tJvuRhfnTfSO9Njn8LeXCoXrp8RXwSFygQC7U0EI83wyqo5QS9BzPt
	IBKZxIJnowsovMsWAo9fTNoBu/k2jrvl6T3SztRdTU+lH2vKfQPq72LVVMdBNeWstSR6z3K2M5j
	muXC5+urErL/vqMXWbyMXoGS3RCFXWru8e18cYJ9Khi1Lb2F3aTH9tp2wBqiCbDRdwV3zzq3+wy
	UlVGR83UIc8FERRQ3xDFKrHhHlHYtWNu7yP7XXqaDRjhivodZH2xHe7w8svPNQDetlvdLRtnWD5
	ON9hlEiCJADxTt//P0QS3RwwtByJ8PQFX6lwcrOZELYbXRcn9GquZA+oj/lo8/e4CYNyERPIrI8
	G4
X-Received: by 2002:a17:907:96a8:b0:bec:687f:6603 with SMTP id a640c23a62f3a-c119e45a11fmr20199066b.28.1782253467082;
        Tue, 23 Jun 2026 15:24:27 -0700 (PDT)
Received: from localhost ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c610e5280sm579916966b.53.2026.06.23.15.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 15:24:26 -0700 (PDT)
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
Subject: [PATCH net] nfc: nci: fix uninit-value in nci_core_init_rsp_packet()
Date: Wed, 24 Jun 2026 00:24:02 +0200
Message-ID: <20260623222402.175798-1-sam@bynar.io>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bynar.io:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301513-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,bynar.io:dkim,bynar.io:email,bynar.io:mid,bynar.io:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFAF16BA66C

The CORE_INIT_RSP handlers walk the response using length fields taken
from the packet itself, without checking they stay within skb->len:

 - v1 computes
	rsp_2 = skb->data + 6 + rsp_1->num_supported_rf_interfaces;
   from the on-wire (unclamped) interface count and then dereferences
   rsp_2, and memcpy()s the advertised interfaces - both can run past the
   received data;
 - v2 walks supported_rf_interfaces[], advancing the cursor by an
   in-packet rf_extension_cnt with no bound.

A short CORE_INIT_RSP therefore makes the parser read past the packet
(into the uninitialised tail of the RX skb); the values are stored into
struct nci_dev and consumed while bringing the device up:

  BUG: KMSAN: uninit-value in nci_dev_up+0x10f3/0x1720
   nci_dev_up+0x10f3/0x1720
   nfc_dev_up+0x187/0x380
   nfc_genl_dev_up+0xdc/0x1a0
   genl_rcv_msg+0x5d4/0x9e0
   netlink_rcv_skb+0x28f/0x530
  Uninit was stored to memory at:
   nci_rsp_packet+0x68f/0x2310
   nci_rx_work+0x25f/0x5d0
  Uninit was created at:
   __alloc_skb+0x540/0xd40
   virtual_ncidev_write+0x65/0x210

Bound both parsers to skb->len before dereferencing the variable-length
parts, rejecting truncated responses with NCI_STATUS_SYNTAX_ERROR.

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Fixes: bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
Cc: stable@vger.kernel.org
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
---
 net/nfc/nci/rsp.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index 9eeb862825c5..cdcd23c8ca95 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -50,6 +50,9 @@ static u8 nci_core_init_rsp_packet_v1(struct nci_dev *ndev,
 	const struct nci_core_init_rsp_1 *rsp_1 = (void *)skb->data;
 	const struct nci_core_init_rsp_2 *rsp_2;
 
+	if (skb->len < sizeof(*rsp_1))
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	pr_debug("status 0x%x\n", rsp_1->status);
 
 	if (rsp_1->status != NCI_STATUS_OK)
@@ -58,6 +61,15 @@ static u8 nci_core_init_rsp_packet_v1(struct nci_dev *ndev,
 	ndev->nfcc_features = __le32_to_cpu(rsp_1->nfcc_features);
 	ndev->num_supported_rf_interfaces = rsp_1->num_supported_rf_interfaces;
 
+	/*
+	 * supported_rf_interfaces[] and the trailing nci_core_init_rsp_2 are
+	 * addressed using the on-wire (unclamped) interface count, so the
+	 * response must be long enough for both before they are dereferenced.
+	 */
+	if (skb->len < sizeof(*rsp_1) +
+	    rsp_1->num_supported_rf_interfaces + sizeof(*rsp_2))
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	ndev->num_supported_rf_interfaces =
 		min((int)ndev->num_supported_rf_interfaces,
 		    NCI_MAX_SUPPORTED_RF_INTERFACES);
@@ -88,9 +100,13 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
 {
 	const struct nci_core_init_rsp_nci_ver2 *rsp = (void *)skb->data;
 	const u8 *supported_rf_interface = rsp->supported_rf_interfaces;
+	const u8 *end = skb->data + skb->len;
 	u8 rf_interface_idx = 0;
 	u8 rf_extension_cnt = 0;
 
+	if (skb->len < sizeof(*rsp))
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	pr_debug("status %x\n", rsp->status);
 
 	if (rsp->status != NCI_STATUS_OK)
@@ -104,10 +120,16 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
 		    NCI_MAX_SUPPORTED_RF_INTERFACES);
 
 	while (rf_interface_idx < ndev->num_supported_rf_interfaces) {
-		ndev->supported_rf_interfaces[rf_interface_idx++] = *supported_rf_interface++;
+		/* one interface byte + one extension-count byte must be present */
+		if (end - supported_rf_interface < 2)
+			return NCI_STATUS_SYNTAX_ERROR;
+		ndev->supported_rf_interfaces[rf_interface_idx++] =
+			*supported_rf_interface++;
 
-		/* skip rf extension parameters */
+		/* skip rf extension parameters, bounded by the packet */
 		rf_extension_cnt = *supported_rf_interface++;
+		if (rf_extension_cnt > end - supported_rf_interface)
+			return NCI_STATUS_SYNTAX_ERROR;
 		supported_rf_interface += rf_extension_cnt;
 	}
 

base-commit: a986fde914d88af47eb78fd29c5d1af7952c3500
-- 
2.54.0


