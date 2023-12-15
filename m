Return-Path: <netdev+bounces-58138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5836C8153F1
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 23:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C6A1C24807
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 22:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4162917987;
	Fri, 15 Dec 2023 22:47:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCF7495E7
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b42af63967so126059439f.1
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 14:47:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702680425; x=1703285225;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZWZIC0FcoRkbciVDc3BkoS0NaydfXxlAVCYnHQk9q8=;
        b=PGzowFCyK33RaQS3DCg+AA2izd8Fst2AlJaA3HFaPZnDFVJdOvgEZjvB69C7GOJj/f
         ATyV1Ng5W+A1Mi7mtqn/bvaOA2YQ0ax4sKJJ4c2AVeL5yOt7ycQQJQghBrPDGfEaN8oZ
         vaZQhZ1donB37O6X/e9nb78dk/GfcwpPIOhk5QwlMiJwenNLIS5qWXxbiOO3IKmMNz+3
         YPQn1jrQ71rsorJrTgDObVLa2pYUpNDYDYQqkUvFKoCq4OAOFnfKgGoah2yfyHfAm2IO
         s7ra7S/7McYT3VMdbgxEaXpkIujpMVGzM2mBiLbl1XKAfg7DTZihEMk3VL00GDMU4obY
         exQg==
X-Gm-Message-State: AOJu0YyEHg298jtBwfeZdLftXHOYBSoIG5k7Nd9bDY/N6jAlu9mHTWij
	xpnO8OQ/GI38RCm/zcWvsSH8j7vp/RRB/d3acjkmE6u/RNAx
X-Google-Smtp-Source: AGHT+IF8ErutNgm2nKhcrvQd7qgl08tqQHShioYvHK7Pd5JAJTH0sNsgSRlj4dNZ0AM1OqNEzWqPQyh46GhmMkdI3CGKRcnOKdrv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a3:b0:466:63f4:c6f8 with SMTP id
 w35-20020a05663837a300b0046663f4c6f8mr380739jal.1.1702680425250; Fri, 15 Dec
 2023 14:47:05 -0800 (PST)
Date: Fri, 15 Dec 2023 14:47:05 -0800
In-Reply-To: <00000000000011da7605ffa4d289@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9c652060c942d35@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in hci_cmd_sync_submit
From: syzbot <syzbot+e7be5be00de0c3c2d782@syzkaller.appspotmail.com>
To: atul.droid@gmail.com, davem@davemloft.net, edumazet@google.com, 
	johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	rauji.raut@gmail.com, syzkaller-bugs@googlegroups.com, yinghsu@chromium.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit c7eaf80bfb0c8cef852cce9501b95dd5a6bddcb9
Author: Ying Hsu <yinghsu@chromium.org>
Date:   Mon Sep 4 14:11:51 2023 +0000

    Bluetooth: Fix hci_link_tx_to RCU lock usage

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16dbe571e80000
start commit:   9fdfb15a3dbf Merge tag 'net-6.6-rc2' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
dashboard link: https://syzkaller.appspot.com/bug?extid=e7be5be00de0c3c2d782
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165c9c64680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f91628680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: Fix hci_link_tx_to RCU lock usage

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

