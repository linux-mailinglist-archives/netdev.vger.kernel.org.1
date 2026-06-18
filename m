Return-Path: <netdev+bounces-300402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iP/1ByLMM2rDGQYAu9opvQ
	(envelope-from <netdev+bounces-300402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:44:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5769B69F787
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:44:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=OPN5O8Zd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300402-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300402-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4C16300EE9A
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56E83EB0FB;
	Thu, 18 Jun 2026 10:44:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138702609E3;
	Thu, 18 Jun 2026 10:44:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779487; cv=none; b=Im7EJCFqeO+qn4y3Y9a3+HLhygsdc4qblc8ktNoD/oy65/+L/DZn6xJ297gQvyh7h6oxtgCFRLnflEtBylYT8dpn+ND5RpZ0KLMauPsyCuWMzVacjN7+v8qwwdyADFtqXQaOo4TeMZFVoiWYslQt010C6c1OyhqIIwXnTZmNn5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779487; c=relaxed/simple;
	bh=VFXXG5RvzD0D/5bY4Nz0tmnOYc76vgODGIKrssawzzU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eHnGJJ53/8nYmm401h3gRA04JO9RmjfSj3uqCFyuWZjFmnVN9f6M0X2WVD9ID7LriTzfUoe8mvWAMEGrlCdOmV87ipwqvyv9KIgzaXtTGMookckfrFHFmB2ifzEnU8PCrP3D5E/YA8TDAXXSRdf9I3+MHjtQ+qnzt5wu6ZNyZNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=OPN5O8Zd; arc=none smtp.client-ip=205.220.178.238
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I9qsV13905107;
	Thu, 18 Jun 2026 10:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=mBlCMtU+Q
	cj4sYAjPO9TPKSpZBmc5AZXM8mjbjJnoLY=; b=OPN5O8ZdRfwGfJz1C6gMDF7Dd
	z6M6Asii0CrvDyA0ploMBRX4lDKL1B8101PO/kCkj0NDkeGkLEV/b61UuajkX7tR
	3GRX6BDoiquCR5UEUh/We0KI23t2mpDA5NiLD5wrjqi65+K0qjWshfWbRuHOEKej
	MsjXmgiuA4+GghO67MmTElvIEBJeVlH9BTChzFO2uw8ktIn8jTYXPjEEAiXMBLzK
	30AvXHMshj3fcnBfeykjnVh4SaOWdYzTm3tNb3MtB1DF1g7uorSSJ21vTzAcfWx5
	KE8C7Sqw99IEku05FM04UTQqmTxlCQrcA/hMtu/xTrmTV6SF2imBWNa8XcNhQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4euefc2eg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Jun 2026 10:43:56 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 18 Jun 2026 03:43:55 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 18 Jun 2026 03:43:52 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <marcin.s.wojtas@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <maxime.chevallier@bootlin.com>,
        <bigeasy@linutronix.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>
Subject: [PATCH v3] net: mvneta: re-enable percpu interrupt on resume
Date: Thu, 18 Jun 2026 18:43:51 +0800
Message-ID: <20260618104351.3456161-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5OSBTYWx0ZWRfX/eiNkLQzVJN4
 7jvnUdtYkjzWNXVWGvd9PS237dRFlrSjBrZXH+uOg+HQvA+tb1pTiLEUlFdLrfViPigFUJiHTzI
 qAk/zh84TxaaHYShgiEIC3RuM4SUSA3EFJYcvD5ndD/J00I6bKXw
X-Proofpoint-GUID: L0D3TEm_vw335OsfdHTkpvX-M0jQoDtl
X-Proofpoint-ORIG-GUID: L0D3TEm_vw335OsfdHTkpvX-M0jQoDtl
X-Authority-Analysis: v=2.4 cv=ObGoyBTY c=1 sm=1 tr=0 ts=6a33cbec cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=IiQtowvc5NyaFes3EFkA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5OSBTYWx0ZWRfX/v/su5NPtKa2
 4OVDs5AzbHD4MyzESZis3TiKnsICeGlMrg6TzTNTmy1xs43Xm/5grV7ehPBL+8oa//vnB1oEIre
 2qmhDIcIYwxqWfbYc/4TBgYJZ2lPgMV+OBd6qh0UTT0FpHHBxmTfCM0/eLWsfR0Ni9Q+j/Ulgi+
 J40/FyESVvBIWUpE81onIM3bzTsYFNZ9auSK7EfY8cpNik1dD6E4oGJc1y0rONI5ef3gUzJR0Ze
 OgrV+KGvSpDgTa+0oD1Zl7f3D4FJ87rZsYjtg+vQ8lOo2+aVyXsQIqdTU+Ty+DnzXRTD3/YcTBv
 ADPbLky2sNXH9qx6Aj6znGLgw0/ZjiLpIiFkCs4ejEMkIoaXrTvUil/erMw/+k1nMx+OXmQJtGJ
 zOTK/pzOsrdSKZKMebz+uLRQFaOaB2uQl9jEWtoD/vl4EuWvEUnj8b9vXL1qCp8MOlbJpLmSMti
 h9Iy8Lig+N/1ZYqmjvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180099
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300402-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:bigeasy@linutronix.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yun.zhou@windriver.com,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,linutronix.de];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5769B69F787

On Armada XP (non-armada3700), mvneta uses percpu interrupts where
the ISR (mvneta_percpu_isr) calls disable_percpu_irq() to mask the
MPIC percpu IRQ, then schedules NAPI. NAPI poll completion calls
enable_percpu_irq() to unmask.

If suspend occurs while NAPI is actively polling (between
disable_percpu_irq in the ISR and enable_percpu_irq in
napi_complete_done), the MPIC percpu interrupt remains masked.
mvneta_stop_dev/mvneta_start_dev do not manage the percpu IRQ
enable state -- they only control mvneta's own INTR_NEW_MASK register.

After resume, the MPIC percpu IRQ stays masked permanently: the
network hardware generates interrupts (INTR_NEW_CAUSE != 0) but the
CPU never receives them (irq count stops incrementing), causing a
complete loss of network connectivity.

Fix by calling on_each_cpu(mvneta_percpu_enable) after
mvneta_start_dev() in the resume path, ensuring the MPIC percpu
IRQ is always unmasked regardless of the pre-suspend state.

Fixes: 12bb03b436da ("net: mvneta: Handle per-cpu interrupts")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
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
index b4a845f04c05..5ef79e70e319 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5907,6 +5907,9 @@ static int mvneta_resume(struct device *device)
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


