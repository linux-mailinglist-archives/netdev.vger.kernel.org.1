Return-Path: <netdev+bounces-307233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kf9sDJECVWpbiwAAu9opvQ
	(envelope-from <netdev+bounces-307233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 17:21:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8293974CF5D
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 17:21:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=dLMI3uuh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307233-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307233-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CC473294AA1
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 15:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980C0348C5C;
	Mon, 13 Jul 2026 15:10:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F433451C8;
	Mon, 13 Jul 2026 15:09:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955402; cv=none; b=njdLnhcRv9+7bYu1kJUD++7l4Zb8FdlsAJ5qRdlyd6MB3gr6cu7//icKtkcMvDIQ/OOqF62MQGHox+nH4QYj/lAxhpYobBNjWxnw3lJAaEkNq34zWOkZGCE8UWE6OnI6h9/njIYjBPk2Up4w2l1boVqBQ9nBQSeLQUNuWx0awos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955402; c=relaxed/simple;
	bh=Fs4y9gbZTzNJk6w+nYQBjZcpf+/DqAcMGGGE4d19Aho=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HDA+CoTLkwKo2s/SJtKvUbV+OXlGKFSPkLyCB9RUGDg+tzJvBY6aZlPOWSbBHLOOl7X8w0mIB+re8TEPx2mobZOQ8pjfZIb7Mvs/0MLsCaztSMaXvIYoPgMB7hn9AK2KUtLMm2CCB2pCOTsHTOdi99FyQHs42PRrUh7r9QommoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=dLMI3uuh; arc=none smtp.client-ip=205.220.166.238
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DF8LoW4012836;
	Mon, 13 Jul 2026 08:09:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=A0JXP8b6C
	PTjKJHUpXdcIgv+rY0BrJcRMA2DtSAkkMQ=; b=dLMI3uuh32X/a564yC8srZuKb
	83oHQ7hL3fsa+AeLnimKr/PkMA1mPPhjyyp4ltEIwUcwRNr4ko5HPcpimMkPXaC5
	V7eagIg7ZrVPsiHnzrofx/JvgEU5pj4EgFCmvgKsam5EaxWwSSgH3ArFgxlDjmoq
	XiK0n8ZneWxl5iRoBKM87eOiXxenlA7i/HdbOsuw1LnkrIs4ETxR3rfLRaRMSASK
	DKxaPrSAJ6htUsrxt3WH2e4sScMzrJXUVX78RsLVzuSFai58N8trYS7lT6WEvlzm
	uSomwnX7lH8wupY5U1c0tq+Y6a5eoDeHXDNCd1zG2Gu5HPBcS0ueXnkhV6qQg==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fbh40tbae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 13 Jul 2026 08:09:49 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 13 Jul 2026 08:09:48 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 13 Jul 2026 08:09:46 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>
Subject: [PATCH net v2] net: gre: fix lltx regression for GRE tunnels with SEQ/CSUM
Date: Mon, 13 Jul 2026 23:09:45 +0800
Message-ID: <20260713150945.1779628-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE1OCBTYWx0ZWRfX3HEcHNDi0Iw8
 F/hxqS5N9ufbuca2fFxkYVIJnEEvTB9QkCGBnTuBg9vDNKkeqQMZvogugbYE+FJGnYYviP6wyu4
 +m4HDrY+vaCsj6m5E3Lfd8w0KlbwXV48Vbn3HueLH2ixubqrDHOGJWUBnHhSh7+EAL9OvnxIKjq
 D0a2EjCpYs5O43yDjj1zcQBRJXLHUx1elEHqh8eLrAJrXpDqwCv6gg1fUuadlqekjAef2Hq460z
 HYfCRKpzTPkXs9TvWF7Fv8R151ZmM7ZnGgJqnN4hMwT+NcAIg6qQ+aYgPYEScwRnY0PaqApEwFc
 YhhUIiqzdLQwhCjWt+NHG/FLcgnQoBzDJh1ZEQLEz2MkZ+mtgbAJSrbat+8Miw3Uyi6AI9LMEep
 s2Cs+tyH+yCeIsJfDkB+MXrWmXJVORhG54OqqTGH5J659+BYiz8lZzXbJpE5A2Tz+YkO7758k1Z
 I63byaRA/H1dfpSmaPQ==
X-Proofpoint-ORIG-GUID: PwYu2WNeG9DL8WXtQvRFW7CP6s_RWVmh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE1OCBTYWx0ZWRfX3ofJEgvbu165
 IlW5rlRXOJTXVrC5oeMSFE46tw+JO2g7qNCsgjHpKIoZ/2cE281EeJ44ADHHs5p8nWo5ByHrWp4
 z1uub3Km8jMZJPtyOhOQI6FJAk4de6kK1SDCTGE+EfylRulOA0L7
X-Authority-Analysis: v=2.4 cv=JbGMa0KV c=1 sm=1 tr=0 ts=6a54ffbd cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8 a=vaTZyHDp2w___5c-YPsA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: PwYu2WNeG9DL8WXtQvRFW7CP6s_RWVmh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130158
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307233-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yun.zhou@windriver.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,windriver.com:from_mime,windriver.com:mid,windriver.com:email,windriver.com:dkim];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8293974CF5D

Before commit 00d066a4d4ed ("netdev_features: convert NETIF_F_LLTX to
dev->lltx"), NETIF_F_LLTX was set unconditionally in both
__gre_tunnel_init() and ip6gre_tnl_init_features() alongside
GRE_FEATURES:

    dev->features |= GRE_FEATURES | NETIF_F_LLTX;

When that commit converted NETIF_F_LLTX to the dev->lltx flag, it
placed 'dev->lltx = true' after the SEQ/CSUM early returns instead
of before them. This causes GRE/GRETAP/ip6gre tunnels with SEQ or
CSUM+encap to lose lockless TX, reintroducing _xmit_lock acquisition
around their ndo_start_xmit. Since GRE xmit re-enters the stack via
ip_tunnel_xmit(), holding _xmit_lock risks ABBA deadlock with the
underlay device.

  CPU0                        CPU1
  ----                        ----
  lock(&qdisc_xmit_lock_key#6);
                              lock(&qdisc_xmit_lock_key#3);
                              lock(&qdisc_xmit_lock_key#6);
  lock(&qdisc_xmit_lock_key#3);

Fix by moving dev->lltx = true before the early returns in both
functions, restoring the original unconditional behavior.

Fixes: 00d066a4d4ed ("netdev_features: convert NETIF_F_LLTX to dev->lltx")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
v2:
  - also fix the same issue for ipv6

 net/ipv4/ip_gre.c  | 4 ++--
 net/ipv6/ip6_gre.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

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
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 7c09a269b352..b843116e9b70 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1455,6 +1455,8 @@ static void ip6gre_tnl_init_features(struct net_device *dev)
 	dev->features		|= GRE6_FEATURES;
 	dev->hw_features	|= GRE6_FEATURES;
 
+	dev->lltx = true;
+
 	/* TCP offload with GRE SEQ is not supported, nor can we support 2
 	 * levels of outer headers requiring an update.
 	 */
@@ -1466,8 +1468,6 @@ static void ip6gre_tnl_init_features(struct net_device *dev)
 
 	dev->features |= NETIF_F_GSO_SOFTWARE;
 	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
-
-	dev->lltx = true;
 }
 
 static int ip6gre_tunnel_init_common(struct net_device *dev)
-- 
2.43.0


