Return-Path: <netdev+bounces-111145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B4E9300F1
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 21:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA1E1C210B1
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 19:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1FA29402;
	Fri, 12 Jul 2024 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F9sGPGq2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0399B288B5
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720812271; cv=none; b=OxeM9JwqA4aKRFnyInKUFvyclvOSGuh8sAnHcS8Kx16PqSrIAOMCmGIckJ1+ibHTzrjEaJenKZCcAqq96n/MXJ+tG5kiQ1iMeTOsLl9w23c/FofQwQA9cnx+zl4cu2usRhTogCzqxcYsDtRO8JCJ+aV+AdE/VOl7Kw82kYxtyf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720812271; c=relaxed/simple;
	bh=Z9SAVWOH3nQ/hZQ9vUq03QeCG/soOcqocTOpTwL0PlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NqyuXhZ2Y9CqW5c6BBXks5Td/Gddxmv2DZsgq/NDikpju0bIK2X8a8ljNzirLVfU4v/DjavdZG86Xm5PPb7Fhgu3J0TpYeatvM4E5jgUOeAStIfvLFR81KXiBR2xyziyZ2Njqh2NAXQsu4lY7ueXCZ6gX8rkRRXJOkwqMHfz6+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F9sGPGq2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CIhihL026496
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 19:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=K4jdHn4SJ01FB3ywoYHCTj/nsv
	DIuPmyIPiyPspw31s=; b=F9sGPGq2gxPYy6TC0oxCIb9HeN0XIz+ayABLKwSahe
	nuPYDUYk4IZuDxZcmBi38/hu1I7TbKEHaovAcXiz6xHoZVJoljiW0JuTTlqdx+OI
	sRxFfdoWPXyVeahyuISFSARm0nyKdRRD/n4TXMPwe3xNH4fktjfonMFELehKQudf
	UbLRQjfjfqoaG1Sv+eMPf4+gsMX4kCeGnIkY2aNPLpl3mD8Jdow807ZP8cqUMlfP
	NdzR8wbGbA2Kwg6woigXZx+0ZtL+Z5vdlOKzPIYv+9+oejJTZ+lFLFxGnjaiayUu
	jX7qTqAtnQ6Bqi2tKaB5+TxQgpBe/u2enhiM6L46KEaA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40b81n8btx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 19:24:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46CHl7av024646
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 19:24:20 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407hrn83wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 19:24:20 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46CJOH9s23462482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 19:24:19 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CE5558068;
	Fri, 12 Jul 2024 19:24:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE6075805D;
	Fri, 12 Jul 2024 19:24:16 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.16.211])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jul 2024 19:24:16 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Nick Child <nnac123@linux.ibm.com>
Subject: [RFC PATCH net-next 0/1] bonding: Return TX congested if no active slave
Date: Fri, 12 Jul 2024 14:24:04 -0500
Message-ID: <20240712192405.505553-1-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eqZZLtG-jSoKARv-puC0lPWuRVGeFGMb
X-Proofpoint-ORIG-GUID: eqZZLtG-jSoKARv-puC0lPWuRVGeFGMb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_15,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=716 mlxscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120130

Hello. Posting this as RFC because I understand that changing return codes can have unexpected results and I am not well versed enough to claim with certainty that this won't affect something elsewhere.

We are seeing a rare TCP connection timeout after only ~7.5 seconds of inactivity. This is mainly due to the ibmvnic driver hogging the RTNL lock for too long (~2 seconds per ibmvnic device). We are working on getting the driver off the RTNL lock but figured the core of the issue should also be considered.

Because most of this is new ground to me, I listed the background knowledge that is needed to identify the issue. Feel free to skip this part:

1. During a zero window probe, the socket attempts to get an updated window from the peer 15 times (default of tcp_retries2). Looking at tcp_send_probe0(), the timer between probes is either doubled or 0.5 seconds. The timer is doubled if the skb transmit returns NET_XMIT_SUCCESS or NET_XMIT_CN (see net_xmit_eval()). Note that the timer is set to a static 0.5 if NET_XMIT_DROP is returned. This means the socket can ETIMEOUT after 7.5 seconds. The return code is typically the return code of __dev_queue_xmit()

2. In __dev_queue_xmit(), the skb is enqueued to the qdisc if the enqueue function is defined. In this circumstance, the qdisc enqueue function return code propagates up the stack. On the other hand, if the qdisc enqueue function is NULL then the drivers xmit function is called directly via dev_hard_start_xmit(). In this circumstance, the drivers xmit return code propagates up the stack.

