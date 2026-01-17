Return-Path: <netdev+bounces-250694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B07ED38D7D
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 10:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66E133009696
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 09:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F08334C3C;
	Sat, 17 Jan 2026 09:52:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B669229B18
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768643526; cv=none; b=lFGG6KjJpGepeNxe6GK5F7ua69AmZy5BnmQwio1CdedlcrwdOJdF/Di+em+pWWo+/BUC4vq/D/i+/P3xusfOo6gk59oQXTd3YWHbdEyZR7WY/ihBWGDztTXUIvdBB2yhCTDzbU7gvwpv0ZVjPzreinhjJFuHUMmVHn2hPBoj5Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768643526; c=relaxed/simple;
	bh=eGE6xwnWBaZef2Q9XaOEM+/ndlcgV1e5CHdr5Ad2SH8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WGXNiCxCIkadgLx4nNoyci7Mwy2hROmdFFmB0vVPZYnTdy3HH9Y9mM8IF5NnWVRU0T61z52+2/InqzhBAdVQxnWSo31pK7lCP9kni8fS+7CCH4FLqetCCY+WQ1/H99weUtfUnPcZyWFUc6sWE4DX7IkRVVOKgAhbz+NoJY+bdjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-66112077695so4199353eaf.2
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 01:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768643522; x=1769248322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YEPbtUYLx2Jm4/KlE923UzOmbnLMxWXF0DLZ1mFy3hk=;
        b=Kd4QmkZdTCBV9BRrbx8WqHNA1KvHlK1gC6R43bVuY94k/qnL/WNOZ8mdvb+K61TOCW
         XbhDLZkS/M4DmoS8f4bGcx0JmWQ1a9Y/YiNqGhBZR5dG+ESfhO6T2AT/oHPtLb5BQb7g
         GMXF6Cr4lLTQqsjK+hA9ceZ7iKx/pfvtBwP4hucWYqepHrH1yFNmO9vQhZ+XTZa25ykT
         lPbWCrB+cEi4ufsvxHK6TJkP8X6Xlol9STYE36N5qUYxWY6B524mGMn1aCqPkagX/t0f
         xAfn7eN+2ytkwAKCVJEKlNOuVHpI7TxvKfcTMEfw+AOxZto/OS9EAqlbb4JS/9Ng3rY4
         xutQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpBl8hnUri9nkHvHu6wWnODBhd6bG7lbfKky3ZwQ/jD73wrDNBMRt7OB05OW4aKww3cionyoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfowLl4qvzmOZGscd9vPf2AN7BfehGXW96PqJTdn/PRn2Nmwsm
	b5tC9C3fA/ZGdN2mirHN2TRSzOeDZ5cZWMZTaEtuI4OU3jrPyg8vMc3RGX9c+0Uke9cidbqarzo
	GF1LBqaN+yCCt2zjfw+ghuQBee7V0S+OdAHxhIv/4jUKY3vFgeI/D0gEwTO8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2914:b0:65b:387a:835f with SMTP id
 006d021491bc7-661188be5cbmr1959340eaf.31.1768643522624; Sat, 17 Jan 2026
 01:52:02 -0800 (PST)
Date: Sat, 17 Jan 2026 01:52:02 -0800
In-Reply-To: <20260117065313.32506-1-activprithvi@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696b5bc2.050a0220.3390f1.0008.GAE@google.com>
Subject: Re: [syzbot] [hams?] KASAN: slab-use-after-free Read in nr_rt_ioctl
From: syzbot <syzbot+df52f4216bf7b4d768e7@syzkaller.appspotmail.com>
To: activprithvi@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-hams@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+df52f4216bf7b4d768e7@syzkaller.appspotmail.com
Tested-by: syzbot+df52f4216bf7b4d768e7@syzkaller.appspotmail.com

Tested on:

commit:         be548645 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=149013fc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86243b7b185acc7e
dashboard link: https://syzkaller.appspot.com/bug?extid=df52f4216bf7b4d768e7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16c6939a580000

Note: testing is done by a robot and is best-effort only.

