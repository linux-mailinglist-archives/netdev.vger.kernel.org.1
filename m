Return-Path: <netdev+bounces-158955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21340A13F46
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BFF4163193
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6468522CBDA;
	Thu, 16 Jan 2025 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSs8XMHB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D7E22B8BD
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044689; cv=none; b=hOWgG+8PQAysl9Vv3qd+/yMJcQXt+wLR8Oi3RMyAnHZxgWZX3do8hBRg0ya3h6teugTrydKUP1vlMg4sLU3HPO1p0xvDwa1M21bZUe2PDFCrQ6/CREPbCsi5wEl78y/F7ukkE4laqPRQLbRFupojZZD8QnlesYtrwDjFvXScIfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044689; c=relaxed/simple;
	bh=XI8wPbhtc9+CNenZCKwgymcwjp4BI2m19BV0+/pBKeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tDgGnLAbJ/FGUmumKbJe7sUOEP4vnvL2eIvUhaf5jwo/7QPPj+bPEniO1q46q+xY7OSX1MZ82vwUHDtv6+DGYarOE5BzQzk3BhQtKkaV9vTowngVkJDGixGsU326QlwwkHB8QzBoOtq7HJKHosYuVNEyFixGOe5Z3Al1pQ3jHlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RSs8XMHB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737044686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VPXvDT4dJ6cL5FU/96cNilUckLvKAmOMIGjX69ZK5Fg=;
	b=RSs8XMHBmirnb9vBKMHg2KKQZRWAUTnW4oQSRbs6nwDiDYKmcemf+IQtNUsdimzOfwp8il
	revm0zgbbqNo4XH4C3CQ1UZ0y6ESTV3087zIrL950kYUCfH2cflx58nAcn0Blb68NmSpbm
	0rXayaamEEm1QM1RY72K75IaYqYSI1U=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-OOkyWBUNOoeM8HTtUJeWuw-1; Thu, 16 Jan 2025 11:24:45 -0500
X-MC-Unique: OOkyWBUNOoeM8HTtUJeWuw-1
X-Mimecast-MFC-AGG-ID: OOkyWBUNOoeM8HTtUJeWuw
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-216387ddda8so24670475ad.3
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 08:24:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737044684; x=1737649484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPXvDT4dJ6cL5FU/96cNilUckLvKAmOMIGjX69ZK5Fg=;
        b=aZ1dhAkCZTWkQpoG/Aniqz5gZ4W20X9GSunP5qhcZnSzf8tgzZM2sIowXaOPxTGYWv
         PJHcwsxrAgElomU3y3N8fY9GfqJBqAsvwZnZdj6LwAJv9Wv8bN62IB3FkpbRQFw06CrV
         8O3oetb3yL7cAVW5mgenqc9lcmENIfay0BJaLxFYFfBr8Iq9Tc+lXZeGVjKvRHDKwTdD
         S6cOad3NFi2UO19lwuhPoT9J0hV9xfPFXWOkIxLOglqqIBekbq8Gunb/4XyBcwCumxMi
         +PQS9DzAp7hwR2YVly6FlIT3u2AH7T+qE/zwqOCYb4Y8rU7M/3mRJgPb1abSw9653H3u
         U8Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUlnu2K1qvnRkGTULoNqplVwtey1M0kMOW8ARYXcIQJXuuPttPalR9lwojTRMlyNvKgabOmzQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHb2YnKhvgvwVfwRVipJLOuPPvZ5TCBu5N16zzNoRZVb/C/lhp
	r4iG/c/2a+YprNLlyGtECb5XTyrTQV7HH2a0K/mhL4RZa4upxXwscTz7CkfKXTuw/PDxmdHzaNy
	F2KuGUhLul0KwDjMUBteb3mP1uriBOAYX8j3DJ7PXyT/33dA7z3Pv7Q==
X-Gm-Gg: ASbGncsKFFtmt3q9ZBNyPXqq5FyXBFvp8Cibae3CpysEGHky3u48yivhCpQzJE/k1nP
	agAiHjvqANhsCs62wnpBzeDkPsrNUp3k3YNH2cuqNeOSk1wIZXW5zBjSkjo6uBkGvpJAMcA6PMA
	lZL4orGeLwIHBOxA2SJTPU2cvMxGb5kfxhKiRBWOjjtjO60qALe6gT6umD75aXQ8bKEl6TCiOwk
	ao2Yi+maBWM90MqbtOc+44a8Spx0U6HSAQ/E8d1r73XTudbbpZaHSAw0KfSOnDZUIZ9VqTX7yCC
	uDREE72rtLF1
X-Received: by 2002:a17:902:d491:b0:215:54a1:8584 with SMTP id d9443c01a7336-21a83f4c070mr499559145ad.17.1737044684403;
        Thu, 16 Jan 2025 08:24:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyUbLUdMgg1c+CW6qpS6QMO3ywPJZ9HpadXLf470xOZzTswQX7dby0DqNdRKCsjvta9teINw==
