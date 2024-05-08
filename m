Return-Path: <netdev+bounces-94653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4908C00E7
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DD21F2120F
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B360E12883C;
	Wed,  8 May 2024 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P/Z/9z7S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA67F128814
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181944; cv=none; b=Wi1KHftIPjR6RJ26UfCWa4we9WP14UxRDhfv2OpAM5LaViQDzM14a2mUV/h23KhoAOuCPxqHSs5otK5KnXmY8Sx38umz3uWpd+DFFJ+TcglRaOEkEcmK9mNlFYIyTIMsvaH2ihOJrZ97PCchXaewDKIQb+OyicvQTeoTnWEWfVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181944; c=relaxed/simple;
	bh=oBRrtYUsfhNrjd5F2fqLlZ5/ujtWqpiHWgD+jNBXq1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DagKpOJZNGWOJYm26S0CIiLIeYlzaWEcv0sY2Epm2RW4InMmFhUmGJEPQnT2V/fMIACHG7Mpa/u1QTkmlH5vG83T/ZdReyoksiqgV/DOQgqKk4sKBW4yv5RcFdyawYrf9J5WUOhvTKyavVOtbj3fjK31NhY5EkUv4qrC8OVDRKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P/Z/9z7S; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso10834a12.1
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 08:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715181941; x=1715786741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEzeRx3Cfe9WC4lokrGxFNggS4WrBJjfFUbfcYpdb1U=;
        b=P/Z/9z7SqDSgavAXbO0r3xLULTr4nOqQ2wyGvkSAv9OmFYC+sgxfJEdBAxWziytDQk
         a74+G/fD1IQpjH9Z9SAewLmvCpKsLS1hIJXwrvRIuuXKhq3PGYCJlGgHNHBSqSEhC0t0
         InFTJuwsG9CWCf5xydcLlsZQdIc0Lm/LfxLzR/G+PpZx4ankFxp1O6ZDohVec9z2JqXn
         k1iWqA35iebZUY0sJIcZ0VB6PJoAxht5VVnLrxv0ohRl9kqB2gPW8L7wHJGJPpV0GVCI
         GCAkqbqob5VTpZAG0DV3f0MCscBWNztzdf5a5FaswYoZWl8lsMgim1/B8H6tgqwC97g9
         IONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715181941; x=1715786741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEzeRx3Cfe9WC4lokrGxFNggS4WrBJjfFUbfcYpdb1U=;
        b=rLzz31vHPW+zu2Oab2tpUZ3DSAVDuaH3fOTDkEuR1WgcfyLcAj/UbpjTtofVJRxHm5
         RoDYJcjuJq4pbJyaR1VutONKNoarsnR7zXUfU4+rMJuATvkIvFKVtJP4RhubI6SmLvZB
         ZLNtqt21jgAVXVDAj995bM7krhfR2V/l9ojm6jzUWtPTQ1DewxWTbHpEI9eTNfo4gbSY
         zj7FUHdqM2iEc+T17YJIAmyrnU+fyLZnb5qtvIzuax02P/mKY8Ev7sAhNbaoAdqgGIkT
         G7ilDMOKt1VfQ4b/Tn1hxC8OBNd99qzd4a2JQiYqqxcO7XbL5NYZvVb+FcnI0J/MmTp1
         brkg==
X-Forwarded-Encrypted: i=1; AJvYcCWifW+2Wdj3k7y7hWMjZArRynaUnz8cEvgd/IDMCrMfvcENS8mEO/15zxlxCMRflQom3SHS9Tbat9PNkEw88RNH5OWu5RuX
X-Gm-Message-State: AOJu0YyfabaoNoJEvQq+C8eUWbVyVt2qopuihrFmRin5NY0YZAE1Fas8
	t4+e8T8SGO9NMXYV/yQv0sa0f1Zl+B+/iXQf+u8tGQUO5ejqkoUWRtDu9vM4qB0BICrr3niaotj
	bmf0c8Ermb8QU1Q3SSr6dP1KsM64J9HXiGbjh
X-Google-Smtp-Source: AGHT+IF6OkQoaq/vfFO4GErQtJ0Ag93IilPPyC4R6OX6P2PlnnqiC8SVYTRDD/GioiAxlyovSFkCy1ERmSsxkXMIC5M=
X-Received: by 2002:a50:85c4:0:b0:572:5597:8f89 with SMTP id
 4fb4d7f45d1cf-5731fea4d19mr217151a12.6.1715181940857; Wed, 08 May 2024
 08:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507161842.773961-1-edumazet@google.com> <ZjuVAnjhYNomU/4J@lzaremba-mobl.ger.corp.intel.com>
