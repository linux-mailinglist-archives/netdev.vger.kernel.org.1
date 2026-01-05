Return-Path: <netdev+bounces-246848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFCFCF1A76
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 03:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24D0D30012E9
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 02:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F9331B117;
	Mon,  5 Jan 2026 02:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAtQCGF/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F54A31AF09
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 02:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767580731; cv=none; b=D06hfqYFeguyMy8YE03gmQ0E3L7DM/pgrB33tghvxWo5CCDSjFLmh3nuLCguvwALHScOdI5wFDmBTPq9CDih4m9K+5XtNX4XRdiy8MLT0Z1jF4qIS+z5dC3zg6po8tbA167snvcdCWYPrBoLkHFk2O1Rd+vAzhWRdOslaVmH4Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767580731; c=relaxed/simple;
	bh=6/acNCX7vjm0NM8sd8jjQdUv18qEJnBBW6xmNTJlIJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EN5RRe/hxyfdIjP9bTdZ/hvpBPWhVGnpDvRxHbzQSyyRwI88g/h2XFY7crUd3MPF3uCiKwnnkW93HTAHzHv3yuXAm3fjORmlBSr6ZMRmqC2W8BxJM4tSKQW0fj9gwkD/79Z4kDDhADJxVd5mjtK8eJXZpp8o0GLY3DR2hKqb484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAtQCGF/; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a12ed4d205so118608675ad.0
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 18:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767580729; x=1768185529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ltBIrcQzwz+TGu1FSwRd7xy+jtxW8km5l5/wzkRfIg=;
        b=WAtQCGF/tk3avh41SqEa/hWUZHsCnPDb4ZiPvE/GIqLqWjZiarl3D0gQMssdptHyN9
         micp8bXVsoY6/thnLB1Qc8ocspUTdGQEhaO/FSfzuP4CIZr73Y6UFjTXewVkAQ8dMW33
         1+E1bdbQLMeC8xX5yb8OFH7ACfk6sANpf8BaKICCXMYQgRcBhnkVvSVhCu0Npb6fZ1KE
         lVcQ4lUiWFPK8ju9Kh2prydQrnaFIP31nPRdmj5ZSpoSDIQ6CrpcvoVulgFnXomes9cv
         VUreuytTQ4HhpBNO9ewPXHI6DJ7HeDbg7UJQ8HDfRklj4CrcoXlV9DwO4WbFcypF/UTe
         e3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767580729; x=1768185529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+ltBIrcQzwz+TGu1FSwRd7xy+jtxW8km5l5/wzkRfIg=;
        b=C7HRPvRpjv2zO+bOVT5Dcms3IGAhytqkFtrK9M1FobcUokJP55MnlpqL8X/+3P4PYu
         mt4UPDAd6ojE2kj4uREbctUKWnnpgdZxg8bgI4ArKCUPFa9S2qku5HaBt4hYhH4liKC/
         zqvatVj01aw0xWS8K1I4lOMa97gessN70OSoc+H1m5d2Ll3NWam5bnvcLG1QloTL1wnC
         wzpx/yk8vkXp4I02yQpt/aNychj9El0jb705BOftiqOXXc0zWR7Nsdq3+3jT4r+6ws6N
         tM0MEEYgKLViWcYd/A8ltrPsUNTuO7tJJz8eQaj59xy0pjcUL/b0Y6l6/VZm+IIJjAel
         EelQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO1SFG/on51k6Q/DM+8IAq5zFTDKerryVQ98vbi6Ug8CPRhZLGz20MoRB+cr69RSSTZsw123I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGDEycsopJjIOG7ZmhtsNpgveyOHNozK173Djev+djmDyPZM5F
	Jtd3VQ9NiYXie3iSkls1epRA1pbTc/CA1HUY0duyD+n/4wKVEY8bxRVM
X-Gm-Gg: AY/fxX4qxfWPAXt2RuKsdczFky68zE65WdKHhE+MpEoEp5z0XXPxEdV1Iq3t7q9cUSt
	fwX1HiO4/w4veKwjEp81UJxX1DKQZqbUhAxj4aAhrbauubQPxLKf6yY9nWfeUU98QEcYdwGcJQA
	Nw052jCJYk0Pn/guGDtxbX3169mYmbuAAt7fXnhHJWN9btfjwj+lsjKB4U6Gmoz9np8ZzTUOZjQ
	HXdEiTVVOxUHqGpnzpsUAf+PYtB/fu9ZaGnZlGC0p5zv6j3AOjBwOL1DlwkyQ281EJGSDAGtjrI
	8PqWzH3domPNjLWGy9jxwg/T/0zGHpCEevheByyUXl0y97BfZqO+ma/lsPzE8w5ultOwukANDDF
	HURpapXTf+SEFlgZqJnUCeE9cIG6xDaQwIvTiauEndQuT0sd+Qg7oSNWwU6fjx5SxNajsxgXbD0
	IzMWyvivV7z6qNUDbsMm8HPXEfR+aSfD2jxqnIMA==
X-Google-Smtp-Source: AGHT+IHkPLTkF7fQWPd2p62Rv/D6yyxahxmeMXUfRBuO1yoXeRazXHIrZvENtli2a8EDJfpEsk0qOg==
X-Received: by 2002:a17:903:3c50:b0:2a0:9040:637b with SMTP id d9443c01a7336-2a2f2423178mr500699145ad.26.1767580729318;
        Sun, 04 Jan 2026 18:38:49 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d74bbbsm435854135ad.94.2026.01.04.18.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 18:38:48 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+e0378d4f4fe57aa2bdd0@syzkaller.appspotmail.com
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [perf?] KASAN: slab-use-after-free Read in __task_pid_nr_ns
Date: Mon,  5 Jan 2026 10:38:42 +0800
Message-Id: <20260105023842.1739283-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6891c7b8.050a0220.7f033.001f.GAE@google.com>
References: <6891c7b8.050a0220.7f033.001f.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/kernel/fork.c b/kernel/fork.c
index b1f3915d5f8e..72b9b37a96c8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1975,6 +1975,7 @@ __latent_entropy struct task_struct *copy_process(
 	struct file *pidfile = NULL;
 	const u64 clone_flags = args->flags;
 	struct nsproxy *nsp = current->nsproxy;
+	struct signal_struct *free_sig = NULL;
 
 	/*
 	 * Don't allow sharing the root directory with processes in a different
@@ -2501,8 +2502,11 @@ __latent_entropy struct task_struct *copy_process(
 		mmput(p->mm);
 	}
 bad_fork_cleanup_signal:
-	if (!(clone_flags & CLONE_THREAD))
-		free_signal_struct(p->signal);
+	if (!(clone_flags & CLONE_THREAD)) {
+		free_sig = p->signal;
+		p->signal = NULL;
+		free_signal_struct(free_sig);
+	}
 bad_fork_cleanup_sighand:
 	__cleanup_sighand(p->sighand);
 bad_fork_cleanup_fs:
diff --git a/kernel/pid.c b/kernel/pid.c
index a31771bc89c1..1a012e033552 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -329,9 +329,9 @@ EXPORT_SYMBOL_GPL(find_vpid);
 
 static struct pid **task_pid_ptr(struct task_struct *task, enum pid_type type)
 {
-	return (type == PIDTYPE_PID) ?
-		&task->thread_pid :
-		&task->signal->pids[type];
+	if (type == PIDTYPE_PID)
+		return &task->thread_pid;
+	return task->signal ? &task->signal->pids[type] : NULL;
 }
 
 /*
-- 
2.34.1



