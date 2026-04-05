Return-Path: <netdev+bounces-275444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKR8Hl/60WkeSAcAu9opvQ
	(envelope-from <netdev+bounces-275444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 07:59:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FF039D7AE
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 07:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFF963015A59
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 05:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA8236B047;
	Sun,  5 Apr 2026 05:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwHuDsgG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E4D36C5B4
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775368746; cv=none; b=pVMNzM3oua1k3uOzCcTTWudPvKGWdN5/A0EK0/bSbNWPt1T/KHifni55yi3ck7+rBGkZucKlPAVYcez/f2pdtW+FYVqwekN6dl71oYQogVgKB5rBj6J8V7qCJP5keUVEQMcNFF4DYLmNa46jcM7mHu6/frb1+y0QXYsdMBFLvUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775368746; c=relaxed/simple;
	bh=zT2RqGd3nP3UCMWCKPndkuHNOyLMnz4Yhzwh6iq/cJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxwAdryT4Wh58K1d8m4lUxcFGjuElvMUM6ZhCal0aZgqWAMaCf7rzS4v3i6PUdpjABtTToPQXcd+tU2yC9T5AhzDqoeVPLZ4BpLr5pfglqxf1Uc5wLyQTwWkjbl+FXcH0g1oPut1Mdq0cFtEGq1Wc+6VAL4iLHJHzL6Dxnb3cyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwHuDsgG; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6500ff16c0aso341931d50.3
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 22:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775368744; x=1775973544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=LwHuDsgGMkWjYslZJrKwnpXLJdEPSmX5q6SVqKRC8CPZ3l0h8+Z1qEQgcAcbJMnWDK
         roWIa7GPTq8WHtxE3u+LIyXMF/6M4c5ONtIl/vTZQK0/UGQKMXHiT+Zh1yZ23gtZVWJQ
         ZV+QJWtl7OSfRki9NK7Pp0rR/bMyH3hcUz6urgbus+cOABC/mg5ByJNrgpRjJ8RT5uVg
         p3PfqXvCQYrNEHNrnAlDixOs87zXqaWh70aZDEou7QMJTy0F+ur2CnbpME1XN6HrkglG
         oY/EwzSH4ICT+RaMyNGzJGBAVZ5NBgXay80mrWfAk2MLpJK24xL4HSmEwIOHr40BOUXv
         yL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775368744; x=1775973544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=YR7XK5vMEokW2zKIIfrhv8Bsu72DaGtGBXSGlQe+X0wdPvs1dVdwXm5Lb6SeO21tSO
         Bi/fKogJSg7JLBdPzmbIcuetd29Dn4C5YHqXmFtKGoCQidzdzgm/1rtlWfHK3KmLRimI
         KLKTg+usLXHGbglAF1K4SPHlDQvY8MJDjSbp1Y7+mO+XuLPbEJNyA2JvRCUPRxSs/Xrb
         ngs2tfaF87EngsQ1rpZiQzQLYJgAbiLcMCmT23te00mptHQbE6OkG79RMQen1e9SIeX1
         mF0Q7HtnPB4wIH6j/SVSjj/Ut0Z7WdtCLhMkQe3uBIn4tSwXSgqQcaKTFgwiH8yxZjX0
         DsHA==
X-Gm-Message-State: AOJu0YzA+p6XdMugpYhQSsgGimzZ5qpzVZ9TQ4KnfWGnc4SE5xTBG8XU
	MGM9XynzCsNdSGPQVn4NnbE6ZfYYKj8sU2EiiKvyv3ii4bBe5UXkr3WVuO+4a8oY
X-Gm-Gg: AeBDieuQxDIIK5sfYsJSNIshzhbe7iWK9wlNNhXnvNLDrgHBwbPlN26K1Z9RdP+Loik
	Ff8drSMze/Z6kamypu2gObWzuSRLOjHsYImL8jAei5yVIhlHXZVyzoTia5uYqA2ccTfACrt7aKZ
	IDDBXQh73qUL3FHCoYDjoIXwu9pxZ54trhrhPbMgUOlKMatcxtNrPs6Dr7GEbOtFQzFFyrQO8Nb
	G3QeJz1LTIqH5/Rv8KygtFAdsSS92m0hIsEdhcUENrKrHyIlz5Ze8wU/92h6qhCodLyCssywrnv
	YpzvoMg9eG7Ol4IqUVr4PWDwMzSbt6C6HM66b7otbcpo5954OTeR+lhgNnuuCn7I73+gRrYjhTo
	GZhtx17aHDFrY6IyeE4lSjVQyBlRMbFFGBfVUn1H57D50Qr4X4IfLxGWI5ZGTUm3CZDD0WDuGzj
	oKKjaCJAeIbs2o0I9DHNxBs3n/
X-Received: by 2002:a05:690e:d4e:b0:649:bf2a:71d with SMTP id 956f58d0204a3-650488da167mr4951954d50.4.1775368743634;
        Sat, 04 Apr 2026 22:59:03 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:50::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a9d8c2fsm4328943d50.20.2026.04.04.22.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 22:59:03 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH v10 net-next 4/5] selftests/net: Add bpf skb forwarding program
Date: Sat,  4 Apr 2026 22:58:51 -0700
Message-ID: <20260405055853.3285534-5-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260405055853.3285534-1-weibunny.kernel@gmail.com>
References: <20260405055853.3285534-1-weibunny.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275444-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fb.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: E4FF039D7AE
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


