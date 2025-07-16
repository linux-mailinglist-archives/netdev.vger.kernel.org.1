Return-Path: <netdev+bounces-207337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ECBB06AF0
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FF41A64963
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358DA21A445;
	Wed, 16 Jul 2025 00:55:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4CD7081C
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752627305; cv=none; b=jV31Vgcb4SaXS5bFuyazh22X51rNTV+6zVfdqZPA5CcZ27OsnS4/bWhDv43EG0aa26WtYCJBHdLX7N7QNBCzb303VWrF5Hl84L+hZD3sHPUCADTVB0s3DlSb6oDzpgPQIvKtgU9abdTmlkszLK/MTL4B+tCXqwgbqf5iq8pZmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752627305; c=relaxed/simple;
	bh=DP8GiTDr7LONFqWrhR2oRaGbm4kOyXlAQ88DKWR6cFE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TlfDQtYZMcLmPKCi5Hb0Wk2yh3JvKi3dFnRm7afbD/sT9jGB2g72+tZidQnHw68bnePDeRYksqMgjJHuGCqfdDx8j78YnkKSk6qU9phw8g0I4ULqfnk35mElFGUGOnXKBva8S8piDHzFvqaQHjUm8p1Pf1XjFnvomcC3Ljvpdqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-879489ddf11so1168591939f.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 17:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752627302; x=1753232102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTgObeiSF+es4KOes8znjLU8b3MFA9dVOpbWT9GtXpo=;
        b=KxUFosKhcaNZXJhtQNWDe9vGpaqAXLbmvPWcCbfpTYFD9i5VxYLxrjYuMmbLp726Xg
         5/Jc5ExxLqMPeerteRPrJLqNOTYh6WOte+/gJ46OSxZFisvT79QPaSZlGS4okNe1t2Zd
         /t/OTRQFwbMoyoGC6QgQwHq3EACAozQEXj8tuV9dwBZNQoVuj996VltSM+Z/KevNYXrb
         0EeQXBvf8hWU2y/cPhPPMfOgjmFipUIvoYvdPBo3fKVZe+5lc8gNOxVwI6a7Q1h13hpt
         VGkrIgrB5kEBo/gvGFWGVJheFaiNCiuoiKp8BZS3YJyRASi46bOx8U+aEQ3eu6uCLyXT
         xEOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIbDFTDp4DmG9uasIa6IgqcaSoA/dbCOtrDhxBqzTrJvpDYrYJ7uJMW3pUAcfZzsy3kcZ0Kr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySRnAfQL+tnofQKhpNdDLykYtXy6RHfOKwvyT+plm3M6hWIzfJ
	mhO3YZ/i/o01jOHMCS0xLlJWYBQIJ5aUwye6c2IHAXhyvfjQIj4upAqs8OKuLquIabE35O4hHd7
	ncoiXYyd2DbqnhDU+RjN2SEeh7xgGNpZdsbOtjoTiJ9ml0m8rteFka6ylcAA=
X-Google-Smtp-Source: AGHT+IG2Ujec7AL48oA6oc7jrWfZ15/MNGS1ftRczCGlyjHTpMmlvzXzUdU+nJUgpJca62iKOILg8FGu2YvBLz1oL5ZxoVIiFUcI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3e9a:b0:86c:fae7:135d with SMTP id
 ca18e2360f4ac-879c08a24cfmr204755039f.4.1752627302333; Tue, 15 Jul 2025
 17:55:02 -0700 (PDT)
Date: Tue, 15 Jul 2025 17:55:02 -0700
In-Reply-To: <6876cc3c.a00a0220.3af5df.000a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6876f866.a00a0220.105e77.0001.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in tcp_prune_ofo_queue
From: syzbot <syzbot+9d2a6ef56c3805144bf0@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	hdanton@sina.com, horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 1d2fbaad7cd8cc96899179f9898ad2787a15f0a0
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri Jul 11 11:40:05 2025 +0000

    tcp: stronger sk_rcvbuf checks

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13b7098c580000
start commit:   55e8757c6962 Merge branch 'net-mctp-improved-bind-handling'
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1077098c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17b7098c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8235fb7e74dd7f6
dashboard link: https://syzkaller.appspot.com/bug?extid=9d2a6ef56c3805144bf0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12494382580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103327d4580000

Reported-by: syzbot+9d2a6ef56c3805144bf0@syzkaller.appspotmail.com
Fixes: 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

