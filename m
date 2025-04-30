Return-Path: <netdev+bounces-187074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898DDAA4C84
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EEF3B8842
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 13:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807A525F7B9;
	Wed, 30 Apr 2025 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+k6WGku"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E892AE8B
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746018015; cv=none; b=kHoBKgRVT5N9NR1FQEvAIxpcKsURydgPiIOzUyrKoWkJ5TLpdpre48oY8Yoo/Mm0zA8YGXfBlxnJSPUsHXeWcTNGY1A2CtpARge7vBXOZWKk1LX030gsHLiahpt8DT8TcBeHbWT576Z/JhqCPDcRq6miMdOU5/TaDbiF+fN0LJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746018015; c=relaxed/simple;
	bh=Vz5oWI8ZAn9vhYvM7eNEYiDApymK+MKfVHVrsCCoRQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPddkuGhYVGCjX26+3T+1Etr7PNBSw7pStBxqvS8X3BzZjcprEJQSdRunLB6hK032t7STf61+LoMV8QCKROYofCjTmp0ZcwC++oZAz9Z1m+/0CLuJVMcZ0FEXgsp4IDzmMU97KYLZf30cfek3Aetin/3qtlIv+sdsiZ0MjKd+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+k6WGku; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5f62d3ed994so528708a12.2
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 06:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746018011; x=1746622811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+DYJDxXcqILpnqG9bHNtG/qhQrQSSUbxz2lrQm8R3k=;
        b=I+k6WGkuAPzKgQTBq0KsBoMF1L1VGjd0NTozt5WtiXrMA2QjteZGo9tOBrCYEblINQ
         zEfLyAlFRDPEgbRAXXMLIjDgxPK/CyCc0T2ktm6Hqt4labMl5vruYuU88w3a5YpUskNM
         55qOx5Mx5GX7hXHzxVis69KnJrCTSbLs5VCxLF9XanbydKgito6Zkt5Lqx6T8Ymqxc9Q
         KeLMV5QiguBiQ9e2mIbDNi2n1X6xEH7VCe5gmCCRxFbFLMs7cveApzbxfDSi7o2UtpXP
         Nd9L/t8VoNDOifVX2djRvQHLqUwajp2iF31s8/CwVOoFb7uv09m7zEBPaF/zSoLV5XNl
         u9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746018011; x=1746622811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+DYJDxXcqILpnqG9bHNtG/qhQrQSSUbxz2lrQm8R3k=;
        b=UzkxS8F627VOeRQMoTbd2oWXVBfSXXTNSfhZ/a8PLJ/CTqKQmuVrolqWY5fl2jbE57
         o+PuxU/sabG8+rtupzyCQNTzF6Vfne50O7r61KZFKaIC1CYw+qxNdy8gLWutf0YVVz2W
         /CvtBWihdx/C9S0Z7Nc7CK3ERQUZiRcSwRfnT06aSxRkuyQU4FwsNI5V0WUOBJjlIhfh
         I79VCm7CFrAr5XbT2ohui4tdTuP0v6SPZpkFUCX2Ev7KUZFTN5sqbJJPBFewnIL3XZXs
         QvwHNhcizMg9sgi5YrgTMdtWb3VI1sOeQx12mgq/wP1MxS3sfmOOrRDXK4sUNAT1ufya
         4t7g==
X-Forwarded-Encrypted: i=1; AJvYcCV0qTUIAGQwPqEO35vnEbk8HT05J2NUy7sWrt5jgZv8K8uFLDBzJ1nAXRBxGZXOYv77THnzrbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YybtWIALHyIpbQNqOWVz1/G3+QMsz4/2M0UFXQziLQo79VFlY89
	gvFIb6CxXV30v531cGr3ABR8+6E9CL7S3JiFbTyddXeG/jY6WTUeC6jzHiKoD6KAk+CeeEGcUK3
	/oHbO+wAA15jJV9kGUaKKMIdWtoU=
X-Gm-Gg: ASbGncs1mx3Bc3WDi9tNR7WkVJbOwv2qhgSyDy+7nep5RDkMze44RNdaY0kTHHVtLwI
	umtdQFGc2hO6FnaG+4oWaF1Cx5t0A46iNJplTtexrg+jwwn4pmETkz31wUfy9YDaQoSSlPqaxBS
	94FqPaC232AsXemAkYvxHUcks=
