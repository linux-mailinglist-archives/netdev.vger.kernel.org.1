Return-Path: <netdev+bounces-141138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 801FF9B9B9B
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 01:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2600E1F21B1F
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 00:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0A2A920;
	Sat,  2 Nov 2024 00:43:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BAA191
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 00:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730508184; cv=none; b=EBg1HhIjAmGpH5edC51OYI1nGqbjKJM0Lzk5pkzZVaTC58zYHQ99M+DQGpWB5jw7/Tt8kEf2THtHBX9+OOz/wOBQxcATKl4VZuuMjguH2oAbArriCMPM7iKwpZxGsUR5p5byvokTuU5qGnlCwd/R1PrIVfX7tBhm27UvAGsD/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730508184; c=relaxed/simple;
	bh=t6+nYbWnTUcQph4dakhbCHXeYuREcutQ2Uw0L+Njw/c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GK2mhhc3VHLmfknfuUJgZRTPVgPAM3tUEqdVqHYeSYEYkEoB5I/SUaQmHh2H7HjL/ZXfqg9qDqBGwHuTAw01+yLrQX63GpzupZzuXCyjfPo3dMx0/X+8xyiKpbkBkcLyet3zkLMjXy1hRlq9xt2aJm7dUrrlX/eeGpSaCEhzfkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6bb827478so6452975ab.0
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 17:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730508182; x=1731112982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blDNl7p3TrZu+StGKdiZkS5V2Mkh+Znm08zp7zUtOfo=;
        b=PkXOTZNWSFQpP7F412u3r5KL8oJOV7XNNb6xzqBYI0sZHJl6+ak2mwqigZ439TgFNy
         jsox4ETvfJSTlyHKtVzirYl5zGaZwWiMAD4nkcHsMZs5tsHTB/racpgHIzrCyYmMHVkJ
         cRFdSt7uJu6n+QGzjSJgT2diZQZ4rCekqzwZUFI28Q334jyHJSemt4RNUVP1cVx/ZUJS
         qpEk7WqUeQ7MOtY6Yg/C+XeulGm59K1pb4H0hEbhcc+fiXYqfHqUVEgS2yT82sUdHawC
         JRrjDVh7AqdSsfRCSbcKLRRloR+3OXZNH53f30q0td0OssFGDKMuj+hfpmsrJy4WcVG/
         7PLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMozMzmMp+uUcUeRqiEo9rw69y2eoJD262pmvw3kUwf9lBqYdLmRCQneXk/c8QyHPsxeUjyAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdyQOp1nGbp7Df8WbvvDkdq24DVYO/jrCznBlYKWONsKC9nKNO
	dfPTN/Fxo4aNJA/1db4NTpk2RqACtxIAG6qPYS3J3VXXJptW13Ap/JlrQbszr3Cyb0GBtEX5KYh
	XIXLepIJV6PUa/kjvvUqxD6qUSCJUgdc0FAcsDRgZkyyQMtLNAjXjgTU=
X-Google-Smtp-Source: AGHT+IHuX3D/YUJcxTR7pHn9w36Es3rDqsxXIZTtq6kdzV4AeD4s72qmH15UucBYNu62Uw0qCKqYE74K7+7IeY+fiSey2rl0X7Ah
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218f:b0:3a6:af24:b8c4 with SMTP id
 e9e14a558f8ab-3a6b0354e19mr60407115ab.20.1730508182395; Fri, 01 Nov 2024
 17:43:02 -0700 (PDT)
Date: Fri, 01 Nov 2024 17:43:02 -0700
In-Reply-To: <ZyVs271blMTITWVZ@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67257596.050a0220.3c8d68.0912.GAE@google.com>
Subject: Re: [syzbot] [net?] general protection fault in put_page (3)
From: syzbot <syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com>
To: axboe@kernel.dk, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, hch@lst.de, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, ming.lei@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com
Tested-by: syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com

Tested on:

commit:         f7270670 lib/iov_iter.c: fix iov_iter_extract_bvec_pages
git tree:       https://github.com/ming1/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12849630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3ebcda5c61915e91
dashboard link: https://syzkaller.appspot.com/bug?extid=71abe7ab2b70bca770fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

