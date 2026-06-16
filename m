Return-Path: <netdev+bounces-299767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v7dSIgL8MGpIaAUAu9opvQ
	(envelope-from <netdev+bounces-299767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 09:32:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0AA68CDDD
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 09:32:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=rgZukOpc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299767-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299767-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28A713181A57
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 07:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEC8397343;
	Tue, 16 Jun 2026 07:28:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50025280CC1;
	Tue, 16 Jun 2026 07:28:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594882; cv=none; b=kvefDCCldlLegwLDm4KnQuBL4VF40X1bwkTRFrTElGYlGpl32wGgEnRFpaWDIzNPrdX5QyoMQWJ4aOhbB1JR8iRQOX6xEskR5yiyVVX+BjHOEMYmrLYVPnTW36aEePQ6gSNR4/U4+uj3cNiqcMBm61YkF5Y8JYmpJWAZ7df3uIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594882; c=relaxed/simple;
	bh=nl2KhLYTjDu/weO3hmQUZyto7iut233yvLAozLtohfg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NUE7WmYX6TyZuqVD9v8Jx313sg+QZoSwjhIu04v80cjSg8JgQCQ0mnKQcRiWf7zVuvozNCkMyLtncg3SpTUmYRoqPBozSJP9MRe9SdAzZOa/UzAOO7zCznq6OgMKBk0NQ+gjsvUfonF0ahr0vGBtExD08aW/8IQHryDnotzhkAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=rgZukOpc; arc=none smtp.client-ip=205.220.178.238
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G69YmF2262437;
	Tue, 16 Jun 2026 07:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=W+cluXi79
	vQzeFuIuku4WBBZGeVmIeItCbIc6BatS6A=; b=rgZukOpcYnNGd+S126K7d4RLK
	vAroZ3sOlkRIp/e6mWwk0qyPV+Nq2MnIyjKAk6TSgOuegfapzp0dvNW/OrYUkEfM
	6PZWeuBXBDVIAG8saY8X5DlnZk0JTkSmmbL72thc4cckRIpPNFtClr5zR3D+qh4X
	Rx5swT7I7zPZpBiadcqWWz8EJBc8MRPmihoJRNjkp9uyLpPDVx/eoyilifG8BSBb
	JZaQ71cDizw5AxRPcuqU2rbeipEkjokOTJb36aZLjNX8TiETLQxYwISJtvOSrLbp
	lunMRU1iLZoWw852qR/4yGOF9h9Pv7ZYPv14l9Er55S8CxHDW/5UoL0nPDwcg==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4erx63vdqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 Jun 2026 07:26:54 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 16 Jun 2026 00:26:53 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 16 Jun 2026 00:26:50 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <marcin.s.wojtas@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>,
        <rostedt@goodmis.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rt-devel@lists.linux.dev>, <yun.zhou@windriver.com>
Subject: [PATCH] net: mvneta: free/request IRQ across suspend/resume
Date: Tue, 16 Jun 2026 15:26:49 +0800
Message-ID: <20260616072649.2514602-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=SvmgLvO0 c=1 sm=1 tr=0 ts=6a30fabe cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8 a=H1i4495hyjeC5Vi1NPAA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: eASCHtemyO39xCKV8K3IW93vE8r8mEHF
X-Proofpoint-ORIG-GUID: eASCHtemyO39xCKV8K3IW93vE8r8mEHF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA3MyBTYWx0ZWRfX1ly//fMlYdK9
 PkSuq6rwkIyVKraixGuaP6S7ReZOZY3M4GjkhyhogjbBtjOeLFaYUAviNkM2lRDD0z0PDDO297Y
 ChEt8tKCtx8IcIiECfBggd2qlElfbysbEz1KTKeDY1/WIBajumWr8wOrRDbbYmSCB5EaWjr68tV
 x1QhY8jJY9Vc5rL3cKHmVbKEnJ5ZLe4ysWX/wPz88Qwsl1PKjPQ+MwyqKHMYuUD7f9hz2mj+KM7
 /Hi0ASumC3U3lSTgo3NYtRr9yrNULQa7YuuQst/Wq1fhYcoA/IQzcEcNJlR7kJbPAcFzEt2827B
 tlFoMmcmUKM1Kpebn/B/B+++z4oyVT2rxan/P6M2Vttrh8dssx611l0nqfXGqu4j3JaGAodZWN8
 Ktaw3fNR029p/ZtVpw30dfbVOGY4nMcUpoSRsrLLJFR2gJ2peXUiNbJOp1S22RIMd2ZRFtvfqY0
 8c8irkNEID+bxi2Rsjg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA3MyBTYWx0ZWRfXxH3wVxPmftBa
 RICvVkj6cxCAVx5hoNt71qfgAfMb3yPPYNFKc7MpKWoIW3iaKJlJ9MOg4J9ovovsRC4SAqLYcF2
 h7B7hBZSTbDAv5KHgbLNGc/QAO4v/1pFyMaOl2jWnNOvzY1mlbOT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299767-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:yun.zhou@windriver.com,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,goodmis.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,windriver.com:dkim,windriver.com:email,windriver.com:mid,windriver.com:from_mime];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD0AA68CDDD

