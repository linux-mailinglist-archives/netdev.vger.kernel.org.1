Return-Path: <netdev+bounces-160391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EB5A1983A
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 19:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099693AAFB0
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 18:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4A621517D;
	Wed, 22 Jan 2025 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Bj3SXpgp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD08170A11
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737569560; cv=none; b=Txq4MWkCWUgWIVx4Q2jPjQue9OEhhWnI406OKPLa4CaUjFxxPsOF/EUwwDcQgs7qZGcaNH82vrCfoXlAcO9HzvdwVQ7iryhqo98oWQrd7K80/ZOu/K80mPIFHAN4gMU60OVT+4OE78Uzmo+ptI9PRAuYZpbl6g9FBHOBR673xKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737569560; c=relaxed/simple;
	bh=cQXnSSLwRoU6BvSddDKTmQP1VV4hsu/ppMC0RUGck8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRmSAq4LvWJQ/ZgHYgEHxmrymBH4tOvQwLxxcV3nVI1su1lvjibCA28nf9X5UBEOgb6J2NYePF9FIIWD6khRR+H6yLoAmn3QUsJ59XMut6wqeCkmOkHCWxAONYPKZVbcg0ypFMynNh6GSlwxkoVOMtdx6ZiyshwpDLugNF5UFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Bj3SXpgp; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MI0ExI028601
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 10:12:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=yqFW9ZhJ1B4oRjXbf71eCXT7/vw7OOexYESWNK1x/Nk=; b=Bj3SXpgpHa/X
	bE4CIzjrxzSqEIE0XUqU/XRX6lnCp4XxiOpISFyYj8OZye1UupaWQUM6hAAEIKHI
	HMugOqL79ryA0RyJ0yYEfBZQPoRATTadx5LtlAb/viKmzxO6RYitK1il5TKlQJml
	WWioairUL/xG3thwI60UL4iERiGym75MN8oV7tBjTSbjZHVZWF/Yt3M+EKJBgQ6E
	fdLUQMZ4xMXBAIAkqXBMNgH9LCtFQ6MWy6rHksshO5fgQZV6Iw+ergTu1LVirr5N
	ptYTgCmlcsw/4S4CdcdNtoc9EMyBXHMsL5t9FfYMHshrAAhvhxJuRyyHF8+wWdjI
	Euc2ZUk62A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44b4harp8a-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 10:12:36 -0800 (PST)
Received: from twshared24170.03.ash8.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 22 Jan 2025 18:12:10 +0000
Received: by devbig072.ftw6.facebook.com (Postfix, from userid 678122)
	id 499BE1204305; Wed, 22 Jan 2025 10:12:03 -0800 (PST)
From: Michael Edwards <mkedwards@meta.com>
To: <netdev@vger.kernel.org>, <mkubecek@suse.cz>
CC: Michael Edwards <mkedwards@meta.com>
Subject: [PATCH] ethtool: Fix JSON output for IRQ coalescing
Date: Wed, 22 Jan 2025 09:40:15 -0800
Message-ID: <20250122181153.2563289-1-mkedwards@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250121181732.4f74b6a6@kernel.org>
References: <20250121181732.4f74b6a6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: zucXTIyZEUWD-XPDkp17CfSoo8kaVMrs
X-Proofpoint-ORIG-GUID: zucXTIyZEUWD-XPDkp17CfSoo8kaVMrs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_08,2025-01-22_02,2024-11-22_01

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

Fixes: 7e5c1ddbe67d ("pause: add --json support")
Fixes: ecfb7302cfe6 ("netlink: settings: add netlink support for coalesce=
 cqe mode parameter")
Signed-off-by: Michael Edwards <mkedwards@meta.com>
---
 netlink/coalesce.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/netlink/coalesce.c b/netlink/coalesce.c
index bb93f9b224d6..bc8b57b6d412 100644
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


