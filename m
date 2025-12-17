Return-Path: <netdev+bounces-245171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54651CC84F0
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 15:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B11D302FA02
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 14:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6983A3502A9;
	Wed, 17 Dec 2025 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3785NrXT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D8E34B198
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982492; cv=none; b=dWtNO7k67H032GoHdIzzLHMZXlmWWzXBpwoTSU7a9Jzm7wnFTgXbjzGayvTFGyWNh/D5tZUtG7gcEP+ewt4SZdMVq296+Z4CDCQU/bkdqr7Rg7aE6KSHV3DVmctvXv6YyUYpPv1euKSSx/l3NV1cZ97JSRyKIr/Y2nOTcrCSxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982492; c=relaxed/simple;
	bh=muUA+2mDsOSCfHb6LDdF2v+wS7FG+tKMh+lqJTSGgMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlhqBqL1YtUfySSXLcT+a98JPo7iVb5GY1S2XPIWG7yUWH4IJiXyB6PQo2O7c831bUC76CYz3sEscoIyZxHbAk2zRfVDMoAbCIlqyj76AlA1ta/A/SmSSqtIzrmhLUpbyX+XEeQ/0MvUlwQhfxGt4BCWM2Rdea+EqcjvAQuleeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3785NrXT; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4edb6e678ddso80812941cf.2
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 06:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765982488; x=1766587288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlcQaMegGSeI1OKi+Z5uv9Yjh1ks1IJ/MG0jPsf9xE4=;
        b=3785NrXTXv3agb1ujda9/f9l1DD2bmXSXndbtqyHjA+BNPQh1hMqsZcPQAeu6H5qq7
         KpdVfrGsPndCR04HcwDIakQBrbWXZ7JZEo2PNSSkWIyhHNiFIBP0wJKDGumF2wDsJxHF
         e+2x/OtARlWNDtpRb+gs60tfOcetVK/dsGQcxqhdc12kR7NAgMD10+NP8H++aGf8Zoqo
         dHcz9Mbjg7f1vj78uTOxhWmpk9e03xmbo6StS2p5Z95mSkp1QbEdfQCgyABzxP5KRhGs
         K+FXXXLa4dGYP91Kf8V3WaBTwdBcZTDRF1/O7aXblGV6y73SxvG63ReNQE4FsTp3DEBh
         DwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765982488; x=1766587288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HlcQaMegGSeI1OKi+Z5uv9Yjh1ks1IJ/MG0jPsf9xE4=;
        b=Sztnzar1lruK1Kzj0q2zwP1UukFk545JporbaWyYzR2BcX98cDqzSXBS7HTsWmZ9SE
         foCZq6t8CFCsuscwpfYOCPl4NQa+iMHMOQfe+icRJx2OgAbTHtuJ3qf28Pk8v8tkLgE0
         fSkOw+VmxJ1YeVIAusP+/kOolDoTglUmKSgv74ZFXvvtaz5O1IVYNQbctlQUFu4ErmBk
         U9LFfiiT12/+bvKlbAZXh8aUj244aFSLvNQypEEfruG6x0N49F6scGNlIiBjKyRqFZyS
         5BSX1mztISao5CpaKds6MoUBpMhadyxsprNsFjiqknNh062R+Uc/Xf3Z1XZeMrxQxI1z
         JsZA==
X-Forwarded-Encrypted: i=1; AJvYcCUQTFsw6VeSSHwXlD9IOswUSeUeSd5e/XSWC4Cy3yMC2H6675MXRGwZ/lD0IoZLYkP4FOvQrn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCAiXGxPdv+QWmRofDPFhwO2z744vbvrlyxS+X38dYQi20bHy/
	Q2Kiq0TB7O4A1mbY4BtdFU3Ub/z1g0oR139uvDzE1rQoTMCNqSbkwblP7L9QqBxkDc6xkSCZ6uN
	gq7E27WjX7xfFaC+WjAcKdTrn+06lilSBJqcxMH3iyllhlHW2DWL/ZOyxsrc=
X-Gm-Gg: AY/fxX7k+yt+XZCAcGuDn0/7+QrHOgg3mvsUOH5I0w/rgg3P0EqBIT327L30rsDPO/A
	//wA7eQty8v1Xp8Oy8Rai+e6sSJZE+DhAUSt8TBwnr0DFgzIbanUq7UFgCtKs70hqJcRuGag8jK
	WQhAa4wuszzd69vEifOV6+80wSCBiPNp9ALLRiD6DHvM2dh0fT+/uvIwukjZE7DPgIzM9QQANxV
	E/fsgQzgFcxopmyi77ZgLonel0OMyXqU1lgidpoFoT28BtSjl9Ds6cIwDYW3g7PTJp93nYB
