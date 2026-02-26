Return-Path: <netdev+bounces-261596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHINCIy4oGnClwQAu9opvQ
	(envelope-from <netdev+bounces-261596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:18:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BAE1AF9C8
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40614309CC91
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6772B477E3D;
	Thu, 26 Feb 2026 21:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HSbXyZrf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210A24779BF
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140400; cv=none; b=mGywxnWWq/hGsQeEzk3Te2y7mnPbFM8zaVGeZ7Zzz5l2XBdFPBBLqrORNcwnJBId4BpTBV0NTWxy2YHK0CDiEyr5Xi9ymI3nzhcHdnLWzrEq+TnArJLEjaJKlaV4hqph4TrwaijWZzWNkD53Pe1eNBtPCk+DF8pQ65Od8+ORUKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140400; c=relaxed/simple;
	bh=OTVrss/3LRtGekr0mBxcD67LyIqn8V5WW0W6TUG4yMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uTC68zq6gfgzGcE6yKPn119TV3u7qc0npiwO/jA5imCPsic+Jryj1gESqAd2KrAYOoyu0JCzJBbvleUaEorb5DgEiQzjg1ZEhT6tfIHu3FX1tL6SUnRqTvLChhs57kyFIUJdqQk5j69x30oVIEV+bebrJDmvmxyTtA4x+7eaF8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HSbXyZrf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so15135025e9.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 13:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772140394; x=1772745194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTw2TYqUyjwBZ4ECkQKNX4mXfjOM8iHHwzNAybhskVg=;
        b=HSbXyZrfJaa5wQVdaiWanIscUdCD0E+qrTCeldlUaxhaDgxLa0XagpKRjKW5i7BV3U
         X9bksb7vmkeusYJe3AhCWeatK2lZwAM3vPiMvnghpZwLx1afDkLuCxwEGtEk1DwBVc5U
         fLt3qs9R2DjArDSjtGb9SPoPn/s9C7JSJBM+tqfHEI5ind77oIY9ekO6edYLMj8ISiNP
         eUG9rffy/aSoiO5HUsQYMdQR2A5v6NeEN/CpQon2nxbfKgoBxJo0QmRkidhdkdvT3Gsc
         XAqU4TJ99sOWPNMj3MQZiGDZKIGhzeKRiMkjSoJTqK5XjfU+b3I+NWSUSH6ibYYIMMNw
         MkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140394; x=1772745194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iTw2TYqUyjwBZ4ECkQKNX4mXfjOM8iHHwzNAybhskVg=;
        b=aNKHJXSfSbh31zxGr/GNyDhiBqm+E2xtCIUzCXsw5A0EQ7qboZC9jEKH5vFr6HEeej
         tKeJ7BmBRFldHLYTYB3in3kvnEU9+4fnrq4FmjRFO1nx3ZRLl8mXqIdl6ITFNfh+FlLO
         LumuxotXKHJlfO81ktxGCIx2kTAi7ag2ttE+KefA8afbBgq6JsSX7jyZfJ0iCwCoFztj
         UJxHLbHkwnXGmNely1wQCM0iOW8fC9z7hjqKRthtxIhZxQdYmBlBe3fQTG7/rCZahOYW
         XXfRRD7PuWtBBSkitbrpKPDC5OT574MqnqE+qMHnGmK7AOcOtePMiJ2IRGOTv9khfSB6
         rltw==
X-Forwarded-Encrypted: i=1; AJvYcCU+jK4ka0m9bJrmeh4X9ouKVYZrUg4at0k5OcOO/++eGub0STomTAAFmY20BHzRmETRIvFItsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDGvYlTFtH/4JH9Q65EpOhVMadfEO5anwCPSXdpFsX8Osxv4Zn
	LFxht+s/xS0H4RT3YXyk7tyzJdLLdzgIHXkIVUINw+bAU6QMwNT3Tc11P4bKyZP89kyPXeGJAm4
	iJ3HnkQM=
X-Gm-Gg: ATEYQzxW+eTIiVO4Y9tV35Xhs3n8HrLJDdcqqCTGb0RcJE8kp53y3zQE7qtFEDKp2oF
	10XrT09twK07390aCbjpU6ufbOkF2MNiWqhR88g0mXRuU+UBWEq8F1yO0cEpCSfob9jgV3TpmpV
	3MjDzLoq6o5yM03PMjHM50brQNUIuAUOqdTGabrt9NQUcZITylzov5uuZ5ldji/3CcoAx9n27E7
	4F9b43vBbe5l71aD5Q65k6Eq4MOfpYl+qddFHFgMP2IWjWS/HS5Vmd+b+qM1j/1/gHggVysEVPK
	JRdNFi7scz/wQUnLA8JQlxm0mq9QwjnKA9gAxsQd5oEGmLuUnwY4UOfKfvPyn4KJ5xOTQbAr5lK
	3oxL3b7QDOdfHPeVFJr6XCXLyn9GXo0wj6PkZwD7YsYVk8TIe3I4T8Tu5pJCsObxqW+uOMjNWoz
	6YbDdBbPzXpM0c1PEtP5iUR0PmuJz93xekUIkla/WPf6BotUKJH5crj2e9jxfhJ/BvhBZi
X-Received: by 2002:a05:600c:3486:b0:480:3a72:524a with SMTP id 5b1f17b1804b1-483c9bed89emr3796995e9.19.1772140394248;
        Thu, 26 Feb 2026 13:13:14 -0800 (PST)
Received: from cloudflare.com (79.184.124.63.ipv4.supernova.orange.pl. [79.184.124.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfccff00sm46083465e9.25.2026.02.26.13.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:13:13 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 26 Feb 2026 22:12:55 +0100
Subject: [PATCH RFC bpf-next 4/5] selftests/bpf: Add verifier tests for skb
 local storage
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-skb-local-storage-v1-4-4ca44f0dd9d1@cloudflare.com>
References: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
In-Reply-To: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261596-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:mid,cloudflare.com:dkim,cloudflare.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0BAE1AF9C8
X-Rspamd-Action: no action

Cover verifier checks for the bpf_skb_storage_get and
bpf_skb_storage_delete kfuncs.

Negative tests verify argument validation:
- not_a_map_on_{get,delete}: a non-map pointer as the first argument is
  rejected
- wrong_map_type_on_{get,delete}: passing a BPF_MAP_TYPE_HASH map instead
  of BPF_MAP_TYPE_SKB_STORAGE is rejected

Positive tests verify the kfuncs are callable from all registered program
types: socket filter, TC classifier, TC action, cgroup skb, sock_ops,
sk_skb, LWT (in/out/xmit/seg6local), netfilter, struct_ops, LSM, and raw
tracepoint.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/progs/verifier_skb_storage.c     | 209 +++++++++++++++++++++
 2 files changed, 211 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 8cdfd74c95d7..c82e0d48ba34 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -114,6 +114,7 @@
 #include "verifier_bits_iter.skel.h"
 #include "verifier_lsm.skel.h"
 #include "verifier_jit_inline.skel.h"
+#include "verifier_skb_storage.skel.h"
 #include "irq.skel.h"
 
 #define MAX_ENTRIES 11
@@ -259,6 +260,7 @@ void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
 void test_irq(void)			      { RUN(irq); }
 void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
 void test_verifier_jit_inline(void)               { RUN(verifier_jit_inline); }
+void test_verifier_skb_storage(void)	      { RUN(verifier_skb_storage); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_skb_storage.c b/tools/testing/selftests/bpf/progs/verifier_skb_storage.c
new file mode 100644
index 000000000000..cd4d817232de
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_skb_storage.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Cloudflare, Inc. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 1);
+} hash_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SKB_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, int);
+} storage_map SEC(".maps");
+
+SEC("socket")
+__failure __msg("pointer in R1 isn't map pointer")
+int not_a_map_on_get(struct __sk_buff *ctx)
+{
+	(void)bpf_skb_storage_get((void *)ctx, (void *)&storage_map, NULL, 0, 0);
+	return 0;
+}
+
+SEC("socket")
+__failure __msg("pointer in R1 isn't map pointer")
+int not_a_map_on_delete(struct __sk_buff *ctx)
+{
+	(void)bpf_skb_storage_get((void *)ctx, (void *)&storage_map, NULL, 0, 0);
+	return 0;
+}
+
+SEC("socket")
+__failure __msg("cannot pass map_type 1 into func bpf_skb_storage_get")
+int wrong_map_type_on_get(struct __sk_buff *ctx)
+{
+	(void)bpf_skb_storage_get((struct bpf_map *)&hash_map,
+				  bpf_cast_to_kern_ctx(ctx), NULL, 0, 0);
+	return 0;
+}
+
+SEC("socket")
+__failure __msg("cannot pass map_type 1 into func bpf_skb_storage_delete")
+int wrong_map_type_on_delete(struct __sk_buff *ctx)
+{
+	(void)bpf_skb_storage_delete((struct bpf_map *)&hash_map,
+				     bpf_cast_to_kern_ctx(ctx));
+	return 0;
+}
+
+static __always_inline int call_skb_storage_kfuncs(struct sk_buff *skb)
+{
+	struct bpf_map *map = (typeof(map))&storage_map;
+
+	(void)bpf_skb_storage_get(map, skb, NULL, 0, 0);
+	(void)bpf_skb_storage_delete(map, skb);
+	return 0;
+}
+
+SEC("socket")
+__success
+int access_socket_prog(struct __sk_buff *ctx)
+{
+	return call_skb_storage_kfuncs(bpf_cast_to_kern_ctx(ctx));
+}
+
+SEC("classifier")
+__success
+int access_tc_cls_prog(struct __sk_buff *ctx)
+{
+	return call_skb_storage_kfuncs(bpf_cast_to_kern_ctx(ctx));
+}
+
+SEC("action")
+__success
+int access_tc_act_prog(struct __sk_buff *ctx)
+{
+	return call_skb_storage_kfuncs(bpf_cast_to_kern_ctx(ctx));
+}
+
+SEC("cgroup_skb/egress")
+__success
+int access_cgroup_skb_prog(struct __sk_buff *ctx)
+{
+	return call_skb_storage_kfuncs(bpf_cast_to_kern_ctx(ctx));
+}
+
+SEC("sockops")
+__success
+int access_sockops_prog(struct bpf_sock_ops *ctx)
+{
+	struct bpf_sock_ops_kern *kctx = bpf_cast_to_kern_ctx(ctx);
+	struct sk_buff *skb = kctx->skb;
+
+	return skb ? call_skb_storage_kfuncs(skb) : 0;
+}
+
+SEC("sk_skb")
+__success
+int access_sk_skb_prog(struct __sk_buff *ctx)
+{
+	return call_skb_storage_kfuncs(bpf_cast_to_kern_ctx(ctx));
+}
+
+SEC("lwt_in")
+__success
+int access_lwt_in_prog(struct __sk_buff *ctx)
+{
+	return call_skb_storage_kfuncs(bpf_cast_to_kern_ctx(ctx));
+}
+
+SEC("lwt_out")
+__success
+int access_lwt_out_prog(struct __sk_buff *ctx)
+{
+	return call_skb_storage_kfuncs(bpf_cast_to_kern_ctx(ctx));
+}
+
+SEC("lwt_seg6local")
+__success
+int access_lwt_seg6local_prog(struct __sk_buff *ctx)
+{
+	return call_skb_storage_kfuncs(bpf_cast_to_kern_ctx(ctx));
+}
+
+SEC("lwt_xmit")
+__success
+int access_lwt_xmit_prog(struct __sk_buff *ctx)
+{
+	return call_skb_storage_kfuncs(bpf_cast_to_kern_ctx(ctx));
+}
+
+SEC("netfilter")
+__success
+int access_netfilter_prog(struct bpf_nf_ctx *ctx)
+{
+	return call_skb_storage_kfuncs(ctx->skb);
+}
+
+SEC("struct_ops/bpf_fq_enqueue")
+__success
+int BPF_PROG(access_struct_ops_prog, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	call_skb_storage_kfuncs(skb);
+	bpf_qdisc_skb_drop(skb, to_free);
+	return 0;
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops qdisc_ops = {
+	.enqueue   = (void *)access_struct_ops_prog,
+	.id        = "qdisc_ops",
+};
+
+SEC("lsm/inet_conn_established")
+__success
+int BPF_PROG(access_lsm_prog, struct sock *sk, struct sk_buff *skb)
+{
+	return call_skb_storage_kfuncs(skb);
+}
+
+SEC("tp_btf/kfree_skb")
+__success
+int BPF_PROG(access_tracing_raw_tp_prog, struct sk_buff *skb, void *location,
+	     enum skb_drop_reason reason)
+{
+	return call_skb_storage_kfuncs(skb);
+}
+
+SEC("sk_reuseport")
+__failure /* FIXME */
+int access_sk_reuseport_prog(struct sk_reuseport_md *ctx)
+{
+	struct sk_reuseport_kern *kctx = bpf_cast_to_kern_ctx(ctx);
+
+	return call_skb_storage_kfuncs(kctx->skb);
+}
+
+SEC("flow_dissector")
+__failure /* FIXME */
+int access_flow_dissector_prog(struct __sk_buff *ctx)
+{
+	return call_skb_storage_kfuncs(bpf_cast_to_kern_ctx(ctx));
+}
+
+SEC("lsm.s/inet_conn_established")
+__failure /* FIXME */
+int BPF_PROG(access_lsm_sleepable_prog, struct sock *sk, struct sk_buff *skb)
+{
+	return call_skb_storage_kfuncs(skb);
+}
+
+SEC("fentry/kfree_skb")
+__failure
+int BPF_PROG(access_tracing_fentry_prog, struct sk_buff *skb, void *location,
+	     enum skb_drop_reason reason)
+{
+	return call_skb_storage_kfuncs(skb);
+}

-- 
2.43.0


