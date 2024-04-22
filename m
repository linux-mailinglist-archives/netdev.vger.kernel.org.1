Return-Path: <netdev+bounces-89983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 279FD8AC741
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 10:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17FE1F214F2
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 08:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06564502BE;
	Mon, 22 Apr 2024 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4kVrvdjr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AA14317E
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775213; cv=none; b=IWE41Adtei3Wo+Bn7C5oEmHlgyQTGdHGZOxQ5DUZe2l9649qn7bA3+GP8X8iBYfa5sCynABJvc34NRMZ6s2YV1eG5iUUGzUKrEqfjt5cc/pNuc8DmnW/2X59fv/zi5a4elQZQKaHsfsfEduOcR1qzg89qC4EVf/GjvDrBAfj0hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775213; c=relaxed/simple;
	bh=gBjd+Vu8U7gmMK1cuacoUqWYu4Mm34R+F75jPHl6MLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgP0ubWP/27P6o/2bz9O30t+4G9fAr6r1uMY5kMNNdhpL24csZs2HnEeO2FFfZfH3kOKpwCn2l4obK9lFSzXP7JNxG9nbnfP+Q5BvL5+EPIT61AK07ka4LZvxzK1z8x4/tOPnZG4tgmRRpm7AcKu52h+7+3H6eIzynd5+XR8G9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4kVrvdjr; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-69b137d09e3so26403636d6.1
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 01:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713775211; x=1714380011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyV/lN5dlUHG9Gy3r8/spvLCW++B9nPT5UV3g/jx5Xs=;
        b=4kVrvdjr2p9mjVLIDGrZWj387KqxTGUQaknDPGFWnpWaDNFJ3jOfDIohD1ym1dOGfl
         bG7Lw9t5kpHqeu60Fw6sL66PNSNOwoZzNm1r97z1GdMD3GG+VcQQWgkUvudk/VIC8DIx
         kmIFipbu4UwgjDT024Nm2/0r0FZpiKwCVXsVpunkPRTt2E0DsvQ0Ht08EGQF2riJKYAh
         4eBNxt2Q/pjDi+9SKOQg7EOaaLYiAeRC/5eUOHQswjkx2jxJARuJ9jc93PbH4vbjLqqw
         e9F13nl352QwbNi+80aZ19D5bZmjMbwSH7EcRBhI69Y6zLWqNl2VrtlqtUYEe4gZsGD+
         ocuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713775211; x=1714380011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyV/lN5dlUHG9Gy3r8/spvLCW++B9nPT5UV3g/jx5Xs=;
        b=KeTd8ryoAPUSQWvk/80uFGNxBfI7XRljOsgTZgQyMi5PKjr9aMg4n9iAp+/GarqSMJ
         Lvvh/bdANpo6I11cAmGtIQcBp9E/fQwRIqgkcs+/LB2kBrulVAZwlXc/1VJ0/Rh6b/uN
         JHT+QfHOYyFao8yl5H/IZvLBNudDj4f7+YQb71coynZyI9c3I4DdzVOae7bCPtrQrFmU
         itY5XLZxUlnZxJWqBzOrfFXCuBCebpdOtexyj/1Rwp6Ktb5lKhWDqjtvRTZWYOa4wqdU
         1Sr3RC3Ir2G7es5Qjd1Gn8xLvCsgQqVu8MFFPXPknruwkGD2LxrOBQYuCdwdZVzcZylM
         FUCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl3GmuQ6ZsavdlPboTV4GsdeI1l3Dr2WVRWGEsCseyGVIfMCb1d0DjI5CvsSn5f01kOqSk0OBRbNPfoJq8uv52vAtoRWtY
X-Gm-Message-State: AOJu0Yy4l6pMjtGRZq7/y738FU4LXzwKni9Qh580CoKTRzHocON/xA7L
	ktj9cVNGHyspylUV5IKxExdMo4TubGpBDgdruE8nWz8BX9lZ9YabyMkhiT28h7HOK0uEx3HUwV+
	+r6HKyFHjjdxwrhfzFYIkrBY9UgLFK3EWliKZ
