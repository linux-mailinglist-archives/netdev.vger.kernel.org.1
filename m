Return-Path: <netdev+bounces-87481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54528A3415
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 18:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C11F1C22C40
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 16:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE7514B097;
	Fri, 12 Apr 2024 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OPDcFsFC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87914BF98
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712940770; cv=none; b=LpEbjMFc+OogXP6yuNKfjnm2obIhLiSH6CmcL7PJWtnMnxmmPe0zIs/9XrQMquBg1XXRHaqjpx1+ZDXy/HYvANLfEd0CP/NZXDASDX8A0ZBlZtdAEIEkkLn4chkJTSDMN3uAwgxkXLS5TBU7DvHXwlQO8yAeREDhyjFfbyWa1gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712940770; c=relaxed/simple;
	bh=4ysUujkhmWpniBw5497xDCByIggQ2+aGhR+vSt9krfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nhUGYMTzIzCY8VmultF9hqgb9wE9Rk/IjOqtszE7rhu1Vyzu8df4uH/y7aXAOAlvEPgTlsq73NMwTQtupOBXAzy7hiw5tsLokQS2j/pPOsqyqyACr4O5uTfPmxHDavhITPF+mMEgqMgxolBxBghhHIeTCi1006/P3AsvEQZtNzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OPDcFsFC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64f63d768so1961112276.2
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 09:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712940768; x=1713545568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qrm0IPGHpUgLnmwZ4xUH2dS9N0r0jHRYc5VqLEJGVMg=;
        b=OPDcFsFCfrVJ8hsCEXQulrKseMhaDD4m6Je4M32tv3NfJ/IQe1H/gDQaRUmog6fowk
         eevFsaV906mnrxkJwqjvQwYXIss4mbuhSSoI8NDMCG2fUssdtN8NxmjbiSVHhD1DM0nw
         v7k4cHocJ59XwrhSeQIvz5ugY6X4NdxFtGWJgtrWUrXffbvLllNjRt2K14kRxCcTRceJ
         tFAxI0VC5yoCqL4by+kXkmr2Ga88BPJmihog8L/8Qz4IAbV2mj0kb8TGqauc8zqwbRbx
         jxMDDsstWlNByr+sXxW1rYIJqQIFjZWSa83zKs9ygX9lhTtRdBs/Oa470p133/gxW9U6
         oVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712940768; x=1713545568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qrm0IPGHpUgLnmwZ4xUH2dS9N0r0jHRYc5VqLEJGVMg=;
        b=Hr4B1yrCoz9ceJx9IjMwBLW/cwXl8bs/JS73ZFHGAN9g40XoMswwuxut2QI3uBj2K1
         cMnRRLj/Rh3BFjZyggl1R48QWWtmUupc5VSoqKjzYaqQQR+SiXHuEa7OpNGvIKfiu3nA
         pyBmfqvfogXirLaF8h4i8V4i9LrmthfRa9jRUY6orI2zlAo2CegxfzZsbc0izleMl6W/
         JLBcskrzbZAcqQkeVOkIaDSVuhoHOBYdKGc2ecoO8+t7j+RmcOFLASo+1rryiHbgf5/L
         Lcv9e5Yk7oqagmjZml6wjpGjGwpOVr7+A63u0opVzeVGNPYk5U136UEhKmTbF6agvL65
         LuuQ==
X-Forwarded-Encrypted: i=1; AJvYcCURZAPieRcLSriaXRbZoKBNzxLOvXuQJu2nzSqSxfs6R6NBgcxMbnOAFJ/Sr0RFe19FqKp4BNLA3eN8m9aNB85Gc+jMDZFc
X-Gm-Message-State: AOJu0YwTp3rUIYb+6L1W7WWDt1xVSOEpGTcQdm+P5GBWNPMVrzaoAa1M
	DrnsDRdsKNExylS2xsdbxEOAWB19f6yCjyE0nBIuo962smLw4Z3p0VGNmkcXvbJn7EIb1BoYLA=
	=
