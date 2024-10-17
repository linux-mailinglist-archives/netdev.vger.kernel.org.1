Return-Path: <netdev+bounces-136461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 356589A1D72
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666EF1C23569
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224B11D416B;
	Thu, 17 Oct 2024 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PsNR8Bx/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60C514E2FD;
	Thu, 17 Oct 2024 08:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154594; cv=none; b=O7ib7aKgik68yGf8WH3v4XvuWr1Sxos5/N5ZCsNRSUOKVa1R8zguQaFBJLEdbq+Z/qg4pxBipy+KL5rfap9DhErrFEKM8unI9TWNI2t+JnfzIDNzcOcZhD+KPi60NvAcRUAcjnb/+SVVoMuwYaGDzNRlozr5M3n2M0OJ5xFUwCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154594; c=relaxed/simple;
	bh=STIQE9AtS8SlTuHohkEOIR6Ujz0eVHcfn6JDTgcEdeg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d6X7gcvXdUnXZjljFo5fG5nvUuQvdiN7i+Fpvt+LM5USseV9v4WvtSp+R4D0H8fhQyLT+FTZuQyZ1mVz9XQpkXha81kUPSUxhWZu95g/rTRd/50zRFbKl6USTO3pJcVG7El0RMX6JLKDgK4ZrKd44zUuJuhOn0pH9Ch6JRNxDDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PsNR8Bx/; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H5Lxk0004324;
	Thu, 17 Oct 2024 01:42:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=G1gkBy1mUMK2jHgsHiwttkM
	tScLLLOLISBHoe4yzMvw=; b=PsNR8Bx/RQmTZ8gqD74Vx4kMuwkUVN5gUIhTNWx
	8SEDbIaolss23bGtqwZyiQOZbe4RxOPTAWANthqJJ4/NeC16sE2z6xeHSA+kMTWr
	FQBrkUornp/eqxU51F2Qpdb8DLSDqJ3ySHdZIOpdgQ8cw0xOlEElJPc8Venk3OkI
	ADLNqcsmtrWyG4+kYMKrw1G+Owbd/hvvQD4LXReHvEkOjuyV4W8v973c6MjGNKvL
	T4+lWESJESiT+0UDsL/BbY9l6M9Bm+/WyojV6D0o3t63COle5d1CJ/R0z68CJqFE
	eRFLVwj0AvNoF84l/56a9HpzxNfXGswlDAXS9CIL45tcaCA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42avbxrcn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 01:42:54 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Oct 2024 01:42:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Oct 2024 01:42:53 -0700
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 6B1C23F704C;
	Thu, 17 Oct 2024 01:42:49 -0700 (PDT)
From: Linu Cherian <lcherian@marvell.com>
To: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <jerinj@marvell.com>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v3 net-next 0/2] Knobs for NPC default rule counters 
Date: Thu, 17 Oct 2024 14:12:42 +0530
Message-ID: <20241017084244.1654907-1-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: TOzX1PEw2YAzCSe7jotNFJiYY-l7uJwQ
X-Proofpoint-ORIG-GUID: TOzX1PEw2YAzCSe7jotNFJiYY-l7uJwQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Changelog from v2:
Split the patch into 2 as suggested by Simon.

Changelog from v1:
Removed wrong mutex_unlock invocations.


V2 is posted here,
https://lore.kernel.org/netdev/20240912161450.164402-2-lcherian@marvell.com/

Patch 1 introduce _rvu_mcam_remove/add_counter_from/to_rule
by refactoring existing code

Patch 2 adds a devlink param to enable/disable counters for default
rules. Once enabled, counters can be read from the debugfs files 


Linu Cherian (2):
  octeontx2-af: Refactor few NPC mcam APIs
  octeontx2-af: Knobs for NPC default rule counters

 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   8 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  32 +++++
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 134 ++++++++++++++++--
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  36 ++---
 4 files changed, 171 insertions(+), 39 deletions(-)

-- 
2.34.1


