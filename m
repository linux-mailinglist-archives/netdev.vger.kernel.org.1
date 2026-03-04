Return-Path: <netdev+bounces-263496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLYXIEh6p2kshwAAu9opvQ
	(envelope-from <netdev+bounces-263496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:18:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4251F8CF4
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9781330398B2
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 00:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73315291864;
	Wed,  4 Mar 2026 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="KHOypqXU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED36C288C2C
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 00:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583338; cv=none; b=tZjzkkxQBuYUm6HoujP1XW0QixbCMDukNzTxO7wZCr8C0FV7Lcm6t2d1p2zbMxncG9Y90TL/rm4NQ15Nj8NrbD98M/fXDybWfQFnIcVHo5B8mWS6DEW7IBuuPq/K8FcB2C8tlKonEYiMVA1zafOZHDOM4wKyAXStwL2VcIrXEkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583338; c=relaxed/simple;
	bh=oI/vGu36wfkM1nmzE96a7ohou5yqGigIgG8quRlCS5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jje29TQg0oHj5oCAD4W8reTyTE8hPl2jNabESAe6I7nM87EN0eNn1he5daba5q32zbPbH7QqLylu0zoLZFF0MXJU3CSpbIH1/vNtCJFOvR752uCJKA9/4Q+ai55BkOne+RnfjPrSpgPdavynpJTSN00QWfNH+FiObBoBiB4zn3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=KHOypqXU; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623K69E72733908
	for <netdev@vger.kernel.org>; Tue, 3 Mar 2026 16:15:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=h53iYLfeYq7JFFSt0lCT1fiqn0WJe2A9Pnv+RsinQ3c=; b=KHOypqXUIYSL
	I/HsCohSd1pRHMFj3gRR2Oqhvw5HmyGUUkH2Ce8P/r1uy5VLoJ1mlj8tKB5SFsQQ
	4zFAHSTp5f4J1FP1v1pO10jRXUfkScqWvGhoiAyEFp1k1+85uSPzyWW2tw+WOfof
	bGtPspjdubcBK1LkdiSvqaVxxseRwVG6kJrtbVtsa9dnLq/NWUmBfkK6SIuHoqX1
	Mh+r0u2Kod51yrBQOKQvx12r0HCoXhCOYDbw6sgm5DdwE9izC7/pjRrpmUtIzJCu
	PEJTCMOmItRKbKHN+MqS5FiBVJrLPWpGAdtJjHVltgYBeORcbc4k8xvpUfdsgywR
	4sJqXrde6A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cnmun6djq-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 16:15:36 -0800 (PST)
Received: from twshared108583.15.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 4 Mar 2026 00:15:01 +0000
Received: by devbig1867.frc2.facebook.com (Postfix, from userid 708122)
	id 544DB7599537; Tue,  3 Mar 2026 16:14:50 -0800 (PST)
From: Wei Wang <weibunny@fb.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Daniel Zahka
	<daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
CC: Wei Wang <weibunny@fb.com>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH v2 net-next 8/9] selftests/net: Add bpf skb forwarding program
Date: Tue, 3 Mar 2026 16:00:48 -0800
Message-ID: <20260304000050.3366381-9-weibunny@fb.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304000050.3366381-1-weibunny@fb.com>
References: <20260304000050.3366381-1-weibunny@fb.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAwMCBTYWx0ZWRfXyFiHjvu3LBmc
 vkMl0gOUaIoaIZ4COOfTUCDSukEc0toFyWl1MiIa3rWHUS5ORZUHREe9uxXQA1jUGikfVfqSr+1
 Zb4sy14BzGrZi8fmwphVigYNwO/s6c6UOp12DPx0EBBELXJMdL4w9ZGuFxkpgVJiWmdxyP9eXX3
 kdbNMED8KKDU4LC/i0lwQl73W5hD1HKesJecwxayLit48oxKTTaFBMCclXjc0YIkAT5MC4mTR/l
 moJHi1nTtlmgb1gQ9qFFCIcXnOj0X9jtHaScWRV3GewsXLmVvMH6YWBZG39IftfTw9N2EJzMU+e
 5i7SLKQOhjjDUX/u6cK9On7FStglkwlf1n+Ezt/5e26hX6WGJUWW6x+X7GqGCJ3BfRKq43Q4Pvl
 cO2YVUkpWptZrTvfAV5FKIzJI/cx01EuyMYWrbZHSYvkKrje3a5nYzDZW8oLBv0sO9cspjHkekC
 ioPcdIFxiJbvfSDO9dg==
