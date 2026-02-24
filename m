Return-Path: <netdev+bounces-260279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPHjLN/vnGkaMQQAu9opvQ
	(envelope-from <netdev+bounces-260279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:25:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BDC18035E
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38B6A30379C2
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0152A21FF23;
	Tue, 24 Feb 2026 00:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="F3hU8VhF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83EA213E89
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 00:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892695; cv=none; b=KPWvCn13WpVOVQvKt7iJNNunFq3DlwPQzszTQaXHiJFaKK1IZsQDvn5rbmXQCgQ6QBXjSKQzXpmLB5dZ1ozDScDl2MA/l9AkmsBzwQoLI0hZYtvpmX9hM+ZPvO7+VmGLIDWrRXnM8VJzncsxE19HkQRH0ML9dWd7sfFwP4fOyLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892695; c=relaxed/simple;
	bh=I6NT8QE6kTDlm6tEVjFDufQy+waw+NWjPm+X0+6012A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWw4mssavjprFrE9VKcmJzpyDMuKEO+THE+IZ2fU5ljYaK3NDA9dzOfqexPjNKLMaZlRtkoVgCgfMBgYfBp4mNKGLUOMRw06KY9Es9KOhDq8felPqX3Md9Uaw+U0I7JSjM9GTUAwhJGay8fIg5PgpKUorjcGp0m3eCoW01Uh3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=F3hU8VhF; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NJD5Gj3058462
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:24:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=h0UsdyvY59guDLP6XvmIZpWocDbWP0BzS+diMk1F+mw=; b=F3hU8VhFpAgK
	jJSxm+vBLbHQ/ucw52SPv+TNcdRi3hnrUf2D85CIo/FKGxOJ3mRqG7tl6vEDPmmz
	XMxfuhMm44KUpjBBCnrBE9oRtdmsKYS5oIzo8Q967zDFl6BU+93nU6pqGahx3suk
	vFZfIQ/oAZ+IrQQ3tm6SjUS2vFKlEh6FqH0rSQR560bDeDK0ItQwdGnHH9OAxmNK
	lanP6T3IqceOXvp69ES1JzQAauYFXIundHBo5mZ/UxP5Yj0OEY9ChNZvHoLFE7rd
	QhmW2GrdDbusl1ukTRiFhGSkIIwfiXCEquHXgmT2f5yoTG461/V+iNWHD458Pmpg
	MTFRQ0HlbQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cgvuyjxrx-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:24:53 -0800 (PST)
Received: from twshared18080.32.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 24 Feb 2026 00:24:47 +0000
Received: by devbig1867.frc2.facebook.com (Postfix, from userid 708122)
	id 0EC1B65F7EDE; Mon, 23 Feb 2026 16:24:38 -0800 (PST)
From: Wei Wang <weibunny@fb.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Daniel Zahka
	<daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
CC: Wei Wang <weibunny@fb.com>
Subject: [PATCH net-next 8/9] selftests/net: Add bpf skb forwarding program
Date: Mon, 23 Feb 2026 16:24:08 -0800
Message-ID: <20260224002410.1553838-9-weibunny@fb.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224002410.1553838-1-weibunny@fb.com>
References: <20260224002410.1553838-1-weibunny@fb.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAwMSBTYWx0ZWRfXwnuXYhYXPPPd
 QHaMMGQUT9HlUo/eTzEB5TGkdAbivtx+deh5fsXXXgpcaor31zg1tvKB4+fGUT5y56zmZdefyKa
 gP7xVjotq5rsCfST0brugAMNmJx5LD+VE6MEb29oE2ps8JuPiE0/iqXtj66zUYS1kZ2fHLq/wTA
 3sJzqp34YqM6wtpsi/l8zwirvCGzqI8UYne8HwPVZAC1DTshfhXRId0qBRnjYBFc0fDZ5liNNg+
 J+RHA2gqU8XzEHQG0zsTuzqF5IM2hT3M3na2O3Ov9UA//TgJMv8erP+VxadrZ3eA0xSQ5O7Ittz
 RpgC+TaDZVxNltGhzfWAD9tOWZmoD9AEfCGSx9LDyBa0SWtSGMSI//JXsFQSh7y2fSBet1KUkn/
 4BNEL5QAiGZKvX9kXUAkRELHHd/6075zFPNaQDCudu2Id585VTi3Q2rOMcPJocGetGAyo6wsXh0
 J1edgr5b/YoxPwtA9pg==
X-Proofpoint-GUID: Ni7WuydUpx1CEfxyY9fACDuWvJ0noleI
X-Proofpoint-ORIG-GUID: Ni7WuydUpx1CEfxyY9fACDuWvJ0noleI
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=699cefd5 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=FOH2dFAWAAAA:8 a=lP32a40L5JUvlfaZ6LoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fb.com,reject];
	R_DKIM_ALLOW(-0.20)[fb.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-260279-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[fb.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunny@fb.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 78BDC18035E
X-Rspamd-Action: no action

Add nk_redirect.bpf.c, a BPF program that forwards skbs matching some IPv=
6
prefix received on eth0 ifindex to a specified dev ifindex.
bpf_redirect_neigh() is used to make sure neighbor lookup is performed
and proper MAC addr is being used.

Signed-off-by: Wei Wang <weibunny@fb.com>
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


