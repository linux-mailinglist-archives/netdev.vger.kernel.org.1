Return-Path: <netdev+bounces-307234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CedWFy8DVWqIiwAAu9opvQ
	(envelope-from <netdev+bounces-307234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 17:24:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A776B74CFEC
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 17:24:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=NWQBH8+5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307234-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307234-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 200AD305D349
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 15:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994CC344D86;
	Mon, 13 Jul 2026 15:14:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5112D97B5;
	Mon, 13 Jul 2026 15:14:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955690; cv=none; b=OfhuhqLOvGF+qC4HwHX51cTjd1Bbvol07xxJXxthuZfHryCvvD7/k0tgikMlbH2NDM+INDMd6NmG0/3tNfMq+qb7mQw7X9cUNOvHSM6THBX6yiKEnnBYgyeRl14V5fDqyYzRXd5ENoxogghMDH53/7sG9YMDHmpBz/Z8vI2u63s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955690; c=relaxed/simple;
	bh=Xz2yxyqdH3isDSsywy7HayL4CR/Uw5husGxta7pvLqA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gCxfHqB9npSdt+vcCa536gaH+e8i8l5AfHRngWPB9RMfYS+7Z4FgW6l7weS+ga3kvrg6uZLIrBS7gjQwk3F4n/BFqz3fx1ei8BfOxOdKqUGyzFfiCL4qWEl4ouAG/L3HJ+qcqO3J9lrEtxSXMHo7US4npjQkSAESCFM8vv6yTNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=NWQBH8+5; arc=none smtp.client-ip=205.220.178.238
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DF8CYe4116152;
	Mon, 13 Jul 2026 15:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=+l/u+TjhU
	GaRo6WDznrv9gb0x+VodEy/7M4WrJRKPnk=; b=NWQBH8+55q9iti4HaX2tHYfPu
	geQYGU39i9pOy8iFEVLhaLCsUx5MMr2UvbJ/WhuNG1cJoRXmeKw9TnBNa89RD+ME
	txX/QlByB09agLA5XY0/GPmehzu3uEHy45a8+gIu428zygggJ2H0UYWt+3eM13Cs
	ziSeKCiNxFZ3Mwetx52AuB95QatSN8nkv8sMDiOpkN81J9l+aXF1KrxU+eKvoiae
	TmToSvxQNifFWRRxitg1/Z15i7kjXwd3nOcal/XBXG5JIz98R3oyc88kmr81pG75
	MSATZOc/MWpj/zvZTMmgssSfw058FujS5ufNd5SZgr0P/fawJs7LreWC9MSvw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fbcpn2grd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 13 Jul 2026 15:14:40 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 13 Jul 2026 08:14:39 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 13 Jul 2026 08:14:36 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>
Subject: [PATCH net v2] net: erspan: set lltx to avoid sch_direct_xmit deadlock
Date: Mon, 13 Jul 2026 23:14:35 +0800
Message-ID: <20260713151435.1815104-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE1OCBTYWx0ZWRfX7WUFIda9b1Kv
 BzSgOIaA8+0xf0KrDIvhYF+2lAEeJ3+iVLX5f0rkbmvm/fEuV8RR1RhXLMa2Gmi6nk5usueDkCj
 4Gm5CSniElivbqmRd7xs6Posn2MnB21rZ4YD+d9aOLp/IcLSrPZf8lT/JWkhxgR8Z2uo2g8hASW
 a19xx8hx5o3ZLT7CNi/ccl/VXy8S38cBXSf/TyufEmmXKWCQPBdZyKZyXCL0MG1/meKA9QMVMQL
 Kl6fwsRQj4iHeGB6IOekcUHrCkcQ7T7ujBqXqsEvCIndvL9UWo27LHlxaXRd/Xv4R2pRJqxDIv/
 9MzYlDeN4hhbkPWR6QoR6trZcYn2CFBANmqK8fB0oIWOrkBf1SMEoc6Fm1XbTYYpM66oDOMoKmk
 GSrdU19TjJN5BJuTFPbzg+IDdhTZit8powwTfRxoaJfZ+OK6Ex7CiJrxbpbEq91slaHKCaZtRq6
 5wem/QlERHYp+RufnAw==
X-Proofpoint-GUID: cr2YXyKqllIrDF4XP139IZUjFXfchJSZ
X-Proofpoint-ORIG-GUID: cr2YXyKqllIrDF4XP139IZUjFXfchJSZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE1OCBTYWx0ZWRfXypsjMiKjadyq
 yR4yswJRJny2RMxWdlMsvxmpwkKTHMeT3f5AafQSxIop42dKnc5/6bK27Ce5/uFbUswJYlWtQU5
 bsWHtp0o961jMNsy4cDZ40jj3MJiMb7tBext4kLEiTTHNZ9nFYh6
X-Authority-Analysis: v=2.4 cv=JNsLdcKb c=1 sm=1 tr=0 ts=6a5500e0 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=JjHGVKUl6pe_7mdbYbAA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130158
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
	TAGGED_FROM(0.00)[bounces-307234-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,windriver.com:from_mime,windriver.com:mid,windriver.com:email,windriver.com:dkim,syzkaller.appspot.com:url];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A776B74CFEC

erspan_xmit() re-enters the network stack via ip_tunnel_xmit(), causing
nested acquisition of _xmit_lock on the underlay device while already
holding the ERSPAN device's _xmit_lock. Both are ARPHRD_ETHER and share
the same lockdep class, creating an ABBA deadlock:

  sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
  ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]

Set dev->lltx = true so HARD_TX_LOCK() skips the spinlock for ERSPAN.
This is safe as erspan_xmit() has no shared mutable state: o_seqno is
atomic, stats use atomic_long_inc, and dst_cache is per-CPU. GRETAP,
the sibling device with identical xmit structure, already sets lltx.

Closes: https://syzkaller.appspot.com/bug?extid=9bda1b9fbb7fbdf9b62b
Reported-by: syzbot+9bda1b9fbb7fbdf9b62b@syzkaller.appspotmail.com
Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
v2:
  - change subject prefix to [PATCH net]

 net/ipv4/ip_gre.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 3efdfb4ffa21..9fbff16cda1d 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1363,6 +1363,8 @@ static int erspan_tunnel_init(struct net_device *dev)
 	dev->features		|= GRE_FEATURES;
 	dev->hw_features	|= GRE_FEATURES;
 	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE;
+	/* Skip TX lock: xmit re-enters stack, risking ABBA with underlay */
+	dev->lltx = true;
 	netif_keep_dst(dev);
 
 	return ip_tunnel_init(dev);
-- 
2.43.0


