Return-Path: <netdev+bounces-207540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DCCB07B5B
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 18:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6988E586514
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8DA2C08A8;
	Wed, 16 Jul 2025 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IGB87/jV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31FC1A5B8A;
	Wed, 16 Jul 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752684142; cv=none; b=KCDuZZLKWRzDG6gH3+6t5ngAlQ46GaOE9unO8eZZ2bJFL48t9N+PNVFaLtA9wCGHWNFWGX4nkjxXRBI4BjBQuD+qv7piCW60ge/CHj5odRmoetAyuzluiG1uDtllW/Uu38axVtdxaUsw4EQOz51fz+faGg43yt0UOnrIUnn3YXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752684142; c=relaxed/simple;
	bh=HLkFSJ3Iqi6kf1r1tXQQ2GlWdxejczsBA1++g4gUyu8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GKnURdjb6yCcFHVFcvq52rx1k5Fnhj5X71q5JKwXfJsx6+A0GJN8koQgG27HyaaiAdFWq+P5yHEoOphCsbNIqmGzFY97Lr5S88e9SazooskC6ecl2aKIpBgqY/hFmA6HQZ9TUdY9hCnMXNqJgXRmFQr0KNxHlY7R+dqsahBhEPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IGB87/jV; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GBmFft023111;
	Wed, 16 Jul 2025 09:42:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=RpxdBOIUoSa0bl8YwANvtrn
	DogE0m/NuwtJtEY7nF+Y=; b=IGB87/jVmYDkMO4IT6mY4FK7OiiCoYVB4/L8wBe
	2cIVu+XoT7L026faBXgEfJuzN0KvgXM+pBJupjaRMpvzxn+V2+YxgdaIcwJONicj
	4QRzHa4AhGOytSjap7ruCJNK7N0lfyp/hWL2y7xspDVjtFIbRXfeUDBUd5f4CnLx
	TV+fKAFXBBMkf6eyYLRDiE6G0MOxIakU5KwRGrS5bCv6mYgpVwljh1GsVrK4MRmF
	10KdeiILPe7V0B5Sr4LpxKKhS6CE0VWU9pNX8pB3i7cxNj5XF8QdjMhD85gyU19v
	RSSLmEQSG/gw+EztsRu7FHSJfIjtqgzU5mXKgEEl+9qxelw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47x0qjjpmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 09:42:05 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Jul 2025 09:42:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Jul 2025 09:42:04 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 09F163F7041;
	Wed, 16 Jul 2025 09:41:59 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next 0/4] Octeontx2-af: RPM: misc feaures
Date: Wed, 16 Jul 2025 22:11:54 +0530
Message-ID: <20250716164158.1537269-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1MCBTYWx0ZWRfX6P7quBh2WZOU rtCv6kOfoDWtmjOmE7mW7wved5HtyYD0dqv7nkdSl14R1bniOwjgH0q4XqdA3StEhzFXxyXB6NS pL0i/1NyrrFXMTYHDENlmz55dv7W1XpcOGzDT68HTyNZx6l6vMclC1leRu3ybNk93Y+AyYLzJdh
 dWuCUS+t5HUnFg7ex5zUpJDcKu8pGleACVQkuQWl/Dxt05eTawpRS1MQc78nqgb2LD5e6rp5h+c 9dqsIQMi2BR6DYeRGr0ehafAoRryhdPUQp+5ME7BCX/ZXipXFKCD+4wOdRVy6S/g+ZCUwHlFS9y yA4JFJxOUIbMIKrZH8W1VxdsEosJfC6oRsrR6zvOftDXBY2Sno3o8m3peIt/dNvesy2CWbVxCwr
 GRM3UFF25gEZfAgJJN7FDQo2cgggC6t00Da6OKrYq4G8tnX1TtULlbLvsKjjwNwj09nzLWwL
X-Proofpoint-GUID: EmL9eB1p7mKE9tYRZJw4SSo1J2oZRfL2
X-Proofpoint-ORIG-GUID: EmL9eB1p7mKE9tYRZJw4SSo1J2oZRfL2
X-Authority-Analysis: v=2.4 cv=beBrUPPB c=1 sm=1 tr=0 ts=6877d65d cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=56pKTMNPzGyt_i_oFpIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01

This series patches adds different features like debugfs
support for shared firmware structure and DMAC filter
related enhancements.

Patch1: Saves interface MAC address configured from DMAC filters.

Patch2: Disables the stale DMAC filters in driver initialization 

Patch3: Configure dma mask for CGX/RPM drivers

Patch4: Debugfs support for shared firmware data.

Hariprasad Kelam (3):
  Octeontx2-af: Add programmed macaddr to RVU pfvf
  Octeontx2-af: RPM: Update DMA mask
  Octeontx2-af: Debugfs support for firmware data

Subbaraya Sundeep (1):
  Octeontx2-af: Disable stale DMAC filters

 .../net/ethernet/marvell/octeontx2/af/cgx.c   |  19 +++
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   7 +-
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   |  23 ++-
 .../marvell/octeontx2/af/rvu_debugfs.c        | 148 ++++++++++++++++++
 4 files changed, 182 insertions(+), 15 deletions(-)

-- 
2.34.1


