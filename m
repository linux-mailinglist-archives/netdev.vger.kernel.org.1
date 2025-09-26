Return-Path: <netdev+bounces-226665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FADBA3D50
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117B91B20EC9
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 13:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59C92F60B6;
	Fri, 26 Sep 2025 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b="i2lcdMA5"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-007fc201.pphosted.com (mx07-007fc201.pphosted.com [185.132.181.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4784D224FA;
	Fri, 26 Sep 2025 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.181.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892438; cv=none; b=AW9LsavHiPOrgWbjJA4gQYmXGMLsIpRAUZktuR2ZuAFmPDQj/uLedWV+dVqEmzCJRNiYoTC2hpI1LrdvV5n4kr1iePgzLNMtQ/3UaBSKZ5e63MrK4k3chCpY6H5ohkDM9iJHMtDiyaoADzDR4FDMLERgnga/KAwL/nI0eUK9bZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892438; c=relaxed/simple;
	bh=HQ0TjsXdnC2h7hCUsr1iSIh6qz11PRKG9AQD+nvtaHM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qQhvXoltfjR5PfnDtflmwVe0Dij5jypfOhozCdXR4DAZiqmMg7DAD6WiVbeIwkTCgOPD5oZEd5RXJTG2EhuDLeo7RIiR2dEvfDBCMPbtvmZJL9FMEMNkI9THDwexAPgU3Ok450Y40vcRcknN3FXhqe4/Y5ik26widUIesX1Ojk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de; spf=pass smtp.mailfrom=cab.de; dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b=i2lcdMA5; arc=none smtp.client-ip=185.132.181.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cab.de
Received: from pps.filterd (m0456228.ppops.net [127.0.0.1])
	by mx07-007fc201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58QDDmQ72098326;
	Fri, 26 Sep 2025 15:13:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cab.de; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp-2025; bh=ccXHebrV/0XdmkLpSozUT0ib
	VxcklXejuOTnEV1n578=; b=i2lcdMA57xoKVVQh4FvQNi3GKMgnsVdLWQySbqg7
	QeQszRdwNfzs5GTULNDErrLheCA1wo52vd4FHjVe4xPW/HOZQLYiE8MXCywLKqIA
	VCPyy77AMDG2vJxuDHAuDih0LpITskOXIPbn+VZFf6+5ELaf12QePP9DG+Aj3STA
	JrIsbOJP83GCjyeJAnhFVyVfU/aWD3PeSR8bFzFtmiNSw+iZXP4isft9dQcaWhIN
	qf7BwMpzDb+L8CXzXa7k4V3JZHEEHYe5u6fcPSrZqHRKrQrCoAa7XjwjtT6kikI4
	W1/BRaMpODm9eAsYto4JW5Td+krOc51zts7BcIC2lnU0JQ==
Received: from adranos.cab.de (adranos.cab.de [46.232.229.107])
	by mx07-007fc201.pphosted.com (PPS) with ESMTPS id 49dbt3g9b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 15:13:47 +0200 (MEST)
Received: from KAN23-025.cab.de (10.10.3.180) by Adranos.cab.de (10.10.1.54)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Fri, 26 Sep
 2025 15:14:03 +0200
From: Markus Heidelberg <m.heidelberg@cab.de>
To: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vladimir Oltean
	<vladimir.oltean@nxp.com>,
        Markus Heidelberg <m.heidelberg@cab.de>
Subject: [PATCH] net: ethtool: remove duplicated mm.o from Makefile
Date: Fri, 26 Sep 2025 15:13:23 +0200
Message-ID: <20250926131323.222192-1-m.heidelberg@cab.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Adranos.cab.de (10.10.1.54) To Adranos.cab.de (10.10.1.54)
X-Authority-Analysis: v=2.4 cv=fOA0HJae c=1 sm=1 tr=0 ts=68d6918c cx=c_pps
 a=LmW7qmVeM6tFdl5svFU9Cg==:117 a=LmW7qmVeM6tFdl5svFU9Cg==:17
 a=kldc_9v1VKEA:10 a=yJojWOMRYYMA:10 a=T-h9KMRQKiC5iZaHfPcA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 1RKkIk0Sc6IAOPkZLw0gOlgJLSYeN52T
X-Proofpoint-ORIG-GUID: 1RKkIk0Sc6IAOPkZLw0gOlgJLSYeN52T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDEyMSBTYWx0ZWRfX9Tp0E7Pk0paD
 zMam+em4glds69vG7lMdPelUlZ7SNcwmQorGySzLJxLOGpRtTL3LViKLbaBOl9wGpUjPMjYNIAJ
 fithJgXDV1XAWJB1bIva5cH9UOUhfhc1sloT4YxdllRQN7YsgG1UfgOPTqob7t6zL61t05RxcAz
 fdiN225UlNLwonJQ9nEVsLBK+8vm+FvXS4PfTGbcUAsW8xPlc+pzQiHKDedzNpJxzkfuuVvjb4H
 HMHKcHnfR7y2BraCBm3aDqjvarqTaj+2N1UBSI0OBWK4klhbqExyzuHwFtf6Jt1xRt1E9iP8yGh
 rEB3cGUd0NRqnXdMwQxerQv2t70n70yNOTLBV4bjS9JSrRYnvUiZnb5pwiJogeUaDfSUyWJRoRc
 UT45dY4tiHFyIZH10+EGnvupR50U5Q==

Fixes: 2b30f8291a30 ("net: ethtool: add support for MAC Merge layer")
Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>
---
 net/ethtool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index a1490c4afe6b..1e493553b977 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -8,5 +8,5 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
 		   linkstate.o debug.o wol.o features.o privflags.o rings.o \
 		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
 		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
-		   module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o mm.o \
+		   module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o \
 		   phy.o tsconfig.o

base-commit: 203e3beb73e53584ca90bc2a6d8240b9b12b9bcf
-- 
2.43.0


