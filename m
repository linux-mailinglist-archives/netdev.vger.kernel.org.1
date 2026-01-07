Return-Path: <netdev+bounces-247734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FD7CFDF21
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2BBE3019BB0
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B9032827A;
	Wed,  7 Jan 2026 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bDdea52p"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D001328257;
	Wed,  7 Jan 2026 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791959; cv=none; b=ELubsTtbbpqns40kVykxs+R5rvjWO79UesH9OtQk9ic92enAhMCeiG1ojG77m2W2LxTb+Q20Twvpju34IsLDwMtxbb51BNMccMQBVg6GfsoMBo0c+TF0XSP0bBUQ1YjYAIv1qxRMdeCCX73kgY+cTRd0sYsXWomu+1ik5JvCYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791959; c=relaxed/simple;
	bh=kJ3NISw2DX0W/sPkTkQ38NAffUlq7AQ+JTvOdtzgOtE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hG2nn/4QSeCSuZzFaBxAnGLv9xm+pugLg4aWtJGrG4MdNct1jc+DJDc3cBIoG6oOcFi8g2Id/rtNiDg/cGu1epnvFsGuQtiy02eVL279YuXnPnSXokRnVYMP7DeDZnNSLR4reGWTUX2jsO3QYytrDSdMrEAuvx40ipW5fgV/3XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bDdea52p; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6071DbLp2795403;
	Wed, 7 Jan 2026 05:19:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=hH3OugolXYCmIENIepGzs+x
	2CZ5v/p7C+ZxQE744/1A=; b=bDdea52p5B21k11xEYUWedO8xlU0ZFX8czzUCY4
	hlUPEE/CR4kBtOlcqbBqFKyl0ZC1g1gbTJ+OgEFGhFHEW5cWhiAddyAyGaPp5AlG
	9Bic5OZLZ7z+81fBSyE5dOvxBX5GoS8AT166QdxZR2ecGdTNj/8mb3D0IGeFcvtb
	3jVUyYFc7VrQGZ4Bi10h2VQseNEbj19yJeaJ80hTynlaKw6elviOD2KB+9P6u/ae
	1iZjeTyGqry4M+ZHnBn+Wm6Ord6CtiBs/qcMbPqs0KNbON0NSs8UFLyk16aXCF02
	kBE0ba2yJXGU8DBtp0wlpPE69Nw91VDjWUQ+mQDsRlgHohA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bgf3fw1h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 05:19:09 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 7 Jan 2026 05:19:22 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 7 Jan 2026 05:19:22 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id C7C733F704A;
	Wed,  7 Jan 2026 05:19:07 -0800 (PST)
From: Vimlesh Kumar <vimleshk@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sedara@marvell.com>, <srasheed@marvell.com>, <hgani@marvell.com>,
        "Vimlesh Kumar" <vimleshk@marvell.com>
Subject: [PATCH net v3 0/3] disable interrupts and ensure dbell updation
Date: Wed, 7 Jan 2026 13:18:53 +0000
Message-ID: <20260107131857.3434352-1-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=PLgCOPqC c=1 sm=1 tr=0 ts=695e5d4d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=6bxer7aP3YgKHE6BY9wA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEwMiBTYWx0ZWRfXw/Szx9cxalBP
 lGeBRpZSao4asHDXd5fsU2z4xF9avPUjwAfvZVDJeIKhYpbQVBk/vAJCX8NuYdSVU9xNnOvL1XD
 ukLnv/3OXNU2kxk4PjhY3FVaf8/6AI+sAeGjnfIneaox5Dak0pbbr68PAvqyimi6O2I5TXmgLCu
 0RHlG87TulS7lMgW8ds/+GPuAm20A5R0GSAIBGOMHHDdGTDT08Cx0gPoTe94HLzMdkOexL1DXRq
 IEj1LvLv8uBjZRXvhhFyU70/pFcu34YZeIxy2g5CMfoYA+Q5ToY+idfnsfuoL3tz1K5qSICWkFN
 mlvoe3w0ad6NkpP92lsE2A9/Dz8VR5DJQpVm1CrBqb3jsbI21IJ9v6XQJgWzdjwGxXFHdUW5yFA
 XHZ9sxw8GDV8z8tXTa2AirIHSIaP1X0MzfCSe5ln5xzFwJmOkvYdQjoDdBXTLO8o7a+lPAcizp/
 KQbVhVz6oSgKxaa0cVA==
X-Proofpoint-GUID: ZhMxJZedeQEZQZrup1kuflJRL5nPIAHa
X-Proofpoint-ORIG-GUID: ZhMxJZedeQEZQZrup1kuflJRL5nPIAHa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01

Disable per ring interrupts when netdev goes down and ensure dbell BADDR
updation for both PFs and VFs by adding wait and check for updated value.

Vimlesh Kumar (3):
  octeon_ep: disable per ring interrupts
  octeon_ep: ensure dbell BADDR updation
  octeon_ep_vf: ensure dbell BADDR updation

V3:
- Use reverse christmas tree order variable declaration.
- Return error if timeout happens during setup oq.
 
V2: https://lore.kernel.org/all/20251219100751.3063135-1-vimleshk@marvell.com/
 
V1: https://lore.kernel.org/all/20251212122304.2562229-1-vimleshk@marvell.com/

 .../marvell/octeon_ep/octep_cn9k_pf.c         | 21 ++++--
 .../marvell/octeon_ep/octep_cnxk_pf.c         | 64 +++++++++++++++----
 .../ethernet/marvell/octeon_ep/octep_main.h   |  2 +-
 .../marvell/octeon_ep/octep_regs_cn9k_pf.h    |  1 +
 .../marvell/octeon_ep/octep_regs_cnxk_pf.h    |  1 +
 .../net/ethernet/marvell/octeon_ep/octep_rx.c |  4 +-
 .../marvell/octeon_ep_vf/octep_vf_cn9k.c      |  3 +-
 .../marvell/octeon_ep_vf/octep_vf_cnxk.c      | 39 ++++++++++-
 .../marvell/octeon_ep_vf/octep_vf_main.h      |  2 +-
 .../marvell/octeon_ep_vf/octep_vf_rx.c        |  4 +-
 10 files changed, 118 insertions(+), 23 deletions(-)

-- 
2.47.0


