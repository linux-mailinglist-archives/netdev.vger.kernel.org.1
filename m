Return-Path: <netdev+bounces-17833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 714467532AA
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C9128207F
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 07:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633AC6FD1;
	Fri, 14 Jul 2023 07:11:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563856FA1
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 07:11:56 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172E726BC;
	Fri, 14 Jul 2023 00:11:55 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DLUPrC029957;
	Fri, 14 Jul 2023 00:11:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=eietfSoD+b0bITyQQrSikcmT4WSlhR+3d6lnEZaIHBY=;
 b=Rd7nUPpAJO2cWjA5W9odrf8Hcokdoa/kDIGYLI55n/zauL5fi6JpdPm3OZvt+LcIXnXu
 btrPaV2+ycJ0ieUg4K44fJbxjUBPTlOGrTI2q+9J/INdfI+JabhuxodyByHpKuFvNFjk
 YYFa944KZ0xgAqdDIQLmiEMY2OJNddT3B35s0WDvYgYb5sPfFj4RX1Z3FYDuejD2SNu6
 BzMjPJO8OO4iz7l84vbUMR3KKXmsiqoEHni5+T6v0UP/EZ/PTcpynHFfhAjJGk0MYX7O
 z7qS/bRHzY1K6EEQjBjcAFNE34sp+GuKpU3r/y4OtE9KDk3zmzG9mcZW5wjviMP4rEQN gw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rtptx9sve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 14 Jul 2023 00:11:48 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 14 Jul
 2023 00:11:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 14 Jul 2023 00:11:46 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id A4BFE3F7065;
	Fri, 14 Jul 2023 00:11:43 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH V2 0/3] octeontx2-af: Fix issues with NPC field hash extract
Date: Fri, 14 Jul 2023 12:41:38 +0530
Message-ID: <20230714071141.2428144-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4rv3Y67UkmmIcKvFN0XlQ8tZiE1O6kZ8
X-Proofpoint-ORIG-GUID: 4rv3Y67UkmmIcKvFN0XlQ8tZiE1O6kZ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_04,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset fixes the issues with NPC field hash extract. This feature is
supported only for CN10KB variant of CN10K series of silicons. This features
helps to hash reduce 128 bit IPv6 source/destination address to 32 bit(also
configurable) which can save 96 bit and can be used to store other key information
during packet filtering.

Patch #1 Fix hash extraction mbox message

Patch #2 Fix hash extraction enable configuration

Patch #3 Fix hash configuration for both source and destination IPv6

Suman Ghosh (3):
  octeontx2-af: Fix hash extraction mbox message
  octeontx2-af: Fix hash extraction enable configuration
  octeontx2-af: Fix hash configuration for both source and destination
    IPv6

---
v2 changes:
	Fixed review comment from Jakub Kicinski
	1. Updated detailed commit messages
	2. Updated cover letter.

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  16 +-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  22 ++-
 .../marvell/octeontx2/af/rvu_npc_fs.h         |   4 +
 .../marvell/octeontx2/af/rvu_npc_hash.c       | 160 ++++++++++++------
 .../marvell/octeontx2/af/rvu_npc_hash.h       |  21 ++-
 5 files changed, 150 insertions(+), 73 deletions(-)

-- 
2.25.1


