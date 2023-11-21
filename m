Return-Path: <netdev+bounces-49736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195DF7F34AB
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 18:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78A42B20E70
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 17:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E72859140;
	Tue, 21 Nov 2023 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yKoRbjsw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i837O3Jj"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B974010F3;
	Tue, 21 Nov 2023 09:13:39 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1700586817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1cohRsqh/gMhQXdMjmF/EuQWloEkKiFSISrxy+k+Yc=;
	b=yKoRbjsw+M17klBqF2oTGsSjab+urRzwkmf3bgaPsgI9SRyvP3MOQsRW73SchXHd+8bDQ7
	dekfagNyy3HkIjpcObwWt9cVMGdAXaik7+XrPsUQG/BdvtVOS3tJQQgtiYK9MsZoinXYUe
	nNiqkC85nrXyE/1Au4nKbrd2GX0IR0XfqT9s7fNhxhdHGqwuPIwURGGD+0RtT/BuqthHDf
	JRpq3q5QppnAtDvmHLB3YMVKrS8viAl2nsOye3jv766JCtcy3exvkN/5h3tWgJsFVdXG/I
	PsNLGmndD/Grb30YnMwUJ/2kbH7r1oUfbDwdWLbanRpFPp5Acwrc5eMmYOPeqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1700586817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1cohRsqh/gMhQXdMjmF/EuQWloEkKiFSISrxy+k+Yc=;
	b=i837O3Jj13QAzuwzURXhtUBgENdXHytu9f4mzpfzuKO8+CNfdSBX0StCX4uHyyZAcZCwlg
	KF+oUz4ZAoaLJJDA==
To: syzbot <syzbot+72aa0161922eba61b50e@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, bp@alien8.de, bp@suse.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, luto@kernel.org, mingo@redhat.com,
 netdev@vger.kernel.org, peterz@infradead.org,
 syzkaller-bugs@googlegroups.com, x86@kernel.org
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 copy_from_kernel_nofault
In-Reply-To: <000000000000c84343060a850bd0@google.com>
References: <000000000000c84343060a850bd0@google.com>
Date: Tue, 21 Nov 2023 18:13:36 +0100
Message-ID: <87jzqb1133.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Nov 19 2023 at 09:53, syzbot wrote:
> HEAD commit:    1fda5bb66ad8 bpf: Do not allocate percpu memory at init st..
> git tree:       bpf
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12d99420e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ae0ccd6bfde5eb0
> dashboard link: https://syzkaller.appspot.com/bug?extid=72aa0161922eba61b50e
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16dff22f680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1027dc70e80000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3e24d257ce8d/disk-1fda5bb6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/eaa9caffb0e4/vmlinux-1fda5bb6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/16182bbed726/bzImage-1fda5bb6.xz
>
> The issue was bisected to:
>
> commit ca247283781d754216395a41c5e8be8ec79a5f1c
> Author: Andy Lutomirski <luto@kernel.org>
> Date:   Wed Feb 10 02:33:45 2021 +0000
>
>     x86/fault: Don't run fixups for SMAP violations

Reverting that makes the Ooops go away, but wrongly so.

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=103d92db680000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=123d92db680000
> console output: https://syzkaller.appspot.com/x/log.txt?x=143d92db680000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+72aa0161922eba61b50e@syzkaller.appspotmail.com
> Fixes: ca247283781d ("x86/fault: Don't run fixups for SMAP violations")
>
> BUG: unable to handle page fault for address: ffffffffff600000

This is VSYSCALL_ADDR.

So the real question is why the BPF program tries to copy from the
VSYSCALL page, which is not mapped.

Thanks,

        tglx

