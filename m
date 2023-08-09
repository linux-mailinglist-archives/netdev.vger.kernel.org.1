Return-Path: <netdev+bounces-25708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE04A775381
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 09:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7551C21138
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 07:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720055665;
	Wed,  9 Aug 2023 07:05:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FC57F3
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 07:05:54 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E501BCF;
	Wed,  9 Aug 2023 00:05:53 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378Nol4T010112;
	Wed, 9 Aug 2023 00:05:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=+Hsc2+YoQSOX68y7WU8LnKL8cn4BAkjsPBo+6lWUebo=;
 b=L0gfPDaCi+Mc5sY2eMoG3/I7khQVK+Ex9zSyd/YoM18BLAHNY65okhjgE8OR3sz7+Vn/
 x0ryGwhn3bBVCLupWOyRBdtu5/16Eb2sLxuVPBck1PJwuYlSADC6vibM+h6LMcwJqvcb
 q8J7iGukd6YYtNlHTR8WD6MDhSKAkc88MKwepvuZKg6lgs2Vg1Y64Oy3Lv3+8fXRXtb/
 YrnVmsnD8l+drPIIc9paQNcklH/MfGbNWNFSwUukzHouwgYQh33OGjHRK4GLhKIBj8Gt
 vbiJKpr4arzHIMic0LburgAwJeacJUVfnqRSFgo0AvBNJyIFlN51sjWDdCzDBnOICZVz 2Q== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sbkntktqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 09 Aug 2023 00:05:41 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 9 Aug
 2023 00:05:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 9 Aug 2023 00:05:39 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 322F73F7061;
	Wed,  9 Aug 2023 00:05:34 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH V2 0/4] Fix PFC related issues
Date: Wed, 9 Aug 2023 12:35:28 +0530
Message-ID: <20230809070532.3252464-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: khN410DhqFG13rUXK8cRjGRMz_0GKuuY
X-Proofpoint-ORIG-GUID: khN410DhqFG13rUXK8cRjGRMz_0GKuuY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_05,2023-08-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset fixes multiple PFC related issues related to Octeon.

Patch #1: octeontx2-pf: Update PFC configuration

Patch #2: octeontx2-pf: Fix PFC TX scheduler free

Patch #3: octeontx2-af: CN10KB: fix PFC configuration

Patch #4: octeonxt2-pf: Fix backpressure config for multiple PFC
priorities to work simultaneously

Hariprasad Kelam (1):
  octeontx2-af: CN10KB: fix PFC configuration

Suman Ghosh (3):
  octeontx2-pf: Update PFC configuration
  octeontx2-pf: Fix PFC TX scheduler free
  octeonxt2-pf: Fix backpressure config for multiple PFC priorities to
    work simultaneously

---
v2 changes:
	1. Fixed compilation error in patch #2
	ERROR: modpost: "otx2_txschq_free_one"
	[drivers/net/ethernet/marvell/octeontx2/nic/rvu_nicvf.ko] undefined!
	2. Added new patch #4 to the patch set. This patch fixes another PFC
	related issue.

 .../net/ethernet/marvell/octeontx2/af/rpm.c   | 17 ++++-----
 .../marvell/octeontx2/nic/otx2_common.c       |  1 +
 .../marvell/octeontx2/nic/otx2_dcbnl.c        | 35 ++++++++-----------
 3 files changed, 24 insertions(+), 29 deletions(-)

-- 
2.25.1


