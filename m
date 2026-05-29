Return-Path: <netdev+bounces-292981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2N0dNlcjGWqVqwgAu9opvQ
	(envelope-from <netdev+bounces-292981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:25:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ED45FD553
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA01130561E2
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9F03A0E8B;
	Fri, 29 May 2026 05:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFHQB+m2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5487B39FCDB
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 05:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780032223; cv=none; b=C7LzrGUVLn/37QdrOk9k3KuD7JUBYlbhUIfcSk0D4xj984dHk54ZXSpmhtHoUbznRd8CE9NoQw+g7lJpTK0O04q5m5mh3R8tUyS4YQUD15V7iwiMsdMZyI87f7LXmyszZ4+sxr95GlvYqxwmcCfx+NPGnZRSzZTWpeztW+AMMuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780032223; c=relaxed/simple;
	bh=3vNAKM6j6aVnMJxr08z6uHmAK2r+kDyvp6exP24BZxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PRPo9JeiX9Rblz/cZRJgaYX7UX2au10jsiiRTg1WtlHekQwOgO+BbBK6K5UmwVw7lJn5eTm02SeNTiQg+mi4g0xZ9kCdMSsJb3MvIcmBBw/apcTop/0Gs4qcaXehm3DZ5qLC3oJtyKcgwnaizgUwN+bnuOWULUcFukLmXlMd3s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFHQB+m2; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-915336b83adso11423685a.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 22:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780032221; x=1780637021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VB5HuyxQYxuhg6foYaDXdEVb1NOeFWcqTT/3q8+M92I=;
        b=HFHQB+m2w1CIYXiv5x1pG81B1vsYh91tZBJLRRVh2piOkiyC6MGSMfTzNN18xVb0Fz
         6FTHO6A5Aax07HvsVPUXxtqK0QAisS+g+qoFAAZSWkSTwVGdYkwrPzM5XYjAKB0sUvle
         8s4pNka1DUnSZq5zs7mqYl+O6Ivh2+2UWT2TtlVFXLz8a9HPbxuCLSPYjRuqyq7JpZQa
         V2YrxceYurD5gGmEG+P9dnn+9QOcpKWTjodEcCKq5pfPm1SyFpIZyFUjI/dnpoBvVJ7A
         BfSamCwoHA0sJmRxEaYfzP2GG9JmPQCo1y29hlhJ22MAzYI9Fgnb37OwO+jwCPFnnnn7
         EYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780032221; x=1780637021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VB5HuyxQYxuhg6foYaDXdEVb1NOeFWcqTT/3q8+M92I=;
        b=Dg12glUVXKoMNz0qoYStYN5rYdJexHv+t9y5RzPsUBH2z74NmWuPYYKPn6yH3p4fRN
         QalMrRDQF8Nf3s/TiO6oYeWh5no75592Lv4E9Kfru0Wa2/vVyogHy4RsP5B3/UAsiPxu
         /fXeibNK21zSHwddPoS4xfYlRAuMLMoz9KUD7r+XtCIDNDxhZjrm4eOrj1Mp0El3hTmn
         x+/ZLkf+K1XnptvpLI9NilOuG3r2mFDaKiRy7OrQTTIFLfrLFrCWfQ9aLsyTbKiOciUt
         HXmlG7sPiGZAhlJbj5yIVkE768Qnbtq0TTc6ZgKdTn5NrIyGkwk3Y/2Sug3yvcEixlmX
         tBtQ==
X-Gm-Message-State: AOJu0YzqjYNgUMCynbIvy56epC5KQLvfdEK2Jo30YMSFT3jBneyXu8g/
	AZFeC0+mZH/xwSv+vrrwQCp2QSrTxihQ65qCr4ANMOqNuMRKhzmwcJS5
X-Gm-Gg: Acq92OF2rZERtSh7PRcRUEO9IorOJsrQgjzMN84yV+l3Vo0SITdfH2JorFKL6bV5GT6
	cuZxyUcd4blZRKywjvN7OkV+ufZdNPuQWGC7KtS5zgpWtpDrTmVOxDzXSKiT10Ihg+RWmcyyIFE
	3RAJ6dl+5m8PVwUcwIVnaLEXmycTEdVKpk+iPir29LI5ktYUTYe9j4rTfktVBeqdkdc36WixJMF
	aRD6bDDaDqGc4IWOfXRTQkPYe1IQd68iHjMynFDpIuJaNIdwU/t8fjXZMmeO0AdQ7Qea0ORlCV6
	EZOWPWXEOhy7mGpzsrGmYuBCmtvSkA34G/oxVnd+JGv41vZ2/2tFsJ0qprjwGlpMGYzcGvJgdIy
	56baucyL60yJ1Ua/nblqO5j3MO9sKch6KyjMfhbKH9gQuCsMEmWhypVrV6jX8p3QrgLqO7d7tmg
	xfNynDCyKD3wdE6fPfhhZrON2lrx52MvH3zhXlrx316PXkFbda2hLaij8RD0ZUyw==
X-Received: by 2002:a05:620a:4890:b0:913:aee6:3931 with SMTP id af79cd13be357-9152fe0c9e9mr180131285a.45.1780032221078;
        Thu, 28 May 2026 22:23:41 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915324868a0sm86617085a.18.2026.05.28.22.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 22:23:40 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] octeontx2-af: Fix PCI device reference leaks in debugfs
