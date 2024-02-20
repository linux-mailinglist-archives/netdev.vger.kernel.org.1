Return-Path: <netdev+bounces-73453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A52485CA48
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 22:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744651F23269
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 21:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED42C152DE4;
	Tue, 20 Feb 2024 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JHJBYgsx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103514A4E6
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708466268; cv=none; b=Kosp6GKe46EgJStpccc0h56PmTh/a+tSFcgrRSjKbB0o5YQkJ+Bk95BAyggnaGtfY+s5cHFJz4/mkM+zJ7OimbxuKx/WU7rmBiK0HfCcdiB/OUullonYBgrZdcLamuK4fhLOE0r+bkErPHRC5EjMQyMF5GCgjzvVj4Rap0E7WxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708466268; c=relaxed/simple;
	bh=44pBp+NfcxKYpVo79/NWuv6LTph1YieIjoqPlYyRJXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGxLsvNmJXWPDrE3QeSCDVI1o9jyQa+fc5UNWgfZPMGyGx/pq84Dr6b4QXETxvCCfUlV+IU+s/59U2SyNIT9b3/KmYEWba62W6OnVO4m0gqU7c+wchkuCqS72f9mjKd1EGLKar8/TYS8kwrliVzHMMDYs+5sukf7CoFkhkCdzd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JHJBYgsx; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4cb031cd5deso470343e0c.1
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 13:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708466266; x=1709071066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSpWI5lBL6tgmjpGFVfLRNofd/k4k9bDnsh2+MD9SCo=;
        b=JHJBYgsxPttFdUszwpFTwaONGU0cNWhP2zYerI3TeC8EtInAZ45R7aHnuBQmjQTNUX
         ecswCqZqY251F0KyT4xhMi/iADckVP41WCm84cY+b/DuddNGXVEl5T0DLJhY3Yhvva29
         rWEzUER8VE9CdBQpGo2vAz9y12OwFhTPeE0lM36EDDCiOcDLtcIdsjwWcWW1hevFkCG2
         wZ5RAlR5KmKf+Y1VUmt+glQOwzO54DYE6t9qgUE//6yaimOj424oHwkCd18MdVtufONX
         cdEG5pgTld2IwECsq/kLHwmV/9Zdog41hbbR+TGqyvleap7eFUKi7TXeDAud398YbsKE
         lpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708466266; x=1709071066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSpWI5lBL6tgmjpGFVfLRNofd/k4k9bDnsh2+MD9SCo=;
        b=RcsNaKpVbIm/dov+jICPIITrsdQTZgC3NEy8TIoy6233XmcQ5I3bYpqjXQB7yzJObb
         4hi/GWDYqkA0UNdPR3n9YkgLw9g2xF+4Ry9qzpiBsP8hBQUOKrpL+ai08ocvJsjYBrIr
         clXMlwiexxKOOQrm1O8zMIOeP4Ti2ppmCiinPX1WA3a2iO+5YiQPQd3HHa6ot+C134y0
         5C/hLRpTlyEWqUo1hWxU4xjDNZHyOsUduiufcLv3XmU0iWsbAm0leeApetPOksHlAZca
         vU2TjUqFwF78aLrXztD1KXXP9wtuQXw9iP6KU7NcWdsezi0QqKBR1sRpqItKM0cgEv+R
         wJug==
X-Forwarded-Encrypted: i=1; AJvYcCW2budQ6yOVsQ5OzYn3hVEybdZD12TmaaXOl8S2U/b5V9piSniMN6eopMNrylfv6NXTRqiskioXIOjN+syyuDp+cSc/cgod
X-Gm-Message-State: AOJu0YyZXb5T8LuM7vJc0EAJEO7iEO5zfi+68j6Q7oOXj3xq/OsEqa/j
	uiQisHvNpzDJy8JNhwZIPLSSJCBooAFMIKYinaKl8Mf1YPxP0GUuX1L7JUu+96+H4mS3qe1buWt
	+HOXMfE3zzPAvgfAnSI36o9byw8GAczHXrtbI
