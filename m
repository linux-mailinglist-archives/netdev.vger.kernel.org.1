Return-Path: <netdev+bounces-276747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FdFB5fh1mnUJQgAu9opvQ
	(envelope-from <netdev+bounces-276747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:15:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 892A63C4BF5
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EB9F302A1A7
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 23:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E09381B1C;
	Wed,  8 Apr 2026 23:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOYYh1Gv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6093A1CE9
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 23:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775690071; cv=none; b=T0AxRmP+dJPPZdRgs8+QmFrm8A1kmjL2FCIw2yiWhCyXoRQg0ImLoTSyo75w5VeO6X2bXar6x+HSVo1Epr5ZzzAAY50Q+auX2cDw5aUTDI2Flla5SlpYosl8/IqP4EM43m3nojGMT8NnR0Bg+9fO8iBrfWyDrykAYJ9TYd61ASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775690071; c=relaxed/simple;
	bh=zT2RqGd3nP3UCMWCKPndkuHNOyLMnz4Yhzwh6iq/cJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGWoISgynNo7bWl/qrv9XFao22R6kUF9jrATSPhJAOqCQQP5HJuMx2o+QS3GYLdninhgQOTN1jdIaFmznIfopnM8kvqpFl2nh31DpCvQNpbAshsbSyA0KV9wrDXjKCOv+twPkShq1u7rYoSF6gwXsBmw2LKA1kyVr9CWPxmvxek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOYYh1Gv; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6500f949a23so41881d50.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 16:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775690068; x=1776294868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=hOYYh1GvW39avwf9Tcw1bzhdeC0hpGYjvRU1xBh+gJAHxAG52pJpmQC4rP2CIqRZ4b
         3giLnl+KSz2Z/B43m5pJVIU5kkgcYDjdxtP36jeHWFpuA6Rr+3nnY5SG/om8eEwMeomN
         eKh1b3c+V+qDQLQGEoFbWPwuMTd2MzymIr4E1pQM5GU0LYfi6KSMKmfVLqgBIhgX9QBf
         F55w+y9hXQtzIm+RGqjCx8hp6FgHLqRjLViwaCNGkMV2KQKsMc+IjbXF2kRhAk2EKow8
         jq5IPHJ+vyS946Z74yAhSW+e8r1B2BBaxJgT/Mwmnj8EB1VKaUScDxWleImhOzLOZxiH
         KGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775690068; x=1776294868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=Uwt2Qv1UZ+57PttkDtz9dCZnEy6UK2WX1eWrRB+rfYxAwrXrKqZXN8vMWOKE2t1wyO
         DrmxSI3K8856bJTxj7kIvqQYTi/jE0UNyPmMtkvH2lv5IlxrRyWHouuFj9c1EAeUzvrJ
         sPACj9f1/4+n6sZzTYnvH9qoycFq+/wVi5ocB8NMlbTUNsPqmHrT7mpAVOesq6rn73Ga
         DwZoS7MeVQXSiUDv3am7YbLlE+A85rK5YiLPLdx2x2/gu2+FoYkFBxA3e+FxHkjygcxj
         xmDtz5mGaBIOIVpt4Tz/qSh6XATbLVNA8UT9NUBCDcUrg/YiONIeU2ZKrxVPGxEG/2oe
         pGqg==
X-Gm-Message-State: AOJu0YwjMhgjpTVq/CBxUyNn/+dqzStddn47TOq/Cw5tcW8tIM8/LYKh
	hfKNaxJnvm4gVAfXdKu7RPSjpFX097GIu+iTJwgJNlcDhGFeby1qTf2LGz/AAoGz
X-Gm-Gg: AeBDiesihsh5+kVBOYvp1OPF4dB4XJF/ygtZFhAuK0paOlt1JK/062aI2+eNapycIeb
	61NTjym9y1NrlgTewaXu8LX+rvLVltcczYdzh4pyru8Jzawfrho7fEkG9ehe/+bQ4Ics3jWAJO+
	XUeJbzKzJkDRsCdCEO7TjGyO+Pb9bhFpD9/UtbKPQhWPQO602Qo/LRk/U3TGKGZfL2mhvoGeazM
	7Kb/fIHoMe/+fNMYM8Rvet10XFC/Ykrh2dcbM1No1ocdbBzhjZjZINyKFYmrYL8MxZ9s90sz2Yy
	w7w7gbwKzAmRAmF3gTR0fVYAB4dcbNN5v7taTOvcOv/eudxiU+58441WixqBGHUZ4t8NaKcHtLU
	rhv5Ej3RUGmKwjre691TwzEzdNjBXUdNiXw15UYrAuD2SmOVG8D0kmr9vU8GdWhKeS5U+EWJ91K
	CbSHxzUjw4dyD+zryYdzUH
X-Received: by 2002:a05:690c:4d09:b0:79a:46eb:d1cf with SMTP id 00721157ae682-7a4d692b65emr169264797b3.8.1775690068624;
        Wed, 08 Apr 2026 16:14:28 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e42ff26sm94940957b3.9.2026.04.08.16.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 16:14:28 -0700 (PDT)
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
Subject: [PATCH v11 net-next 4/5] selftests/net: Add bpf skb forwarding program
Date: Wed,  8 Apr 2026 16:14:13 -0700
Message-ID: <20260408231415.522691-5-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408231415.522691-1-weibunny.kernel@gmail.com>
References: <20260408231415.522691-1-weibunny.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276747-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email,fb.com:email]
X-Rspamd-Queue-Id: 892A63C4BF5
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


