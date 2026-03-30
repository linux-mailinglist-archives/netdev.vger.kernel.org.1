Return-Path: <netdev+bounces-273346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF1xGvL7ymmlBwYAu9opvQ
	(envelope-from <netdev+bounces-273346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:40:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD63D362070
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D12C309C87B
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 22:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C4B3E5579;
	Mon, 30 Mar 2026 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpLIhHr1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39E13E3D8D
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909922; cv=none; b=T1zG4H3QtOTbFWGp06eli03SCy7fP1Je2DxPvhdosGRTEi67f1a619a7Aq7DOZfZyzheEmOH33a10EJexEZF/a1KgqtdWAcPtI7Cv+LnNbstNKHHqIE53iFWHPG5DZTlyrK8WLrwYjzRrPneM85pdLXDOYItgYsH/e5v7IIyslc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909922; c=relaxed/simple;
	bh=zT2RqGd3nP3UCMWCKPndkuHNOyLMnz4Yhzwh6iq/cJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DofdLUdhAmvhAhQhwpxR7aNgxaIpfxawO9XIXCxzx3LgQrVpl9ty+HRXXBqy9TZ4crMUx/4qCcTPnCm5pvKANhGBiXRqBEwHBSbY4ITrJt2/3fUqpRsU9L8OZw8uMwrP8Tcfh4yHUwU2KL+302FybwkM25PBjisYYGbmR4AD0vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpLIhHr1; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64eeddd31a2so852004d50.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 15:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774909912; x=1775514712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=IpLIhHr17cBFZSe0CnBKCbJiFqt05npZVselGfrENeuvka88XbrcT35ruqAbJPlhXu
         bI5cs/VTYA7GBFFxjWylzupgzLTS4q/XER8AX/14eVzcbzQi0BnM2uaM8WG0zaMQx97C
         srnRaYgHsBGKd+MtWnNqRX+Eq98qJxErOV0ApsxuYoD8Xi0be2uul4q5x0CpTGATnOeb
         hVffbBEmz5qrnnaS/j2xlZUtkQMKudADUnj8wEFcFyx4Mj5fvXwG+NSH7IOXPO/s9pMP
         Vn/83I6gmLZEqJxkyvWFXHYab4bWZhJ/G1V0XJvfXToJaxTp1HNx6LIn2KdnXaGObLgg
         lu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909912; x=1775514712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=U0/pzxAaXm+UmW2XUMo+aVFSbVoHuqlqTdai4PUtsoMvGH96RaGuooZEADF5N2dydu
         Og9kN73uSIn9TX/k7StyhCKse2TdibrQmE5o9RdpO7DIN64wh5G2zkKg5jYEldbP0+EW
         yRVVfkGG90mz51DBrYR9+mcgVV7MYajuRbjZrw92Q+A3wsHYthq0s2pG5JUDJBgBrB+m
         zAb7KnnXzJzddGtgFCvdHDgXXVIJ9dQcQbm2j1DpkdeMbFGxUcdS4PRvFB3ghsL2bM0R
         DO4ZlD3StQReNWNgc+hNnZ7BNuTKfSGc6TnxGzIDUcovl7acuPlCTA+DE2WAxeu4MXvh
         vJEA==
X-Gm-Message-State: AOJu0YzsRK5gkTTBAMa8sD+sd4mACYD9sIjkIN+mrMTKbIIl3a424gd8
	o6rZ2+aS//D+L4sSsXU0FvJSsmyOZqbHrzLYKTvmMjZk8emrlaEI8juz6EGMNnYt
X-Gm-Gg: ATEYQzyJIQyqD4fKHUJ4kxFG9tfCcocJR9laOgp8BmEbhUQpgjfBVvVE0j3w8t5RRgB
	/MNXmvIh8DgSvAz/Yj9MD2byHam6HNWOtg1jNFHrgg2LSbRuCgF3Ku3or7iz+2b2+hAhTCzEuaa
	DYkD2PxIP9aC18nDYltK1gtdKafZd9eWKf/qLViN7NlgbKAJb8w97qrr6yLbR8MiLK//WPuaQTg
	vtgUUP5TAFcd/3E1xtAxbGbX8X63uKXqH0F9LrgCLLbdUhrk2vNSOcsMitR7+nrtl0PGulM6H6S
	ZxiuWMgIJS2cOoE4xJlN7WB6TdfTQVIDYWNG2cH0em1MybMRoDAiwYIT7Qp6hIS6IW1Ja/v3trj
	JxqqWIhq8e0CyWV4Ow7id3o2Li3q9iT5L0klP6VTiXFp2jsbC1+heWCCNzG9Q9Y1NI6EnrLp53A
	NKmQ8XoI/hyVe8dOqfuhcmCcU=
X-Received: by 2002:a05:690c:4445:b0:79a:c473:ca05 with SMTP id 00721157ae682-79bddc99310mr108562147b3.2.1774909912470;
        Mon, 30 Mar 2026 15:31:52 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cba374c42sm41620427b3.39.2026.03.30.15.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:31:52 -0700 (PDT)
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
Subject: [PATCH v9 net-next 4/5] selftests/net: Add bpf skb forwarding program
Date: Mon, 30 Mar 2026 15:31:41 -0700
Message-ID: <20260330223143.2394706-5-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330223143.2394706-1-weibunny.kernel@gmail.com>
References: <20260330223143.2394706-1-weibunny.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273346-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Queue-Id: BD63D362070
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