X-Google-Smtp-Source: AGHT+IEW/K0rXYhBz1qch8TBVtM2dF+wzjNpVHrueOGsgTKK/Zo/SLGjIJZFua69rkeJ4s8ZhLOWhbvMe3z3RjFdd64=
X-Received: by 2002:a1f:ec83:0:b0:4d1:34a1:c05f with SMTP id
 k125-20020a1fec83000000b004d134a1c05fmr130513vkh.0.1708466265794; Tue, 20 Feb
 2024 13:57:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87r0h7wg8u.fsf@kurt.kurt.home> <7dnkkpc5rv6bvreaxa7v4sx4kftjvv4vna4zqk4bihfcx5a3nb@suv6nsve6is4>
 <ZdS6d0RNeICJjO+q@boxer>
In-Reply-To: <ZdS6d0RNeICJjO+q@boxer>
From: Stanislav Fomichev <sdf@google.com>
Date: Tue, 20 Feb 2024 13:57:32 -0800
Message-ID: <CAKH8qBs+TBRHhx0ZqMABCsGZ8sbXtSZMeFuP73-=hY69Wpfn8g@mail.gmail.com>
Subject: Re: stmmac and XDP/ZC issue
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Song Yoong Siang <yoong.siang.song@intel.com>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 6:43=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Tue, Feb 20, 2024 at 04:18:54PM +0300, Serge Semin wrote:
> > Hi Kurt
> >
> > On Tue, Feb 20, 2024 at 12:02:25PM +0100, Kurt Kanzenbach wrote:
> > > Hello netdev community,
> > >
> > > after updating to v6.8 kernel I've encountered an issue in the stmmac
> > > driver.
> > >
> > > I have an application which makes use of XDP zero-copy sockets. It wo=
rks
> > > on v6.7. On v6.8 it results in the stack trace shown below. The progr=
am
> > > counter points to:
> > >
> > >  - ./include/net/xdp_sock.h:192 and
> > >  - ./drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:2681
> > >
> > > It seems to be caused by the XDP meta data patches. This one in
> > > particular 1347b419318d ("net: stmmac: Add Tx HWTS support to XDP ZC"=
).
> > >
> > > To reproduce:
> > >
> > >  - Hardware: imx93
> > >  - Run ptp4l/phc2sys
> > >  - Configure Qbv, Rx steering, NAPI threading
> > >  - Run my application using XDP/ZC on queue 1
> > >
> > > Any idea what might be the issue here?
> > >
> > > Thanks,
> > > Kurt
> > >
> > > Stack trace:
> > >
> > > |[  169.248150] imx-dwmac 428a0000.ethernet eth1: configured EST
> > > |[  191.820913] imx-dwmac 428a0000.ethernet eth1: EST: SWOL has been =
switched
> > > |[  226.039166] imx-dwmac 428a0000.ethernet eth1: entered promiscuous=
 mode
> > > |[  226.203262] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_P=
AGE_POOL RxQ-0
> > > |[  226.203753] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_P=
AGE_POOL RxQ-1
> > > |[  226.303337] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_X=
SK_BUFF_POOL RxQ-1
> > > |[  255.822584] Unable to handle kernel NULL pointer dereference at v=
irtual address 0000000000000000
> > > |[  255.822602] Mem abort info:
> > > |[  255.822604]   ESR =3D 0x0000000096000044
> > > |[  255.822608]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > > |[  255.822613]   SET =3D 0, FnV =3D 0
> > > |[  255.822616]   EA =3D 0, S1PTW =3D 0
> > > |[  255.822618]   FSC =3D 0x04: level 0 translation fault
> > > |[  255.822622] Data abort info:
> > > |[  255.822624]   ISV =3D 0, ISS =3D 0x00000044, ISS2 =3D 0x00000000
> > > |[  255.822627]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
> > > |[  255.822630]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > > |[  255.822634] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000085=
fe1000
> > > |[  255.822638] [0000000000000000] pgd=3D0000000000000000, p4d=3D0000=
000000000000
> > > |[  255.822650] Internal error: Oops: 0000000096000044 [#1] PREEMPT_R=
T SMP
> > > |[  255.822655] Modules linked in:
> > > |[  255.822660] CPU: 0 PID: 751 Comm: napi/eth1-261 Not tainted 6.8.0=
-rc4-rt4-00100-g9c63d995ca19 #8
> > > |[  255.822666] Hardware name: NXP i.MX93 11X11 EVK board (DT)
> > > |[  255.822669] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS=
 BTYPE=3D--)