X-Google-Smtp-Source: AGHT+IEvLXnUt1tDwR52cd2+PIzNCWsXEcc1PXHoC05DOnfM3doMKPwnA9b8H+lG2YivsGOn76jmhCohBw==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a25:8d83:0:b0:dd9:1dc0:b6c5 with SMTP id
 o3-20020a258d83000000b00dd91dc0b6c5mr812753ybl.6.1712940768309; Fri, 12 Apr
 2024 09:52:48 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:52:23 -0500
In-Reply-To: <20240412165230.2009746-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240412165230.2009746-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240412165230.2009746-3-jrife@google.com>
Subject: [PATCH v2 bpf-next 2/6] selftests/bpf: Implement socket kfuncs for bpf_testmod
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Artem Savkov <asavkov@redhat.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This patch adds a set of kfuncs to bpf_testmod that can be used to
manipulate a socket from kernel space.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 139 ++++++++++++++++++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  27 ++++
 2 files changed, 166 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 39ad96a18123f..663df8148097e 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -10,18 +10,29 @@
 #include <linux/percpu-defs.h>
 #include <linux/sysfs.h>
 #include <linux/tracepoint.h>
+#include <linux/net.h>
+#include <linux/socket.h>
+#include <linux/nsproxy.h>
+#include <linux/inet.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/un.h>
+#include <net/sock.h>
 #include "bpf_testmod.h"
 #include "bpf_testmod_kfunc.h"
 
 #define CREATE_TRACE_POINTS
 #include "bpf_testmod-events.h"
 
+#define CONNECT_TIMEOUT_SEC 1
+
 typedef int (*func_proto_typedef)(long);
 typedef int (*func_proto_typedef_nested1)(func_proto_typedef);
 typedef int (*func_proto_typedef_nested2)(func_proto_typedef_nested1);
 
 DEFINE_PER_CPU(int, bpf_testmod_ksym_percpu) = 123;
 long bpf_testmod_test_struct_arg_result;
+static struct socket *sock;
 
 struct bpf_testmod_struct_arg_1 {
 	int a;
@@ -494,6 +505,124 @@ __bpf_kfunc static u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused
 	return arg;
 }
 
