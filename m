Return-Path: <netdev+bounces-268828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ISbN2rpuWkRPgIAu9opvQ
	(envelope-from <netdev+bounces-268828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:53:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4648B2B47B0
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6DA831299B9
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55163A783D;
	Tue, 17 Mar 2026 23:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM0d+XUu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C263A7F62
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 23:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773791556; cv=none; b=LIcx8+MQVI5/h8zqJSYQjFMYJB7ccCN5n3livUqXYIHHs6eu5wmucv4/QrRCvct2APV8wFDL2dndRk5wudI7xZjQwo28uDVbucawjxAAS1hgnFsyV7Yut+NZoc0mShuSB7WK/sw1qrXMCVNHkP/2r7RJrRZV1iPmovi6FjOQ8oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773791556; c=relaxed/simple;
	bh=zT2RqGd3nP3UCMWCKPndkuHNOyLMnz4Yhzwh6iq/cJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLp0X1VaG68Qd/Bh+Lg9FYLbO3hZorSW7OcHuIObsvl1yoYghI9rtolwcgZNpclXRZiWJhak96bUBhM/sKNOzZ9dY44mswXvpGDiT+XZdhzlxYozJzfdNrGFWcjD4vwVnOB2JNU+ZADzAZSWhapJQiMGUEK9FUKXi08EQOkIp0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VM0d+XUu; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79907132d9fso5205827b3.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 16:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773791554; x=1774396354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=VM0d+XUuUFztImt6zTwy8LFBdBK+3oIAY7oW4y+A6T/kYTHIkt4IW65RfMMBalUyNH
         cw34hbdbH1NebJ05GvZrxSBfGNqSpYpgFVfAVU7WjuTF9KecWDqAwIIhwSrjESR5hW8G
         8bBkHtP2JMh2kbkZ2qb/qSzCoP3R/ugzHk6E+AK0GTLlEqq7gVB6UqJHi3LryuWtJ39v
         RjrgheY206wkOdf7DY5JaHEKXP5jcOcoAjd3zDvZFbA1DgP3JwWUOQLZza1s04mwsZKj
         G3Tx67xeO1kOSA74sIOODtKHYc4cLN0kT+WZbJi0VtngKwsswysXJo/guMSobta8KBbp
         bhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773791554; x=1774396354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=Evu7bibd8+Kd5Bso06FKfF4JmWgjgJM1URetY6Mn78Y1/Yj+iFLLz2F66fAv10sNLC
         OKlGholPrJwDFYRsxcomnpowmO9bn8ISAhQG91Q4XnmXlhb7XBobkE7sCHq+xIcOO+m2
         Qgw2x9Kslx4z5A0gYvmHjyOCANzeoXnYHP4ViRsGXXpFXmobcq54Ae4op3U2rLbAlhCi
         kSNIKb29KSdpUPHF30yIQcXB7XJdKiwOais5YDu+EvKpQOTd0t1HNwmilJzEji0/OiWO
         ofIwYtcTEJ7nILD4oqPGc/QKeWEReAhH//XpWfMihLfctUIcEhkJASQoZKGDbbKq4c3X
         NENg==
X-Gm-Message-State: AOJu0Yy8BDSgaciURiiEoYXdz9mMFzaWbTG+NE/bhI72/IpGMY1wRF6l
	n89eShi0frCOdqSScwp5uydl22qiV/nbiTObZfk3mgb6sgxplcV9YEp/zTBiau/l
X-Gm-Gg: ATEYQzzJnWlLFepf2Gys13VFHOXD7VINod7DF0riyfrMzOWkCS/tUbtFTbc5+ouoQDV
	mGMcF4zlBaNIP91RIgx7PcrnVoMSci1LrWvKPgZZlUEP1IDT3q/AIQsugfETpI8a3IYQeUk6g06
	0+CVNdMypAdrig+oL6/eYDvhHCDY2zifs3X60buUOYAZghd3Kn3J4jQAoxi/gImQDfEL1AsgVm2
	fLsOjBft/O249AcuKlJuL++7Ld3clUhWLvKZReEhor1K3PCod7Y+uGHSsdwndShdL1wE79WKF0L
	BpYTmBzFBilJlZomnrgjEryy6vPmb1vv6QSGbfsYR8DjexF5OWNWq9p53y0HrQ0QC5KKnP6hCoL
	+WoFM9+Q2L6MV4kdGGEsDmM9YfxJI1h9lGG4HyckHlcN6G7jeFghAJE4687KN9uL9rxDl8ASHiP
	A1syrXydGW0u/jQlzuyWdFv5B1irkJbrs=
X-Received: by 2002:a05:690c:b87:b0:79a:39db:9c78 with SMTP id 00721157ae682-79a7162fd08mr11230487b3.0.1773791554346;
        Tue, 17 Mar 2026 16:52:34 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a71593c08sm6750677b3.24.2026.03.17.16.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:52:34 -0700 (PDT)
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
Subject: [PATCH v6 net-next 4/5] selftests/net: Add bpf skb forwarding program
Date: Tue, 17 Mar 2026 16:52:17 -0700
Message-ID: <20260317235222.700615-5-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317235222.700615-1-weibunny.kernel@gmail.com>
References: <20260317235222.700615-1-weibunny.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268828-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4648B2B47B0
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


