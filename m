Return-Path: <netdev+bounces-301083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 36R8BnklOWrLnQcAu9opvQ
	(envelope-from <netdev+bounces-301083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:07:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACDC6AF4A7
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:07:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=spbyP6t2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301083-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301083-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E88F30488CC
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3883A6F0B;
	Mon, 22 Jun 2026 12:05:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4473905EF
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 12:05:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782129933; cv=none; b=ITNGigKvZ4QKdfa4qQIoEqnaMvxOdjV5EokkCnNuRvdLYxjImyMtid6PMluZK87A6ndElneJQXnn524u5KEpN3SVRM53bM1uzU4LkTXWhNR2kQSMNskcrzmGLOf7J6VQeQK6fKYvgHQ0sqbt1kYOtzFLc3rHTyCsyCXd9iCEvNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782129933; c=relaxed/simple;
	bh=EaT57APwDLbRDVSJpex3SzVfEaGvAq1jZhGocpW41BE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gn10iYKKNuDaSrIvRwZqMxiANTOzTVNCoUqOZRCUsJbx/8Vj7qh51GTvA9yYvV3S2NHnjshLQWYXKUPNEW7hz6OMJ2g2chtMZo4bowhTwt/TE2Ou3tz1CZVerSN6ft13tFTnJ1I5DaU9wZw1EV451F83w5zfToMpEJurzweneIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=spbyP6t2; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490cdae130cso20578715e9.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 05:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782129930; x=1782734730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8wRHqN1v5qtDf6h6onUf5Z6NIMoxTDlFE+BkdNR4SQ=;
        b=spbyP6t2TlPgNaiUxKGEmnuszdXkI6En6ze96KNgO/4XOcDyFKtCZhFvqGMjtbuPsw
         Hvif41J1lUoMbiYXKoZwu6KFpdsxOWTpaJKjd3wD857KoZFTYxhfE+VA1dIS3+6y6PZh
         IvpnEtEhAcOGn6UbPjacPZrFpQVfI3QBaAKLXEehh6bEs656xL9Q1GFKTWRLvMYcMlK9
         h225Or+AfUyApFWglhINKuSV50L2RptQJ1Q4spZd0yX0taIYK2GxxXcDk+45epCP9Rhz
         ehnjv1MR/jdNfhniKQWaow7ms6VwfEntFbW7YvJqfrup5lX2b5Qo97I5cCCvU+oddWAp
         4VDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782129930; x=1782734730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a8wRHqN1v5qtDf6h6onUf5Z6NIMoxTDlFE+BkdNR4SQ=;
        b=d8xiFdCZ2aH5sIcrmzG9K7yQFyZ8uZuyQAv1hEpPTS8nSZN62qdziK47CRDTiUmEyd
         7oK4uo7S/ILLCChulI0mRER/DKYwpA73nHlZhL9MmRLn3t5+P3wXUCdfruj+75SAkGsY
         fIhIvKxl1DTxiyfdhl4O/lMbjk4D0VG+sYs3WyCkLclC1/3NcezZV9vUluhNJccn9DlH
         CwZ3SobaS0pOk2nsDRNdInm9R3E4FcZw3EMwCSWuwwB7Q/SUDVmF1WsQCgUoJ8DWu02X
         aAhCicf618QcCFaFs8yTHLuNebnlrEWqg8+CIF8VHglTUEBiePyIVsq6XuAJYSZo2v9S
         AJEA==
X-Forwarded-Encrypted: i=1; AFNElJ9KZtQyhcmMRj8VohM/08+k9m7X5xPCe1OFN8x+MOh7HrZzUF0c95VM27dKFP9Yf+0myGg5YtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+5sTjcQca3Y55vNfI9aLmkZGwv4F2wcEtyZI8uz0X368lWH5
	rtoMWLpVKNM+v13N0pTlJSNPpRnWfYMqBs/4fl1Rx8UdMCtkx9ccH/sB
X-Gm-Gg: AfdE7cm9hz8BAp4IaHCu7piPj5XEnSxeHWKCumyENayZTxLw21D1QAH7H8qxt9iFxvS
	PICufhIHabqJ9y1nUjENzvx3yfEyEDBo74gAQ42ELhX8n1aX/nBG+W2mb0LfEej6OBujZ+AXgan
	ECrAjdlLclqbe9RF9q4wPqSHm8F7leF/4pJIfJ9AgOCjnp9kS1zA5WdjqLlBw6j4VPrNxihf+U+
	+LdPBGAaNitNx6QOmAsr2ZvA5l8Ej86dQlryz3aoOTEVBMcb8OZ6aHm7zjabxL2gq+M9Y97Ja6V
	XKonzFHXZuXKRchzRiG+fmvKSMttO4ZRQUnnId758OKSk0NOxC1eYAMmA6zUxLvhXGGJECRnvml
	qi5FD5BCXQDPOiB8Lk/PD38IjK/RRay9pNDtx7Y/h3bMy4rVMyzfz358eWNt/StR0CFboUHqreH
	6+c+KGgt1Jpv59G3bt
X-Received: by 2002:a05:600c:1548:b0:492:48dc:3d0d with SMTP id 5b1f17b1804b1-49248dc3e0amr147076885e9.12.1782129929529;
        Mon, 22 Jun 2026 05:05:29 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm491083105e9.0.2026.06.22.05.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:05:29 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	edumazet@google.com,
	john.fastabend@gmail.com,
	jordan@jrife.io,
	kuba@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	pabeni@redhat.com,
	yonghong.song@linux.dev,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v8 3/7] bpf: add bpf_icmp_send kfunc
