Return-Path: <netdev+bounces-227902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0951BBBD15C
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 07:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 253EF3450BB
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 05:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC32C248891;
	Mon,  6 Oct 2025 05:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ut29Izpw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386681A9F80
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 05:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759729411; cv=none; b=JPdfJD22nWKNRp+mVIVVr7cPnkVnMqSScVfw4udWKUgNU9bGHg/Y7qeQTPU8wvXyySm4F1a/DIb20oa6uUeX6zP+KJwABnNuQnPrimozFz+dPU+Bk3NfqUxwqpnkq4FRpUF0jp5PwIecCutejiqOWn21vAZPj7w5IDAr+SYyh6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759729411; c=relaxed/simple;
	bh=RE+zGZ8yF4o1w8jWuzVSUSVxDNM3CJztkem+rcfkWWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i05VUJPypvwQ5oK9TCvD0khQDkDxaFDU0dQ/GdnYKmkv5e6FWYGJWMvt+YPNr+dRpTuK1GvlqekL3eWJh7lyTos5xobvtahYRt0EPVoQHKgLjn46uMWaoK80+m3Aq/qOtrg8DJczZiVoR6AaGatqhUV3X245M9tKrYhMlUsDsk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ut29Izpw; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-269639879c3so41648995ad.2
        for <netdev@vger.kernel.org>; Sun, 05 Oct 2025 22:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759729409; x=1760334209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UeAUDJn0BeGNQx3vn077OGP4xs5barO9XuqG13SWPJU=;
        b=Ut29IzpwbyB3AnjvP2qVIJ0/q4dqUGJL1md0vwMxedDAkrjOnEbwQg84xBD3tRGWUh
         exinCSEajTz7Ham1ToXtgS0y1939/95+GAIpjg9gPHvnWcEdTjE3N4tej6Dp+O470yBP
         GcONRIeitkhdPIuATeXN8rRfKFA+XsuRaS3clXxfELOUSmNk88w9Gh0dzZQsyyDs3mTw
         6MAo6+YKyT9dAaLGiWIkiLIV0jxNLW4ZVDLIt2+mWenKqGDp81/hYpopAxgyZq7clUZY
         Hd6fW5zVQRq++pPjh+mCfBaVrzgwoTRe0rJ8IU/zdkil6wJHUlv4j0XyzdUE9DY2pjv5
         S+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759729409; x=1760334209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UeAUDJn0BeGNQx3vn077OGP4xs5barO9XuqG13SWPJU=;
        b=CabYoNschNXQlSNXXIubcviVDk3FNEWCBkgY41fTeGa9KhSVHIQa8pV/LTRaOqMj1F
         k3Dydikot4hT5kEqlNBrD2iH4w5LXeXeIxurVh4R+Oil9jPcPWlsgRcPqEmwuS9Qy/Re
         3WHLtS7eMRSTzayQucmIv+EZFFbpawS7CAiE5xvVFNotbe6Z4mS4QXeIjwO/KXdtQOdo
         x9Th6bCGevC53pbgtF12UWpngtzrebJbkWo0vHbroO80hSAy9bP5+S5nof3hLlogwj5r
         0YnlSCV9t6JRCWVBiZK3iY3lQmfdvdQ9skTGpi+M3AsyRUkI7IM5GStIyBUy7J0uVMiH
         0NfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtUwWuOUg31rAGpZOz81qqYZCxw62Ej5NxMA9KI4O6OT6cB4egsTe05TqL7KBI/7Td7cpudSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI57lCACSaaBH1ScHO/f0EqqaUuFixm7FqfNuHOZKvWoSfcULN
	KUy7WL10hUYna9eiAyj/FSmgqOKZg/vhRrmfxFLrHhe7GnszLY7MgZYv
