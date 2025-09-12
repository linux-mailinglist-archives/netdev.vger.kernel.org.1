Return-Path: <netdev+bounces-222608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A8CB54F93
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA6D5A55FB
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B722612F5A5;
	Fri, 12 Sep 2025 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IuB1hPcA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043EB1D6AA
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683909; cv=none; b=cThJcrNPIvlC0IjutVBUUJpbEssf3vNGPY5T0HTy0DSPrZiO8H9GnBGIxTdHC8vV4NsTI0+pir8E9KadS1FSfczzv/62XW1+Z8qtNKKl+a0UKHIK9qh7TiY+kVHgxx7Vxx0SF81BCJovHBnj0DsZmd4K3RLdCo5zl+MfPZUfuj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683909; c=relaxed/simple;
	bh=EOTi/TK/oJV884DxbtG+g0G+c8SUGR+qUHRJKGOa7pU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kHNGopGQJ3szGivQg2m4uIQcvxuV8BqKcZNNNKa2J5cnuAKZv2uqaOgUKrMJBm3wS6GpgbrrEK82ER7lmfy9DONqMVu+pCZ+lRubmziMepMBSt76IepaTwQTBF541OheZi2a4xpJZccTczeUy38W5jjyi+XF+JxMINRwH2LBY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IuB1hPcA; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C2hcXB028100;
	Fri, 12 Sep 2025 13:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=tuMvVsNB23IjiAcbEEICeRDsBsXZ3
	a3A2OBE2YnR/4c=; b=IuB1hPcApA/NXsc0Qh5mLSUDt5J/3ToSUdV9Yt0CA+rsw
	OE2mM+t5Oqvad5xtuN8Pur08dnsfQTCfBubNbLlka4MMTyhIoRafl8IYOL+vQUeB
	iQt3a4mPfQCTriS50MaJk9hJ+h3N0Mz5qZt3pFdLylO4Yj2gMGD8wqa//SGLYQ8N
	hJxMO4uH+af3ynmu1up0sytZJfhdBqe2w6Fg0ywVRy9ByNUxK5dAfsAe4gJAkc9k
	HHIbbStsA/8zCp/ofwr7BCS2OOxOmgsRhCNQvi431HhUSh2IRuDhO5Mf3ZaDihr5
	iWEBf9J1KgkIK0tfvdX6/82uFfk1kCQdG5MOALobA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922sj04hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 13:31:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CCaVwm013865;
	Fri, 12 Sep 2025 13:31:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bde2ayg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 13:31:35 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58CDVY4x002365;
	Fri, 12 Sep 2025 13:31:34 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bde2axq-1;
	Fri, 12 Sep 2025 13:31:34 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net-next] bonding: fix standard reference typo in ad_select description
Date: Fri, 12 Sep 2025 06:31:30 -0700
Message-ID: <20250912133132.3920213-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120126
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c420b8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=fhbEuBtg5PAJj_auYQMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfX3Qcn6IhZa7LJ
 QTakjB2S1+6z4CdEMnQ8+V9JJ1H0NCdrnrM15MRqQdPBrGq8J65eEJveeDz6Do50xqP2krychs1
 EXbi2QAUgyvTKc9hq0Dwd31NttkfmM9jw3sJNv2aM56eR2i2+trq8IvkGCP1TZLh1K2EOAt3BWj
 65PUXPxtAzV4kSdmBJgHBsZx4VzYy+qpVMOd1qj55gkDCNpO09QEoOMckRa8ODQ7/pr6VgYT850
 EAKVsZbzToC0GiNSy+kEns4rDQzS6c5k18wg6Ci9zw7tMi9pHp+jH9k5xRPrDrs2P5jbuDtqfg0
 lDQUzy/qa6e/OnsfzvwMieY+63BWJt2f40k6APLRykfnQJmq1TqMhZONDi38nmq7SWxyZefhYe5
 DF9gbTLE
X-Proofpoint-GUID: _43lEVKguIGqIeF5uwH8fnjmsEFz_brI
X-Proofpoint-ORIG-GUID: _43lEVKguIGqIeF5uwH8fnjmsEFz_brI

The bonding option description for "ad_select" mistakenly referred
to "803.ad". Update it to the correct IEEE standard "802.3ad".

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/bonding/bond_options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 3b6f815c55ff..5b967522b580 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -370,7 +370,7 @@ static const struct bond_option bond_opts[BOND_OPT_LAST] = {
 	[BOND_OPT_AD_SELECT] = {
 		.id = BOND_OPT_AD_SELECT,
 		.name = "ad_select",
-		.desc = "803.ad aggregation selection logic",
+		.desc = "802.3ad aggregation selection logic",
 		.flags = BOND_OPTFLAG_IFDOWN,
 		.values = bond_ad_select_tbl,
 		.set = bond_option_ad_select_set
-- 
2.50.1


