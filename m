Return-Path: <netdev+bounces-258014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEJDM0iRimkQMAAAu9opvQ
	(envelope-from <netdev+bounces-258014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 03:00:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ECA1161B4
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 03:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC25E3011125
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 02:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5D926CE05;
	Tue, 10 Feb 2026 02:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTnjbCsP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D58D128395
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770688838; cv=none; b=l98lnM7ZgFi88K2WNtd+ouUVackyLQRI5bLAMp/D3xpCxvCZWGpV9+xa/JMprSERyLC1GG50IVeDxaiQg63herJyAkUoJcjVt7BiwVqpL4iiK7i61qgYLZPvk6/V1Gqh0dZpkqm4llRZFpWBT6/JbNwgB5D1Vh0ZPN2o1VbKAcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770688838; c=relaxed/simple;
	bh=UJkIDp3mei6FigAUKfuCD/58P/3Z7xvlLeXNG9/FfTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ejMq0H1NQKGqYHGaKA0fF0theLhEKridxl9N8ZvRDuwasx1O7E1WANp2nIs64rxrLEi/kUOi0j3zQQnU4lkDAHsUmO/T13UfXCN1+Bz/EqWysjBN0KhgLouqiKMuQCjtriKxn50hOqRhwn0tXTDqcuT++dWZ6sqeFh48XxUVAGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTnjbCsP; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1270adc5121so395838c88.0
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 18:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770688836; x=1771293636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MfY4Xzr/UFYtGolHiW+DJ/mV6vJV4fu9aHTEWwC08qI=;
        b=GTnjbCsPOiSy2X18BmYbXx2+UtXf7E1P+6+E7zI8Fs7SjdqCjhPP56KqnkHzZtgR+X
         RdfGFPAKQQDXILKDBjNiUybd66sZRBtvwYe4MKnAGvrLWsic+5tVvr/36dXK1v3FL4KR
         WS4LB+fjL3QAFlipFpV/6rDU8DsKJazdIgsF8hC3KKK6LFSO1qZwjQuzjK/qZ7W6yrJ/
         EMmKvBYTtjR2zOCqYQagWThZNXL2vi9uJh+hJ+5KQ+9KzBpoI4xJnI4S/4UlLChqckXB
         cIRK45amNTzWYu1BlIlL5tdkLMFLzMRcKyFGCRPaYK0u9wjukJs8PmEBqEQL69sxRCni
         +WUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770688836; x=1771293636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfY4Xzr/UFYtGolHiW+DJ/mV6vJV4fu9aHTEWwC08qI=;
        b=sU+J4/SmZddHiY5CQHQXGNM47sK5hhzfhbMvKTxuxffD+J1sIoQeC1zi6xdDG+Un+L
         reeeq6wmAdpPp/aY4vvA8hVMnwYNQ4+uC0+9pPpPRh8cKlLwwMVe/g46LmNXRWjpRQsO
         CshgCzcAnqbHm3l+SsMFCp7tLN73d4ET0LNRA177Ld3yy8zWpb+SX1NlLV52vyUGd1Y2
         AXpNKd3Wi56I/AxVxQM98RnAeIzdtW/8Y6rw3Y6CcaEFqzf364XUJn3W0zqa9fkbeSdm
         +Ra1DqvR67NpuAbaGZk00/iwXqmquGj7ojc1f+/MkK/sz4+8Lj8DDNMUHQNGI6WMmKuU
         JeTg==
X-Gm-Message-State: AOJu0Yw/158TIzF5zFusbaX65WLcCHvGshaQNhsMvVlETL/SmUifmpRN
	933/ajO586fMVc3UVBXlZY/uYiRHtGLlnGRZUiBdhecBylD2L3Xo74g3ulQPI5uP
X-Gm-Gg: AZuq6aIgpvT+QDwVaQXpXYm3lkCSc83h36ubRUVW9pB2C6sft/twQocnS2N62ju6w+z
	WfitpfObT3UfgIdG7GOXoX8rrHofKX6FmM/1HOF5GfUewjQP2Vv1WLqhFK5d3el3S1XBBqHIyKf
	f8N8sRSHv3yS9i8j9FXON7iZmM1n4SvUs3d16ACHM/sL6dX158cGpXLx1r2XJt0ve0fFoNwMIMO
	rEX5PiQ+s1NVd3yCkfgGUkImEem8fhQ8GL/8br537BcDMnqXYQ0Mj2xKGktjlLFGH/19B78JeFN
	DxF5aAxUFwn9zY12K6JWDSWeSvPpGxKg44FLw4c351aT1Pl50YT2IYnPyPh4v/wRRBQf8RtJhls
	qgLA7zALnONcsXlOpqpY5l79xhFxiCrgEKC14v9A9RE9Kf71iCt0lSwiiufsk1Y4TCKlc9BdTlq
	Krf7bVlhlxZKy9HnYXOVdaKBoNFmh/P6hqbUEW8EsoJ1jMUIwIfUK4wJRbzCBsV2wxt9nd7lxo4
	Vq0o3GOA9kZ4TWcdBdhaboTXOcRsKGtLPETQldqN9Y4y7jKNiQ26yl46jeo05Od/Ody86VaRb92
	sAXVFNphpSKNvQpmZQ==
X-Received: by 2002:a05:7022:f97:b0:119:e56b:98be with SMTP id a92af1059eb24-1270405aa41mr6196402c88.37.1770688836142;
        Mon, 09 Feb 2026 18:00:36 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041d9c91sm11239559c88.2.2026.02.09.18.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 18:00:35 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2] net: arcnet: com20020-pci: fix support for 2.5Mbit cards