3. The bonding device uses IFF_NO_QUEUE, this sets qdisc to noqueue_qdisc_ops. noqueue_qdisc_ops has NULL enqueue function. Therefore, when the bonding device is carrier UP, bond_start_xmit is called directly. In this function, depending on bonding mode, a slave device is assigned to the skb and __dev_queue_xmit() is called again. This time the slaves qdisc enqueue function (which is almost always defined) is called.

4. When a device calls netif_carrier_off(), it schedules dev_deactivate which grabs the rtnl lock and sets the qdisc to noop_qdisc. The enqueue function of noop_qdisc is defined but simply returns NET_XMIT_CN.

5. The miimon of the bonding device periodically checks for the carrier status of its slaves. If it detects that all of its slaves are down, then it sets currently_active_slave to NULL and calls netif_carrier_off() on itself.

6. In the bonding devices xmit function, if it does not have any active slaves, it returns NET_XMIT_DROP.

Given these observations. Assume a bonding devices slaves all suddenly call netif_carrier_off(). Also assume that a tcp connection is in a zero window probe. There is a window for a behavioral issue here:
1. If the bonding device does not notice that its slaves are down (maybe its miimon interval is too large or the miimon commit could not grab rtnl), then the slaves enqueue function is invoked. This will either return NET_XMIT_SUCCESS OR NET_XMIT_CN. The probe timer is doubled.
2. If the bonding device notices the slaves are down. It sets active slave to NULL and calls netif_carrier_off() on itself. dev_deactivate() is scheduled:
    a. If dev_deactivate() executes. The bonding enqueue function (which was null) is now noop_enqueue and returns NET_XMIT_CN. The probe timer is doubled.
    b. If dev_deactivate() cannot execute for some time (say because it is waiting on rtnl). Then bond_start_xmit() is called. It sees that it does not have an active slave and returns NET_XMIT_DROP. The probe timer is set to 0.5 seconds.

I believe that when the active slave is NULL, it is safe to say that the bonding device calls netif_carrier_off() on itself. But there is a time where active_slave == NULL and the qdisc.enqueue != noop_enqueue. During this time the return code is different. Consider the following timeline:
  slaves go down
             |
             |   returns NET_XMIT_CN
             |
     bond calls carrier_off
             |
             |   returns NET_XMIT_DROP
             |
       dev_deactivate on bond
             |
             |   returns NET_XMIT_CN
             |

Because the bonding xmit function should really only be a route to a slave device, I propose that it returns NET_XMIT_CN in these scenarios instead of NET_XMIT_DROP. Note that the bond will still return NET_XMIT_DROP when it has NO slaves. Since miimon calls netif_carrier_off() when it doesn't have any active slaves, I believe this change will only effect the time between the bonding devices call to netif_carrier_off() and the execution of dev_deactivate().

