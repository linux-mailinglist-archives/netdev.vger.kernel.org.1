Return-Path: <netdev+bounces-142840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4589C0764
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5166E282D2B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DD621216B;
	Thu,  7 Nov 2024 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eOuWMLVr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A48520EA44;
	Thu,  7 Nov 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986154; cv=none; b=hjNZVFpVzuLIS5t6HyhlietPuCeJlTlr+rDTLF1VBI8U9actmTf2gK2CpAsh1jRYZkpBTRB1WLbDkCVONU1wFvhssYQts9S2jAMt/OikwbNYYYt/SCM3ppIcwbZY5SHmTWM0XXVMPaeEBRAG21v+f2XZWztFXe6Vb2pdfqTcF70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986154; c=relaxed/simple;
	bh=nGx0+Cuv9QklJE82DvtuzYrtbZEfkyiaC0YZdU3kTYw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JN7vbWZJxb+K8rt/14y0j8JsiBecTcC2i1Cs9kDUSThEQrSCF69U+xcSrOE0/rXZUC4gew9L5cgXl7TN0JunpdP/xKs1/Pn9RUWNrPwJSJ9jeZ+0t0T7mT5pOKrNeUSTVmE0DM1XF35dXU91dng41zgIZy2kbX09S7uPGho4wDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eOuWMLVr; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A75b3bH006198;
	Thu, 7 Nov 2024 05:28:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=RQUI3MPS77oSCEsi7m5B+gU
	JgI2pFXyx0c3nNVYyZeM=; b=eOuWMLVrgHNvD+WnWwXqRxsfUc6Dm3v3J9/xwPp
	69N9LZR4dEjF6B5+uLc6iiyuQpb5WLeQQ0Hmp0kTOrlQW72AAayHa6NyaemPuSB2
	4fHP0MrKpHJEhJ5a7xAFbzDix1wDQERCwrJcX+ZVEFy7uxJ4iTYbQdtsS8i/4b/C
	OkmY9gxAtWu6CGj8kVD61JKNZ9/5Z+T4r5/ko7u2lZDnxBndVz5bCyUfMWVKn5jQ
	SForX4ADbph+Ulv0nobW8r42GPjeTnNz+syjGjy+6O81RoIdkyvteZD2DqyCIFSJ
	z9OBdaoNa10i0IenL250Pjf8RSyp8x4P0Q25PkjewSTHjLg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42rqj8rtpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 05:28:55 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 05:28:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 05:28:54 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 119243F708C;
	Thu,  7 Nov 2024 05:28:54 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
        <frank.feng@synaxg.com>, Shinas Rasheed <srasheed@marvell.com>
Subject: [PATCH net v2 0/7] Double free fixes and NULL pointer checks
Date: Thu, 7 Nov 2024 05:28:39 -0800
Message-ID: <20241107132846.1118835-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: gMZ1EqnbI8k_qt8Dmp-i7dm6UtXOMRfA
X-Proofpoint-ORIG-GUID: gMZ1EqnbI8k_qt8Dmp-i7dm6UtXOMRfA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Fix double frees which happen on reset scenarios, and add
NULL pointer checks for when rare cases might trigger
dereferences of such.

Changes:
V2: Added more context in commit messages and split patches for each
    commit fix

V1: https://lore.kernel.org/all/20241101103416.1064930-1-srasheed@marvell.com/

Shinas Rasheed (6):
  octeon_ep: Fix null dereferences to IQ/OQ pointers
  octeon_ep: add protective null checks in napi callbacks for cn9k cards
  octeon_ep: add protective null checks in napi callbacks for cnxk cards
  octeon_ep_vf: Fix null dereferences to IQ/OQ pointers
  octeon_ep_vf: add protective null checks in napi callbacks for cn9k
    cards
  octeon_ep_vf: add protective null checks in napi callbacks for cnxk
    cards

Vimlesh Kumar (1):
  octeon_ep: Add checks to fix double free crashes.

 .../marvell/octeon_ep/octep_cn9k_pf.c         |  9 +++-
 .../marvell/octeon_ep/octep_cnxk_pf.c         |  9 +++-
 .../ethernet/marvell/octeon_ep/octep_main.c   | 42 ++++++++++++-------
 .../net/ethernet/marvell/octeon_ep/octep_tx.c |  2 +
 .../marvell/octeon_ep_vf/octep_vf_cn9k.c      |  8 +++-
 .../marvell/octeon_ep_vf/octep_vf_cnxk.c      | 12 +++++-
 .../marvell/octeon_ep_vf/octep_vf_main.c      |  3 ++
 7 files changed, 65 insertions(+), 20 deletions(-)

-- 
2.25.1


