Return-Path: <netdev+bounces-168089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DA9A3D6BC
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356BF16CD12
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F541F0E5D;
	Thu, 20 Feb 2025 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="UciR4ap9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CBD1EFFB7;
	Thu, 20 Feb 2025 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047429; cv=none; b=U1fMPFDduwlzECu2SQUiqi7M6Gq0/lvSb2oGvL4UHAa46CgdSE8ill8Vc2rUK/Q93rfwGJkfAW/yvXsJcKKQH8qwYBDcrTorgiMlrqYnDeJLJFQivkNNDPlDcDyEBXtYdUGbO4n9yI6d+HeuIFKiqD+bGRa6DqKrRzsmrrmMsrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047429; c=relaxed/simple;
	bh=aVI7MSpA6JJtCSJZog5P27jj8+A5s75+FcDCBidxMWI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H+K6tc0MuTOcHlMEdQP6nTXkR6fObOkl8y+4uj3cLiEWVH8N5npJGrXJ3BfJ7mV8YkWzsLP2LoMZWXoTwd2vXCpxEyMRoMapmnQU6+We9ipBQJDDSn/JMzTLZmIKgJCTVkVQCZUTn1xwtFiXaUSODfazta2VW94ltbuJ4AKpH3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=UciR4ap9; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K22eLk011860;
	Thu, 20 Feb 2025 02:29:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=7+ODaABIcK9e8YYd3/ydv43
	56SWmM7kNom438gXWxdg=; b=UciR4ap96cnb3AuhkbwyXmz7n3+5GTsr4WsVUTB
	pWX5Bhh9Eja+VtNM8skI7t3+dNOenEPibUZnRCCnlem2rJioQLOo0n0ZeTiVTMJS
	RzUrobyz1HB4Vbz+nvj6w+j7KvIGOipRoKz8rfuQmtRNlkFaLmw4lbLZVjgcGScf
	Tq2PWqsBIBik48It6tha5UUcTF37QHqVtrzsSFveVi7XMCIJG2+xXCG2+leocm8H
	mHZwaBtljjvYDZaHyjEkuSsIJNJUIb0DWJ7d9x3JWtBdyuHc4mzOMLrZV84dnxUl
	UYZYGz6exX4y0Ycvh9iY3agkD+RDER+aYgunabZNjyybS0w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44wu8p9120-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 02:29:57 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 20 Feb 2025 02:29:55 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 20 Feb 2025 02:29:55 -0800
Received: from localhost.localdomain (unknown [10.111.135.16])
	by maili.marvell.com (Postfix) with ESMTP id BA18D3F7073;
	Thu, 20 Feb 2025 02:29:55 -0800 (PST)
From: Harshal Chaudhari <hchaudhari@marvell.com>
To: <marcin.s.wojtas@gmail.com>, <linux@armlinux.org.uk>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Harshal
 Chaudhari" <hchaudhari@marvell.com>
Subject: [PATCH] net: mvpp2: cls: Fixed Non IP flow, with vlan tag flow defination.
Date: Thu, 20 Feb 2025 02:29:54 -0800
Message-ID: <20250220102954.609564-1-hchaudhari@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: P_1Q4I8NPeAYU6caooYniiUafw_FmdrL
X-Proofpoint-GUID: P_1Q4I8NPeAYU6caooYniiUafw_FmdrL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_04,2025-02-20_02,2024-11-22_01

Non IP flow, with vlan tag not working as expected while
running below command for vlan-priority. fixed that.

ethtool -N eth1 flow-type ether vlan 0x8000 vlan-mask 0x1fff action 0 loc 0

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


