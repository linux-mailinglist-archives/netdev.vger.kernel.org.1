Return-Path: <netdev+bounces-114358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F14B942459
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 04:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B0B285D5C
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 02:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBC9FC0A;
	Wed, 31 Jul 2024 02:00:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1010DDBE
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722391206; cv=none; b=RN0071c2iFbgDPaAiDL1XAh6vzXYb3hIk41Ppd1k7JUTPNK8rMb9bO8UXcVdvKg+27mfAK2OtxY87NgHEZ/BCL9J60BuCD0BR9bma/SyiCrwJTQkmUWaTki52CdLRk7OGJ9Cf6GrDYL+8Cw56bxYvF7WrqQh5w6PK6974f42ZJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722391206; c=relaxed/simple;
	bh=K1qOC5tHUaMsNZMC1TjMJaYf6RAeKSo/0m0qrGDii54=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JyVPiQrFqgfAnPvK9AOYOeHYXaTMGUKZrUJ6odM4l6USsAOnEYlK6+7mxJHKcWrVbZ9HrAS7morhXa9PeuAvpobvZ8THX8jChAT/3KFIXcFnEt9r50CbljamVJTDuO4JdSinLckkqNGB4xmnYvNJ3P14pft99nz1Df6ITQPJFS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39862b50109so81014005ab.3
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 19:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722391203; x=1722996003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oifXDfDa4Pc0Sdv5gbrkS91BTKOjBFXuRwSI5Vt+woE=;
        b=cpsDhbaylhpHhDQPe7Wa0+0ZBU9vVvCdzneh7ZgBMWOy1BzmV56Wd24oFjWRLHPepU
         ys/oTPEmVe+uAUGYLm0v8w0ZwrjxinLx4c0i46OUcRFYtlShJ5d9Yo8TdL3mvSeYzY3U
         tGw0jrjEo2us0Y7FENUBfTtZnuKGmrPXyE/aAKtFiskErXB9W7SyH36u8Ahx5b+BoaDv
         ph6fAMfuTGW/EzAcoZbD/Jm9al08UJhIXRoCVsBZdxkvYipoy9IBar25qT4G2rMXEJK/
         HSsOq1vby39t9zTGpFb1DBygn6kD1S56UIMliFyDyDtNZHlQFe45E4+LQ3AzlZugEN/9
         n3rA==
X-Forwarded-Encrypted: i=1; AJvYcCUAH4FzfsKFmbTfPjsvXDrHTN9Hj2FftUKfXkvzcZBHskOj5grafiDILJw6wDqnKBPkj7las6+BUHlccWcNN31V/Pj4oGUS
X-Gm-Message-State: AOJu0Yw+ySnz+ElHM5UmwtEznkTeSLdFog8VEcXivJQnwVpYtVq+O6DZ
	JAn2n32Qo7LWI6shTdXxl0PHadSFhtpzQNDnCGDW29drejT9a5v/NoDIw+utLYa3mzlgdOZ7V/L
	wtxa5mqoQkQ4fzR5KeBKNo4wzZMfaI8rfFiCZ4FPVreFPSvpunuYlMBs=
X-Google-Smtp-Source: AGHT+IEc9c926Yi+AT5PgUKRiu91sAVFQJ4tCQhhgGVLxxVCE3cfKmVkDEp3A00yLNByqBX3a4esm6+HSw2f3lbDf8KogXFJ5U+M
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1d:b0:397:95c7:6f72 with SMTP id
 e9e14a558f8ab-39aec448e1cmr10502905ab.6.1722391203729; Tue, 30 Jul 2024
 19:00:03 -0700 (PDT)
Date: Tue, 30 Jul 2024 19:00:03 -0700
In-Reply-To: <0000000000005dc7ce0611833268@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dce735061e8173dc@google.com>
Subject: Re: [syzbot] [mptcp?] WARNING in __mptcp_clean_una
From: syzbot <syzbot+5b3e7c7a0b77f0c03b0d@syzkaller.appspotmail.com>
To: cpaasch@apple.com, davem@davemloft.net, edumazet@google.com, 
	geliang.tang@linux.dev, geliang@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martineau@kernel.org, matttbe@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit fb7a0d334894206ae35f023a82cad5a290fd7386
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon Apr 29 18:00:31 2024 +0000

    mptcp: ensure snd_nxt is properly initialized on connect

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12c8bdbd980000
start commit:   4f5e5092fdbf Merge tag 'net-6.8-rc5' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d7c92dd8d5c7a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=5b3e7c7a0b77f0c03b0d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fc9c8a180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d0cc1c180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mptcp: ensure snd_nxt is properly initialized on connect

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

