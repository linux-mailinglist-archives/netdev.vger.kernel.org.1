Return-Path: <netdev+bounces-146827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC309D6216
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 17:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2F67B2801C
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 16:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607A21DF267;
	Fri, 22 Nov 2024 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Cgjey4WF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A97E1DF275;
	Fri, 22 Nov 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292465; cv=none; b=JXiKTT/98HM4An8y/7+se/4PVoFN0emt8DWwk9JdnUR6DaOFblNjT1ErYKmu0KM5QG9iO+2oA6lEqsbMt4PZPCHt/4bTWc/9AoOH04Dyhl5XCmnCRSwIHTqH9JJDrPmoG8UD5a9rAUwSJRTk2KS2jahykMRuLE8dk43uV10/3G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292465; c=relaxed/simple;
	bh=oeSQJHlAN+tHOQhvIV7nldyaufYqcHpNMCZF8KlGwEU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oGGQWaVNKFlQCxGgy/Zdi9hQxpuis3JZsxYsOQCfjm4C4c84ACOVCQyh/9nXG5VGfjCekPKj2lq1SyYZuZ+VGXzw19lau6Jwph936Cw/ex/e2IwZ5FUBhidaUvLmie4HqyGJvf2+kE4tfKPHIi94cPQS67q8OMkfMKjhD25ruy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Cgjey4WF; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMBKKhk028772;
	Fri, 22 Nov 2024 08:20:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=TfcnMBsRC+T+Cdjd6AnCj3hScWEQVTGAhRnI44C0Kp8=; b=Cgj
	ey4WFgRnMlvmrleSiDk4qoP3wQAGhenlbEckXoJ9ZEeabQvjx9wC8zRN2jkVxsHH
	1dnj5nuehFkjEGAq00PFsuuKLialpCOYpSxVnokbMGXFSELfubcDCFIq0eTdibFs
	jb4JBYTM4lBniKZVa6fQQ9vVqkI+dMwCfqWKjx7SnJQUu7VFNCfTBpywfdAH1z5L
	2ckDH7BtMdCRopEq7oe3Pp3D4DxtFgPnoFAkLYq2jeTGwhDx7umECG/ABJWOSqvW
	qAUnVOiirMNrHGm9p6oYpP0fzZOH27DzvtZoaJoDmRGkPOW3Epzhdu84OMNQJ4nI
	tHPpuTwqaGUQmV5SsDA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 432ryyrmxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 08:20:43 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 22 Nov 2024 08:20:41 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 22 Nov 2024 08:20:41 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 7AEEE3F7080;
	Fri, 22 Nov 2024 08:20:36 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: [net 0/5] octeontx2-af: misc RPM fixes
Date: Fri, 22 Nov 2024 21:50:30 +0530
Message-ID: <20241122162035.5842-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: ilTYFJdbWItwnyP4cxVJEhs6SKd8W7xq
X-Proofpoint-ORIG-GUID: ilTYFJdbWItwnyP4cxVJEhs6SKd8W7xq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

There are few issues with the RPM driver, such as FIFO overflow 
and network performance problems due to wrong FIFO values. This
patchset adds fixes for the same.


Patch1: Fixes the mismatch between the lmac type reported by the driver 
        and the actual hardware configuration.

Patch2: Addresses low network performance observed even on RPMs with 
        larger FIFO lengths.

Patch 3 & 4: Fix the stale FEC counters reported by the driver by 
             accessing the correct CSRs

Patch 5: Resolves the issue related to RPM FIFO overflow during system 
         reboots

Hariprasad Kelam (5):
  octeontx2-af: RPM: Fix mismatch in lmac type
  octeontx2-af: RPM: Fix low network performance
  octeontx2-af: RPM: fix stale RSFEC counters
  octeontx2-af: RPM: fix stale FCFEC counters
  octeontx2-af: Quiesce traffic before NIX block reset

 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 70 ++++++++++++++-
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |  5 ++
 .../marvell/octeontx2/af/lmac_common.h        |  7 +-
 .../net/ethernet/marvell/octeontx2/af/rpm.c   | 87 ++++++++++++++-----
 .../net/ethernet/marvell/octeontx2/af/rpm.h   | 18 ++--
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  1 +
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 45 +++++++---
 8 files changed, 194 insertions(+), 40 deletions(-)

-- 
2.34.1


