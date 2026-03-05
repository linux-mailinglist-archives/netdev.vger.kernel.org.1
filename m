Return-Path: <netdev+bounces-264508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMx+BQvJqWkAFAEAu9opvQ
	(envelope-from <netdev+bounces-264508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 19:18:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E73F216E94
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 19:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F4B330459FA
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 18:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07D83D3CF9;
	Thu,  5 Mar 2026 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="jygwHAFf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F724366829
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772734703; cv=none; b=n/zr7E2YsByKFNH+f4/X8DaREPOWlFFFNdjnOBtiTvF6vJW/2/+4DoFu5OPzec9TIYG22rzTuHlrc6++DFtZQuoI2BXJS1kVHJD7xeLk7Wj9v5tp/vH/u0z2jeuOvfusIiJOwViQ+y1Pp6TwiVOOXITzuUFIuvDGIp11icXeALc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772734703; c=relaxed/simple;
	bh=sPmix59H2C1cYe6RWQi1HyeyyQZOU/8D95KeCn7K9QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckkC7BOVA6udh5pDEghbJJ5BWgvcuggAxEAFRBmn4WwhV2JP9dsV1fOM3RHFAzKTwsZxOQOHIK4qRx9KHVWnlMG7MWu+4ZLFe80pa18a6IU6glBnMicXg/bZqAuDTt4cThSdehjZU/7JikIt33z9E6kcrDiw/2hERiCftt2s+Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=jygwHAFf; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d4c65d772cso7340789a34.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 10:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1772734701; x=1773339501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtLJ51MVvzxIjJKbVfy4ay9B4kth9zqdhIvM1OEySYE=;
        b=jygwHAFf7mg74AojDGf3CyCUD869Qy9v5W0v6QT6ZsVbM7Wd+ckoQFdqm2//pVunmu
         mCkrkmH8fy9eCrMiyOtMXJ1vSi5oW/YQFgMNugRYiWcdVStpHQnIlvUJ1+HzPG6l2y0N
         dHdzVKumTMZxDoBe3ENpXFNBRvI92Uc/sXV/Zf1Ia8JasnmD2c/h060cDikE9KIJ7GUz
         6VNWB2ETwv5KzarnUQRbKOPWByCACD08LpRf9NgfypoY1Jmbeq9ChncqKZfbCoeMHCW1
         HxvburVM0RcSRYkQJhRd2QXeISwiHvU+AMap0A4UqaPyFN4QHxtj5XZjwArUqWKu50KF
         o+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772734701; x=1773339501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GtLJ51MVvzxIjJKbVfy4ay9B4kth9zqdhIvM1OEySYE=;
        b=VEFHsol3DCXZb+REf9AZ3Ye7tRfsxu575ACd/kQuyBpbVkIKJSEbjgjKBtrFbqq54b
         VST5vmbkAURL6h5/ckfPV55wERtwnZ1nrvk8h7oWzZRvQuGT97RQOPHGKoy0ueJglc0r
         m/7Ua6gsiR5l3D0Q9UDfAxV0ey5Ds5iYfnP2DzgFf9e6XlVRION+kEA9I+FA+YRUYD3Z
         mByNURDZPESwoRgwA9sQn1BtU/yIh6shWEBvKdg/jdWcqSPZZsVIiJMavrCwPfPmGS43
         wsGELG2mq9BrAnZbaOzoLYfCUgJFu9DEQX9Ji/uBNPFTUK+1itlC83Uy2zPipn3lIW3Q
         uYlw==
X-Gm-Message-State: AOJu0Ywr1JSHH/ETBllJnCEQ+ES9/XdzTe91eAn7MYyI+NT6HQe/FCsZ
	4YNKLVAlGVKj2H3DFz/p5RYy+/JWzBZsSwJY5xDt2A83jLEvv9K1Kyk7bLaF208ooCzvvj9Wnwd
	zk+Hm
X-Gm-Gg: ATEYQzxWERQMMa/RBCsh0lIC1CXOrNa2cSng0QeXf7iH4L6U3JtIT3vTSKhETxCg7iM
	2r60dPWq14Ljw8t5lbHkTRf0YOPAUE66r0PT72VdqtZTJ6KmptChAIcqvLa0/yw+nzt7UaBv375
	rdhV5uZTSD67Ez6dDDzgrFs5O3zWUm9/qUpPXdY0YzZvPuQcsTgvUlltKBxKRqmjsKxwscA335P
	rL3L86Qq6tgMZ4HR6GxQnUGqvBvDi5jOiDzWKVAx7gz5xwVN6uNABxudSneDHyKqP6bq2orcYis
	6thLR2Rhuk1Grm2fmvoVPJRTzUHkH1Jjzup8BAulTtnaQq2Oa86jwQ6KgRkzCtBaVTsrajnc6Im
	vSIYLmEdAN7/ly5RmHDQJxHC14lGbuW0u6LHZcErkNV88So/sMhyHRNE5TdUEsP3iQzAFKuceYN
	31s/cNyHWM4Qi7rDN5teoLFVm2o1Cn55Y2sRVh3DT5OzllojHsqpTC
X-Received: by 2002:a05:6830:390f:b0:7cf:d119:8d93 with SMTP id 46e09a7af769-7d7248f5fffmr355760a34.0.1772734701373;
        Thu, 05 Mar 2026 10:18:21 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5b::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d59785d8d5sm14636575a34.17.2026.03.05.10.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 10:18:21 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <joe@dama.to>,
	Wei Wang <weibunny@meta.com>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next v3 1/4] selftests/net: Add bpf skb forwarding program
Date: Thu,  5 Mar 2026 10:18:00 -0800
Message-ID: <20260305181803.2912736-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305181803.2912736-1-dw@davidwei.uk>
References: <20260305181803.2912736-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6E73F216E94
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264508-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dama.to,meta.com,gmail.com,fomichev.me,blackwall.org];
	DMARC_NA(0.00)[davidwei.uk];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Add nk_forward.bpf.c, a BPF program that forwards skbs matching some IPv6
prefix received on eth0 ifindex to a specified netkit ifindex. This will
be needed by netkit container tests.

Signed-off-by: David Wei <dw@davidwei.uk>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 .../selftests/drivers/net/hw/nk_forward.bpf.c | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c

diff --git a/tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c b/tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
new file mode 100644
index 000000000000..86ebfc1445b6
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
+#define ctx_ptr(field)		((void *)(long)(field))
+
+#define v6_p64_equal(a, b)	(a.s6_addr32[0] == b.s6_addr32[0] && \
+				 a.s6_addr32[1] == b.s6_addr32[1])
+
+volatile __u32 netkit_ifindex;
+volatile __u8 ipv6_prefix[16];
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
-- 
2.47.3


