Return-Path: <netdev+bounces-139784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 898529B4168
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 04:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335621F22E01
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 03:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351DE1FF603;
	Tue, 29 Oct 2024 03:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Me+tR/DQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FEC282FB;
	Tue, 29 Oct 2024 03:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730174284; cv=none; b=uyCaVWqDHZpvEIq0Hzb4urHUt5qPJFXu7fbapKORumwWsdgJXildtXx60ZD+OxhyMNVpF7n1E7ZNpGY14y3zqag4+LweYxi9dvEml0U1HkFXjwTDcacQ0y/qVDQWAgdGvGbOV+gJvwRLXEU8iUFBWXzP8AiFVzp1F3MQxrYyCUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730174284; c=relaxed/simple;
	bh=qCFhFOtJ4I3Hn+BWlPCl86BaY7vRx+mzS4qdyiTVuqw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A4kNSghtfXwsv16qG3n8LP4CAr+XRqzYJuWLtw2RytsRjotPRXcCmAfOJNfNRg3vyGrilB8ZcYiFkkb6wfmjK9kw69kfXqci3b8gp0HaJ2m29MgSLTo+3B60vt1+tsjoTPLnMLJ30AH8FLCR20sQ13E4bbjRxzrmwXN8aDuvx7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Me+tR/DQ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T0A3eG014614;
	Mon, 28 Oct 2024 20:57:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=/ySelO4BS1pJ+rl/uL7gEKl
	Tg18DTfPwz+e+g89mxjE=; b=Me+tR/DQr/yHZzih9s+/hE9Mn/OplNOSwa6iZIP
	tggbOOj9mkH6X8B3QWkArMc9WZBagLOaV1jfQjjUkVUfQTvW6Wn+BExaRiwBjQBx
	CTFpFKixJISXR35mng5482mloHkfYwb/BShsqq3MRLvkj9OFJDnM+eg0Tepp4vms
	J6Ga/GA4cfLvd1NdRPc8s9VOjpOFbZVxD8QSZvZO3DCmld6thLlEv/IkInR5+Bul
	wXCwUUij4yG8pLnT1KSwoBWcX1qMCkK/addYra0ENiLYCcfofkLqRdhZLRORznha
	y3TE1CWpFKxrMZHFLIenbzDG2+TOoaNQsFjMs3WSBfWIxHQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42jmx40gff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 20:57:54 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 28 Oct 2024 20:57:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 28 Oct 2024 20:57:53 -0700
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 7599D3F7054;
	Mon, 28 Oct 2024 20:57:49 -0700 (PDT)
From: Linu Cherian <lcherian@marvell.com>
To: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <jerinj@marvell.com>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.comi>, <jiri@resnulli.us>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v4 net-next 0/3] Knobs for NPC default rule counters 
Date: Tue, 29 Oct 2024 09:27:36 +0530
Message-ID: <20241029035739.1981839-1-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MZ_LkrQH-DEcSU69VI_NJHNRdNs6Yk3w
X-Proofpoint-GUID: MZ_LkrQH-DEcSU69VI_NJHNRdNs6Yk3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Changelog from v3:
Add documentation for the new devlink param as well as the existing
ones.

Changelog from v2:
Split the patch into 2 as suggested by Simon.

Changelog from v1:
Removed wrong mutex_unlock invocations.

V3 is posted here,
https://lore.kernel.org/netdev/20241017084244.1654907-1-lcherian@marvell.com/

Patch 1 introduce _rvu_mcam_remove/add_counter_from/to_rule
by refactoring existing code

Patch 2 adds a devlink param to enable/disable counters for default
rules. Once enabled, counters can 

Patch 3 adds documentation for devlink params


Linu Cherian (3):
  octeontx2-af: Refactor few NPC mcam APIs
  octeontx2-af: Knobs for NPC default rule counters
  devlink: Add documenation for OcteonTx2 AF

 .../networking/devlink/octeontx2.rst          |  16 +++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   8 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  32 +++++
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 134 ++++++++++++++++--
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  36 ++---
 5 files changed, 187 insertions(+), 39 deletions(-)

-- 
2.34.1


