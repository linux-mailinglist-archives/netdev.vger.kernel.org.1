Return-Path: <netdev+bounces-206423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59401B030FB
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 14:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9413B4EE7
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 12:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECC9227581;
	Sun, 13 Jul 2025 12:20:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E7218580
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752409206; cv=none; b=nOrhLGqnBCNHcPAFRUJo6edlOhcYcMvE/gyz2C9uUfYp9z5VOpVdZ8op9wh+8kfAtWjkYfhv0xAwv54BGAo4wy32JGwP1OfTT8x1IXgJ8xU+Y89JD4cuLbmcC3uWLAf2sb48mXn9lM7WcWb+Kcv9U0xmTV2dPA9TjjwoLEE6z2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752409206; c=relaxed/simple;
	bh=4TLGo6GK4QSP+WPahMdSl6hUqJJNrHr+VZrospIkjj0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mlMxtqqaQfT++hlZAyNJ31gXlilGRu+6OekgPbxVz+B/xNsro0aQrK1OfE1yE5dn/VtNe2HE/6HKPLsavE0H2xX2vf9/pa6GJiDaFvoKEPyByev4iN+7n2Px0FCAPi9jYCP6utJix9wZCoYxxhZY/WGCdnPFs/f12Ks+6TuoVQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddcfea00afso56286675ab.0
        for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 05:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752409204; x=1753014004;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHfZZYwlltX3cnWzSRwgx2BtUxjdDvi1oy+Wb8i2L5c=;
        b=puCaCn71Pr9pbuaSrXwFdX6B1yZ1S/JFnlDDeZAMJLQyk9r1TDV0tlgM9wcQzZQ1aO
         cUup55qjaIspElFhmde5eSeBpeBXhN9ni2CGQzX8gHMcIO+OoER9gwzHosBQJ6WZAlUM
         d/2/zpWVo4PuuF9azjFhw/cMC26XiZi7mvDMjGfGlGkejobwIcu7lzreEMZj9dKpcwkJ
         od65/QcJYz4zKLd1fmA/HkzsBR6OR3sxz1R7xNdvBxIOSq5n3x2tRx7TVNK7pkCglPJp
         g/vKQviGLV44dwgfOve6QLxWk0dIMaDLQaVE0lyiKVP9JLVhorUgTCDHhfZtyKPGsCk6
         UF5A==
X-Forwarded-Encrypted: i=1; AJvYcCVqnqNTg8sAiFBa6T3l3jUke8xT1uPS8JI1xOh+8WaU2ngRNbGmbvtc7yf8+DUaLrGMg6jLMNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye0MlfN7P1BoRdvlkv5ut3RfzfMJOkcz2V9dItgOGxosMyCC3I
	PM/Mt+t/r4fJb5DqV7BTjR2al4fG74WQ9QZEb7WX52Pf4bWhNFcmRzWrjzIcX/7H4NPkFU21uxP
	ux5uBXlfUOl3zrzzLCshXKPIIO4P4wOlDykPlt7cf97UiCLjCHmA5h3yRtAg=
X-Google-Smtp-Source: AGHT+IF2Exx2IUNfv7fdIrV5sTW8rBytOis0b7TGzJm4zo9XvFCq3New/6Dkvq4Mr7o0fywQcedS34O/GhHp43TJvQ62c0w91YUL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b85:b0:3df:399d:39c9 with SMTP id
 e9e14a558f8ab-3e2542e803amr113121025ab.2.1752409203286; Sun, 13 Jul 2025
 05:20:03 -0700 (PDT)
Date: Sun, 13 Jul 2025 05:20:03 -0700
In-Reply-To: <6743b30d.050a0220.1cc393.004e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6873a473.a70a0220.3b380f.0031.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in blk_mq_update_nr_hw_queues
From: syzbot <syzbot+6279b273d888c2017726@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ming.lei@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Oct 25 00:37:20 2024 +0000

    block: model freeze & enter queue as lock for supporting lockdep

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ea5d82580000
start commit:   a52f9f0d77f2 Merge tag 'batadv-next-pullrequest-20250710' ..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16ea5d82580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12ea5d82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8235fb7e74dd7f6
dashboard link: https://syzkaller.appspot.com/bug?extid=6279b273d888c2017726
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14321d82580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179590f0580000

Reported-by: syzbot+6279b273d888c2017726@syzkaller.appspotmail.com
Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