Date: Mon, 22 Jun 2026 12:05:11 +0000
Message-Id: <20260622120515.137082-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622120515.137082-1-mahe.tardy@gmail.com>
References: <20260622120515.137082-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-301083-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:kuba@kernel.org,m:martin.lau@linux.dev,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:pabeni@redhat.com,m:yonghong.song@linux.dev,m:mahe.tardy@gmail.com,m:johnfastabend@gmail.com,m:mahetardy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,google.com,gmail.com,jrife.io,linux.dev,vger.kernel.org,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,jrife.io:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7ACDC6AF4A7

This is needed in the context of Tetragon to provide improved feedback
(in contrast to just dropping packets) to east-west traffic when blocked
by policies using cgroup_skb programs. We also extend this kfunc to tc
program as a convenience.

This reuses concepts from netfilter reject target codepath with the
differences that:
* Packets are cloned since the BPF user can still let the packet pass
  (SK_PASS from the cgroup_skb progs for example) and the current skb
  need to stay untouched (cgroup_skb hooks only allow read-only skb
  payload).
* We protect against recursion since the kfunc, by generating an ICMP
  error message, could retrigger the BPF prog that invoked it.

For now, we support cgroup_skb and tc program types. For cgroup_skb and
tc egress, almost everything should be good. However for tc ingress:
- packet will not be routed yet: need to set the net device for
  icmp_send, thus the call to ip[6]_route_reply_fill_dst.
- fragments could trigger hook: icmp_send will only reply to fragment 0.
- ensure the ip headers is linearized before processing, and zero out
  the SKB control block after cloning to prevent icmp_send()/icmpv6_send()
  from misinterpreting garbage data as IP options.

Only ICMP_DEST_UNREACH and ICMPV6_DEST_UNREACH are currently supported.
The interface accepts a type parameter to facilitate future extension to
other ICMP control message types.

Reviewed-by: Jordan Rife <jordan@jrife.io>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/filter.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2e96b4b847ce..fc69a14650e4 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -84,6 +84,8 @@
 #include <linux/un.h>
 #include <net/xdp_sock_drv.h>
 #include <net/inet_dscp.h>
+#include <linux/icmpv6.h>
+#include <net/icmp.h>

 #include "dev.h"

@@ -12546,6 +12548,101 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
 	return 0;
 }

