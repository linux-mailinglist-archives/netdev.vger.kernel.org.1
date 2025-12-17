Return-Path: <netdev+bounces-245164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33758CC819A
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 15:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19D103059AD9
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 14:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF81C385CA4;
	Wed, 17 Dec 2025 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c7KupjB+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EE43845DF
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979943; cv=none; b=cUlowWU7ld1j1eszxMW7UxQ90Btuf4NkgEYCeC2d/G4q6YlF06+GZYDWDuQLEd8I5WUrdhTHOn9cNzgaa+XQJwMehaEsOPa+466r/opEWzsftER80vPQvGCI/bFhOWG3alB41/dec5CH9Trrqz03BAOTI7abtr1fU2t9ZzzbkQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979943; c=relaxed/simple;
	bh=yxwNryvvPv2/Myqjqro8Y3BAKEi6lqw+ueWkpdWMVOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4TEiv5xXf5U9IWdDgFEVhqRBUAtxPkJK3DnP13DJSylpuksNDDsS2M7crPdX3uCiLER6WKef6nxXhpJbv8V5Ii4TqWCZBk2AiaIamR5YttWWXM8Kma+EB3bbcXIYtmwAk6mOetELU1Z2SOKT8oTw1c/cDIyQvls6uMwMAyIgGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c7KupjB+; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ed66b5abf7so5718021cf.1
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 05:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765979941; x=1766584741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjS38TShpgIQaTlElXdtGFRUdJi3vLtheP95SobCA3w=;
        b=c7KupjB+oufMEJtWNgsRgJZ6X2TthzVaWs1vIvMoQgI6XCPOT+xJRuIXpP3yJXaEKO
         652KydwUTb0NlTm4xvxl37PwRdL6XPxsriqPYB/qADw8wN1emSornOAPbGsYt6fTlgJf
         gcW1iQ9RnZshAr9zT2o3RNPf4uhRDPpuPQBEJ3YeiK2wzAFY48KP8gIFghe5CJewzu5b
         HoOYj/b+GuJWNZelLqkTDPV4q0XDMAqztY5hlwU9EK035Gj6oCKH29h0i7PPMitV1IKT
         fVMwb1qKOc5zik/2HWWDH0KCH1gX5fwMdS42eEuKOaGMWqI+uEJ0eF1h+sidBvXE6H2Q
         qjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979941; x=1766584741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kjS38TShpgIQaTlElXdtGFRUdJi3vLtheP95SobCA3w=;
        b=esNuq/bzba4RBOia6QieSw5iV4RDpcngHDkA8gccOEHeSaWFoZ5cgc0bFj0h+FwrsO
         S+XD88Ot+wY9xO9OtZ8SmNx3hg873Ra9kxX2NB3VRX2p6DYCYClz2d4cxHriT35UrUkd
         axE0ogjjuZvqjODjT4q7/eIXoFzyuScSAPzRzs9i0ZamWCOfFgOhG8QRAI5S2wS6+Kqd
         JdJkzSA7+sxNYP8jEkJquJ75+0E2qVKC8EVXU91SRDDhIrbBRvD+hqGekdicsnB1Gf1i
         HDl7GqPkEQxYGIA9oIvXNjs/YwBui2A1IWPfPobAYRUMLzSc49KpNOghpVU2De4qIz2D
         V+ug==
X-Forwarded-Encrypted: i=1; AJvYcCWq7D+SknVkUyYm3b0nKzhZFT3Np/G+lSMaketTBmCF2Imvyqp53DV9w519lC3qrD7kWA+DSSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/iX7P3LcVsnjXTTsc23bOr0yZVc0Y0RbsavSUhk5W49ZSH2mr
	W6ZEn02b7G0lazezm1MBaA0IFI+n0XhplAJleJovYE+281bksbBDS4juAyq0PdWYvsgz/aNLjUP
	F7VhncIgGIT0M8T4ZonUOscSagFlxzvLVWDpFTZ++
