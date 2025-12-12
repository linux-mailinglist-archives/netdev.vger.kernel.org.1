Return-Path: <netdev+bounces-244487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E48CB8CA1
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 13:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4E78306C70C
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 12:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3CB3128B7;
	Fri, 12 Dec 2025 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fW9BimWg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6BE2749FE;
	Fri, 12 Dec 2025 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765542207; cv=none; b=nEiP4mf1Gl6cFf5VNr0POhWy5zVU0ImIVi5bFwvCLS9wmbusyFOkod4YAYPZRVBpCaxCCrhINrjyG4XMWYA06Zql6qsD1LCIkXU3fxR2HZNNG+y7ie/q+22khKxWd4XBPYmxcaX/bGZsx4i9Fq2JdxTV1z8lMO9imKpLf3imRAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765542207; c=relaxed/simple;
	bh=tpM9WR2KzO/SgCiqvEo+8xcHvDnUe2f235uhe7nKzy0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cmstLV71z5iKdYmcp/Cyrj1Zjmf7wYDIh9yoXtVngsftwFXx8fMb5sVwZny8lBfGuq0Nr/mZ5L5JC7mq5+/gEJg4WePo56qLVmc0tOf2ImwQkmbq94Cj+UiG4DGNI1qQPMH1OiM+h28XEUa50Cr6q1vyFv1wysj9yGa+2YueTZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fW9BimWg; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BCBY1nu283865;
	Fri, 12 Dec 2025 04:23:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=GcnxZvaJm0T4LC7ZG9Kh7Gt
	TotES7O/oFuGY+dYUVho=; b=fW9BimWgbrFDEbDgsRdRsdTEodpFTCrdjNwQSQb
	WrNoYTtTOyF0GZ5E91pu/bW6diEtDRaXpYLCw7agIp7NAvvorwrGojX2Cx7wADUl
	HkEciWoHkDBaLggeRt6UW5AoxjWXTTam3fsa4to4CMLo1DYAVthRDXvK4DJRSTkf
	VAIEkYtFNapPJx2dMbrkT9vE+bbBaAAfEYN4KjGrV3NEgmEzcvhacsN0jBucgTz3
	eLDzhyf76lZFpMTZvFqou+lq90vNAmhk6Jxv0bPYNtFV695oJ14iTNPxeqqQGALn
	C9kCX12I0A/jqI4VqwKnSjudzdH4orlaKlwB0MT1zFx6R6Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4b0j96r2h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 04:23:19 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 12 Dec 2025 04:23:30 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 12 Dec 2025 04:23:30 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id 7AAF65C68FE;
	Fri, 12 Dec 2025 04:23:16 -0800 (PST)
From: Vimlesh Kumar <vimleshk@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sedara@marvell.com>, <srasheed@marvell.com>, <hgani@marvell.com>,
        "Vimlesh Kumar" <vimleshk@marvell.com>
Subject: [PATCH net v1 0/3] disable interrupts and ensure dbell updation
Date: Fri, 12 Dec 2025 12:22:59 +0000
Message-ID: <20251212122304.2562229-1-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=HMfO14tv c=1 sm=1 tr=0 ts=693c0937 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=pEaJl98hfMzEgLVLcYcA:9
X-Proofpoint-GUID: MSVg2EHbW82GaCEuB7R7GGw_CpQUsfIq
X-Proofpoint-ORIG-GUID: MSVg2EHbW82GaCEuB7R7GGw_CpQUsfIq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDA5NSBTYWx0ZWRfX/jND3MQs8MiG
 qN0HSfbcrmIOTSCxa2mNCtqOauJYaT6y7H5hymtK6l9O4m4kNbabB/6RKy0i71dQBhsO9zPL+2B
 39y/AX9O4PLb8FyXt3Q4yVn4vU/bTPNcLoRT0vGLzAGDBFxvpfx+XIlUWA8ZeT+FdFYz9ZQSAN0
 ruKD0Coez0teuS4IaHPzznnbsDDx4CJC4pxEJ+efjLcyMauCU24i5enSfOgZ8p0Ah3mQ2FlLY5b
 Tw83TBgeh3XG1fdH8UV3idoSGDDlOoTzzn8NmF9g4XPi/Ef67vjfh8aODTaqqkTodndScQ/CxNS
 +WmNo2yxGVcmk02+YA1PM2MkLGfzhbuSryxBIrU+VBO6pX6WUy4E1J2Ibe4HI6nNpYsITLANVx7
 kPhvN0cgECpcARUs2S2E2jI4BDO/AQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_03,2025-12-11_01,2025-10-01_01

Disable per ring interrupts when netdev goes down and ensure dbell BADDR
updation for both PFs and VFs by adding wait and check for updated value.

Vimlesh Kumar (3):
  octeon_ep: disable per ring interrupts
  octeon_ep: ensure dbell BADDR updation
  octeon_ep_vf: ensure dbell BADDR updation

 .../marvell/octeon_ep/octep_cn9k_pf.c         | 15 ++++++--
 .../marvell/octeon_ep/octep_cnxk_pf.c         | 37 +++++++++++++++----
 .../ethernet/marvell/octeon_ep/octep_main.h   |  6 ++-
 .../net/ethernet/marvell/octeon_ep/octep_rx.c |  4 +-
 .../marvell/octeon_ep_vf/octep_vf_cn9k.c      |  3 +-
 .../marvell/octeon_ep_vf/octep_vf_cnxk.c      | 25 +++++++++++--
 .../marvell/octeon_ep_vf/octep_vf_main.h      |  6 ++-
 .../marvell/octeon_ep_vf/octep_vf_rx.c        |  4 +-
 8 files changed, 82 insertions(+), 18 deletions(-)

-- 
2.47.0


