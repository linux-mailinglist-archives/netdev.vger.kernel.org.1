Return-Path: <netdev+bounces-279709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPWKDxwH5mkIqgEAu9opvQ
	(envelope-from <netdev+bounces-279709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:59:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCE2429B01
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16BBE30451C7
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A640B39DBC0;
	Mon, 20 Apr 2026 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuwejd4m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33B839B96A
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776682715; cv=none; b=ooJ668fXO3Xn5hlU9sjcka3pe6X5W6bwq/Yu7nTAYWbXuY/YT8mhdlRLo9UKirvZY3XVNww7tteSldyLFzeSFhfjH0iev+gBUzmAiEiujzuqVrUIlRlLmNm1IKV1RkORUueGmYIfwVrJsDNZ/fT6Rby6tNLjXRJIda/kKqc2+mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776682715; c=relaxed/simple;
	bh=tGFWlJ9Emn6lMayfM7X7YT7f2+X67E/6qliDHAALv6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H1t9oJLPKpP6NfomjB106A3uX6FIio6kY19L/veT6EzJ9Vi0X3b/La4tNpnPr232vNFs/yPdW5L83ajQueELPdunbPLJdoKMbAwfPg+3QHRHw2g9X5vr7ltZiIzasFEifPBO4kH2OGTpJV32xw0MX1z99Inc2XxeZ0VL8GRfFyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuwejd4m; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso33885345e9.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776682712; x=1777287512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xo1ra+dvGbFs6OJejHFLsiY9EUjfbBrgYOeoScEsTuc=;
        b=kuwejd4m+mq5a0aewiDuTaXsOZPk0oZtw4A9PqEl9cdOeyrCJulozNifgRHjgsakvg
         CZGT+PgRajEUScOTjIOmPqvTI1JSscnGehNWVDRog2tPhK+q9O+7Ybe9XOLneMZ9k4AQ
         oLyan1IdB6e6f4AYH1xLaFO6082Ts4FzhyyNaq7QgkH1TdtkKkbB3/IXVwHVdP/CWDVO
         rsb5tpeLWk+sYMEnorzbNNB56vyv+vDQfj76Q/AuWSx+9WnR5fYJowZryjZdCS+2CgVY
         huyGvi7YJlHxWHOMdv+TTs1tcHo/WZ2ZYGL3kKVRcEPF5l8dibk3daJXrBW+zD4bykei
         zt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776682712; x=1777287512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xo1ra+dvGbFs6OJejHFLsiY9EUjfbBrgYOeoScEsTuc=;
        b=o/geVbyZNut4NIrROO36SgbBAWoAuPWjHvDbdaqAqI74J9q67LDK0l7QaQdl0zKJbU
         igJL+PACDGUvpd3R6//oc5R0OKL89EMFZP/O2QYIBVfdJFAX3gdPIxeQVkxpTdCrnECr
         9Z6qIzB6eZWSaoRp4Aa4CJ3G7Pg3kXBbO+54rMgqsUscrfz2UZIvks9A9P1v0V3KArDE
         Aq+kYACsgNgyyTU8N2mbQfW1jHDgh1MyN5kXrw+sfW4kB6uNGTT97yw7bRMtqdpzCGoR
         PBJELaM035mAkwXTKmTtSK82juTnkvoWUI4aGPznSPsg7N8pRC4silx7Nu1Wxb6ci1FM
         aSKA==
X-Forwarded-Encrypted: i=1; AFNElJ+gkT2T8Zh3XJLmDudCJKYka2zcaSJgNU9PW5yK513cuo4oR6vMXQreAENSTXaxrx3c5yN1GzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbW+6gHBqYt98OGn4QKn425FZxTX50PhP1Rplujb6ANsTT5roO
	CwkVNSCKQj9SaTCXU38IhhFsaUaRpExO7hIYWjyAtd6kMRpprrPyVOF2
X-Gm-Gg: AeBDieuNx5g3eQZiGTfysuP5QhbGFs5w0ZbUl5UWnyKcbqtuC96MtOAAP7CZ3KoqT0c
	pZLtWOtwHVwKgRGuJhIMMYhhmQnDZ4mEJVOsLEtUxHZ4lkjaUOK0zZ+zHaQ+NhMbd+4+0svQL2W
	om3+GMTEzKU/9Ufri8oT193ECvfFDewi1I1X/rSX+IgIpXnUdD11J3Mb54Wrz7i417z1axb2rDI
	qU5almv6AjKrJN49WF/IPguY0hHHQHSNa5YdLLztmP877nxU6p0pTrEc2Ey/8lTiSerAcgMWlvM
	jvOrgvuVQw5GxwkYGB0CrAyv2fBntcynt741el2i+UiaVAV9wLQO6c73iOw4Mg3HCBEkONO8fRJ
	wRDYcz2zIhlKZLo0I2vyzDhZd2LHx2sv6fZ7WduHuNRrL29Ma3lk0dzALdGsVLsCV2eUw/OQ6b/
	98QFOE53c1JpHn8/BwAhI4e87HSJSxDX2A1EEcXw==
X-Received: by 2002:a05:600c:870e:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-488fb84ffb8mr180290575e9.0.1776682711829;
        Mon, 20 Apr 2026 03:58:31 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-488fc1cfbf2sm290929495e9.15.2026.04.20.03.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:58:31 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: mahe.tardy@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	coreteam@netfilter.org,
	daniel@iogearbox.net,
	fw@strlen.de,
	john.fastabend@gmail.com,
	lkp@intel.com,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org
Subject: [PATCH bpf-next v4 3/6] bpf: add bpf_icmp_send_unreach kfunc
Date: Mon, 20 Apr 2026 10:58:13 +0000
Message-Id: <20260420105816.72168-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420105816.72168-1-mahe.tardy@gmail.com>
References: <aI0MkNvWlE4FXMV8@gmail.com>
 <20260420105816.72168-1-mahe.tardy@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,netfilter.org,iogearbox.net,strlen.de,intel.com,linux.dev,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279709-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: ABCE2429B01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is needed in the context of Tetragon to provide improved feedback
(in contrast to just dropping packets) to east-west traffic when blocked
by policies using cgroup_skb programs.

This reuse concepts from netfilter reject target codepath with the
differences that:
* Packets are cloned since the BPF user can still let the packet pass
  (SK_PASS from the cgroup_skb progs for example) and the current skb
  need to stay untouched (cgroup_skb hooks only allow read-only skb
  payload). The kfunc set the dst of the cloned skb by using the saddr
  as the daddr and routing it.
* Checksums are not computed or verified and IPv4 fragmentation is not
  checked early (icmp_send will check).
* We protect against recursion since the kfunc, by generating an ICMP
  error message could retrigger the BPF prog that invoked it.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/filter.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index fcfcb72663ca..a6c3b9145c93 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -84,6 +84,10 @@
 #include <linux/un.h>
 #include <net/xdp_sock_drv.h>
 #include <net/inet_dscp.h>
+#include <linux/icmp.h>
+#include <net/icmp.h>
+#include <net/route.h>
+#include <net/ip6_route.h>

 #include "dev.h"

@@ -12423,6 +12427,86 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
 	return 0;
 }

