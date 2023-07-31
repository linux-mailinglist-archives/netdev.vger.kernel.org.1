Return-Path: <netdev+bounces-22803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E6F7694F6
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234F61C20C0A
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D1A18014;
	Mon, 31 Jul 2023 11:34:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3028EAD3
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:34:48 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB93C3;
	Mon, 31 Jul 2023 04:34:47 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36UNIc2w012062;
	Mon, 31 Jul 2023 04:34:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=KXU6HeF4XMVGolZFm5r+sG4Lh2+DVjYgvTIpuejrQLY=;
 b=AIkZewaV1xhVaOGtEZHeg38o33ecTt7WDl+3B0vd49cgN25e9Pe/6qsVS1LX/Wi83+hf
 ROdll7+7ZA3mm9VCTpCAlNXtCJAkfa6mpGbu4glX9mjegvXUYaqek4tmUSOKXEFCHiOT
 i7Nq5tQy7yAYKF3uMUYMe5pEhfecVto87YegAHjogq1jwwWonuu3AqD9njwTZDykIMTd
 h0X00/qciMSoNUjRFdhfWijYVViqz3wADIhsQDLnW5FXlljDnQAGcNuFy6WOgIGX4Hy2
 A1ggj4tV4V6tI6Uf8hrUii/f7TfBHvYmtBOedA5OyZxLffP14BPZ20Mpr2VPFLMLljpY TA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3s529k4qgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 31 Jul 2023 04:34:32 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 31 Jul
 2023 04:34:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 31 Jul 2023 04:34:29 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 1EDFB3F70B7;
	Mon, 31 Jul 2023 04:34:24 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
        <jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>,
        <jiri@resnulli.us>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next 0/4] Packet classify by matching against SPI
Date: Mon, 31 Jul 2023 17:04:04 +0530
Message-ID: <20230731113408.2586913-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: V1OO5pOKBsfEyJxPyzWURFHrfq0WO17X
X-Proofpoint-ORIG-GUID: V1OO5pOKBsfEyJxPyzWURFHrfq0WO17X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_05,2023-07-31_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

1.  net: flow_dissector: Add IPSEC dissector.
Flow dissector patch reads IPSEC headers (ESP or AH)
from packet and retrieves the SPI header.

2. tc: flower: support for SPI.
TC control path changes to pass SPI field from userspace tools to
kernel.

3. tc: flower: Enable offload support IPSEC SPI field.
This patch enables offload flags for SPI.

4. octeontx2-pf: TC flower offload support for SPI field.
HW offload support for classification in octeontx2 driver.

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  4 ++
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  1 +
 .../marvell/octeontx2/af/rvu_debugfs.c        |  4 ++
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 11 ++++
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 27 ++++++++++
 include/net/flow_dissector.h                  |  9 ++++
 include/net/flow_offload.h                    |  6 +++
 include/uapi/linux/pkt_cls.h                  |  3 ++
 net/core/flow_dissector.c                     | 53 ++++++++++++++++++-
 net/core/flow_offload.c                       |  7 +++
 net/sched/cls_flower.c                        | 35 ++++++++++++
 11 files changed, 159 insertions(+), 1 deletion(-)

--
2.25.1


