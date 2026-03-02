Return-Path: <netdev+bounces-262494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HhkNfwhpWnd3wUAu9opvQ
	(envelope-from <netdev+bounces-262494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 06:37:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 311EB1D3238
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 06:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D5753022635
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 05:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC13318B83;
	Mon,  2 Mar 2026 05:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="AD+rp1Cq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B2826E706
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 05:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772429681; cv=none; b=sijr2L2eznhhWZQ99jd1ksJlPDIfVOLbgDLImx7Tu6dOSPUOy5svFZX7NN6FgMD4cDPMlPZke8ljWdu86Y5UZeAV935Uk5AkvUDSZ0LvWbT6VirOYx+28vxF8b+5DUvRXyrNJdBpK3rFAsFQxr5VWiXnfW6w8rlzmwNDJc2UB3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772429681; c=relaxed/simple;
	bh=sPmix59H2C1cYe6RWQi1HyeyyQZOU/8D95KeCn7K9QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sX2v0oYyRVZmU+n1b9vl/g1J1niTYBdUTFLY6e2YLexLjPDW8V/Ow9Jj38TdmmEB/c4QZNn9SwfVnnX1EAcgDraHTOSloR5e5OtsWWDXr3z2Sw/7hp1KtTkifsB25uIz/rbae3YXMMqP/T080yumVRjB+SJI08o9VDE+sIdUA/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=AD+rp1Cq; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d4cb7e10efso5000275a34.0
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 21:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1772429679; x=1773034479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtLJ51MVvzxIjJKbVfy4ay9B4kth9zqdhIvM1OEySYE=;
        b=AD+rp1CqsuArZMpdCocDd+HcC7zB1trbw98xjCR1GTIkuRCqD9nXEe9QS2reCFHwGl
         TW/ttthLeyXU8oLJPhVHxSNgXjaGP5c9QodBP6QlHqmVRIOmYjjZv9a2khmOwhV5jGWh
         bLE8jk7ekEwiK0Wy0D6noy8kYfuWa/KKsfyFSwPPGRzdFVstPwMvHU+9DfREI/a9TUXk
         kHSE7pBTeNxXgVSSqd70UufMR53ILfc0NNq1mJ9nbt3m2tzKOg+sLeMCL998xLdiJHPd
         SPJxUySw/H/4CS8NGTFnb+nc5e9+wyngcjI877B8v5QhWUc9nq3vKrz+HrHQGb/0HOXq
         scSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772429679; x=1773034479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GtLJ51MVvzxIjJKbVfy4ay9B4kth9zqdhIvM1OEySYE=;
        b=hDkklLkXe64jFMtHvmdkaHLeZCvbUYKjnacAvQkztQf6HK84V8N/B4NFl6x4rfrekF
         vtcViyiHnaGjvZ26eSGZaA6G1VvRSRkxHuvqLTslhutLsyM15wsF5Sf3fdIsYvB5gIYX
         byZQkD/9h3KqQyD1GfieL9xuhH1ix0uJdVl86OH/apnSicIyUFUq3nfEQ3mzfggDYGKb
         6MtBcLw/5es/usvXNX8VDmWsljDeMlFGONMqnKNh+FmKwVcao/YnhDTZU4Gf9AsmC66t
         X8oRuelu+8vw0tkRrXXhAQ/WSh3BxE0SIATzB7dhi46If+ohr/Wa+brb7gaxkZdfbaOx
         nQ8g==
X-Gm-Message-State: AOJu0Yy7oD7rJ5XMKR8syg1eVG53lC/7vCrCW+wdvvCEwV8T2sIJIOnD
	yZeoZ2CFisfVV7CKg8Ji7/JrqcaRsp2H3lih+bhU3QJyPvaF67djN/SdH3zdsokv0mefDzOEF5x
	lI5K9
X-Gm-Gg: ATEYQzzH4bSyiQc2UcgvxoRYEjsj3H4siu9KLT32WZw7+gkSssO4SXqLOZIEK4m4j3N
	16l4Cd/WzMlhWwAohKEr90gduAfXoHVZjSwc0XoGMNXI19OfzEElmQu/SLM03sg+OWxotEMzwHf
	sGardbgL0QAlbMbzyAFy0KU/cBM7e48PHIraHozz+ytreBWHdy8Ug3x7VgMFAdw5kLA/zjYg87Q
	9/lAq34yEr+mU8DUfry6EyRxRYUYrd5GZTE00ZR4KSM9E4ochdyau8EFTDOLswoulHfY/9wI4O7
	DPDRUBjKHQCrW3J/POGpL5z0F385zldGUiKd5EqQaREZxJxGm4w+bpj/jitykQCXF0Plf9s7lYa
	fICBkfImoAF6mgtjt57a8vZjaaaPGjbrSiDZxQVNxPs2yj/lODCaXzPfXBSJSU+O9A82lgjGyDa
	1TEbuV4LlOQiEFkjwDQYdqb6o8EYT8xn2vxfmRVGnoCQ==
X-Received: by 2002:a05:6830:6737:b0:7d4:bc46:e35e with SMTP id 46e09a7af769-7d591a238eamr5294929a34.0.1772429678886;
        Sun, 01 Mar 2026 21:34:38 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4d::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586626abfsm9883392a34.14.2026.03.01.21.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:34:38 -0800 (PST)
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
Subject: [PATCH net-next v2 1/4] selftests/net: Add bpf skb forwarding program
Date: Sun,  1 Mar 2026 21:33:12 -0800
Message-ID: <20260302053315.1919859-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302053315.1919859-1-dw@davidwei.uk>
References: <20260302053315.1919859-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dama.to,meta.com,gmail.com,fomichev.me,blackwall.org];
	DMARC_NA(0.00)[davidwei.uk];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262494-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davidwei-uk.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davidwei.uk:mid,davidwei.uk:email,blackwall.org:email]
X-Rspamd-Queue-Id: 311EB1D3238
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


