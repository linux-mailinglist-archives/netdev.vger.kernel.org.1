Return-Path: <netdev+bounces-169298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51FFA43410
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 05:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19DCA3B795A
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 04:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF221459EA;
	Tue, 25 Feb 2025 04:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SYTO+lSf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63122EEA9;
	Tue, 25 Feb 2025 04:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740457304; cv=none; b=ZbStciJoEA0l+mJ1SQIIystm14TPO83QxuyFe9iRdZdOAbd00Q6COHjRwtjU21f6lsxdIZBl9jOv2ZFYjUzwguIoF6VRDL/rfYJ0kqmVQTbpQvGIYtChEjHqal+O2ZaStuSICxL4NAGke+6DHw0Bcy/1uf8i3MzJLOM9SzQdwmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740457304; c=relaxed/simple;
	bh=H4OmXnztUEsPC7v/SI96osX4EalFKkfsxVy36yEaTZQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i4Og9rMV17wYtBci1LyUcA/ZklzOLEGmXpwNHRciq8en8mGVERS/4OBTsPHxxeJ5Pmd3mZ+1Awjs5uxL2zZ+DrLcL/YwTc+CvarjHGOjI45ImwWYDYm3AGme1BZREsGk5xh8rWFGuF+VLtFoTlyQ4TBFgwp1eAGtRh31GIywoHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SYTO+lSf; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ONUUHQ004527;
	Mon, 24 Feb 2025 20:21:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=5owx7nFq6qHKJn0Te52Tnn3
	1Lk4PLT722UG2bOCfBHc=; b=SYTO+lSfbIhvU+SDUPHOfjxkDrcLJl3C0JSoJ8z
	kXo+RseHHDN0Nj0pVrLn6y7lmUAUY2GLEQPrEYp2UV3vEqghXLED4xZVPkhovqMT
	l3AzMJONV/lf9Iso7DRwfUqeB5gRme0PgzhWMZf9Mel/NslpT4tms8B1bbaWK84x
	+4AdqQLagu2NDj6HcRfRIQE8T+NKxaGZafddF8bCTwlppbXus+iuUWlLVg8xbxwN
	g4KsBS7AJi61PZ5V2B9N/K/ft77u9XfArm0LPesRpuns/bhCThuULnxEpaAzUOMd
	Xw0SxFtYHfodAHDtqWgxGpBjKsJJcEtuyKr/Sz/ye6YMkcw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4512ge0hd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 20:21:15 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 20:21:00 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 20:21:00 -0800
Received: from localhost.localdomain (unknown [10.111.135.16])
	by maili.marvell.com (Postfix) with ESMTP id 551D13F7065;
	Mon, 24 Feb 2025 20:21:00 -0800 (PST)
From: Harshal Chaudhari <hchaudhari@marvell.com>
To: <marcin.s.wojtas@gmail.com>, <linux@armlinux.org.uk>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Harshal
 Chaudhari" <hchaudhari@marvell.com>
Subject: [PATCH v2] net: mvpp2: cls: Fixed Non IP flow, with vlan tag flow defination.
Date: Mon, 24 Feb 2025 20:20:58 -0800
Message-ID: <20250225042058.2643838-1-hchaudhari@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=P6XAhjAu c=1 sm=1 tr=0 ts=67bd453c cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=T2h4t0Lz3GQA:10 a=M5GUcnROAAAA:8 a=kR3TKN_x4rxgODecb9QA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: yUy462nxTJJH6JGJpKveUrqDc4m4wxGx
X-Proofpoint-ORIG-GUID: yUy462nxTJJH6JGJpKveUrqDc4m4wxGx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_01,2025-02-24_02,2024-11-22_01

Non IP flow, with vlan tag not working as expected while
running below command for vlan-priority. fixed that.

ethtool -N eth1 flow-type ether vlan 0x8000 vlan-mask 0x1fff action 0 loc 0

Fixes: 1274daede3ef ("net: mvpp2: cls: Add steering based on vlan Id and priority.")
Signed-off-by: Harshal Chaudhari <hchaudhari@marvell.com>
---

Notes:
    Change from v1:
            - Added the fixes tag
    Change from v2:
            - Corrected description format.

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


