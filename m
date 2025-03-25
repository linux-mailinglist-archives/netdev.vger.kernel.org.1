Return-Path: <netdev+bounces-177607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B05F1A70BBB
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A08E189A8A8
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 20:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52551A3A80;
	Tue, 25 Mar 2025 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M4dSmkHQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4162E3383
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 20:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742935657; cv=none; b=vEekNjhUTUYe2r/OxBgL7lZokw8vzyf+d3M1vYq7/SUOU9tZtn6AE6Zs/wkELi7QRnYc7DbbgomNjPTGNBnYaoAM4QEkVuHORkuTliLHN+XTCzDupOBlKuSX8LaFOHQQnclZfYr5zSllXiqzRBnE4zeaxKTMmIhXWxTy9iPVKG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742935657; c=relaxed/simple;
	bh=GCAhGVtueceq1ubCUXU7aIifbCxnCpAKEuI8oUAtt/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4IYLwN1TimBZaMmsMEjDjszveqZzUEY+G8TB4kIWoCy985PeBXRImytA82m0bYwmeNklqpel0YW1ysF/MA/S5PEq/ipe1JIOgf4dGEZY/9EAbo1BdU4ELt4iZ+K+Cc1xafwlf8nDcxio+QKGgvT/htXcSCXhiBvcWVn11zU7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M4dSmkHQ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54954fa61c9so6939585e87.1
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 13:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742935653; x=1743540453; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=M4dSmkHQpcBAA3eh8MMDRnITR6veJ0xV1x5W7OWpAZ5dy4r6ICnCdJPcmzeY7YZ4Z7
         QM2QJ7iYMFlNps/OgJIlpsYH/Ydhw6pNx/TjQFquQwS+VqJ6lbpkKAWcR98WquoVj118
         1y8Dd51B7n10Xqu3zsF7x0IRSb4Yk59OO98Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742935653; x=1743540453;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=g5Fa5S0DKl5mPwN+N6ZOVYxwnSucAUDFV36nE8GQ30r1wk9Xd3kRqFdoVXQb/HXX05
         5s+TrW/Yeulte1Tn0ecbOgZtJSJLN8OPfXaibnSD/3TGTXImcNQacMCd5/XGCIi02142
         23YPhJJ7e/FMkxT4qFvBPdifl+Vr500yyvaPco16bcXKmx1Lzb8tvBXqUR4K0hcj/KnW
         3gLG6PqbYddF/UXmaW+rfsdp0VtUvU5Ln+OhUKjh3m52t9yaQjjL14VuAUhMd/p61a86
         Q5Q1qYvcNsBgZVZSQ7IP6G7mFLh1EvqdeVLhWrqiTTy20rIoWem6G1JWELZt+oDwZzNR
         NElg==
X-Forwarded-Encrypted: i=1; AJvYcCXvc1NZFJlME/MUeVUYM9QWtxi79tSck424qS6IWybaXHso+ags0bvE1fD0NrMh6zRdG1wTqDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVFjH4rITSCUpQ6oC/6WS7+FEGoKo3jp4bPCQcv8Y0ntCZAKWA
	5cxBHgdNTMp7obyrEReSA+bQX8yMXI47/nKWpaLlq40y1YWuvnIp30s0ZNHbIv7pAWe0WQlPfxs
	qst6sqw==
X-Gm-Gg: ASbGnctcwIxDP+MJYlKB+cIu1Qu+A2kkDEN4zT04EGI0m7B4ZhAF1oWvQFDQ7AGeaYl
	87up2WS5/l+x0eSIsM9k7Tn0rZQhx8ivUZh/YVQZcQyTI9RbUFHgCvtwYYoXp8k5febV+p4j8UW
	HfS+a1ygWJUun72CzGZSVG9i/SNui4y/TQyKwhTzF+npAr1zVu+oUPCyPE+A/68MQahqh14EB5x
	X4Ruqko8wdDT8UmjhVbDmiOfqhaSvrAgHikSC26o4RvRvAdUFMXVKiTgcR7kP0ktEMbtcsrr/Eg
	zSUP0VgCPYRbONb9B4mERWvhyOJ+g+GMOizBbp+1zWgWbrWyiUQ/ggCBoK24GgEkdXi0uuxaQb2
	A5jjGdb79ov0sVVO4P5k=
