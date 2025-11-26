Return-Path: <netdev+bounces-241856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CBAC896D6
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 12:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D8C3AF51C
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 11:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0375C29BD85;
	Wed, 26 Nov 2025 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDdUpBjl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3679431D371
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764154852; cv=none; b=Fl+ePTPIRnqhxse+48oFaly1wB0IDEJSN4hLDnKdP1Hz1DDxOCw/hv07ZTjxT/LTMJdGxMGuzAimuuG0CtZLE9hMCu+VetwpjtYXGGWdpk4APBra+KRR8rc2TKXzuRKbUkOoj1p6f4FaYM1Z66HTU/fYWfSwMcWXRzNKmHPQ7XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764154852; c=relaxed/simple;
	bh=msoYboerQ9GyfrtFtKxaOgrGBy5crqNw31fDrjzoNaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uarIxnG42LImqpeU8qGQsD/gYNztmslUM3WxmK07oKclIqxIeOD9hlSHo+B5iHUVghqHH1ZnzTG6TAYOTflvnGNsqLrQ1+nuov9zXR2tvlUvU2DrTO+5h6AdAHK5Y9rOvJfrupCfSWp2yRr51TzZHefJKsD8Cq7I3+DIqJL2sp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDdUpBjl; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-4332381ba9bso29350845ab.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 03:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764154850; x=1764759650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiVfog/xOrvqP7cd7C9oJ6i+ydH+RPdRpxqOC6g1mA0=;
        b=KDdUpBjlDXGie319vOC97uPLzQP7fFnpnPO6MyTkuC4QQOlcnoSccw4zt0349Otz1+
         Wh94Yj3bMGzkB4Hldxev5JOT6jS9nFCQ6SA9ZJeXY5N8PTTnQS40MV9paz+fFwNXfg+j
         cmwpmu0vvPOJOGiuwYbgfNdwBG1dzpXvmXNVIEpDKoUBOEcIdJl2rskLWSRL8drwAMSw
         i8f4S/jdIVNf4qTXq2zYM1IS5y9LQS7kr33zQ+qJpSTfR1KaPfR6Px10gGEtLYyZXrhT
         CIdnEtPc2Q0TYyIMZG0TNgNHUy3fWsxnbo1vuZLXMFvWlpieSvFcLb9/GGH56YzM9hDn
         wvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764154850; x=1764759650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uiVfog/xOrvqP7cd7C9oJ6i+ydH+RPdRpxqOC6g1mA0=;
        b=BbiV0/IXNDpXIpH5zynWWRhyZOyvVoycDf9lJ9SFWfzMKPk5dKJD9fFo9chonxS3WV
         +UbCYbp/XPmqZ5qncSuUB1aRfT0e4bkRgNp8UKY7aY0Qmx1jn3k4lxxGQefWY3gsGG3n
         gsdz/P3XJMYTkbtx8B6sBClhmCAKNw+DkHECtoNJ0BCemF4aEHyYHZ1coPP2TSB0P1Iv
         clM9SRIcY2AcG4O02mABFOSVrxm8V8pwxuZBv0/kTGMzjTnPbmDktJfF9Tj7cqJD5NPX
         wJkVpaXnOrdgVQPZ4d/79AYJWzXy8MIF91FZr8ji2sMFNWTLtlmKH6DLdDqgEGFs6Akw
         9w/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+P9fuj8Wxp99Nd2J3mHB3oPH9Q7/WDBwr9tXduOSnS1SLUw/sn1zasD6QyNgKoY0Athxfq2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Kuzd3QokBNSfFxhGlEs7X7IUAu8WAm+hzmtFyndG5ssNZi1N
	GM23K71Vsps0DSuSOnP1RL2bjwa2ATrYZY5z3EVzsW89azO9smWdEot4L3qM9rVQQS2idQi6jiJ
	pcYQXBPDXOoQy2vpqQASKdtOq2jUjbrE=
X-Gm-Gg: ASbGncu30PsT5PMDArSrAMwbOrCXC5xEZ60fd63+56GUt8QnbbmHWf6WYLT5zwrHZH6
	MEnAvkYHOB/qvd9lwXtbKywwCbptH20zt2p7Qekilx8jM/jizTOVGX1J4p4KBSeuqZB5SY6KeS6
	6pVhharoJ+rGA6914ygjHrUM4w/Nv3fHAxndWMCwkQ34xdXAavQj/eBOsxj3K/55rEV2NlmF7F1
	DT4/AfD6Z7m/1kozLchgvmB9p4dNGyVQmQTQFqvQqfeZpAsuz0JtFCOGjEcCpwbgH3UM0ZX6h1q
	rgYXZA==
