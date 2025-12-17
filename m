Return-Path: <netdev+bounces-245160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE588CC80A4
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 15:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBA6E30F47F7
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 13:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1110359707;
	Wed, 17 Dec 2025 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cF6aTfqO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09F03590D6
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979403; cv=none; b=fkrWmzhBBSJfVniKtZHlrqN9T/kYKaAwV+4ZzfucxZNIpZgqL8ANqzNJU23AqPaZvbN/vQLSdZdKfv34iXph/vOdQbuQ2MSibgtJi12VMM7YAt06mM5xun1N5DdfbdE98XFeoGJl+i7AMmJaW52If5J+1YxEw1AB0RoCnjtA3Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979403; c=relaxed/simple;
	bh=uRWrJs/TRoyh+N8rPG7ekXKGM3anojqN9tURNmc6WhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXCOUoyc5/6E5zheHEtA+Yf7O6dxB8IZPjdpI6XE5FRjhERViwAH48qoIR5gddgGHkvvb6poAJ1SyBsCS2zmvz6fvPcGFm8FspJdxAHPM97TSTYD84Posg3NoSKgyPVLovvLhr1YTrlj0VsjROKZxIaeHS8ZsX1vUSDV4on1FMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cF6aTfqO; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4f1b1948ffaso42382411cf.2
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 05:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765979401; x=1766584201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wAxe21u8OQJImjclL7KOZcAzJDlK9qFn9YMRVSj5Ns=;
        b=cF6aTfqOszJdmlb658/qINbTQcxRHUUed1H7Wk+DRu2mcBKo7uKjezO/qQw/fTaDsT
         L+krgPWnofdx/aXIv0vW7HEEkHIV8OW+tQiwGmKszf7YGH0ExSN88zp1SonYY8vsTpUr
         6V94Pov9YQkQKCCwPaIVLxvQO1KHfzZ2paGoSjnDSCHKStAYo/QPt/0yeNY/WkTM0Rl9
         3+j+soyLPZldeDcCWQEvXuzLPh+XNlPs/ZL56mBTbRftWetOEEUZHOolUWqqaLPNHzpL
         sxEJnVqsQIHAK4hjqy4sakoGzenyMEaJ/OGgGS/rckGOTZPwyEqleTcBLWiaab3ALFhQ
         UatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979401; x=1766584201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7wAxe21u8OQJImjclL7KOZcAzJDlK9qFn9YMRVSj5Ns=;
        b=nebPSbTCDw9fuE2gfqP4dRNaI7X7KlPF+0bzUdhISaR3xkuRUjVfaHRYFq5jzF/3vd
         X98X1qwg9SHr+WKIWp9e8geWe1dKK2XAcX2RE3efgW8I6Dv7LDzKoTHq5y5r/VV+ZAeu
         0lQwFZ+heUSKInnKbekJ6EOlHqnoQanT8Tqq4l6aPYVOkDTLWJhRIaXq7STkNhVbGfkk
         4GwnyGAEP0IM9cpbq4hBQcMVyxUy6h1rtslhMS4wD8lrFrGPsSMCFZo+CXn8YEzXoHmp
         2GZBaSfkkvyrBKbbwZ51ZmMEpzjeyJ57RJ2iw4YOOC0ki170cySEZfTyBc5YFQTVl4ds
         ldWw==
X-Forwarded-Encrypted: i=1; AJvYcCUb9yNFs2B38XWM5fYhvPA9NmUq/bI80Qbo7/1K/lG+Cuc2Jelk/oaU4h4iS3rIP+8ofgn+M44=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCRk0UaxTQR0VIwJmOHzEycJ/K2VwsdQP+M5Q6GEepwRwcZG+A
	eKMMQezAd3vFrQTsgQTp7QTpBhoRH7PdMIBHUrkc2m22t54qempqxa9f+PWe+MpYwtacyAYYsCI
	LHJNOZLI/KKfMnhY+ymzDsVutOV5b74wZhQfaSWk9
