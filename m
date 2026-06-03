Return-Path: <netdev+bounces-294534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BaDJAceaH2rUngAAu9opvQ
	(envelope-from <netdev+bounces-294534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 05:08:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EE5633C5B
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 05:08:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=W7uphe9o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294534-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294534-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A4FD302F1A9
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 03:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3340E3DD532;
	Wed,  3 Jun 2026 03:08:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E1D3074A1;
	Wed,  3 Jun 2026 03:08:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456127; cv=none; b=RK8ifsYMTW/6n3FRhU5M7jc2nUJ6eXGqJOsFqGWTlY4G0xj95h98/zdKnc2le2epgmvidxKCS4nwWLdRzk6+CNKBZtX9zCu855HLrV2g8lm3FKK/4wQLiiVMACKTIlqQXqAmFj1iIUDLdk5DuNKKWzc8uc/8ilFyGJoqkm+yMfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456127; c=relaxed/simple;
	bh=SzGvNxxVvNqRsAunnOeuy2llFZGGgrparxpBYy4hIbY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V14I3kCBRJ2cvymbaAXq4EdKACkms1g3Fc6RXjO1qmbzjWZlFKuwt8vvos+5S/un/S+eMewjakANqLmT5XycXIAR7TJhxQc73F30hWlgRcbkhk78lSax+ffs5NvkCUbWT8QKDhdBqn3q+Yep70cFgy40JhOAgJpd0nreHUnoqEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=W7uphe9o; arc=none smtp.client-ip=205.220.166.238
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6531KIiW2960801;
	Tue, 2 Jun 2026 20:08:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=+bLnFaOfB
	7tT4zKBm088mm1PssN84ne2gIUEnFngM10=; b=W7uphe9oqZ0y/mCPpoOIFI/cc
	uSqBfsa+CVQoAVp3LN8QqJ3iEEvjOdUc4hbiY/xuxZuedNRWaHqYUsrF4pivc9DA
	OapVG+vAihVVbWjiyg8LCZVnLWOHaK+sq0W59QjydwQlnt8SNZhhUB/4zKy9/wuT
	kdXtXUQyDpSLaiP2IZGL6CIOhPqwfLjDtGevQRTfKURGTeAwx9y9HL3ParWhTfaq
	hryUI7v4C5hXJKBgzJ3itDQoOjLQccWSmofwotKY4cgz/zJ5J1loG4eopVM5PAHS
	d+qrMI014nspTw7/BbkMkTMYbmurOT6sXh9GkFo7tGbnHjuWkHMvRusbzS7ag==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4efu61wtnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 02 Jun 2026 20:08:14 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 2 Jun 2026 20:08:13 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 2 Jun 2026 20:08:11 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>
Subject: [PATCH] flow_dissector: fix uninit-value in __skb_flow_dissect() for ETH_ADDRS
Date: Wed, 3 Jun 2026 11:08:10 +0800
Message-ID: <20260603030810.3593625-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1ouoIwlypr5Hk4Bk4rp11JibNHgpGr0Y
X-Authority-Analysis: v=2.4 cv=PLg/P/qC c=1 sm=1 tr=0 ts=6a1f9a9e cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=ZFV9FTQqrnKTM9pgA68A:9 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 1ouoIwlypr5Hk4Bk4rp11JibNHgpGr0Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDAyNiBTYWx0ZWRfX+LsCh2kx6ciO
 03QdLY/QZOR6ZolXRN+TtU1GFjrGNPZwP4Ezeer8PUWLZZwq2QyXSs0V5oPHZ5s6mErCbt40gQf
 +JEp/6pjx0oOO2QYa+pPQmz1qFragvt0d3oy3nC4reZR5feq4/NjnCylujyvyIVoyhkd4+uDXtK
 wUdE5QWzWVXZlU2KOvC+ncA96o+/5pT1Rz4LMlnNPDNYvaNrNEqkdi+3vq7M4hfoZPtrfxFyg97
 T6Okmu6jwUzx4gVwT1rFHpybDJVLuoVu2GvU/pKwH9ntTiscSPa1qRG4sOY5UhXMake6FRSNe3F
 87WEFC7AewTGRhIcdFQpR6z8/YcxVLNgtISWFKMC5rxzdGhrJNJw7LTVEg1BZTK8aaqPmcbtQsr
 rtlJxvHLOdPKKjjUxLXI2ywkCjwSe7lMTSWWkigD1BQW/hyMQBXfnZiePArElFrC2tlYUWCwgx+
 R0sB3BXz2AY8Es8mN2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030026
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294534-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yun.zhou@windriver.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54EE5633C5B

When dissecting FLOW_DISSECTOR_KEY_ETH_ADDRS, the code unconditionally
copies sizeof(flow_dissector_key_eth_addrs) (12 bytes) from eth_hdr(skb).
However, if the packet is too short (e.g., a 1-byte packet sent via
AF_PACKET on a TUN device), eth_hdr(skb) points to uninitialized skb
memory beyond the actual packet data.

This causes KMSAN to report uninit-value in __fl_lookup() when the
uninitialized eth addresses are used as rhashtable lookup key in
cls_flower.

Fix by checking that sufficient data exists from mac_header to skb tail
before copying. If not enough data, zero the key to ensure deterministic
behavior (no false matches).

Reported-by: syzbot+fa2f5b1fb06147be5e16@syzkaller.appspotmail.com
Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet addresses")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 net/core/flow_dissector.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 2a98f5fa74eb..d5817b800079 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1173,13 +1173,19 @@ bool __skb_flow_dissect(const struct net *net,
 
 	if (dissector_uses_key(flow_dissector,
 			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
-		struct ethhdr *eth = eth_hdr(skb);
 		struct flow_dissector_key_eth_addrs *key_eth_addrs;
 
 		key_eth_addrs = skb_flow_dissector_target(flow_dissector,
 							  FLOW_DISSECTOR_KEY_ETH_ADDRS,
 							  target_container);
-		memcpy(key_eth_addrs, eth, sizeof(*key_eth_addrs));
+		/* Ensure the skb has enough data at mac_header to cover
+		 * both src and dst Ethernet addresses.
+		 */
+		if (skb_mac_header_was_set(skb) &&
+		    skb_tail_pointer(skb) - skb_mac_header(skb) >= sizeof(*key_eth_addrs))
+			memcpy(key_eth_addrs, eth_hdr(skb), sizeof(*key_eth_addrs));
+		else
+			memset(key_eth_addrs, 0, sizeof(*key_eth_addrs));
 	}
 
 	if (dissector_uses_key(flow_dissector,
-- 
2.43.0


