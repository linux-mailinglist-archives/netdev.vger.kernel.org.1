Return-Path: <netdev+bounces-122135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E65C96003F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 06:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C49D1F2255B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 04:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22ED225A2;
	Tue, 27 Aug 2024 04:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="A1HOGxFS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28D423BB
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 04:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724732728; cv=none; b=foXJq3C56F19iOY+RtMwLfP9FM2Atr4RBU6zOOITWQfQnTj5qLqsLb0G6oixdSMFEngQ4MqaU5DkE+z5mcQ5DX9H00/9sMemGFrR2UvSymVzd2y40Ck2tXhhJ22Cvj5+1PhU14nHIgGOVBcWCJSFxS+S53q87/wPiSH+XVnNHoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724732728; c=relaxed/simple;
	bh=UFjPsWqJtkXG8x73erwd3qwHtYz+HRDjc3+xsBq8w5E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p+jKV3WmS8O7dOJ3h01QNLPtvpEKPhoInMtKqy2Innmp+UM0aVrFsS1SF43fwOW6IGdwszEqT8ANKh08EpApJdV3efwU1swRKqVhi5B/cbNfwrBoQ0gaKT08MdyNcWIV10NS02PQqaIs/LrV5EuSktsSbzLxusvvAKtuRBwrzC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=A1HOGxFS; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R1vSRV027979;
	Mon, 26 Aug 2024 21:25:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=iKhaQ31EXiygmFIywSnaiZ3
	ZdzHQeK0hbxh/44EfKbU=; b=A1HOGxFSdzNrVkmGnRz9a6gbLsGz4J069vmOZFP
	OUhDFEMFvuwntNpTZ0R0xDE5OOBA4X8ISkLUs71i97bTGcK4ZrbyhomeN7iPlyob
	3Z5bzDVsi06Yy1Ku595OMwKczbtMeqKf8HpsoSw6dkKsTyvC4pMwRB9FHpICrdrl
	eOY1p3aRpN/3hyFUx+e65ivdF0/ptfrIN4Xt7OtFDnxR7x9SOvaSX+Wuip/zGXkC
	OxpwWY4kHeHUiyBqXBQsXs4FyDwwIpMq2FuIfTZHbPJKwDjB6rkNIL8mn4mTnpDS
	DBZWBLBAOokF1LzgODLZFkGyxMcqvMa2EPpXeboyfjlvgyA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4195kggdmc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 21:25:19 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 Aug 2024 21:25:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 Aug 2024 21:25:18 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 35BFC5C68E5;
	Mon, 26 Aug 2024 21:25:13 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <bbhushan2@marvell.com>,
        <ndabilpuram@marvell.com>
Subject: [PATCH net-next,0/2] octeontx2-af: Update CPT block for CN10KB
Date: Tue, 27 Aug 2024 09:55:10 +0530
Message-ID: <20240827042512.216634-1-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: B4nHHKkMgjJ4hkdB4whojmGJ0YNQkLQL
X-Proofpoint-ORIG-GUID: B4nHHKkMgjJ4hkdB4whojmGJ0YNQkLQL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_02,2024-08-26_01,2024-05-17_01

This commit addresses two key updates for the CN10KB hardware:

1. The number of FLT interrupt vectors has been reduced to 2. The code
is updated to reflect this change across the CN10K series.
2. The maximum CPT credits that RX can use are now configurable through
a hardware CSR. This patch sets the default value to optimize peak
performance, aligning it with other chip versions.

Srujana Challa (2):
  octeontx2-af: reduce cpt flt interrupt vectors for CN10KB
  octeontx2-af: configure default CPT credits

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   5 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +++++
 .../ethernet/marvell/octeontx2/af/rvu_cpt.c   | 108 +++++++++++++++---
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   1 +
 .../marvell/octeontx2/af/rvu_struct.h         |   6 +-
 5 files changed, 129 insertions(+), 21 deletions(-)

-- 
2.25.1


