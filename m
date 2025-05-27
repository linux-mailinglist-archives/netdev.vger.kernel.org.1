Return-Path: <netdev+bounces-193648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C1FAC4F57
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1088B188C517
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354BF2701D1;
	Tue, 27 May 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kjN84Y7V"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7422701CC;
	Tue, 27 May 2025 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748351327; cv=none; b=rxuVg0WPAcOkK08glnHbNr2Noq2yYslusjP46iad2OxC1MakOH8ELEFptMW66YOa3VxKkeFiwDXGJvPcKpo2luzDqQ7aIhEgKI7hOox23BofQeWvla80gDm0iNGQD3H9Cstpt1UnWCNYZ+TWgnYuIMygwdje8Vo5DVAPrt9ah1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748351327; c=relaxed/simple;
	bh=vcFeUz3dFxQDrwJYtYjo5wMuJZdGBPkvsXvsnI3Lf4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJlvtkRo/OWlyZIcD3nqEyEiYot4/NM1OS/JXIG78+/50ZVDdMmwOgTZ8J8u2uy7NcppFX8uo305Rwm4yji21OX3cIOWQoT7qLzcGJV/ZtF6kPAOmn0gR6oUMNnCBB0Kcn07HHhm3xubKtXriBugYzUjAtXZHjr20lK4Mb965ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kjN84Y7V; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RCjhII025608;
	Tue, 27 May 2025 13:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=xn1YFCL80fjRjbit6rFph5hfLTwHU
	TDwrB8C2k2AnVM=; b=kjN84Y7Vy3Lr0ET3MygUv7DIPL62khb5xJA0iZ/iwzg0/
	KQLqfo56d1F/xX+tRO1OgOY25f1CgzXu8oMIs6CCVYJptVZfk1VUICIg5ytwnfAt
	xmkhlxwbVZ0IQ9q7jtnmHNOmpFBIreQXb3Q2aMOYx3qHSd4r8+Kk2OZClMfGoCTd
	eowEIq/qel30SIYvw/5btV2t42w7SYQkmp4HU5eJRxbYjH3FW+qQ9SEqyV9JXcms
	rIiwvxDzjV/vNQ3BjtBeeofglAYMeFV4AcTp5HvtHggJa93AO5UkBacIvl4kf9me
	IDFW7QmrnxCDkPmLuYMBxmT4ud5+tYeDArZXif7Ig==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46tu37j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 13:08:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54RCd110024426;
	Tue, 27 May 2025 13:08:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j93njy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 13:08:34 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54RD8Xx5040782;
	Tue, 27 May 2025 13:08:33 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46u4j93njg-1;
	Tue, 27 May 2025 13:08:33 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: ziweixiao@google.com, joshwash@google.com, willemb@google.com,
        pkaligineedi@google.com, pabeni@redhat.com, kuba@kernel.org,
        jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH] gve: Fix RX_BUFFERS_POSTED stat to report per-queue fill_cnt
Date: Tue, 27 May 2025 06:08:16 -0700
Message-ID: <20250527130830.1812903-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505270106
X-Proofpoint-GUID: tBiwi9u0e3A3bn3ARgO--e1PUcKAfpkw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDEwNyBTYWx0ZWRfX9+/MeK1yoLMQ PXZz4G9sIyUdR0YpuDCv+lReS62yQ5EuBhBbSceAuTKolWpG0NQ6EP8lJAGWC78JTAOLoNLW8n+ pQrr3Jlf2iwIBB4Ovy+nKeFA4nmHlf/eyixYHayLIwMofaFtD5LvZoCvhpZy57LOvvkZcaHGStR
 kSpvJ++Z3QTzSsd8ULfC3MBaDExOu7LdX22aqaDHR3yVUoemX9m2Ih69Tt8lSA4iGjG6XWFbhLn dJsYRjA9MHDkTVYENFkUJfs/MObsRE5dOu+NK8xnPBSkyLcKsWn/hWGDA5sfMaD1eZTz7++NJZd kn7LfmqsVEtEB0K0q7sWihtNnV8retXKg15p7EIu/tyhM6C5mvV1jZ7Z/ftFRifQk9/MBBZdHOn
 MnmM7oy9cAcFTUwSpQO5wyrl2Vdl8jQJzzJIlur6NX0jd+hq5II62FeVb7vznF4ERbCvOHBI
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=6835b953 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=SUWBHirP-6E5t1gQD9AA:9 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: tBiwi9u0e3A3bn3ARgO--e1PUcKAfpkw

Previously, the RX_BUFFERS_POSTED stat incorrectly reported the
fill_cnt from RX queue 0 for all queues, resulting in inaccurate
per-queue statistics.
Fix this by correctly indexing priv->rx[idx].fill_cnt for each RX queue.

Fixes: 24aeb56f2d38 ("gve: Add Gvnic stats AQ command and ethtool show/set-priv-flags.")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index c3791cf23c87..d561d45021a5 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2153,7 +2153,7 @@ void gve_handle_report_stats(struct gve_priv *priv)
 			};
 			stats[stats_idx++] = (struct stats) {
 				.stat_name = cpu_to_be32(RX_BUFFERS_POSTED),
-				.value = cpu_to_be64(priv->rx[0].fill_cnt),
+				.value = cpu_to_be64(priv->rx[idx].fill_cnt),
 				.queue_id = cpu_to_be32(idx),
 			};
 		}
-- 
2.47.1


