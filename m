Return-Path: <netdev+bounces-123153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE5A963E11
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2075A1F22B8A
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32F2189F31;
	Thu, 29 Aug 2024 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PPueZOkY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7682D15DBC1
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919003; cv=none; b=J9wKgMbjU58PeQN4oFxdRLunHMFtCSOQyQtJELgu3sH14lodDSKpxIqAqdeWt/QWHj0RSx5SiRLB4SXh/c4Rv8sCKmV9prFExEsZm8BnVBBpQlI2rqKaI/JmEnJiD8Yq897MCusjn7hGkwD/2On7s3+hjGSGc1P1Pr30xa+HFVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919003; c=relaxed/simple;
	bh=if2GYpkvY05wYayJREk2tk8NZsGdMkrwwINWN63iriY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iiuhG/VRZKdpe9WMuImUQvj8l+OfECUBsQ+LBBF8auWxFWPR5A6pexKBTbzjxIm9i7sejGJfNt0/AQWGJyn5WsuJfeJ0WYQJObgFwYiC3iP394Rmf2woj8yfL6Him2T9A6hPOsLD2Mrbqym9LN3nRQgD0GYBtPiQ7LNhkUCKhDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PPueZOkY; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T4Yxh1023415;
	Thu, 29 Aug 2024 01:09:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=hvl7UJLse9fR6aKoVY82o+F
	rWdKnDSBedBdFarm6Z6c=; b=PPueZOkYrt4+dqG03KUDmviDtleUeGu5IOUxnZk
	sFPC0ivm0yw53cNVNZU8g7/wTE6tbzQWarl810LhWx24ViDWAxjlct/EtJJja9F0
	njeHEywpeTk7d7nPdxy2/zGXEnpjGSsqzDccNPT9QNfaJ8QmUk9adVP+5Jo0IUz0
	4Se82NIrAkrfEm5hK3H7A0gOA6MW26H67PVtPiLN0HcfrHWg4fRtbGuZ5eYe+syM
	RTJN4yHSModtkSKFA1xRGA7Gf/VS25jZowP2P3klbzshocv4HkttZMkLLhSqJl0u
	VLs3ugUbo9DuHkTy7VARF/KlQKzgzExvIYKXGmXwPA+4k0w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41aj340r30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 01:09:43 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 29 Aug 2024 01:09:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 Aug 2024 01:09:41 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id A9FD73F70A0;
	Thu, 29 Aug 2024 01:09:36 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <bbhushan2@marvell.com>,
        <ndabilpuram@marvell.com>, <schalla@marvell.com>
Subject: [PATCH net-next,v2,0/3] octeontx2-af: update CPT block for CN10KB and CN10KA B0
Date: Thu, 29 Aug 2024 13:39:32 +0530
Message-ID: <20240829080935.371281-1-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: GcVN5kXDszyXdjcWF6NAoSaK7Gi1Ie9s
X-Proofpoint-ORIG-GUID: GcVN5kXDszyXdjcWF6NAoSaK7Gi1Ie9s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01

This commit addresses two key updates for the CN10KB and CN10KA B0:

1. The number of FLT interrupt vectors has been reduced to 2 on CN10KB.
The code is updated to reflect this change across the CN10K series.
2. The maximum CPT credits that RX can use are now configurable through
a hardware CSR on CN10KA B0. This patch sets the default value to optimize
peak performance, aligning it with other chip versions.

v2:
- Addressed the review comments.

Srujana Challa (3):
  octeontx2-af: use dynamic interrupt vectors for CN10K
  octeontx2-af: avoid RXC register access for CN10KB
  octeontx2-af: configure default CPT credits for CN10KA B0

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   5 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +++++
 .../ethernet/marvell/octeontx2/af/rvu_cpt.c   | 124 +++++++++++++++---
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   1 +
 .../marvell/octeontx2/af/rvu_struct.h         |   6 +-
 5 files changed, 143 insertions(+), 23 deletions(-)

-- 
2.25.1