Date: Fri, 29 May 2026 01:23:33 -0400
Message-ID: <20260529052333.1665989-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-292981-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dbgh9129@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 60ED45FD553
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cgx_print_stats(), cgx_print_dmac_flt(), and cgx_print_fwdata()
look up the RVU AF device with pci_get_device() and pass the returned
pointer directly to pci_get_drvdata().  pci_get_device() returns a PCI
device with an elevated reference count, so the lookup reference is
leaked on every debugfs read.

Store the returned PCI device pointer, check it before reading driver
data, and release the lookup reference after pci_get_drvdata(). In
cgx_print_dmac_flt(), release the AF lookup reference before reusing
pdev for pci_get_domain_bus_and_slot().

Fixes: f967488d095e ("octeontx2-af: Add per CGX port level NIX Rx/Tx counters")
Fixes: dbc52debf95f ("octeontx2-af: Debugfs support for DMAC filters")
Fixes: 49f02e6877d1 ("Octeontx2-af: Debugfs support for firmware data")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 .../marvell/octeontx2/af/rvu_debugfs.c        | 31 +++++++++++++++----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index fa461489acdd..a94c48e9acc6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -2838,9 +2838,16 @@ static int cgx_print_stats(struct seq_file *s, int lmac_id)
 	int stat = 0, err = 0;
 	u64 tx_stat, rx_stat;
 	struct rvu *rvu;
+	struct pci_dev *pdev = NULL;
+
+	pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
+			      PCI_DEVID_OCTEONTX2_RVU_AF, NULL);
+	if (!pdev)
+		return -ENODEV;
+
+	rvu = pci_get_drvdata(pdev);
+	pci_dev_put(pdev);
 
-	rvu = pci_get_drvdata(pci_get_device(PCI_VENDOR_ID_CAVIUM,
-					     PCI_DEVID_OCTEONTX2_RVU_AF, NULL));
 	if (!rvu)
 		return -ENODEV;
 
@@ -2958,8 +2965,13 @@ static int cgx_print_dmac_flt(struct seq_file *s, int lmac_id)
 	u64 cfg, mac;
 	int pf;
 
-	rvu = pci_get_drvdata(pci_get_device(PCI_VENDOR_ID_CAVIUM,
-					     PCI_DEVID_OCTEONTX2_RVU_AF, NULL));
+	pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
+				 PCI_DEVID_OCTEONTX2_RVU_AF, NULL);
+	if (!pdev)
+		return -ENODEV;
+
+	rvu = pci_get_drvdata(pdev);
+	pci_dev_put(pdev);
 	if (!rvu)
 		return -ENODEV;
 
@@ -3014,9 +3026,16 @@ static int cgx_print_fwdata(struct seq_file *s, int lmac_id)
 	struct phy_s *phy;
 	struct rvu *rvu;
 	int cgx_id, i;
+	struct pci_dev *pdev = NULL;
+
+	pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
+			      PCI_DEVID_OCTEONTX2_RVU_AF, NULL);
+	if (!pdev)
+		return -ENODEV;
+
+	rvu = pci_get_drvdata(pdev);
+	pci_dev_put(pdev);
 
-	rvu = pci_get_drvdata(pci_get_device(PCI_VENDOR_ID_CAVIUM,
-					     PCI_DEVID_OCTEONTX2_RVU_AF, NULL));
 	if (!rvu)
 		return -ENODEV;
 
-- 
2.43.0


