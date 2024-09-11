Return-Path: <netdev+bounces-127424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F816975588
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1641F27AC8
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC7019F102;
	Wed, 11 Sep 2024 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="i+M08XpW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC925185954;
	Wed, 11 Sep 2024 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065225; cv=none; b=d2HO64NkjGTeXTiDIm1JmN2Pwra4YNgh7XVgY939zvuLJM6spOoSBrLG3Js4XBzP56tCZiUMfe31caP8NnH2iUMRCI0UJV4DpMQZGSwYxipfAbzZgEkF6izNjcijUmE9MHno79ppzMmrCQqXIAw5wvt10TYhUubD3nAqGEgWllA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065225; c=relaxed/simple;
	bh=tbaZDzev6HLkOa2j5q1VSaWSM0c1uUP/m18P3pDx52w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NNBQaataQdmeSv8KSEUr6699elcc4Xe6Z5rszVY8sJXZx1O+MXG/+rGn9KFUUPtBNCKXL8FleZ0vqOtqoYpJv6gLysPMI0YkroVV1YwIHimmabREUfGKLEi1JadocglN98a2eTTgyLixqAHlvi05/FRZxh3+Wul/bT+5s2wRe8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=i+M08XpW; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BBsWhs017614;
	Wed, 11 Sep 2024 07:33:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Xt+d3zj0dfbnJCefnXOYh2g
	ZscvXY/AowLdfIl6Y7dM=; b=i+M08XpWYc9L7wZUlR4+kuIKogFMWljz81DkS/v
	IXoTJbQnjCXcyZWSTRCcB+m9OHGUqQ6VSpf+Er8vZdIjaCNVb8XUqsHmsSKQGRmC
	yoGZpojx5g0sCXn8OokAFIg1rExThoia2c/hfLGrcSWey0SRFdgpayDVJRkWoDQP
	Y1f72fPMZuJiwyKwTfHeK+2qdNqCis61VGREqhGU54U13X2UAQMC9i4T5gLXnX86
	TfvtnZYEqiw3a42ZyEp+qy5JOICm30R4SJ0Z5yhI/8y0JzvbwJ7Etht/TaHDGjfp
	C+AYlYaJVpyV3t/Zc58+sSCQURrvA9MSwRXyFbGEcKu5T+Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41k17vjxs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 07:33:25 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 11 Sep 2024 07:33:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Sep 2024 07:33:24 -0700
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id C49113F7041;
	Wed, 11 Sep 2024 07:33:21 -0700 (PDT)
From: Linu Cherian <lcherian@marvell.com>
To: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        Linu Cherian
	<lcherian@marvell.com>
Subject: [PATCH net-next 0/2] octeontx2: Few debugfs enhancements
Date: Wed, 11 Sep 2024 20:03:01 +0530
Message-ID: <20240911143303.160124-1-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: UEgTgB-aJtAHFikOtxjc4DTTSXZhZBOQ
X-Proofpoint-ORIG-GUID: UEgTgB-aJtAHFikOtxjc4DTTSXZhZBOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Patch 1 adds a devlink param to enable/disable counters for default
rules. Once enabled, counters can be read from the debugfs files 

Patch 2 adds channel info to the existing device - RPM map debugfs files  


Linu Cherian (2):
  octeontx2-af: Knobs for NPC default rule counters
  octeontx2-af: debugfs: Add Channel info to RPM map

 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   8 +-
 .../marvell/octeontx2/af/rvu_debugfs.c        |  11 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  32 +++++
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 132 ++++++++++++++++--
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  36 ++---
 5 files changed, 178 insertions(+), 41 deletions(-)

-- 
2.34.1


