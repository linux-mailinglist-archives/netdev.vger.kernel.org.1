Return-Path: <netdev+bounces-279530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOgOLh2542kiKQEAu9opvQ
	(envelope-from <netdev+bounces-279530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 19:02:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 368EC421B95
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 19:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDC2B3019921
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 17:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902F13019AA;
	Sat, 18 Apr 2026 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWfJcXiO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2E303C93
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776531695; cv=none; b=GbGtK+jc9DcRnwWKZtAA0tuFKOxxMOHYG1/sy6aWpcGltKyTtZ+YQyomf3OPL+bMtTCh9bKHdxXo/CvM8LdZbseJpqSCK4w7w8VZhHvpRD8sU2nEW/ENTeJSBckzqK8X750EkR/7Sns/t5BArYiWCwgEEkKTARQ4kgSFUFLXj10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776531695; c=relaxed/simple;
	bh=zT2RqGd3nP3UCMWCKPndkuHNOyLMnz4Yhzwh6iq/cJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smMEinRVL6v6//YgcLjsHZUJYZI8qeUt/OAPWfXOa8Hqa0aa2mEejen69qtql96OLuFlEYtfCinVHcvPwqem/PgGunOxlq2+fsSKrZHVefTda27Bma2T1b79crBgfr3nBlCVTxcg2ro1p7z0W8E1KRCHJV4BKdY+3GxCERUUins=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWfJcXiO; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65019c1dc32so211253d50.1
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 10:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776531693; x=1777136493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=fWfJcXiO7RBrCzX6+X6i2oubsCJHVJxW3p3SWWbXvzIX9teILhcJSbtJSBDDpyPinu
         eAR77Okpf+UEH10cr39C9ZZPgW3Wpi+PGVKwtLmYa0If55R7v8wrT4Ld30qJIXb2Rc4W
         +FmHi4kSQZfKRE3kFpgrDB+Ra4C/vuugRBvTG82IubpHfIZIVEkbFENqyi5eJiRiwFhQ
         YOImxC/+7VvwCwiIWYTCwnHa13BeSTwZm4OfjwxMR2Lq2McLSkPzJClAGhrRMghNgMvN
         K0eoDzPq7jebytpULaXRzq8oqAs7oFbZs3G1/7bAsBhI7WS00ciayq60Z2dMki7TnfGX
         scLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776531693; x=1777136493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=OKRDv7mkqq+Co9i+5Fb/DF3ox9mhVSIox0GLu9P3wPoUgr8g3JG0cxtmXKtgWGOL9l
         QCIRBL1tSUqoR4mRZo3bLk9ohg0/O8BYGnbZ4kVMkY1oe8UBDOBIZYbqsHPU45AUgpb/
         OOI0yvEUYEOj2foBUnk3zDQZAKpEa1ssXn0ZvgCF5m/WcD60LYoRqWhugTh3hFnJNYZu
         dcMiAzbXz7u/Bg5jYfsuCoql6XAq1mlSgRW6zzB/m+uvFM6oJHXLR6Qu7GXvNefe6iz9
         G1Ks4qm6L5AZf5JM8fvG42R9cVz4U++u6hYpXpFKriw7bfjV+9PqqMCk7LfmEj1acfDv
         jgGA==
X-Gm-Message-State: AOJu0YzR7r/nvVzWtBFZUFhy3qaQrDUc8BFebjVEiwAbZXP5NbOTRne0
	AjcqHxGDOT2sccSNM8aj8l1zP9Efu4KR+kRUJYmk+1l09Usg5RzHe9GuUr9Pnw==
X-Gm-Gg: AeBDiesZjKItmoJxVmg7xNSml+0WllFSWnABSQFJarpreM8OsGLRFM2gm6tTEsx7d5t
	Bjd6ztMJjiKv1ZfctLxwLVatA6eoIMyBV2B4GKV7WGtxM7r8LbthBYmdPR7UuviWElTu46++unf
	ZxwUX87Y/cOz3Zb+YY+w3K7iA81VRcGcFKBaWbb7Jphh111yqAT2WqFKxnE6pOv3BuUST/c7v0Y
	ND83O0RYh6BIphENJ0boRWv5ZdTHlO5eAS703sfhIbI9ZM5JGLAQ+7kRtJQnMUz6Q0ARQ0G55cg
	gg7yTLSqY6ZOXecqMgymDIMeRqSWYtjQPXFa4HngjiApxhksvUGeGJ7VM614LsXfNjB7DVFI1Q/
	C/Pt/xBSwG3WR5kUuiV3BaphHxjjVLXvjj2Qw+bMR4pnk7NYODjRO4Hp+oov9Jdgoh3NgpLRKqG
	m5hJgd/oqopIXQ8ne0Y1s7X1TOB3bMK63WJ2M/hmeKZopl
X-Received: by 2002:a05:690e:4199:b0:645:51b2:8057 with SMTP id 956f58d0204a3-65310bb39dbmr3645605d50.8.1776531693155;
        Sat, 18 Apr 2026 10:01:33 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:5::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314ea3ee2sm2456864d50.16.2026.04.18.10.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 10:01:32 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Wei Wang <weibunny@fb.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH v12 net-next 4/5] selftests/net: Add bpf skb forwarding program
Date: Sat, 18 Apr 2026 10:00:54 -0700
Message-ID: <20260418170056.3490525-5-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260418170056.3490525-1-weibunny.kernel@gmail.com>
References: <20260418170056.3490525-1-weibunny.kernel@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-279530-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.941];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fb.com:email,meta.com:email]
X-Rspamd-Queue-Id: 368EC421B95
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


