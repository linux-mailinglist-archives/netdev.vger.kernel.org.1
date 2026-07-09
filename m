Return-Path: <netdev+bounces-306078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HZ3bH+ZGT2qZdQIAu9opvQ
	(envelope-from <netdev+bounces-306078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:59:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C560872D6EC
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:59:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=UxxJ3WMp;
	dmarc=pass (policy=reject) header.from=windriver.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306078-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306078-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09772304DBBE
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 06:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D844E26738C;
	Thu,  9 Jul 2026 06:56:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B12C3C342A;
	Thu,  9 Jul 2026 06:56:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580205; cv=none; b=mObCzyduebhFLQYR9zIm9QwESPZ4fNQ5kmeM0TzbNQzjIppNb2zIl80I8PuOILWGmgIFE+9wXzIs2xF45la9m7KJnf5USx7s2YPNyounpOTI+6cculBbQVrLetCDwfPnMjdPYpgRgnxgloe9GC7YgDAFv9zwk54ytcIZzcniT/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580205; c=relaxed/simple;
	bh=2RDekpdaEq/v4I/n97+FDyHl1evjrkSxkSSv2j/55Pc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pl912nLcCgvyBXa+tYjmii7rg9dxEWEPbsKxxruBUJPun0nK6ZqKILDm2Z2BpB4fN7LjsSdbGjukcwL8aqdIRngUCs0k0igLcYXowxi4bCkfurvTboqjkVqoNfaUgMRr/z3iYS5RWYkodr5QzfIO+QnjwyhCK3lLcLImG1Z+Inc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=UxxJ3WMp; arc=none smtp.client-ip=205.220.178.238
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66963BxT1541309;
	Thu, 9 Jul 2026 06:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=+MiGPOb2U
	BFk56odLYV8MLd7ji5tz0gEcPqWOMn6IHw=; b=UxxJ3WMpN2E4IfsZEtECoxsDB
	mV110VffsRgnFb5ObZZItsPXdQ+/e9v/me3OiiMKp/QocofJm7QTfAI642Zvzem9
	cCF9mvAU512fRHcUZlFApWAolBB4DhtrDvCSGjdMOP4E9tRF00pVv/9GWi6an8tG
	7OWxHeN2wKPbb8U7G4dDquU4mRC010fBwfXcdsGYvLUsTJpmRnVRRsyJF0qF0tN8
	9r3WjkNJ64RaPl9Dq/MUvSNkZ32QheD6ONw2O0vIRFhZ7ldQGdYW5utl6Fj8r4Yb
	WA/g8EEcxSiVkoVTWPps5ZsMNzcx7BjHK+c9SGErSAlHa+9ZY7uX5rBoDe+4Q==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fa1h20cut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 09 Jul 2026 06:56:36 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 8 Jul 2026 23:56:35 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 8 Jul 2026 23:56:32 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>
Subject: [PATCH] net: erspan: set lltx to avoid sch_direct_xmit deadlock
Date: Thu, 9 Jul 2026 14:56:31 +0800
Message-ID: <20260709065631.3488067-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a4f4624 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=JjHGVKUl6pe_7mdbYbAA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2NCBTYWx0ZWRfX8qSWfsMauU86
 wFfDI3D7qOBr2z4d0hMvgcrkabQff6yoX6rb0FIllnWDR5WrP8Uu5zY29I/GChhuktiAs5pyUUA
 mhuyaAcSrEp2bpB6YV3Dsh2wg0Jk6LysJAmgOIYjCZ7n5fi/mBD3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2NCBTYWx0ZWRfX05YUNVW4NJ/q
 h0LAYzpuAee6lkX7aLpHNELu9bIgr1O7dIG6B1KdaYZuhGd+FUDRGvgJ/anHUp6LHkxZq75XXJB
 sr39BYEDW98iRZ7/7Jrh5IWxxy9pZMOZNPrsdhMXWFzGZVDZBVLAZS6WBITSPBUDtCX+AZEaxW3
 48tXPNC13s9e4RndXpkBODwQ3ptuJ4rj3v1EXZdIe/8tzsOSOiMsPf5ISZyev+n7HGUogczgMYP
 paw6PWhqH0F/3Twn8ldr0tFLhJ7gQoIpKPA3X/GGo5yjrY3ZlZNzBmwsYCwqExA8hRHtVc/wzvQ
 dMwH0mafFybd7iWejvjjbZFMEFjZ3OWvesIfPsBvpJn8hBfHTachG4B+8ywydKI7mkq2honVXSC
 ZpqUprMqDNu8/r123fThFSKPBvuCd/Dl93HcCb11UnSBkj2swbWGZCnBLgNXeW4a857NNgF0eyk
 dr6WlI4kBENDOFrkOnQ==
X-Proofpoint-ORIG-GUID: Acgkk_hbwuMpqP4XHhYda3R6pcR3T7MI
X-Proofpoint-GUID: Acgkk_hbwuMpqP4XHhYda3R6pcR3T7MI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090064
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
	TAGGED_FROM(0.00)[bounces-306078-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:from_mime,windriver.com:email,windriver.com:mid,windriver.com:dkim,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,appspotmail.com:email];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C560872D6EC

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


