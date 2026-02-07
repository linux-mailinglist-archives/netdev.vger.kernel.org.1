Return-Path: <netdev+bounces-257792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK/KDcnFh2lldAQAu9opvQ
	(envelope-from <netdev+bounces-257792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 00:07:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 800C210763C
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 00:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BD41301E3EA
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 23:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC39310645;
	Sat,  7 Feb 2026 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gPlLADHL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E7A20010C
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770505645; cv=none; b=IojtBlIG9joyt04HcnIFpWBZZ7oJbxOZdDGd0WPcHFsXJ+5pLnK31qOaTBfwD/mMSiTG73OFZFC77HXMAovKffZu54FGwyAdGTIKCwjztErlwB6gdDqAlm91lZUYPRia4qELPMP8vTuFdfiGkOQCXx5voQC+slYmNZ64QQPakOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770505645; c=relaxed/simple;
	bh=C41IRFijtQzRZlauXeIIR/4sndA4xOV88VT65gcUTFE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YeBkGRJj4R59YfJAvhtAORsmLIMzaFl04Dvi+nsPRD8puiYaAzhw50OoKFG4T5OssVvYzdhy/jwM3djkCOVmSn6wwRSGARa2AIOt4ir2VIDli8lStcpubtTdlzaXeM7/zrs06LSQv5pE8U8izjiOUTWAknlrRFDIe7SBK+XhUxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gPlLADHL; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a76f2d7744so33949045ad.3
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 15:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770505645; x=1771110445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8bv9HC4USag0VbcfoeIn7GkYivkoa06qGH0wzz89UHc=;
        b=gPlLADHLrtuA2ODrGwpKDrd6sKkwgNE41C2lRpoXrEdaDwu1aSycTpoY1trxISUla0
         3DiZOWZdUhLxFPhCmW3tqI5av5T7B1vdF3b1VdWXoCKW+1Hp4dRKD+vtetXGxnscyeEr
         6TJAjElmk/ohT3Wo6Q6KvJe0pc223V1behlU1fAdaUVU/n7bQGRLArtmx9wUf5MqwVZP
         u12OzQ7b0jR5yHYdzqYabtZ8WQxx6m3gzFEDLVTb258HpZfUeutPY3XsZLzBuXmQ5ti6
         KTcqLh5QkN2fmvBzQkFH52wzoAClkYYrBW/o80aeCZx0mrq1CqFZnaTBbVIi0ha1t3wC
         gXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770505645; x=1771110445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bv9HC4USag0VbcfoeIn7GkYivkoa06qGH0wzz89UHc=;
        b=kR5O9sDsidHjoj2aVnFsqoM3a2TMo9ZioQRBiDsCLl9LrKpls6Xg4/yykaQioeYOwy
         jsXwhU4FhGryQ3W/PyvtNf7m/wCMye8H2y5Y0C2mIa/b5N2w9p3vKyTq9q9uxbbWrQFw
         23PzTVONH+7BRMAATZbp0TkzIJ/kirXXc5A8R/i7pKcbfcpEvS+Y1UArxAS68xo6WfSc
         Fzn0Gg+nmEFA0mLLt4tUy4MJJS1ziGvdf5MXEJcy1UIjSkR1Yh2KHaAwYBbUb675GN9I
         HQegwrr/uolVFLTnqLZQPQRPQuutLcpWh0HGy6m0M+pPIH5ZRdGkc6MsEojDv2cTGpmV
         oY/g==
X-Forwarded-Encrypted: i=1; AJvYcCXnSoA2fs8IY6vbukMzNOQe5KZW/8Jnx3e6Vnhu6YaFIBcZvQs9WN5gfIbAjbGibV5kA6NhGlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1U1ZronEIxUvEv9uqrfHnfmwRuVCEMRtrvxBLnIKyucqga/Qn
	suLeNHIOIUXp+OAXdbMRuiX2PuryumEmf2NpFwLgUPaNmEWefRBf7NQYan0RGrf3eYxZ0lbC9n0
	JpXgTrw==
X-Received: from plbkj6.prod.google.com ([2002:a17:903:6c6:b0:2a9:5e41:3b0a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d0f:b0:2a2:d2e7:1601
 with SMTP id d9443c01a7336-2a9519428c7mr68235285ad.48.1770505645223; Sat, 07
 Feb 2026 15:07:25 -0800 (PST)
Date: Sat,  7 Feb 2026 23:07:10 +0000
In-Reply-To: <20260207230720.2542943-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260207230720.2542943-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260207230720.2542943-2-kuniyu@google.com>
Subject: [PATCH v1 bpf 1/2] bpf: Reject access to unix_sk(sk)->peer.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257792-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.dev,fomichev.me,google.com,rbox.co,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rbox.co:email]
X-Rspamd-Queue-Id: 800C210763C
X-Rspamd-Action: no action

Michal Luczaj reported use-after-free of unix_sk(sk)->peer by
bpf_skc_to_unix_sock(). [0]

Accessing unix_sk(sk)->peer is safe only under unix_state_lock(),
but there are many functions where bpf prog can access the field
locklessly via fentry/fexit.

unix_dgram_connect() could clear unix_sk(sk)->peer and release
the last refcnt of the peer sk while a bpf prog is accessing it,
resulting in use-after-free.

Another problematic scenario is that unix_sk(sk)->peer could
go away while being passed to bpf_setsockopt() in bpf iter.

To avoid such issues, let's reject access to unix_sk(sk)->peer
by marking the pointer with PTR_UNTRUSTED.

If needed, we could add a new helper later that uses unix_peer_get()
and requires bpf_sk_release().

[0]:
BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
Read of size 2 at addr ffff888147d38890 by task test_progs/2495
Call Trace:
 dump_stack_lvl+0x5d/0x80
 print_report+0x170/0x4f3
 kasan_report+0xe1/0x180
 bpf_skc_to_unix_sock+0xa4/0xb0
 bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
 bpf_trampoline_6442564662+0x47/0xab
 unix_shutdown+0x9/0x880
 __sys_shutdown+0xe1/0x160
 __x64_sys_shutdown+0x52/0x90
 do_syscall_64+0x6b/0x3a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 9eeb3aa33ae0 ("bpf: Add bpf_skc_to_unix_sock() helper")
Reported-by: Michal Luczaj <mhal@rbox.co>
Closes: https://lore.kernel.org/all/408569e7-2b82-4eff-b767-79ce6ef6cae0@rbox.co/
Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 kernel/bpf/verifier.c                         | 18 +++++++++++++
 .../selftests/bpf/progs/verifier_sock.c       | 25 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3135643d5695..b328a1640c82 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7076,6 +7076,7 @@ static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
 #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __safe_rcu_or_null)
 #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_trusted)
 #define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__type, __safe_trusted_or_null)
+#define BTF_TYPE_SAFE_UNTRUSTED(__type)  __PASTE(__type, __safe_untrusted)
 
 /*
  * Allow list few fields as RCU trusted or full trusted.
@@ -7154,6 +7155,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
 	struct file *vm_file;
 };
 
+BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock) {
+	struct sock *peer;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -7201,6 +7206,16 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 					  "__safe_trusted_or_null");
 }
 
+static bool type_is_untrusted(struct bpf_verifier_env *env,
+			      struct bpf_reg_state *reg,
+			      const char *field_name, u32 btf_id)
+{
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock));
+
+	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
+					  "__safe_untrusted");
+}
+
 static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *regs,
 				   int regno, int off, int size,
@@ -7343,6 +7358,9 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	} else {
 		/* Old compat. Deprecated */
 		clear_trusted_flags(&flag);
+
+		if (type_is_untrusted(env, reg, field_name, btf_id))
+			flag |= PTR_UNTRUSTED;
 	}
 
 	if (atype == BPF_READ && value_regno >= 0) {
diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index a2132c72d3b8..8de4d3ed98d4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -3,6 +3,7 @@
 
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
 
 struct {
@@ -1166,4 +1167,28 @@ int invalidate_pkt_pointers_by_tail_call(struct __sk_buff *sk)
 	return TCX_PASS;
 }
 
+SEC("fentry/unix_dgram_sendmsg")
+__failure __msg("R1 type=untrusted_ptr_ expected=sock_common, sock, tcp_sock, xdp_sock, ptr_, trusted_ptr_")
+int BPF_PROG(trace_unix_dgram_sendmsg, struct socket *sock, struct msghdr *msg,
+	     size_t len)
+{
+	struct unix_sock *u, *u_other;
+
+	if (!sock)
+		return 0;
+
+	u = bpf_skc_to_unix_sock(sock->sk);
+	if (!u)
+		return 0;
+
+	/* unix_dgram_connect() could clear u->peer
+	 * and the peer could be freed.
+	 */
+	u_other = bpf_skc_to_unix_sock(u->peer);
+	if (!u_other)
+		return 0;
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0.rc2.204.g2597b5adb4-goog