X-Gm-Gg: AY/fxX4DZ4An5QdtMPI86ciOx2LyIac8O3AsijlDX4h/FQDwloVUeJYJTFX6n7pDjhv
	AHjlrxWTDwSz7tEX+EtmQFiayO9H8I/oDUUC7ZhKrh5QntqUAwOj0uRS00Rzgy3OMjSt18+NLDe
	TAbToY/L+rzOqvRVhzR0EQQyZEgIUBn0yx9VS55M0QL5BV1ZikvT5At0dgI2Ww13hL2lxZZO9le
	MXwIkJdQS0mT1WFHXeIczL5BF5N68Kivfin4TpZNOMRkdClMinFydsUmobU9/8/2KjyFxJh
X-Google-Smtp-Source: AGHT+IHkVWXP+ciQW6u05tSacZ+264X/yy3nNbHRlRYHRCWMjjafw04fWoA1eSlX5lbrNAp3K/njPJ1OB0fDfbtgaWs=
X-Received: by 2002:a05:622a:1b8f:b0:4eb:e287:3a76 with SMTP id
 d75a77b69052e-4f1cf5a2c98mr223535651cf.24.1765979940486; Wed, 17 Dec 2025
 05:59:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <q3j7p3zkhipxleesykpfrfhznasqnn6mnfqlcphponzvsyavxf@a6ko6obdpso3> <CANn89i+8hX9SjbhR2GOe+RfEkeksKCtPbkz-6pQhCA=pjnr5zg@mail.gmail.com>
In-Reply-To: <CANn89i+8hX9SjbhR2GOe+RfEkeksKCtPbkz-6pQhCA=pjnr5zg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Dec 2025 14:58:48 +0100
X-Gm-Features: AQt7F2rwYs_Ti7nRLgLCC_jPCguit5spAYoyiXau9vrxY8MXegJlMygPd0mfwCg
Message-ID: <CANn89iKUQXmR6uaxVJDi=c3iTgtHbVaTQfRZ_w-YsPywS-fHaw@mail.gmail.com>
Subject: Re: [REPORT] Null pointer deref in net/core/dev.c on PowerPC
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 2:49=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Dec 17, 2025 at 1:10=E2=80=AFPM Aditya Gupta <adityag@linux.ibm.c=
om> wrote:
> >
> > Hello,
> >
> > I see a null pointer dereference in 'net/core/dev.c', with 6.19.0-rc1,
> > when using e1000e device in qemu.
> >
> > I am able to reproduce the issue on PowerNV and PSeries machines on Pow=
er
> > architecture, though this might be possible on other architectures also=
.
> >
> > Console log
> > -----------
> >
> >         ...
> >         Starting network: udhcpc: started, v1.35.0
> >         udhcpc: broadcasting discover
> >         [    6.389648] Kernel attempted to read user page (0) - exploit=
 attempt? (uid: 0)
