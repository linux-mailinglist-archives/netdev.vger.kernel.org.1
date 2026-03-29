Return-Path: <netdev+bounces-272856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIHhHcmoyGmjoQUAu9opvQ
	(envelope-from <netdev+bounces-272856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 06:21:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E30553509F5
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 06:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCB38302C777
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 04:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA928246BBA;
	Sun, 29 Mar 2026 04:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNHcCNxq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCB419CCF7
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 04:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774757980; cv=none; b=mEdavvzCGFcbPfwBUqNGPETCgveTulUW2StHPLKuOjiHAjzqW7LYv0jZ+DtoE2BbTVUigxfOz5UkXFQrTWmiaG/BKpNWv+VgGIqWZrNMaCcxcJYcxHs3KsGG92aTNVT6m++W+mPUtO26pyFN5y1Zi0XC2DCqjIMe/fVyZB63uW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774757980; c=relaxed/simple;
	bh=zT2RqGd3nP3UCMWCKPndkuHNOyLMnz4Yhzwh6iq/cJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVsW9M1qI5KTq3Bx7qa1gZr/iyZjdD0PFO3LtqY7hdoqDKfpTb0a9oWAD5RVt2ljn0HilgOZPZ5fYucHWyD79H+jcs2TdPI5hOb5EbZtW+juiUDt62T8jjglUn0LJ5uAEY9haUneZ8FfXmpcam3emy7f2FjQ4wHP7rdT+cev5kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNHcCNxq; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64ee072d105so479550d50.3
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 21:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774757978; x=1775362778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=jNHcCNxqoowC8wdD9CiD852e75RHmUvCDEAw3UeKgdHdi9npmSu0uqCkp0aqgbySGu
         Fhgf0jG5yk8Kyzh6s11hVk/zGWm85WzzrftNhr0qfvIhes3ryVB0ICbPZ1NyZU9dPvlN
         PArdGxY2sS3p8X9Ss0sr/jwPMJyi0NhpLG4E7BKfiavw+KhYytiy/KNs/d90OX2JKyga
         sAjd2QQF4mIiCYOfwUmM3mHxmyQAad2rfuLQvWXxz0n+ptlW86ftMuQhjkns99tiTvfg
         tGo40zrsGFKpuS4FNReG/Jff0LCvbRNbWX/Qe+AjLk1L6WtTJtQlTgBhT8OL3qsSNAm/
         vZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774757978; x=1775362778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=YJhiOojoyktYc2xJDJW81jYl2jU424KlGp6/Iq+Wuwhel91H3hLRWPUUoarArHB1Gj
         KJt9k+P4aqdD1jwaU2uhJPG0fQEmlBKNTb3WWiLs44xPltXra7YT2r9iwGJ6YOdV60OY
         txzxoa2gvmPHHGuGJgWOKz7p13qFsii0tiPQbkWQljzmw3EgoMizy8IgIZfhZ5mJnJQu
         Y/vKeuiMUgPg7KkxL4WNEpbCm0Qdl1MAj6m5WgwUVgbSa666xX075Te1bR1Fyc7cxnw4
         wgltXBl32C3EDmf6AETXfL/bQF90okgsMDzUpjfvh7xnb0bIf3Qim34xFBKcXTeEuJ7m
         QObg==
X-Gm-Message-State: AOJu0YyaJ4lHIQzyxVHaqg3jHurHAQkCYD7Y+AGa4HUrsyTOIQIQ15LW
	bdQxC5E3Kkzl0t6Ax6qbaADsZqurqpYje7+nrc3UnI+CEWxX4HNuYGixInYtVjxC
X-Gm-Gg: ATEYQzzNsJD3i/qkZmiatI000Wo3tnFbq8TXDHjWdnP7ldl3d51CgL09Tvg9rainCLE
	Qf3nSvy3XqoS6Wnt6EaSNWvJeAtTHsLGmYrTkdplvtBX4VT7dr87BqvMpxnshdwOTwiptbdVLOm
	2f7SsGHhtiVAGj/o210JM/0+2BzT4Y8lawE6RDnqn4OQCiOGuXvhVGPTEtOQ6q1umqNPKLoPh3E
	9gvWyxVY0NX9y471AfYqwLTK/e6408DToTdrOyuBuZ1ahYU0eZZAvSO9j6VvI8ypVTMNnhUehU/
	M2MTnnmZaxEhE5yH5GhPaKPLesa47rhFwp4Z2m5sR8ZVeZACoqQHOZsXZjOlZCj7gFdGTbGSUI4
	HxGeB9THrJFkvv+BGzpCNcEnNz3dvP2hikUNNZcwd2wi0ni19OTg6NB4YEbZwGg8dxewWjwnXQ0
	kKo1YgP1/YOSVtn33kozCsMSmR
X-Received: by 2002:a05:690e:1918:b0:64e:dc58:1ad4 with SMTP id 956f58d0204a3-64ff7195e07mr5805687d50.2.1774757978454;
        Sat, 28 Mar 2026 21:19:38 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:72::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65008fe9c3asm2026084d50.0.2026.03.28.21.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 21:19:38 -0700 (PDT)
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
Subject: [PATCH v8 net-next 4/5] selftests/net: Add bpf skb forwarding program
Date: Sat, 28 Mar 2026 21:19:20 -0700
Message-ID: <20260329041922.3850747-5-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260329041922.3850747-1-weibunny.kernel@gmail.com>
References: <20260329041922.3850747-1-weibunny.kernel@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-272856-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fb.com:email,meta.com:email]
X-Rspamd-Queue-Id: E30553509F5
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


