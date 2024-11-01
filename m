Return-Path: <netdev+bounces-140977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8DF9B8F3A
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8309928179A
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E088C165F1F;
	Fri,  1 Nov 2024 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Vh/Rjxxp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D870F1581EE;
	Fri,  1 Nov 2024 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457274; cv=none; b=h7cwBvzk7wAmMBuaySdCm0o1SESwFCb4jxkHkGTyjvszCHyKIju7g8feUy/ZmEfjkUd+onI9MkXjVmoLT1BV+O2g0yTSIJClfsJPmchj7p05Yb1g33/FL0jZTeN75sM7el7Hwn+dTdicY5lzfyIJtm3yQjHvE/R4trF/FcykzCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457274; c=relaxed/simple;
	bh=V/9y5EYD+ZCAAHPu5nwxzuHIm+6PZ9gfMQchvAcJr88=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dLGm1iD40v8w1Hr3q1PJAwLiIB0J4KFoviQCJOWLdtJx/RlQb6qjA+WdVzBAzCuYkZtT6JhY63idQcKqtFd3mzflkJ1LUq2zGxaKJvn+r3dstJyLqy0oGb3rKaxzE+kIpRpOCUCHlas5m5g+v84/vbrS+kLVHbrzWprDZ+R5VxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Vh/Rjxxp; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A19DaJA009756;
	Fri, 1 Nov 2024 03:34:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=EcPjjDRA+Ke0123rTBNrK9z
	ugc5UlYAnn7m8z7rUprA=; b=Vh/Rjxxpr7BZcIYQNGHp5iGqmzL1pNMI/p4Db/z
	cck5KH8z/4/pN8UxeDfxJmMkW+lVQyuuN0PS3Yib6B0Kg0qzuS+I69wQYEmQ7ZeG
	Ya5xq5XkPsVvgK1v3BQxYJF3lI37P1rTgwMkDsoPa7D/+jElafsNvsxL0qrERxnr
	2PK+QEGM6RXCPFtmAJ2wvU+1/sBxZMspeNMI4HWQHmAiGtMDLAjG8Yy4sSeMuEFf
	HSSclW9t8CXOK2+BuqqD6aQ4DpBZ067+nVLRA9i7PEOMd90otBGAs0dFIcVmNoN8
	9wtH4fdIzAHxKA96EI5icMdvHQJ+Eacs3YDz06YDhmqdExA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42mv5ng4a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 03:34:21 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 1 Nov 2024 03:34:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 1 Nov 2024 03:34:20 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id C4B0E3F704C;
	Fri,  1 Nov 2024 03:34:19 -0700 (PDT)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <wizhao@redhat.com>, <horms@kernel.org>, <kongyen@redhat.com>,
        <pabeni@redhat.com>, <kheib@redhat.com>, <mschmidt@redhat.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>
Subject: [PATCH net v1 0/3] Double free fixes and NULL pointer checks
Date: Fri, 1 Nov 2024 03:34:12 -0700
Message-ID: <20241101103416.1064930-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: O3TuMDC8US8kWtf_6pkRfpxSkVaBg-ZA
X-Proofpoint-GUID: O3TuMDC8US8kWtf_6pkRfpxSkVaBg-ZA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Fix double frees which happen on reset scenarios, and add
NULL pointer checks for when rare cases might trigger
dereferences of such.

Shinas Rasheed (2):
  octeon_ep: add checks to fix NULL pointer dereferences
  octeon_ep_vf: add checks to fix NULL pointer dereferences

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