I was able to see this issue with bpftrace:
  10:28:27:283929 - dev_deactivate eth252
  10:28:27:312805 - send_probe0 - port=8682 - snd_wnd 0, icsk_probes_out = 0+1
  10:28:27:760016 - send_probe0 - port=8682 - snd_wnd 0, icsk_probes_out = 1+1
  10:28:28:147410 - dev_deactivate eth251
  10:28:28:348387 - dev_queue_xmit rc = 2
  10:28:28:348394 - dev_queue_xmit rc = 2
  10:28:28:670013 - send_probe0 - port=8682 - snd_wnd 0, icsk_probes_out = 2+1
  10:28:28:670066 - dev_queue_xmit rc = 2
  10:28:28:670070 - dev_queue_xmit rc = 2
  10:28:30:440025 - send_probe0 - port=8682 - snd_wnd 0, icsk_probes_out = 3+1
  10:28:30:440084 - dev_queue_xmit rc = 2
  10:28:30:440088 - dev_queue_xmit rc = 2
  10:28:33:505982 - netif_carrier_off bond1
        netif_carrier_off+112
        bond_set_carrier+296
        bond_select_active_slave+296
        bond_mii_monitor+1900
        process_one_work+760
        worker_thread+136
        kthread+456
        ret_from_kernel_thread+92
  10:28:33:790050 - dev_queue_xmit rc = 1
  10:28:33:870015 - send_probe0 - port=8682 - snd_wnd 0, icsk_probes_out = 4+1
  10:28:33:870061 - dev_queue_xmit rc = 1
  10:28:34:300269 - dev_queue_xmit rc = 1
  10:28:34:380025 - send_probe0 - port=8682 - snd_wnd 0, icsk_probes_out = 5+1
  10:28:34:380072 - dev_queue_xmit rc = 1
  10:28:34:432446 - dev_queue_xmit rc = 1
  10:28:34:810059 - dev_queue_xmit rc = 1
  10:28:34:900014 - send_probe0 - port=8682 - snd_wnd 0, icsk_probes_out = 6+1
  10:28:34:900059 - dev_queue_xmit rc = 1
  10:28:35:000050 - dev_queue_xmit rc = 1
  10:28:35:330054 - dev_queue_xmit rc = 1
  10:28:35:410020 - send_probe0 - port=8682 - snd_wnd 0, icsk_probes_out = 7+1
  10:28:35:410070 - dev_queue_xmit rc = 1
  10:28:35:630865 - dev_queue_xmit rc = 1
  10:28:35:850072 - dev_queue_xmit rc = 1
  10:28:35:920025 - send_probe0 - port=8682 - snd_wnd 0, icsk_probes_out = 8+1
  10:28:35:920069 - dev_queue_xmit rc = 1
  10:28:35:940348 - dev_queue_xmit rc = 1
  10:28:36:140055 - dev_queue_xmit rc = 1
  10:28:36:370050 - dev_queue_xmit rc = 1
  10:28:36:430029 - send_probe0 - port=8682 - snd_wnd 0, icsk_probes_out = 9+1
  10:28:36:430089 - dev_queue_xmit rc = 1
  10:28:36:460052 - dev_queue_xmit rc = 1
  10:28:36:650049 - dev_queue_xmit rc = 1
  10:28:36:880059 - dev_queue_xmit rc = 1
  10:28:36:940024 - send_probe0 - port=8682 - snd_wnd 0, icsk_probes_out = 10+1
  10:28:36:940074 - dev_queue_xmit rc = 1
  10:28:36:980044 - dev_queue_xmit rc = 1
  10:28:37:160331 - dev_queue_xmit rc = 1
  10:28:37:390060 - dev_queue_xmit rc = 1
  10:28:37:450024 - send_probe0 - port=8682 - snd_wnd 0, icsk_probes_out = 11+1
  10:28:37:450082 - dev_queue_xmit rc = 1
  10:28:37:480045 - dev_queue_xmit rc = 1
  10:28:37:730281 - dev_queue_xmit rc = 1
  10:28:37:900051 - dev_queue_xmit rc = 1
  10:28:37:970019 - send_probe0 - port=8682 - snd_wnd 0, icsk_probes_out = 12+1
  10:28:37:970062 - dev_queue_xmit rc = 1
  10:28:38:000045 - dev_queue_xmit rc = 1
  10:28:38:240089 - dev_queue_xmit rc = 1
  10:28:38:420053 - dev_queue_xmit rc = 1
  10:28:38:490012 - send_probe0 - port=8682 - snd_wnd 0, icsk_probes_out = 13+1
  10:28:38:490076 - dev_queue_xmit rc = 1
  10:28:38:520048 - dev_queue_xmit rc = 1
  10:28:38:750069 - dev_queue_xmit rc = 1
  10:28:39:000029 - send_probe0 - port=8682 - snd_wnd 0, icsk_probes_out = 14+1
  10:28:39:000093 - dev_queue_xmit rc = 1
  10:28:39:030052 - dev_queue_xmit rc = 1
  10:28:39:260046 - dev_queue_xmit rc = 1
  10:28:39:450050 - dev_queue_xmit rc = 1
  10:28:39:520044 - SK_ERR(110) port=8682 - snd_wnd 0
        sk_error_report+12
        tcp_write_err+64
        tcp_write_timer_handler+564
        tcp_write_timer+424
        call_timer_fn+88
        run_timer_softirq+1896
        __do_softirq+348
        do_softirq_own_stack+64
        irq_exit+392
        timer_interrupt+380
        decrementer_common_virt+528
  10:28:47:813297 - dev_deactivate bond1

Again, I know the easier solution is to remove rtnl users to reduce the time before dev_deactivate (we are working on that as well).

Nick Child (1):
  bonding: Return TX congested if no active slave

 include/net/bonding.h | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.43.0


