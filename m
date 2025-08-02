Return-Path: <netdev+bounces-211464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFF5B18F2B
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 17:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035B8189B8A2
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 15:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54092248A4;
	Sat,  2 Aug 2025 15:01:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F5F22B8CF
	for <netdev@vger.kernel.org>; Sat,  2 Aug 2025 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754146865; cv=none; b=X3NwmWQvkdxHsZ3UnDZqPhYupXaDomybkYYvQk7J7Z5O4SClHtY+yKhtajEhXKmoiH4HicX+KvGMuHM7IQHO9DOemhSGHntRsrHR85Qc/ck60rAahl9alg24OplMOvvZe4mmK2oLI97JjIGYdFGGbv4TIKK7VbOI1NJmskqEzVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754146865; c=relaxed/simple;
	bh=EpXsiXDlaAijMIG/2TXsIuAgTscjINiku6LvJ6STKi0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NxddcL5u+l7MqgWvV2w3FoIRGIY24AYNvpBaO//ymaIH7o+Hp7HN3OrRwPIk+Kjk1FeWJKSyGj4sy5OH9fwT4Y05NIuTowBWGTe18nE7WyoxyZ9z7fw06bW+yCHvHD01Is1YF0kVxVAka0yR/yGsvhC4abUascdmE47a+tU3eLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e40bc54f89so21285415ab.0
        for <netdev@vger.kernel.org>; Sat, 02 Aug 2025 08:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754146863; x=1754751663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/Ecw3FP20+oDYQixIHPpQylVTslIptkPkEbIYt0Lvo=;
        b=Kh4hvMfgicgKTfGgpf/d1GJYohlmfgbHv9n6u9KjY1mF/bmjBJwuePoTS1rfT58BKX
         rWhWL8Qzo3BPFXQGtRM/hBQFPR/lu33u+Y1HWXLTNnw7eqY/LBiK4ml+HjbA8jVZ7XSg
         zigInuI3BwPHs+Hsfuu6JBqguB+cXNMs6L3nIO10JOE/r5wUt9aYW6ewDDQ4WKnoBfqk
         6i5ZixADDWXScjbDRzcU/N/7dOsDdYqyTfyjiCqZxTj/Y8jUETIUVUMh3AvSk7JqmroG
         i7NRot1NxvexAMzis2aj6Z7RSD/6O4OnwxrER5+T7NoT4+K8JbnEY3PRBkxr9aC+sPFR
         zI+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzZHbyXf+biN5HNJkrXs62rLflI2kvx6WuCYJ1ofjGHWFPZ9NnMoQ+KVFhVYbO96M901qErhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7iJi4lpXo+nE8PzAE49VzVgKEssKt46dmmytCNYgV3x56siK0
	v7GXxOgoONAo7aMtqxMsmTuRqYKUKjwPTKwCWPIKnpuOVQ5RfMe+1yzJyQfNjmB5zLTkGTzi+uW
	3Ac9WdDSwDAswuz5OmEy0v6iZ3NfewZjdW6cOxZ/Ue3rX8r37QLFDRYOO19U=
X-Google-Smtp-Source: AGHT+IFiv8g6pWUx4rUWbWQyjoXB0UPEAtgCnjzWk+ld07aZhDICdYrH4MXl7HbUpJyUXdOrr0GR/ibYh9xtsEiFXU4aiBw4HA9k
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3093:b0:3e4:6d6:b436 with SMTP id
 e9e14a558f8ab-3e41618be54mr73004845ab.12.1754146863239; Sat, 02 Aug 2025
 08:01:03 -0700 (PDT)
Date: Sat, 02 Aug 2025 08:01:03 -0700
In-Reply-To: <684a39aa.a00a0220.1eb5f5.00fa.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688e282f.050a0220.81582.0000.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in __linkwatch_sync_dev (2)
From: syzbot <syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com>
To: andrew@lunn.ch, cratiu@nvidia.com, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, jv@jvosburgh.net, kuba@kernel.org, 
	kuni1840@gmail.com, kuniyu@amazon.com, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, liuhangbin@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sdf@fomichev.me, stfomichev@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 04efcee6ef8d0f01eef495db047e7216d6e6e38f
Author: Stanislav Fomichev <sdf@fomichev.me>
Date:   Fri Apr 4 16:11:22 2025 +0000

    net: hold instance lock during NETDEV_CHANGE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13eb22a2580000
start commit:   afd8c2c9e2e2 Merge branch 'ipv6-f6i-fib6_siblings-and-rt-f..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=101b22a2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17eb22a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4bcc0a11b3192be
dashboard link: https://syzkaller.appspot.com/bug?extid=b8c48ea38ca27d150063
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fa74a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117731bc580000

Reported-by: syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com
Fixes: 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

