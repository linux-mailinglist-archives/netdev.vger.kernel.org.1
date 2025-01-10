Return-Path: <netdev+bounces-157262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA04A09BFC
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 20:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CE03A95B6
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 19:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6132C2144CF;
	Fri, 10 Jan 2025 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hWkV/ppm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E83124B247;
	Fri, 10 Jan 2025 19:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736538107; cv=none; b=JTO4AazTVnLhZpH8ijWkK1Vnk0BlQRs0nzGtyRu8dvKptJXUh19RCXh5sSGuRq9HmOzrY0SRcXG3J+ONmcszIFEzXDhU/Sn2nta+4q9KY5CCfOpXeS2B86hWgnnOKhMsuwBePTYUaOQlMm1oWXIRt3PL/bDz1uQvkJAYPR4mJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736538107; c=relaxed/simple;
	bh=KlTcZAOphqI+mKXQSHQkBFkp34x/UalfYMYLFIylyYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BRAig2c9QBbeVrVdmimATFfjDrQzBzIp16Fiwi74wEoUGv/vThOdx+hGazWAWNusfSqo++oOtlTcNEYu//HzmEuZjDswZz7jvO567Vce9BJ4X75MHENzc552PC5fuOF2iNgy4zyfB7/ioxIPmxTLcYBQe6RfNipIReT8/Kt6Xr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hWkV/ppm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AE6LuJ025777;
	Fri, 10 Jan 2025 19:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=xqKwkwDxLIeWcu+5+AJmJwxlzjIwVAT1iL166k6cD
	7A=; b=hWkV/ppmoQJHl4N1qVi2xPoWbsPbCXOeNcVk8IoNFbw3ScYxmTv0T4yAT
	eMn0hfHTllR0KF4En3rSkWkdLKuv1JccoOZ6ZhECtAQvgYsaCYYVGzgJzR2E5Gsp
	NFfr/nTrWI0wkhNRxTN3LuKOIrJbkIV4Z8qsIGicx6N0RGntjOU0hLTkfYfgXxu9
	JrOyrpUYrAJ49gPSNh+8XIaJGSjugL9JsoKLfxLqLljBKdor7peXa2y9NVO9NoUD
	32JYrXBJ7lLP1R9RSg6FXuDM4X4ffM+p6Va20+zEao9RK+yz4navpdnEDCq5LhnD
	C21LgQzHNjkabwKlo63uF2aMqo0lg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4435151g8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 19:41:37 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50AJO3Of004912;
	Fri, 10 Jan 2025 19:41:37 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4435151g8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 19:41:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50AGU8Eb003614;
	Fri, 10 Jan 2025 19:41:36 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yfatm2jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 19:41:36 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50AJfZtX11469498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 19:41:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE7C658059;
	Fri, 10 Jan 2025 19:41:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54C1058058;
	Fri, 10 Jan 2025 19:41:35 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.130.82])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jan 2025 19:41:35 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
        kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
        sam@mendozajonas.com, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] net/ncsi: Fix NULL pointer derefence if CIS arrives before SP
Date: Fri, 10 Jan 2025 13:41:33 -0600
Message-ID: <20250110194133.948294-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DeXRnO5upH6Fy6siIyIlIdccsQsgeZla
X-Proofpoint-ORIG-GUID: RgTKoyRG45DUy38PZ9j9A3fpth5TibdA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 spamscore=0 clxscore=1011 mlxlogscore=933 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501100150

If a Clear Initial State response packet is received before the
Select Package response, then the channel set up will dereference
the NULL package pointer. Fix this by setting up the package
in the CIS handler if it's not found.

