Return-Path: <netdev+bounces-189988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BF3AB4BC9
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 08:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4980C3A5972
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 06:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1AB1E8333;
	Tue, 13 May 2025 06:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="J8q7LdU4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCCA1E5B91;
	Tue, 13 May 2025 06:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747116857; cv=none; b=oRpXZOs0XSr0K6/jOwaMRGuS/yhCRfwPLyNX9J13m+OEJ/iTTPmqjwl6i1/5fdYzkFvQClLDRNYGidxYU3xAZoF1anLmWPaqDcyX2i2sm9fEIxn7FQ8YACzhN41uO1qB3ZY+oHKXUSX0MSig66Rzs2sYiQL3VJpJYL50UbfL05M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747116857; c=relaxed/simple;
	bh=ppsAc3NvpxHC3c9VeG5RIpl30mloOVWcDsHtDV5W4+0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t0E+xnXEk/OHBJqaOyFRySAmAYR48uVr9/hay7M7znupahmOFK8Nl/RL5ryH5/aVgqZSsULnLdTduaEo5A/9tC/Wj6onWnCrJibxQgrnn5OfCiPcKfufJdp+o7IKeh5uDchG9wtkqogkbJk1eHEHSbNXvk44TF/O5JDn6zJ9vbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=J8q7LdU4; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CIOMaU002621;
	Mon, 12 May 2025 23:14:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Rm45X3DssiNRUWPzdMlI/PW
	gTfBeRMQ59d7XSlhO858=; b=J8q7LdU4kDs7k1GON2l7Jpq1iRrDeqLo7Aws8u4
	Z7lxhnFNlaeIeY5aPtXlKBa/oXRb+0UG2XCn10KY1m5u5h4IeoEv8TQekTh/Z0ZQ
	t2K/IodCz4Qx06Em6bl/rnRS1T+VI8mmvNdiOpjRUZyc8+ZM0do1M+3IKWIj96O3
	CfNghEAQlIajlocVtRWWT5UZhubJ30S//ptNfOitFo+v8CdT3FLnSKj80KQKv4xj
	pFSIGqo4ump9e+q17YDfDZ2xVyPwx87XboyHf193JJTeUkzAilbBa/ayxd+Txmpo
	S2F5b6rVqFgEpCQ8N+cuTYTeUJ6QSbyJSKJnZBnGRIMVSbA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46kp7ms5uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 23:14:06 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 12 May 2025 23:14:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 12 May 2025 23:14:05 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 7975B3F7077;
	Mon, 12 May 2025 23:14:00 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>
Subject: [net-next] octeontx2-pf: ethtool: Display "Autoneg" and "Port" fields
Date: Tue, 13 May 2025 11:43:51 +0530
Message-ID: <20250513061351.720880-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA1NiBTYWx0ZWRfX8jK3UktG4zw6 MR8qtciL4M48V0QirB5ysIO5bCxMrVZqs8bnALySopIV9nefBnqwTCVzcK9FT0BRg04HF1wkHGX rWK4oQ0s1F/GxLZPVW96PPVZskcRLSDh6yDoOWWor0bi7V7Gl+VQvhwj7ChHtdNI5GXVCR9DWUA
 d4J3MKTQfZSQin3mS/DItabj9nNouKUnZkcDHeEHUNw0pXLDGpNRMj7x4IFl9h/v5lk43NVVSx1 /sUw6nUM+xiP7UZ8l/KYB4KzE0H9kFh3X5guWNS9UMbLaSCfA+nf4afQm9WQeFCqIuuZOlV2ei9 ync4lcAWjePvLZ9Amr9pulXVVShP7eDampL0K228ljjcbzLQ3GVYUw8lnPBes8uPAA3LsvkGYXk
 b+TjzO81DhLqSrpew7YcA8zgBVJdOqdRLgTWWPKqKBvQ2wkMOXSkwFuKIo9lkIbv7yC4Wg5i
X-Proofpoint-GUID: Y_e93pHQV3kUXwJoO2xfK9CxvAE4sapw
X-Authority-Analysis: v=2.4 cv=YsYPR5YX c=1 sm=1 tr=0 ts=6822e32e cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=kqO5N8cHV_PgJFjelC8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Y_e93pHQV3kUXwJoO2xfK9CxvAE4sapw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01

The Octeontx2/CN10k netdev drivers access a shared firmware structure
to obtain link configuration details, such as supported and advertised
link modes.

This patch updates the shared firmware data to include additional
fields like 'Autonegotiation' and 'Port type'.

example output:
  ethtool ethx
	 Advertised auto-negotiation: Yes
	 Port: Twisted Pair

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h          | 4 +++-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 005ca8a056c0..4a305c183987 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -652,7 +652,9 @@ struct cgx_lmac_fwdata_s {
 	/* Only applicable if SFP/QSFP slot is present */
 	struct sfp_eeprom_s sfp_eeprom;
 	struct phy_s phy;
-#define LMAC_FWDATA_RESERVED_MEM 1021
+	u64 advertised_an:1;
+	u64 port;
+#define LMAC_FWDATA_RESERVED_MEM 1019
 	u64 reserved[LMAC_FWDATA_RESERVED_MEM];
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 010385b29988..d49d76eabc07 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -1190,6 +1190,7 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
 	cmd->base.duplex  = pfvf->linfo.full_duplex;
 	cmd->base.speed   = pfvf->linfo.speed;
 	cmd->base.autoneg = pfvf->linfo.an;
+	cmd->base.port    = rsp->fwdata.port;
 
 	rsp = otx2_get_fwdata(pfvf);
 	if (IS_ERR(rsp))
@@ -1199,6 +1200,10 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
 		ethtool_link_ksettings_add_link_mode(cmd,
 						     supported,
 						     Autoneg);
+	if (rsp->fwdata.advertised_an)
+		ethtool_link_ksettings_add_link_mode(cmd,
+						     advertising,
+						     Autoneg);
 
 	otx2_get_link_mode_info(rsp->fwdata.advertised_link_modes,
 				OTX2_MODE_ADVERTISED, cmd);
-- 
2.34.1


