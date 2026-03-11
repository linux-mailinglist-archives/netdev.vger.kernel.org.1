Return-Path: <netdev+bounces-266804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJZMBBwCsmmHHwAAu9opvQ
	(envelope-from <netdev+bounces-266804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:00:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 803D426B810
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8632F3150185
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638573A1E72;
	Wed, 11 Mar 2026 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECzYzTyN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3E53A5456
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 23:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773273571; cv=none; b=O4c2aw/8a6PEo+5MAnjXviWurr0l64+cA0aliYmgc4vArLpcULYognowSo6nQgbLycy34jyQ47vt54gGUGDyib4nJJlQUWtkYyonRnOnxUuh01Kx5zR2Goh5Qh3HTlRqZn/RpeAas+xm4qnIRY/SYNCQJEQQkDp4TwAxLbtQWoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773273571; c=relaxed/simple;
	bh=zT2RqGd3nP3UCMWCKPndkuHNOyLMnz4Yhzwh6iq/cJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjNZNkRIGTWdVYgUvIU0DX3DZN3tRyF7uPowGVQgwh6wglQCQYx9q3keP1kvtpukYoAWEpqq7CUEg83HVYV/sg7WwMQvJyAQZE1wJkJDTD8UYgph1WVxwLY6X/jU4ahyiMYswFAKY8rQzi8yGxLIXiDYrkyuhUwpErDPbvlSKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECzYzTyN; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ae58222aaso1055d50.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 16:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773273569; x=1773878369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=ECzYzTyNAWUmCBJDtTPcNN9f6jGAUmdWBlfbdixKP0SdIX9g7QGzCCjv4lqrbvoAyh
         E1o6ULyh7LBj4aufUKsmXxpB1oKkvMLuZdn9Hf0r/53VvKje3OxgOJ6gbEn7JLX58SaB
         SJ0KVqVlekWkPaJwKblx65AoW/wLfM1fg8ukSR0Pkt564Utt0R54nDvkLJj4y9VdX/kV
         wz2SCylwktY65wn0+8CYoAsH4RKyz0ni3iFcS3/ks1UBQcPAOduMTAvTfU+mtgU83jFN
         3k6ZwoElBUWqYi2IxRAvZHHPg9Wp6JpgnV9CtvZEOpe7rPw+H4yLXmluxLeNgPtF95Zz
         Q6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773273569; x=1773878369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=Pv+2QOcz13ZaEls5sIRMgx0MXcsauDDJPWYggyqbCb17lUQoXHEBMZg5iVlI3xun1M
         eEuMm4mqxSsxa1yNCDDZSUKjDX8uB/VSyHKjAhGL13v+HvAjt+0x8lgMVSiKlNbWOQYK
         1H+IzgE94g1dxZ33AmI/bk1xUrelcWjV9u/QpMO807rmQn+wSWcf/lmyhPA3s3lvztAR
         r+o5v9Ft+m2dQLI35rVXm9XlyUH9mqROHBZrQjidpUlbNSjghe1gWhBTfMTTrDsoLQyE
         uLFeiy53xqkPUbfGfWoAuYmHCMLKH5hW1o229UQ+JEJ9TJfYYixYibWYcxPQ63RxUD66
         9z9Q==
X-Gm-Message-State: AOJu0YzwyF+EbFlZGFoYmYB7St60ZHpa7tymqiqPZPbT7yBGyeud5tjo
	vkxf0o4+PV2fdyhV6KYhKGjzy3tzYmOtlDVDgdjssZANTrDcTD81QSxNRQEHXdbT
X-Gm-Gg: ATEYQzzOyZrdNOD9rYOHsAWbCvFYCn0MsaOpBjxhm7zYAOM/4M0fm/yBPa89PZAiRel
	aGzWYmYZ58h6RwejkTYMSCj48xYpQxJj6T6IctgDu04lvU/HfN3qmsrAv6ru9k8lvput6N5TBMX
	MLWcUihdgn40PWX7Blfrl9xaIvZZGQoK09tcbnVT4/HDP8UPiGI7rFV2eJ+yuxC5ZTFk+1WDBzy
	5gxYPDFMghSyma8/J+2vJ+uxO3LRg18UPV9C8swy494KSRlQmV1FNF9JWVt0hDTYhVpvCOgDs8M
	X/k8uC4UxBt0DN72VdbaXzQfmyS5302FjUGM8UKHr6kJJnu47fmv3PHuHK83T9aA8Kf7YvXdxIt
	+ECgGvFIu7X6U3k0G8Mk57wi4zPzmmnXKX4k5WYHTQsmcOgJH85PFZYr5PcRLcrfpPTTW84AblC
	kBbsxWXIJ1zSw64WJwfWK/vZo=
X-Received: by 2002:a05:690c:f03:b0:798:59fd:fd60 with SMTP id 00721157ae682-79917e92df1mr39123557b3.1.1773273568866;
        Wed, 11 Mar 2026 16:59:28 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917de8c44sm21791927b3.9.2026.03.11.16.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 16:59:28 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Cc: Wei Wang <weibunny@fb.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH v4 net-next 4/5] selftests/net: Add bpf skb forwarding program
Date: Wed, 11 Mar 2026 16:59:02 -0700
Message-ID: <20260311235904.2392010-5-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260311235904.2392010-1-weibunny.kernel@gmail.com>
References: <20260311235904.2392010-1-weibunny.kernel@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-266804-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fb.com:email,meta.com:email]
X-Rspamd-Queue-Id: 803D426B810
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


