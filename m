Return-Path: <netdev+bounces-165009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC97A30020
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 02:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839803A37D5
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 01:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DA21E1C1A;
	Tue, 11 Feb 2025 01:30:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E41DF960
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237407; cv=none; b=G5FSn74k0o+mqw/ewuUBhkp+FOYTpgIqHXVjG63JPtSUG8f9mILtD0RMdbznzA7yGYVnYx2S+wGDOQ+qxRbKviqnKsFcl6qnPhjQ2smKT2NOv80NESsltbClr5dg4PTBGBvgvFQOxZpUbxOHxPJYzbJP3BTtvR4YmnAwaa24ZuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237407; c=relaxed/simple;
	bh=v/Nh6V3Squ6zTlqOd8JqUTRgJWgw0anyNQlDu2hHeM8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IfNsx1ji0zBUxyjYF6UQHRAb2dBVvuafUdmnAFZ+RK/QkeyJfSo+i2pCtgpG12cQe06cqoeciBqyCUvk5mWnb8Xx10vVNMioOYoLizZT+kgXx+zdJmFsGUNSp2Xl/3t0aYTylOoV1LFzZlDTwrAy7v8tRDxda36QK0WaHTJu11Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3cfba354f79so114718885ab.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 17:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739237405; x=1739842205;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6+FBchsBBeiNSoV+eW+VD+Rx2zp2Kr3ieu0cpfLjMM=;
        b=oDMITndybtlEL/dctBd0x1y4qrQpNz+2FUrBF9QeJydikmFVot2MxPbY5L0dVTj3zB
         boR79Ciu4Ns2Qmqv0rqWN0dQtTBWVrr8U2WI+ZQiAv4hCGyJLHmh1JvViT64kairAtil
         TfdcpxJpvCO1RL9A85CVQmNVSmAYC4dIsH3/LFzOxaQ2z6rWYXaAV/tRy7HN4NJXsrWI
         mDlgA4I1tpPR62wFJ5tw8LkjlPX1KUtajyfOfHQyD05eglJ0SNzB5a9FjVZlyQhm/F0/
         sRKX+jhX3hYpzLRJOyeT5C5Z9A3r1hmUeIKCvEGt9cj02+f3VIIhSEkn/aY02xxWoGIN
         p7ng==
X-Forwarded-Encrypted: i=1; AJvYcCXO+ocmrt6ADD4tF7wJXlVjbapOnFedzh+0Y4DFoDJit8OBBBl670TN3SDtyH2KpuYVuHnwcvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnvfWyZ4EfNdAJ2QS5lKEW1hofPzqaLjDQNNU5vl/fztC9p7nK
	6yGK9PAv+500LgIYZNTQYd67IlPwfumf+Xfk2qhYV1hsnoZp98r+r/6o7E76L5qUzJg5L+1pWjG
	vgzxT9WvcbB6Jq/t2Ln1JmlVGzvZdisRP8qugtFK7burwwvgUZpODfFg=
X-Google-Smtp-Source: AGHT+IG7+XNeWPwTQyEuOSiBbyR17tnLyzZGxNLcT/H3Nag+ebW/Zo92Lj1QdCiNeeqakv6HPCbyQQayKdDo1wilBgT9j1TpzxFv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c546:0:b0:3cf:ce7c:b8b1 with SMTP id
 e9e14a558f8ab-3d13df2c784mr118031675ab.18.1739237404979; Mon, 10 Feb 2025
 17:30:04 -0800 (PST)
Date: Mon, 10 Feb 2025 17:30:04 -0800
In-Reply-To: <67867937.050a0220.216c54.007c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67aaa81c.050a0220.3d72c.0059.GAE@google.com>
Subject: Re: [syzbot] [net?] [virt?] general protection fault in vsock_stream_has_data
From: syzbot <syzbot+71613b464c8ef17ab718@syzkaller.appspotmail.com>
To: bobby.eshleman@bytedance.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, leonardi@redhat.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, v4bel@theori.io, 
	virtualization@lists.linux-foundation.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit df137da9d6d166e87e40980e36eb8e0bc90483ef
Author: Stefano Garzarella <sgarzare@redhat.com>
Date:   Fri Jan 10 08:35:09 2025 +0000

    vsock/virtio: cancel close work in the destructor

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12bb31b0580000
start commit:   25cc469d6d34 net: phy: micrel: use helper phy_disable_eee
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=d50f1d63eac02308
dashboard link: https://syzkaller.appspot.com/bug?extid=71613b464c8ef17ab718
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125a3218580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147f11df980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: vsock/virtio: cancel close work in the destructor

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

