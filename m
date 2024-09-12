Return-Path: <netdev+bounces-127864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BF7976E84
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BAB1C23789
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC0A15443D;
	Thu, 12 Sep 2024 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Us45u6BS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF11D14A092;
	Thu, 12 Sep 2024 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726157706; cv=none; b=VKJSzN4+9YH8GAXnthCcnegblrzJgMo6bQ4FaMJB0FB3Pzi1+oFxvYWXLBRBO+FQsoClDgwV/IQ7TSGq7qlcc/Bpf3s9dqSU5sUQ9/E6/4+FNsUuTywmVVePvGsPXWEvv2jC75NPskp4u/3RD9V1ZkT/Is5CuCtblXp9VAyph5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726157706; c=relaxed/simple;
	bh=+z5vSVsqHnO2ipIBd+YFZ/PE7fmOt9+3lf1B+WMstCo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XUXati6QbzdjYo9XriGFRUMv66kxfZP3tx8cz8NMNc/Zz1WvPp4HsHdA7cb14XJDB3TH/smJcqkyuIq02kntF2g7vWtcTIdAGVVBNNJ1Kcrrdi99whswvYGamMhlZ4gx37WW1QVcgsRuo2mPp63QYbKfxmE9zUOaBLG/lg3ss4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Us45u6BS; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CCj07j011518;
	Thu, 12 Sep 2024 09:14:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=TFX1Va4RcGu5v1s1RQJLbpP
	TQ/vDrcCic/gmU++00GI=; b=Us45u6BSeJN1970YWt/U218UGXK2lehFFpJTq2l
	BdZnKTKnTml/dDu4lFBo622EZWWCyyQDtxrZspBQMrS+CDA3EwOlqYcxckJIMS9j
	W8HscYRqyQsZ9QJC/fY+T9g9bTHcBNwbbCP9IpRgl5VuYiHQR0ij27palKWXxJdh
	yPiFUXo6rAxR9UAq9RjzU/55evfW5Et6YvLn4L39D48h2q41+RjXhwMKAA5hM13j
	KSeYfWqn8OGtA/tc5fEh7+fZWEhITaCLBa9tKHXEJzqrkWaRhxIOkDdzNecrJeRs
	5xKW/DhXI5NQGiu9YTwh7ixDlfelCAQvs0GjHDKi+2WnUfg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41ks8ptydc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 09:14:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Sep 2024 09:14:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Sep 2024 09:14:56 -0700
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id F05A53F7078;
	Thu, 12 Sep 2024 09:14:52 -0700 (PDT)
From: Linu Cherian <lcherian@marvell.com>
To: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        Linu Cherian
	<lcherian@marvell.com>
Subject: [PATCH v2 net-next 0/2] octeontx2: Few debugfs enhancements
Date: Thu, 12 Sep 2024 21:44:48 +0530
Message-ID: <20240912161450.164402-1-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: oPKILyMUVH7uvlZFGO4ZxYKye3O8-H3O
X-Proofpoint-GUID: oPKILyMUVH7uvlZFGO4ZxYKye3O8-H3O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Changelog from v1:
Removed wrong mutex_unlock invocations.

Patch 1 adds a devlink param to enable/disable counters for default
rules. Once enabled, counters can be read from the debugfs files 

Patch 2 adds channel info to the existing device - RPM map debugfs files  

Linu Cherian (2):
  octeontx2-af: Knobs for NPC default rule counters
  octeontx2-af: debugfs: Add Channel info to RPM map

 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   8 +-
 .../marvell/octeontx2/af/rvu_debugfs.c        |  11 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  32 +++++
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 134 ++++++++++++++++--
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  36 ++---
 5 files changed, 178 insertions(+), 43 deletions(-)

-- 
2.34.1


