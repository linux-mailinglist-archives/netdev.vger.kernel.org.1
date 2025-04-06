Return-Path: <netdev+bounces-179457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 382E0A7CCCE
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 06:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67CD188AD80
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 04:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A7213213E;
	Sun,  6 Apr 2025 04:54:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199942AEF5
	for <netdev@vger.kernel.org>; Sun,  6 Apr 2025 04:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743915244; cv=none; b=upStmxoKfo0TGMScSm/bWL0hyJ8JcLZt/AmBi/iUP0iMH0tb7YyqG9ALUepwJnLzI4CAcXLXXp4IN92asQGqBZteALWKY0lxHsRnHvOW34Q5siqDpILeGiG1tEGJmSB2LmDypP9GlQt7CVZqAO36nH1aZATeKDKsHueWN8eJ1Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743915244; c=relaxed/simple;
	bh=9shYWMX5Ytp9BXENmbPc8hwPW9/mHMaBBb0I4HAS5vs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q7NFQJtkSjYJgKMw8qhgQs1/Vk9iJqg2rap+yb0cufTYBD9sF8HV69o780tPdUUIB53zglZvtGFNxPNRiIGeyjhUkBtG0zytUNiIcR+J9ssGYZIVL7F1Z4Rj0X6VjHKjnm7ypVYfDn0Cgmopnyl9UrXSQ9Hc9pl3+lv1S7TXv5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d5b3819ff6so36071205ab.2
        for <netdev@vger.kernel.org>; Sat, 05 Apr 2025 21:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743915242; x=1744520042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aGPPyVggy8u1+rNTXf5zY9ekKgRQk29SLeCmXq4Rf9w=;
        b=ZGLnljc/oWXRT2wl0HLszxObcaZYp6yae8r5t6Tj1smYEvNuT8EFONeF1Quy7yRzVF
         zk0DufXmN60xL4vXlGXHk8CDuL2Bnvad5og+cGddj+5AcAThSqYau2Lj5FWEnIND+QvT
         EqFuJ5EsUVCtq4z1pOuZrSBy94rNqvyb7EGKHyFb8V/VpOYx3tj3EAym7wN/ehNlS6zc
         /AtlU+xao7ECkSW2WuKZj2ua3Icwo061/4V+oq4QYt24U+ls9vLdKKmf3p+V4382Mbhv
         otiQCjUYygl1OSXGiBbw61gea5WLBeVlEhFww+AZrNvlLaJ2ZG05Tv7BKYGY1fHhVk88
         Nl1A==
X-Forwarded-Encrypted: i=1; AJvYcCVTX8EstOfsSqqX9AtSKPD/0kSiD/cf3IVXPJJr6eaDacwRAK+1nQoCjSE78P3DCfRiELnnuNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeVoilVb3abw61wuan3O6pXYIDGxWHI3RsCLaC7UAPgopqzDqx
	f8HhwYpRqvHeCSQt48hVGFpCiB+uU6cxT019tgY63TCpmU55VmbZYw1MPIq3QbebxbtD2HDEbRB
	Ba00zeGIqwqDUFr2nmJeyEHZsCqPwpLBSwqFqJDuOFmnDKGtYS3vK0Gk=
X-Google-Smtp-Source: AGHT+IH6L7RSs6IYC/h5tiecLQbSE7pdcCXCcDTsgcUTGyIjASb1IO1tc0crEJIGEIkrP5NU1utEu2Eat6BZFQwbqJEb3MJt1ZlT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219a:b0:3d3:db70:b585 with SMTP id
 e9e14a558f8ab-3d6ec59053bmr49280745ab.21.1743915242240; Sat, 05 Apr 2025
 21:54:02 -0700 (PDT)
Date: Sat, 05 Apr 2025 21:54:02 -0700
In-Reply-To: <20250406042646.72721-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f208ea.050a0220.0a13.025b.GAE@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in ipv6_sock_ac_close (4)
From: syzbot <syzbot+be6f4b383534d88989f7@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for batadv0 to become free. Usage count = 3


Tested on:

commit:         f4d2ef48 Merge tag 'kbuild-v6.15' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10325b4c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2054704dd53fb80
dashboard link: https://syzkaller.appspot.com/bug?extid=be6f4b383534d88989f7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=145f87e4580000