+__bpf_kfunc int bpf_kfunc_init_sock(struct init_sock_args *args)
+{
+	int proto;
+
+	if (sock)
+		pr_warn("%s called without releasing old sock", __func__);
+
+	switch (args->af) {
+	case AF_INET:
+	case AF_INET6:
+		proto = args->type == SOCK_STREAM ? IPPROTO_TCP : IPPROTO_UDP;
+		break;
+	case AF_UNIX:
+		proto = PF_UNIX;
+		break;
+	default:
+		pr_err("invalid address family %d\n", args->af);
+		return -EINVAL;
+	}
+
+	return sock_create_kern(&init_net, args->af, args->type, proto, &sock);
+}
+
+__bpf_kfunc void bpf_kfunc_close_sock(void)
+{
+	if (sock) {
+		sock_release(sock);
+		sock = NULL;
+	}
+}
+
+__bpf_kfunc int bpf_kfunc_call_kernel_connect(struct addr_args *args)
+{
+	/* Set timeout for call to kernel_connect() to prevent it from hanging,
+	 * and consider the connection attempt failed if it returns
+	 * -EINPROGRESS.
+	 */
+	sock->sk->sk_sndtimeo = CONNECT_TIMEOUT_SEC * HZ;
+
+	return kernel_connect(sock, (struct sockaddr *)&args->addr,
+			      args->addrlen, 0);
+}
+
+__bpf_kfunc int bpf_kfunc_call_kernel_bind(struct addr_args *args)
+{
+	return kernel_bind(sock, (struct sockaddr *)&args->addr, args->addrlen);
+}
+
+__bpf_kfunc int bpf_kfunc_call_kernel_listen(void)
+{
+	return kernel_listen(sock, 128);
+}
+
+__bpf_kfunc int bpf_kfunc_call_kernel_sendmsg(struct sendmsg_args *args)
+{
+	struct msghdr msg = {
+		.msg_name	= &args->addr.addr,
+		.msg_namelen	= args->addr.addrlen,
+	};
+	struct kvec iov;
+	int err;
+
+	iov.iov_base = args->msg;
+	iov.iov_len  = args->msglen;
+
+	err = kernel_sendmsg(sock, &msg, &iov, 1, args->msglen);
+	args->addr.addrlen = msg.msg_namelen;
+
+	return err;
+}
+
+__bpf_kfunc int bpf_kfunc_call_sock_sendmsg(struct sendmsg_args *args)
+{
+	struct msghdr msg = {
+		.msg_name	= &args->addr.addr,
+		.msg_namelen	= args->addr.addrlen,
+	};
+	struct kvec iov;
+	int err;
+
+	iov.iov_base = args->msg;
+	iov.iov_len  = args->msglen;
+
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, args->msglen);
+	err = sock_sendmsg(sock, &msg);
+	args->addr.addrlen = msg.msg_namelen;
+
+	return err;
+}
+
+__bpf_kfunc int bpf_kfunc_call_kernel_getsockname(struct addr_args *args)
+{
+	int err;
+
+	err = kernel_getsockname(sock, (struct sockaddr *)&args->addr);
+	if (err < 0)
+		goto out;
+
+	args->addrlen = err;
+	err = 0;
+out:
+	return err;
+}
+
+__bpf_kfunc int bpf_kfunc_call_kernel_getpeername(struct addr_args *args)
+{
+	int err;
+
+	err = kernel_getpeername(sock, (struct sockaddr *)&args->addr);
+	if (err < 0)
+		goto out;
+
+	args->addrlen = err;
+	err = 0;
+out:
+	return err;
+}
+
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
@@ -520,6 +649,15 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
+BTF_ID_FLAGS(func, bpf_kfunc_init_sock)
+BTF_ID_FLAGS(func, bpf_kfunc_close_sock)
+BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_connect)
+BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_bind)
+BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_listen)
+BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_sendmsg)
+BTF_ID_FLAGS(func, bpf_kfunc_call_sock_sendmsg)
+BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getsockname)
+BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getpeername)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
@@ -650,6 +788,7 @@ static int bpf_testmod_init(void)
 		return ret;
 	if (bpf_fentry_test1(0) < 0)
 		return -EINVAL;
+	sock = NULL;
 	return sysfs_create_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
 }
 
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index 7c664dd610597..cdf7769a7d8ca 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -64,6 +64,22 @@ struct prog_test_fail3 {
 	char arr2[];
 };
 
+struct init_sock_args {
+	int af;
+	int type;
+};
+
+struct addr_args {
+	char addr[sizeof(struct __kernel_sockaddr_storage)];
+	int addrlen;
+};
+
+struct sendmsg_args {
+	struct addr_args addr;
+	char msg[10];
+	int msglen;
+};
+
 struct prog_test_ref_kfunc *
 bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr) __ksym;
 void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
@@ -106,4 +122,15 @@ void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p);
 void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len);
 
 void bpf_kfunc_common_test(void) __ksym;
+
+int bpf_kfunc_init_sock(struct init_sock_args *args) __ksym;
+void bpf_kfunc_close_sock(void) __ksym;
+int bpf_kfunc_call_kernel_connect(struct addr_args *args) __ksym;
+int bpf_kfunc_call_kernel_bind(struct addr_args *args) __ksym;
+int bpf_kfunc_call_kernel_listen(void) __ksym;
+int bpf_kfunc_call_kernel_sendmsg(struct sendmsg_args *args) __ksym;
+int bpf_kfunc_call_sock_sendmsg(struct sendmsg_args *args) __ksym;
+int bpf_kfunc_call_kernel_getsockname(struct addr_args *args) __ksym;
+int bpf_kfunc_call_kernel_getpeername(struct addr_args *args) __ksym;
+
 #endif /* _BPF_TESTMOD_KFUNC_H */
-- 
2.44.0.478.gd926399ef9-goog


