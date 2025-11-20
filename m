Return-Path: <netdev+bounces-240265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D829C71FDE
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 04:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6E004E4560
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 03:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1B224DFF9;
	Thu, 20 Nov 2025 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Na171HJa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87A02E7F05
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609427; cv=none; b=cniqgbhH/kxoFMUWELv43gQhm7okxrSnSB5QqFfpiSwOERllufu87VcXG/DWi4INMg9XWTX8eoPRuoZV4DycX6jpVViWUeMk73pa4z8r+1N16pr1AOKM62da3QWjHAq7neguMf7WtVGSs9V+wJQZzZxdBle6bHZx5Jdt2VoY8HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609427; c=relaxed/simple;
	bh=A7scEB3VfIHMG59Abv9M3s+GC7JvjO2Z9ALiZPOzFm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DumdKcnGHaiw/a6JEeU7QLfJeVtuoOYNbsSfRChYxS8RhgbVqu176SoTjBDm4HB6wENWN9wJpLYRWLxNlgJWuw9r/7nSQmRFIb+V2vwLPjsELiUXMKMvpwjDzrcf32HNU2gbcPbCJYDkvo0DDdgp6neirS4hA9LgT39jZc58rRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Na171HJa; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6542eb6dae0so164207eaf.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763609425; x=1764214225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOsyOsnEWrnCw/kr6c+Xn0Alym7jBRdC578rwpn/VQc=;
        b=Na171HJavO7Dh2ggOEiH4PR+qD0+U3ueFOL0yT2sNoylVMl8JJeRS89+rsyWWOenja
         0f45be9rAPae+LWjkAWy9MaAMHNU/Q9VQKssifr9063zS33Ax15AS0+zUSJmVSyHEx93
         VeF5h99EyiGhf5tzWFdEOHvr5uj72BWc3rWuZKOpqwLR+mYmViEgi6lm1kJfj4qNtwfP
         gHgQMSliSotpad7c+WPDaeIc5yIkoD9QhKbwPENLCSoy0DOMvIL6JbaRlDSCtBjALlEy
         X+rNeMHpGqMODVQ7DrVC1GgLYQvpwpkIvQUnakz2nxJF1I6p15N9avKkSBLE+WRxDj+7
         9z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763609425; x=1764214225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YOsyOsnEWrnCw/kr6c+Xn0Alym7jBRdC578rwpn/VQc=;
        b=ID4JZtw+PJFLynDjfFZoITZFDifyWUf8utYb8l9TA8ALbbRwZXF/+yNkCUbdRXGtAt
         iSpUJCdHKdsfOskhTa9s2Ya6p5jToIeo2ntG5oq8ou59d3qddaX1PfLNZMGMVv/BsCt8
         Nd3IEYDraK1RAks8ejBekWRNzHCck5m/8fLjEr0aM3bLyJbjOlhPmqdc2lZTgnJ92KWM
         tzJfPnNywQBulzp0WXSWnZiQLBHjLh1CM/eAWgPN0CpMHVYqXIy45j7f7qtn9vuu+R5x
         6NZBDnq2q04SVy0RgE9VJ7OfCvEQzEhjlGqoAjDj4k/KV8bKVnvCNenKB0UGyVQQ7ub/
         50NQ==
X-Gm-Message-State: AOJu0YwFyxO3vm+JauKVVakYiQl/msz6xht2BvVRzOJyH8oEA58gAdzG
	pCfEp6RDVYIOmXa2vhxtLKphBv3x/Q4y64PD0ybgL66vlla3gGm23TCigsaY2j59Wu6ddnL+Tv3
	vGVt2
