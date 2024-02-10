Return-Path: <netdev+bounces-70697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D36850104
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 01:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E84D9B2653C
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 00:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF0337A;
	Sat, 10 Feb 2024 00:17:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E80163
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 00:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707524226; cv=none; b=jnA7AYLYQ4904aaKoYTaXnb+Q7PvYl8SjRkfZmRwU4wU7ZF8K7y6nz/Sme0nktz+9VA/E7Xq8VOzTMZGAtvgeuJEcqjkAHH0Y7R6QkP8YIAd3ljduBSTZrdZPd8L82DwFiQb8WLc6f/t+925nd2PHRAmXVIQFoArneeU2D81WFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707524226; c=relaxed/simple;
	bh=4ge+/WmzvR0J9ejhrGXr1W+09OnA2O5Y9YuwoewWnzY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DKJZv6ZQ4Hp3wQbaijL2LKZ6t7n+8SfpMCjjkZg3d35RPHyB4EQAJTqFT4fNX0NjLT/dnhcgolR7fPO3hHxwvyNBw4uP0OmfzHqsL6IJB/au38lMoQMaq2o5uxC15M6sO/PDkKuQFwEqcv6brlGJ300XRSDO4eQLMoP6B/xEHms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363d6348a07so11855175ab.3
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 16:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707524223; x=1708129023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rH7XWE+1Uesz6zBrfYb5Ze0RvaWDz5N+5wCoQa9ttkk=;
        b=d7TeAtEHuruXvd0HfrQ7jj0/J6CIIb9mJRkq3aEAUr+NvXRCa2dV22/z34yyhUp6JO
         2UXhE3yF6ej1o8Lfy4L2tGafo5iWcQw+l0f+j9E0Co0coukV/rnWZIZ8cl4epmp8Fuql
         ivYP3K9C3e1AKAYYHna1sJuHbYixHw3694b44F62JBOvNwQ2tBZJhkAUL5KZ6FIOLqHy
         TkqMIJeYnKZSSKqjv/+XCUesmzHRXlDI0BzdxbGEudk1pFbki3WRU2jTaViqTKlsOoCJ
         GrzL4QmW+f/3n/f6sHw9dMeuQLO4Pxd51vYT08TQzejvxdcdEvfWTKaRQKuRC5ErSMu+
         4qXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9v5DAf5KhU//zLfuaIJTHb68Ch5PXYEZy6AaRqyp8rFuiEr2SXgEaIDYRsbuUXQfz/oEPmd3d9xvJJL4/ZWoM9ESSkRRU
X-Gm-Message-State: AOJu0YwBmkvqn/WPUXv5WRVOv0nnjpDkCSTu19sHNGfxt0tJlfpqcxpI
	EXJ+fUbIHnC2sXBqBSYrQglvgIC/dMBUdtC14SlooLD4PwvSlmBnM21A+qUe4eMBodDQwVDEPhB
	vd6QW+Ro2hX8+8Z/sMsivVUGkACShuWHBedRdkX1ow7fAgoWw2eWDuvU=
X-Google-Smtp-Source: AGHT+IHaSCpSBmrGWfp4RAWRiVgNaUBDrl+UwAAOt5yahbYipkZfIVgzW/xl8ZNcd1Dq2szhLGEgZjca74TYQxXTUaIL35YpvPpK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bc7:b0:363:e134:a158 with SMTP id
 x7-20020a056e021bc700b00363e134a158mr36517ilv.5.1707524223738; Fri, 09 Feb
 2024 16:17:03 -0800 (PST)
Date: Fri, 09 Feb 2024 16:17:03 -0800
In-Reply-To: <20240209204745.89949-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd2b640610fbf6f1@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in unix_dgram_sendmsg
From: syzbot <syzbot+4fa4a2d1f5a5ee06f006@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+4fa4a2d1f5a5ee06f006@syzkaller.appspotmail.com

Tested on:

commit:         1279f9d9 af_unix: Call kfree_skb() for dead unix_(sk)-..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15c46df4180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=878fbcf532b1a170
dashboard link: https://syzkaller.appspot.com/bug?extid=4fa4a2d1f5a5ee06f006
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16376320180000

Note: testing is done by a robot and is best-effort only.

