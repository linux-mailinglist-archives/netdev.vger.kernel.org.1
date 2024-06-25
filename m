Return-Path: <netdev+bounces-106603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD71916F52
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC933283A3B
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AD4143C69;
	Tue, 25 Jun 2024 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TqDlTECh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6FBA20;
	Tue, 25 Jun 2024 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336852; cv=none; b=fVT29GWUzrc/nr+jEJ6hsRPW7jbDLJbNnhFRKZ9m4MU/dZeFfA9LcfjIy3zxS7fwROzTSgh6KuKAZ1u2UFBXMiJ0kzX0ob2fuyaEplUqRxw6UwPeFnlWzhsGBtIyHzZlF9XdG9juDOU7epr7aCZllPBHAk6gTvH1Eb1fesw4olM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336852; c=relaxed/simple;
	bh=nvg2bDyu97UFY7UtAM4glGoAg2abvvoKxXSCMlGpmmg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7AkRgf10KkaNhJNZlmuF4Z4LedkBYnkK93G4fySQFAbKI6jSqhZ0w8JCoaEg2XgdSl898jcPUvQnegLkpDnXMjOsC9QKIMEuZ7rtVgcG7xFBNEC3vC8o8NxS0DkV3w8+IOPOhdM4Lwp0IdoQFK1ZCa42OczDQh3gemm6h0jrDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TqDlTECh; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P8sUvB006267;
	Tue, 25 Jun 2024 10:34:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=B
	s4dvTdVkjOQxvYbHqJg9rN6SsX5DycL0uN69uYr4MY=; b=TqDlTEChkegIDQO5D
	gbqipLKtYtfqbEZqF1Pu6hhzy3f47z1feLeeILMhoKDkUEQCjv2hcYqr0hzuewfV
	NQRyARtGlFWd3tjFhpEKSgO4ta/oEihWa3eklQurtqZFIdKG8o1SZ6SiT/3DrggJ
	UC3idIQ3dLDfP3C0ms0Ltq3wasx+VCvEK83kmXHVS1IhloddOF9EP2/TkTsMD2p8
	EKsP1ZuxGUvjynNneJX5hQejYru+pa2t+ajUZfuq0L2KRJhg9Vo/1ABGiVncKPhP
	+cfwXcBaEwchYMDZG3N1Z6REevOzX9QOZMQvh0+P85ZVqoVfU0ztpbIPVEogYIB0
	w3vaA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yytt0a2v0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 10:34:04 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 10:34:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 10:34:02 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id ECAF83F7063;
	Tue, 25 Jun 2024 10:33:58 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <markus.elfring@web.de>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH v2 1/7] octeontx2-af: Fix klockwork issue in cgx.c
Date: Tue, 25 Jun 2024 23:03:43 +0530
Message-ID: <20240625173350.1181194-2-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240625173350.1181194-1-sumang@marvell.com>
References: <20240625173350.1181194-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vrbSNRk-xEbkxA1xGIQSZOGXwmtCCOSZ
X-Proofpoint-GUID: vrbSNRk-xEbkxA1xGIQSZOGXwmtCCOSZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_12,2024-06-25_01,2024-05-17_01

Variable "cgx_dev" and "lmac" was getting accessed without NULL checks
which can lead to pointer exception in some erroneous scenarios.
This patch fixes the same by adding the required NULL checks.

Fixes: 96be2e0da85e ("octeontx2-af: Support for MAC address filters in CGX")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 27935c54b91b..e5e266608cfc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -465,6 +465,13 @@ u64 cgx_lmac_addr_get(u8 cgx_id, u8 lmac_id)
 	u64 cfg;
 	int id;
 
+	if (!cgx_dev)
+		return 0;
+
+	lmac = lmac_pdata(lmac_id, cgx_dev);
+	if (!lmac)
+		return 0;
+
 	mac_ops = cgx_dev->mac_ops;
 
 	id = get_sequence_id_of_lmac(cgx_dev, lmac_id);
-- 
2.25.1


