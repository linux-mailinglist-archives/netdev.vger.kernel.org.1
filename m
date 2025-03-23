Return-Path: <netdev+bounces-176945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC25DA6CE1C
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 07:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B01617A2CCE
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 06:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55C52010E8;
	Sun, 23 Mar 2025 06:53:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD471B532F
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742712785; cv=none; b=RlUdFf36fz2vEUHb2jcVmtBTehND+C6wk7H6bFfulicakaeTNgyChHxGR1Wd//ZTmoIo53QVBQyBJ0FYgWIEHgdjaNdonA9frOP3Kztavu4IDsOyWFNlDaIhWepKP1Kn2agZZeEgjtHIowbyhhF3cGO87zfgDFul+wOybMqWD2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742712785; c=relaxed/simple;
	bh=Bf7yka2w1VVpUuX6J7h+vWCKWalB2ArNcjPpVEqVGZc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eKiW2cSTnmxxjZ+Q+E/HmFl0MyEYx4NhdB96XA44Y25mHNXFXbTKevoG4r+39fHdA7eiPA6IpEMMdyWJ7u9orEKf6UyyFqaWu30ekh5Y4qrxp7qmDwxdU76U4R5epbbX9AVJOw3PQOfYpgcee7jbL6cQon2qzOTP2Ky5PwnzW4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d2a40e470fso26251975ab.3
        for <netdev@vger.kernel.org>; Sat, 22 Mar 2025 23:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742712783; x=1743317583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuTtDdQllfqVQdTnY1GFjo08/XepPL02PHTKNSl5Nyk=;
        b=CiuOIxRqzo+7MOrRrudTTDRgeniABGQv0asAEzPjtRxzrit9ypAy5Ybhu7opX1g5Rs
         w/aDQfmIEaa6veM1xE//5bmBlkBn+LmLnLT1w3XiGG5hO6qBuyF5rD+jVw5DklL5vFTS
         yz8MNfdJ+VEoDrOooW1yT8o4lO5OFzMkBmCrFZTTcC6lfEmiVlY2ZnqL44wyRYUv+StP
         r6gheOxRabGKOCn/T9p4iqo/WOUALpg6nx1nh2TOBrGdIyAxxZHjGH83zwa9FyhCJgJ4
         Ti8DBNk1kzJ4ggfQtPbnH5HUmN0MyjWVvntEjEfyE2Hea2BX61Of6ok0Or/kp+4muvkY
         IPqg==
X-Forwarded-Encrypted: i=1; AJvYcCXOg2yJAgP6fLEWnbFGf3iqgk0OHmcybX6lVTaorin6Q7Tk3fbHloKWaUuj+F/2ObaHHf//7BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrnej+0xruYDRipZzYGeWh2AIQTBGRFOTpLfAIvzYQSgr6HTeV
	CxIGDYk702TdoC06LoXMEkdigkOjrTW4f0fEiQOTP6w7Zv/0WysptDBR3Zhyfu7tTduakoivuxx
	PfVKXN8Vs2JiIGygJWbr74bVwdFCjD2FpEo4i5McK3+k3wNMEzPoCFXg=
X-Google-Smtp-Source: AGHT+IFomXej1RrN6WELV4Qii9/yxfjxlWnmlmMb+ysYA1j31F3Z04e+3d3vMyCUXzjVvvz9y1wv7XB/R6rxL+wT2R6HvXmksUMF
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378c:b0:3d3:cdb0:a227 with SMTP id
 e9e14a558f8ab-3d5960f4d68mr77368565ab.9.1742712783188; Sat, 22 Mar 2025
 23:53:03 -0700 (PDT)
Date: Sat, 22 Mar 2025 23:53:03 -0700
In-Reply-To: <6707499c.050a0220.1139e6.0017.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dfafcf.050a0220.31a16b.0058.GAE@google.com>
Subject: Re: [syzbot] [net] INFO: rcu detected stall in sys_getdents64
From: syzbot <syzbot+17bc8c5157022e18da8b@syzkaller.appspotmail.com>
To: apparmor-owner@lists.ubuntu.com, apparmor@lists.ubuntu.com, 
	edumazet@google.com, jmorris@namei.org, john.johansen@canonical.com, 
	john@apparmor.net, kuba@kernel.org, kuniyu@amazon.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, penguin-kernel@i-love.sakura.ne.jp, razor@blackwall.org, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit e759e1e4a4bd2926d082afe56046a90224433a31
Author: Eric Dumazet <edumazet@google.com>
Date:   Wed Jan 29 14:27:26 2025 +0000

    net: revert RTNL changes in unregister_netdevice_many_notify()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1084f004580000
start commit:   fc20a3e57247 Merge tag 'for-linus-6.12a-rc2-tag' of git://..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba92623fdea824c9
dashboard link: https://syzkaller.appspot.com/bug?extid=17bc8c5157022e18da8b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135f7d27980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1483b380580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: revert RTNL changes in unregister_netdevice_many_notify()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

