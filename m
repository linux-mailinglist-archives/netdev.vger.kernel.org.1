Return-Path: <netdev+bounces-92265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590AE8B64D2
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 23:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1505C2815BB
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 21:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D341190674;
	Mon, 29 Apr 2024 21:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LOEwglY+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4E619066F
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427144; cv=none; b=LbBOD03OPfzPC3VhuOXDutMqsaFWfsUtbOsdbG6MV4BaNW4BoQj6zGNpyfW+6+AJt5v7uF2eFsRc8H/u6dvVuv9P5tZgyAVdrouDtbir12sAGDU01VaMYug/8csZJcjjs3KLgyqktuySLbPbnauFYL3kX1iAV9OrJ/OuFBUpCpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427144; c=relaxed/simple;
	bh=8ypncdYcfhHsdlMrqbyapwo4Pvkh7l2XnqBx6SFPA5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XQdu99cKNKE357mO5igEWnQY/mPfNEw96oaS2HyY2RTA5sKOj7zF8hZKUaHug7Gxct4mr9laIfpT9+MomFwVwOAcwwvoBKGImIlhwOx/cgn1HRQkVpV2kxh+SLdacQfV+9xuZ6z48PTi/NJe9Qe6wmauP+hJ3LDxR6bMWWXnnKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LOEwglY+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b330409b7so91282827b3.0
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 14:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714427142; x=1715031942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRW3v1PsNRuBnsLckz6xpTxguyKGBJkvg2o2SpGBrTI=;
        b=LOEwglY+7sStM2kajtM1MZ0nndP6GhBSFGOjMMXbrf1pr4s68HxJQJF4FSrnASwv5D
         9uW2+G3jgfOJ/tk7hhw03kcu9ppbCMw/Ir9v6WyhjToCW8KrYiTVYGPC7Y5Dt34us/2K
         ZkTR+BEybP/eQZQcDz+YbRhhXJf/U7Op1AU0OhBqA1vW6nrJKxknFn7Boq8bVFLU5qYn
         L+F8I+XinInt08fTHlOUcDbQLUjRG81+SWIr2RkHsEVTe3zFq1/KVv8Yu98jJeG2zvZb
         zkKo8nbedBYgNdn7EdQptYCf7M9AdHKeaSLqtpGU3wEFb07hpyS/nWyun1BEI6PFqMys
         mg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714427142; x=1715031942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRW3v1PsNRuBnsLckz6xpTxguyKGBJkvg2o2SpGBrTI=;
        b=D8DVqk0FgEfN4PlW2uzeuJXLg1B1qVqi9wqa+WcEJ3OhBxfBR0u4Wd3qovFlqMVnmf
         7/HjWS5Ba6czQWGjqSYKiGpBo0s1SMKatahR1Fs9C2BAMa2T/a7tEm7iIfcJd+AvYSA7
         z6OT/u5NiRVKVsbQvtOOT4z8OyeLVMGqJFjde7vL6LiwAUJwxTTqYkM3HJGviOcDkhi6
         pbH/IWQsvEWXx6O4pDTrtV1n0SlRg/eKQMBmXplI1fNWbRMou082OP5Xu38msFWbsHRa
         LM/gxs5xVjXpqrJMr5QdZg+xXokJWumxmyyJWxaSMd2qe5iL/XBEW2bi4cwofnfJJUvd
         sdnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdjIKElkZ9XoZeXvNgvtFNCSFmK1lYx/r61j3SL0Wp47qf/tYcJMKkeBoR529vkDnEoD84rrqWVfBjDD0p1V/psX/puslP
X-Gm-Message-State: AOJu0YwBPbyNQoehXOFYsS6nFEetjraoZFXwJmSNyxbxKZSvSKKPs2wM
	+pa1N7g/xmY0MM3UOX7yk2zpum+A8CJZB2MkYfnYjwM7JaB+p5scxUOoPoJM7JALY6JfDyShjw=
	=
X-Google-Smtp-Source: AGHT+IECbatiFUlb2eIbvH1htrCqD5HxfKjjrK7ixQ6M4nuq9O5N3VH6Uk7qA01ceWsXbMhKDagouQXkRw==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:690c:8:b0:614:f416:9415 with SMTP id
 bc8-20020a05690c000800b00614f4169415mr3659690ywb.7.1714427141914; Mon, 29 Apr
 2024 14:45:41 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:45:20 -0500
In-Reply-To: <20240429214529.2644801-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429214529.2644801-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429214529.2644801-4-jrife@google.com>
Subject: [PATCH v3 bpf-next 3/6] selftests/bpf: Implement BPF programs for
 kernel socket operations
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
	Benjamin Tissoires <bentiss@kernel.org>, Hou Tao <houtao1@huawei.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This patch lays out a set of SYSCALL programs that can be used to invoke
the socket operation kfuncs in bpf_testmod, allowing a test program to
manipulate kernel socket operations from userspace.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/progs/sock_addr_kern.c      | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/sock_addr_kern.c

diff --git a/tools/testing/selftests/bpf/progs/sock_addr_kern.c b/tools/testing/selftests/bpf/progs/sock_addr_kern.c
new file mode 100644
index 0000000000000..8386bb15ccdc1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sock_addr_kern.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+
+SEC("syscall")
+int init_sock(struct init_sock_args *args)
+{
+	bpf_kfunc_init_sock(args);
+
+	return 0;
+}
+
+SEC("syscall")
+int close_sock(void *ctx)
+{
+	bpf_kfunc_close_sock();
+
+	return 0;
+}
+
+SEC("syscall")
+int kernel_connect(struct addr_args *args)
+{
+	return bpf_kfunc_call_kernel_connect(args);
+}
+
+SEC("syscall")
+int kernel_bind(struct addr_args *args)
+{
+	return bpf_kfunc_call_kernel_bind(args);
+}
+
+SEC("syscall")
+int kernel_listen(struct addr_args *args)
+{
+	return bpf_kfunc_call_kernel_listen();
+}
+
+SEC("syscall")
+int kernel_sendmsg(struct sendmsg_args *args)
+{
+	return bpf_kfunc_call_kernel_sendmsg(args);
+}
+
+SEC("syscall")
+int sock_sendmsg(struct sendmsg_args *args)
+{
+	return bpf_kfunc_call_sock_sendmsg(args);
+}
+
+SEC("syscall")
+int kernel_getsockname(struct addr_args *args)
+{
+	return bpf_kfunc_call_kernel_getsockname(args);
+}
+
+SEC("syscall")
+int kernel_getpeername(struct addr_args *args)
+{
+	return bpf_kfunc_call_kernel_getpeername(args);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.44.0.769.g3c40516874-goog


