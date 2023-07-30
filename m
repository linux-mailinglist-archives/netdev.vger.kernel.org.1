Return-Path: <netdev+bounces-22586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0E2768439
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 09:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E911C20A14
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 07:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A79A34;
	Sun, 30 Jul 2023 07:41:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F90A810
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 07:41:59 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D37198E;
	Sun, 30 Jul 2023 00:41:58 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36U5ra1h024294;
	Sun, 30 Jul 2023 00:41:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=yiQhQPcbST93uqmvQs608MRTPE8/5cstdmtGYWxa/aE=;
 b=c2CYQ9A7capXAcItO1gK977aNSwB10fl3UrApk/2n+AL41Igqnbq0Hmo4cx251SEuIdA
 d7j+Wtq1BHAjd8QDhpE7DNYAaTX1uCYqtvMfXstMG4C2q+Yt+q2qxy5QNSAVlsj4nwzg
 755ANzd0K5yf/Pv8UR/noO4up9tmKb9qWCWY9NVr+ou11LdrEui1aM/uffrXrpMxKxBM
 K3UXcYP+vL5mC7jPm3sDLBNFpfv0u1OLWhF3lEBZTZoHafl4AqQ6EQStRMqdmwmbA0tU
 +rWXEen0oDtJsojTCcxT0YGFF0151l4bFwN1oGiasVdDsrQKpUm160ttNZQcRrs6xnJY aA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3s529k1px2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 30 Jul 2023 00:41:44 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 30 Jul
 2023 00:41:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 30 Jul 2023 00:41:41 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 90E163F706D;
	Sun, 30 Jul 2023 00:41:37 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <simon.horman@corigine.com>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH 0/2] octeontx2-af: Code restructuting and TC
Date: Sun, 30 Jul 2023 13:11:32 +0530
Message-ID: <20230730074134.2838427-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 76iSP1rRAbjcbrcMjdwIhwLes1VPPNcI
X-Proofpoint-ORIG-GUID: 76iSP1rRAbjcbrcMjdwIhwLes1VPPNcI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset includes minor code restructuring related to TC flower offload
for outer vlan and adding support for TC inner vlan offload.

Patch #1 Code restructure to handle TC flower outer vlan offload

Patch #2 Add TC flower offload support for inner vlan

Suman Ghosh (2):
  octeontx2-af: Code restructure to handle TC outer VLAN offload
  octeontx2-af: TC flower offload support for inner VLAN

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   1 +
 .../net/ethernet/marvell/octeontx2/af/npc.h   |   3 +
 .../marvell/octeontx2/af/rvu_debugfs.c        |   5 +
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  13 +++
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 105 +++++++++++-------
 5 files changed, 89 insertions(+), 38 deletions(-)

-- 
2.25.1


