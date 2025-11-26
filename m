Return-Path: <netdev+bounces-241721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 735D4C87A9B
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 02:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BD154E1602
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 01:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB881487F6;
	Wed, 26 Nov 2025 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMY/7D+X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7732079DA
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 01:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764119731; cv=none; b=tQdK2ppXCtt4IhpfvjRz5ahUbX3aja3DEptX+4WviVsEQ5FJyOIsr2M8QV+US7EHftW5xLrnHJPMhwObGpL/eOOyiRKfcxzQsaZM5WTiPF7BsMyuJuODcl+jbW0Gu+ap+9gQuvwl4jQfXSwZrzxyqN7QaQRAtT7wAAFGw0m5wUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764119731; c=relaxed/simple;
	bh=SdrG3m5QpKiAf20FeZYsynk1EYREusVaQ8jBlyYX8Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exu301hczZbicuw4XwNHEv0yjImWe7tkEd05DSRefEAAdb6uOmoiQsJJI1QoZGjyVXQRlcsuF79Sdl1NgLJvhcllmYQrRqNNmCJvJZhF1Pfv3/wU+tI3hVhVz/JOKdL7uY+m7vKDrQLkavR4AD4lkHPi+/93HBnUA9QS2UCWfFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMY/7D+X; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-43326c74911so33733125ab.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 17:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764119728; x=1764724528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9ZMN0Qq/AcRlqNun7xu3yj4t/kcK5Yz56eI02+nTB8=;
        b=OMY/7D+XNvgCtvK+pVnRXCN58WXiPKcJTiPqe9OdZJpEvyB5251gRKyS3MLCxLkTkh
         Ts6xmrWtRK/nhfGyzk+xOTzdWpTvNAMZUzGzC5mwtZweyIepcEdaaJSBVZEfrVHS+Pt9
         oviDhZj4TKonW/HFzTeTWplT9NwcL/EaEQCFFHk1EM+hH/CA/KceDflEXiujMbXt6rqj
         psve5q7p/h67AldXgGxNrOVUiKcFmXts3l0o477BmaypQpkiN9gdo7ODlNCnhnc6H5ui
         sHm1RCMe5rHh7f+RYVqBKcRvOISW+UM7/1jNIbWMVS2TPm/Ls9Snkqw8cJc8jJY7Gvlm
         typQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764119728; x=1764724528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m9ZMN0Qq/AcRlqNun7xu3yj4t/kcK5Yz56eI02+nTB8=;
        b=QC68CP+W5xLThGBLjFVoTViqprGsZ+d7vhd2ZCXvoxVBpIJCPSdKx724zKtqkhYKyt
         McGvmL/pVk5EXIbRKdXqN5Gs9bunBoPxBnhKHlqPcbSybDxfIDXY0NCcqG38XQK/2XE8
         A3PWLKVSG9zgy6VIYfK3Gi/+YwrcO9c5dsVX/ObPDzrJ41wdz2V3fQDTNNKMy9BsHjDG
         6w2VKW2wbKcIuUNVQ/icukMPYojm5VUhnptXsn1BpgKpMRg4MZITcrpN/a8rTVdnNGGm
         ghSAUFtTee8mbson7DHNOkPLxwoTvODNjml+9uSo78hALy1+oqN4pKfqBEKGMsluH5Wj
         HbyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6+MVa3gUodvyU4hAoSPfUPH66kpW7pb1tgmWbFmDvF4e1VI7ZpSwQeolwONe0qBX12AcxQX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+hb9DPuEsqqzFD3tAOeIgsgzzyAH3CYFTAK2TqMwDHiFWKPmR
	D0aBZcg+3BMflvzZlgnN7epvrbSKaxOjlaSq4Y0p/KUE2YFdlDiZZA2mbzr/PyGt/zh5oC7Arg5
	BQXjXJ7c0tj7/WUJ1vSMpevTbVNkIfyI=
X-Gm-Gg: ASbGncuMAmh1uNkN/YlhV5yFbLI62MhI7A3cFkRyB816NO9zvXT/yciEjFqk8LCF1gW
	gZZ7EvlFBN2NMVodwSrpyaJQyjA50aYYrev2qWjyPs70uttw+HDKFMrrcUI2FeMfK8oq1yhcWoN
	Pb8SBAoxI60H95r16g0EnHavX8cpX1bBz0E2i/cNsrmtooXaht22YCQpxLc+affJr5UBV9C3aG7
	oUMvc9M2hjkEMbVvQzbhnOz4o7/xLTjUMfgmEPfX0ipzseQDZhz80NX/g0C+isHO/Zlj1s=
X-Google-Smtp-Source: AGHT+IHO7ctCZNPqrO7e8gCRYCtU6LCr4Yi+ew8le9U/+raTHoh1pHg8wC1MFfnVhngFJ2m+VnmjXS4lhaBExLDz+lM=
X-Received: by 2002:a05:6e02:1a83:b0:433:6943:6c70 with SMTP id
 e9e14a558f8ab-435dd0691admr32910095ab.16.1764119728370; Tue, 25 Nov 2025
 17:15:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124171409.3845-1-fmancera@suse.de> <CAL+tcoBKMfVnTtkwBRk9JBGbJtahyJVt4g8swsYRUk1b97LgHQ@mail.gmail.com>
 <955e2de1-32f6-42e3-8358-b8574188ce62@suse.de> <CAL+tcoD83=UXpDaLZZFU2_EDKJS9ew2njLmoH9xeXcg5+E3UDQ@mail.gmail.com>
 <aSXZ37i5CgGKn2RF@boxer>
