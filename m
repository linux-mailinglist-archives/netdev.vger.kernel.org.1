Return-Path: <netdev+bounces-144372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDAF9C6D83
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 12:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90AC0283130
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915B61FF7AF;
	Wed, 13 Nov 2024 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="c8trpogb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033DC1FEFA9;
	Wed, 13 Nov 2024 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496423; cv=none; b=AwJ1lZWLiZCemi5YD+hTnGxAvASZ7UbWG8Wp1MAdlwKk5SBqtlXTg2FsXGkJkO67DnDEiwBBqd34iZ5nhezi6yk/YZI1Ynmb6dpyHpi+tFIzB43km6HF2Lhs3/dVtQ6N870wzcJAtcrqPonEnR8kr14/N9iK1dcE1J6sYNna33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496423; c=relaxed/simple;
	bh=vJqvo6FxVVts6+LB73gU30c/NIHLZPzdO6pZfbMGa0c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kbffFF00Lty76pc6KDj7rWruD7s3XSA2Anrwi8ZxP8YWCkabRWpBqQrv/rObZcN+D5hpWkiYUYYcEkRTBm6hmo24cOGs1cQfdsW+vK+ryEz8eQOEUceWjthatLjsHezt1tzGU7CJ/a8zPc1DvvzgleUfunXvCszdOJpvfWzwbHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=c8trpogb; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACFpGDg025873;
	Wed, 13 Nov 2024 03:13:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=AmGS4uTaByKEtLmKTRFjqLb
	Ip+Vk8wyBdFrP3R6b80w=; b=c8trpogbZd5521c7W0MmFyJ46BG9IgNz4QjDUTq
	PrBm6ckbpeHd8A0Igpr3aVIkD6P4ViyKWtzJEQxLLOBhw4s93dUSZ4TqMPc7HJqq
	h7KiZnVkuD3sutscJ5v1qs+OK6Ixxvo4EwHaXpJs/VOA7128GfoK+xNkj0eOt+LL
	1gx6L4/htJSDjB+zufur280cZnGie6FeXwPyBwENN7BCgQ0RsH1rpleOvdgHH9hY
	QwD4YxY8cyEpobS+ZLyl8n/Ab1mB+dLT1NczB7q7c5ewEz1vEObwnWHUFaacEXVH
	VvLtZbBhZlveJVS5U770LOWCCJrEOcoTpC8PTjdeALbtKhg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42va1625t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 03:13:23 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 13 Nov 2024 03:13:22 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Nov 2024 03:13:22 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id D52AC3F7040;
	Wed, 13 Nov 2024 03:13:21 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
        "Shinas
 Rasheed" <srasheed@marvell.com>
Subject: [PATCH net v4 0/7] Double free fixes and NULL pointer checks
Date: Wed, 13 Nov 2024 03:13:12 -0800
Message-ID: <20241113111319.1156507-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4AtFl5f0aR9tpzoKPqpoW1sVp2aydrO6
X-Proofpoint-ORIG-GUID: 4AtFl5f0aR9tpzoKPqpoW1sVp2aydrO6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Fix double frees which happen on reset scenarios, and add
NULL pointer checks for when rare cases might trigger
dereferences of such.

Changes:
V4:
  - Removed unnecessary protective code from octep_disable_msix() and
    improved commit message

V3: https://lore.kernel.org/all/20241108074543.1123036-1-srasheed@marvell.com/
  - Added back "fixes" to the Changes listed

V2: https://lore.kernel.org/all/20241107132846.1118835-1-srasheed@marvell.com/
  - Added more context in commit messages and split patches for each
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
  octeon_ep: Add checks to fix double free crashes

 .../ethernet/marvell/octeon_ep/octep_cn9k_pf.c  |  9 ++++++++-
 .../ethernet/marvell/octeon_ep/octep_cnxk_pf.c  |  9 ++++++++-
 .../net/ethernet/marvell/octeon_ep/octep_main.c | 17 +++++++++++++----
 .../net/ethernet/marvell/octeon_ep/octep_tx.c   |  2 ++
 .../marvell/octeon_ep_vf/octep_vf_cn9k.c        |  8 +++++++-
 .../marvell/octeon_ep_vf/octep_vf_cnxk.c        | 12 +++++++++++-
 .../marvell/octeon_ep_vf/octep_vf_main.c        |  3 +++
 7 files changed, 52 insertions(+), 8 deletions(-)

-- 
2.25.1


