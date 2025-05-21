Return-Path: <netdev+bounces-192164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ABFABEBAF
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D425D3A2823
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 06:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB4C230BEC;
	Wed, 21 May 2025 06:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="evMk45oG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F6512E5B;
	Wed, 21 May 2025 06:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747807733; cv=none; b=fFIeYrZ1wQy0Fm7QfX/vRS7cWpHe8fAWoJxLryMuVNtME0U10/1W47mYjmX82vXNLd7MYOw3cGd98PQ56bJw1cGmqvf/lyQQ4YLv1Gz+0No2xwEOIvrDJchG8TZgeHv0IbxcUxAtJdflyibIcRg4Y0d/3SxZpCfHAs/HR9tcWbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747807733; c=relaxed/simple;
	bh=fqCmeUHx0FwWnh1ReP+MONXpTkX28d/rWGe51x8Qv5I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RucjwVfkgdHwyZJNVItAyY+bt+pxZCFRH9jMkPIF4UVzTVBf3oPGnBrdcRFChTfmw1LNom5UJenn9P/R+BcqsRGtsOh5YV42/SVsOxZzUGCGMpohn7/O1Tvd0qEOS8TdliVmAyiYRaZak4wBzyeSv1oxJgkppUFSBaTADhFbUkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=evMk45oG; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KNcfu5031889;
	Tue, 20 May 2025 23:08:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=T9eaAaDeNeEfWA5paAwl9kYIyBBzTBWsa+OvJ7s2/tY=; b=evM
	k45oGlNOINk1aekJMZJ4TLiU3clO0f50HPhYZvuFlj9wVJzBeBkjE231m13VrCDN
	FJKKXMjRrwMZRrbX7xjWM10E5RSTGlEQTLmcHdEzP5xPh6HT6AARAcsnuqtKPwNk
	Xa59FDuPMGso/CEuGXeHlg2Q7Rn7OvWnUBZB1NZAzA9HkBi4AMC6tdML2jf81w/D
	kvNlLPOffTzwxArB/JA/aRLrhHQfku3z9PJIxRWBNh9aWpB7saECz9ZX+sTR4rxY
	cszCDjGNSfjkEr3AsrkHDr6ahCq006rGoOxSMeyb0uKXroZerra60bwSlbhUoBVh
	lk6iVXs6QCUyfswhopQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46s3kc8kg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 23:08:40 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 20 May 2025 23:08:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 20 May 2025 23:08:39 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 143343F7077;
	Tue, 20 May 2025 23:08:35 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <andrew+netdev@lunn.ch>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net PATCH 0/2] octeontx2-af: APR Mapping Fixes
Date: Wed, 21 May 2025 11:38:32 +0530
Message-ID: <20250521060834.19780-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jjTnz7CYTP4xqzFrfN-YgFACpDyF73L4
X-Proofpoint-GUID: jjTnz7CYTP4xqzFrfN-YgFACpDyF73L4
X-Authority-Analysis: v=2.4 cv=TcyWtQQh c=1 sm=1 tr=0 ts=682d6de8 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=73v077vbolFR-TuZ8xgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA1OCBTYWx0ZWRfX9nUJQycffXUd 7fqwUhEaYcbcdC6ot2FrTGGxs2KYfgyhhLWNg25EuJvH9l2DaShgajxl+3IONDK4vSybTWrWzvw V0yZPQufrKwBnmnTNhZWBL01MfhxmIPv6ALiANXc2b8J3cT7cUr6RE2cBZ9Hti1oja8MqO0UL/p
 9e9fluizM+V8nGZaKlXm9Dt4u9dL7Gks1qwikZJTsf3IL/WeRhgyPnYe8qj6vpv2V6mf4nrO0fi VV9a0bK6HhiI3KTsSwxW8Btl7UdrCsqfVXPCtDEi0T05d4NCIq3J0JyUbxH+NO258PxzY40L8jv /3EfXGO7SZYsXh+d3OD3CJPmqO6uiSNpHZXy70eZbOhaV50h4FDEH5m0KJQrW9VKIwToR2CfwOl
 +kk4hp4lF/hIE+r0Mvye+uTMoDVafwkEXUWrplg6WD4A8U+W87ZCXLqpcBZ2SSFga+CsuuuU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01

This patch series includes fixes related to APR (LMT)
mapping and debugfs support.

Changes include:

Patch 1:Set LMT_ENA bit for APR table entries.
	Enables the LMT line for each PF/VF by setting
	the LMT_ENA bit in the APR_LMT_MAP_ENTRY_S
	structure.

Patch-2:Fix APR entry in debugfs
	The APR table was previously mapped using a fixed size,
	which could lead to incorrect mappings when the number
	of PFs and VFs differed from the assumed value.
	This patch updates the logic to calculate the APR table
	size dynamically, based on values from the APR_LMT_CFG
	register, ensuring correct representation in debugfs.

Geetha sowjanya (1):
   octeontx2-af: Fix APR entry mapping based on APR_LMT_CFG

Subbaraya Sundeep (1):
  octeontx2-af: Set LMT_ENA bit for APR table entries

 .../ethernet/marvell/octeontx2/af/rvu_cn10k.c | 24 +++++++++++++++----
 .../marvell/octeontx2/af/rvu_debugfs.c        | 11 ++++++---
 2 files changed, 27 insertions(+), 8 deletions(-)

-- 
2.25.1


