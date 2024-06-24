Return-Path: <netdev+bounces-106052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2670914791
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 12:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF03285CB4
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 10:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A371369A3;
	Mon, 24 Jun 2024 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="C9nc9Nv1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB0D125D6;
	Mon, 24 Jun 2024 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225415; cv=none; b=MNa1zEitImrRowQKI7oh7FtipA8yle8P2rRaX420ozD75m6r5pVfcQwpkfvsfIuYC6+LDHJQUmldKylPRWQ7ghNSigSYCLlfigvG66/GZDxdAB8oAtijwdkwVDYozmbN8YVmEZDIg57SqREwh5opGXalqkstpgsMW9XdtMOBlo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225415; c=relaxed/simple;
	bh=jFcsobCzk/xEeNwb5cqA2dlOiPk+qmW3O1s1igQRQmQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Iw/0Qq1tKfvVm6vUSOOjQxP1UChFEkH/c1ffCBhDGEIZjP5EPTWQ5d54asNjhETUZbrpB4J1pcJ9YMhZXLzF5FyGLIrtS4UDHx2VzoNq2uvVh2nuagoYAHteBmBIRq+AZLl0ef0Vv/nTY7SJAMExcCyxg9DfOsHa3LTUno5nyKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=C9nc9Nv1; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OARDkF022064;
	Mon, 24 Jun 2024 03:36:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=v6EdmHnrmhHP0343/lCMbqP
	fLh5LEyP1/SnWP2HDVTY=; b=C9nc9Nv18ceKvy99MepX3kr02HQQT3isj/sEsf/
	2B6E2ecmmDBJ5/px/eIf+fMN71p5e1bFGXkyspPUFbvGQ2w1cmdGLtmi1YSIlYZr
	9Jq7wCaL37pDPijHIcS8qWNZlLy1ZUGC21IJmuT+Wd5eQREtwwohzDLNwUSQxqf7
	CQUZ7tSPa1MAiPVUukCq+wCp7iUCSDrwOZ5HuAK9ihfdW0qlXtjkumQBN3hLhMXC
	Xq+gZEVv1q31MkOr5wWomlksqT/gGj1cjb/+BGoKz06MJm4vGXte9g4rfuKwXdkI
	zWPhJeELD9zD0A0KGJrZlMdDDVwBV2721wNkH8SX9EVacWg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yy72f00t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 03:36:46 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 03:36:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Jun 2024 03:36:45 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 3859D3F7079;
	Mon, 24 Jun 2024 03:36:40 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <markus.elfring@web.de>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH 0/7] octeontx2-af: Fix klockwork issues in AF driver
Date: Mon, 24 Jun 2024 16:06:31 +0530
Message-ID: <20240624103638.2087821-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2vC16EgX9-tk22aEZ5k50ud8NGobUUig
X-Proofpoint-GUID: 2vC16EgX9-tk22aEZ5k50ud8NGobUUig
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_09,2024-06-24_01,2024-05-17_01

This patchset fixes minor klockwork issues in multiple files in AF driver

Patch #1: octeontx2-af: Fix klockwork issue in cgx.c

Patch #2: octeontx2-af: Fix klockwork issues in mcs_rvu_if.c

Patch #3: octeontx2-af: Fixes klockwork issues in ptp.c

Patch #4: octeontx2-af: Fixes klockwork issues in rvu_cpt.c

Patch #5: octeontx2-af: Fixes klockwork issues in rvu_debugfs.c

Patch #6: octeontx2-af: Fix klockwork issue in rvu_nix.c

Patch #7: octeontx2-af: Fix klockwork issue in rvu_npc.c

Suman Ghosh (7):
  octeontx2-af: Fix klockwork issue in cgx.c
  octeontx2: Fix klockwork issues in mcs_rvu_if.c
  octeontx2-af: Fixes klockwork issues in ptp.c
  octeontx2-af: Fixes klockwork issues in rvu_cpt.c
  octeontx2-af: Fixes klockwork issues in rvu_debugfs.c
  octeontx2-af: Fix klockwork issue in rvu_nix.c
  octeontx2-af: Fix klockwork issue in rvu_npc.c

 drivers/net/ethernet/marvell/octeontx2/af/cgx.c       |  9 ++++++++-
 .../net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c    |  6 ++++--
 drivers/net/ethernet/marvell/octeontx2/af/ptp.c       | 11 ++++++++++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c   |  2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_debugfs.c   |  8 +++++++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c   |  2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c   |  1 +
 7 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.25.1