+/**
+ * bpf_icmp_send - Send an ICMP control message
+ * @skb_ctx: Packet that triggered the control message
+ * @type: ICMP type (only ICMP_DEST_UNREACH/ICMPV6_DEST_UNREACH supported)
+ * @code: ICMP code (0-15 for IPv4, 0-6 for IPv6)
+ *
+ * Sends an ICMP control message in response to the packet. The original packet
+ * is cloned before sending the ICMP message, so the BPF program can still let
+ * the packet pass if desired.
+ *
+ * Currently only ICMP_DEST_UNREACH (IPv4) and ICMPV6_DEST_UNREACH (IPv6) are
+ * supported.
+ *
+ * Return: 0 on success, negative error code on failure:
+ *         -EINVAL: Invalid code parameter
+ *         -EBADMSG: Packet too short or malformed
+ *         -ENOMEM: Memory allocation failed
+ *         -EBUSY: Recursion detected
+ *         -EHOSTUNREACH: Routing failed
+ *         -EPROTONOSUPPORT: Non-IP protocol
+ *         -EOPNOTSUPP: Unsupported ICMP type
+ */
+__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct sk_buff *nskb;
+	struct sock *sk;
+
+	sk = skb_to_full_sk(skb);
+	if (sk && sk->sk_kern_sock &&
+	    (sk->sk_protocol == IPPROTO_ICMP || sk->sk_protocol == IPPROTO_ICMPV6))
+		return -EBUSY;
+
+	switch (skb->protocol) {
+#if IS_ENABLED(CONFIG_INET)
+	case htons(ETH_P_IP):
+		if (type != ICMP_DEST_UNREACH)
+			return -EOPNOTSUPP;
+		if (code < 0 || code > NR_ICMP_UNREACH)
+			return -EINVAL;
+
+		nskb = skb_clone(skb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+
+		if (!pskb_network_may_pull(nskb, sizeof(struct iphdr))) {
+			kfree_skb(nskb);
+			return -EBADMSG;
+		}
+
+		if (!skb_dst(nskb) && ip_route_reply_fill_dst(nskb) < 0) {
+			kfree_skb(nskb);
+			return -EHOSTUNREACH;
+		}
+
+		memset(IPCB(nskb), 0, sizeof(struct inet_skb_parm));
+
+		icmp_send(nskb, type, code, 0);
+		consume_skb(nskb);
+		break;
+#endif
+#if IS_ENABLED(CONFIG_IPV6)
+	case htons(ETH_P_IPV6):
+		if (type != ICMPV6_DEST_UNREACH)
+			return -EOPNOTSUPP;
+		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
+			return -EINVAL;
+
+		nskb = skb_clone(skb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+
+		if (!pskb_network_may_pull(nskb, sizeof(struct ipv6hdr))) {
+			kfree_skb(nskb);
+			return -EBADMSG;
+		}
+
+		if (!skb_dst(nskb) && ip6_route_reply_fill_dst(nskb) < 0) {
+			kfree_skb(nskb);
+			return -EHOSTUNREACH;
+		}
+
+		memset(IP6CB(nskb), 0, sizeof(struct inet6_skb_parm));
+
+		icmpv6_send(nskb, type, code, 0);
+		consume_skb(nskb);
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
@@ -12588,6 +12685,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)

+BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send)
+BTF_ID_FLAGS(func, bpf_icmp_send)
+BTF_KFUNCS_END(bpf_kfunc_check_set_icmp_send)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -12618,6 +12719,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
 	.set = &bpf_kfunc_check_set_sock_ops,
 };

+static const struct btf_kfunc_id_set bpf_kfunc_set_icmp_send = {
+	.owner = THIS_MODULE,
+	.set = &bpf_kfunc_check_set_icmp_send,
+};
+
 static int __init bpf_kfunc_init(void)
 {
 	int ret;
@@ -12639,6 +12745,9 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_icmp_send);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_icmp_send);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_icmp_send);
 	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
 }
 late_initcall(bpf_kfunc_init);
--
2.34.1


