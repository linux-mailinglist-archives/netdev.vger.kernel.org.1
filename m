Return-Path: <netdev+bounces-306183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n7/dNS+ET2pSigIAu9opvQ
	(envelope-from <netdev+bounces-306183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 13:21:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBB6730382
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 13:21:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=EeY3sV2K;
	dmarc=pass (policy=reject) header.from=windriver.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306183-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306183-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF84D31AC884
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 10:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C78A413256;
	Thu,  9 Jul 2026 10:53:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576A2411675;
	Thu,  9 Jul 2026 10:52:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594383; cv=none; b=AKb3uNUv91iFmoqGRSROLvPdJajSAKgXnc3u8FXXHTRTvvfvIIbI+4pgkhj+2eZtBQU+TIsAYliq1tDI+ffo7ghfCnLcFj4hQWRNWR8YqLHmydtn5pZvlbnbZliIB+S5V0p5wV+F6L0235dPbhLDs3DdSk4eVLvKneP9cBOsToc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594383; c=relaxed/simple;
	bh=V3rpfWAd+lWD9msPJ9an2gJqMtwH77vCEKUZ/6rphls=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FWs/Sh5ZD4+KdBe6Q7wFLHEXEoCKk9psseS3+esLRFCBA0esB7xOmQdaZzOItm8N4gFGP9YqM4IfWR1bSwt2KlbxdmBJ+QOVOPh0rNR5icMvsVtPLn6/XesptTRTEqTY8MF66WaUURsDOfRhdYwc59yZ4Xf9deJTOAL1r5Mjljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=EeY3sV2K; arc=none smtp.client-ip=205.220.166.238
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669ALKuW2183284;
	Thu, 9 Jul 2026 03:52:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=7iLGBe6dL
	tR3X+bil544DxNqjEmhqOYIjDDrXOXzhsg=; b=EeY3sV2KusRwNHV21/a1/J5sy
	64ro/l54HQClpE8leBmFoX2Jw5KlHHxpiWGYkxUuv7tFuG3xx9BWpjKfG40yLdnz
	b0K0QAhjYC+/OhhFCtogKbRuy4X/nke6+dzIh6R8IBnK1+L3KWVe3WHxXHfkRwQ7
	TNU1gFZxPArU4Zi+SLwLXKNhF7z/6uoaffokZWELpL5fHQUYZOIv10K+BJ4Pr06n
	0PfGrJufuHyn3GHTsD/FGuGk3a8Ta/LNzHOXXpdQ+84GhqaV7wbh/mZFMpz2CaJU
	+Cc8mvMcW5XTABIynnsGB4gVKVaAtT8A8DxiQqGwbVkehT5hbWVyRtZe14rlg==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fa1gy8qap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 09 Jul 2026 03:52:47 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 9 Jul 2026 03:52:46 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 9 Jul 2026 03:52:44 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>
Subject: [PATCH] net: gre: fix lltx regression for GRE tunnels with SEQ/CSUM
Date: Thu, 9 Jul 2026 18:52:43 +0800
Message-ID: <20260709105243.864835-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: orP29TGAcc_p0bFjhlYFd1CxclJbsE4s
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwNSBTYWx0ZWRfXxV04wVr/eQMK
 sirk8NohBtKzCzstQ18GF+K6glUBWTQTY8J8Ptsdms+rrOZOg4ivXV83BdGLEGiAc480+hkWTtV
 4t8brFvxnZT0Iquf13VmIHV/mJRPfgTTTpXG8uHWLhpfFqLVfYmW
X-Proofpoint-GUID: orP29TGAcc_p0bFjhlYFd1CxclJbsE4s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwNSBTYWx0ZWRfX/gidtCm3i2Z4
 ZwICXEQILUcD6BCB8B0PhfyJ0RE02yI6xmTR/wt3BA1ZXVe1oYdT4wNSFSKXjg08Dhb5xeZA5EP
 5tZTpIP+nTN4XaSl2OMG94ZENHbcSt3NtE5UmPT0VZ55ISK6qh8VinXJIgO0WCf/UePmdmVLbGl
 bPHia8ataoDmb4OvOCAoGrZC4AE9EFT8eNY/6JghA+iHvxAy/66a5hLJmV0wPISb3XhwieBEYR+
 BxmdsJcncT5+ejndP6/4/+g6wAmo/U7aGunn96X2QAuJmpH4+MsituydLCW/MKPoPlTX9SPCj/Y
 ucRxuA0861f6Nkm7j5Tomcgy6ikPVicwOHlfyAvxUthmKonqwxLQKTnBzaq1tzOmHE5/Kq4UL74
 PpuM1WbPpFmM+rlGsrVH9e7ffZJ1QnUaRpTYR2wDjUC6lW8WyEMx96d6l/a/lLD2wtZE7Ia1jXT
 WcsHSEJeOOB8Sf5/Xgw==
X-Authority-Analysis: v=2.4 cv=P7IKQCAu c=1 sm=1 tr=0 ts=6a4f7d7f cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8 a=493gFeiaP1eb9wWiEwEA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090105
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306183-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yun.zhou@windriver.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,windriver.com:from_mime,windriver.com:email,windriver.com:mid,windriver.com:dkim];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CBB6730382

Before commit 00d066a4d4ed ("netdev_features: convert NETIF_F_LLTX to
dev->lltx"), NETIF_F_LLTX was set unconditionally in __gre_tunnel_init()
alongside GRE_FEATURES:

    dev->features |= GRE_FEATURES | NETIF_F_LLTX;

When that commit converted NETIF_F_LLTX to the dev->lltx flag, it
placed 'dev->lltx = true' after the SEQ/CSUM early returns instead
of before them. This causes GRE/GRETAP tunnels with SEQ or CSUM+encap
to lose lockless TX, reintroducing _xmit_lock acquisition around their
ndo_start_xmit. Since GRE xmit re-enters the stack via
ip_tunnel_xmit(), holding _xmit_lock risks ABBA deadlock with the
underlay device.

  CPU0                        CPU1
  ----                        ----
  lock(&qdisc_xmit_lock_key#6);
                              lock(&qdisc_xmit_lock_key#3);
                              lock(&qdisc_xmit_lock_key#6);
  lock(&qdisc_xmit_lock_key#3);

Fix by moving dev->lltx = true before the early returns, restoring
the original unconditional behavior.

Fixes: 00d066a4d4ed ("netdev_features: convert NETIF_F_LLTX to dev->lltx")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 net/ipv4/ip_gre.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 9fbff16cda1d..8c5ad8ec8d09 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1018,6 +1018,8 @@ static void __gre_tunnel_init(struct net_device *dev)
 	dev->features		|= GRE_FEATURES;
 	dev->hw_features	|= GRE_FEATURES;
 
+	dev->lltx = true;
+
 	/* TCP offload with GRE SEQ is not supported, nor can we support 2
 	 * levels of outer headers requiring an update.
 	 */
@@ -1029,8 +1031,6 @@ static void __gre_tunnel_init(struct net_device *dev)
 
 	dev->features |= NETIF_F_GSO_SOFTWARE;
 	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
-
-	dev->lltx = true;
 }
 
 static int ipgre_tunnel_init(struct net_device *dev)
-- 
2.43.0