X-Proofpoint-ORIG-GUID: CQNEw0aW5xHUX_dO8pcRJ5hAI5pWknSK
X-Proofpoint-GUID: CQNEw0aW5xHUX_dO8pcRJ5hAI5pWknSK
X-Authority-Analysis: v=2.4 cv=BrGQAIX5 c=1 sm=1 tr=0 ts=69a779a8 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=FOH2dFAWAAAA:8 a=VabnemYjAAAA:8
 a=lP32a40L5JUvlfaZ6LoA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Rspamd-Queue-Id: DE4251F8CF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fb.com,reject];
	R_DKIM_ALLOW(-0.20)[fb.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-263496-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunny@fb.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fb.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add nk_redirect.bpf.c, a BPF program that forwards skbs matching some IPv=
6
prefix received on eth0 ifindex to a specified dev ifindex.
bpf_redirect_neigh() is used to make sure neighbor lookup is performed
and proper MAC addr is being used.

Signed-off-by: Wei Wang <weibunny@fb.com>
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
Tested-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 .../drivers/net/hw/nk_redirect.bpf.c          | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_redirect.bp=
f.c

diff --git a/tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c b/t=
ools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c
new file mode 100644
index 000000000000..7ac9ffd50f15
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BPF program for redirecting traffic using bpf_redirect_neigh().
+ * Unlike bpf_redirect() which preserves L2 headers, bpf_redirect_neigh(=
)
+ * performs neighbor lookup and fills in the correct L2 addresses for th=
e
+ * target interface. This is necessary when redirecting across different
+ * device types (e.g., from netdevsim to netkit).
+ */
+#include <linux/bpf.h>
+#include <linux/pkt_cls.h>
+#include <linux/if_ether.h>
+#include <linux/ipv6.h>
+#include <linux/in6.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+
+#define TC_ACT_OK 0
+#define ETH_P_IPV6 0x86DD
+
+#define ctx_ptr(field)		((void *)(long)(field))
+
+#define v6_p64_equal(a, b)	(a.s6_addr32[0] =3D=3D b.s6_addr32[0] && \
+				 a.s6_addr32[1] =3D=3D b.s6_addr32[1])
+
+volatile __u32 redirect_ifindex;
+volatile __u8 ipv6_prefix[16];
+
+SEC("tc/ingress")
+int tc_redirect(struct __sk_buff *skb)
+{
+	void *data_end =3D ctx_ptr(skb->data_end);
+	void *data =3D ctx_ptr(skb->data);
+	struct in6_addr *match_prefix;
+	struct ipv6hdr *ip6h;
+	struct ethhdr *eth;
+
+	match_prefix =3D (struct in6_addr *)ipv6_prefix;
+
+	if (skb->protocol !=3D bpf_htons(ETH_P_IPV6))
+		return TC_ACT_OK;
+
+	eth =3D data;
+	if ((void *)(eth + 1) > data_end)
+		return TC_ACT_OK;
+
+	ip6h =3D data + sizeof(struct ethhdr);
+	if ((void *)(ip6h + 1) > data_end)
+		return TC_ACT_OK;
+
+	if (!v6_p64_equal(ip6h->daddr, (*match_prefix)))
+		return TC_ACT_OK;
+
+	/*
+	 * Use bpf_redirect_neigh() to perform neighbor lookup and fill in
+	 * correct L2 addresses for the target interface.
+	 */
+	return bpf_redirect_neigh(redirect_ifindex, NULL, 0, 0);
+}
+
+char __license[] SEC("license") =3D "GPL";
--=20
2.47.3


