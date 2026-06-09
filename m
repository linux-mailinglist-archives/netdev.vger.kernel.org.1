Return-Path: <netdev+bounces-296869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L2zdLbd8J2qYyAIAu9opvQ
	(envelope-from <netdev+bounces-296869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:38:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF4865BDE3
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:38:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=dfkRKkJr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296869-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296869-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EE10301908F
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 02:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D2E30EF92;
	Tue,  9 Jun 2026 02:38:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D8A23BCF7;
	Tue,  9 Jun 2026 02:38:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780972722; cv=none; b=Z6dMt7pmzAD7ar5Abth7jYzM0vVJDl274QkXhRu/Bh5gdKzX4rpYs4PRy8m/qW7TNQMSJ/fGIvY5lFGqAd3WT9w+74Na0ODTG+8xTJqiofGMj8eWkcx+fnoB1iVCPor55HSt61sODN8tu+PxISK72que21ECoA69jFh51RL8+9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780972722; c=relaxed/simple;
	bh=RRaAkDfBV2yN44plEJro8olWN2RFPeoqkxR4bSBA8yU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fjnbh9iEIxX2H7EiRED3eQcHsr/yJww+JX8al0s/kAu2mluoh9FRqyOhmfA2r90uCw852sclKJK5FkBXHfHSPLfsEEzeRSvF3syryZ/SkCGQmRK3/loPW7eE80d2mrvA5X2fUWpeSmKnXx+ebE3iOt21NXrOYOlySnXU/v3UfNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=dfkRKkJr; arc=none smtp.client-ip=205.220.166.238
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6591dAHR1445044;
	Mon, 8 Jun 2026 19:37:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=5mVFZtYxd
	hwP6hmEO6eS5K+9TPEiImUTKl3kk5d2D04=; b=dfkRKkJriq7TEo1p3t93U8CHl
	BXRteJ3FgcMBAWAvDMWuK6dynMhudGbSpOgp2gGz0FsGZpRQ71OzOnl3lZObQdEF
	TR+opVcqGe0TH/BlgAMvugMIHQF9pBw7EpMKYj0sdMkRG6ofeAxNnE+fj8GusLbA
	u4wkCYTtMcnGd4YZLImW7OIa/zYhSN0TB1bZNYo/oVH51MTWdlqwZDOvjCIPxw/W
	x8Yzjr0AgLK6d7+1pEQkUV4FVQzzPYFfA121qyF4UxncwHKKNIc+2XpaDm0wwWZC
	u/58MwdBknINfICppHI2vf5H75/YBPYDrSYpzFk/JHAIXt/463OdPTez1QZRA==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4emety3nvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 08 Jun 2026 19:37:56 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 8 Jun 2026 19:37:56 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 8 Jun 2026 19:37:53 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <qingfang.deng@linux.dev>, <jiri@resnulli.us>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yun.zhou@windriver.com>
Subject: [PATCH v2] flow_dissector: fix uninit-value in __skb_flow_dissect() for ETH_ADDRS
Date: Tue, 9 Jun 2026 10:37:52 +0800
Message-ID: <20260609023752.1245848-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: cW1h867CUOu9oJH1__l_pjWm8cWWbDEi
X-Authority-Analysis: v=2.4 cv=VKjtWdPX c=1 sm=1 tr=0 ts=6a277c84 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=vesAdP9fBmeZQYaB-p4A:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDAyMiBTYWx0ZWRfX0PrdjEdNw+83
 wKQ+TbIJZTuiM7+7YGL/N+ec60OBAEdjB/Wy+ekUa7F3ZcnP3P9CDlh5BLd8nZNpb+NFUCsEWLw
 R/eriu3xqM2zPVHxpvoIPgw5YEJpyH+IUD+kodln3rv9mmRHKtBCV8nkaicw0joIZ98UDQa6X3a
 Ao88Q0cc+z2YggYjm6rmVNjmwvCtwcBY9BIiBvsGO6w9hzJk/Mwxb5OJ+DoM8MixAl9OhNBkOII
 h/IW8+sjFPbJ6uiXGdtWQ+m7gq0s4Dgd5d1FsiJVhGMhe2sVx3RWlmjY/5FdHTfi/OgnkPkii1e
 NLcdrlQF550ik65eo8mck5hCL3XYJBg5LgCAvZYZzezV0Lm2D2bJzeEYGG4rk4wgk22NRsG1/yO
 GHGrJXlcX3YuwdLnI9wFhz4HmE4F9s/6nttcojk40W7V31JKF7zuNb4U9wVAEhzS0xpHdK6vcAl
 qygKuXLX6UIzqT53Vkg==
X-Proofpoint-GUID: cW1h867CUOu9oJH1__l_pjWm8cWWbDEi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_06,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090022
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296869-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,syzkaller.appspot.com:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,windriver.com:dkim,windriver.com:email,windriver.com:mid,windriver.com:from_mime];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AF4865BDE3

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
v2:
 - Adjust commit message and comment

 net/core/flow_dissector.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 2a98f5fa74eb..1e6a2c04698c 100644
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
+		if (skb_mac_header_was_set(skb) &&
+		    skb_tail_pointer(skb) - skb_mac_header(skb) >= sizeof(*key_eth_addrs))
+			memcpy(key_eth_addrs, eth_hdr(skb), sizeof(*key_eth_addrs));
+		else
+			memset(key_eth_addrs, 0, sizeof(*key_eth_addrs));
 	}
 
 	if (dissector_uses_key(flow_dissector,
-- 
2.43.0