X-Google-Smtp-Source: AGHT+IH1w4gM6ENMZg8MCMHcw2gq/uNhccO80qwldSRAnQEUMh4A1rW7ENoXBMecXlQh7wjUnD2m1sXLcE2Owp/KeAM=
X-Received: by 2002:a05:6402:2155:b0:5f8:e6de:fd0f with SMTP id
 4fb4d7f45d1cf-5f8e6df0554mr314330a12.15.1746018011144; Wed, 30 Apr 2025
 06:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424125547.460632-1-vadfed@meta.com>
In-Reply-To: <20250424125547.460632-1-vadfed@meta.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 30 Apr 2025 21:59:59 +0900
X-Gm-Features: ATxdqUG9Tq38K_hj964uL7A6SX4-G5Cj20IRJymJ7CGLGnTyf5pTj-y-o192iL0
Message-ID: <CAMArcTWDe2cd41=ub=zzvYifaYcYv-N-csxfqxUvejy_L0D6UQ@mail.gmail.com>
Subject: Re: [PATCH net v4] bnxt_en: improve TX timestamping FIFO configuration
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Jakub Kicinski <kuba@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 10:11=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com> =
wrote:
>

Hi Vadim,
Thanks for this work!

> Reconfiguration of netdev may trigger close/open procedure which can
> break FIFO status by adjusting the amount of empty slots for TX
> timestamps. But it is not really needed because timestamps for the
> packets sent over the wire still can be retrieved. On the other side,
> during netdev close procedure any skbs waiting for TX timestamps can be
> leaked because there is no cleaning procedure called. Free skbs waiting
> for TX timestamps when closing netdev.
>
> Fixes: 8aa2a79e9b95 ("bnxt_en: Increase the max total outstanding PTP TX =
packets to 4")
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
> v3 -> v4:
> * actually remove leftover unused variable in bnxt_ptp_clear()
> (v3 was not committed before preparing unfortunately)
> v2 -> v3:
> * remove leftover unused variable in bnxt_ptp_clear()
> v1 -> v2:
> * move clearing of TS skbs to bnxt_free_tx_skbs
> * remove spinlock as no TX is possible after bnxt_tx_disable()
> * remove extra FIFO clearing in bnxt_ptp_clear()
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  5 ++--
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 29 ++++++++++++++-----
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  1 +
>  3 files changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index c8e3468eee61..2c8e2c19d854 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -3414,6 +3414,9 @@ static void bnxt_free_tx_skbs(struct bnxt *bp)
>
>                 bnxt_free_one_tx_ring_skbs(bp, txr, i);
>         }
> +
> +       if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
> +               bnxt_ptp_free_txts_skbs(bp->ptp_cfg);
>  }
>
>  static void bnxt_free_one_rx_ring(struct bnxt *bp, struct bnxt_rx_ring_i=
nfo *rxr)
> @@ -12797,8 +12800,6 @@ static int __bnxt_open_nic(struct bnxt *bp, bool =
irq_re_init, bool link_re_init)
>         /* VF-reps may need to be re-opened after the PF is re-opened */
>         if (BNXT_PF(bp))
>                 bnxt_vf_reps_open(bp);
> -       if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
> -               WRITE_ONCE(bp->ptp_cfg->tx_avail, BNXT_MAX_TX_TS);
>         bnxt_ptp_init_rtc(bp, true);
>         bnxt_ptp_cfg_tstamp_filters(bp);
>         if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_ptp.c
> index 2d4e19b96ee7..0669d43472f5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> @@ -794,6 +794,27 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_in=
fo *ptp_info)
>         return HZ;
>  }
>
> +void bnxt_ptp_free_txts_skbs(struct bnxt_ptp_cfg *ptp)
> +{
> +       struct bnxt_ptp_tx_req *txts_req;
> +       u16 cons =3D ptp->txts_cons;
> +
> +       /* make sure ptp aux worker finished with
> +        * possible BNXT_STATE_OPEN set
> +        */
> +       ptp_cancel_worker_sync(ptp->ptp_clock);
> +
> +       ptp->tx_avail =3D BNXT_MAX_TX_TS;
> +       while (cons !=3D ptp->txts_prod) {
> +               txts_req =3D &ptp->txts_req[cons];
> +               if (!IS_ERR_OR_NULL(txts_req->tx_skb))
> +                       dev_kfree_skb_any(txts_req->tx_skb);
> +               cons =3D NEXT_TXTS(cons);
> +       }
> +       ptp->txts_cons =3D cons;
> +       ptp_schedule_worker(ptp->ptp_clock, 0);
> +}
> +
>  int bnxt_ptp_get_txts_prod(struct bnxt_ptp_cfg *ptp, u16 *prod)
>  {
>         spin_lock_bh(&ptp->ptp_tx_lock);
> @@ -1105,7 +1126,6 @@ int bnxt_ptp_init(struct bnxt *bp)
>  void bnxt_ptp_clear(struct bnxt *bp)
>  {
>         struct bnxt_ptp_cfg *ptp =3D bp->ptp_cfg;
> -       int i;
>
>         if (!ptp)
>                 return;
> @@ -1117,12 +1137,5 @@ void bnxt_ptp_clear(struct bnxt *bp)
>         kfree(ptp->ptp_info.pin_config);
>         ptp->ptp_info.pin_config =3D NULL;
>
> -       for (i =3D 0; i < BNXT_MAX_TX_TS; i++) {
> -               if (ptp->txts_req[i].tx_skb) {
> -                       dev_kfree_skb_any(ptp->txts_req[i].tx_skb);
> -                       ptp->txts_req[i].tx_skb =3D NULL;
> -               }
> -       }
> -
>         bnxt_unmap_ptp_regs(bp);
>  }
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_ptp.h
> index a95f05e9c579..0481161d26ef 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
> @@ -162,6 +162,7 @@ int bnxt_ptp_cfg_tstamp_filters(struct bnxt *bp);
>  void bnxt_ptp_reapply_pps(struct bnxt *bp);
>  int bnxt_hwtstamp_set(struct net_device *dev, struct ifreq *ifr);
>  int bnxt_hwtstamp_get(struct net_device *dev, struct ifreq *ifr);
> +void bnxt_ptp_free_txts_skbs(struct bnxt_ptp_cfg *ptp);
>  int bnxt_ptp_get_txts_prod(struct bnxt_ptp_cfg *ptp, u16 *prod);
>  void bnxt_get_tx_ts_p5(struct bnxt *bp, struct sk_buff *skb, u16 prod);
>  int bnxt_get_rx_ts_p5(struct bnxt *bp, u64 *ts, u32 pkt_ts);
> --
> 2.47.1
>
>

I=E2=80=99ve encountered a kernel panic that I think is related to this pat=
ch.
Could you please investigate it?

Reproducer:
    ip link set $interface up
    modprobe -rv bnxt_en

Splat looks like:
Oops: general protection fault, probably for non-canonical address
0xdffffc00000000fd:I
KASAN: null-ptr-deref in range [0x00000000000007e8-0x00000000000007ef]
CPU: 2 UID: 0 PID: 1963 Comm: modprobe Not tainted 6.15.0-rc3+ #5
PREEMPT(undef)  78b5b
RIP: 0010:__kthread_cancel_work_sync (/kernel/kthread.c:1476)
Code: 00 48 b8 00 00 00 00 00 fc ff df 41 57 4c 8d 7f 18 41 56 4c 89
fa 41 55 48 c1 ea4

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   00 48 b8                add    %cl,-0x48(%rax)
   3:   00 00                   add    %al,(%rax)
   5:   00 00                   add    %al,(%rax)
   7:   00 fc                   add    %bh,%ah
   9:   ff                      (bad)
   a:   df 41 57                filds  0x57(%rcx)
   d:   4c 8d 7f 18             lea    0x18(%rdi),%r15
  11:   41 56                   push   %r14
  13:   4c 89 fa                mov    %r15,%rdx
  16:   41 55                   push   %r13
  18:   48                      rex.W
  19:   c1                      .byte 0xc1
  1a:   a4                      movsb  %ds:(%rsi),%es:(%rdi)
RSP: 0018:ffff888111857608 EFLAGS: 00010292
RAX: dffffc0000000000 RBX: 00000000000007d0 RCX: ffff8881330ece8e
RDX: 00000000000000fd RSI: 0000000000000001 RDI: 00000000000007d0
RBP: ffff888198ad8e00 R08: 0000000000000001 R09: ffff888198b800d8
R10: ffff888198b8019f R11: 0000000000000000 R12: ffff888198ad9008
R13: 0000000000000001 R14: ffff888198ad8e88 R15: 00000000000007e8
FS:  00007f831f921080(0000) GS:ffff888888405000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005655646882e0 CR3: 000000014c52e000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
<TASK>
bnxt_ptp_free_txts_skbs
(/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:807) bnxt_en
__bnxt_close_nic.constprop.0
(/drivers/net/ethernet/broadcom/bnxt/bnxt.c:3513
/drivers/net/ethernet/broadcom/bnxt/bnxt.c:3523
/drivers/net/ethernet/broadcom/bnxt/bnxt.c:12965) bnxt_en
? __lock_acquire (/kernel/locking/lockdep.c:5246)
? __pfx___bnxt_close_nic.constprop.0
(/drivers/net/ethernet/broadcom/bnxt/bnxt.c:12940) bnxt_en
bnxt_close_nic (/drivers/net/ethernet/broadcom/bnxt/bnxt.c:12980) bnxt_en
? do_raw_spin_trylock (/./arch/x86/include/asm/atomic.h:107
/./include/linux/atomic/atomic-arch-fallback.h:2170
/./include/linux/atomic/atomic-instrumented.h:1302
/./include/asm-generic/qspinlock.h:97
/kernel/locking/spinlock_debug.c:123)
? __pfx_bnxt_close_nic
(/drivers/net/ethernet/broadcom/bnxt/bnxt.c:12980) bnxt_en
? __local_bh_enable_ip (/./arch/x86/include/asm/irqflags.h:42
/./arch/x86/include/asm/irqflags.h:119 /kernel/softirq.c:412)
? lockdep_hardirqs_on (/./arch/x86/include/generated/asm/syscalls_64.h:316)
? dev_deactivate_many (/net/sched/sch_generic.c:1325
/net/sched/sch_generic.c:1383)
? __local_bh_enable_ip (/./arch/x86/include/asm/irqflags.h:42
/./arch/x86/include/asm/irqflags.h:119 /kernel/softirq.c:412)
bnxt_close (/drivers/net/ethernet/broadcom/bnxt/bnxt.c:12215
/drivers/net/ethernet/broadcom/bnxt/bnxt.c:13015) bnxt_en
? __pfx_bnxt_close (/drivers/net/ethernet/broadcom/bnxt/bnxt.c:13011) bnxt_=
en
? notifier_call_chain (/kernel/notifier.c:85)
__dev_close_many (/net/core/dev.c:1702)
? __pfx___dev_close_many (/net/core/dev.c:1663)
? __pfx___mutex_lock (/arch/x86/entry/syscall_32.c:46)
dev_close_many (/net/core/dev.c:1729)
? __pfx_dev_close_many (/net/core/dev.c:1719)
unregister_netdevice_many_notify (/net/core/dev.c:11946)
? rcu_is_watching (/./include/linux/context_tracking.h:128
/kernel/rcu/tree.c:736)
? __mutex_lock (/arch/x86/entry/syscall_32.c:46)
? __pfx_unregister_netdevice_many_notify (/net/core/dev.c:11909)
? rtnl_net_dev_lock (/net/core/dev.c:2093)
? __pfx___mutex_lock (/arch/x86/entry/syscall_32.c:46)
unregister_netdevice_queue (/net/core/dev.c:11891)
? __pfx_unregister_netdevice_queue (/net/core/dev.c:11880)
? rtnl_net_dev_lock (/./include/linux/rcupdate.h:331
/./include/linux/rcupdate.h:841 /net/core/dev.c:2084)
? rtnl_net_dev_lock (/net/core/dev.c:2093)
unregister_netdev (/./include/net/net_namespace.h:409
/./include/linux/netdevice.h:2708 /net/core/dev.c:2104
/net/core/dev.c:12065)
bnxt_remove_one (/drivers/net/ethernet/broadcom/bnxt/bnxt.c:16012) bnxt_en
pci_device_remove (/drivers/pci/pci-driver.c:474)
device_release_driver_internal (/drivers/base/dd.c:1275 /drivers/base/dd.c:=
1296)
driver_detach (/drivers/base/dd.c:1360)
bus_remove_driver (/drivers/base/bus.c:748)
pci_unregister_driver (/./include/linux/spinlock.h:351
/drivers/pci/pci-driver.c:85 /drivers/pci/pci-driver.c:1465)
bnxt_exit (/drivers/net/ethernet/broadcom/bnxt/bnxt.c:1588) bnxt_en
__do_sys_delete_module.constprop.0 (/kernel/module/main.c:781)
? __pfx___do_sys_delete_module.constprop.0 (/kernel/module/main.c:724)
? __pfx_rseq_syscall (/kernel/rseq.c:458)
? ksys_write (/fs/read_write.c:736)
? __pfx_ksys_write (/fs/read_write.c:726)
? rcu_is_watching (/./include/linux/context_tracking.h:128
/kernel/rcu/tree.c:736)
? do_syscall_64 (/./include/trace/events/initcall.h:10)
do_syscall_64 (/./include/trace/events/initcall.h:10)
entry_SYSCALL_64_after_hwframe (/./include/trace/events/initcall.h:27)
RIP: 0033:0x7f831f12ac9b
Code: 73 01 c3 48 8b 0d 7d 81 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66
2e 0f 1f 84 00 008

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   73 01                   jae    0x3
   2:   c3                      ret
   3:   48 8b 0d 7d 81 0d 00    mov    0xd817d(%rip),%rcx        # 0xd8187
   a:   f7 d8                   neg    %eax
   c:   64 89 01                mov    %eax,%fs:(%rcx)
   f:   48 83 c8 ff             or     $0xffffffffffffffff,%rax
  13:   c3                      ret
  14:   66                      data16
  15:   2e                      cs
  16:   0f                      .byte 0xf
  17:   1f                      (bad)
  18:   84 00                   test   %al,(%rax)
  1a:   08                      .byte 0x8
RSP: 002b:00007ffdfb651448 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
RAX: ffffffffffffffda RBX: 000055fb93ae5fa0 RCX: 00007f831f12ac9b
RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055fb93ae6008
RBP: 00007ffdfb651470 R08: 0000000000000073 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 0000000000000000
R13: 00007ffdfb6514a0 R14: 0000000000000000 R15: 0000000000000000
</TASK>
Modules linked in: xt_nat xt_tcpudp veth xt_conntrack nft_chain_nat
xt_MASQUERADE nf_c]
---[ end trace 0000000000000000 ]---
RIP: 0010:__kthread_cancel_work_sync (/kernel/kthread.c:1476)
Code: 00 48 b8 00 00 00 00 00 fc ff df 41 57 4c 8d 7f 18 41 56 4c 89
fa 41 55 48 c1 ea4

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   00 48 b8                add    %cl,-0x48(%rax)
   3:   00 00                   add    %al,(%rax)
   5:   00 00                   add    %al,(%rax)
   7:   00 fc                   add    %bh,%ah
   9:   ff                      (bad)
   a:   df 41 57                filds  0x57(%rcx)
   d:   4c 8d 7f 18             lea    0x18(%rdi),%r15
  11:   41 56                   push   %r14
  13:   4c 89 fa                mov    %r15,%rdx
  16:   41 55                   push   %r13
  18:   48                      rex.W
  19:   c1                      .byte 0xc1
  1a:   a4                      movsb  %ds:(%rsi),%es:(%rdi)
RSP: 0018:ffff888111857608 EFLAGS: 00010292
RAX: dffffc0000000000 RBX: 00000000000007d0 RCX: ffff8881330ece8e
RDX: 00000000000000fd RSI: 0000000000000001 RDI: 00000000000007d0
RBP: ffff888198ad8e00 R08: 0000000000000001 R09: ffff888198b800d8
R10: ffff888198b8019f R11: 0000000000000000 R12: ffff888198ad9008
R13: 0000000000000001 R14: ffff888198ad8e88 R15: 00000000000007e8
FS:  00007f831f921080(0000) GS:ffff888888405000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005655646882e0 CR3: 000000014c52e000 CR4: 00000000007506f0
PKRU: 55555554
Kernel panic - not syncing: Fatal exception
Kernel Offset: 0x6000000 from 0xffffffff81000000 (relocation range:
0xffffffff80000000)

Thanks a lot!
Taehee Yoo

