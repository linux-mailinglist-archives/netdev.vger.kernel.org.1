Return-Path: <netdev+bounces-126818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1BC97299F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE7A1C23B8F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9362717B4EC;
	Tue, 10 Sep 2024 06:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qae3IWWn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6BE17ADE2
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 06:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725950232; cv=none; b=Nv6Pd71xGQLcwtLA6ENASozXYCb2UcrtQj/qZbZsMHYyBwq1RL+OViusYEjHbm33vofvigAgL7sejlN18/h1eadD60aGne80nGfDyfkxrSCzu51zDE/duMHAbkIMxkewM+sRFnb0FmEgQi2olPX1HzoD1w5LsIEPrvbw9ZkVf88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725950232; c=relaxed/simple;
	bh=/gZ/e9rJtdKGsqdl5Nd3WaCf6RpxN2blOu9TshVlFaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUOBgO5N0Gm4FSnDnk8DJt6pAlQdh3XD3i5guNCjHZkIlNPRfZQYjoI3nLIgKvwQZH6Etx0jO7JtjW9W+VqcfkvWtxdgpdJLHrcDDSzk3hb/y/2FiRqopiWtXFkwRdf+63AYoQ8vm/hZ1P8ON0kycFfabO+ZaifN5IUQ94qe3rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qae3IWWn; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8ce5db8668so567124266b.1
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 23:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725950229; x=1726555029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jghqw20+C9fL5tVNTNoyx1SLKWNXxTj4hY1LELdiq+0=;
        b=Qae3IWWnXV+qvf5A9nneMzOHDYJ2zRpcM0SvYQ/Qyp227gzqoCDOwQ91ny22C+M2v7
         YWg9o+wjowh/XlJS6ULAreUpzKhr5bbi0Mdo8VNoXpvaNS2fVTCbjuGfiQVCIpX53Q7p
         Wblt3vCGI1Z1AsACRsJL68513g5kXo2oCvWmj90q82APYmMblTpUxQh9SEK4vldVte4g
         cjpFhduNQxcJqlQu0swg5ralut1tudl9FhHcTXqUI687yVKuzMsLZMOeqUlTaLB5UJ6J
         XyTaRpQngLaArvzjqfFc6HsdTbVSFPaqrgGEX1SRYuOqcZhVhVH+4kgTYNc+aOkAc7Ah
         CJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725950229; x=1726555029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jghqw20+C9fL5tVNTNoyx1SLKWNXxTj4hY1LELdiq+0=;
        b=aj+BNfE5736XDzxsWy6xoB7+z5GXcPq65Aw+i9vZg7Ozr6JcNYByh7vXKkxqcevF72
         UUeLr1Wobgf/bZiyzxCJoLvqTNMq/MsoQOnhbn/DxhAeYxUtsqld/xmLj+jqtaPXUObd
         uhGzjZefuEU4ZqF9crHq0Yko8LkNhu0b1SDNkD9DOlJ+nhNzPvl390zOP3xafBnKWm5s
         4zAtWFQHAo7dv17Uy2R/TGvlWB865y6ls0CUHF76P/cV0yVcyhYXNhlD+N1lYJTjYH/A
         OeZ4HzpOxrHf2cllod6oQQkWe2LQT2uj2hOfmvUhYLQv0fiM6y6ejkOEEufc5GmBOTCf
         zUFA==
X-Forwarded-Encrypted: i=1; AJvYcCVnHkZkjCoU5kDaKSncSgF3o9TDqBkhq1ELoGEqb6nonXY7NNZEzoTF3jNvGyeFi9c5eubaT2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjRBT5mSw95sjBbOyYI3DzUPtyU6uqra4MRb1t0XT/EOPkGjPE
	9p391iUGBBRsFYtXdHc6guCirosYnyIXOGIH3GJgeJ54SC7KNidNoiihAKwbQ2HOaEXYF5MKU6j
	+u66K2IuSArdOy9rsfoaZeo4c3l868VWFZCon
X-Google-Smtp-Source: AGHT+IFhz9Ea6Ytm456NNVlcwQqaEs92ozth94eaizAc0QlKR8/XD18NjGwolnXIm/Amzef+NyPriSpCjfunSMoaziI=
X-Received: by 2002:a17:907:9703:b0:a8a:837c:ebd4 with SMTP id
 a640c23a62f3a-a8d1bfcb40bmr895053466b.27.1725950228569; Mon, 09 Sep 2024
 23:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000000311430620013217@google.com> <0000000000005d1b320621973380@google.com>
 <CANn89iJGw2EVw0V5HUs9-CY4f8FucYNgQyjNXThE6LLkiKRqUA@mail.gmail.com>
 <17dc89d6-5079-4e99-9058-829a07eb773f@linux.ibm.com> <02634384-2468-4598-b64a-0f558730c925@linux.alibaba.com>