X-Google-Smtp-Source: AGHT+IENPCbRIQ0LUueLwxddxA/XFr+u6ftoONVq0st9eSr/uSCaEUXWKVFNQ/qNjCmILccHeR7B/y8ZUUcVGBHPLk0=
X-Received: by 2002:a05:6214:1772:b0:6a0:75fb:4587 with SMTP id
 et18-20020a056214177200b006a075fb4587mr5828957qvb.41.1713775211256; Mon, 22
 Apr 2024 01:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000826ac1061675b0e3@google.com>
In-Reply-To: <000000000000826ac1061675b0e3@google.com>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 22 Apr 2024 10:39:31 +0200
Message-ID: <CAG_fn=Xt=i_EqRbbceS-GSo5voAF-9GO0ZBMykX3LwyffaU9NA@mail.gmail.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in unwind_dump
To: syzbot <syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 6:36=E2=80=AFPM syzbot
<syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    0bbac3facb5d Linux 6.9-rc4
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D13403bcb18000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D87a805e655619=
c64
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D355c5bb8c1445c8=
71ee8
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/93eb2bab28b5/dis=
k-0bbac3fa.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/47a883d2dfaa/vmlinu=
x-0bbac3fa.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6bc56900ec1d/b=
zImage-0bbac3fa.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com
>
> WARNING: kernel stack frame pointer at ffff88813fd05fe8 in kworker/1:1:42=
 has bad value ffff888103513fe8
> unwind stack type:0 next_sp:ffff888103513fd8 mask:0x4 graph_idx:0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in unwind_dump+0x5a0/0x730 arch/x86/kernel/unwin=
d_frame.c:60
>  unwind_dump+0x5a0/0x730 arch/x86/kernel/unwind_frame.c:60
>  unwind_next_frame+0x2d6/0x470
>  arch_stack_walk+0x1ec/0x2d0 arch/x86/kernel/stacktrace.c:25
>  stack_trace_save+0xaa/0xe0 kernel/stacktrace.c:122
>  ref_tracker_free+0x103/0xec0 lib/ref_tracker.c:239
>  __netns_tracker_free include/net/net_namespace.h:348 [inline]
>  put_net_track include/net/net_namespace.h:363 [inline]
>  __sk_destruct+0x5aa/0xb70 net/core/sock.c:2204
>  sk_destruct net/core/sock.c:2223 [inline]
>  __sk_free+0x6de/0x760 net/core/sock.c:2234
>  sk_free+0x70/0xc0 net/core/sock.c:2245
>  deferred_put_nlk_sk+0x243/0x270 net/netlink/af_netlink.c:744
>  rcu_do_batch kernel/rcu/tree.c:2196 [inline]
>  rcu_core+0xa59/0x1e70 kernel/rcu/tree.c:2471
>  rcu_core_si+0x12/0x20 kernel/rcu/tree.c:2488
>  __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554
>  invoke_softirq kernel/softirq.c:428 [inline]
>  __irq_exit_rcu kernel/softirq.c:633 [inline]
>  irq_exit_rcu+0x6a/0x130 kernel/softirq.c:645
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inli=
ne]
>  sysvec_apic_timer_interrupt+0x83/0x90 arch/x86/kernel/apic/apic.c:1043
>
> Local variable tx created at:
>  ieee80211_get_buffered_bc+0x44/0x970 net/mac80211/tx.c:5886
>  mac80211_hwsim_beacon_tx+0x63b/0xb40 drivers/net/wireless/virtual/mac802=
11_hwsim.c:2303
>
> CPU: 1 PID: 42 Comm: kworker/1:1 Not tainted 6.9.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> Workqueue: usb_hub_wq hub_event
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

This seems to be a false positive caused by KMSAN instrumenting
READ_ONCE_NOCHECK(), although it is not supposed to.
I was going to define it as follows under __SANITIZE_MEMORY__:

  #define __no_sanitize_or_inline __no_kmsan_checks notrace __maybe_unused

, but I find the name __no_sanitize_or_inline a bit unfortunate
because it doesn't distinguish between "do not instrument this code"
and "do not report bugs in this code", which have different meanings
from KMSAN perspective.