In-Reply-To: <aSXZ37i5CgGKn2RF@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 26 Nov 2025 09:14:52 +0800
X-Gm-Features: AWmQ_bkU-ABddYlX_U6JaDeYI7FY7iYbGuvbWTRblBgQnK1jVPp4DBHlWLLYPy0
Message-ID: <CAL+tcoBw9OuMcpjy7eQq2=SDWRr+OGszbC+HNgbc_CVw6S=bWQ@mail.gmail.com>
Subject: Re: [PATCH net v6] xsk: avoid data corruption on cq descriptor number
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org, csmate@nop.hu, 
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org, 
	john.fastabend@gmail.com, magnus.karlsson@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 12:31=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Tue, Nov 25, 2025 at 08:11:37PM +0800, Jason Xing wrote:
> > On Tue, Nov 25, 2025 at 7:40=E2=80=AFPM Fernando Fernandez Mancera
> > <fmancera@suse.de> wrote:
> > >
> > > On 11/25/25 12:41 AM, Jason Xing wrote:
> > > > On Tue, Nov 25, 2025 at 1:14=E2=80=AFAM Fernando Fernandez Mancera
> > > > <fmancera@suse.de> wrote:
> > > >>
> > > >> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> > > >> production"), the descriptor number is stored in skb control block=
 and
> > > >> xsk_cq_submit_addr_locked() relies on it to put the umem addrs ont=
o
> > > >> pool's completion queue.
> > > >>
> > > >> skb control block shouldn't be used for this purpose as after tran=
smit
> > > >> xsk doesn't have control over it and other subsystems could use it=
. This
> > > >> leads to the following kernel panic due to a NULL pointer derefere=
nce.
> > > >>
> > > >>   BUG: kernel NULL pointer dereference, address: 0000000000000000
> > > >>   #PF: supervisor read access in kernel mode
> > > >>   #PF: error_code(0x0000) - not-present page
> > > >>   PGD 0 P4D 0
> > > >>   Oops: Oops: 0000 [#1] SMP NOPTI
> > > >>   CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb14=
-cloud-amd64 #1 PREEMPT(lazy)  Debian 6.16.12-1
> > > >>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17=
.0-debian-1.17.0-1 04/01/2014
> > > >>   RIP: 0010:xsk_destruct_skb+0xd0/0x180
> > > >>   [...]
> > > >>   Call Trace:
> > > >>    <IRQ>
> > > >>    ? napi_complete_done+0x7a/0x1a0
> > > >>    ip_rcv_core+0x1bb/0x340
> > > >>    ip_rcv+0x30/0x1f0
> > > >>    __netif_receive_skb_one_core+0x85/0xa0
> > > >>    process_backlog+0x87/0x130
> > > >>    __napi_poll+0x28/0x180
> > > >>    net_rx_action+0x339/0x420
> > > >>    handle_softirqs+0xdc/0x320
> > > >>    ? handle_edge_irq+0x90/0x1e0
> > > >>    do_softirq.part.0+0x3b/0x60
> > > >>    </IRQ>
> > > >>    <TASK>
> > > >>    __local_bh_enable_ip+0x60/0x70
> > > >>    __dev_direct_xmit+0x14e/0x1f0
> > > >>    __xsk_generic_xmit+0x482/0xb70
> > > >>    ? __remove_hrtimer+0x41/0xa0
> > > >>    ? __xsk_generic_xmit+0x51/0xb70
> > > >>    ? _raw_spin_unlock_irqrestore+0xe/0x40
> > > >>    xsk_sendmsg+0xda/0x1c0
> > > >>    __sys_sendto+0x1ee/0x200
> > > >>    __x64_sys_sendto+0x24/0x30
> > > >>    do_syscall_64+0x84/0x2f0
> > > >>    ? __pfx_pollwake+0x10/0x10
> > > >>    ? __rseq_handle_notify_resume+0xad/0x4c0
> > > >>    ? restore_fpregs_from_fpstate+0x3c/0x90
> > > >>    ? switch_fpu_return+0x5b/0xe0
> > > >>    ? do_syscall_64+0x204/0x2f0
> > > >>    ? do_syscall_64+0x204/0x2f0
> > > >>    ? do_syscall_64+0x204/0x2f0
> > > >>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > >>    </TASK>
> > > >>   [...]
> > > >>   Kernel panic - not syncing: Fatal exception in interrupt
> > > >>   Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation ra=
nge: 0xffffffff80000000-0xffffffffbfffffff)
> > > >>
> > > >> Instead use the skb destructor_arg pointer along with pointer tagg=
ing.
> > > >> As pointers are always aligned to 8B, use the bottom bit to indica=
te
> > > >> whether this a single address or an allocated struct containing se=
veral
> > > >> addresses.
> > > >>
> > > >> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
> > > >> Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-688=
68474bf1c@nop.hu/
> > > >> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > >> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> > > >
> > > > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> > > >
> > > > Could you also post a patch on top of net-next as it has diverged f=
rom
> > > > the net tree?
> > > >
> > >
> > > I think that is handled by maintainers when merging the branches. A
> > > repost would be wrong because linux-next.git and linux.git will have =
a
> > > different variant of the same commit..
> >
> > But this patch cannot be applied cleanly in the net-next tree...
>
> What we care here is that it applies to net as that's a tree that this
> patch has been posted to.

It sounds like I can post my approach without this patch on net-next,
right? I have no idea how long I should keep waiting :S

To be clear, what I meant was to ask Fernando to post a new rebased
patch targetting net-next. If the patch doesn't need to land on
net-next, I will post it as soon as possible.

Thanks,
Jason

> >
> > >
> > > Please, let me know if I am wrong here.
> >
> > I'm not quite sure either.
> >
> > Thanks,
> > Jason
> >
> > >
> > > Thanks,
> > > Fernando.

