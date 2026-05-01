Return-Path: <netdev+bounces-283264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE/TI2/p9GnpFgIAu9opvQ
	(envelope-from <netdev+bounces-283264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:57:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E77804AEAA1
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62467302C0DE
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 17:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB1F3242A9;
	Fri,  1 May 2026 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQQ7JXzK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF59F3264D6
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777658153; cv=none; b=adNlz8pidbPBr0vpvthfkVFMR582KjjrZ8qkcj77hyyddl4v4Kf0L0ze5lGvQ9XYnBJaH2rDje/xgGMdrBy8qDNlPhnVpB1bCMj8eu0HzklR9ofkIlhAiUflihux4o4cX/jKYawA2c1Yr4ZMDuN5uXpl5xYpjv0ReBOrjr6W27c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777658153; c=relaxed/simple;
	bh=zT2RqGd3nP3UCMWCKPndkuHNOyLMnz4Yhzwh6iq/cJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3QZskHZpss2VJwZptJt6Wo+XUuGYhMmu0t3EAXdHrAC2bYRdYo3OX0cSWDAmxa5cSsmYhka7aN+PzN+rbIX7ocbbBw1nmbq2Ai9hLM7uGjH+4Vkx8qYK1kDhYtIx6kMVtfxJsU6HMZM1YvmIQN2noZSrWies9PJaUmk8q8wphc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rQQ7JXzK; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65c2e7ff1acso180170d50.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 10:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777658151; x=1778262951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=rQQ7JXzKPEsAY0DLMajugesbqJUgPb4MgBvt5Hb34T9h+T0V73l0JDOF8Rf/sRxBlL
         voWPmdFthY+Yk2SSr1IuIrKfYWPT18ObVE+NrTGWQ4PHf0m3iXQnhfB+YrkpK6gp0HnG
         1u9APB3yrVrrDwaLMOqSKwoO2gKbGAofwR8iBH7teQPXYDx5/zA33XXyegRKcxBIUQ9b
         exN5c0+NulgCqNdkhpRLPVzbCgWxDsvudn8ziNXGU0mMsQ7JhKp7aWj0OeWdccQO4HfG
         lho/f+Pz49aGlNwec9vupcCLxln8OqQocXlp2QWN91TtgVcnJ/sofE4wZh1M+ssSiaZA
         k4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777658151; x=1778262951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=Gp6ElkMLw+kO/D/17Ds958TbC2uDnsGPAkMfgMUuJTWEMQPbXQPXwbMMtHKP4xq7oy
         NenxFgziAEXeeiVpNHZ0yR5nv/lmNA8XnIIoszTAVdJ1MzrDwWTRSX6sfjJCTUGGuc9j
         j0sITab+L1ccGcVXF6PALhIZcHn4upXzYL0+W60/xCodChWQf+YXZv2np/8LzKp97JN3
         UjSC3b8YcPtSCC1npYbaEB/0kQTw6Yd+A0BPEH9imzRlet0T6uVsqpdgU34Rpn+QelbC
         60k6Dr9zgoLN6MWIMidwKizGZO/xfuMsbtoTXX4A7IY3y9NDfW4v5Pth7qQpeGFk3Ij+
         2ACA==
X-Gm-Message-State: AOJu0YzY6m6a/A+YUXsu16gSb1TBOVIQFhya/dSb3t73sf5AJ6oVWxzG
	JFRRifV+Z2+1pPFSArz8k/iwC7IdWQDrEJrf+eHv+hXr/PvzqKPwb0XWWrUmqA==
X-Gm-Gg: AeBDievwX6p3KDUdCZJ8WNS0jJfya19JjqsQiJjGXvPU3McmOb6anreEbsaKl4ebUxU
	5Je9ROT//idUPDuNGrd0n7PwFejO8yypvDnjnNWCxromaNKBbx9gC+sKFBvHLP17ydhV2aC5zDo
	T5QO39JnhAcVTpmVmdF2/kZv83ynLOj6mPZA0ORnYwxP4x8FU83Bb3HZZPjLY6+MenJnuZkK9c2
	bKpROLCvp7+Dlw3cse0U/uAnp/TIbMt+eg5HKDVIMG7Hwcx0VRiVt4zBmnPeK940jC6uwp2e90G
	4qQFwKXMHtX18JcrqB92QAau7i/0Bed1xF6g0xAwXUbh4ARAKNcVpnRak+cLnzW5X+N87gWQTsx
	ABM2iyn8UrUr6ulJbyGY2JBoTfvfyzy0d49AxWghg4nww1kDY82aRcaXBPVSRTKBgJ+P3K0yvXy
	0EnEZPouOZNT/L5SWKYRx+scSYYTJLroy4+II=
X-Received: by 2002:a05:690c:c4f4:b0:7ba:f0d0:5e9b with SMTP id 00721157ae682-7bd76f7e1a8mr2996657b3.2.1777658150682;
        Fri, 01 May 2026 10:55:50 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6654cc7csm14426077b3.13.2026.05.01.10.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:55:50 -0700 (PDT)
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
Date: Fri,  1 May 2026 10:55:26 -0700
Message-ID: <20260501175528.2130551-5-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260501175528.2130551-1-weibunny.kernel@gmail.com>
References: <20260501175528.2130551-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E77804AEAA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-283264-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,fb.com:email]

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


