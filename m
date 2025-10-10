Return-Path: <netdev+bounces-228464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92489BCB505
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 03:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416973A5FB9
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 01:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5951E1DE9;
	Fri, 10 Oct 2025 01:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNvrVQ8i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C223EDDC5
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 01:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760058151; cv=none; b=WWjidi9hLZWNSSpP1Q2wdS0trENuOIe/0TTSbusxHeShOg4EbkqsH/+Y6x/T2Jc2lg9cNdnMLmhoTBlkZyo97TzTagu/qx50HHXNmJqc+GmzAzWtJM7+oKfcMAyVkUBvjGpfCaxoYXLHrKh2QgY6tTEuj3KLj+LDYawy1cJi6o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760058151; c=relaxed/simple;
	bh=1Ps93Q6sYsxHBeY+l92lpGx/fq2SAnulwNg4BIcDfNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVhKieLvQcMA0KtNGviLihhvWPYT2B2mHE9oWq/rRaBcH7/eZwGhpoyNSz95YfWriWHl/vXEBaYnc/gNqKDT94ovK5wF2Xy2HQQg6GrppbOfhl5aqgXtVc3VwW+1im0XorI1wvvLKve4qjYaSm8W+aklKjiqaptGSMgn0zF/4l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNvrVQ8i; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so1773047f8f.1
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 18:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760058148; x=1760662948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnR0uJiI/epmSV/1cEgYnUQ4eWwUQy0eIshJnBoMl6Y=;
        b=mNvrVQ8iyyolGQ810fOndCHtCZsBLRGwVx+ZYzSsPgIbAXpRxCmDVNAYVIx27hAgVA
         gQ9JEGO4tBnqydk9fgJzoUWhxWtfVH8Z5bj1nJ1zX4zMBWXIeuBDPoIJGQcGHz4/lXlG
         M/u2gXzueyTWbOOVHM0cKozQV7h9LSDFBdYs6sq2ni3eEP54dLMPqCEPWSiyvxSyHl51
         syzD1yd6ceP5HJNxp9p/sF4YcsRbtOSrpiyo29O+Tju0smi48jjYFByuo5nvMMtyqX1T
         dpYkCJO8O8S0fvmPcz8zrynEaPHoJ/Tl/RGlbOh7On2gzFY10GYixtggSjJgUEvhxzjC
         cTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760058148; x=1760662948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnR0uJiI/epmSV/1cEgYnUQ4eWwUQy0eIshJnBoMl6Y=;
        b=jpBhzF/VI+Bk/VbMpDzP7K14cf95ViSGxKboD4zg2qHZ2o+URvogtNqUC1WfN/nCvV
         26dxe0gJ3i1I23XmzENnrXW3UUC4crJ94TyFshs3lKStv6atSqTgmRkzcaXs4d7kPWnZ
         KW2F0dO/zGmuYSjVxWXURfUhZCb0I/SX0aHFR96CgltXvuLy61n9fX6ZISHZzW1v9Qzj
         TDsZqhqJNzbLiWR+MYu46AE8pDLkH3S6DPQDRiqwzR0DtuNmWH+fTCmwnaFym97Ps61H
         OQhRQgSPCI9kdS0ZQL4B5J9LjyfP1xZaH3lI6SFfb4XztFW/hCHpz0jeeczcJpVIYh9V
         npPA==
X-Forwarded-Encrypted: i=1; AJvYcCUwHy5hUYh9gg++kkkuORdxQu8bwYFBOa+b9l6U/EvtdL+WP6f2l0bX1h8Xq2FdkFSpjvdBvi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YznH53Gk+hsJKR3vznZUBfPS/9oCY1tNyAQXv0yxtb2KHF7lyfv
	VgQCBomjsyAyLXxorDe+zNVkyW2X1cmF77jsurzZUVv4hHw51l6zy2zjOr3zOEJQqdK5K8e6bBE
	cjbNIEK038jLyNPRDDN+Q0sWuoJ0Gu3w=
X-Gm-Gg: ASbGnctibpT+ahEFuedajRCf6lmsTZ5fa4xZFpM3401Q20hq6tIr2x82WCYalq8Cg6c
	DWzmBfRyONvucvpl1c6DI+ZMG6rjPZFWB2s4myKKgiBaYo2BWFprm6OQ/tqB71xBoGNjcnrxSrL
	6kyiw0nNZIjz0rVLwQ4h9VG59jwt7FDV1vBO+Q0ZM52AyhhUn0soEqpegH8aVugbC+axAXLmmxL
	TQOVet7hfagQAiAeMtV3F0H3YxUJElhqdCW3+gUtOcAHP7Z/9RHbF1Lbvy/3YlP
