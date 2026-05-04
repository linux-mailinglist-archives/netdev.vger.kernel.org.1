Return-Path: <netdev+bounces-284081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OZ8J0Il+Wmz5wIAu9opvQ
	(envelope-from <netdev+bounces-284081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:01:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D464C4ADC
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A2163017BF4
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E7038F252;
	Mon,  4 May 2026 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYJhhLKP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C62638D6A4
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935679; cv=none; b=sH/6gvzVZGhlNjmSQCfrQirHz0cai7DqVcPZ1r1p+ZWj/9VlCy9vOddSX0l5wf1L9+oUoMRgMlhaQEf7rT0Kqt1Kzvx/kEtGqf9r+vH4jUH5+7QDMtT9BDk/rm2Y1+1lAQ0OFkAl2P4rtvYaRJZE5VMcN9mpjVTUYYSXOUlr7b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935679; c=relaxed/simple;
	bh=zT2RqGd3nP3UCMWCKPndkuHNOyLMnz4Yhzwh6iq/cJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8xwirOnuJBbJkNpwhQ0zH9143rsQlUwE5xy1s7yVu9c4Eeap+JhC6xRjGQxfmMmzuqSn2RpZnd7if+TvX9bNMkFXvOYvPX2qqnl+j42FV6f+t8zXM9TSDnBwwM8m08Xj6dQLjvBSXroQn5UOIjBtHEhD9uecK9+jAou2ADcKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYJhhLKP; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bd5c5b8de6so4494707b3.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777935677; x=1778540477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=RYJhhLKPNXy7o7iK85h2CrYZpKeOZGrE7nHhGrW7aESiqmhXb2vZrtvRg+IssePJ8U
         6t6hWfOttXni+JLqY3nqmRYb6PXO9RUbAAd/BXmEZ9UTR64kSvVenirIOGb4LdjmMfDS
         /GXPRxu6DTl75KzbBlD494MskVtc7HDNXVA0n/p958VloAJ/NjDjEGx6lVlBHJ7vxoUp
         Ejkwb0pX+5taC1Y3EP8/MCBoDeGMJYWjnHmpvx+dI5iwykS65v/TnilQAdetvln0qypF
         UVyABsPTLe/L7ZnXAEW1pIJMt4UEoe42aSCRR1on+rZcDg6JIG4Cads/oTMPnJwOyrgx
         X1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777935677; x=1778540477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=qRNI5Y4tnX6KFNbYwBgQVabbPYja/JT8+rYCrR0JBKgn7gR+gZolFalfmznxxXVrQb
         mUedFb78/iQuuhE7W8MnBGkxq1DB+Feo0VC19vdqHGZEpGB/LrVCNYNzc5+FddCjy228
         u0Pd3JbOgqlvg8AFzYN9Gj6gfXaJwg2OcnXAsvQ4hZhw3Yst3+uKKiytrBLyVvvHPDp9
         5DcBGWJe1YhSeTAXWfzTGSzHN1tOWlHwAVGeqhN+C2iqz+bdBv05zK4Mc4aNtUrSpHr0
         NkrX7qhuNJfzxSLfj0nqw7eGM1T4IOi78Aew72NOcLHppy1uKGKqs5+zLq+k9kEF1LOw
         M01g==
X-Gm-Message-State: AOJu0YxomuFDYcBAu4+NGDlZ9Px+iCRKYg/Ljt6ESVgEZ6JGwCEnfN9G
	9U0q2C8f/05/l/MVJqTNQwM41Gzn9ihM+DoRsOP9FDZFKpBgKpCFRhZS25KdYw==
X-Gm-Gg: AeBDieusxXGouyYB1ugLKB1x/LyJKNvwf3aHsAVz+9OOH4kEIBLXB0xwCwfqG8ZGoKb
	4TXnuswrFzHoqPKygF6RIVrsSx5MSwnimzQDHExCsiT9dGOKKVmvSJyPczy/DNOeUDk97uWmxFb
	k/TkONNkMFVf0QoRMqgUvLH6KG1p3m8k3UhBWEwq9zplgOwfyrGVtwn7yIx5uQdoiYgpcYbvrUt
	2ByF6G7bCFn/z42OAkLugYNHjU+a3KtCaHHde2BL9KiGsUiADchk4qZGnXB4IvgkSEl69GQpO8D
	dD5PJ6A2wdEOYEG9i3lkgDLAlP9Lg6t4BNxChXgpvxroRTfqz+2Y3YfSQm9RwWT6/PxIFRb47nr
	bepMT9IIuoOdaf+jJgdMmyZ5vZcqqhyRcA/Np8j1u02xKmn4AbFuDx98q77NmUelP8jl+Y7M+5L
	kkkIzleCvFHV3rvsLWl/eQ8P+ZIQf7lr5jEVKxTdfl5DiT
X-Received: by 2002:a05:690c:4b90:b0:7ba:d931:151b with SMTP id 00721157ae682-7bd7707bc82mr78492647b3.4.1777935677226;
        Mon, 04 May 2026 16:01:17 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6685d37fsm56133397b3.36.2026.05.04.16.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:01:16 -0700 (PDT)
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
Subject: [PATCH v13 net-next 4/5] selftests/net: Add bpf skb forwarding program
Date: Mon,  4 May 2026 16:00:54 -0700
Message-ID: <20260504230056.917415-5-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260504230056.917415-1-weibunny.kernel@gmail.com>
References: <20260504230056.917415-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 13D464C4ADC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-284081-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fb.com:email,meta.com:email]

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