X-Google-Smtp-Source: AGHT+IHp5PB4YF4CDBA7GD5vFoLYmpIgo3uW2CCz98agh7AlBdh1hmpzzolECmczJSfEExIwt2TcVwuaSB3TiVAzXsQ=
X-Received: by 2002:a05:6e02:250d:b0:433:78fa:8000 with SMTP id
 e9e14a558f8ab-435dd0e8d2fmr50409875ab.24.1764154848993; Wed, 26 Nov 2025
 03:00:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124171409.3845-1-fmancera@suse.de> <CAL+tcoBKMfVnTtkwBRk9JBGbJtahyJVt4g8swsYRUk1b97LgHQ@mail.gmail.com>
 <955e2de1-32f6-42e3-8358-b8574188ce62@suse.de> <CAL+tcoD83=UXpDaLZZFU2_EDKJS9ew2njLmoH9xeXcg5+E3UDQ@mail.gmail.com>
 <aSXZ37i5CgGKn2RF@boxer> <CAL+tcoBw9OuMcpjy7eQq2=SDWRr+OGszbC+HNgbc_CVw6S=bWQ@mail.gmail.com>
 <23b56ddb-f5a3-4b2b-bf75-e93aa39ab63f@suse.de>
In-Reply-To: <23b56ddb-f5a3-4b2b-bf75-e93aa39ab63f@suse.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 26 Nov 2025 19:00:11 +0800
X-Gm-Features: AWmQ_bmnlv1bwnmLYnfM-vDf9qbtgGp9o7tMAVnedZ4Pq6mx4O3jLlLZ1Vobq1w
Message-ID: <CAL+tcoC+MzURCCuPQ2DJ2YpmAftNfm1WOrGrCzsL1MOnkBscgw@mail.gmail.com>
Subject: Re: [PATCH net v6] xsk: avoid data corruption on cq descriptor number
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org, csmate@nop.hu, 
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org, 
	john.fastabend@gmail.com, magnus.karlsson@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 5:15=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> On 11/26/25 2:14 AM, Jason Xing wrote:
> > On Wed, Nov 26, 2025 at 12:31=E2=80=AFAM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> >>
> >> On Tue, Nov 25, 2025 at 08:11:37PM +0800, Jason Xing wrote:
> >>> On Tue, Nov 25, 2025 at 7:40=E2=80=AFPM Fernando Fernandez Mancera
> >>> <fmancera@suse.de> wrote:
> >>>>
> >>>> On 11/25/25 12:41 AM, Jason Xing wrote:
> >>>>> On Tue, Nov 25, 2025 at 1:14=E2=80=AFAM Fernando Fernandez Mancera
> >>>>> <fmancera@suse.de> wrote:
> >>>>>>
> >>>>>> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> >>>>>> production"), the descriptor number is stored in skb control block=
 and