X-Google-Smtp-Source: AGHT+IGH4L1PsW2HSLnPT1b+FvAV7y3XviS/A+70p3mDX7ru+D0SLH/bqU8GIUNA4SjlCEDYSkoogFsoO2+4hU5l5hI=
X-Received: by 2002:a05:6000:1863:b0:3f6:9c5a:e1ff with SMTP id
 ffacd0b85a97d-4266e7dfda8mr6665630f8f.39.1760058148046; Thu, 09 Oct 2025
 18:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68e7e6ad.a70a0220.126b66.0043.GAE@google.com> <20251009165241.4d78dc5d9fa5525d988806b5@linux-foundation.org>
 <CAADnVQK_8bNYEA7TJYgwTYR57=TTFagsvRxp62pFzS_z129eTg@mail.gmail.com> <20251009174108.ad6fea5b1e4bb84b8e2e223b@linux-foundation.org>
In-Reply-To: <20251009174108.ad6fea5b1e4bb84b8e2e223b@linux-foundation.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Oct 2025 18:02:17 -0700
X-Gm-Features: AS18NWAbHuQ_j1bUNdwnvSYqJz0NpolTFAn_Q_jw8qP8y-DnFQMt1Zor-q5enF4
Message-ID: <CAADnVQKkLyJ0cbLet3q3X+X70FPAejcqTxP66d82WTO82c16rw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING: locking bug in __set_page_owner (2)
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+8259e1d0e3ae8ed0c490@syzkaller.appspotmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brendan Jackman <jackmanb@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Michal Hocko <mhocko@suse.com>, Network Development <netdev@vger.kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, 
	Vlastimil Babka <vbabka@suse.cz>, ziy@nvidia.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 5:41=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Thu, 9 Oct 2025 17:26:21 -0700 Alexei Starovoitov <alexei.starovoitov@=
gmail.com> wrote:
>
> > On Thu, Oct 9, 2025 at 4:52=E2=80=AFPM Andrew Morton <akpm@linux-founda=
tion.org> wrote:
> > >
> > > On Thu, 09 Oct 2025 09:45:33 -0700 syzbot <syzbot+8259e1d0e3ae8ed0c49=
0@syzkaller.appspotmail.com> wrote:
> > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    2c95a756e0cf net: pse-pd: tps23881: Fix current mea=
suremen..
> > > > git tree:       net
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D16e1852=
f980000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D5bcbbf1=
9237350b5
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D8259e1d0e=
3ae8ed0c490
> > > > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f9=
09b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/8272657e42=
98/disk-2c95a756.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/4e53ba690f28/=
vmlinux-2c95a756.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/6112d620=
d6fc/bzImage-2c95a756.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+8259e1d0e3ae8ed0c490@syzkaller.appspotmail.com
> > >
> > > At 2c95a756e0cf, page_owner.c hasn't been modified in a couple of yea=
rs.
> > >
> > > How can add_stack_record_to_list()'s spin_lock_irqsave() be "invalid
> > > wait context"?  In NMI, yes, but the trace doesn't indicate that we'r=
e
> > > in an NMI.
> > >
> > > Confused.  I'm suspecting BPF involvement.  Cc'ed for help, please.
> >
> > The attached patch should fix it.
> > There are different options, but this one is the simplest.
>
> Cool, thanks.
>
> > From: Alexei Starovoitov <ast@kernel.org>
> > Subject: mm: don't spin in add_stack_record when gfp flags don't allow
> > Date: Thu, 9 Oct 2025 17:15:13 -0700
> >
> > syzbot was able to find the following path:
> >   add_stack_record_to_list mm/page_owner.c:182 [inline]
> >   inc_stack_record_count mm/page_owner.c:214 [inline]
> >   __set_page_owner+0x2c3/0x4a0 mm/page_owner.c:333
> >   set_page_owner include/linux/page_owner.h:32 [inline]
> >   post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
> >   prep_new_page mm/page_alloc.c:1859 [inline]
> >   get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
> >   alloc_pages_nolock_noprof+0x94/0x120 mm/page_alloc.c:7554
> >
> > Don't spin in add_stack_record_to_list() when it is called
> > from *_nolock() context.
>
> Seems 6.18 will need this.  Do you think it is needed in earlier kernel
> versions?

Maybe. I need to study the git history of that code to see
whether it's a new path or I simply missed it earlier.

