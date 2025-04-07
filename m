Return-Path: <netdev+bounces-179702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB03A7E310
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7353916F5FF
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E661F3FF3;
	Mon,  7 Apr 2025 14:54:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FF71DF727
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744037644; cv=none; b=XFxazqPT6vVRMzIcAoWCeDSRWw9Vx+c1/jDWNQingJ1GemE2f6z9u9/394oaASlrfoDTBZMOr390gbGwaktsiT9lcFBEQUoL6m84pJWoyEWVYCtYt/9wXhdK+CZhCUbDj6tPUTdCAq0wSlm6iMY4IYyh/J2x7ax2TdWr1f0IIYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744037644; c=relaxed/simple;
	bh=4w78mRBZGZNNPI600JuP+cOnyzbvyrz8F2Axik6zU38=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=E8ZEXbZW+Y4YsWeY+l9uKL1kyMAhBINNFKz2Q9DragSEM0FWw5lW8qgUot3vu4UDgV2FoJM8wfaB4hRrhvbdkVmBPXhdJHdXcteZ1Y8Ad+N7LVlEXzP26+HmcYQMONH2F/wiF6Mhud0sSVVGYan9fuN69LrnuY36KuSNkgC0KY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d5da4fd946so90822865ab.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 07:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744037642; x=1744642442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87eXy0/HAb1l8mSEeghgon1TgAuvqIEpPCir2UTgld0=;
        b=DEM2L6VV6eSRR3GXTYSen9wMybT33F93JFL3tuDpd2n4NXmxBUJbPkBZEM5D5fBVeb
         JJsmWPDrb1ym9KCM4WviVadgQPUbIWOWfAfuPAWOdRurZCN1Bxlt+2RzyeNGpMHt2Owv
         Cz14Xbl1n9YkYLyD9PqezdajXoRFS9ddzED/3Xuoq0oypbXwQKOYjiL14/QzskiYKfsq
         /b6ijRDvdMOV6+HVWAF/loYfAsGlgfuCeFeDFGkll0NjYbMBvyny5V8JSWC8zUkHzlu+
         2tpRTe/+7LvyDrQqqHjOg8usvDqZXiWsW9+wUCljWv3WRPQ5Gt3f1YdXBkNuUHaRBrzF
         Ymig==
X-Forwarded-Encrypted: i=1; AJvYcCUMwPYpqTUc9nz337Ba3VVZh/YrTlkxfZi4Qw6XLyH9yoYQOvcLiddXyHopSCuMauJXoInmKd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytOu+q1T3LhCHGGiiwdIAQuye99BXOn+bY0XxUs7ZNqziLQnM3
	VunEYdU8dTEnZYmgesAhicaKXZxjOLzSxJJ6ecERJR0YmbxyOnksMBMDGE8oHR5Gm9DjCbMO7p7
	npTleN88JzdJ8H0KfrZCUs4K6h066XOC9JxMpfdBc7RC31qXHKc53ALc=
X-Google-Smtp-Source: AGHT+IEApL7+tBTTM3/AYmjFUw2oyXy+24vzKRuL5QFleomUWv+TfmCZZ8M0Kz2xXcWYob1yS+NvoqfHAmDxj9IcA/hPSIfMGIXL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe7:b0:3d5:bdee:8a8 with SMTP id
 e9e14a558f8ab-3d6ec52d113mr84753915ab.3.1744037642206; Mon, 07 Apr 2025
 07:54:02 -0700 (PDT)
Date: Mon, 07 Apr 2025 07:54:02 -0700
In-Reply-To: <20250407141747.92874-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f3e70a.050a0220.107db6.059f.GAE@google.com>
Subject: Re: [syzbot] [ppp?] KMSAN: uninit-value in ppp_sync_send (2)
From: syzbot <syzbot+29fc8991b0ecb186cf40@syzkaller.appspotmail.com>
To: andrew@lunn.ch, contact@arnaud-lcm.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-ppp@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+29fc8991b0ecb186cf40@syzkaller.appspotmail.com
Tested-by: syzbot+29fc8991b0ecb186cf40@syzkaller.appspotmail.com

Tested on:

commit:         0af2f6be Linux 6.15-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f81b4c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a6e21b5ffe4f6eb
dashboard link: https://syzkaller.appspot.com/bug?extid=29fc8991b0ecb186cf40
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=105b3b4c580000

Note: testing is done by a robot and is best-effort only.