X-Gm-Gg: ASbGncuRcHYCAsLkK2h5zhVb7d1dlS6HacYssrknS4ujlZpVYQ1vMIDHAcyLbKCbAUv
	M108vm6uMOfMJ567ciVt//io0RjQ0pKqhl/xEDyTl1FeGBFUk7K4T1ZsEiTFIQTPCcg/WL+ME8p
	oHJRLQI3/u5QytXiZaisaO+mp2jVc8QUWRDx1R9PsRCLU4mGuyw4kClCosV4nVUYKhnK1sO7YQs
	+3RUCg9oMjDp3rvnHU3KZsRrX+JCimsNB+/EJQfqes6YyEDSFA7JM6Hl+ECwj39FXFKYmtkYLKd
	D05Y/4ABWOGFHUNGtnwz0aW9DINoiiw0804p1TSdH4crjGfZyRRk/MOFA9OpB2V5GjvwvvIsamB
	blzkI1Jk4KPTZBcP3BV2uAuMwRkMND5dX3VZDu9us2lR6dtSyOaE4qOtd0SfqzOCq/+5+6EDyU4
	s4TxfEOfQLmg4RlkRe4+nTfianXOXszQ6xWGDFrA==
X-Google-Smtp-Source: AGHT+IE+WUXueODDtZPkwDsuCk6vBC0FBXywDQkrvExo2luX7AfdOziJe2DAto9ICnMQYo9pHS7mKg==
X-Received: by 2002:a05:6808:3a14:b0:437:eb1d:cdde with SMTP id 5614622812f47-450ff3866a2mr876549b6e.33.1763609424895;
        Wed, 19 Nov 2025 19:30:24 -0800 (PST)
