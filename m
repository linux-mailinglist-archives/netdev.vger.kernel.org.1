Return-Path: <netdev+bounces-246470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBC4CECAA9
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 00:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8568F30109B3
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 23:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B372D47F3;
	Wed, 31 Dec 2025 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5ua38zc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416D527C84B
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767223261; cv=none; b=AeM6h42qan41HpFceGMmrydXVr7geXBv526PoifoqXqPLuypy1XF2V2fcyveNITviM62oPs6PgxCWe/8m7mW+itwYlzXAZZKrR7f5btygh7aY/xBS+5JTa54AXamDrQyeQIvVk2E604wkKdoZRJMCi+3hCMwWGVm/ELDIh49S0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767223261; c=relaxed/simple;
	bh=QbQeTPKkvqwDTi9jphXlB0QOUtZZZiT4Q18MidmASV8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GIuURj+HW60k77/7oBZ23Rv+z8BvA8cdrBwXQjlzWlocVxeeqiYoutvU4gCYyxmqxk41Ptn3iPepnRZ7bVxxAcbDZJu+S9LC8TT7z2M5jneI2SM2MsXF7il44HZFkWVJhlq8xSv4FZ83VScULZUeOoNMQbSLL8NahycpyY50ndQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V5ua38zc; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maze.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b993eb2701bso11346751a12.0
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 15:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767223259; x=1767828059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Fkw4pJwbf+RiOcgktvh2leaGPbqkfTxYnH0P1Ik49Q=;
        b=V5ua38zcVzyEbjtiknV/tnbR2joQ4EIFPjYyQ98e0A4d2jNRaHHVOA6mlq+eKw5ndl
         skhJVQZpGE3VcVjPiBMJEC0gHBGtLYxODPq6zyECUdbL1X4cUl6E60FeR8YtauHFNE/8
         w6eAs2+XZPoFOu/t7TtONN47pW2wkU1alLOEcn+AzhwbuH1FN+X2wP1i+7f+IyJ1LI37
         b7O2Kqo1A//JlXsigmb1jTZh0dTDXmMUEUw093J8XttO7IMIKhtW4c0GLtkogcFmoN3O
         QJ2TU8sS0RghBF7tIujBQ0sjx9UDQ2y4nyv85Es3utUo3TFR38P29ju9b/QSq2G9WQZK
         0p2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767223259; x=1767828059;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Fkw4pJwbf+RiOcgktvh2leaGPbqkfTxYnH0P1Ik49Q=;
        b=xPuRC4iJT/9sjNlxAtrfAxwSySwLRNscD1+wZ4vsUJj5tDNVtta3NGUNlunU/K97Kk
         vzo9tdhDS2rMtbUQa+sA1JZiLQVnwKjAqK4KLNk1e76ceFTyqDknbFE/OIKr/IaYhp86
         QqBXZTa/GBEE1utx1EwcoqUacnN++LQ6H2ScdDz2cf/j3gC2xcFn7t3If/Lww7Z6LfC0
         QHLiVXPlpYDasDc/CwmNujJfuUQrGC6yUQ9BnvSObgDsviuo8eeR6t1K4qWo17+taR0l
         9JMUvlIHqkGxtw71m+SupigGJFyV3iE0PgA9pEr+hbALrIKsfmoDzI8Whdeo+adiM8V1
         kbbA==
X-Gm-Message-State: AOJu0YzTnv2Ogbmm+P6H7S1XKUhFmNcGk7X6YzNfRl6/sK6eJh2kU7S/
	1nWH+NgiSv6MrAageDwCqTyuFLcEp8XRPkbQSNobOfu40Yn4+fSv08O5KQMU1faUZ1WbdPAQIg=
	=
