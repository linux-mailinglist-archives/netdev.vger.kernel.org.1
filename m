Return-Path: <netdev+bounces-155275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8071DA01A24
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 16:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BAF3162A8D
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 15:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208EA15539A;
	Sun,  5 Jan 2025 15:45:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5691547D5
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736091904; cv=none; b=gj+mIgJbPTMjPezVri0w2alDtJvjDe4s4KA+OEz3+sTaXJhhG8+lBX1O9LAKvJnVTlJoYD+wuNKGlCVBU4IRSdmcwdtMOf3fpUp+ftmFdQgcEl1bV8FZUAo4tKpy3S216oPdgSqLS4ZF2qKopgMjIlKX8o8ceMZH+kX1sdZIX8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736091904; c=relaxed/simple;
	bh=xLQhZr0EN5jjBoypeww7FvA9A7WyNgocWYq12D0zgAM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AhwxvsnxBYcxu6iI5Zdcx3shJgAV+SJqt2xyvH0ebhoVVsryQIrQjdG1QSIRytQf40BSvUbmjV3kF6NJ43hBNZMf0442M7N4rFjerAOVClA79JgS6JSfH18KRqnsDMUyUYojWnGwCzcZcnU4JcfV3mU1uLOnVUPwlmUbISCZ2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a9d57cff85so277146285ab.2
        for <netdev@vger.kernel.org>; Sun, 05 Jan 2025 07:45:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736091901; x=1736696701;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYO2mT0l8UdFQloxr21510y8jZ+d6H783XFANJKB5e4=;
        b=VANShloXhhw31lpdUI87iVSGoybwafq7iFvsZYk59suNhabjT3pwB5p16gTv5NJzJJ
         ES47sz7rJ6VPRMhdw0fixL1A7GUEveje0IKK3Z58hTjMX5lmi4/Ak7FKK3ta4PIJ4lVQ
         hWqoaFAVKWGrnaa9XBsNiZg1pcZNOi2cF9aCn83Vyku1LLCzyfgwW4rmWs3cTrN4Qb/9
         XJPYjlqyej4hDGt8WTbFos7beNqyLJzJ/5AD4LusDX+LJlAuQo8wxbpPYrJIyTMZOgug
         1MR4VYvLyWsCByqGkIf4kF8An/t6o9cpyDoUYobTNWByaYsUVPjJ2tDBLjAXGoq1QBz/
         lM1g==
X-Forwarded-Encrypted: i=1; AJvYcCXziTAGdy7S4LEH5xky9+4Jc1en10VjrTR3ZL6HnNpcsdA/NiVrlwGngxXF7LjsTNsmGIAw4ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz8k5tzdDYGLf7wY3qPrB190jqCmxethlroepVjr7FsXoaIikh
	zzV4FjXo920zf1OpYHrm7fLot8ShEbrjeosyTyt566mjXuHo/4CtF68E6P2gE3M0vHljOcT+BO6
	Xpj+EFPo8mcL2DHob0qnoy2p9dQnliMQb5V2FfqCSchRKTL6oUIKyuoE=
X-Google-Smtp-Source: AGHT+IFwCap45szDJbgHItMrNynRyqPDv0rMUC6X/I/GFjB+cEFn4XLaNGO4GeV3q5BlT/r5RZH/dBDV6dduH0YJsOYQBW0UD/dB
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d94:b0:3a7:e047:733f with SMTP id
 e9e14a558f8ab-3c2d1e7f8f0mr533683665ab.1.1736091901794; Sun, 05 Jan 2025
 07:45:01 -0800 (PST)
Date: Sun, 05 Jan 2025 07:45:01 -0800
In-Reply-To: <000000000000bd671b06222de427@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677aa8fd.050a0220.380ff0.0019.GAE@google.com>
Subject: Re: [syzbot] [net] INFO: task hung in tun_chr_close (5)
From: syzbot <syzbot+b0ae8f1abf7d891e0426@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, jason@zx2c4.com, jasowang@redhat.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mail@country-targeted-traffic.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, vinicius.gomes@intel.com, 
	willemdebruijn.kernel@gmail.com, wireguard@lists.zx2c4.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Sat Sep 29 00:59:43 2018 +0000

    tc: Add support for configuring the taprio scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11535418580000
start commit:   7ed2d9158877 qed: fix possible uninit pointer read in qed_..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13535418580000
console output: https://syzkaller.appspot.com/x/log.txt?x=15535418580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
dashboard link: https://syzkaller.appspot.com/bug?extid=b0ae8f1abf7d891e0426
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112374f8580000

Reported-by: syzbot+b0ae8f1abf7d891e0426@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

