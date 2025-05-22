Return-Path: <netdev+bounces-192529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE752AC046D
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04EA8A21952
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 06:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25857221558;
	Thu, 22 May 2025 06:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OhrQhfdm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5D84D8CE
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 06:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747894539; cv=none; b=PhdxY70BWYkqSv9t1duGSw5ie4qm5HTyOXBaBJpDWxCWWeZDHD94ReAVdGIID1wdyeH8bvqG44s3LFLcPmvFMHCx8+NXkHxN7KoCt/9h6WAgstAp9PZBG9LghQTG6IJ6UjpIq4GkDceSpPt4AbmfWXDjKeOjHEjcAuMarRoFCWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747894539; c=relaxed/simple;
	bh=KrIOScfNo86NSVsbBzT4cgirF+u5CcW7Hzgt+L9sXXU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PhhePBgLz3kMwMW8vqyLpkz1z1/YhC+zxYgHyLGRXG3EyLsMoZS/6OK/aGGEpyW4NbQ6BqMfT0XIYUj2yivoxEjEts9yMq7cLQkJaPqTGLWwm2v53wGSir3GRttDq8uIO0hbItfOIZz/LfgYxooNHWuad/tcG/bCwhUe+35ecqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=OhrQhfdm; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LNWPN7010312;
	Wed, 21 May 2025 23:15:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=snutPY3tOn5fl66GJavJHminmMFbyCOyR7fcbGR7HF0=; b=Ohr
	QhfdmIPDWexs+/34vovssLrFDGLdV2AWInGOyVpHuceCaUYQ4skF0QodWNK8bT/z
	2/Avm9zmRLIgZvgLhLMs09w1zEJq5VK4tPFDFPAFMNWs4hcULaswyycd1A3jG+Ow
	ACz13QmiI4Da9vUKXhx09K714fiXhjmjdvcMw5eChrtIEskluQnjJs3D/qbmAUfV
	zS28I5RX4AdogWTebHP8579wmFOXrEshfOE7D+fE9UaCafegvMQYT5D7umCqZApA
	OpdwrhSQgIcTgqg1986UzeMRXvWKfFSdr8tGtsw5w2dnYQIsh/epRvNqvpaYF1VM
	AqUzlTdv+ZYcaqWcSsQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46srka8kja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 23:15:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 21 May 2025 23:15:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 21 May 2025 23:15:23 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id A320F3F708A;
	Wed, 21 May 2025 23:15:18 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <sd@queasysnail.net>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v3 0/2] octeontx2-pf: Do not detect MACSEC block based on silicon
Date: Thu, 22 May 2025 11:45:16 +0530
Message-ID: <1747894516-4565-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: xSfDi1yPQW6JfIeMWIzKh0aLxwDLWg5C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA2MSBTYWx0ZWRfX7JmyY91D/JCJ txYm1Ge7oF16dDM7vrkvN901BoTreQMIYo5xr6il2Y80CH+IxLpo/EkooRUFKdiN54M5Jt8Gnct TuAhqao6cPZH6nwDqPWjwY/uL78uIJSH0QJ26S862vIjgHkDSkl5SgCNdRGD/iFvp4VejvUsb5x
 UlvA693T0q3Z2P8HAEY9rC+Tjf7UrOm/YTWkW2QkP+zR7zlTcs7SA56ouU1iHsDUhBW2796QZWK LcsWhu4kQpJr3+Bg0eAFXDGaGc4ONlWOopJ4O/IXdYpHriSeAw2hbvoqlyFgqKNizpgy9xjGNj5 Rjk23TEDncQvi/pAhhIXlut4vw4f9UG3/jAcwQNjn7lNobmwHKsrSGL4PZPRon4Z1a/XsnUCw66
 FH0/fyXzrsDbXfnmElLWUtb8EvImJa5b1emSTkaa0mvXXxXQmhQLPV0MJJrqyxAARbf6G/4H
X-Proofpoint-ORIG-GUID: xSfDi1yPQW6JfIeMWIzKh0aLxwDLWg5C
X-Authority-Analysis: v=2.4 cv=Bp+dwZX5 c=1 sm=1 tr=0 ts=682ec0fd cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=Vyz-oGtGZ4BesLdMQXsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_03,2025-05-20_03,2025-03-28_01

Out of various silicon variants of CN10K series some have hardware
MACSEC block for offloading MACSEC operations and some do not.
AF driver already has the information of whether MACSEC is present
or not on running silicon. Hence fetch that information from
AF via mailbox message.

Changes for v3:
 None. Resubmitting as v3 since there is no activity on v2
 for a while.
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