Date: Mon,  9 Feb 2026 18:00:12 -0800
Message-ID: <20260210020012.11819-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,pengutronix.de,lunn.ch,davemloft.net,google.com,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258014-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39ECA1161B4
X-Rspamd-Action: no action

Commit 8c14f9c70327 ("ARCNET: add com20020 PCI IDs with metadata")
converted the com20020-pci driver to use a card info structure instead
of a single flag mask in driver_data. However, it failed to take into
account that in the original code, driver_data of 0 indicates a card
with no special flags, not a card that should not have any card info
structure. This introduced a null pointer dereference when cards with
no flags were probed.

Commit bd6f1fd5d33d ("net: arcnet: com20020: Fix null-ptr-deref in
com20020pci_probe()") then papered over this issue by rejecting cards
with no driver_data instead of resolving the problem at its source.

Revert the incorrect fix and fix the original issue by introducing a
new card info structure for 2.5Mbit cards that does not set any flags.

Fixes: 8c14f9c70327 ("ARCNET: add com20020 PCI IDs with metadata")
Fixes: bd6f1fd5d33d ("net: arcnet: com20020: Fix null-ptr-deref in com20020pci_probe()")
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
Changes from v1:
Rebase on latest mainline instead of net-next
Add received tag

 drivers/net/arcnet/com20020-pci.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index 0472bcdff130..4847f40a2095 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -139,9 +139,6 @@ static int com20020pci_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	ci = (struct com20020_pci_card_info *)id->driver_data;
-	if (!ci)
-		return -EINVAL;
-
 	priv->ci = ci;
 	mm = &ci->misc_map;
 
@@ -347,6 +344,18 @@ static struct com20020_pci_card_info card_info_5mbit = {
 	.flags = ARC_IS_5MBIT,
 };
 
+static struct com20020_pci_card_info card_info_2p5mbit = {
+	.name = "ARC-PCI",
+	.devcount = 1,
+	.chan_map_tbl = {
+		{
+			.bar = 2,
+			.offset = 0x00,
+			.size = 0x08,
+		},
+	},
+};
+
 static struct com20020_pci_card_info card_info_sohard = {
 	.name = "SOHARD SH ARC-PCI",
 	.devcount = 1,
@@ -448,49 +457,49 @@ static const struct pci_device_id com20020pci_id_table[] = {
 		0x1571, 0xa001,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		0,
+		(kernel_ulong_t)&card_info_2p5mbit
 	},
 	{
 		0x1571, 0xa002,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		0,
+		(kernel_ulong_t)&card_info_2p5mbit
 	},
 	{
 		0x1571, 0xa003,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		0
+		(kernel_ulong_t)&card_info_2p5mbit
 	},
 	{
 		0x1571, 0xa004,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		0,
+		(kernel_ulong_t)&card_info_2p5mbit
 	},
 	{
 		0x1571, 0xa005,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		0
+		(kernel_ulong_t)&card_info_2p5mbit
 	},
 	{
 		0x1571, 0xa006,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		0
+		(kernel_ulong_t)&card_info_2p5mbit
 	},
 	{
 		0x1571, 0xa007,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		0
+		(kernel_ulong_t)&card_info_2p5mbit
 	},
 	{
 		0x1571, 0xa008,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		0
+		(kernel_ulong_t)&card_info_2p5mbit
 	},
 	{
 		0x1571, 0xa009,
-- 
2.43.0


