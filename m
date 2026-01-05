Return-Path: <netdev+bounces-246849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD424CF1AB5
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 03:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E72B5301E17D
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 02:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB64B31BC84;
	Mon,  5 Jan 2026 02:38:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4085D31AABF
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 02:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767580732; cv=none; b=GHOH+cUSVdrJ7kGEHHVTV2k9fIJt9ZUV0/zYf1DZAYHbvWlmRQRndl2Z576O0H1yn85j6VMSG08LVS2tYWOntyx5GWBWW0bHuhJhL7b8IruogBKK0Ae2jwmYIoEEfcvsrWX4zDGg6wSprW0zmjsmFrIq2I05MEE3gtIH5nWxVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767580732; c=relaxed/simple;
	bh=7obfdYcAoY6c0ylCEFa7/4ZOtVj4bbzG2KYZukjLvQw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=eDo8miEKNF2oooaEpCfY5rGaLXRX/eqbbDfmzV6/o2B6ag3mjaXjKLgF1+mrEzb53AXukd59mSz3/Vy/J61s1tjYTDc56zx0lWySWrx6HC2HqOPbpIOh2QJu2TauMBe93bq5X25sylu5Ul6QoVG7mON6Jj533a8lnBc6NIeIJjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-65b31ec93e7so28062481eaf.3
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 18:38:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767580730; x=1768185530;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D9o9u3BoEgfjkbS84MC31NTcI++PBXoKbiOR/3JRI8w=;
        b=BPMXH3TfWUicpAwkPYIDnebCvbkbGrWw1kPat4BCP2t9dV4xWHPHiuWcF7QoQjMIgO
         zEl0acZC9HbHpWaH4Y0/cHgiCekc8ii8GT+PhTpjwvaOH8ucdI4Pb48fUXXGoeGu+qzZ
         S94j8+l8z0E184EI8IwPOtglu3ofznGt10RuLwAHiHfn1xD99CAbaaTFtIa2wYglbV1G
         zwr5RVK80LHFXQM+srGRoD5oRCONiDi4ggjIiEebOB7Kg/4APtNTvZ+bd0zWUfjO0T4f
         F3E01mJmSYb+j9UCpZWcqUl0YvHL8jVWAms+JONuMHIfPJwcI7iDHwRKzQKDZa6w1Sp8
         wtPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO0d4PT4AiM5OUx0OOtOMRuh0XAAaGFNrk7HF24LV2nFfmjk7gTqIuhH4i60Hyvb1vzJaUIhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlb+Dy3/s9gehifuFOiGr2lyz/RqdP0EuQ3XYZEblGW3+nCDMc
	Tmo7SGPuBl8P/ootoDmM9iCY/HerEsVw4a3C2PlOQqOqp0AZLOsEPzsIgqEfac7PzThCb+Ye1B+
	PTcHjg6hS14y8l7qlJT+ErhYX39aeyiiXQHLBMkPCk33II2MwphEOdzqLqL4=
X-Google-Smtp-Source: AGHT+IHxEiEyCDzK5u8kMXvWPaLqH2zQhGLy/7alfJTYSzUg1Py7KhmE0ECNV7JWJzl5OWCwqtrKIDwZJWXL81GYCFBoMgJyS+on
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:a094:b0:65d:757:39f6 with SMTP id
 006d021491bc7-65d0ea9d1aemr16413352eaf.39.1767580730260; Sun, 04 Jan 2026
 18:38:50 -0800 (PST)
Date: Sun, 04 Jan 2026 18:38:50 -0800
In-Reply-To: <20260105023842.1739283-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695b243a.050a0220.a1b6.0396.GAE@google.com>
Subject: Re: [syzbot] [perf?] KASAN: slab-use-after-free Read in __task_pid_nr_ns
From: syzbot <syzbot+e0378d4f4fe57aa2bdd0@syzkaller.appspotmail.com>
To: wangqing7171@gmail.com
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, netdev@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"

> #syz test

This crash does not have a reproducer. I cannot test it.

>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b1f3915d5f8e..72b9b37a96c8 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1975,6 +1975,7 @@ __latent_entropy struct task_struct *copy_process(
>  	struct file *pidfile = NULL;
>  	const u64 clone_flags = args->flags;
>  	struct nsproxy *nsp = current->nsproxy;
> +	struct signal_struct *free_sig = NULL;
>  
>  	/*
>  	 * Don't allow sharing the root directory with processes in a different
> @@ -2501,8 +2502,11 @@ __latent_entropy struct task_struct *copy_process(
>  		mmput(p->mm);
>  	}
>  bad_fork_cleanup_signal:
> -	if (!(clone_flags & CLONE_THREAD))
> -		free_signal_struct(p->signal);
> +	if (!(clone_flags & CLONE_THREAD)) {
> +		free_sig = p->signal;
> +		p->signal = NULL;
> +		free_signal_struct(free_sig);
> +	}
>  bad_fork_cleanup_sighand:
>  	__cleanup_sighand(p->sighand);
>  bad_fork_cleanup_fs:
> diff --git a/kernel/pid.c b/kernel/pid.c
> index a31771bc89c1..1a012e033552 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -329,9 +329,9 @@ EXPORT_SYMBOL_GPL(find_vpid);
>  
>  static struct pid **task_pid_ptr(struct task_struct *task, enum pid_type type)
>  {
> -	return (type == PIDTYPE_PID) ?
> -		&task->thread_pid :
> -		&task->signal->pids[type];
> +	if (type == PIDTYPE_PID)
> +		return &task->thread_pid;
> +	return task->signal ? &task->signal->pids[type] : NULL;
>  }
>  
>  /*
> -- 
> 2.34.1
>
>

