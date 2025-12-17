Return-Path: <netdev+bounces-245200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20773CC88FF
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 16:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEDB430E3616
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 15:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1629B22FDEC;
	Wed, 17 Dec 2025 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZyPssKG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4405433B6F4
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984964; cv=none; b=bVJiOc9Z1T6LOSwvtZzUZDa7EaZuAY2Kr7IgZSO1+cC24PWlWlijjawnaG1iUYUl4/hIOWlVwWjR84UuRSYTRdPeQpxBoTHfCi3Yh49zmgJfNcfAToiuTrmFQ3qBrzl6V3b4Tlg+0us1Q8tWakgUJ3QqPCyneP3HZbfjZklbNFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984964; c=relaxed/simple;
	bh=TLbsF26CFnxxGnC4pPP1emIgw036GIae15uxDXmdTYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIyAvibfgCPxKpFgi1lE8LbdLg76JWsnKoqgYvM31q+ySHI5QfQAkP0cZH5w4prcf9UlJumnPBJuDanw8uHVGSZQV1VGPRbTQjsRHnC7HzzULDl+8FlFD+x8qAwaH+FCOyzP3xqyw8DOk9aHnpYVnf9HvT9+df5rxaaoPQnzaKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jZyPssKG; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-641e942242cso4585220d50.1
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 07:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765984961; x=1766589761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AyNi5WS76W6Julk1XnJm44whvIfOVahT+07T5M8LTQ=;
        b=jZyPssKGAd3rdKFkhh9rdj4gCRwlqudZhrUeTbP6AtQ6xtVj7oo4TPEYjHahMJtXTE
         Ogg14M/0xd3P2R1K4feRzuc1tAL8X5Io/ItcFncJMp8KIaisgqJwrjTT6XhdpSQMn/f/
         c2twwNXZbHl7KoriZorDP57vx/G1Rxz6L/xgy/Kke0CaDqDf+8iHd0Bf3lisTxcQw/ss
         dxwocBU3dDyVSvpxwUO+2gnEcQvptDgdsnjHpP9G4Ca8cWMxK//cEKfyTf3dUdP50UZZ
         1iOIAB2hkX72l+sK/1Y9g5ihHAXLvDLYTjIv/6eMnux6ph7EosqtoeZGOlxhGRE+mm9Y
         Xo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765984961; x=1766589761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3AyNi5WS76W6Julk1XnJm44whvIfOVahT+07T5M8LTQ=;
        b=XFRWu+4WkYj9totklKWZGVTfMKuHfGkR15EQRpc79MeToelP9mo1za6HgUmcXu8Rvz
         bghruZlh0rModmjOAMzZB3zOl10NxnEyqzbbCCojDR4Kr37iasFfrOml6ZdDH/9de5uc
         1wvo9Fa7okGE/f2DDXrBStKNsKSOCmt1ATUpkYezvFMVHWmXXsy8tAjNhdNfeKiNbqNt
         D/7scnT4pDukLCKFYJSG6+DjXOtm0ikQI7ySEqzrODWJF/Cy0sCfbR8RMUEunOvMj3jS
         kxuPwTrQxURonLhLRQ55hNkuw7nDmkvx9COToH8OZho/3ogcJDnmUThxRJOmDNYfFBWd
         bxrg==
X-Forwarded-Encrypted: i=1; AJvYcCW/2LKNWIHqktUdP98trvjjPguxO7CZbwjOhjd1O8Dh9QjWuaICL5mIHtmTFrcZ33N1462ffGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxId8HFqZlTPJ9X+TcjN8s9oNymYq/w04NM1B12fuA1HAHUKria
	dsNZdN9G6vi5oT4ESRqlXaEPSJyKbrG+07AB2a7CMK92jjPxFqmxQ71Xj1oeoh7hG+ij7WfgEWv
	+et3yT5CD7zA3Yru37xh1MmhXRt2JgWHKexQb5MLM
