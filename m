Return-Path: <netdev+bounces-141979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517D99BCD22
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E35282814
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28F71D5AB6;
	Tue,  5 Nov 2024 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NomfM5i/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0F41E485;
	Tue,  5 Nov 2024 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730811409; cv=none; b=aWexgOUApKWSOeVbx9ZHkhcl8A7sDg3dysbwsj/MR64khW5Vgxk1JzIHxRTPHYCEiFK+Vq8UoixG9rVaCxRUArbQ1SSZ44bGtZvaXl59h2SD7Lub4KJiRQ6njRyqAJacKaTgKQ5CZX3y4BqKAVoViOWPfEWKI/+0tCu7jwRcy+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730811409; c=relaxed/simple;
	bh=4yPEqGiZe3jinJ079Y2+cDXkxTpM90m4cX9Uxm5bL2g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RvuooLKMfbE0WrDgDMRih1F/3BHgmVKYNnQiWcMzdqTqRIsUddB8J4l8ilRjFyqfYbvS+TMx/rd8Sot9DDNctsMaThRWXwfxk1u31Xw1P1W8PR2rqUlngvUTT1gGh/U0Yp+0pbUqh4RHsLjskKRyddmhHs8iGZHvHy+MIhBX1To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NomfM5i/; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A57Uc43023729;
	Tue, 5 Nov 2024 04:56:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=YRTJnZsUF0W9Dz6Q+KOKXNe
	f4c1WL843lS7dmH4uQdo=; b=NomfM5i/9un39yv0lFanSDZQ79xjY6TDmvBvkeS
	ewRCAK9n0jnKv7bs/OcoruaCa8Phyda+EUz1tgXlsy7Sdou7MADmWxzMDoMgTg+9
	Y/TKOUxjEGRpua/xCKaniHdOTLIDp57mlwWWfGtCsnueFFzcColvjV8Bi5PkJHyR
	6kNpOu49pXQKVuXH/b5sMX9dZJqbVywslPK+00vM6zLAILw7N93zW3XygFou0x5R
	0mAFapbc6Gn44dapp/WHlGhMm2rMCr80/f2cvBB/Rc8Rz1hQKhZ9PFJUkvB9ypiL
	DMo83NPX0vGChM56XGLisewek2CDlpKBWbQBnhtBBE39BSw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42qf1e8kcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 04:56:29 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 5 Nov 2024 04:56:27 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 04:56:27 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 613965C68E3;
	Tue,  5 Nov 2024 04:56:24 -0800 (PST)
From: Linu Cherian <lcherian@marvell.com>
To: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <jerinj@marvell.com>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v5 net-next 0/3] Knobs for NPC default rule counters 
Date: Tue, 5 Nov 2024 18:26:17 +0530
Message-ID: <20241105125620.2114301-1-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: g5JqTjVpLFp1SaJ7PKCwrakl4-4WqzeL
X-Proofpoint-ORIG-GUID: g5JqTjVpLFp1SaJ7PKCwrakl4-4WqzeL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Changelog from v4:
- Minor code refactoring to make the code more readable
- Make documentation more clear about the counter usage, behaviour when
  counter resources are not available, definition for default rules. 

Changelog from v3:
Add documentation for the new devlink param as well as the existing
ones.

Changelog from v2:
Split the patch into 2 as suggested by Simon.

Changelog from v1:
Removed wrong mutex_unlock invocations.

V4 is posted here,
https://lore.kernel.org/netdev/20241029035739.1981839-1-lcherian@marvell.com/

Patch 1 introduce _rvu_mcam_remove/add_counter_from/to_rule
by refactoring existing code

Patch 2 adds a devlink param to enable/disable counters for default
rules. Once enabled, counters can 

Patch 3 adds documentation for devlink params


Linu Cherian (3):
  octeontx2-af: Refactor few NPC mcam APIs
  octeontx2-af: Knobs for NPC default rule counters
  devlink: Add documentation for OcteonTx2 AF

 .../networking/devlink/octeontx2.rst          |  21 +++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   8 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  32 +++++
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 132 ++++++++++++++++--
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  36 ++---
 5 files changed, 190 insertions(+), 39 deletions(-)

-- 
2.34.1