> > > |[  255.822674] pc : stmmac_tx_clean.constprop.0+0x848/0xc38
> > > |[  255.822690] lr : stmmac_tx_clean.constprop.0+0x844/0xc38
> > > |[  255.822696] sp : ffff800085ec3bc0
> > > |[  255.822698] x29: ffff800085ec3bc0 x28: ffff000005b609e0 x27: 0000=
000000000001
> > > |[  255.822706] x26: 0000000000000000 x25: ffff000005b60ae0 x24: 0000=
000000000001
> > > |[  255.822712] x23: 0000000000000001 x22: ffff000005b649e0 x21: 0000=
000000000000
> > > |[  255.822719] x20: 0000000000000020 x19: ffff800085291030 x18: 0000=
000000000000
> > > |[  255.822725] x17: ffff7ffffc51c000 x16: ffff800080000000 x15: 0000=
000000000008
> > > |[  255.822732] x14: ffff80008369b880 x13: 0000000000000000 x12: 0000=
000000008507
> > > |[  255.822738] x11: 0000000000000040 x10: 0000000000000a70 x9 : ffff=
800080e32f84
> > > |[  255.822745] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000=
000000003ff0
> > > |[  255.822751] x5 : 0000000000003c40 x4 : ffff000005b60000 x3 : 0000=
000000000000
> > > |[  255.822757] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000=
000000000000
> > > |[  255.822764] Call trace:
> > > |[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38
>
> Shouldn't xsk_tx_metadata_complete() be called only when corresponding
> buf_type is STMMAC_TXBUF_T_XSK_TX?

+1. I'm assuming Serge isn't enabling it explicitly, so none of the
metadata stuff should trigger in this case.

> > > |[  255.822772]  stmmac_napi_poll_rxtx+0xc4/0xec0
> > > |[  255.822778]  __napi_poll.constprop.0+0x40/0x220
> > > |[  255.822785]  napi_threaded_poll+0xd8/0x228
> > > |[  255.822790]  kthread+0x108/0x120
> > > |[  255.822798]  ret_from_fork+0x10/0x20
> > > |[  255.822808] Code: 910303e0 f9003be1 97ffdec0 f9403be1 (f9000020)
> > > |[  255.822812] ---[ end trace 0000000000000000 ]---
> > > |[  255.822817] Kernel panic - not syncing: Oops: Fatal exception in =
interrupt
> > > |[  255.822819] SMP: stopping secondary CPUs
> > > |[  255.822827] Kernel Offset: disabled
> > > |[  255.822829] CPU features: 0x0,c0000000,4002814a,2100720b
> > > |[  255.822834] Memory Limit: none
> > > |[  256.062429] ---[ end Kernel panic - not syncing: Oops: Fatal exce=
ption in interrupt ]---
> >
> > Just confirmed the same problem on my MIPS-based SoC:
> >
> > Device #1:
> > $ ifconfig eth2 192.168.2.2 up
> > $ pktgen.sh -v -i eth2 -d 192.168.2.3 -m 4C:A5:15:59:A6:86 -n 0 -s 1496
> >
> > Device #2:
> > $ mount -t bpf none /sys/fs/bpf/
> > $ sysctl -w net.core.bpf_jit_enable=3D1
> > $ ifconfig eth0 192.168.2.3 up
> > $ xdp-bench tx eth0
> > ...
> > [  559.663885] CPU 0 Unable to handle kernel paging request at virtual =
address 00000000, epc =3D=3D 809a81e0, ra =3D=3D 809a81dc
> > [  559.675786] Oops[#1]:
> > [  559.678324] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc3-bt1-=
00322-gb2c1210b8fe6-dirty #2176
> > [  559.695824] $ 0   : 00000000 00000001 00000000 00000000
> > [  559.701676] $ 4   : eb019c48 00000000 bf054000 81ddfe53
> > [  559.707524] $ 8   : 00000000 84ea05c0 00000000 00000000
> > [  559.713372] $12   : 00000000 0000002e 816e9d00 81080000
> > [  559.719221] $16   : 00000002 a254c020 00000000 00000000
> > [  559.725069] $20   : 84ea05c0 00000000 852b8000 00000040
> > [  559.730917] $24   : 00000000 00000000
> > [  559.736766] $28   : 815d8000 81ddfd88 84ea05c0 809a81dc
> > [  559.742615] Hi    : 00000007
> > [  559.745826] Lo    : 00000000
> > [  559.749029] epc   : 809a81e0 stmmac_tx_clean+0x9f8/0xd64
> > [  559.754974] ra    : 809a81dc stmmac_tx_clean+0x9f4/0xd64
> > [  559.760909] Status: 10000003 KERNEL EXL IE
> > [  559.765588] Cause : 0080040c (ExcCode 03)
> > [  559.770063] BadVA : 00000000
> > [  559.773266] PrId  : 0001a830
> > [  559.777740] Modules linked in:
> > [  559.781150] Process swapper/0 (pid: 0, threadinfo=3D9e75df13, task=
=3De559c9e5, tls=3D00000000)
> > [  559.790194] Stack : 00000001 00000001 00003138 00000001 001a07f2 469=
6b1a6 00000000 00000000
> > [  559.799552]         00000000 00000001 00000000 81080000 00000001 000=
00000 84ea0b40 84ea2880
> > [  559.808909]         84ea0e20 00000000 00000000 00000001 81600000 81d=
dfe53 810d6bcc 817b0000
> > [  559.818265]         815d8000 81ddfe10 0000012c 80e83fd4 84ea05c0 a25=
4c020 00000000 80142518
> > [  559.827622]         00800400 eb019c48 81600000 00000040 81ddfebc 84e=
a05c0 00000000 84ea1320
> > [  559.836979]         ...
> > [  559.839710] Call Trace:
> > [  559.842435] [<809a81e0>] stmmac_tx_clean+0x9f8/0xd64
> > [  559.847985] [<809a8610>] stmmac_napi_poll_tx+0xc4/0x18c
> > [  559.858885] [<80b2db94>] net_rx_action+0x128/0x288
> > [  559.864232] [<80e84d48>] __do_softirq+0x134/0x4e0
> > [  559.869489] [<80142484>] irq_exit+0xd4/0x138
> > [  559.874261] [<807cc768>] __gic_irq_dispatch+0x154/0x1f0
> > [  559.880101] [<80102d50>] except_vec_vi_end+0xc4/0xd0
> > [  559.885641] [<80e78884>] default_idle_call+0x64/0x168
> > [  559.891288] [<801975c4>] do_idle+0xf4/0x198
> > [  559.895965] [<80197990>] cpu_startup_entry+0x30/0x40
> > [  559.901513] [<80e78c1c>] kernel_init+0x0/0x120
> > [  559.906477]
> > [  559.908126] Code: 0c2682db  afa50048  8fa50048 <aca20000> aca30004  =
1000fded  8fc208b0  8fc308ac  0000a825
> > [  559.919047]
> > [  559.920734] ---[ end trace 0000000000000000 ]---
> > [  559.925908] Kernel panic - not syncing: Fatal exception in interrupt
> >
> > No problem has been spotted for the XDP drop and pass benches.
> >
> > As you pointed out reverting the commit 1347b419318d ("net: stmmac:
> > Add Tx HWTS support to XDP ZC") fixes the bug.
> >
> > -Serge(y)
> >
> >