X-Gm-Gg: ASbGnct3t4E4GrQDk9+vJdA2/xj4BpK2kzAQ6Kgjdngzsl7eNz/qAHsqNsx3YkTisVg
	n95bLVZTis+UIocOk23cM0tc0lwS75+JUM5/mQgJuVnNGX7r8/8I/5BO+TtEiZ9EminnVFpNwLc
	dJmvuNGPukSJtz9cxdjD0JBy7ooih8hpOsuRgeJhA++uBTxN3786Mb6YdxrSQfHZueC6XyY52yw
	BbeSy1o6Q0Gtd5yi289I3ha1JdymOLIusW+mbRb/fJJP5VZhj85JXQYO9m7P3PRBEIztT9xN0dM
	jbc8O0Uhgt7E/FvvyvAChr+l1eXkGzprwOsnaJg4/MkeWuo62+6QV/hdRAXlf08qi4QtvRXUVXH
	KOgNImu/lYhcUb5LbBQ8WmmBJd0vf+H96XG0dvDkQPZtc5kIFTzPIkcGxZShNP+Au/cRCVErQdf
	NrowcKEkQALn4QmGhwp0QhMC0=
X-Google-Smtp-Source: AGHT+IEgWCXbq557PGaex/0bq+zmROsO2U11LOaA2gdlP8UhSWMYUL72C92P/f2n/UgOF18aD+TRlw==
X-Received: by 2002:a17:903:2c10:b0:265:89c:251b with SMTP id d9443c01a7336-28e9a68fdfdmr122698305ad.29.1759729409388;
        Sun, 05 Oct 2025 22:43:29 -0700 (PDT)
Received: from chandna.localdomain ([182.77.76.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d125ed2sm119549815ad.35.2025.10.05.22.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 22:43:28 -0700 (PDT)
From: Sahil Chandna <chandna.linuxkernel@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	Sahil Chandna <chandna.linuxkernel@gmail.com>,
	syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Subject: [PATCH] bpf: test_run: Fix timer mode initialization to NO_MIGRATE mode
Date: Mon,  6 Oct 2025 11:13:20 +0530
Message-ID: <20251006054320.159321-1-chandna.linuxkernel@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default, the timer mode is being initialized to `NO_PREEMPT`.
This disables preemption and forces execution in atomic context.
This can cause issue with PREEMPT_RT when calling spin_lock_bh() due
to sleeping nature of the lock.
...
BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6107, name: syz.0.17
preempt_count: 1, expected: 0
RCU nest depth: 1, expected: 1
Preemption disabled at:
[<ffffffff891fce58>] bpf_test_timer_enter+0xf8/0x140 net/bpf/test_run.c:42
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x44b/0x5d0 kernel/sched/core.c:8957
 __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
 rt_spin_lock+0xc7/0x2c0 kernel/locking/spinlock_rt.c:57
 spin_lock_bh include/linux/spinlock_rt.h:88 [inline]
 __sock_map_delete net/core/sock_map.c:421 [inline]
 sock_map_delete_elem+0xb7/0x170 net/core/sock_map.c:452
 bpf_prog_2c29ac5cdc6b1842+0x43/0x4b
 bpf_dispatcher_nop_func include/linux/bpf.h:1332 [inline]
...
Change initialization to NO_MIGRATE mode to prevent this.

Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
Tested-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Signed-off-by: Sahil Chandna <chandna.linuxkernel@gmail.com>
---
 net/bpf/test_run.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 4a862d605386..daf966dfed69 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1368,7 +1368,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 				     const union bpf_attr *kattr,
 				     union bpf_attr __user *uattr)
 {
-	struct bpf_test_timer t = { NO_PREEMPT };
+	struct bpf_test_timer t = { NO_MIGRATE };
 	u32 size = kattr->test.data_size_in;
 	struct bpf_flow_dissector ctx = {};
 	u32 repeat = kattr->test.repeat;
@@ -1436,7 +1436,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kattr,
 				union bpf_attr __user *uattr)
 {
-	struct bpf_test_timer t = { NO_PREEMPT };
+	struct bpf_test_timer t = { NO_MIGRATE };
 	struct bpf_prog_array *progs = NULL;
 	struct bpf_sk_lookup_kern ctx = {};
 	u32 repeat = kattr->test.repeat;
-- 
2.50.1


