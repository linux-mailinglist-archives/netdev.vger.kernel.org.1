Return-Path: <netdev+bounces-211570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EFFB1A2DD
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 15:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C833A3801
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 13:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D38253F3A;
	Mon,  4 Aug 2025 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZSn9x/b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761611DE2A7
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312919; cv=none; b=CaCi911MB6mzWGId6HT6cTIQWmoAOlshUlvV3Xo2fof39lVdeEfy1pL/m+07fFI2mUS9oNUuHtI+/IaOCkeeVrFNHscclZQ+26iGa9cAeJWo4Ibbt9f7dI9nI7jiHwmqJMrwYrXftvKrubmjOQVm3a0C3bUDnh5zswWWMoV3MWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312919; c=relaxed/simple;
	bh=iUTCoia3qC7dnHqyIdaAEHAYjh1BhYWnAs3abd/hu6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3xOlebXZLEUKq1v6RjD8RP7j5fKvEgnTJ3Pu1GaH8r6uJjKFWlRMS0e1aSOWrQnaj5WDcYdwDYw6OsAjU+4YhNxHjWxsUCLA1O/b4d2a99Hs2RKuTwKVrHkd6kh148DpUVoPp2lx4/1ZXGlIg8b1oMtp4uk5gJoPzlwA+4v+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uZSn9x/b; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4af21689d1dso12116791cf.0
        for <netdev@vger.kernel.org>; Mon, 04 Aug 2025 06:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754312915; x=1754917715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxEUr8lMPZtPdNJe6+M0dEkWbVJQUyJ83QSvThVqvn4=;
        b=uZSn9x/bwSAgogq/91yzgx4+WzOgzLoywjjVr2Fu5FEiN/7xtDvZb/mU25CoAVKFzy
         pSlQ108u+59PwOT0nu8NP/TORHOzmvdUow6Xpt+Vn5kkjiZ8CL3QOceu2N0xop5TqzGd
         GN7S67Ib+ggs+WNqNfV6uK0rwGt+pmfRGcOcVEaH/DR88w/tQNDKVE5qJjyfNEOf7Fja
         yb2UEQO4TXPPyD79A5woTd4RPiQ7pgHUAKaLivNBRdHRLNw5fzZ9EuIdA/83otVLs/+j
         x316trUBSd8CX/aJYdE/bYm7yU/d1HQJO+lg096HGBq8EYrLLiDHqSSL4zI4+MO9MNnJ
         vsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754312915; x=1754917715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxEUr8lMPZtPdNJe6+M0dEkWbVJQUyJ83QSvThVqvn4=;
        b=ev+90wHdqubFN0g7zzcP2MBKrCZOpvCXlGyYfRFNXD3VoqPITJ7q66+VeO58rcjg1D
         4kW4iJo5PVgeI0Bw+6N2wcEhiXf4eGuFd3rV8cXDWWeuGlT+tf57959BmxLw0BRNKIrK
         dzWLMZaSX7Nw/vpE8+lRdrVEn96rJ28xytvR8nHIqHcu3A9OtlCYeEqz7U43eFOxwzCL
         rwyvPEcCVD7uUqiVkKJRplxEBydqqMWuAMCEhCUQWXUVaIhOOVvuTziiqn2edYkoqa1f
         5l+gc7B+86AxZhqIyxW9N7SRY2UhYMRINqYD+OVEiG7idQcY+q7UlxzZGpkOoiqm/7e8
         KX6w==
X-Forwarded-Encrypted: i=1; AJvYcCWWQHFglHcuUz5MK85/OIqCt0HPgG2w9fehAYheooF/Yik3ifvxe5suQ+kWNGy0SS05ZF0o3Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZbCqpNHWrIM9qEXzpQl7koX2cXpqBBQR6eo8xwT0owZ39mHhn
	KFqkQ0sIHNK+rnfcfM3WC22eV9nz/cCnS9ZIvjBG8EIHFqOqVtYdrY3oQ13506kt1aGAilItaCg
	I6kOxH98b29PjC8/O29hH1H88tIFV2+Q7fu/kpRiJ
X-Gm-Gg: ASbGncugGdWTJt4u3+Idwe3LB5f2Hz2v/cmQewhvjFbWu6+A6j6lA5d7ucDWmMO2SYe
	13nQ2m97DOmCg566d1L5rZ+/ibbzEYlG2wizgVm4ii4ges5YnZh+6p35ZfurSfs6FLfdIyz2N/i
	Mpt592IneDSK5WlW8+oZpUIkzM0P42JlWWii5u5/nI9Pf8UO6GiFpkAhFedg1w5cHoXatTIo6ut
	j7N