On PREEMPT_RT, the mvneta IRQ handler is force-threaded. Under high
network traffic, the IRQ can enter suspend with desc->depth == 1
(masked by the oneshot mechanism between handler invocations).

During suspend, the kernel increments depth to 2 and masks the
interrupt at the MPIC level (clearing the SRC_CTL CPU routing bit,
due to IRQCHIP_MASK_ON_SUSPEND). On resume, depth is decremented
back to 1, but since it does not reach 0, the unmask is never
called. The MPIC CPU routing remains cleared, permanently disabling
interrupt delivery.

Fix by freeing the IRQ in suspend and re-requesting it in resume.
This ensures a clean IRQ state (depth=0, proper hardware routing)
on every resume cycle, regardless of the pre-suspend depth. This
follows the approach used by other drivers (e.g. igb).

Fixes: 9768b45ceb0b ("net: mvneta: support suspend and resume")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 0c061fb0ed07..e7e9a58dbe55 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5819,6 +5819,20 @@ static int mvneta_suspend(struct device *device)
 	mvneta_stop_dev(pp);
 	rtnl_unlock();
 
+	/* Release IRQ to avoid stale MPIC mask state on resume.
+	 * On PREEMPT_RT, forced-threaded oneshot IRQs may leave the
+	 * interrupt masked (depth>0) at suspend time. This prevents
+	 * resume_device_irqs() from restoring the MPIC CPU routing,
+	 * permanently disabling the interrupt. Re-requesting the IRQ
+	 * on resume guarantees a clean state.
+	 */
+	if (pp->neta_armada3700)
+		free_irq(dev->irq, pp);
+	else {
+		on_each_cpu(mvneta_percpu_disable, pp, true);
+		free_percpu_irq(dev->irq, pp->ports);
+	}
+
 	for (queue = 0; queue < rxq_number; queue++) {
 		struct mvneta_rx_queue *rxq = &pp->rxqs[queue];
 
@@ -5895,6 +5909,20 @@ static int mvneta_resume(struct device *device)
 						 &pp->node_dead);
 	}
 
+	/* Re-request IRQ (see comment in mvneta_suspend) */
+	if (pp->neta_armada3700) {
+		err = request_irq(dev->irq, mvneta_isr, 0, dev->name, pp);
+	} else {
+		err = request_percpu_irq(dev->irq, mvneta_percpu_isr,
+					dev->name, pp->ports);
+		if (!err)
+			on_each_cpu(mvneta_percpu_enable, pp, true);
+	}
+	if (err) {
+		netdev_err(dev, "cannot request irq %d\n", dev->irq);
+		return err;
+	}
+
 	rtnl_lock();
 	mvneta_start_dev(pp);
 	rtnl_unlock();
-- 
2.43.0


