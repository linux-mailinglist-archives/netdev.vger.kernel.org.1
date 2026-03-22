Return-Path: <netdev+bounces-270294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJziCDFrv2lk4gMAu9opvQ
	(envelope-from <netdev+bounces-270294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 05:08:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CC92E82F4
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 05:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 230923012EBC
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 04:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F662C0F75;
	Sun, 22 Mar 2026 04:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5ANpWlV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1DD37FF61
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 04:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774152438; cv=none; b=czHDSS8iJ2+BRC5UeojUD3wgf+3JT8yejwCSE6hCFbaTfZUiflLcyBrCnI91NIXicWtauqx59rA1LqQzBmSJJTefWyYogn5SEErLGtWONfNwQ6kgt+MXYb08z0wJRZNeZUaOf/eYscdzpcwW2lLnRTYPh6cr8duWHs079dfmny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774152438; c=relaxed/simple;
	bh=zT2RqGd3nP3UCMWCKPndkuHNOyLMnz4Yhzwh6iq/cJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7vmSLhUgl6Sn6k4jcwGKOmDESJGN0ct36xhJjlY9I1Nsf8Bj5t8Rz2Amhc2hmZrrX/KBF0DoLseZ1NxKPUcu4QOdIiDPUjjLB2R/IOeigLRyJAQoyrBiyy+zONWbp4/WR/xHxYX/b66XW7qsQ8aHiOjw6ur1mprPrVoZhYVdjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5ANpWlV; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79652789a0cso2024637b3.3
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 21:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774152436; x=1774757236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=X5ANpWlV2dJolZHpmAzVYFxD54geH3ABCf8QwDhyweO/KFiBNhlQpyfqdTFQRUhJE/
         5Px7owYGRzAAEoZQyGPTECQXLTnv4N52+/ziVOoa49KDiLDmHpzKGJZIw1ECm5rbp+3m
         Ut652mpNl5NYcIwnD8CondscKrtOg7pu6zP5BZbAIQSBu227BM42RIO6P2jq2yrRQVSC
         v0pVZHKLbcHa9kSeVlxkZp4dxJnuIBGmsnr5bpPJgnJgzQRLT6EW/rd0PKYgL61fa4Oy
         Sout9+dj8xDttwSmlMB7KLujM4eLicPspjdhNWFMcHfCpLoJNR81IHfYUTprxNCLDR4t
         IHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774152436; x=1774757236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=SySjOBidcAt7FS53RRLLHVVndk5nq9gjrk8YThqLYUTtf6ChK7mNy2SqtibrKCfRT3
         l0KKqteChowD70MvhNE4OFVxXcVjzW8gtWkfgRGf890x1Ys6L/g2rAWHEk+N+keH8l3r
         ADqeWGrv176KGJLVwetx2p/2RiJSrpOJ1iw+8g8xJnvbwU4v3RBTymvpOfziqVUh8Hwd
         x4hz9j1mTNnyfb+F9ckgyP6pP0FHQ1aLQFapBzdp6FZKL2BQ5WOq8V0obMJ0tkllY23X
         z4VQ+TGoK5aTWz4f/LeYdg+wsPRy1izfGHtOaKpId6LxyQZW/rHzFUUZT2NdKvvJrktz
         qO1g==
X-Gm-Message-State: AOJu0Yw62hCYWdEpPu+naCnccP8ADPJMMEvWxYvBVY7jP8Ji0i9f3L3r
	//IiT6KFUWUCJ3aI70z8pAJ4zLi/uFWr7xUsIaXjhrJh+ce45f36nXIWGjhLpdw4
X-Gm-Gg: ATEYQzz44X8zWH/JIBW7cQ2onNOQcHeUKimgn5xU6v3fOC106Z61flgbxw0eCoB88y+
	9Me3YQebS39g7cmcgjTcBhUd176xmLPcw9HzOnJwpxoOLdpbwygPINwbN+S0trvNykT2LTNOUQv
	WYGRJAYixYV2O6idD3LkCUYrH91PHbBYJC0+MyrbGZhTgsfIiwFbRyxM4v/EwllwY3OvLEEDzLo
	1iHvA2YF3PwLRFbuIj++SJJyy7iIE3KdMfKrHlT9KoHrEy9RqahGtbIkTrfrklSLTozOeR2AAt1
	zG+gfjnM/Bbma72jjUcjUp6+efgmDohjDmoOQyQMybqvgwKIYNcQ/ZXLLQ5VvbA9bpzG1W7+zkJ
	UChgFFNeXZQHmBoU9q+CX052g6w/ua2TcBoyyXRY8ZEdvsTpc7y0CMD7LkHkbsckg74B1iscLg5
	XWshZrXUa/Y9/0rtGMyUdDeeU7
X-Received: by 2002:a05:690c:3385:b0:79a:5905:cec2 with SMTP id 00721157ae682-79a90aa32b0mr72700667b3.2.1774152436509;
        Sat, 21 Mar 2026 21:07:16 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:10::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a9054bee1sm38702067b3.32.2026.03.21.21.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 21:07:16 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Cc: Wei Wang <weibunny@fb.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH v7 net-next 4/5] selftests/net: Add bpf skb forwarding program
Date: Sat, 21 Mar 2026 21:06:50 -0700
Message-ID: <20260322040704.991766-5-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260322040704.991766-1-weibunny.kernel@gmail.com>
References: <20260322040704.991766-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270294-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: 98CC92E82F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wei Wang <weibunny@fb.com>

Add nk_redirect.bpf.c, a BPF program that forwards skbs matching some IPv6
prefix received on eth0 ifindex to a specified dev ifindex.
bpf_redirect_neigh() is used to make sure neighbor lookup is performed
and proper MAC addr is being used.

Signed-off-by: Wei Wang <weibunny@fb.com>
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
Tested-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 .../drivers/net/hw/nk_redirect.bpf.c          | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c

diff --git a/tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c b/tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c
new file mode 100644
index 000000000000..7ac9ffd50f15
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BPF program for redirecting traffic using bpf_redirect_neigh().
+ * Unlike bpf_redirect() which preserves L2 headers, bpf_redirect_neigh()
+ * performs neighbor lookup and fills in the correct L2 addresses for the
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
+#define v6_p64_equal(a, b)	(a.s6_addr32[0] == b.s6_addr32[0] && \
+				 a.s6_addr32[1] == b.s6_addr32[1])
+
+volatile __u32 redirect_ifindex;
+volatile __u8 ipv6_prefix[16];
+
+SEC("tc/ingress")
+int tc_redirect(struct __sk_buff *skb)
+{
+	void *data_end = ctx_ptr(skb->data_end);
+	void *data = ctx_ptr(skb->data);
+	struct in6_addr *match_prefix;
+	struct ipv6hdr *ip6h;
+	struct ethhdr *eth;
+
+	match_prefix = (struct in6_addr *)ipv6_prefix;
+
+	if (skb->protocol != bpf_htons(ETH_P_IPV6))
+		return TC_ACT_OK;
+
+	eth = data;
+	if ((void *)(eth + 1) > data_end)
+		return TC_ACT_OK;
+
+	ip6h = data + sizeof(struct ethhdr);
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
+char __license[] SEC("license") = "GPL";
-- 
2.52.0


