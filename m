Return-Path: <netdev+bounces-240921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DA4C7C13B
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 02:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB315356750
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 01:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7E7244670;
	Sat, 22 Nov 2025 01:17:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CEB38F9C
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 01:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763774227; cv=none; b=T0h2gaXVzO4flI1KxCSQt2QIUq9tirs1NdWcottqkqU0HGXGozp/YEPxDuwpvCdhTRmUps31CRgx2X+J8SsTSdhKmFnqhctmxzcq9VGOwIDX6+/8tDlxXoC7Yh8Eg9TaOAmLalDKJ0AnUA7O0Gx5r7d7XBEY/9D2sCbY7RPMkfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763774227; c=relaxed/simple;
	bh=WMkOOnc7lW16bqTV7elMZfje/Ou6G70+Yq1wBSRahgc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LSjDPWmQATfSu+OtbMI9fSS3jgRVAgZJHP3tmmP1YyzBlJXLQ6VE1TE7CqIKOHuW9eCu7dx+qLrU3KdRW7yk5cGQYWlYlssnmwUXev6V3r8ykNHeqoElPKId63Ichm8c/lp2gtuMp4ngCxMFHw6Mu+AdtOvq9XceP0oLWMDAenY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-94908fb82e0so216202739f.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 17:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763774223; x=1764379023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZSU65QgF/FBmE4nfihqRERT5QTB/HlH/UzGV+EFLBo=;
        b=ZxXGVFlp5HlTNkDbD/XO+NPaiTtElyM2lb5gvljerWl45zPisYMmYf3viRBSweBPFC
         AYq6MTVmRI3Xq1G4C0zeDCECimE24BrM/64CuHsqtEgopzTy7c9qgDuIPaTXsjnvue3W
         YAzeJZDvRwIrNZjzcSflA1umItzTlx38ecMxMty9zCbHpeKSfizrlmOsu7y/ctbMQygS
         HCXUi1XofQR2onvhRguLAvnvPU21NMCluDNSqdJME/aNyVgaqq6whW1gdWW64DLf6NIG
         B8w1LG8bY890nj+tkdSyXyKQCbgMrw9mhISCehYjmNAe5N1tymqKSEO0Bfa1XRNU2mvv
         pFVg==
X-Forwarded-Encrypted: i=1; AJvYcCWmyEJSz/ouUQa1aTYzAd+dXgZ/dWGc7nMMyO1cGbj/8fVlB53O7/fF/g6JgY9Ve+vrNvj/z90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTy0M0DNBbdFiPGJT1IZzNRjgkSv2qXNf5nVPa+7MFoASNttsI
	yRm1QVKarEJk49XwwBhw1chOTkwpt1Y0MpBEk5bEmXHfUoTW3Djnr3CuwaQnFr56wsz8oA2nGmr
	L78HHLx+WlT7KlkCdaOoI50CHpVZUCFBZNB/SDn+/2iawytKExtIlYsGKV+0=
X-Google-Smtp-Source: AGHT+IG/+InU6l3SCKRBCtqkGdLhhTDnXg4Q87LoKI3LfM9Ku6m3WSw99nfIzBsnT2r9jMHVCZCPpbGqxnWboVEZ10RRp44G37j0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180d:b0:433:7c77:be58 with SMTP id
 e9e14a558f8ab-435b8e716ffmr45102085ab.29.1763774223595; Fri, 21 Nov 2025
 17:17:03 -0800 (PST)
Date: Fri, 21 Nov 2025 17:17:03 -0800
In-Reply-To: <6920855a.a70a0220.2ea503.0058.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69210f0f.a70a0220.d98e3.0050.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in em_nbyte_match
From: syzbot <syzbot+f3a497f02c389d86ef16@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, eric.dumazet@gmail.com, 
	horms@kernel.org, jeremy@azazel.net, jhs@mojatatu.com, jiri@resnulli.us, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, pablo@netfilter.org, syzkaller-bugs@googlegroups.com, 
	tom@herbertland.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 66e4c8d950083df8e12981babca788e1635c92b6
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue May 10 03:57:39 2022 +0000

    net: warn if transport header was not set

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15b34c2a580000
start commit:   8e621c9a3375 Merge tag 'net-6.18-rc7' of git://git.kernel...
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17b34c2a580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13b34c2a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14b6a9313e132a6b
dashboard link: https://syzkaller.appspot.com/bug?extid=f3a497f02c389d86ef16
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e83658580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149b4484580000

Reported-by: syzbot+f3a497f02c389d86ef16@syzkaller.appspotmail.com
Fixes: 66e4c8d95008 ("net: warn if transport header was not set")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

