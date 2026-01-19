Return-Path: <netdev+bounces-251033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B1DD3A318
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 464BD300FE3F
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A858A350D78;
	Mon, 19 Jan 2026 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X1ndaabW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B5C268690
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768815023; cv=none; b=gm9ZFcPadNscXvmRjrSW5RJGwDP6799Ob94uBfOQVlOTakvjiu/p9yUqLD2O/sBrJ7YgWm1i0Ewpt+nDGnzkjyyXVBQQO5tDYCwDqW7fZIP+T11fwJjN9ZcrFQbiWNLl4DKCB8NQ6n6Mg1qxCqqEQfd+nhofw2LasKYhjqrH5m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768815023; c=relaxed/simple;
	bh=TQ9VJE1U3xvPPvaZTsUmcFO9h7ihdqQGpK5YKrq3A+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCrioZMh+sY5UfW/MTM+eSbeXNXvLVkjpdDkx7yz8HrqhUGbHK1rVvOhZK8oim+Dz9eHtkiTQAeE9ORyF7qdtKKO2qm47ga1jiNE5inokWF9+pz1pZSn5EncKKH9iYICmykcw0q55Y9KAOwiLoDTjniWqOeBlg1LqxFQDG9Po1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X1ndaabW; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5013d163e2fso42742121cf.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768815021; x=1769419821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLDd66u9zAy67Tl6sY/Or445elKO0v/MjPLWBa8TQAE=;
        b=X1ndaabW4rgpR1FbrPkCDiaHZCMlX2E7XVoHYHHdeHbIwJ8YEzJH+pdB6esGPCxUYp
         +qBYquhadpCBovhtAfKN57WpT2k7KU3V5EDwge2b++ubXNwgB1zmFyOzarI2D+Gszg7H
         apnUkaaohlpsjZVawuMfwCDfNnHKtU3vn25+zUDT2QpuAdFGVg/IuLTyrJfk/iet/KSz
         lbTH6+0cFysf0jVmPxVTaCSIV8n3l37iR+h+Ju620RxPJicajT/PxI8J8EqrTpQW2hss
         tSiABbsdgviKiVdaIS1QpylIg1XX/m+KuHoRji0Ln0sac6Juz4I72/KmjB9C2jnNFeZb
         UTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768815021; x=1769419821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WLDd66u9zAy67Tl6sY/Or445elKO0v/MjPLWBa8TQAE=;
        b=kjCWheU7V5EGIT1PJ1dD+aCGOrb2KM5+UrjiotijsDOA6PgtzqkpxPHKDpO60nk5yj
         OIQgHpzv4BEyaceiGGmq5U/Fzy3us5SumBaftF5zhf27NEG3cfb1JceQBECuOsFmBId9
         1D84oWR8auqAZilM159qYWQWhi/tWfwP0QkUILzOtm3FGIfGjCNDkbJZCQoSnyHPrn7x
         4lWTUfrocaNqjKrvZtF14Xsb/s9GMr3Z4ufVU5GkcY/jUtVe+HEz9OxKrEPhzWgPt4JA
         EKMNZIF6yHNxXidEJkSyk/bFprH13S8y+SFMsoVDd1x6ApcHr/CxPv5Q0nYBsdXWT2oQ
         56VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnLfLocBiVUS4W+97L4onChgXhKqBFBWbKxG1opN6rwwG/Ld+PO7w8RfMOa+yj+iP41Sb2wOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt0ALKQW2bPC07DRpQrwZyhRggkvI7fL23XGArwsudhMuMCk3h
	c64qPaK+wQ9is50r3lhLHwJVU0WRkC96+KpTYn1ux9bbGNF+Hgzy1VW2Ic/i07/MPAQZORv4TLs
	vqZVk8LOEJ6+y2hCmBAGHFg51yIPQuOFDkk1dLWbr
X-Gm-Gg: AY/fxX6eKGPRVYeQ7Kua2YPOMCREd7spvfBMq+7Ekqpyfw+YCdY3vkoKBVrupwZ0FL2
	HH4ocDW5xAbf2arsfZYdhDjBZXi/+ce4zyrTp+b9mYwVwlUUjUpTox26PVAiSL6XlCDV/oxZNs2
	S9VD4o0dzpq4bJUk5fvSwy0tnm4SSuKY9qVYdAOpKlH1CaYDCuGEsEisvHgjARi3Q6Cns/QhaVk
	yGJEDKwdLSM4c9CwtA6dQm+Mjk026TGjVxpY13mQOSO4CXz+sWaq+4fMQwan6JgMbLgs+k=
