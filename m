Return-Path: <netdev+bounces-69712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F1984C525
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 07:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E345A1C21765
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 06:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8FA1CD39;
	Wed,  7 Feb 2024 06:50:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4001CD30
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 06:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707288607; cv=none; b=NXcqzjvFXcHI5PCKCBxCNCLb+NmAy5tPpQokYnVYuFrKqJ8LY+mxgEy0CbEn68XeYadXT6uq8mGW5ecnF7mvUCWyfB/ZWo8ELVpJKAZBZ2PbMkgRT5p5SeZVvYDfFMzHbfbk7j2c5+/Rf3XS/bfr8t4MoHU4RWOIRWWv8xxOirE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707288607; c=relaxed/simple;
	bh=txwgru8ukqwseSHIc0ZyhJJEtXFoGOV/G4cX6j4bgyc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s9ohrTGbBAXcSvYXQ5mBN+FSu12L67ZciE4xGFm7gWaRZYXEwQFPSzMCF+9+/CrtaB81GZIpqGg8dZAx8LW1E1p6dgaLfCa/gQso5o+VIimLGPCF5fd0AfV28KD9hurODB8oTIIeD9Ys2DDOIdX1MCCBGH1pgfVZayeTONE/4Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bfd755ae39so24708239f.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 22:50:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707288605; x=1707893405;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJp9PiIxbgAEsE0ISqJs+jF6VAx9STrKEpa7F04AncM=;
        b=fPFcXUEbth8bfJ/VBsFLyCWjLUJFzItk74LBBr4bSTkfxiFIQMOu2pCXWDD4/+YTRt
         S4iCQbZHzGbYO8jVjHkW+0j8QtCjtLI4aUSzaUv7AUKt5gF+vLm3fVJZQzZv6R/ffFeX
         /tWQmFllAGhWyqkzLiuZMZqFO1bU+7xNwbJRuI92NNtaTvgBnIGs5xfUyQbEL3OkYYpc
         rK7nYXYeNn1YUZn/JaW1ZFBTGmg4Mn9wE8XTb0330Ph77mhJ26gcalIVbtY9qNvALXgZ
         oynfYHmPBZkjIeKCXyziUCg7r2lwZt4IMhD9dwBVU4gskk4YdVx5K/NsaBh3FRR9PWUm
         SQ2g==
X-Gm-Message-State: AOJu0Yyz/BxLEKSjCBRxrgxY3vorqqrS74FTkjiD0svzHjGZaR4+oaQ+
	Q60dY8XfK4RPyAdhN7KsrQyCwIFykHs9Px+ulM1M+cS8Rd8gpcfEVLuI8iLxzloXoGILkGaVVTB
	mJHz6GNdUxFl0lk3AYADorFOyIPPTmyiCMK5e1vzPUztYpI4DwekU/Zw=
X-Google-Smtp-Source: AGHT+IHIQD5e5Ra5jnAc0Lil23mYT3rezE8/io/0zI23XRimBC6ndhE/lGbLe2e9vRJfEQFrO/zPDUHLra9PuBS5SabQnmstnc37
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160d:b0:363:ab40:78c7 with SMTP id
 t13-20020a056e02160d00b00363ab4078c7mr314018ilu.6.1707288605030; Tue, 06 Feb
 2024 22:50:05 -0800 (PST)
Date: Tue, 06 Feb 2024 22:50:05 -0800
In-Reply-To: <000000000000ecb4750610659876@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5018e0610c51a8e@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING: ODEBUG bug in hash_netiface4_destroy
From: syzbot <syzbot+52bbc0ad036f6f0d4a25@syzkaller.appspotmail.com>
To: 00107082@163.com, coreteam@netfilter.org, davem@davemloft.net, 
	edumazet@google.com, fw@strlen.de, hdanton@sina.com, justinstitt@google.com, 
	kadlec@netfilter.org, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 97f7cf1cd80eeed3b7c808b7c12463295c751001
Author: Jozsef Kadlecsik <kadlec@netfilter.org>
Date:   Mon Jan 29 09:57:01 2024 +0000

    netfilter: ipset: fix performance regression in swap operation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=179ff138180000
start commit:   6897cea71837 Merge tag 'for-6.8/dm-fixes' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=145ff138180000
console output: https://syzkaller.appspot.com/x/log.txt?x=105ff138180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=457249c250b93697
dashboard link: https://syzkaller.appspot.com/bug?extid=52bbc0ad036f6f0d4a25
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174bd5d3e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fcf5b0180000

Reported-by: syzbot+52bbc0ad036f6f0d4a25@syzkaller.appspotmail.com
Fixes: 97f7cf1cd80e ("netfilter: ipset: fix performance regression in swap operation")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