X-Google-Smtp-Source: AGHT+IE97q5QjOGvWcE+cwtHO+8f8eXdQ/x3OKefFIQwmdYDgq35seW+fWt32+sU0/qW6fxM4BGtwRjhGrdRIXG4OBI=
X-Received: by 2002:ac8:7515:0:b0:4f3:4c1a:4c49 with SMTP id
 d75a77b69052e-4f34c1a5041mr47790141cf.48.1765982487630; Wed, 17 Dec 2025
 06:41:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <q3j7p3zkhipxleesykpfrfhznasqnn6mnfqlcphponzvsyavxf@a6ko6obdpso3>
 <CANn89i+8hX9SjbhR2GOe+RfEkeksKCtPbkz-6pQhCA=pjnr5zg@mail.gmail.com> <CANn89iKUQXmR6uaxVJDi=c3iTgtHbVaTQfRZ_w-YsPywS-fHaw@mail.gmail.com>
In-Reply-To: <CANn89iKUQXmR6uaxVJDi=c3iTgtHbVaTQfRZ_w-YsPywS-fHaw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Dec 2025 15:41:16 +0100
X-Gm-Features: AQt7F2p6C5HCvIynMmRn0SloX2uOAkp8tqp1IPLJkqdou5tq9u16rZW4uN3Oy3U
Message-ID: <CANn89iJj_Vyt2g6QewwaNAXAZ+0iso=4yj0t3U11V_nuUk4ThQ@mail.gmail.com>
Subject: Re: [REPORT] Null pointer deref in net/core/dev.c on PowerPC
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 2:58=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Dec 17, 2025 at 2:49=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Dec 17, 2025 at 1:10=E2=80=AFPM Aditya Gupta <adityag@linux.ibm=
.com> wrote:
> > >
> > > Hello,
> > >
> > > I see a null pointer dereference in 'net/core/dev.c', with 6.19.0-rc1=
,
> > > when using e1000e device in qemu.
> > >
> > > I am able to reproduce the issue on PowerNV and PSeries machines on P=
ower
> > > architecture, though this might be possible on other architectures al=
so.
> > >
> > > Console log
> > > -----------
> > >
> > >         ...
> > >         Starting network: udhcpc: started, v1.35.0
> > >         udhcpc: broadcasting discover
> > >         [    6.389648] Kernel attempted to read user page (0) - explo=
it attempt? (uid: 0)
> > >         [    6.394166] BUG: Kernel NULL pointer dereference on read a=
t 0x00000000
> > >         [    6.394262] Faulting instruction address: 0xc00000000166e0=
80
> > >         [    6.395253] Oops: Kernel access of bad area, sig: 11 [#1]
> > >         [    6.398372] LE PAGE_SIZE=3D64K MMU=3DRadix  SMP NR_CPUS=3D=
2048 NUMA pSeries
> > >         [    6.398647] Modules linked in:
> > >         [    6.399553] CPU: 0 UID: 0 PID: 203 Comm: udhcpc Not tainte=
d 6.19.0-rc1+ #3 PREEMPT(voluntary)
> > >         [    6.399757] Hardware name: IBM pSeries (emulated by qemu) =
POWER9 (architected) 0x4e1202 0xf000005 of:SLOF,git-6b6c16 pSeries
> > >         [    6.400002] NIP:  c00000000166e080 LR: c00000000166e080 CT=
R: 0000000000000000
> > >         [    6.400148] REGS: c00000000c67b4f0 TRAP: 0300   Not tainte=
d  (6.19.0-rc1+)
> > >         [    6.400275] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE> =
 CR: 44022860  XER: 20040147
> > >         [    6.400544] CFAR: c00000000165ef0c DAR: 0000000000000000 D=
SISR: 40000000 IRQMASK: 0
> > >         [    6.400544] GPR00: c00000000166e080 c00000000c67b790 c0000=
000028ca300 0000000000000002
> > >         [    6.400544] GPR04: c00000000324a568 000000000001a560 00000=
00000000020 0000000000000000
> > >         [    6.400544] GPR08: 0000000000000000 0000000000000000 00000=
00000000201 0000000028022862
> > >         [    6.400544] GPR12: 0000000000000001 c0000000041a0000 00000=
00000000000 0000000000000000
> > >         [    6.400544] GPR16: 0000000000000000 0000000000000010 00000=
00000000148 0000000000000148
> > >         [    6.400544] GPR20: 0000000000000000 0000000000000008 00000=
000000005dc c000000003ea5e98
> > >         [    6.400544] GPR24: c000000003ea5e94 0000000000000000 c0000=
00005b7e200 0000000000000001
> > >         [    6.400544] GPR28: 0000000000000000 0000000000000000 00000=
00000000000 c000000003ea5d80
> > >         [    6.401178] NIP [c00000000166e080] __dev_xmit_skb+0x484/0x=
b88
> > >         [    6.401697] LR [c00000000166e080] __dev_xmit_skb+0x484/0xb=
88
> > >         [    6.401843] Call Trace:
> > >         [    6.401938] [c00000000c67b790] [c00000000166e080] __dev_xm=
it_skb+0x484/0xb88 (unreliable)
> > >         [    6.402060] [c00000000c67b810] [c0000000016738a4] __dev_qu=
eue_xmit+0x4b4/0xa94
> > >         [    6.402122] [c00000000c67b970] [c00000000192748c] packet_x=
mit+0x10c/0x1b0
> > >         [    6.402190] [c00000000c67b9f0] [c00000000192af6c] packet_s=
nd+0x784/0xa04
> > >         [    6.402278] [c00000000c67bad0] [c00000000162a91c] __sys_se=
ndto+0x1dc/0x250
> > >         [    6.402340] [c00000000c67bc20] [c00000000162a9c4] sys_send=
to+0x34/0x44
> > >         [    6.402400] [c00000000c67bc40] [c000000000031870] system_c=
all_exception+0x170/0x360
> > >         [    6.402468] [c00000000c67be50] [c00000000000cedc] system_c=
all_vectored_common+0x15c/0x2ec
> > >         ...
> > >
> > > Git Blame
> > > ---------
> > >
> > > Debugging with GDB points to this code in 'net/core/dev.c':
> > >
> > >         static inline int __dev_xmit_skb(struct sk_buff *skb, struct =
Qdisc *q,
> > >                                          struct net_device *dev,
> > >                                          struct netdev_queue *txq)
> > >         {
> > >         ...
> > >                         llist_for_each_entry_safe(skb, next, ll_list,=
 ll_node) {
> > >                                 prefetch(next);
> > >                                 prefetch(&next->priority);           =
                                   <----------
> > >                                 skb_mark_not_on_list(skb);
> > >                                 rc =3D dev_qdisc_enqueue(skb, q, &to_=
free, txq);
> > >                                 count++;
> > >                         }
> > >
> > > Git blame points to this commit which introduced the use of 'next->pr=
iority':
> > >
> > >         commit b2e9821cff6c3c9ac107fce5327070f4462bf8a7
> > >         Date:   Fri Nov 21 08:32:52 2025 +0000
> > >
> > >             net: prefech skb->priority in __dev_xmit_skb()
> > >
> > > Reproducing the issue
> > > ---------------------
> > >
> > > To reproduce the issue:
> > > 1. Attaching config as attachment
> > > 2. Kernel commit I built: 'commit 40fbbd64bba6 ("Merge tag 'pull-fixe=
s' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs")'
> > > 3. Initramfs (it's buildroot): https://ibm.box.com/s/x70ducx9cxl9tz4a=
bh97d9b508ildync
> > > 4. QEMU command line: 'qemu-system-ppc64 -M pseries -m 10G -kernel ~/=
some-path/zImage -append "init=3D/bin/sh noreboot debug" -nographic -initrd=
 ~/some-path/rootfs-with-ssh.cpio -netdev user,id=3Dnet0 -device e1000e,net=
dev=3Dnet0
> > >
> > > Thanks,
> > > - Aditya G
> > >
> >
> > This seems to be a platform issue.
> >
> > prefetch(NULL) (or prefetch (amount < PAGE_SIZE)) is not supposed to fa=
ult.
>
> Special casing of NULL was added in :
>
> commit e63f8f439de010b6227c0c9c6f56e2c44dbe5dae
> Author: Olof Johansson <olof@austin.ibm.com>
> Date:   Sat Apr 16 15:24:38 2005 -0700
>
>     [PATCH] ppc64: no prefetch for NULL pointers

I will send the following fix, thanks.

diff --git a/net/core/dev.c b/net/core/dev.c
index 9094c0fb8c68..36dc5199037e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4241,9 +4241,11 @@ static inline int __dev_xmit_skb(struct sk_buff
*skb, struct Qdisc *q,
                int count =3D 0;

                llist_for_each_entry_safe(skb, next, ll_list, ll_node) {
-                       prefetch(next);
-                       prefetch(&next->priority);
-                       skb_mark_not_on_list(skb);
+                       if (next) {
+                               prefetch(next);
+                               prefetch(&next->priority);
+                               skb_mark_not_on_list(skb);
+                       }
                        rc =3D dev_qdisc_enqueue(skb, q, &to_free, txq);
                        count++;
                }