Received: from localhost ([2a03:2880:12ff::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-450fff8d592sm379701b6e.12.2025.11.19.19.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 19:30:24 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next v1 5/7] selftests/net: add bpf skb forwarding program
Date: Wed, 19 Nov 2025 19:30:14 -0800
Message-ID: <20251120033016.3809474-6-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251120033016.3809474-1-dw@davidwei.uk>
References: <20251120033016.3809474-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed for netkit container datapath selftests. Add two things:

  1. nk_forward.bpf.c, a bpf program that forwards skbs matching some
     IPv6 prefix received on eth0 ifindex to a specified netkit ifindex.
  2. nk_forward.c, a C loader program that accepts eth0/netkit ifindex
     and IPv6 prefix.

Selftests will load and unload this bpf program via the loader.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 .../selftests/drivers/net/hw/.gitignore       |   3 +
 .../testing/selftests/drivers/net/hw/Makefile |   9 +-
 .../selftests/drivers/net/hw/nk_forward.bpf.c |  49 +++++++++
 .../selftests/drivers/net/hw/nk_forward.c     | 102 ++++++++++++++++++
 4 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.c

diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
index 6942bf575497..ca6947f30561 100644
--- a/tools/testing/selftests/drivers/net/hw/.gitignore
+++ b/tools/testing/selftests/drivers/net/hw/.gitignore
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 iou-zcrx
 ncdevmem
+nk_forward
+*.skel.h
+tools/
diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 8133d1a0051c..855363bc8d48 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+ OR MIT
 
-TEST_GEN_FILES = iou-zcrx
+TEST_GEN_FILES = iou-zcrx nk_forward
 
 TEST_PROGS = \
 	csum.py \
@@ -55,3 +55,10 @@ include ../../../net/ynl.mk
 include ../../../net/bpf.mk
 
 $(OUTPUT)/iou-zcrx: LDLIBS += -luring
+
+$(OUTPUT)/nk_forward: $(OUTPUT)/nk_forward.skel.h $(BPFOBJ)
+$(OUTPUT)/nk_forward: CFLAGS += $(CCINCLUDE) -I$(OUTPUT)
+$(OUTPUT)/nk_forward: LDLIBS += $(BPFOBJ) -lelf -lz
+
+$(OUTPUT)/nk_forward.skel.h: $(OUTPUT)/nk_forward.bpf.o
+	bpftool gen skeleton $< name nk_forward > $@
diff --git a/tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c b/tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
new file mode 100644
index 000000000000..103b259d288a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
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
+#define ctx_ptr(field)		(void *)(long)(field)
+
+#define v6_p64_equal(a, b)	(a.s6_addr32[0] == b.s6_addr32[0] && \
+				 a.s6_addr32[1] == b.s6_addr32[1])
+
+volatile __u32 netkit_ifindex;
+volatile __u8 ipv6_prefix[16] __attribute__((aligned(4)));
+
+SEC("tc/ingress")
+int tc_redirect_peer(struct __sk_buff *skb)
+{
+	void *data_end = ctx_ptr(skb->data_end);
+	void *data = ctx_ptr(skb->data);
+	struct in6_addr *peer_addr;
+	struct ipv6hdr *ip6h;
+	struct ethhdr *eth;
+
+	peer_addr = (struct in6_addr *)ipv6_prefix;
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
+	if (!v6_p64_equal(ip6h->daddr, (*peer_addr)))
+		return TC_ACT_OK;
+
+	return bpf_redirect_peer(netkit_ifindex, 0);
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/drivers/net/hw/nk_forward.c b/tools/testing/selftests/drivers/net/hw/nk_forward.c
new file mode 100644
index 000000000000..9519d20cd363
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_forward.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <net/if.h>
+#include <arpa/inet.h>
+#include <netinet/in.h>
+#include <linux/in6.h>
+#include <linux/if_link.h>
+#include <bpf/libbpf.h>
+#include <bpf/bpf.h>
+
+#include "nk_forward.skel.h"
+
+static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
+{
+	return vfprintf(stderr, format, args);
+}
+
+static void usage(const char *prog)
+{
+	fprintf(stderr, "Usage: %s -n <netkit_ifindex> -e <eth0_ifindex> -i <ipv6_prefix>\n", prog);
+	fprintf(stderr, "  -n  netkit interface index\n");
+	fprintf(stderr, "  -e  eth0 interface index\n");
+	fprintf(stderr, "  -i  IPv6 prefix to match\n");
+	fprintf(stderr, "  -h  show this help\n");
+}
+
+int main(int argc, char **argv)
+{
+	unsigned int netkit_ifindex = 0;
+	const char *ipv6_prefix = NULL;
+	unsigned int eth0_ifindex = 0;
+	struct nk_forward *skel;
+	struct in6_addr ip6_addr;
+	struct bpf_link *link;
+	int opt, err, i;
+
+	while ((opt = getopt(argc, argv, "n:e:i:h")) != -1) {
+		switch (opt) {
+		case 'n':
+			netkit_ifindex = atoi(optarg);
+			break;
+		case 'e':
+			eth0_ifindex = atoi(optarg);
+			break;
+		case 'i':
+			ipv6_prefix = optarg;
+			break;
+		case 'h':
+		default:
+			usage(argv[0]);
+			return opt == 'h' ? 0 : 1;
+		}
+	}
+
+	if (!netkit_ifindex || !eth0_ifindex || !ipv6_prefix) {
+		fprintf(stderr, "Error: All options -n, -e, and -i are required\n\n");
+		usage(argv[0]);
+		return 1;
+	}
+
+	if (inet_pton(AF_INET6, ipv6_prefix, &ip6_addr) != 1) {
+		fprintf(stderr, "Error: Invalid IPv6 address: %s\n", ipv6_prefix);
+		return 1;
+	}
+
+	libbpf_set_print(libbpf_print_fn);
+	skel = nk_forward__open();
+	if (!skel) {
+		fprintf(stderr, "Error: Failed to open BPF skeleton\n");
+		return 1;
+	}
+
+	skel->bss->netkit_ifindex = netkit_ifindex;
+	memcpy((void *)&skel->bss->ipv6_prefix, &ip6_addr, sizeof(struct in6_addr));
+
+	err = nk_forward__load(skel);
+	if (err) {
+		fprintf(stderr, "Error: Failed to load BPF skeleton: %d\n", err);
+		goto cleanup;
+	}
+
+	LIBBPF_OPTS(bpf_tcx_opts, opts);
+	link = bpf_program__attach_tcx(skel->progs.tc_redirect_peer, eth0_ifindex, &opts);
+	if (!link) {
+		err = -errno;
+		fprintf(stderr, "Error: Failed to attach TC program to ifindex %u: %s\n",
+			eth0_ifindex, strerror(errno));
+		goto cleanup;
+	}
+
+	while (1)
+		sleep(1);
+
+cleanup:
+	bpf_link__destroy(link);
+	nk_forward__destroy(skel);
+	return err != 0;
+}
-- 
2.47.3


