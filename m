Return-Path: <netdev+bounces-241337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F29BAC82D4E
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 00:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8C53AA356
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 23:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC522D0607;
	Mon, 24 Nov 2025 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMJaBaVM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8862BDC0B
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764027749; cv=none; b=LXK9GIoGtPkFtqPMGZIBeSc9GylJNwTbqeBkdRVh08Eu48qBxyaXJEi0MZJTgcDENVG2NKS55ufnfiSrb/5shs89D6bmOeNilPPcEY/L34fVAl5XNMqJze3AMKyO6A6jo3N7y1IQSQdh+3Lb+CUaopp+KEIs5TgXDAUvg8awLAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764027749; c=relaxed/simple;
	bh=dG0C2S+L2R3WtJH9tdP29ghbxSjbg7+VtnphMfrKoEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8UhlcC7flVL5ZlARibDKPztr6kIZTN07nPI6cxIPSjSuh6h48nDtYdzWd8/xSFX3E2GWzcaYNpUlPAtTnET6Z5VXlaXad5rIL0staAICVD/9tFfEosuXWRvyfpClJ+T2LngWM3mxp3FO3m1KBdwcdyABCBvfusdUJv5j67mlIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMJaBaVM; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-43326c74911so26725765ab.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 15:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764027746; x=1764632546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3apy2CyU2bh8Lc5v04oP/DIoqnkdbNgF8gnG9rkBtU=;
        b=bMJaBaVMEP48YG5KtvpQpg8hEB9ObXzr+cpsLlC/ftRYlS9xrWo/R98eW4yebHSuOz
         qRtY9DpUakEqSLLb7S8SVAiNJsIdfTnWSApy4lQFnn3r1GnIX4tCnJRLaWTwV0rDyk5X
         sVwqqWUnnRwNrTrx5h0BcpQGv/wVydCRvfzmoR3phRk6XVbdeiM51D5r1D+HyDmNkbZf
         uxkfnG5tfIONQPqHLqIDJYqZEa9s3ZT9UTrYja+CNfzBHlmtRgrSbAoZ/31wjYEOZM1v
         +f69kBms98OWDyeikSt1nHHVeDeyesRqiaC7NtTpGeoem+vn84C8ZNv9uXkU01yoKUTC
         LcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764027746; x=1764632546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w3apy2CyU2bh8Lc5v04oP/DIoqnkdbNgF8gnG9rkBtU=;
        b=gKAfeZuUvi3aObZX+Ejqj2BLNOdHCmtU7v04mMQ6NKtvJI7knuREEyKXzfUkhw56yJ
         WFjeNsYQRaBMja+2Df/qn9C/myNwezBbbFduCkrbvwGXhVMbV/R26EgGzL0qsSzTDbfo
         7n6jcaO4gqnS2fcI0N01PRNpH9ciN2m7HO0cZZb+f6T2Zdo84ii5UgGbzp3/TXzoy6ZX
         f45696kTBfIl2raSTShG+d0KA/KwdVr8isfKxB1JFaRT+lQdm8q2sm7D0btKqE365iCR
         6d0uoQGJMlQDOUQv0P3h6jh3fN70BOoQYu+X9Rkvcg+PsylMcQXBL67Mj3TKgSK4DWOx
         HcMA==
X-Gm-Message-State: AOJu0YyjDt4MNzTJeZbwfudjS+vRreofjQ0BnK6Qa7qJturyZn/mv/3i
	C/YETF6Rw5WdWy3SFN2galp8u9wzMs811AvmLDskZ7AIMOz04ghBAFGIRTf7ZQrxr8q/CdVBeVf
	sDCWlEPpJtkX083xWlD5S/BfBPbM+ViI=
X-Gm-Gg: ASbGnctAGeiy+t3c01lrjXNyEWl2z4GpnFa14yF7bxTvE97epPXf+M4VD/lk7AUgyrO
	uDVJkVPjVyo4RvMoisGs93VrA7WZCMm8RgYu1kh3kJDkUlenAjHLzwvMCTU/AsqQmI6JX+ETita
	1hSj1iZKK0/4QaUYbyARwCLgPsn2SBFe9b0QJuKTH4hSv2Jm7iSyxkGUJRvDCDVZeWxgheM0u+B
	yJh5L0bBwJc7Gz+Vuznn2JrM/eokDzpusSf0ZX36MdD81Hsm8NewqyDoQ1zrGT4UPRMNfs=
