Return-Path: <netdev+bounces-189524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBCCAB2872
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 15:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC853B546A
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 13:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D70E198E6F;
	Sun, 11 May 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aoYlh6/V"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33FFBA3F
	for <netdev@vger.kernel.org>; Sun, 11 May 2025 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746969785; cv=none; b=nENBVtDnMrTKtX2q+ZVe5Ssh2LZLwDaDaTSQRO8st/93rohh6VAG1uMbc+8ewtyTe9DtPyvkevfNzGC90gr8ZjRMXNPyqLOwgmB+rACm0/mLqDXMxlfpQF6rtzdNc3brse4beE0D6hV6ZFwF/fNmXZ8U9u2D/3Fss/tZdjdIo7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746969785; c=relaxed/simple;
	bh=MUUm5iAnUfOCHQEuOw4kGJpxRa3UoZ/0SqHsLEglhZk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W5VXmB80T/f6vuWSqFYiiF59LOggjPFYRuZ4spRGoc5fAhyvF8HtmG5ST0iJhgsJMskS89U21R5ZcZp+4I9xej4/d0JYxK6Sh776nxgG0yPsZKX+DsZOzfGwCtx3niDz6cbPvwa3Zt3zw2uxLpvRSwQo7K/NYaYOMRSw9pE08S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aoYlh6/V; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BCPnq9016796;
	Sun, 11 May 2025 06:22:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=c7ombRKAqYaF3N14S9utGoGTlWq1v7wSscxqQT5w+r8=; b=aoY
	lh6/VxQJCwaAgfMlzvTzVfCT2wCAb1YTnAwo50IcXaOm1u4ybp+V3anvJS4ALrqh
	Vx7S+sNDjScWUp4pZDtpVXlON2458NEgDc4dwVVT/6+C0Ym0JYbOHV6AQ/uhVEP9
	EQcl7LXxd2CD7xCgI5ndJJAQR0laNbYOGd0JgWQoLyfS6+8bTpQZu3K/tkfQ4nX6
	ntAGIDXG0SSgWczkqd6kghUZqw/nOhY8tokM+n0NLoJ+gbbCCg2L707U+s0s0SXJ
	SRGzfM8HWnlUcmN8fimt6y9pG7YarRDuaay0yLpF345c83dwCVvgv6kVIayVbdX1
	vmlRkdmNJgMCaXB44Qg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46ju2b82u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 06:22:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 11 May 2025 06:22:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 11 May 2025 06:22:54 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 5E2CA3F7087;
	Sun, 11 May 2025 06:22:49 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next v2 PATCH 0/2] octeontx2-pf: Do not detect MACSEC block based on silicon
Date: Sun, 11 May 2025 18:52:45 +0530
Message-ID: <1746969767-13129-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: o--_gymFpxKvGULsR2wWq3YsP0JY9ySg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTExMDEzNyBTYWx0ZWRfX++13uwXxyg31 3nVtwIB1c9Pn1nV3GxYaOhD5YT5rknaUpF99ujMovURM0HYHC0uFxfE5Nnq8FUWnsBR1mlBlNU5 bYtrVmAGo8RDDwE4H2XH5SdSzGggYKpM7NVGinBCHRxaXEWSp801pKRByTh04bEPbAiBJp0AN7I
 CJZoeETI+DzEGnFswHq0a+ewJ69s0AROf4kli7dYIPc56488u6uCMsgULeShdP92lBKtPRdttBS vLOevSZC3uliemTEUz+wV2eLUNbETLaDKTrDBVNx2/G2avMTBHfOyA5JRKahVyXWxTBVYDA+Fob sh0dAHJt1HtxtpRYcq1GwRZhSrdZx8PjRyTcX8NCAq8A28anyAJXvJQd9FPVHtfRvm/nP8kjltu
 EapAc4ZL0X2JYbHs1u4HiY1X0Mm16gHnrbAXSzju6nozjFXm5nH7VNFFhl4agGhjGYRwRrzg
X-Authority-Analysis: v=2.4 cv=DY0XqutW c=1 sm=1 tr=0 ts=6820a4ae cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=Vyz-oGtGZ4BesLdMQXsA:9
X-Proofpoint-GUID: o--_gymFpxKvGULsR2wWq3YsP0JY9ySg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_05,2025-05-09_01,2025-02-21_01

Out of various silicon variants of CN10K series some have hardware
MACSEC block for offloading MACSEC operations and some do not.
AF driver already has the information of whether MACSEC is present
or not on running silicon. Hence fetch that information from
AF via mailbox message.

Changes for v2:
 Changed subject prefix to net-next

Subbaraya Sundeep (2):
  octeontx2-af: Add MACSEC capability flag
  octeontx2-pf: macsec: Get MACSEC capability flag from AF

 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |  2 ++
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |  3 ++
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   | 37 ++++++++++++++++++++++
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |  4 +--
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  2 ++
 5 files changed, 45 insertions(+), 3 deletions(-)

-- 
2.7.4