[    9.289221] 8<--- cut here ---
[    9.289244] Unable to handle kernel NULL pointer dereference at virtual address 00000018 when read
[    9.289306] [00000018] *pgd=00000000
[    9.289333] Internal error: Oops: 5 [#1] SMP ARM
[    9.289367] CPU: 0 PID: 35 Comm: kworker/0:2 Not tainted 6.6.69-f1d562d-gf1d562dd8fa4 #1
[    9.289423] Hardware name: Generic DT based system
[    9.289457] Workqueue:  0x0 (events)
[    9.289486] PC is at _raw_spin_lock_irqsave+0x10/0x4c
[    9.289525] LR is at ncsi_add_channel+0xd0/0x174
[    9.289561] pc : [<808d1018>]    lr : [<808907bc>]    psr: 40000193
[    9.289605] sp : b4801e20  ip : 8695e000  fp : 80d6c2a8
[    9.289642] r10: 80d6c2a8  r9 : 8136a4dc  r8 : 00000018
[    9.289680] r7 : 00000000  r6 : 00000000  r5 : 8695dc00  r4 : 00000000
[    9.289725] r3 : 00000005  r2 : 00000018  r1 : 8089202c  r0 : 40000113
[    9.289770] Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    9.289821] Control: 10c5387d  Table: 81adc06a  DAC: 00000051
[    9.289861] Register r0 information: non-paged memory
[    9.289898] Register r1 information: non-slab/vmalloc memory
[    9.289939] Register r2 information: non-paged memory
[    9.289976] Register r3 information: non-paged memory
[    9.290012] Register r4 information: NULL pointer
[    9.290046] Register r5 information: slab kmalloc-1k start 8695dc00 pointer offset 0 size 1024
[    9.290111] Register r6 information: NULL pointer
[    9.290145] Register r7 information: NULL pointer
[    9.290180] Register r8 information: non-paged memory
[    9.290216] Register r9 information: non-slab/vmalloc memory
[    9.290257] Register r10 information: non-slab/vmalloc memory
[    9.290298] Register r11 information: non-slab/vmalloc memory
[    9.290339] Register r12 information: slab kmalloc-1k start 8695e000 pointer offset 0 size 1024
[    9.290404] Process kworker/0:2 (pid: 35, stack limit = 0x401e97d3)
[    9.290448] Stack: (0xb4801e20 to 0xb4802000)
[    9.290482] 1e20: 00000000 81099810 81be7150 81368000 00000000 000024a8 81be7150 8088efc4
[    9.290540] 1e40: 81be7150 00000000 00000000 8ae45185 00000000 00000000 81368000 8088f4fc
[    9.290598] 1e60: 86337300 806fce18 81368018 0000008a 00000780 00000000 86662dc2 8ae45185
[    9.290656] 1e80: 00000780 81365800 8088f3e4 0000002a b2c44000 b2c44090 81365800 86337300
[    9.290714] 1ea0: 00000000 8071c4d8 00000002 86337300 8136c45c 8ae45185 80115aa0 86337300
[    9.290772] 1ec0: 0000000a 8071c584 b2c44000 b2c44090 00005800 8ae45185 81365dd8 805be000
[    9.290830] 1ee0: 00000000 805be060 00000040 81365d80 0000002a 00000000 00000036 00000001
[    9.290888] 1f00: 00000040 81365dd8 b4801f53 ffff8ea7 80d03d00 00000000 81365dd8 8071d010
[    9.290946] 1f20: 81365dd8 8071d010 49514f00 b3d96100 0000012c b3d962c0 b4801f58 8071d4a4
[    9.291004] 1f40: b4801f60 81081980 80c4e100 33148000 00c4e100 33148000 b4801f58 b4801f58
[    9.291062] 1f60: b4801f60 b4801f60 b4801f68 8ae45185 b3d929f0 00000004 00000008 80d0308c
[    9.291120] 1f80: 81081980 00000100 40000003 0000000c 80d03080 801206d4 80c4c790 b480900c
[    9.291178] 1fa0: 80d03080 b4801f98 80c493c8 0000000a 00000000 80c4d380 80c4d380 ffff8ea6
[    9.291237] 1fc0: 80d03d00 04208060 80c4c790 8016c180 80d06094 81081980 80000013 ffffffff
[    9.291295] 1fe0: b4935f44 61c88647 81081980 81081980 b4935f08 80120c84 80134f4c 808945b8
[    9.291351]  _raw_spin_lock_irqsave from ncsi_add_channel+0xd0/0x174
[    9.291402]  ncsi_add_channel from ncsi_rsp_handler_cis+0x98/0xb4
[    9.291451]  ncsi_rsp_handler_cis from ncsi_rcv_rsp+0x118/0x2c4
[    9.291498]  ncsi_rcv_rsp from __netif_receive_skb_one_core+0x58/0x7c
[    9.291547]  __netif_receive_skb_one_core from netif_receive_skb+0x2c/0xc4
[    9.291597]  netif_receive_skb from ftgmac100_poll+0x350/0x43c
[    9.291642]  ftgmac100_poll from __napi_poll.constprop.0+0x2c/0x180
[    9.291690]  __napi_poll.constprop.0 from net_rx_action+0x340/0x3c0
[    9.291736]  net_rx_action from handle_softirqs+0xf4/0x25c
[    9.291777]  handle_softirqs from irq_exit+0x80/0xb0
[    9.291816]  irq_exit from call_with_stack+0x18/0x20
[    9.291857]  call_with_stack from __irq_svc+0x98/0xb0
[    9.291898] Exception stack(0xb4935f10 to 0xb4935f58)
[    9.291935] 5f00:                                     00000007 00000006 80d03d00 00000769
[    9.291993] 5f20: 85963e80 b3d953c0 80d03d00 b3d953e0 61c88647 85963eac 81081980 b3d953c0
[    9.292050] 5f40: 00000004 b4935f60 80134f28 80134f4c 80000013 ffffffff
[    9.292096]  __irq_svc from worker_thread+0x1fc/0x4e8
[    9.292137]  worker_thread from kthread+0xe0/0xfc
[    9.292176]  kthread from ret_from_fork+0x14/0x28
[    9.292213] Exception stack(0xb4935fb0 to 0xb4935ff8)
[    9.292250] 5fa0:                                     00000000 00000000 00000000 00000000
[    9.292308] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    9.292365] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    9.292413] Code: e1a02000 e10f0000 f10c0080 f592f000 (e1923f9f)
[    9.292455] ---[ end trace 0000000000000000 ]---
[    9.295147] Kernel panic - not syncing: Fatal exception in interrupt

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 net/ncsi/ncsi-rsp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index e28be33bdf2c4..59d0af7183acc 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -100,6 +100,13 @@ static int ncsi_rsp_handler_cis(struct ncsi_request *nr)
 		if (ndp->flags & NCSI_DEV_PROBED)
 			return -ENXIO;
 
+		if (!np) {
+			id = NCSI_PACKAGE_INDEX(rsp->rsp.common.channel);
+			np = ncsi_add_package(ndp, id);
+			if (!np)
+				return -ENODEV;
+		}
+
 		id = NCSI_CHANNEL_INDEX(rsp->rsp.common.channel);
 		nc = ncsi_add_channel(np, id);
 	}
-- 
2.43.5