X-Google-Smtp-Source: AGHT+IGqgkskkJgs/zqQXB1WLHSt1o+Bw9RJape10VonaAXWDnA5H43cR1zjO50EbL1nlKhyKu5Djw==
X-Received: by 2002:a05:6512:3e0a:b0:545:8a1:5379 with SMTP id 2adb3069b0e04-54ad65004c8mr7457007e87.43.1742935653462;
        Tue, 25 Mar 2025 13:47:33 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad647ca4esm1600461e87.87.2025.03.25.13.47.31
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 13:47:32 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54af20849bbso2159692e87.0
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 13:47:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUd8zS4ekmkL5eYge21GOHrqkrbEqZDYJraPs0W3R/F1PnGRUSPKsticZb6PwRofKd5SN/7Ihk=@vger.kernel.org
X-Received: by 2002:a17:907:95a4:b0:ac3:48e4:f8bc with SMTP id
 a640c23a62f3a-ac3f27fd3b3mr1859596466b.48.1742935307883; Tue, 25 Mar 2025
 13:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325121624.523258-1-guoren@kernel.org> <20250325121624.523258-2-guoren@kernel.org>
In-Reply-To: <20250325121624.523258-2-guoren@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 13:41:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
X-Gm-Features: AQ5f1JpwFc7ifwGuAhyrs4E5qPgHx1McCR38KFycRhkLFRMKTveHrmoaWi4zba4
Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 01/43] rv64ilp32_abi: uapi: Reuse lp64 ABI interface
To: guoren@kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, anup@brainfault.org, atishp@atishpatra.org, 
	oleg@redhat.com, kees@kernel.org, tglx@linutronix.de, will@kernel.org, 
	mark.rutland@arm.com, brauner@kernel.org, akpm@linux-foundation.org, 
	rostedt@goodmis.org, edumazet@google.com, unicorn_wang@outlook.com, 
	inochiama@outlook.com, gaohan@iscas.ac.cn, shihua@iscas.ac.cn, 
	jiawei@iscas.ac.cn, wuwei2016@iscas.ac.cn, drew@pdp7.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, ctsai390@andestech.com, 
	wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com, josef@toxicpanda.com, 
	dsterba@suse.com, mingo@redhat.com, peterz@infradead.org, 
	boqun.feng@gmail.com, xiao.w.wang@intel.com, qingfang.deng@siflower.com.cn, 
	leobras@redhat.com, jszhang@kernel.org, conor.dooley@microchip.com, 
	samuel.holland@sifive.com, yongxuan.wang@sifive.com, 
	luxu.kernel@bytedance.com, david@redhat.com, ruanjinjie@huawei.com, 
	cuiyunhui@bytedance.com, wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn, 
	ardb@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 05:17, <guoren@kernel.org> wrote:
>
> The rv64ilp32 abi kernel accommodates the lp64 abi userspace and
> leverages the lp64 abi Linux interface. Hence, unify the
> BITS_PER_LONG = 32 memory layout to match BITS_PER_LONG = 64.

No.

This isn't happening.

You can't do crazy things in the RISC-V code and then expect the rest
of the kernel to just go "ok, we'll do crazy things".

We're not doing crazy __riscv_xlen hackery with random structures
containing 64-bit values that the kernel then only looks at the low 32
bits. That's wrong on *so* many levels.

I'm willing to say "big-endian is dead", but I'm not willing to accept
this kind of crazy hackery.

Not today, not ever.

If you want to run a ilp32 kernel on 64-bit hardware (and support
64-bit ABI just in a 32-bit virtual memory size), I would suggest you

 (a) treat the kernel as natively 32-bit (obviously you can then tell
the compiler to use the rv64 instructions, which I presume you're
already doing - I didn't look)

 (b) look at making the compat stuff do the conversion the "wrong way".

And btw, that (b) implies *not* just ignoring the high bits. If
user-space gives 64-bit pointer, you don't just treat it as a 32-bit
one by dropping the high bits. You add some logic to convert it to an
invalid pointer so that user space gets -EFAULT.

            Linus

