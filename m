Return-Path: <netdev+bounces-267557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yD0dKLtXtGlbmAAAu9opvQ
	(envelope-from <netdev+bounces-267557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:30:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D35288BEC
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69F7832648A5
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47F03DDDB4;
	Fri, 13 Mar 2026 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn3AiXJ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AF33DDDBB
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426502; cv=none; b=Jd9HM53LT/0CRHX9fyivZSmXkXAr8Km/IObZjjgq9aKEtZxbAzT5H+5yAjNOzKryLZZhRWljgraB2wokQGCs+zKhdRCv7bf+qnJvNAjlHpCAf1Rqn+lWO8Mhr5fi+Ufy4fmVSgUC4WTnEA84nFn9YxUEhBBWWtuMFBYtHSEDjdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426502; c=relaxed/simple;
	bh=zT2RqGd3nP3UCMWCKPndkuHNOyLMnz4Yhzwh6iq/cJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P//VuLqVI3UHbpp2BwvyCXPYv3lzLn7Rs2WaAdrzlKVdycEpSEcNcv4hou+myR8lOhvbpg2nHNiViO8LIXqK0ZYamBXoMRTW24UBPZvps1ntN++9UdjbmSsJHXF7zXNjvZkqblGojUidCFQvmiYjZYkSsthpcA2d9OY6tdqX0U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dn3AiXJ6; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64c28495b3dso278763d50.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 11:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773426500; x=1774031300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=dn3AiXJ6fI6C16WJCPDOvznABidK+UqgY/EBAIaVppjArGMMc5gVK2DJr1Gzh0Oa14
         Kk2J4MrffTefi5LdccLjw7GPYzqcCB0OqFbPbBtS+f1b7YXwWmhEsa4DX5aeOCk0RoLI
         zNkj8Or4mju0gbBoP73nepoE8PnV9lojCxaCb3YAWrOReyAYg+++kxieW/tqkCbgABlE
         8leQPZgfmHc5OVgmTleWcBz1qzgPk3MjZP9zeNgPiagaNfPkM/MghooReCCMuABL2Gjb
         cwKo/PX9HkjezWhytxF2G89IWLgnQJtkLRCKa+yxD/5/Mo7YeoAD663AfHpUF7O0pjY+
         VOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773426500; x=1774031300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=SajnIlh69+fNGcuHwfucdrpq3bpxu+ybJXismg+U0D/6hp2xrfiFlaqWfa1hYcGjE4
         N5rM4Y69MrKfVo2ZsZwswIBgeD+W4EV20T0oDLqdGgc5xuwNNyei0KkMXd1RrpbTXt3W
         k9eYSf/XoOmPgNzQV9eybjKrMBNbJjXJDWZqGfT8Qdq63z/Ibvf68+neUYJmv0v5sCfT
         7RCdbzXbraryqvtREFy7Ph7eWveDydC4akWnZ0gn9V8KvQwktCGYcuBQX0RJ+QxU0TKD
         XB5wemym2xsdoI3Xb0RolvzMvOlQAB8BD2Ip21HH+Y8++JJvTvOHoOGRYGIvRGKNI045
         Hgyw==
X-Gm-Message-State: AOJu0YySW+fawbQc3GUtgfqnppgWKCWdxdS+iBwrtPU/XIY71QJz7WzY
	fbhaiha6i1PxzCpR3zmhMOE/v4u69l/cXYjcuCPabUHFSEqHpcC0E7rcGyXlcw9L
X-Gm-Gg: ATEYQzz0EsEH/O+XNZfF7Zh4Cx7I+U090+0aA2KiMpmj+FidQ5uYGKBgwBh+pWUIj1I
	TzIxBI/BAyG17yi+0vachFxRfSIzITFa4JAADT7sD17Zt1VIcddLzbKjhht0/99adYTiPdTqYG9
	jQWs+hCOrl1LbzyS50jWa2UfR26wEQy6UAbPxED3XKWr13KRftCTQyYKQdaC2oD0NICYZU8EKz4
	pt+rm1tlRwFAMps7SVg//49e7+ipDBH7ODevphv5/mKP/vkMMZDmJHWbYo5hwB1WFojVWYTX3Gf
	tmEaVmVW2YlqLLgNqahpteLwYZDyT2oyK0LZUvpF1Xv6Gmap4pOeDNYhq7+hUmh1pSv1DB2+edq
	C1o5Q/M5HKPhc1/KWpPS6frPUaNz0lyInPQ3hFq4ncdWFpuu3mXBcJwhCbafxh2Pk8TFoSaHiB2
	bvOQ5puMDNCivY2jHLhlwusoxD
X-Received: by 2002:a05:690e:14c4:b0:649:bf2a:71d with SMTP id 956f58d0204a3-64e630b0a1emr3752744d50.4.1773426500141;
        Fri, 13 Mar 2026 11:28:20 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:70::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e65b628d1sm1487412d50.16.2026.03.13.11.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 11:28:19 -0700 (PDT)
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
Subject: [PATCH v5 net-next 4/5] selftests/net: Add bpf skb forwarding program
Date: Fri, 13 Mar 2026 11:28:02 -0700
Message-ID: <20260313182804.696100-5-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313182804.696100-1-weibunny.kernel@gmail.com>
References: <20260313182804.696100-1-weibunny.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267557-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 01D35288BEC
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


