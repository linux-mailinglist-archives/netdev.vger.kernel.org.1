Return-Path: <netdev+bounces-298960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QwFtJMQ/LWo+eQQAu9opvQ
	(envelope-from <netdev+bounces-298960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:32:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8988367E7A1
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:32:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=nwRS11+N;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298960-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298960-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99AD03001FAA
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6268D3A7587;
	Sat, 13 Jun 2026 11:32:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152E71E9B1A;
	Sat, 13 Jun 2026 11:32:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781350334; cv=none; b=ml3lmwHFt9dA2bR5YJhd8hP6uhnGchbF+GUAtUP06+ZNFQ/S1QK7kSJscoiMddqmoxOB79bK50o3quVgSBkHK1R9BzH+X+nkkqXn7dgfmdF55kmx2HlRkS9HZcCnh1haeAU2+1AfVjqrv2+f0NUsOHr/xSkVGIzlHrxaQzaeUL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781350334; c=relaxed/simple;
	bh=HW3pTJwO4RJ6zuUfrZ7jfvSLwOxOYXsdIGhg6Slp8EQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rg/UiB15jCJiMj/zXAhva9555E+C8n40a6Ysecj0KdpbBZPEcaPRzFPFu9rKC8Jz4YyRLJn2pxVZMzo6axH9H6hi5LAoff4ddr+BQ04h762l/O9EeAFB3Uh67rv/s6aBub6D9ay+YaHMRy0ymNxQVpJTyK5dSzVOKrSDgHmFaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=nwRS11+N; arc=none smtp.client-ip=205.220.166.238
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DBFGdN205026;
	Sat, 13 Jun 2026 04:31:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=3w27mQHgC
	Yp3ZLBrBbJrDMh8cjmCK8zeyg+YIAs8c6o=; b=nwRS11+NJUElxzC1FkIG8iL6I
	UM1ybUqf3WggaBJOUbLqnKtw2NWgfhJqEHaVv4R0yL5xxihjOx4Valx9EtUHvC0h
	8QuO6W9SR3cwNnSqlpNPxJhecYzhSvWYuaUGpwUa3Du3l0QTcQSjotzFGCKcKYjE
	fdqmj7mxY9YQ9EXNiYyiQwTLtsWtiityX6/EOOmeo3OqWKsXQZ4GWXzhG47lGe6B
	8CYR+4YO+ZUUuOmV5DbIl/zGndLdM3hHvw2aDBeBxyFAChLQ43+5ChVezi/Kcd1m
	VtoG7ZwHOTY55DptFKDDeBZJwfNXkYhdT1x1Qmvo21IC0irU+q0ffQypxIL5g==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4es2g086tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 13 Jun 2026 04:31:58 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Sat, 13 Jun 2026 04:31:57 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Sat, 13 Jun 2026 04:31:55 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <qingfang.deng@linux.dev>,
        <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>
Subject: [PATCH v3] flow_dissector: fix uninit-value in __skb_flow_dissect() for ETH_ADDRS
Date: Sat, 13 Jun 2026 19:31:54 +0800
Message-ID: <20260613113154.2550286-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ZJ/nX37b c=1 sm=1 tr=0 ts=6a2d3fae cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=vesAdP9fBmeZQYaB-p4A:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDExNyBTYWx0ZWRfX9PBCzOaskSi+
 M0P9iLvfqqegJrnFhJeks1hbEbQJme+Eq9gd8lic4vYQ9zEOh6431JARcICTYSktQlMf48wA0Rb
 6NUv9OXj7UVyI8zG57hrJxNz5+nXYuQwSG7B5iRtYFxAat1FU21wnGo/BysTKT+Jig/CwykxTyO
 pxGybPoAIBJdmeddpx3XadHchv/F7FGsuHhGzCUJfGga+MBvvkkCmnytMp3IslCMGfipi9nGPqb
 TXeH+KXKFbLcAllnsv+Y3qgvL8VHhwFX3PKyepxFh0vqTkl1OidcXNhpyhGBmcZDSHSW/o3xbwe
 YWYQ+pH+GIx1XAymnsBh+6HSoisyN5V+PvPsUty7iXztPLWhQTNgQ4xg9EAaQbcbYRyPFuzb/NL
 P7XSZphjiZ/drkvlZWMyhJPqWW7wMOELYwbU4+UrkHbFyNVw1hHh3yt0DFgwHFZVaGMQfxGlEm1
 Fg9mbCbIj1RNPjmgirQ==
X-Proofpoint-ORIG-GUID: 4UJkfH-yxgydNpS-SICBBco7G2Wq5XoR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDExNyBTYWx0ZWRfX+HNQspgucfDP
 OAJXug7CNln6VgYMsrFDurosaijY0IpO4kCPstpwlgN0eIB7U2vYryjyVBOPYrFcWseZUZ2Zb5q
 7J8670Pxz0gAy5qMvogfKMxwI2y8e5Pa//zB2aNYKRhzEvtvsa2z
X-Proofpoint-GUID: 4UJkfH-yxgydNpS-SICBBco7G2Wq5XoR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606130117
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298960-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:qingfang.deng@linux.dev,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yun.zhou@windriver.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:email,windriver.com:mid,windriver.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,appspotmail.com:email];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8988367E7A1

