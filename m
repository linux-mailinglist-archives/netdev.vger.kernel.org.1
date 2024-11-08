Return-Path: <netdev+bounces-143219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205BD9C172E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 08:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30C828437E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 07:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72311CCEC8;
	Fri,  8 Nov 2024 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ye+bOGBl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588E019413C;
	Fri,  8 Nov 2024 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051957; cv=none; b=te/Mzupm4abZldSCn2kURjrrImOd5V1jk/p9sLa76H8VuH4U0v9a2c1zScWWcJaX9K+Qe5LSXgpc/FahqlqYew5yi8qY8EVnlPRFRPAW4PVA+ZN94Cp34EPKcZ3ZGvPOnkbVEcPDHEHsxpdQWwPrlir5smk6+EwAUvBrILi66FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051957; c=relaxed/simple;
	bh=Fkd0srhv2ijoasMC6UdMGE+8ZICaWjZXE/4liIUb8IY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fcOljn9Yf5KV6hENf+5RGWxZ24xajDCXL6WJ2PNiNxnK1LWh6eeLCkodyZnBB2K7WC8mkf2djD9Bv5uXOP/7LeMgob0JAlAinsAL0AHaFxyUKfwmEQqmyGwbBgDz4fMJk47U6Dm4e0GIZubLUZ5uMDPUDiOA0NWPSKRzes3G1IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ye+bOGBl; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7MbaR9022658;
	Thu, 7 Nov 2024 23:45:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=BuxZI8o09+k2d5KjQXDEVKl
	wqpiXiPBSI+fc3I0jgPE=; b=Ye+bOGBlez1rMXtwaxcBvMuQnqxGVaCxGtyg+Vd
	yeZrQ0cJ6vZZFqsvj7RR+HcKmqAjijaxuRAnc9opPSrGuFiXiGHtpOsSfc91CB9O
	ItRCOp4ozuRVC9ZSiGgGjwVyWtRdbRUtyNXDY6EMsaeeF+0ogAIZvMk/V627TdlB
	/zZRY8tH2XO8jmLJT3HpjyFioq+PTcDBujygJVyzGqLzLSYGHO4POCERaJS1fV6F
	gm8xdBSoB96fSvtSeGs+vmUCOrXegjI9cQ/szAG2Sc6VL7M2z7RY6FmAvBRv1VQb
	nYzOyxyHvb+zrLwcdbDImrNA7k1cBfrhvPPnWcX8lUnTsqA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42s6gu90aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 23:45:46 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 23:45:45 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 23:45:45 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 664443F7082;
	Thu,  7 Nov 2024 23:45:45 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
        <frank.feng@synaxg.com>, Shinas Rasheed <srasheed@marvell.com>
Subject: [PATCH net v3 0/7] Double free fixes and NULL pointer checks
Date: Thu, 7 Nov 2024 23:45:36 -0800
Message-ID: <20241108074543.1123036-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Ip7Jj--oBKhBGh3YZQ5xDQYd4G841DXh
X-Proofpoint-GUID: Ip7Jj--oBKhBGh3YZQ5xDQYd4G841DXh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Fix double frees which happen on reset scenarios, and add
NULL pointer checks for when rare cases might trigger
dereferences of such.

Changes:
V3:
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


