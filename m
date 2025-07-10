Return-Path: <netdev+bounces-205915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B856B00CD9
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2289FB400E0
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CEF2FD87F;
	Thu, 10 Jul 2025 20:10:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B442FD877
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 20:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178204; cv=none; b=uJFzukolV6qBtpUG5E3R0ZAJqIvZgZTOVE7gcyIuqjhsgCX8zicZ1LRNOZcpBnEdixvkbYvRo4DQTZkX4KpRgzcUr/Gquqnmmlkg4HHXKvialBRrUGkZZxEYOt3BUPe0ggdfy09mvgK8+3kqE3E2JLtFNXB+ddcfNoTZxhJRFPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178204; c=relaxed/simple;
	bh=gFQLhCQuO8ZeRAqNO4hLPYHcztfgq/Gntqnj5vgmx70=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iYepQ8rliF1ECPYjdNafI11baXdgtep7ICHSwP6ABuj9TVu9CEXCmxMq5QpLCgv8AzSJwPAcofLU276w03dXv7DJAxg8+tC+XBGNC1wSt8nogOYXKC3puDt8/EZrh0Q+w7mc1CdFfIaifsKLZL8zOgvImvoy4KW7MK7c02/ruGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e172e68440so14907555ab.3
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 13:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752178201; x=1752783001;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Pxa3RmrXUd7XP4y3Ez9YoubgvwaMh3QfqWsCzDty0g=;
        b=iWkoEla7blAARHipFSteo3Si+iglzkBZTAVKiMCe2aWfGkKADNYL8CS4jUpjWNeDpN
         1pv7ljjVea6YAwlnoLn7/FZC6zdps2k1CQXgX/SIW+/JRzEifTxx/vC3oXSxp6XG6+GO
         /jVquxNPhWJjdT2cTNJTQwm92wVddTSsZJesLlHw7vkpOUp6z6iMU7SjDpZDG5CTSypA
         vBYqUSJGWNMMpu+2f6b7EHer0YfFBra3D6cN8oKBMs87JBotW3FyteIxyL3FZuQ4vvlD
         YGhGvMX9aRcDASce24sFrrjK2OgpuvHn9coEkY0rOoo5B5f/rXQt2K3X4YFcJl/StmnK
         wncQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhvMJImesQqY90aiuB7lpe1ntDibCCkky7InhvbEwUH8kS0/MeXiX1au+LcS3b+0raCX9Uk5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqOCctSHG9FItax2qXZT+AF1yM/iJHyQD0u9OIXx2NiZdZY8uv
	SeCygGbza0LcZ3gnpkB5kofXfHTmP6x9Nd3aeHekp6pDw6AOIN6178Ko804vbSatCFM+ZqqWUQj
	xyg1gCVAVCx8xT3UBBwCopz12pJd3bCc4pcKjy9BYBknh4LI42q+NyL0VIWk=
X-Google-Smtp-Source: AGHT+IFggx9JbriZOmPuGXePKBTVWM5kDd3JYdYz87L6cNFN9QpcyR9jvFNkIRr+16nYfrzAdQaUNvtpGEKE4JF+LcDxTY3QCyh9
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b:b0:3df:4159:8fe5 with SMTP id
 e9e14a558f8ab-3e253272d56mr9684205ab.4.1752178201628; Thu, 10 Jul 2025
 13:10:01 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:10:01 -0700
In-Reply-To: <4687a61d-e4e7-4a1f-bbf6-59d3decd6fcc@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68701e19.a00a0220.26a83e.0020.GAE@google.com>
Subject: Re: [syzbot] [usb?] WARNING in usbnet_status_start
From: syzbot <syzbot+3f89ec3d1d0842e95d50@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3f89ec3d1d0842e95d50@syzkaller.appspotmail.com
Tested-by: syzbot+3f89ec3d1d0842e95d50@syzkaller.appspotmail.com

Tested on:

commit:         d1b07cc0 arm64: dts: s32g: Add USB device tree informa..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16f83a8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28729dff5d03ad1
dashboard link: https://syzkaller.appspot.com/bug?extid=3f89ec3d1d0842e95d50
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=164bda8c580000

Note: testing is done by a robot and is best-effort only.