__skb_flow_dissect() unconditionally reads 12 bytes from eth_hdr(skb)
when FLOW_DISSECTOR_KEY_ETH_ADDRS is requested. This assumes the skb
has a valid Ethernet header at mac_header, which is not always the case.

The problem can be triggered by:
 1. Creating a TUN device in L3 mode (IFF_TUN, hard_header_len=0)
 2. Attaching a multiq qdisc with a flower filter matching on eth_src
 3. Sending a packet through AF_PACKET

Since TUN in L3 mode has no link-layer header, mac_header points to
the L3 data area. The flow dissector reads 12 bytes of uninitialized
skb memory, which then propagates through fl_set_masked_key() and is
used as a rhashtable lookup key in __fl_lookup(), as reported by KMSAN.

Rejecting the filter in the control path (at tc filter add time) is
not feasible because TC filter blocks can be shared between arbitrary
devices -- a filter installed on an Ethernet device may later classify
packets on a headerless device through a shared block. The device
association is not fixed at filter creation time.

Fix this in the data path by checking skb->dev->hard_header_len before
reading. If the device does not have a link-layer header large enough
to contain the Ethernet addresses, zero the key so the filter will not
match.

Reported-by: syzbot+fa2f5b1fb06147be5e16@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa2f5b1fb06147be5e16
Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet addresses")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
v3: Replace skb_tail_pointer() - skb_mac_header() length check with
    skb->dev->hard_header_len check.

v2: Adjust commit message and comment.

 net/core/flow_dissector.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 2a98f5fa74eb..0b235ec0743f 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1173,13 +1173,20 @@ bool __skb_flow_dissect(const struct net *net,
 
 	if (dissector_uses_key(flow_dissector,
 			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
-		struct ethhdr *eth = eth_hdr(skb);
 		struct flow_dissector_key_eth_addrs *key_eth_addrs;
 
 		key_eth_addrs = skb_flow_dissector_target(flow_dissector,
 							  FLOW_DISSECTOR_KEY_ETH_ADDRS,
 							  target_container);
-		memcpy(key_eth_addrs, eth, sizeof(*key_eth_addrs));
+		/* TC filter blocks can be shared across devices with
+		 * different header lengths, so we cannot validate this
+		 * when the filter is installed -- check at dissect time.
+		 */
+		if (skb->dev &&
+		    skb->dev->hard_header_len >= sizeof(*key_eth_addrs))
+			memcpy(key_eth_addrs, eth_hdr(skb), sizeof(*key_eth_addrs));
+		else
+			memset(key_eth_addrs, 0, sizeof(*key_eth_addrs));
 	}
 
 	if (dissector_uses_key(flow_dissector,
-- 
2.43.0


