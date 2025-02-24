Return-Path: <netdev+bounces-168893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A0EA41556
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 07:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037D43B3F44
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 06:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30641CBEAA;
	Mon, 24 Feb 2025 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="i3IiGxEc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BB41C6FF3;
	Mon, 24 Feb 2025 06:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740378600; cv=none; b=qLCLOEASZ45ZD62tFfBveiZLwQHgz4PqzRhd0eWOLQJoGeY2WoMI2h29FMA+j+xqNrI0HV/tYpijl6SMP3hW6+OlOLOa0BrGCosuNP25AmzAiIwR5XTHwL00pnkQN3Ai3mzLACq6yrE9mp7trve3ZGtHiefrN1w4bI/FrTALa44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740378600; c=relaxed/simple;
	bh=YVsDtyqTxPJIZHLawY8vKzQMRCjme0GSRmVavCWwFtU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pAPcbz3gY3VFalgA+Dg2myD/81ta1UWu870d55zAc75MwjdGGSgOV4OA/J7sKYaWS6QdsDVpN091y9jpNzhhR7s3cn08LP1TUygZOnVG33DZ9S/i4ZIRiVixICil9Ok6J7ZMFr/l1LAU54sxaO3rzSRisgBsfzLnsHeuvtcUtco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=i3IiGxEc; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O519nw003072;
	Sun, 23 Feb 2025 22:29:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=LaVl+u1W0NCCSosgbI0Qoc6
	M45Ml9akeZq79noOTqVI=; b=i3IiGxEcNg/v0qmEtzgYmifx3l+9FIUtYOyI5qC
	cj2ikCX2b2LWaqjMMdpKvE6YfuZoJhtdpc+KvwIbHp0i1lLPkH1IIbs0fDPQRhxx
	dOD7pRm1riU8u1IlwpFT+T+wBEO1e52R6L3v2+7m5lXMA/hvb/m0bXFjxkAT4e3c
	am8/jvioqySiohNq+oVBgX3Xqt76L364Tvd/KnQ3BKjEpQTJnR+rlK2kZaQHpZ2v
	BKS/5nkUrqSvUu0pNAlZYvQT4wSUOaTu7uq9erMmigaI/C586HGKoJ9tQx1T6YEl
	ckvZa9NPD/S0rOArpuwwDMh1Yk83uc+TCmyy0dkIDJ5ZwWg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44yeyktw2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 22:29:44 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 23 Feb 2025 22:29:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 23 Feb 2025 22:29:29 -0800
Received: from localhost.localdomain (unknown [10.111.135.16])
	by maili.marvell.com (Postfix) with ESMTP id A07613F7067;
	Sun, 23 Feb 2025 22:29:29 -0800 (PST)
From: Harshal Chaudhari <hchaudhari@marvell.com>
To: <marcin.s.wojtas@gmail.com>, <linux@armlinux.org.uk>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Harshal
 Chaudhari" <hchaudhari@marvell.com>
Subject: [PATCH v2 1/1] net: mvpp2: cls: Fixed Non IP flow, with vlan tag flow defination.
Date: Sun, 23 Feb 2025 22:29:27 -0800
Message-ID: <20250224062927.2829186-1-hchaudhari@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: x6nw1Yxnm5QMTamh5MLJ1SqtlQAR4of2
X-Proofpoint-GUID: x6nw1Yxnm5QMTamh5MLJ1SqtlQAR4of2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_02,2025-02-20_02,2024-11-22_01

Fixes: 1274daede3ef ("net: mvpp2: cls: Add steering based on vlan Id and priority.")

Non IP flow, with vlan tag not working as expected while
running below command for vlan-priority. fixed that.

ethtool -N eth1 flow-type ether vlan 0x8000 vlan-mask 0x1fff action 0 loc 0

Change from v1:
	* Added the fixes tag

Signed-off-by: Harshal Chaudhari <hchaudhari@marvell.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 1641791a2d5b..8ed83fb98862 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -324,7 +324,7 @@ static const struct mvpp2_cls_flow cls_flows[MVPP2_N_PRS_FLOWS] = {
 		       MVPP2_PRS_RI_VLAN_MASK),
 	/* Non IP flow, with vlan tag */
 	MVPP2_DEF_FLOW(MVPP22_FLOW_ETHERNET, MVPP2_FL_NON_IP_TAG,
-		       MVPP22_CLS_HEK_OPT_VLAN,
+		       MVPP22_CLS_HEK_TAGGED,
 		       0, 0),
 };
 
-- 
2.25.1


