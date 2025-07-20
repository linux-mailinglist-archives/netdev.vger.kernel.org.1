Return-Path: <netdev+bounces-208442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ECEB0B6F9
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 18:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0679D18967E6
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 16:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53E721D5AA;
	Sun, 20 Jul 2025 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="k8Bz38xd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B261B423D;
	Sun, 20 Jul 2025 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753029429; cv=none; b=RXZ4/JeJmW1ggA8cPrGrHEk2q9jfuerk5Kadj1zVGlDFyuFwcfXOLY8z784FPMexe7rKQZN62hBE5DzidvqtNEcO8NlHHJEloOIOmCj9c+5lKrlWi3mpvw1mJj4sNpg0Bz4vqQGuGiandLH+XHYKbrt8ufhku1V6o7bKLN8aSMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753029429; c=relaxed/simple;
	bh=qTtuyUqSLRCyOJYOisYZDpKsrNhWdTwJSyxTfg1qlHY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PqCxRf3cjvs7sdDMTbnc8/NO0jhSbkKJ8THB6LqmXRF64o0PyxSpV3BhQAlPlIcfF3ftmhL9OhgAMXx6q59JF9+pKNgn6rVEBR8eCGeacePDfX0sPHTyy3TUeh3GeNScLLrxB0ktmPngW60BclW6dK1BnFK/w1vQd8jCG1rfQDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=k8Bz38xd; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KGBZPK016012;
	Sun, 20 Jul 2025 09:36:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ndP80q4rdPUOCMPfCTkgzo7
	PXQ7AuDgzzhEFUN9/BFQ=; b=k8Bz38xdDguUoOM4w8kLTTnM8D6TiFJnGqoUsHf
	dsN3LiznHVWNt+85+wx6GdMjxd1Mw6UKP6pNsz39I+JRmR7NngKmY1Yvvmc/aQcs
	ulXVIbb2MYyx4Asj48ZmMXE0M/5OPPRr7+heXtA81QE6IhBgiHxdiwYACJwoZuhz
	AsKo6SDYO2KyfU+jJRMsF5Xmy0lwgtvLXJ4JeNsG1K8ACb6aN5FzgNdgl9k9YMNL
	hXNU4wArjVnGHOGFPVCO6mgNLv+eI7gzg9pMPWbsHVvsMDwYuYqNyfsr+zJ3eFkU
	K1gYq1xbSjdGbD6MViAxR1SSpeSTevPYqzQhE7VnXouZ6nA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 480ymbg8p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 09:36:45 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 20 Jul 2025 09:36:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 20 Jul 2025 09:36:44 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id D1C893F7057;
	Sun, 20 Jul 2025 09:36:39 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next PatchV2 0/4] Octeontx2-af: RPM: misc feaures
Date: Sun, 20 Jul 2025 22:06:34 +0530
Message-ID: <20250720163638.1560323-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=VtgjA/2n c=1 sm=1 tr=0 ts=687d1b1d cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=rTa-d_mVba20Wz9wDAAA:9
X-Proofpoint-ORIG-GUID: cZBOi1dBX5SkxLzjSSxap834h9Ir7myG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE2MCBTYWx0ZWRfXzILNIiy6ySOQ tc1J6wUpPt+cr59XPWgOxd6jsbnY5JE5OeCQF28ZmYdfbTvudMRLGA2PNadbSCweJ3BfK9Y7Lai Cvs9i/wvvDLYekgpbK/Ep45unGe8Y8mbFXiGDqt7I2o7kNxRMmHAeRdE3px/9JW2QqQq4eOoNGR
 zHbNtvWowMW7Vi5SbnHnHxxa7O2vusmbQbt5F+N6EWl2uoaPWDk+CW7shg9T2qdRLBWnk4Ekb2E hazn0/biZu4i2TFb0Bp22Ye3WEcXs+XxDVnAIsH/A+fEKS/IY+G+tBnr5DKZxy9ZP99mOKx6hZu Zq16i4e39xS8uiBrqy0rS5ssc5h2dRXhJJe2xC18me7PEk/drTR4S56Cz3pMOYJfQtdNXqTJYwq
 8IVspfbeo4moq8TzqAgdZkqtHlyOWgyRFSO9ykR7SABpXehLXrY/4MAvtj2YStT3St9mh/Nh
X-Proofpoint-GUID: cZBOi1dBX5SkxLzjSSxap834h9Ir7myG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01

This series patches adds different features like debugfs
support for shared firmware structure and DMAC filter
related enhancements.

Patch1: Saves interface MAC address configured from DMAC filters.

Patch2: Disables the stale DMAC filters in driver initialization 

Patch3: Configure dma mask for CGX/RPM drivers

Patch4: Debugfs support for shared firmware data.
---
V2:
   1. Use  ether_addr_copy instead of memcpy
   2. fix max line length warnings and typo 

Hariprasad Kelam (3):
  Octeontx2-af: Add programmed macaddr to RVU pfvf
  Octeontx2-af: RPM: Update DMA mask
  Octeontx2-af: Debugfs support for firmware data

Subbaraya Sundeep (1):
  Octeontx2-af: Disable stale DMAC filters

 .../net/ethernet/marvell/octeontx2/af/cgx.c   |  19 ++
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   7 +-
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   |  23 +--
 .../marvell/octeontx2/af/rvu_debugfs.c        | 162 ++++++++++++++++++
 4 files changed, 196 insertions(+), 15 deletions(-)

-- 
2.34.1