X-Google-Smtp-Source: AGHT+IGQ1Yo74Lfs+XDagvF/do2RICQ0VFYGB7N4aHuu3r4sO5GbnwTUXgQ19dSEciYhPBpJEkJa6lWY
X-Received: from dlbsi4.prod.google.com ([2002:a05:7022:b884:b0:119:9f33:34a6])
 (user=maze job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f401:b0:119:fb9c:4ebb
 with SMTP id a92af1059eb24-121722ebbafmr31057680c88.30.1767223259510; Wed, 31
 Dec 2025 15:20:59 -0800 (PST)
Date: Wed, 31 Dec 2025 15:20:48 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.394.g0814c687bb-goog
Message-ID: <20251231232048.2860014-1-maze@google.com>
Subject: [PATCH bpf] bpf: 'fix' for undefined future potential exploits of BPF_PROG_LOAD
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Over the years there's been a number of issues with the eBPF
verifier/jit/codegen (incl. both code bugs & spectre related stuff).

It's an amazing but very complex piece of logic, and I don't think
it's realistic to expect it to ever be (or become) 100% secure.

For example we currently have KASAN reporting buffer length violation
issues on 6.18 (which may or may not be due to eBPF subsystem, but are
worrying none-the-less)

Blocking bpf(BPF_PROG_LOAD, ...) is the only sure fire way to guarantee
the inability to exploit the eBPF subsystem.
In comparison other eBPF operations are pretty benign.
Even map creation is usually at most a memory DoS, furthermore it
remains useful (even with prog load disabled) due to inner maps.

This new sysctl is designed primarily for verified boot systems,
where (while the system is booting from trusted/signed media)
BPF_PROG_LOAD can be enabled, but before untrusted user
media is mounted or networking is enabled, BPF_PROG_LOAD
can be outright disabled.

This provides for a very simple way to limit eBPF programs to only
those signed programs that are part of the verified boot chain,
which has always been a requirement of eBPF use in Android.

I can think of two other ways to accomplish this:
(a) via sepolicy with booleans, but it ends up being pretty complex
    (especially wrt verifying the correctness of the resulting policies)
(b) via BPF_LSM bpf_prog_load hook, which requires enabling additional
    kernel options which aren't necessarily worth the bother,
    and requires dynamically patching the kernel (frowned upon by
    security folks).

This approach appears to simply be the most trivial.

I've chosed to return EUNATCH 'Protocol driver not attached.'
to separate it from EPERM and make it clear the eBPF program loading
subsystem has been outright disabled (detached).  There aren't
any permissions you could gain to make things work again (short
of a reboot/kexec).

It is intentionally kernel global and doesn't affect cBPF,
which has various runtime use cases (incl. tcpdump style dynamic
socket filters and seccomp sandboxing) and thus cannot be disabled,
but (as experience shows) is also much less dangerous (mainly due
to being much simpler).

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |  9 +++++++++
 kernel/bpf/syscall.c                        | 14 ++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/ad=
min-guide/sysctl/kernel.rst
index f3ee807b5d8b..4906ef08c741 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1655,6 +1655,15 @@ entry will default to 2 instead of 0.
 =3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
+disable_bpf_prog_load
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Writing 1 to this entry will cause all future invocations of
+``bpf(BPF_PROG_LOAD, ...)`` to fail with -EUNATCH, thus effectively
+permanently disabling the instantiation of new eBPF programs.
+Once set to 1, this cannot be reset back to 0.
+
+
 warn_limit
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6589acc89ef8..ef655ff501e7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -67,6 +67,8 @@ static DEFINE_SPINLOCK(link_idr_lock);
 int sysctl_unprivileged_bpf_disabled __read_mostly =3D
 	IS_BUILTIN(CONFIG_BPF_UNPRIV_DEFAULT_OFF) ? 2 : 0;
=20
+int sysctl_disable_bpf_prog_load =3D 0;
+
 static const struct bpf_map_ops * const bpf_map_types[] =3D {
 #define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type)
 #define BPF_MAP_TYPE(_id, _ops) \
@@ -2891,6 +2893,9 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr=
_t uattr, u32 uattr_size)
 				 BPF_F_TOKEN_FD))
 		return -EINVAL;
=20
+	if (sysctl_disable_bpf_prog_load)
+		return -EUNATCH;
+
 	bpf_prog_load_fixup_attach_type(attr);
=20
 	if (attr->prog_flags & BPF_F_TOKEN_FD) {
@@ -6511,6 +6516,15 @@ static const struct ctl_table bpf_syscall_table[] =
=3D {
 		.extra1		=3D SYSCTL_ZERO,
 		.extra2		=3D SYSCTL_TWO,
 	},
+	{
+		.procname	=3D "disable_bpf_prog_load",
+		.data		=3D &sysctl_disable_bpf_prog_load,
+		.maxlen		=3D sizeof(sysctl_disable_bpf_prog_load),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_dointvec_minmax,
+		.extra1		=3D SYSCTL_ONE,
+		.extra2		=3D SYSCTL_ONE,
+	},
 	{
 		.procname	=3D "bpf_stats_enabled",
 		.data		=3D &bpf_stats_enabled_key.key,
--=20
2.52.0.394.g0814c687bb-goog


