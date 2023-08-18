Return-Path: <netdev+bounces-28846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE33D78100B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEDA41C21630
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A99719BC4;
	Fri, 18 Aug 2023 16:15:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E1619BC3
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:15:04 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC524215
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:15:01 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IFlOkt022435;
	Fri, 18 Aug 2023 16:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bI6FGkL+/KJ5AxiLOHYgA6ULzW3pWF6g2T/jJornhyI=;
 b=GeYIAY9uSwME+KpdBFsNicYESYAZCyOK6Flkd+gHfa8jjNVjFeknGcRb/Kb1zjtzPtQN
 mzg2P/ChC/zWyoONRWYrzTdr36D7g6uuHJ5RUcCaCx7ZpWa5mzwUSQrFkB4gk7DeFZte
 DjFMp7y7Bm6AJMF4ZpO/eraYZ/i0PvVliQGQ39RniDg2bA5zhSKpHs1dttjfL0W+H2a8
 9SkF2797P0HduIHe7gbK0+HMFHQKg3KWiHOCdXJAm8XoPLPZVgYKF9OQLAT/v1i0cfNH
 8Az3xBhbGTpj+dTItiOGVAR3Zz1ABmRymiVBQyN+/R7k6XZDT1N7HdKtHmEdLYrNdmo+ fw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjbkfrk46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:14:56 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37IG4rnJ007682;
	Fri, 18 Aug 2023 16:14:55 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjbkfrk3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:14:55 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37IEu6fe003434;
	Fri, 18 Aug 2023 16:14:54 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3semdt8s66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:14:54 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37IGEqcG63111658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Aug 2023 16:14:52 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48BB458043;
	Fri, 18 Aug 2023 16:14:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E220658059;
	Fri, 18 Aug 2023 16:14:51 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.53.174.71])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Aug 2023 16:14:51 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: kuba@kernel.org
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
        manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
        skalluru@marvell.com, VENKATA.SAI.DUGGI@ibm.com,
        Thinh Tran <thinhtr@linux.vnet.ibm.com>,
        Abdul Haleem <abdhalee@in.ibm.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Simon Horman <simon.horman@corigine.com>,
        Venkata Sai Duggi <venkata.sai.duggi@ibm.com>
Subject: [Patch v6 0/4] bnx2x: Fix error recovering in switch configuration
Date: Fri, 18 Aug 2023 11:14:39 -0500
Message-Id: <20230818161443.708785-1-thinhtr@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230728211133.2240873-1-thinhtr@linux.vnet.ibm.com>
References: <20230728211133.2240873-1-thinhtr@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J2phXJJ0iIYH9hmV7dPJHp_MROptPYwn
X-Proofpoint-ORIG-GUID: 82RH1J5HgLw8Z-9tsCPXJkVY3iRW8Spt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_20,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=682 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

While injecting PCIe errors to the upstream PCIe switch of
a BCM57810 NIC, system hangs/crashes were observed.

After several calls to bnx2x_tx_timout() complete,
bnx2x_nic_unload() is called to free up HW resources
and bnx2x_napi_disable() is called to release NAPI objects.
Later, when the EEH driver calls bnx2x_io_slot_reset() to
complete the recovery process, bnx2x attempts to disable
NAPI again by calling bnx2x_napi_disable() and freeing
resources which have already been freed, resulting in a
hang or crash.

This patch set introduces a new flag to track the HW 
resource and NAPI allocation state, refactor duplicated
code into a single function, check page pool allocation
status before freeing, and reduces debug output when
a TX timeout event occurs.


Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Reviewed-by: Manish Chopra <manishc@marvell.com>
Tested-by: Abdul Haleem <abdhalee@in.ibm.com>
Tested-by: David Christensen <drc@linux.vnet.ibm.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Tested-by: Venkata Sai Duggi <venkata.sai.duggi@ibm.com>

  v6:
   - Clarifying and updating commit messages
  v5:
   - Breaking down into a series of individual patches
  v4:
   - factoring common code into new function bnx2x_stop_nic()
     that disables and releases IRQs and NAPIs
  v3:
   - no changes, just repatched to the latest driver level
   - updated the reviewed-by Manish in October, 2022
  v2:
   - Check the state of the NIC before calling disable nappi
     and freeing the IRQ
   - Prevent recurrence of TX timeout by turning off the carrier,
     calling netif_carrier_off() in bnx2x_tx_timeout()
   - Check and bail out early if fp->page_pool already freed


Thinh Tran (4):
  bnx2x: new the bp->nic_stopped variable for checking NIC status
  bnx2x: factor out common code to bnx2x_stop_nic()
  bnx2x: Prevent access to a freed page in page_pool
  bnx2x: prevent excessive debug information during a TX timeout

 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h   |  2 ++
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   | 33 ++++++++++++++-----
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   |  4 +++
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 26 +++------------
 .../net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c  |  9 ++---
 5 files changed, 37 insertions(+), 37 deletions(-)

-- 
2.27.0