X-Received: by 2002:a17:902:d491:b0:215:54a1:8584 with SMTP id d9443c01a7336-21a83f4c070mr499558685ad.17.1737044684017;
        Thu, 16 Jan 2025 08:24:44 -0800 (PST)
Received: from jkangas-thinkpadp1gen3.rmtuswa.csb ([2601:1c2:4301:5e20:98fe:4ecb:4f14:576b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3d7b0esm2142155ad.162.2025.01.16.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 08:24:43 -0800 (PST)
From: Jared Kangas <jkangas@redhat.com>
To: bpf@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	martin.lau@kernel.org,
	jkangas@redhat.com,
	ast@kernel.org,
	johannes.berg@intel.com,
	kafai@fb.com,
	songliubraving@fb.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: use attach_btf instead of vmlinux in bpf_sk_storage_tracing_allowed
Date: Thu, 16 Jan 2025 08:23:56 -0800
Message-ID: <20250116162356.1054047-1-jkangas@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When loading BPF programs, bpf_sk_storage_tracing_allowed() assumes that
the type is present in the vmlinux BTF. However, if a non-vmlinux kernel
BTF is attached to, this assumption is invalid and btf_type_by_id()
returns a null pointer. Proof-of-concept on a kernel with CONFIG_IPV6=m:

    $ cat bpfcrash.c
    #include <unistd.h>
    #include <linux/bpf.h>
    #include <sys/syscall.h>

    static int bpf(enum bpf_cmd cmd, union bpf_attr *attr)
    {
        return syscall(__NR_bpf, cmd, attr, sizeof(*attr));
    }

    int main(void)
    {
        const int btf_fd = bpf(BPF_BTF_GET_FD_BY_ID, &(union bpf_attr) {
            .btf_id = BTF_ID,
        });
        if (btf_fd < 0)
            return 1;

        const int bpf_sk_storage_get = 107;
        const struct bpf_insn insns[] = {
            { .code = BPF_JMP | BPF_CALL, .imm = bpf_sk_storage_get},
            { .code = BPF_JMP | BPF_EXIT },
        };
        return bpf(BPF_PROG_LOAD, &(union bpf_attr) {
            .prog_type            = BPF_PROG_TYPE_TRACING,
            .expected_attach_type = BPF_TRACE_FENTRY,
            .license              = (unsigned long)"GPL",
            .insns                = (unsigned long)&insns,
            .insn_cnt             = sizeof(insns) / sizeof(insns[0]),
            .attach_btf_obj_fd    = btf_fd,
            .attach_btf_id        = TYPE_ID,
        });
    }
    $ sudo bpftool btf list | grep ipv6
    2: name [ipv6]  size 928200B
    $ sudo bpftool btf dump id 2 | awk '$3 ~ /inet6_sock_destruct/'
    [130689] FUNC 'inet6_sock_destruct' type_id=130677 linkage=static
    $ gcc -D_DEFAULT_SOURCE -DBTF_ID=2 -DTYPE_ID=130689 \
        bpfcrash.c -o bpfcrash
    $ sudo ./bpfcrash

This results in a null pointer dereference:

    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
    Call trace:
     bpf_sk_storage_tracing_allowed+0x8c/0xb0 P
     check_helper_call.isra.0+0xa8/0x1730
     do_check+0xa18/0xb40
     do_check_common+0x140/0x640
     bpf_check+0xb74/0xcb8
     bpf_prog_load+0x598/0x9a8
     __sys_bpf+0x580/0x980
     __arm64_sys_bpf+0x28/0x40
     invoke_syscall.constprop.0+0x54/0xe8
     do_el0_svc+0xb4/0xd0
     el0_svc+0x44/0x1f8
     el0t_64_sync_handler+0x13c/0x160
     el0t_64_sync+0x184/0x188

To get the proper type, use prog->aux->attach_btf instead of assuming
the type is in vmlinux.

Fixes: 8e4597c627fb ("bpf: Allow using bpf_sk_storage in FENTRY/FEXIT/RAW_TP")
Signed-off-by: Jared Kangas <jkangas@redhat.com>
---
 net/core/bpf_sk_storage.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 2f4ed83a75ae..74584dd12550 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -352,8 +352,8 @@ const struct bpf_func_proto bpf_sk_storage_delete_proto = {
 
 static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 {
-	const struct btf *btf_vmlinux;
 	const struct btf_type *t;
+	const struct btf *btf;
 	const char *tname;
 	u32 btf_id;
 
@@ -371,12 +371,12 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 		return true;
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
-		btf_vmlinux = bpf_get_btf_vmlinux();
-		if (IS_ERR_OR_NULL(btf_vmlinux))
+		btf = prog->aux->attach_btf;
+		if (!btf)
 			return false;
 		btf_id = prog->aux->attach_btf_id;
-		t = btf_type_by_id(btf_vmlinux, btf_id);
-		tname = btf_name_by_offset(btf_vmlinux, t->name_off);
+		t = btf_type_by_id(btf, btf_id);
+		tname = btf_name_by_offset(btf, t->name_off);
 		return !!strncmp(tname, "bpf_sk_storage",
 				 strlen("bpf_sk_storage"));
 	default:
-- 
2.47.1