X-Gm-Gg: AY/fxX7Uxoz7S/sSWxhaXz5FEhx7Z5hp8JKOvHatYVHCtmmbAY6U/hrbh60IflZMbIB
	RzF/NFoH9WBr1KcY/qtuFzqZbbU0BI4rjT1GKM712cie7OT1rOFWNo9n+h0bmOFxdffNEKw3fko
	nenFE+ted+4gIhiDmm8Qrxwqv+2JOeuOsSXaHh6gWopIqjNDA8x3Y3AzvVMNku24hAuZtThy1ia
	LWGUT9QB1Cfu4bIdCq3CQFn+cGTh2IQx/F6tMGt0taMV0sQu8+Q3uzGZ5rvMFUwn4uZqAW9
X-Google-Smtp-Source: AGHT+IG1VJ1rKQiCMpO7CwLl1udwmZgJrqb5TjQFgqksBny46RqdqKwyAn1/ocRq6qT/j0sSmi7Sk9sLtvM2vQsEFlY=
X-Received: by 2002:a05:690e:6d9:b0:63f:95dd:b2c9 with SMTP id
 956f58d0204a3-6455564e725mr10918524d50.58.1765984960800; Wed, 17 Dec 2025
 07:22:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <q3j7p3zkhipxleesykpfrfhznasqnn6mnfqlcphponzvsyavxf@a6ko6obdpso3>
 <CANn89i+8hX9SjbhR2GOe+RfEkeksKCtPbkz-6pQhCA=pjnr5zg@mail.gmail.com>
 <CANn89iKUQXmR6uaxVJDi=c3iTgtHbVaTQfRZ_w-YsPywS-fHaw@mail.gmail.com>
 <CANn89iJj_Vyt2g6QewwaNAXAZ+0iso=4yj0t3U11V_nuUk4ThQ@mail.gmail.com> <6d508d6a-6d4f-4b78-96e0-65e5dfe4e8f0@oracle.com>
In-Reply-To: <6d508d6a-6d4f-4b78-96e0-65e5dfe4e8f0@oracle.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Dec 2025 16:22:28 +0100
X-Gm-Features: AQt7F2odo0i9BFFLF9CvXGW90VttH9ERQbfEKWsZGEaNw8XKWsxrUO1mzIGZTM0
Message-ID: <CANn89iKjJ-P0YR-oGzEd+EvrFAQA=0LsjsYHUDpFNRHCDwXeWA@mail.gmail.com>
Subject: Re: [External] : Re: [REPORT] Null pointer deref in net/core/dev.c on PowerPC
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Aditya Gupta <adityag@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 4:02=E2=80=AFPM ALOK TIWARI <alok.a.tiwari@oracle.c=
om> wrote:
>
>
>
> On 12/17/2025 8:11 PM, Eric Dumazet wrote:
> > On Wed, Dec 17, 2025 at 2:58=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> >>
> >> On Wed, Dec 17, 2025 at 2:49=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> >>>
> >>> On Wed, Dec 17, 2025 at 1:10=E2=80=AFPM Aditya Gupta <adityag@linux.i=
bm.com> wrote:
> >>>>
> >>>> Hello,
> >>>>
> >>>> I see a null pointer dereference in 'net/core/dev.c', with 6.19.0-rc=
1,
> >>>> when using e1000e device in qemu.
> >>>>
> >>>> I am able to reproduce the issue on PowerNV and PSeries machines on =
Power
> >>>> architecture, though this might be possible on other architectures a=
lso.
> >>>>
> >>>> Console log
> >>>> -----------
> >>>>
> >>>>          ...
> >>>>          Starting network: udhcpc: started, v1.35.0
> >>>>          udhcpc: broadcasting discover
> >>>>          [    6.389648] Kernel attempted to read user page (0) - exp=
loit attempt? (uid: 0)
> >>>>          [    6.394166] BUG: Kernel NULL pointer dereference on read=
 at 0x00000000
