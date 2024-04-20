Return-Path: <netdev+bounces-89831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E825B8ABCC7
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 20:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53D95B20CBA
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 18:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F392629F;
	Sat, 20 Apr 2024 18:35:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3B017C66
	for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713638106; cv=none; b=V/8qUi0jeI1Rl1C3ijrgcDcWHIlAbB+s/RxXm2hVVYIpG8LP6TEcEGpfnT1NMQaIWlKYBx4F5uZsn/e5+t5zNmQps0mF4U3T+yUmxGKPOrawRfTMXcsTJS51ZzqPeYo7YocjBO6pq4DT9/ghqoKkRi93ZWHH16oHNem7hsDxCc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713638106; c=relaxed/simple;
	bh=hdYBH6iHeFdCwus1qkWibPK9xXXOODQaZ79r1j4yrBI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JUXTMDyvg66/X18ulaT38d2Wsojgx9BYOETsRC923sGzqOcl+6v03qT0xE+Zjpd1/JHfaSbSsC6o+50VmCu83WmZE90R+vE1maCskscrxj/0LpBA4sNYzfGVfZhsjXDRoIplENFWUQ8NmCnPZ1EG4AxJocmK3sQvo1k5y+ac93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36b323b64faso36360105ab.3
        for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 11:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713638104; x=1714242904;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/RSUERUuEiGuR/bt0u6YwzU2HAwP9JNrb2sLt0V+TM=;
        b=W8sXNXoAZuopIa16AfWrE9t6QFuxJzfO1LI24VS59gULNwsrv1JhjMAm7QtlzMrVSY
         GX5ThRdO5ck1hf0SSbEjkLK8sY6oJhe+uwVfCnbzUFNTgEKJmG2mn0w6KdvpqzEx81D5
         l9jEUHy7ITfPT60jE0fbf9go7WcTacqqkqh9GheYgj2pznvaUtNuj2tq2xqlOVS8zNTI
         Eq0GXnwtl9XFYX9QMXNysZADkTloddH0mXke162pU4gNnfeazFKV6rcWQrYxCGwffHk0
         6A+P9iURHCvmBXo59L0lBldEVPEs3DaIPE4+YRa9YxQwN69Gv6fNtP8465XUqjST2Esn
         cpJw==
X-Forwarded-Encrypted: i=1; AJvYcCW8+Qlk8TQFc1aXNmwQC0GN/53E8qupw8lzlx+r+hifkcyvF3++TGBg0krAq0SARRvLmqHDdUzAOgB0EU2p5xrYJ6y/DN8g
X-Gm-Message-State: AOJu0YwWH3XOjCa5vyZZJSotSojEMsj9GBo6pddHu7K6OktC/Vv05em1
	NOMmpFV0r88/fT1QDGSijcfrfUbDlMqtI9ClolORVVUFVZibv2DWblJbKR9kAiokTO9lp6680Rq
	zp0Oh702ZwBOOZioPFk5+KWescAjxToBWjJHrrykUlU7MyEiuEtO7xhA=
X-Google-Smtp-Source: AGHT+IEIYRljOZ2wAtG68BgkwUPz1JJIzsBclxONGi2PdmpGI2v+nTHaehY42mQIKfag3/pz7z4wzM709vsB92+SFOsPU95f+07y
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c267:0:b0:36b:fbab:9f14 with SMTP id
 h7-20020a92c267000000b0036bfbab9f14mr386675ild.1.1713638104271; Sat, 20 Apr
 2024 11:35:04 -0700 (PDT)
Date: Sat, 20 Apr 2024 11:35:04 -0700
In-Reply-To: <000000000000c6405606166fdc68@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007aa28106168b76c9@google.com>
Subject: Re: [syzbot] [net?] WARNING in gre_tap_xmit (2)
From: syzbot <syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, fw@strlen.de, 
	horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 219eee9c0d16f1b754a8b85275854ab17df0850a
Author: Florian Westphal <fw@strlen.de>
Date:   Fri Feb 16 11:36:57 2024 +0000

    net: skbuff: add overflow debug check to pull/push helpers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=167a954f180000
start commit:   443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=157a954f180000
console output: https://syzkaller.appspot.com/x/log.txt?x=117a954f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=c298c9f0e46a3c86332b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a94f00980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bce6ab180000

Reported-by: syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com
Fixes: 219eee9c0d16 ("net: skbuff: add overflow debug check to pull/push helpers")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

