Return-Path: <netdev+bounces-160159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9982CA1896A
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 02:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2392A7A1427
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 01:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EEB8F40;
	Wed, 22 Jan 2025 01:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nil9KyH2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2C68F49
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 01:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737508520; cv=none; b=sSYU5get8qSpoBKRTjMfMK1cJH6TOXFZxT4hf/iZ/Rudb/MuZRJJfj0ad98iAqgpu7FezbQkfpKCIhpzVFSJ/aw6N6H9XKrD7jNYgUVeqao5dlGTI//pFQqmmG9pd7QyDHyNnuuoM8QPYq/AozWmq3O7NTtnkpun0hJ6LNjVvx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737508520; c=relaxed/simple;
	bh=Auil3q9VpnTTByFINJN+9PkUsN5DJlrVKm/9v2vis5U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m+k6RHK9NDZVgyo+2B3kqZyZ1a7twqzwnEVSJ+YSzRj0eBTPgb7x1CetUZ5A8aRnDGj3CDj4W4Q8fVMxNeZ6iTOqrUrrYTwqsYF4kxatqLF/y7AfNYJMY5fOgIN0PA+HW83fYO0SXG7oDoatyf6NJsF06NdVKwM+jkYzdN/xDcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nil9KyH2; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M1CJ5P002927
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 17:15:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=KNkZHhwh/R7GeGtNNM
	eOGK4J0MhlYg+Kl09fusSjY+g=; b=nil9KyH29QkH2CQNpl3pGzFaltcNqOVOxl
	Sb17FbdjTKvy+/fgb1SoO9R2UWRbsW8Fm1d2Fla09e2vJU8qyqVoHpjlu7eh8YNz
	J/Q/znCSBygFXvBY4HOFJ3xhQOkFvyddzCq47nwnzIBTAU7OaC2Q0Vfftvc7qSfa
	vXMtjRJOhzjRmixhbhuY1OsTo1z+w11lAyzQc7sWgOJUk118rUkQlVvNbF7I/JSC
	v0hA6YG3zmjwv/Br64XEK2gCPEDZ3r6cjn+2xk57XLZKR9OCNuc3gWKF1RhbX3T9
	bLE9Jmyus0PdLQfbGDeLiWF4C8dWYCNM1rNggmc8s4cGQvl9Jvxw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44apqwr17u-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 17:15:17 -0800 (PST)
Received: from twshared24170.03.ash8.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 22 Jan 2025 01:15:05 +0000
Received: by devbig072.ftw6.facebook.com (Postfix, from userid 678122)
	id 8272D115C53B; Tue, 21 Jan 2025 17:14:54 -0800 (PST)
From: Michael Edwards <mkedwards@meta.com>
To: <netdev@vger.kernel.org>
CC: Michael Edwards <mkedwards@meta.com>
Subject: [PATCH] ethtool: Fix JSON output for IRQ coalescing
Date: Tue, 21 Jan 2025 17:14:34 -0800
Message-ID: <20250122011445.4026973-1-mkedwards@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: rgDPD5eVor137YbrkgJK2bS13rPZ-l4R
X-Proofpoint-ORIG-GUID: rgDPD5eVor137YbrkgJK2bS13rPZ-l4R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_10,2025-01-21_03,2024-11-22_01

Currently, for a NIC that supports CQE mode settings, the output of
ethtool --json -c eth0 looks like this:

[ {
        "ifname": "eth0",
        "rx": false,
        "tx": false,
        "rx-usecs": 33,
        "rx-frames": 88,
        "tx-usecs": 158,
        "tx-frames": 128,
        "rx": true,
        "tx": false
    } ]

This diff will change the first rx/tx pair to adaptive-{rx|tx} and
the second pair to cqe-mode-{rx|tx} to match the keys used to set
the corresponding settings.
---
 netlink/coalesce.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/netlink/coalesce.c b/netlink/coalesce.c
index bb93f9b..bc8b57b 100644
--- a/netlink/coalesce.c
+++ b/netlink/coalesce.c
@@ -39,9 +39,9 @@ int coalesce_reply_cb(const struct nlmsghdr *nlhdr, voi=
d *data)
 		show_cr();
 	print_string(PRINT_ANY, "ifname", "Coalesce parameters for %s:\n",
 		     nlctx->devname);
-	show_bool("rx", "Adaptive RX: %s  ",
+	show_bool("adaptive-rx", "Adaptive RX: %s  ",
 		  tb[ETHTOOL_A_COALESCE_USE_ADAPTIVE_RX]);
-	show_bool("tx", "TX: %s\n", tb[ETHTOOL_A_COALESCE_USE_ADAPTIVE_TX]);
+	show_bool("adaptive-tx", "TX: %s\n", tb[ETHTOOL_A_COALESCE_USE_ADAPTIVE=
_TX]);
 	show_u32("stats-block-usecs", "stats-block-usecs:\t",
 		 tb[ETHTOOL_A_COALESCE_STATS_BLOCK_USECS]);
 	show_u32("sample-interval", "sample-interval:\t",
@@ -85,9 +85,9 @@ int coalesce_reply_cb(const struct nlmsghdr *nlhdr, voi=
d *data)
 	show_u32("tx-frame-high", "tx-frame-high:\t",
 		 tb[ETHTOOL_A_COALESCE_TX_MAX_FRAMES_HIGH]);
 	show_cr();
-	show_bool("rx", "CQE mode RX: %s  ",
+	show_bool("cqe-mode-rx", "CQE mode RX: %s  ",
 		  tb[ETHTOOL_A_COALESCE_USE_CQE_MODE_RX]);
-	show_bool("tx", "TX: %s\n", tb[ETHTOOL_A_COALESCE_USE_CQE_MODE_TX]);
+	show_bool("cqe-mode-tx", "TX: %s\n", tb[ETHTOOL_A_COALESCE_USE_CQE_MODE=
_TX]);
 	show_cr();
 	show_u32("tx-aggr-max-bytes", "tx-aggr-max-bytes:\t",
 		 tb[ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES]);
--=20
2.43.5