X-Google-Smtp-Source: AGHT+IFhjvOgyNk/ahK1jKtOHPvBR51MmjnhrjCGQLG42lR8Yu6Hk1kGORg6yuxlKqs/mXoSn5MuPF95NqWv2N9KyMk=
X-Received: by 2002:a05:6e02:1a06:b0:433:4f6b:4ca with SMTP id
 e9e14a558f8ab-435dd0de78cmr7882615ab.24.1764027746430; Mon, 24 Nov 2025
 15:42:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124171409.3845-1-fmancera@suse.de>
In-Reply-To: <20251124171409.3845-1-fmancera@suse.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 25 Nov 2025 07:41:50 +0800
X-Gm-Features: AWmQ_bnE-Ua7Eq7VP_JZmltG_86Z7uUmIs67PUNX4Qyc6wi6NWDFRmM2Qm4MzIQ
Message-ID: <CAL+tcoBKMfVnTtkwBRk9JBGbJtahyJVt4g8swsYRUk1b97LgHQ@mail.gmail.com>
Subject: Re: [PATCH net v6] xsk: avoid data corruption on cq descriptor number
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, csmate@nop.hu, maciej.fijalkowski@intel.com, 
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org, 
	john.fastabend@gmail.com, magnus.karlsson@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 1:14=E2=80=AFAM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> production"), the descriptor number is stored in skb control block and
> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
> pool's completion queue.
>
> skb control block shouldn't be used for this purpose as after transmit
> xsk doesn't have control over it and other subsystems could use it. This
> leads to the following kernel panic due to a NULL pointer dereference.
>
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb14-cloud-a=
md64 #1 PREEMPT(lazy)  Debian 6.16.12-1
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debia=
n-1.17.0-1 04/01/2014
>  RIP: 0010:xsk_destruct_skb+0xd0/0x180
>  [...]
>  Call Trace:
>   <IRQ>
>   ? napi_complete_done+0x7a/0x1a0
>   ip_rcv_core+0x1bb/0x340
>   ip_rcv+0x30/0x1f0
>   __netif_receive_skb_one_core+0x85/0xa0
>   process_backlog+0x87/0x130
>   __napi_poll+0x28/0x180
>   net_rx_action+0x339/0x420
>   handle_softirqs+0xdc/0x320
>   ? handle_edge_irq+0x90/0x1e0
>   do_softirq.part.0+0x3b/0x60
>   </IRQ>
>   <TASK>
>   __local_bh_enable_ip+0x60/0x70
>   __dev_direct_xmit+0x14e/0x1f0
>   __xsk_generic_xmit+0x482/0xb70
>   ? __remove_hrtimer+0x41/0xa0
>   ? __xsk_generic_xmit+0x51/0xb70
>   ? _raw_spin_unlock_irqrestore+0xe/0x40
>   xsk_sendmsg+0xda/0x1c0
>   __sys_sendto+0x1ee/0x200
>   __x64_sys_sendto+0x24/0x30
>   do_syscall_64+0x84/0x2f0
>   ? __pfx_pollwake+0x10/0x10
>   ? __rseq_handle_notify_resume+0xad/0x4c0
>   ? restore_fpregs_from_fpstate+0x3c/0x90
>   ? switch_fpu_return+0x5b/0xe0
>   ? do_syscall_64+0x204/0x2f0
>   ? do_syscall_64+0x204/0x2f0
>   ? do_syscall_64+0x204/0x2f0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   </TASK>
>  [...]
>  Kernel panic - not syncing: Fatal exception in interrupt
>  Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation range: 0xf=
fffffff80000000-0xffffffffbfffffff)
>
> Instead use the skb destructor_arg pointer along with pointer tagging.
> As pointers are always aligned to 8B, use the bottom bit to indicate
> whether this a single address or an allocated struct containing several
> addresses.
>
> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
> Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-68868474bf=
1c@nop.hu/
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Could you also post a patch on top of net-next as it has diverged from
the net tree?

Thanks,
Jason