X-Gm-Gg: AY/fxX5VIJGZYXM7iA4/zckQeTsZqDzyKCSB6UD8AYS2ZXt8yzZgVrvRXVXk0rAvNQ+
	AHVrmqOzOdzynfhGfpa76m24yKnSkPdio3OZlPa9q/ZM6Oqb1zDblisWC+Ua9a7Vk7yLtDQODMy
	18p0tjOSMHX6sRCS47QRLAlVa3EpDIX8pMOobQTmT3wm91whraSZFrQKMqx7iq0kFm9MLEV3zI9
	vr1ytnc1zabJ7CKRZTlkEkj5EyR+A9e31CyxzkbK24IxzlS+kNID4Ru1ICp+3/5/4QwzqgR
X-Google-Smtp-Source: AGHT+IFdvlugDldhp8lMeTu+XSwEsyZ0/pzK1KkSSVqM67cg0M17ve/sRfp4yt/YBichH1oNDKqJ+bsoBuYsTy+6PKE=
X-Received: by 2002:a05:622a:5918:b0:4d8:531e:f896 with SMTP id
 d75a77b69052e-4f1d0505884mr245899931cf.27.1765979400364; Wed, 17 Dec 2025
 05:50:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <q3j7p3zkhipxleesykpfrfhznasqnn6mnfqlcphponzvsyavxf@a6ko6obdpso3>