> >>>>          [    6.394262] Faulting instruction address: 0xc00000000166=
e080
> >>>>          [    6.395253] Oops: Kernel access of bad area, sig: 11 [#1=
]
> >>>>          [    6.398372] LE PAGE_SIZE=3D64K MMU=3DRadix  SMP NR_CPUS=
=3D2048 NUMA pSeries
> >>>>          [    6.398647] Modules linked in:
> >>>>          [    6.399553] CPU: 0 UID: 0 PID: 203 Comm: udhcpc Not tain=
ted 6.19.0-rc1+ #3 PREEMPT(voluntary)
> >>>>          [    6.399757] Hardware name: IBM pSeries (emulated by qemu=
) POWER9 (architected) 0x4e1202 0xf000005 of:SLOF,git-6b6c16 pSeries
> >>>>          [    6.400002] NIP:  c00000000166e080 LR: c00000000166e080 =
CTR: 0000000000000000
> >>>>          [    6.400148] REGS: c00000000c67b4f0 TRAP: 0300   Not tain=
ted  (6.19.0-rc1+)
> >>>>          [    6.400275] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE=
>  CR: 44022860  XER: 20040147
> >>>>          [    6.400544] CFAR: c00000000165ef0c DAR: 0000000000000000=
 DSISR: 40000000 IRQMASK: 0
