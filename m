Return-Path: <netdev+bounces-26936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB302779861
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 22:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB11D1C2175E
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 20:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988E1219F2;
	Fri, 11 Aug 2023 20:15:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C26F8468
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 20:15:51 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0780A359C
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 13:15:47 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BJrWWC030947;
	Fri, 11 Aug 2023 20:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=EfufaZuycIccIfu1LlT6K2P2Wwz4hu/cSD/w/1xcyYM=;
 b=nUAUZwmDcuYuKzweLiIpCW6JwI2QjbPvXMhuhe8H6TLUg0mN3ya3aB0MKXRu3Gh0sXjt
 YLbM3VBl7qDDoWa3WXQJ+vT7PGkY0X9AnAa9+VTum5+K4RuPac/1NypFWXFiRRnzootR
 xXDML6aRRioIxXmHxih5BOxh05+FNoaeyOHaS0xk8kaBvUd1w9Rr23URzOMf8MfZhMp/
 9c31EnmSw8TeB2QbL9+NVnlV/InWihYraGhWq5lr1RKLb3vBNALsI9WvgA4IaHnBOhVi
 n0cmvsVx/viC9tqGkqPsurZaSoztL+h8UDLfARvZA7TVfou1/5c76+7G1Zx0AjjtxIQl ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sduhtrhcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Aug 2023 20:15:35 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37BK7t7V013335;
	Fri, 11 Aug 2023 20:15:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sduhtrhb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Aug 2023 20:15:34 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37BIo4ZY006432;
	Fri, 11 Aug 2023 20:15:33 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sd2evk5ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Aug 2023 20:15:33 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37BKFV9366781636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Aug 2023 20:15:32 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B11C15806A;
	Fri, 11 Aug 2023 20:15:31 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 787A258056;
	Fri, 11 Aug 2023 20:15:31 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.53.174.71])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Aug 2023 20:15:31 +0000 (GMT)
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
Subject: [Patch v5 0/4] bnx2x: Fix error recovering in switch configuration
Date: Fri, 11 Aug 2023 15:15:08 -0500
Message-Id: <20230811201512.461657-1-thinhtr@linux.vnet.ibm.com>
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
X-Proofpoint-GUID: piBX9mwzvZf6RVJn1i-Z9UIQ3mVkBp8a
X-Proofpoint-ORIG-GUID: uM4ORAetxD43LhxnvZl5ePOYGvAksHdb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=486 spamscore=0
 phishscore=0 clxscore=1011 suspectscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110184
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As the BCM57810 and other I/O adapters are connected
through a PCIe switch, the bnx2x driver causes unexpected
system hang/crash while handling PCIe switch errors, if
its error handler is called after other drivers' handlers.

In this case, after numbers of bnx2x_tx_timout(), the
bnx2x_nic_unload() is  called, frees up resources and
calls bnx2x_napi_disable(). Then when EEH calls its
error handler, the bnx2x_io_error_detected() and
bnx2x_io_slot_reset() also calling bnx2x_napi_disable()
and freeing the resources.


Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Reviewed-by: Manish Chopra <manishc@marvell.com>
Tested-by: Abdul Haleem <abdhalee@in.ibm.com>
Tested-by: David Christensen <drc@linux.vnet.ibm.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Tested-by: Venkata Sai Duggi <venkata.sai.duggi@ibm.com>

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
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   | 32 ++++++++++++++-----
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   |  4 +++
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 26 +++------------
 .../net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c  |  9 ++----
 5 files changed, 36 insertions(+), 37 deletions(-)

-- 
2.27.0


