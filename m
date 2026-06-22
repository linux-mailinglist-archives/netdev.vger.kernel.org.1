Return-Path: <netdev+bounces-300971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q7ufIv/nOGqijwcAu9opvQ
	(envelope-from <netdev+bounces-300971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:45:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B4E6AD582
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:45:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b="Lo/MZbCa";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300971-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300971-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0AC23016265
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 07:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D147A369D4F;
	Mon, 22 Jun 2026 07:45:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366473655E2;
	Mon, 22 Jun 2026 07:44:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114300; cv=none; b=blOS5f+d8Zht0XMJD9bdjMkOFNBcd67vZ8ldjAT2nKQTUUF67HK0uGSBFSzj1cCHyk/Y/g6YbmjovvmDBAPlUC2tX0FgA7o16Vv4qurrJI4czwyGm4ML8TXsfRRewnj+iVyFRJNYfWxb2j5lp4vhIUU6sZj/mXDQ9WO8JYBlAz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114300; c=relaxed/simple;
	bh=J91I3Gu3m4EIy3VP8VX1uogjbA+L3WLNmgsqNkSYa9w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=igop462rfXdWuceJvRi9szXKa5EFQDP6kuCDltZI6PXuk208JbjOFdISrFiNKVyZ5A1qYcZAs4amQiSrFswGMAWX5D+zRhYOsnWUV43ovOJ3h7fjRDcVpqcISeLEJvPlgwC/RooCrGKzwRUDcC6OXuK4uFMAaUn++KSXIOWJB5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Lo/MZbCa; arc=none smtp.client-ip=205.220.166.238
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M6jsFV995069;
	Mon, 22 Jun 2026 00:43:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=Cge2rn2lJ
	/F4b/+ZaBpnREKhpXxXNwbNDvnD244YEUI=; b=Lo/MZbCap+WuOj5/hG9YzQG6V
	xAvPyWy+LmMciWKQGsFAbKjISIbXo49vkQOzbtVBv5k5Hka+QHUp1Cd3SWnAvGk5
	XMQuQIuJRCpl6mSmJIqEKw0LUVrYDdGyQaccAO8sqcUdTQbSK7bIEnQe3LwV+dQK
	axswE+R5KP2wCeX4LioUTl7zIrNoyEvMcau5V8HVHeT/MLxGeX5NpOdX29Niuzpe
	kWX1NYlteCr1i2KmbJS+I25IWEZi7bxP8giBmFVaGZjId8IQjrxc1NC+5Jjl8S8W
	md7uMqSikJgoD0c7jwePJeEeFRv8NBTEQFc9PeYORnlnXx/Do5sygPgJjlimw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ewp51sh0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 22 Jun 2026 00:43:54 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 22 Jun 2026 00:43:54 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 22 Jun 2026 00:43:51 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <marcin.s.wojtas@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>,
        <rostedt@goodmis.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rt-devel@lists.linux.dev>, <yun.zhou@windriver.com>
Subject: [PATCH v4] net: mvneta: re-enable percpu interrupt on resume
Date: Mon, 22 Jun 2026 15:43:50 +0800
Message-ID: <20260622074350.1666290-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1eszxaEjD_r2EJLOvzZS0HIS10Bbkr1n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA3NCBTYWx0ZWRfX4hEZg9+XTaQb
 TLx25PXtTkJDs4oLr6LI2zKsL75Es4ltCqPJMbeFObLerh+i5xyh3thYUyLbdDkAVcm10JpzLFQ
 A//5YDlWTTpcopFmDHxclRrj49ePgW3odmPIB9osO7Q8FUVHBd5gtDU4n5kp0oScUrf/7LVBbJT
 Sh6fcJQduSoY3I6II9Y5HRNQ4vZmC84jjOGRVmGOpB6PwT7+L+hOcesx3/SAjKWlyHu8d1o3odE
 dE5HwYFZh4pepgtbW/xkzAXYZ/t2Q7C+cknDU4M1/0krfC2DjMrjaLjU5kNRp8Q6ziTmGdHUeqw
 zYYTugUZujexCw63ajHwDrHivudWStv6ed+N1SCWzICDsk4B3A8/X3Y8TZYSzgML0YZjq1V1Lu2
 qXOUe/eTcxuXMuVcaKAfDWvc7legtaC7nhi2f3ZSF1Cf5B2w9Ale3AtiB0kRYV5scNLTbRFCFZP
 x0v62mQHqrJufXcIn8g==
X-Authority-Analysis: v=2.4 cv=KKNqylFo c=1 sm=1 tr=0 ts=6a38e7ba cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8 a=IiQtowvc5NyaFes3EFkA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 1eszxaEjD_r2EJLOvzZS0HIS10Bbkr1n
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA3NCBTYWx0ZWRfX5yf8JdX468gX
 QR02gSJ8MkqxXHNwcT1l/vV61nE2XAy2uF6hL8jphxEUxF4ngNSK6VTSoMrSBjsKyexk8WtwXU7
 WjgIcWM1x1/0YOJkTw2+YEQahZ2CjHi/K4Vxf15apINGFljV9EAh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220074
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300971-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:yun.zhou@windriver.com,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,goodmis.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[windriver.com:+];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4B4E6AD582

On Marvell MPIC platforms (Armada 370/XP/38x), mvneta uses a percpu
IRQ disable/enable scheme for NAPI: the ISR (mvneta_percpu_isr) calls
disable_percpu_irq() to mask the MPIC per-CPU interrupt and schedules
NAPI poll, which calls enable_percpu_irq() on completion to unmask.

If suspend occurs while NAPI poll is pending (between
disable_percpu_irq in the ISR and enable_percpu_irq in poll
completion), the interrupt is never re-enabled:

  1. mvneta_percpu_isr: disable_percpu_irq() + napi_schedule()
     => MPIC masked, percpu_enabled cpumask bit cleared
  2. NAPI poll does not complete before suspend proceeds
     (on PREEMPT_RT this is highly likely since softirqs run in
     ksoftirqd which gets frozen; on non-RT it can happen when
     softirq processing is deferred to ksoftirqd)
  3. mvneta_stop_dev => napi_disable(): cancels the pending poll
     without executing the completion path
  4. suspend_device_irqs => IRQCHIP_MASK_ON_SUSPEND: masks MPIC
     (already masked, but records IRQS_SUSPENDED)
  5. Resume: mpic_resume checks irq_percpu_is_enabled() => false
     (bit was cleared in step 1) => skips unmask
  6. mvneta_start_dev only restores device-level INTR_NEW_MASK,
     does not touch the MPIC per-CPU mask

Result: MPIC per-CPU interrupt stays masked permanently. The NIC
generates interrupts (INTR_NEW_CAUSE != 0) but the CPU never
receives them, causing complete loss of network connectivity.

Fix by calling on_each_cpu(mvneta_percpu_enable) in the resume path
to unconditionally unmask the MPIC per-CPU interrupt regardless of
pre-suspend state.

Fixes: 12bb03b436da ("net: mvneta: Handle per-cpu interrupts")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
v4:
  - Rewrite commit message with accurate root cause analysis.

v3:
  - Dropped the free_irq/request_irq approach (incorrect root cause).
  - Instead, call on_each_cpu(mvneta_percpu_enable) in the resume path
    to ensure the MPIC percpu IRQ is unmasked, matching mvneta_open().
  - Updated commit message with correct root cause analysis.

v2:
  - Move request_irq before cpuhp registration in resume (matching
    mvneta_open ordering) so that failure does not leave cpuhp
    callbacks registered on a non-functional device.
  - On request_irq failure, call netif_device_detach() to prevent
    further traffic on the dead interface.

 drivers/net/ethernet/marvell/mvneta.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 488f2663ad2c..543e566425c1 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5918,6 +5918,9 @@ static int mvneta_resume(struct device *device)
 	rtnl_unlock();
 	mvneta_set_rx_mode(dev);
 
+	if (!pp->neta_armada3700)
+		on_each_cpu(mvneta_percpu_enable, pp, true);
+
 	return 0;
 }
 #endif
-- 
2.43.0