> >>>>>> xsk_cq_submit_addr_locked() relies on it to put the umem addrs ont=
o
> >>>>>> pool's completion queue.
> >>>>>>
> >>>>>> skb control block shouldn't be used for this purpose as after tran=
smit
> >>>>>> xsk doesn't have control over it and other subsystems could use it=
. This
> >>>>>> leads to the following kernel panic due to a NULL pointer derefere=
nce.
> >>>>>>
> >>>>>>    BUG: kernel NULL pointer dereference, address: 0000000000000000
> >>>>>>    #PF: supervisor read access in kernel mode
> >>>>>>    #PF: error_code(0x0000) - not-present page
> >>>>>>    PGD 0 P4D 0
> >>>>>>    Oops: Oops: 0000 [#1] SMP NOPTI
> >>>>>>    CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb1=
4-cloud-amd64 #1 PREEMPT(lazy)  Debian 6.16.12-1
> >>>>>>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.1=
7.0-debian-1.17.0-1 04/01/2014
> >>>>>>    RIP: 0010:xsk_destruct_skb+0xd0/0x180
> >>>>>>    [...]
> >>>>>>    Call Trace:
> >>>>>>     <IRQ>
> >>>>>>     ? napi_complete_done+0x7a/0x1a0
> >>>>>>     ip_rcv_core+0x1bb/0x340
> >>>>>>     ip_rcv+0x30/0x1f0
> >>>>>>     __netif_receive_skb_one_core+0x85/0xa0
> >>>>>>     process_backlog+0x87/0x130
> >>>>>>     __napi_poll+0x28/0x180
> >>>>>>     net_rx_action+0x339/0x420
> >>>>>>     handle_softirqs+0xdc/0x320
> >>>>>>     ? handle_edge_irq+0x90/0x1e0
> >>>>>>     do_softirq.part.0+0x3b/0x60
> >>>>>>     </IRQ>
> >>>>>>     <TASK>
> >>>>>>     __local_bh_enable_ip+0x60/0x70
> >>>>>>     __dev_direct_xmit+0x14e/0x1f0
> >>>>>>     __xsk_generic_xmit+0x482/0xb70
> >>>>>>     ? __remove_hrtimer+0x41/0xa0
> >>>>>>     ? __xsk_generic_xmit+0x51/0xb70
> >>>>>>     ? _raw_spin_unlock_irqrestore+0xe/0x40
> >>>>>>     xsk_sendmsg+0xda/0x1c0
> >>>>>>     __sys_sendto+0x1ee/0x200
> >>>>>>     __x64_sys_sendto+0x24/0x30
> >>>>>>     do_syscall_64+0x84/0x2f0
> >>>>>>     ? __pfx_pollwake+0x10/0x10
> >>>>>>     ? __rseq_handle_notify_resume+0xad/0x4c0
> >>>>>>     ? restore_fpregs_from_fpstate+0x3c/0x90
> >>>>>>     ? switch_fpu_return+0x5b/0xe0
> >>>>>>     ? do_syscall_64+0x204/0x2f0
> >>>>>>     ? do_syscall_64+0x204/0x2f0
> >>>>>>     ? do_syscall_64+0x204/0x2f0
> >>>>>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>>>>>     </TASK>
> >>>>>>    [...]
> >>>>>>    Kernel panic - not syncing: Fatal exception in interrupt
> >>>>>>    Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation r=
ange: 0xffffffff80000000-0xffffffffbfffffff)
> >>>>>>
> >>>>>> Instead use the skb destructor_arg pointer along with pointer tagg=
ing.
> >>>>>> As pointers are always aligned to 8B, use the bottom bit to indica=
te
> >>>>>> whether this a single address or an allocated struct containing se=
veral
> >>>>>> addresses.
> >>>>>>
> >>>>>> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
> >>>>>> Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-688=
68474bf1c@nop.hu/
> >>>>>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> >>>>>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> >>>>>
> >>>>> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> >>>>>
> >>>>> Could you also post a patch on top of net-next as it has diverged f=
rom
> >>>>> the net tree?
> >>>>>
> >>>>
> >>>> I think that is handled by maintainers when merging the branches. A
> >>>> repost would be wrong because linux-next.git and linux.git will have=
 a
> >>>> different variant of the same commit..
> >>>
> >>> But this patch cannot be applied cleanly in the net-next tree...
> >>
> >> What we care here is that it applies to net as that's a tree that this
> >> patch has been posted to.
> >
> > It sounds like I can post my approach without this patch on net-next,
> > right? I have no idea how long I should keep waiting :S
> >
> > To be clear, what I meant was to ask Fernando to post a new rebased
> > patch targetting net-next. If the patch doesn't need to land on
> > net-next, I will post it as soon as possible.
> >
>
> My patch landed on net tree and probably soon, net tree changes are
> going to be merged on net-next tree. If there are conflicts when merging
> the patch the maintainer will ask us or they will solve them.

Right, it's a normal routine. I will wait then.

Thanks,
Jason

>
> That was my understanding of how the workflow is.
>
> Thanks,
> Fernando.
>
> > Thanks,
> > Jason
> >
> >>>
> >>>>
> >>>> Please, let me know if I am wrong here.
> >>>
> >>> I'm not quite sure either.
> >>>
> >>> Thanks,
> >>> Jason
> >>>
> >>>>
> >>>> Thanks,
> >>>> Fernando.
>

