Return-Path: <netdev+bounces-265693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPa2EMATr2nJNQIAu9opvQ
	(envelope-from <netdev+bounces-265693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:38:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FDF23EB4C
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 279F430E2319
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 18:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C3134A766;
	Mon,  9 Mar 2026 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arStlWO3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD5A346E73
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081316; cv=none; b=kDHPyBbp5nMK6PZscWPp31B/WUlmWU68LYp83L1nYWwNDV2DgcjJ2u7oB1zl50YpMKdjvjJwLbdVgDvyppOJOlbidk78W2asJTtuVhztDe9m0SaT4JESZZ4p2WejzauEALCp/txuuCGX9ZEf9rLZS9S8GU3G+3flxsv/pzyVWAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081316; c=relaxed/simple;
	bh=zT2RqGd3nP3UCMWCKPndkuHNOyLMnz4Yhzwh6iq/cJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iW5KCCOS8fPUr5HVAZCZ0BETa/1riO27jpS53mb7yM22bJSVexQ6HK75Gczhhcv3BIpfKpNE+wr4CBouzXfqhaC77w8KFCbBHwpVHZc0BiN+4sVocjZlOA0e1iP1fdnGX7tvecxfl+22UoER50d0AjVGoBxecy8dg6GWGjVi1d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arStlWO3; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64b3801600fso1428481d50.2
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 11:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773081314; x=1773686114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=arStlWO38ZR/i5SFhVFQdTP1i/+Cy6rNJ2AnTA0SaBMyNK8WAFDV/D/QeNLS4t529I
         i/Fa4v7hqrqNXyqLvOaHGU8IR80xskjvKuD2CQC6vUTxso0ZdzBLJSu+p94niB4Lq7vn
         gJJWCbPoBUHoIY12h5lCmFTB+tr8GcpsgDRD1NzWKAbV7wtURmgo2vohBBE3IaxvRFI5
         hU3GggYWhR4v1gHZFBOL6CdxnJ3w1/9xZsSz0qnSiYj27gHRqyBj7e8UtpPVlznYHDGb
         xLIrrkGM3SenWim77uheeODInpCEJ2guIrE2I7qJ0u71/6q8QNvVA4EMI4ekQ+xgQvZ1
         yUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773081314; x=1773686114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=Dv+Oc78CVQWWqDAjFNmdtmC4O1O4LY0icZW5CcS7mKu3hJ2NkMK4WLN8/ImxnCUVPL
         x98xkg2eWXOjqpJIqfDmFxCm4bNVfhR9x/9fF/66+/QYMOZR63fZKUVf/gkdn76jruVX
         gz8FhHB5yVmUwJpzKK+qSfnIS6LNr2YoGkoyCoO3UMbpCSoVpxTUXPGx/tZwrudj4G8K
         sU400V3S/aHAyLYBolXj85n8XSvaNwn+8XtXcAC36elG6uQOybZWt1vVYTV+vFkufe2V
         HP7FP2EGJAqA3I+xggp+ncdpZ6amesaRQhx3feNVRTc8Q6e14y3iIw0OxWj9Dh22DbOM
         cFfA==
X-Gm-Message-State: AOJu0Yy2PKZ1H2kUG8b1KDSaP6t3o5cM2LBgtNQ6zR9Xw7nG1wULu8WR
	IOhZUQ3Fmhhj43Bx7Bs5H/mNoNZp3inwguFZwP746FZ+judqVP36DEallKuyKjZd
X-Gm-Gg: ATEYQzwBpnQQVJo3zk8JilUjKsMz7d5mdKu+NqODly2+V+wnIohzmvhoJHDXE9Jnw8+
	T345/MvxbByX0g3MEooEBT9mCh16bvpZjLQl1DkRX3ACC0J2uIbKH6oxv8Q3RkA6UJJC4EOVtgq
	sgjUYPQn6coWByky7nrdIxV6zHwedgqfbLhkqDb4JFk9Dg23xHjai99VnWM8M7PHOCNRGbJj8nr
	dZMFYbg061hD2OQ+110C3QOnWy0rw/BWW2K/cNoR/H+Nl0ZlA71VF99k3cvO7Fj3mHlUw31TNn5
	VZokrGk3QTWUt0C2dh6wC6Ec2yWV5RiKk1pNNNHEOTbST8MafSQXDsRpXlVbAxqA+oVtreDt8pp
	HWAl3mM5OMgbt8r/JyFubwTnuWDo6QBkNUBUm8tpohg0Ju59C6fQfKcvsJtWWQEwU3YgDTGIE8w
	3/1lt+kWS/l4YflrimVHKLKmLp
X-Received: by 2002:a05:690e:4007:b0:64c:ec4d:4a61 with SMTP id 956f58d0204a3-64d141fb853mr9804330d50.2.1773081314394;
        Mon, 09 Mar 2026 11:35:14 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:54::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d16d74899sm5011879d50.0.2026.03.09.11.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 11:35:14 -0700 (PDT)
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
Subject: [PATCH v3 net-next 4/5] selftests/net: Add bpf skb forwarding program
Date: Mon,  9 Mar 2026 11:34:52 -0700
Message-ID: <20260309183454.2872967-5-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260309183454.2872967-1-weibunny.kernel@gmail.com>
References: <20260309183454.2872967-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B8FDF23EB4C
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-265693-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fb.com:email,meta.com:email]
X-Rspamd-Action: no action

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