> >         [    6.394166] BUG: Kernel NULL pointer dereference on read at =
0x00000000
> >         [    6.394262] Faulting instruction address: 0xc00000000166e080
> >         [    6.395253] Oops: Kernel access of bad area, sig: 11 [#1]
> >         [    6.398372] LE PAGE_SIZE=3D64K MMU=3DRadix  SMP NR_CPUS=3D20=
48 NUMA pSeries
> >         [    6.398647] Modules linked in:
> >         [    6.399553] CPU: 0 UID: 0 PID: 203 Comm: udhcpc Not tainted =
6.19.0-rc1+ #3 PREEMPT(voluntary)
> >         [    6.399757] Hardware name: IBM pSeries (emulated by qemu) PO=
WER9 (architected) 0x4e1202 0xf000005 of:SLOF,git-6b6c16 pSeries
> >         [    6.400002] NIP:  c00000000166e080 LR: c00000000166e080 CTR:=
 0000000000000000
> >         [    6.400148] REGS: c00000000c67b4f0 TRAP: 0300   Not tainted =
 (6.19.0-rc1+)
> >         [    6.400275] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  C=
R: 44022860  XER: 20040147
> >         [    6.400544] CFAR: c00000000165ef0c DAR: 0000000000000000 DSI=
SR: 40000000 IRQMASK: 0
> >         [    6.400544] GPR00: c00000000166e080 c00000000c67b790 c000000=
0028ca300 0000000000000002
> >         [    6.400544] GPR04: c00000000324a568 000000000001a560 0000000=
000000020 0000000000000000
> >         [    6.400544] GPR08: 0000000000000000 0000000000000000 0000000=
000000201 0000000028022862
> >         [    6.400544] GPR12: 0000000000000001 c0000000041a0000 0000000=
000000000 0000000000000000
> >         [    6.400544] GPR16: 0000000000000000 0000000000000010 0000000=
000000148 0000000000000148
> >         [    6.400544] GPR20: 0000000000000000 0000000000000008 0000000=
0000005dc c000000003ea5e98
> >         [    6.400544] GPR24: c000000003ea5e94 0000000000000000 c000000=
005b7e200 0000000000000001
> >         [    6.400544] GPR28: 0000000000000000 0000000000000000 0000000=
000000000 c000000003ea5d80
> >         [    6.401178] NIP [c00000000166e080] __dev_xmit_skb+0x484/0xb8=
8
> >         [    6.401697] LR [c00000000166e080] __dev_xmit_skb+0x484/0xb88
> >         [    6.401843] Call Trace:
> >         [    6.401938] [c00000000c67b790] [c00000000166e080] __dev_xmit=
_skb+0x484/0xb88 (unreliable)
> >         [    6.402060] [c00000000c67b810] [c0000000016738a4] __dev_queu=
e_xmit+0x4b4/0xa94
> >         [    6.402122] [c00000000c67b970] [c00000000192748c] packet_xmi=
t+0x10c/0x1b0
> >         [    6.402190] [c00000000c67b9f0] [c00000000192af6c] packet_snd=
+0x784/0xa04
> >         [    6.402278] [c00000000c67bad0] [c00000000162a91c] __sys_send=
to+0x1dc/0x250
> >         [    6.402340] [c00000000c67bc20] [c00000000162a9c4] sys_sendto=
+0x34/0x44
> >         [    6.402400] [c00000000c67bc40] [c000000000031870] system_cal=
l_exception+0x170/0x360
> >         [    6.402468] [c00000000c67be50] [c00000000000cedc] system_cal=
l_vectored_common+0x15c/0x2ec
> >         ...
> >
> > Git Blame
> > ---------
> >
> > Debugging with GDB points to this code in 'net/core/dev.c':
> >
> >         static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qd=
isc *q,
> >                                          struct net_device *dev,
> >                                          struct netdev_queue *txq)
> >         {
> >         ...
> >                         llist_for_each_entry_safe(skb, next, ll_list, l=
l_node) {
> >                                 prefetch(next);
> >                                 prefetch(&next->priority);             =
                                 <----------
> >                                 skb_mark_not_on_list(skb);
> >                                 rc =3D dev_qdisc_enqueue(skb, q, &to_fr=
ee, txq);
> >                                 count++;
> >                         }
> >
> > Git blame points to this commit which introduced the use of 'next->prio=
rity':
> >
> >         commit b2e9821cff6c3c9ac107fce5327070f4462bf8a7
> >         Date:   Fri Nov 21 08:32:52 2025 +0000
> >
> >             net: prefech skb->priority in __dev_xmit_skb()
> >
> > Reproducing the issue
> > ---------------------
> >
> > To reproduce the issue:
> > 1. Attaching config as attachment
> > 2. Kernel commit I built: 'commit 40fbbd64bba6 ("Merge tag 'pull-fixes'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs")'
> > 3. Initramfs (it's buildroot): https://ibm.box.com/s/x70ducx9cxl9tz4abh=
97d9b508ildync
> > 4. QEMU command line: 'qemu-system-ppc64 -M pseries -m 10G -kernel ~/so=
me-path/zImage -append "init=3D/bin/sh noreboot debug" -nographic -initrd ~=
/some-path/rootfs-with-ssh.cpio -netdev user,id=3Dnet0 -device e1000e,netde=
v=3Dnet0
> >
> > Thanks,
> > - Aditya G
> >
>
> This seems to be a platform issue.
>
> prefetch(NULL) (or prefetch (amount < PAGE_SIZE)) is not supposed to faul=
t.

Special casing of NULL was added in :

commit e63f8f439de010b6227c0c9c6f56e2c44dbe5dae
Author: Olof Johansson <olof@austin.ibm.com>
Date:   Sat Apr 16 15:24:38 2005 -0700

    [PATCH] ppc64: no prefetch for NULL pointers