> >>>>          [    6.400544] GPR00: c00000000166e080 c00000000c67b790 c00=
00000028ca300 0000000000000002
> >>>>          [    6.400544] GPR04: c00000000324a568 000000000001a560 000=
0000000000020 0000000000000000
> >>>>          [    6.400544] GPR08: 0000000000000000 0000000000000000 000=
0000000000201 0000000028022862
> >>>>          [    6.400544] GPR12: 0000000000000001 c0000000041a0000 000=
0000000000000 0000000000000000
> >>>>          [    6.400544] GPR16: 0000000000000000 0000000000000010 000=
0000000000148 0000000000000148
> >>>>          [    6.400544] GPR20: 0000000000000000 0000000000000008 000=
00000000005dc c000000003ea5e98
> >>>>          [    6.400544] GPR24: c000000003ea5e94 0000000000000000 c00=
0000005b7e200 0000000000000001
> >>>>          [    6.400544] GPR28: 0000000000000000 0000000000000000 000=
0000000000000 c000000003ea5d80
> >>>>          [    6.401178] NIP [c00000000166e080] __dev_xmit_skb+0x484/=
0xb88
> >>>>          [    6.401697] LR [c00000000166e080] __dev_xmit_skb+0x484/0=
xb88
> >>>>          [    6.401843] Call Trace:
> >>>>          [    6.401938] [c00000000c67b790] [c00000000166e080] __dev_=
xmit_skb+0x484/0xb88 (unreliable)
> >>>>          [    6.402060] [c00000000c67b810] [c0000000016738a4] __dev_=
queue_xmit+0x4b4/0xa94
> >>>>          [    6.402122] [c00000000c67b970] [c00000000192748c] packet=
_xmit+0x10c/0x1b0
> >>>>          [    6.402190] [c00000000c67b9f0] [c00000000192af6c] packet=
_snd+0x784/0xa04
> >>>>          [    6.402278] [c00000000c67bad0] [c00000000162a91c] __sys_=
sendto+0x1dc/0x250
> >>>>          [    6.402340] [c00000000c67bc20] [c00000000162a9c4] sys_se=
ndto+0x34/0x44
> >>>>          [    6.402400] [c00000000c67bc40] [c000000000031870] system=
_call_exception+0x170/0x360
> >>>>          [    6.402468] [c00000000c67be50] [c00000000000cedc] system=
_call_vectored_common+0x15c/0x2ec
> >>>>          ...
> >>>>
> >>>> Git Blame
> >>>> ---------
> >>>>
> >>>> Debugging with GDB points to this code in 'net/core/dev.c':
> >>>>
> >>>>          static inline int __dev_xmit_skb(struct sk_buff *skb, struc=
t Qdisc *q,
> >>>>                                           struct net_device *dev,
> >>>>                                           struct netdev_queue *txq)
> >>>>          {
> >>>>          ...
> >>>>                          llist_for_each_entry_safe(skb, next, ll_lis=
t, ll_node) {
> >>>>                                  prefetch(next);
> >>>>                                  prefetch(&next->priority);         =
                                     <----------
> >>>>                                  skb_mark_not_on_list(skb);
> >>>>                                  rc =3D dev_qdisc_enqueue(skb, q, &t=
o_free, txq);
> >>>>                                  count++;
> >>>>                          }
> >>>>
> >>>> Git blame points to this commit which introduced the use of 'next->p=
riority':
> >>>>
> >>>>          commit b2e9821cff6c3c9ac107fce5327070f4462bf8a7
> >>>>          Date:   Fri Nov 21 08:32:52 2025 +0000
> >>>>
> >>>>              net: prefech skb->priority in __dev_xmit_skb()
> >>>>
> >>>> Reproducing the issue
> >>>> ---------------------
> >>>>
> >>>> To reproduce the issue:
> >>>> 1. Attaching config as attachment
> >>>> 2. Kernel commit I built: 'commit 40fbbd64bba6 ("Merge tag 'pull-fix=
es' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs")'
> >>>> 3. Initramfs (it's buildroot): https://urldefense.com/v3/__https://i=
bm.box.com/s/x70ducx9cxl9tz4abh97d9b508ildync__;!!ACWV5N9M2RV99hQ!JFK4bRaMJ=
qtwI1HPrt0RUtQ-Ti5RfIOMf_XvhccLjHCtWhOgpn4WF1qglGxo1Z0nXM_TcGB7PehRPosqE_4L=
$
> >>>> 4. QEMU command line: 'qemu-system-ppc64 -M pseries -m 10G -kernel ~=
/some-path/zImage -append "init=3D/bin/sh noreboot debug" -nographic -initr=
d ~/some-path/rootfs-with-ssh.cpio -netdev user,id=3Dnet0 -device e1000e,ne=
tdev=3Dnet0
> >>>>
> >>>> Thanks,
> >>>> - Aditya G
> >>>>
> >>>
> >>> This seems to be a platform issue.
> >>>
> >>> prefetch(NULL) (or prefetch (amount < PAGE_SIZE)) is not supposed to =
fault.
> >>
> >> Special casing of NULL was added in :
> >>
> >> commit e63f8f439de010b6227c0c9c6f56e2c44dbe5dae
> >> Author: Olof Johansson <olof@austin.ibm.com>
> >> Date:   Sat Apr 16 15:24:38 2005 -0700
> >>
> >>      [PATCH] ppc64: no prefetch for NULL pointers
> >
> > I will send the following fix, thanks.
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 9094c0fb8c68..36dc5199037e 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4241,9 +4241,11 @@ static inline int __dev_xmit_skb(struct sk_buff
> > *skb, struct Qdisc *q,
> >                  int count =3D 0;
> >
> >                  llist_for_each_entry_safe(skb, next, ll_list, ll_node)=
 {
> > -                       prefetch(next);
> > -                       prefetch(&next->priority);
> > -                       skb_mark_not_on_list(skb);
> > +                       if (next) {
> > +                               prefetch(next);
> > +                               prefetch(&next->priority);
> > +                               skb_mark_not_on_list(skb);
> > +                       }
> >                          rc =3D dev_qdisc_enqueue(skb, q, &to_free, txq=
);
> >                          count++;
> >                  }
> >
>
> why not only ?
> if (likely(next)) {
>      prefetch(next);
>      prefetch(&next->priority);
> }

Because we also can avoid clearing skb->next, we know it is already NULL.

Since we pay the price of a conditional, let's amortize its cost :/