In-Reply-To: <ZjuVAnjhYNomU/4J@lzaremba-mobl.ger.corp.intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 May 2024 17:25:27 +0200
Message-ID: <CANn89iLGeG3pMbO62hpuC5T5tf5DXmfzVNzgHjP6GXxs9RSHUA@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: prevent NULL dereference in ip6_output()
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 5:06=E2=80=AFPM Larysa Zaremba <larysa.zaremba@intel=
.com> wrote:
>
> On Tue, May 07, 2024 at 04:18:42PM +0000, Eric Dumazet wrote:
> > According to syzbot, there is a chance that ip6_dst_idev()
> > returns NULL in ip6_output(). Most places in IPv6 stack
> > deal with a NULL idev just fine, but not here.
> >
> > syzbot reported:
> >
> > general protection fault, probably for non-canonical address 0xdffffc00=
000000bc: 0000 [#1] PREEMPT SMP KASAN PTI
> > KASAN: null-ptr-deref in range [0x00000000000005e0-0x00000000000005e7]
> > CPU: 0 PID: 9775 Comm: syz-executor.4 Not tainted 6.9.0-rc5-syzkaller-0=
0157-g6a30653b604a #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 03/27/2024
> >  RIP: 0010:ip6_output+0x231/0x3f0 net/ipv6/ip6_output.c:237
> > Code: 3c 1e 00 49 89 df 74 08 4c 89 ef e8 19 58 db f7 48 8b 44 24 20 49=
 89 45 00 49 89 c5 48 8d 9d e0 05 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 =
38 84 c0 4c 8b 74 24 28 0f 85 61 01 00 00 8b 1b 31 ff
> > RSP: 0018:ffffc9000927f0d8 EFLAGS: 00010202
> > RAX: 00000000000000bc RBX: 00000000000005e0 RCX: 0000000000040000
> > RDX: ffffc900131f9000 RSI: 0000000000004f47 RDI: 0000000000004f48
> > RBP: 0000000000000000 R08: ffffffff8a1f0b9a R09: 1ffffffff1f51fad
> > R10: dffffc0000000000 R11: fffffbfff1f51fae R12: ffff8880293ec8c0
> > R13: ffff88805d7fc000 R14: 1ffff1100527d91a R15: dffffc0000000000
> > FS:  00007f135c6856c0(0000) GS:ffff8880b9400000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020000080 CR3: 0000000064096000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >   NF_HOOK include/linux/netfilter.h:314 [inline]
> >   ip6_xmit+0xefe/0x17f0 net/ipv6/ip6_output.c:358
> >   sctp_v6_xmit+0x9f2/0x13f0 net/sctp/ipv6.c:248
> >   sctp_packet_transmit+0x26ad/0x2ca0 net/sctp/output.c:653
> >   sctp_packet_singleton+0x22c/0x320 net/sctp/outqueue.c:783
> >   sctp_outq_flush_ctrl net/sctp/outqueue.c:914 [inline]
> >   sctp_outq_flush+0x6d5/0x3e20 net/sctp/outqueue.c:1212
> >   sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline]
> >   sctp_do_sm+0x59cc/0x60c0 net/sctp/sm_sideeffect.c:1169
> >   sctp_primitive_ASSOCIATE+0x95/0xc0 net/sctp/primitive.c:73
> >   __sctp_connect+0x9cd/0xe30 net/sctp/socket.c:1234
> >   sctp_connect net/sctp/socket.c:4819 [inline]
> >   sctp_inet_connect+0x149/0x1f0 net/sctp/socket.c:4834
> >   __sys_connect_file net/socket.c:2048 [inline]
> >   __sys_connect+0x2df/0x310 net/socket.c:2065
> >   __do_sys_connect net/socket.c:2075 [inline]
> >   __se_sys_connect net/socket.c:2072 [inline]
> >   __x64_sys_connect+0x7a/0x90 net/socket.c:2072
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Fixes: 778d80be5269 ("ipv6: Add disable_ipv6 sysctl to disable IPv6 ope=
raion on specific interface.")
> > Reported-by: syzbot <syzkaller@googlegroups.com>
>
> 'Closes:' tag would be nice.

I do not disclose some syzbot reports, for security reasons.

Maybe this escaped your radar, I am triaging most (unless I am OOO for
more than 6 days)
syzbot reports before deciding to make them public or not.

Have you seen a public report about this bug ?