In-Reply-To: <q3j7p3zkhipxleesykpfrfhznasqnn6mnfqlcphponzvsyavxf@a6ko6obdpso3>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Dec 2025 14:49:49 +0100
X-Gm-Features: AQt7F2qh3veq41BMrftDg3GIcLIqZWDA_1zF-Iiqn1LhG8B7Zkx_QV6qxGDdwg0
Message-ID: <CANn89i+8hX9SjbhR2GOe+RfEkeksKCtPbkz-6pQhCA=pjnr5zg@mail.gmail.com>
Subject: Re: [REPORT] Null pointer deref in net/core/dev.c on PowerPC
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 1:10=E2=80=AFPM Aditya Gupta <adityag@linux.ibm.com=
> wrote:
>
> Hello,
>
> I see a null pointer dereference in 'net/core/dev.c', with 6.19.0-rc1,
> when using e1000e device in qemu.
>
> I am able to reproduce the issue on PowerNV and PSeries machines on Power
> architecture, though this might be possible on other architectures also.
>
> Console log
> -----------
>
>         ...
>         Starting network: udhcpc: started, v1.35.0
>         udhcpc: broadcasting discover
>         [    6.389648] Kernel attempted to read user page (0) - exploit a=
ttempt? (uid: 0)
>         [    6.394166] BUG: Kernel NULL pointer dereference on read at 0x=
00000000
>         [    6.394262] Faulting instruction address: 0xc00000000166e080
>         [    6.395253] Oops: Kernel access of bad area, sig: 11 [#1]
>         [    6.398372] LE PAGE_SIZE=3D64K MMU=3DRadix  SMP NR_CPUS=3D2048=
 NUMA pSeries
>         [    6.398647] Modules linked in:
>         [    6.399553] CPU: 0 UID: 0 PID: 203 Comm: udhcpc Not tainted 6.=
19.0-rc1+ #3 PREEMPT(voluntary)
>         [    6.399757] Hardware name: IBM pSeries (emulated by qemu) POWE=
R9 (architected) 0x4e1202 0xf000005 of:SLOF,git-6b6c16 pSeries
>         [    6.400002] NIP:  c00000000166e080 LR: c00000000166e080 CTR: 0=
000000000000000
>         [    6.400148] REGS: c00000000c67b4f0 TRAP: 0300   Not tainted  (=
6.19.0-rc1+)
>         [    6.400275] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR:=
 44022860  XER: 20040147
>         [    6.400544] CFAR: c00000000165ef0c DAR: 0000000000000000 DSISR=
: 40000000 IRQMASK: 0
>         [    6.400544] GPR00: c00000000166e080 c00000000c67b790 c00000000=
28ca300 0000000000000002
>         [    6.400544] GPR04: c00000000324a568 000000000001a560 000000000=
0000020 0000000000000000
>         [    6.400544] GPR08: 0000000000000000 0000000000000000 000000000=
0000201 0000000028022862
>         [    6.400544] GPR12: 0000000000000001 c0000000041a0000 000000000=
0000000 0000000000000000
>         [    6.400544] GPR16: 0000000000000000 0000000000000010 000000000=
0000148 0000000000000148
>         [    6.400544] GPR20: 0000000000000000 0000000000000008 000000000=
00005dc c000000003ea5e98
>         [    6.400544] GPR24: c000000003ea5e94 0000000000000000 c00000000=
5b7e200 0000000000000001
>         [    6.400544] GPR28: 0000000000000000 0000000000000000 000000000=
0000000 c000000003ea5d80
>         [    6.401178] NIP [c00000000166e080] __dev_xmit_skb+0x484/0xb88
>         [    6.401697] LR [c00000000166e080] __dev_xmit_skb+0x484/0xb88
>         [    6.401843] Call Trace:
>         [    6.401938] [c00000000c67b790] [c00000000166e080] __dev_xmit_s=
kb+0x484/0xb88 (unreliable)
>         [    6.402060] [c00000000c67b810] [c0000000016738a4] __dev_queue_=
xmit+0x4b4/0xa94
>         [    6.402122] [c00000000c67b970] [c00000000192748c] packet_xmit+=
0x10c/0x1b0
>         [    6.402190] [c00000000c67b9f0] [c00000000192af6c] packet_snd+0=
x784/0xa04
>         [    6.402278] [c00000000c67bad0] [c00000000162a91c] __sys_sendto=
+0x1dc/0x250
>         [    6.402340] [c00000000c67bc20] [c00000000162a9c4] sys_sendto+0=
x34/0x44
>         [    6.402400] [c00000000c67bc40] [c000000000031870] system_call_=
exception+0x170/0x360
>         [    6.402468] [c00000000c67be50] [c00000000000cedc] system_call_=
vectored_common+0x15c/0x2ec
>         ...
>
> Git Blame
> ---------
>
> Debugging with GDB points to this code in 'net/core/dev.c':
>
>         static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdis=
c *q,
>                                          struct net_device *dev,
>                                          struct netdev_queue *txq)
>         {
>         ...
>                         llist_for_each_entry_safe(skb, next, ll_list, ll_=
node) {
>                                 prefetch(next);
>                                 prefetch(&next->priority);               =
                               <----------
>                                 skb_mark_not_on_list(skb);
>                                 rc =3D dev_qdisc_enqueue(skb, q, &to_free=
, txq);
>                                 count++;
>                         }
>
> Git blame points to this commit which introduced the use of 'next->priori=
ty':
>
>         commit b2e9821cff6c3c9ac107fce5327070f4462bf8a7
>         Date:   Fri Nov 21 08:32:52 2025 +0000
>
>             net: prefech skb->priority in __dev_xmit_skb()
>
> Reproducing the issue
> ---------------------
>
> To reproduce the issue:
> 1. Attaching config as attachment
> 2. Kernel commit I built: 'commit 40fbbd64bba6 ("Merge tag 'pull-fixes' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs")'
> 3. Initramfs (it's buildroot): https://ibm.box.com/s/x70ducx9cxl9tz4abh97=
d9b508ildync
> 4. QEMU command line: 'qemu-system-ppc64 -M pseries -m 10G -kernel ~/some=
-path/zImage -append "init=3D/bin/sh noreboot debug" -nographic -initrd ~/s=
ome-path/rootfs-with-ssh.cpio -netdev user,id=3Dnet0 -device e1000e,netdev=
=3Dnet0
>
> Thanks,
> - Aditya G
>

This seems to be a platform issue.

prefetch(NULL) (or prefetch (amount < PAGE_SIZE)) is not supposed to fault.