+static DEFINE_PER_CPU(bool, bpf_icmp_send_in_progress);
+
+/**
+ * bpf_icmp_send_unreach - Send ICMP destination unreachable error
+ * @skb: Packet that triggered the error
+ * @code: ICMP unreachable code (0-15 for IPv4, 0-6 for IPv6)
+ *
+ * Sends an ICMP destination unreachable message in response to the
+ * packet. The original packet is cloned before sending the ICMP error,
+ * so the BPF program can still let the packet pass if desired.
+ *
+ * Recursion protection: If called from a context that would trigger
+ * recursion (e.g., root cgroup processing its own ICMP packets),
+ * returns -EBUSY on re-entry.
+ *
+ * Return: 0 on success, negative error code on failure:
+ *         -EINVAL: Invalid code parameter
+ *         -ENOMEM: Memory allocation failed
+ *         -EHOSTUNREACH: Routing lookup failed
+ *         -EBUSY: Recursion detected
+ *         -EPROTONOSUPPORT: Non-IP protocol
+ */
+__bpf_kfunc int bpf_icmp_send_unreach(struct __sk_buff *__skb, int code)
+{
+	struct sk_buff *skb = (struct sk_buff *)__skb;
+	struct sk_buff *nskb;
+	bool *in_progress;
+
+	in_progress = this_cpu_ptr(&bpf_icmp_send_in_progress);
+	if (*in_progress)
+		return -EBUSY;
+
+	switch (skb->protocol) {
+#if IS_ENABLED(CONFIG_INET)
+	case htons(ETH_P_IP):
+		if (code < 0 || code > NR_ICMP_UNREACH)
+			return -EINVAL;
+
+		nskb = skb_clone(skb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+
+		if (!skb_dst(nskb) && ip_route_reply_fetch_dst(nskb) < 0) {
+			kfree_skb(nskb);
+			return -EHOSTUNREACH;
+		}
+
+		*in_progress = true;
+		icmp_send(nskb, ICMP_DEST_UNREACH, code, 0);
+		*in_progress = false;
+		kfree_skb(nskb);
+		break;
+#endif
+#if IS_ENABLED(CONFIG_IPV6)
+	case htons(ETH_P_IPV6):
+		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
+			return -EINVAL;
+
+		nskb = skb_clone(skb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+
+		if (!skb_dst(nskb) && ip6_route_reply_fetch_dst(nskb) < 0) {
+			kfree_skb(nskb);
+			return -EHOSTUNREACH;
+		}
+
+		*in_progress = true;
+		icmpv6_send(nskb, ICMPV6_DEST_UNREACH, code, 0);
+		*in_progress = false;
+		kfree_skb(nskb);
+		break;
+#endif
+	default:
+		return -EPROTONOSUPPORT;
+	}
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();

 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12442,6 +12526,7 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,

 BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
+BTF_ID_FLAGS(func, bpf_icmp_send_unreach)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb)

 BTF_KFUNCS_START(bpf_kfunc_check_set_skb_meta)
--
2.34.1