X-Google-Smtp-Source: AGHT+IE02c5yldHofFgqoJqg52MD/8UsFPaHWuQI/wNJHdjOKDyA169xSV5gIrk+z6J74DwmmlrmqwYrYADiE31VktE=
X-Received: by 2002:a05:622a:115:b0:4b0:769e:42e8 with SMTP id
 d75a77b69052e-4b0769e4355mr26383631cf.29.1754312914474; Mon, 04 Aug 2025
 06:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67f66c9c.050a0220.25d1c8.0003.GAE@google.com> <689095a5.050a0220.1fc43d.0009.GAE@google.com>
In-Reply-To: <689095a5.050a0220.1fc43d.0009.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Aug 2025 06:08:23 -0700
X-Gm-Features: Ac12FXyFuLTBAAHBdyJgd9snBJmPmGPckpbiBUWgvYoCV8wyuBbK26fIvEbNE60
Message-ID: <CANn89iJusO-iDNtUYQKKy6mmrZVqkJ=20_w+RavDup8bmTJ=pw@mail.gmail.com>
Subject: Re: [syzbot] [net?] KASAN: null-ptr-deref Write in rcuref_put (4)
To: syzbot <syzbot+27d7cfbc93457e472e00@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 4:12=E2=80=AFAM syzbot
<syzbot+27d7cfbc93457e472e00@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    5c5a10f0be96 Add linux-next specific files for 20250804
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14f23aa258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df4ccbd0768779=
54b
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D27d7cfbc93457e4=
72e00
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f604=
9-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1628faa2580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1249043458000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cb2134de7be8/dis=
k-5c5a10f0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/fe8a36605e0c/vmlinu=
x-5c5a10f0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/12df22603d55/b=
zImage-5c5a10f0.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+27d7cfbc93457e472e00@syzkaller.appspotmail.com
>
> BUG: unable to handle page fault for address: ffffffffffffffdb
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> PGD df3b067 P4D df3b067 PUD df3d067 PMD 0
> Oops: Oops: 0002 [#1] SMP KASAN PTI
> CPU: 1 UID: 0 PID: 6346 Comm: syz.0.336 Not tainted 6.16.0-next-20250804-=
syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 07/12/2025
> RIP: 0010:arch_atomic_add_return arch/x86/include/asm/atomic.h:85 [inline=
]
> RIP: 0010:raw_atomic_sub_return_release include/linux/atomic/atomic-arch-=
fallback.h:846 [inline]
> RIP: 0010:atomic_sub_return_release include/linux/atomic/atomic-instrumen=
ted.h:327 [inline]
> RIP: 0010:__rcuref_put include/linux/rcuref.h:109 [inline]
> RIP: 0010:rcuref_put+0x172/0x210 include/linux/rcuref.h:173
> Code: c7 c7 80 72 94 8c be 68 00 00 00 48 c7 c2 c0 72 94 8c e8 21 f7 35 f=
8 48 89 df be 04 00 00 00 e8 84 90 bb f8 41 be ff ff ff ff <f0> 44 0f c1 33=
 41 8d 76 ff bf ff ff ff ff e8 ab 27 58 f8 41 ff ce
> RSP: 0018:ffffc9000431f960 EFLAGS: 00010256
> RAX: ffffffff89678f01 RBX: ffffffffffffffdb RCX: ffffffff89678fdc
> RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffffffffffffdb
> RBP: ffffc9000431f9f8 R08: ffffffffffffffde R09: 1ffffffffffffffb
> R10: dffffc0000000000 R11: fffffbfffffffffc R12: dffffc0000000000
> R13: dffffc0000000000 R14: 00000000ffffffff R15: 1ffff92000863f2c
> FS:  0000555583637500(0000) GS:ffff888125d17000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffdb CR3: 000000002465a000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  dst_release+0x24/0x1b0 net/core/dst.c:167
>  ip_rt_put include/net/route.h:285 [inline]
>  pptp_xmit+0x14b/0x1a90 drivers/net/ppp/pptp.c:267
>  __ppp_channel_push+0xf2/0x1c0 drivers/net/ppp/ppp_generic.c:2166
>  ppp_channel_push+0x123/0x660 drivers/net/ppp/ppp_generic.c:2198
>  ppp_write+0x2b0/0x400 drivers/net/ppp/ppp_generic.c:544
>  vfs_write+0x27b/0xb30 fs/read_write.c:684
>  ksys_write+0x145/0x250 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fda7098eb69
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fffb2fc7658 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007fda70bb5fa0 RCX: 00007fda7098eb69
> RDX: 0000000000000013 RSI: 00002000000002c0 RDI: 0000000000000004
> RBP: 00007fda70a11df1 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fda70bb5fa0 R14: 00007fda70bb5fa0 R15: 0000000000000003
>  </TASK>
> Modules linked in:
> CR2: ffffffffffffffdb
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:arch_atomic_add_return arch/x86/include/asm/atomic.h:85 [inline=
]
> RIP: 0010:raw_atomic_sub_return_release include/linux/atomic/atomic-arch-=
fallback.h:846 [inline]
> RIP: 0010:atomic_sub_return_release include/linux/atomic/atomic-instrumen=
ted.h:327 [inline]
> RIP: 0010:__rcuref_put include/linux/rcuref.h:109 [inline]
> RIP: 0010:rcuref_put+0x172/0x210 include/linux/rcuref.h:173
> Code: c7 c7 80 72 94 8c be 68 00 00 00 48 c7 c2 c0 72 94 8c e8 21 f7 35 f=
8 48 89 df be 04 00 00 00 e8 84 90 bb f8 41 be ff ff ff ff <f0> 44 0f c1 33=
 41 8d 76 ff bf ff ff ff ff e8 ab 27 58 f8 41 ff ce
> RSP: 0018:ffffc9000431f960 EFLAGS: 00010256
> RAX: ffffffff89678f01 RBX: ffffffffffffffdb RCX: ffffffff89678fdc
> RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffffffffffffdb
> RBP: ffffc9000431f9f8 R08: ffffffffffffffde R09: 1ffffffffffffffb
> R10: dffffc0000000000 R11: fffffbfffffffffc R12: dffffc0000000000
> R13: dffffc0000000000 R14: 00000000ffffffff R15: 1ffff92000863f2c
> FS:  0000555583637500(0000) GS:ffff888125d17000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffdb CR3: 000000002465a000 CR4: 00000000003526f0
> ----------------
> Code disassembly (best guess):
>    0:   c7 c7 80 72 94 8c       mov    $0x8c947280,%edi
>    6:   be 68 00 00 00          mov    $0x68,%esi
>    b:   48 c7 c2 c0 72 94 8c    mov    $0xffffffff8c9472c0,%rdx
>   12:   e8 21 f7 35 f8          call   0xf835f738
>   17:   48 89 df                mov    %rbx,%rdi
>   1a:   be 04 00 00 00          mov    $0x4,%esi
>   1f:   e8 84 90 bb f8          call   0xf8bb90a8
>   24:   41 be ff ff ff ff       mov    $0xffffffff,%r14d
> * 2a:   f0 44 0f c1 33          lock xadd %r14d,(%rbx) <-- trapping instr=
uction
>   2f:   41 8d 76 ff             lea    -0x1(%r14),%esi
>   33:   bf ff ff ff ff          mov    $0xffffffff,%edi
>   38:   e8 ab 27 58 f8          call   0xf85827e8
>   3d:   41 ff ce                dec    %r14d
>

Quite different bug I think, added with my recent commit

commit de9c4861fb42f0cd72da844c3c34f692d5895b7b
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Jul 29 08:02:07 2025 +0000

    pptp: ensure minimal skb length in pptp_xmit()

#syz test

diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 4cd6f67bd5d3520308ee4f8d68547a1bc8a7bfd3..90737cb718928a2dddacdc098f1=
d48d4430d6ddd
100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -159,17 +159,17 @@ static int pptp_xmit(struct ppp_channel *chan,
struct sk_buff *skb)
        int len;
        unsigned char *data;
        __u32 seq_recv;
-       struct rtable *rt =3D NULL;
+       struct rtable *rt;
        struct net_device *tdev;
        struct iphdr  *iph;
        int    max_headroom;

        if (sk_pppox(po)->sk_state & PPPOX_DEAD)
-               goto tx_error;
+               goto tx_drop;

        rt =3D pptp_route_output(po, &fl4);
        if (IS_ERR(rt))
-               goto tx_error;
+               goto tx_drop;

        tdev =3D rt->dst.dev;

@@ -265,6 +265,7 @@ static int pptp_xmit(struct ppp_channel *chan,
struct sk_buff *skb)

 tx_error:
        ip_rt_put(rt);
+tx_drop:
        kfree_skb(skb);
        return 1;
 }