X-Received: by 2002:ac8:7f13:0:b0:4f1:e97b:2896 with SMTP id
 d75a77b69052e-502a1f0db54mr169319081cf.46.1768815020668; Mon, 19 Jan 2026
 01:30:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA3_Gnogt7GR0gZVZwQ4vXXav6TpXMK6t=QTLsqKOaX3Bo_tNA@mail.gmail.com>
 <CANn89iLVq=3d7Ra7gKmTpLcMzuWv+KamYs=KjUHH2z3cPpDBDA@mail.gmail.com>
 <CAA3_GnrVyeXtLjhZ_d9=0x58YmK+a9yADfp+LRCBHQo_TEDyvw@mail.gmail.com>
 <CANn89iJN-fcx-szsR3Azp8wQ0zhXp0XiYJofQU1zqqtdj7SWTA@mail.gmail.com>
 <CACwEKLp42TwpK_3FEp85bq81eA1zg3777guNMonW9cm2i7aN2Q@mail.gmail.com>
 <CAA3_Gnqo37RxLi2McF0=oRPZSw_P3Kya_3m3JBA2s6c0vaf5sw@mail.gmail.com>
 <CANn89iL8FnPG9bD6zW0eHmeSNzc33SJgrUR7Aab4PFG-O4nfTw@mail.gmail.com> <CAA3_GnpijQeBNVOqy6QtUMDjhy_ku_b54uf30zfEq=etMTqKrA@mail.gmail.com>
