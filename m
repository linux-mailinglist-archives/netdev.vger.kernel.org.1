Return-Path: <netdev+bounces-108061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4503E91DB67
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 11:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE8F6B212B6
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 09:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8877584D13;
	Mon,  1 Jul 2024 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GMOn+323"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343591F937;
	Mon,  1 Jul 2024 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719826107; cv=none; b=GmwvWs3R+klYOk0koxvxlZAaSD0ea8NWRcCs2jpbH2dUk+Yii/GRqskYIqymRFkyeTJ9ro7Nf0CRv9gpQtvq/vWB+8p7hecKhH+CaqkV3T8X6PNOLTgvLK+Vh/G33QigChucJ2pEeWKJOgmm4bHtoh7+3JUUVMhsy9gZRNfJSL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719826107; c=relaxed/simple;
	bh=wAKcEvpgmzYUQv4xBYdWwUr3ERXwzRzT3O3PNKdMLsc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JuF3Q/FDhf9G3fQkfFSFw90p/znjJwXzABYrJgAMAaM+eneR3GUwjOIivRD5Zs8yFHFESgyE03mzORdXgWY1kwrXEzapXBQWZD+F2Vg0Pe8syQYdYzZaBXz+0QbYkj1Nl/IMvxcdAVRVkWRTYmZYtyWGsOp7fe58z/O93Um80Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GMOn+323; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4618vWEV022313;
	Mon, 1 Jul 2024 02:07:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=MxTte4ZHFHq+OKifMO5kKxA
	kLudbwO9gv7RxKcZ+UVo=; b=GMOn+323pObtD3pEJeEzwRpsuLLPIOW7xpgPvim
	5jT0u6NHar5vkYD7LQKjRL5R5NpIxwHVpfJhTIjlSstTGDhsXeEaaL2pdAn9PAMz
	x3RODRHlUVM0wKogzNt/gBjhw0QaMKpZBvHUFbjQZ5rylBHbX3Ks/nQXmkKb+PpN
	Jk3bTa697cLBdmDMAjmURB7/sk41bDH4lff8gr4bNI3VcwmoKR89myx1MPl8FBA6
	XMBueIo+8zk+N+gAE0GVtQX1yB86GcX2dBPKFa9ei9Iw/5vWNWby37ATzSAhrBP5
	6rtXtn3TcWKy5YyswsXJuhfYVXRK9yBApPrcVqdqnvHWGHA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 403sdcg1my-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 02:07:58 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 1 Jul 2024 02:07:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 1 Jul 2024 02:07:57 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 5B2BB3F7048;
	Mon,  1 Jul 2024 02:07:48 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
        <jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <schalla@marvell.com>
Subject: [PATCH net,0/6] Fixes for CPT and RSS configuration
Date: Mon, 1 Jul 2024 14:37:40 +0530
Message-ID: <20240701090746.2171565-1-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Wdzqu5yh_sXxaS-oq3rHEc4RaaA-6Iee
X-Proofpoint-ORIG-GUID: Wdzqu5yh_sXxaS-oq3rHEc4RaaA-6Iee
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_07,2024-06-28_01,2024-05-17_01

This series of patches fixes various issues related to CPT
configuration and RSS configuration.

Kiran Kumar K (1):
  octeontx2-af: Fix issue with IPv6 ext match for RSS

Michal Mazur (1):
  octeontx2-af: fix detection of IP layer

Nithin Dabilpuram (1):
  octeontx2-af: replace cpt slot with lf id on reg write

Satheesh Paul (1):
  octeontx2-af: fix issue with IPv4 match for RSS

Srujana Challa (2):
  octeontx2-af: reduce cpt flt interrupt vectors for cn10kb
  octeontx2-af: fix a issue with cpt_lf_alloc mailbox

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  7 +-
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  8 +-
 .../ethernet/marvell/octeontx2/af/rvu_cpt.c   | 78 +++++++++++++++----
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  7 +-
 .../marvell/octeontx2/af/rvu_struct.h         |  5 +-
 5 files changed, 79 insertions(+), 26 deletions(-)

-- 
2.25.1