In-Reply-To: <02634384-2468-4598-b64a-0f558730c925@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Sep 2024 08:36:57 +0200
Message-ID: <CANn89iKcWmufo83xy-SwSrXYt6UpL2Pb+5pWuzyYjMva5F8bBQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, 
	syzbot <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com>, 
	Dust Li <dust.li@linux.alibaba.com>, davem@davemloft.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 7:55=E2=80=AFAM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
>
>
> On 9/9/24 7:44 PM, Wenjia Zhang wrote:
> >
> >
> > On 09.09.24 10:02, Eric Dumazet wrote:
> >> On Sun, Sep 8, 2024 at 10:12=E2=80=AFAM syzbot
> >> <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com> wrote:
> >>>
> >>> syzbot has found a reproducer for the following issue on:
> >>>
> >>> HEAD commit:    df54f4a16f82 Merge branch 'for-next/core' into
> >>> for-kernelci
> >>> git tree:
> >>> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
> >>> for-kernelci
> >>> console output:
> >>> https://syzkaller.appspot.com/x/log.txt?x=3D12bdabc7980000
> >>> kernel config:
> >>> https://syzkaller.appspot.com/x/.config?x=3Ddde5a5ba8d41ee9e
> >>> dashboard link:
> >>> https://syzkaller.appspot.com/bug?extid=3D51cf7cc5f9ffc1006ef2
> >>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils
> >>> for Debian) 2.40
> >>> userspace arch: arm64
> >>> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=3D1798589f9800=
00
> >>> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=3D10a30e00580=
000
> >>>
> >>> Downloadable assets:
> >>> disk image:
> >>> https://storage.googleapis.com/syzbot-assets/aa2eb06e0aea/disk-df54f4=
a1.raw.xz
> >>> vmlinux:
> >>> https://storage.googleapis.com/syzbot-assets/14728733d385/vmlinux-df5=
4f4a1.xz
> >>> kernel image:
> >>> https://storage.googleapis.com/syzbot-assets/99816271407d/Image-df54f=
4a1.gz.xz
> >>>
> >>> IMPORTANT: if you fix the issue, please add the following tag to the
> >>> commit:
> >>> Reported-by: syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >>> WARNING: possible circular locking dependency detected
> >>> 6.11.0-rc5-syzkaller-gdf54f4a16f82 #0 Not tainted
> >>> ------------------------------------------------------
> >>> syz-executor272/6388 is trying to acquire lock:
> >>> ffff8000923b6ce8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock+0x20/0x2c
> >>> net/core/rtnetlink.c:79
> >>>
> >>> but task is already holding lock:
> >>> ffff0000dc408a50 (&smc->clcsock_release_lock){+.+.}-{3:3}, at:
> >>> smc_setsockopt+0x178/0x10fc net/smc/af_smc.c:3064
> >>>
> >>> which lock already depends on the new lock.
> >>>
>
> I have noticed this issue for a while, but I question the possibility of
> it. If I understand correctly, a deadlock issue following is reported her=
e:
>
> #2
> lock_sock_smc
> {
>      clcsock_release_lock            --- deadlock
>      {
>
>      }
> }
>
> #1
> rtnl_mutex
> {
>      lock_sock_smc
>      {
>
>      }
> }
>
> #0
> clcsock_release_lock
> {
>      rtnl_mutex                      --deadlock
>      {
>
>      }
> }
>
> This is of course a deadlock, but #1 is suspicious.
>
> How would this happen to a smc sock?
>
> #1 ->
>         lock_sock_nested+0x38/0xe8 net/core/sock.c:3543
>         lock_sock include/net/sock.h:1607 [inline]
>         sockopt_lock_sock net/core/sock.c:1061 [inline]
>         sockopt_lock_sock+0x58/0x74 net/core/sock.c:1052
>         do_ip_setsockopt+0xe0/0x2358 net/ipv4/ip_sockglue.c:1078
>         ip_setsockopt+0x34/0x9c net/ipv4/ip_sockglue.c:1417
>         raw_setsockopt+0x7c/0x2e0 net/ipv4/raw.c:845
>         sock_common_setsockopt+0x70/0xe0 net/core/sock.c:3735
>         do_sock_setsockopt+0x17c/0x354 net/socket.c:2324
>
> As a comparison, the correct calling chain should be:
>
>         sock_common_setsockopt+0x70/0xe0 net/core/sock.c:3735
>         smc_setsockopt+0x150/0xcec net/smc/af_smc.c:3072
>         do_sock_setsockopt+0x17c/0x354 net/socket.c:2324
>
>
> That's to say,  any setting on SOL_IP options of smc_sock will
> go with smc_setsockopt, which will try lock clcsock_release_lock at first=
.
>
> Anyway, if anyone can explain #1, then we can see how to solve this probl=
em,
> otherwise I think this problem doesn't exist. (Just my opinion)

Then SMC lacks some lockdep annotations.

Please take a look at sock_lock_init_class_and_name() callers.