In-Reply-To: <CAA3_GnpijQeBNVOqy6QtUMDjhy_ku_b54uf30zfEq=etMTqKrA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Jan 2026 10:30:09 +0100
X-Gm-Features: AZwV_QhxRpJqBgoK-ulYvwewt0kMLo2qcwrj75TKGoAP71sOOxiRakoi0iLllZc
Message-ID: <CANn89iK-Ojmi4kCZwXhFq-pG5PacLs=m71Jtw4zRpxaPEbJdhg@mail.gmail.com>
Subject: Re: [PATCH net] bonding: Fix header_ops type confusion
To: =?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>
Cc: pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?5bCP5rGg5oKg55Sf?= <yuki.koike@gmo-cybersecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 6:36=E2=80=AFAM =E6=88=B8=E7=94=B0=E6=99=83=E5=A4=
=AA <kota.toda@gmo-cybersecurity.com> wrote:
>
> Thanks for your quick response.
>
> The following information is based on Linux kernel version 6.12.65,
> the latest release in the 6.12 tree.
> The kernel config is identical to that of the kernelCTF instance
> (available at: https://storage.googleapis.com/kernelctf-build/releases/lt=
s-6.12.65/.config)
>
>
> This type confusion occurs in several locations, including,
> for example, `ipgre_header` (`header_ops->create`),
> where the private data of the network device is incorrectly cast as
> `struct ip_tunnel *`.
>
> ```
> static int ipgre_header(struct sk_buff *skb, struct net_device *dev,
>       unsigned short type,
>       const void *daddr, const void *saddr, unsigned int len)
> {
>   struct ip_tunnel *t =3D netdev_priv(dev);
>   struct iphdr *iph;
>   struct gre_base_hdr *greh;
> ...
> ```
>
> When a bond interface is given to this function,
> it should not reference the private data as `struct ip_tunnel *`,
> because the bond interface uses the private data as `struct bonding *`.
> (quickly confirmed by seeing drivers/net/bonding/bond_netlink.c:909)
>
> ```
> struct rtnl_link_ops bond_link_ops __read_mostly =3D {
>     .kind            =3D "bond",
>     .priv_size        =3D sizeof(struct bonding),
> ...
> ```
>
> The stack trace below is the backtrace of all stack frame during a
> call to `ipgre_header`.
>
> ```
> ipgre_header at net/ipv4/ip_gre.c:890
> dev_hard_header at ./include/linux/netdevice.h:3156
> packet_snd at net/packet/af_packet.c:3082
> packet_sendmsg at net/packet/af_packet.c:3162
> sock_sendmsg_nosec at net/socket.c:729
> __sock_sendmsg at net/socket.c:744
> __sys_sendto at net/socket.c:2213
> __do_sys_sendto at net/socket.c:2225
> __se_sys_sendto at net/socket.c:2221
> __x64_sys_sendto at net/socket.c:2221
> do_syscall_x64 at arch/x86/entry/common.c:47
> do_syscall_64 at arch/x86/entry/common.c:78
> entry_SYSCALL_64 at arch/x86/entry/entry_64.S:121
> ```
>
> This causes memory corruption during subsequent operations.
>
> The following stack trace shows a General Protection Fault triggered
> when sending a packet
> to a bonding interface that has an IPv4 GRE interface as a slave.
>
> ```
> [    1.712329] Oops: general protection fault, probably for
> non-canonical address 0xdead0000cafebabe: 0000 [#1] SMP NOPTI
> [    1.712972] CPU: 0 UID: 1000 PID: 205 Comm: exp Not tainted 6.12.65 #1
> [    1.713344] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS Arch Linux 1.17.0-2-2 04/01/2014
> [    1.713890] RIP: 0010:skb_release_data+0x8a/0x1c0
> [    1.714162] Code: c0 00 00 00 49 03 86 c8 00 00 00 0f b6 10 f6 c2
> 01 74 48 48 8b 70 28 48 85 f6 74 3f 41 0f b6 5d 00 83 e3 10 40 f6 c6
> 01 75 24 <48> 8b 06 ba 01 00 00 00 4c 89 f7 48 8b 00 ff d0 0f 1f 00 41
> 8b6
> [    1.715276] RSP: 0018:ffffc900007cfcc0 EFLAGS: 00010246
> [    1.715583] RAX: ffff888106fe12c0 RBX: 0000000000000010 RCX: 000000000=
0000000
> [    1.716036] RDX: 0000000000000017 RSI: dead0000cafebabe RDI: ffff88810=
59c4a00
> [    1.716504] RBP: ffffc900007cfe10 R08: 0000000000000010 R09: 000000000=
0000000
> [    1.716955] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000002
> [    1.717429] R13: ffff888106fe12c0 R14: ffff8881059c4a00 R15: ffff88810=
6e57000
> [    1.717866] FS:  0000000038e54380(0000) GS:ffff88813bc00000(0000)
> knlGS:0000000000000000
> [    1.718350] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.718703] CR2: 00000000004bf480 CR3: 00000001009ec001 CR4: 000000000=
0772ef0
> [    1.719109] PKRU: 55555554
> [    1.719297] Call Trace:
> [    1.719461]  <TASK>
> [    1.719611]  sk_skb_reason_drop+0x58/0x120
> [    1.719891]  packet_sendmsg+0xbcb/0x18f0
> [    1.720166]  ? pcpu_alloc_area+0x186/0x260
> [    1.720421]  __sys_sendto+0x1e2/0x1f0
> [    1.720691]  __x64_sys_sendto+0x24/0x30
> [    1.720948]  do_syscall_64+0x58/0x120
> [    1.721174]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    1.721509] RIP: 0033:0x42860d
> [    1.721713] Code: c3 ff ff ff ff 64 89 02 eb b9 0f 1f 00 f3 0f 1e
> fa 80 3d 5d 4a 09 00 00 41 89 ca 74 20 45 31 c9 45 31 c0 b8 2c 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 6b c3 66 2e 0f 1f 84 00 00 00 00 00 55
> 489
> [    1.722837] RSP: 002b:00007fff597e95e8 EFLAGS: 00000246 ORIG_RAX:
> 000000000000002c
> [    1.723315] RAX: ffffffffffffffda RBX: 00000000000003e8 RCX: 000000000=
042860d
> [    1.723721] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000310
> [    1.724103] RBP: 00007fff597e9880 R08: 0000000000000000 R09: 000000000=
0000000
> [    1.724565] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff5=
97e99f8
> [    1.725010] R13: 00007fff597e9a08 R14: 00000000004b7828 R15: 000000000=
0000001
> [    1.725441]  </TASK>
> [    1.725594] Modules linked in:
> [    1.725790] ---[ end trace 0000000000000000 ]---
> [    1.726057] RIP: 0010:skb_release_data+0x8a/0x1c0
> [    1.726339] Code: c0 00 00 00 49 03 86 c8 00 00 00 0f b6 10 f6 c2
> 01 74 48 48 8b 70 28 48 85 f6 74 3f 41 0f b6 5d 00 83 e3 10 40 f6 c6
> 01 75 24 <48> 8b 06 ba 01 00 00 00 4c 89 f7 48 8b 00 ff d0 0f 1f 00 41
> 8b6
> [    1.727285] RSP: 0018:ffffc900007cfcc0 EFLAGS: 00010246
> [    1.727623] RAX: ffff888106fe12c0 RBX: 0000000000000010 RCX: 000000000=
0000000
> [    1.728052] RDX: 0000000000000017 RSI: dead0000cafebabe RDI: ffff88810=
59c4a00
> [    1.728467] RBP: ffffc900007cfe10 R08: 0000000000000010 R09: 000000000=
0000000
> [    1.728908] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000002
> [    1.729323] R13: ffff888106fe12c0 R14: ffff8881059c4a00 R15: ffff88810=
6e57000
> [    1.729744] FS:  0000000038e54380(0000) GS:ffff88813bc00000(0000)
> knlGS:0000000000000000
> [    1.730236] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.730597] CR2: 00000000004bf480 CR3: 00000001009ec001 CR4: 000000000=
0772ef0
> [    1.730988] PKRU: 55555554
> ```
>

OK thanks.

I will repeat my original feedback : I do not see any barriers in the
patch you sent.

Assuming bond_setup_by_slave() can be called multiple times during one
master lifetime, I do not think your patch is enough.

Also, please clarify what happens with stacks of two or more bonding device=
s ?

