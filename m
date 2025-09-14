Return-Path: <netdev+bounces-222844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBEEB567D0
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 12:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7DE189C3AA
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 10:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD1323A99E;
	Sun, 14 Sep 2025 10:51:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DCF2264DB
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757847066; cv=none; b=EdhRjl8QQuZdqCih/t2f+tXVCWUpsPHWGRdF4nPXGi5iC28HmGZNn3zfK4/VOGX18bKRx0J9qfBkWwshpczna40KM7h5g7ORSxprL+7WObX2JrXb22TmmRy66Kz5O3cy6ZBVscd90itzYpYJY4IAui2cBbOvcw+6ki81G9NwBAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757847066; c=relaxed/simple;
	bh=ua5Vb5zOeYFg3FVg3bHIT2DYfrWRx2dMA6ntfB7TQUU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HX5oSOFq1h4o57tdY8tWXswX1ZRT1Ur0U4AmTsOgPQgK+CR2zQyH/VVBbmgUmx3Q2Cfnix7Vf5d5fHI/hl7FOeDjeUNZ9JV75/9iE8V7Lej8aLf2Etoq3CsrMVt+q0n2vfhIscfLpJkQrK16SrBhhTJ3GOGuWjjZA0HbabORkZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-401eba8efecso43543375ab.1
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 03:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757847064; x=1758451864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1G99QjZJIxqZZW0DGsDJGiZk1djjVFhimNBcqrYyh24=;
        b=NyrNvUF0C20udnmkIGOCKyvi8jD8HzkRKGrHH9+PT2RmsQMKpQRKt0GYa88846RtxN
         r5PlkWW3Et4uZjsfMJwoXi5ce3BvRd7KTuuuT6MshvLjtQTzu0VtTwSSNyZeDCicKRSJ
         zFe0uMDxUy0iVMJY1D62d6euSwKYGrg6MRSBD8mgU5gEz8w79MhiX8vGBbizm3eGTcSx
         LSp5rx2YtXWvYP88MRGdXQImXcebOpTaALPrzsw8dCyZldu8lttEm5m71BDnh2py8CEo
         02qLZuCKD1+rGULQZpihYR+KwRX5JLLv/Cjt/Z3n8e0T+6SxyWmZCyuowXjtt2OowAYl
         b/tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRgnwHdAqV6Vqb7RPw6ITx1eHblHAxSxglh/weIoEbax7QwS//DZmf2s0H8brenYUQ6+0Pi+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGgWUp6xknHzvSsloSd+x3QL8Idu+Vd4XDvnX0pyhJOJdju/Tu
	nF/5m6NxmdGJokncYQk5hDeHyDBPMCWlk9XzYuxYyKgIRMUcql0DBco3vn2U2KNwEiABU6fUGCw
	R0wcmeSyzbuLAlgchfOpfvS9xc7kl80kSEO+040AFLeiRxdt9qasPGLTer3E=
X-Google-Smtp-Source: AGHT+IEWB7tBi7JGtQbX1WM80HBYeWQL4LG1xhguZ8b0CvUJv0a+SKXJBPC5JWj+b2DFXN8yyD+lm184jJWgFLvlptAUAb3a95gX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24e:0:b0:423:fc5c:c7b9 with SMTP id
 e9e14a558f8ab-423fc5cc9eemr20438445ab.1.1757847063795; Sun, 14 Sep 2025
 03:51:03 -0700 (PDT)
Date: Sun, 14 Sep 2025 03:51:03 -0700
In-Reply-To: <684ffc59.a00a0220.279073.0037.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c69e17.050a0220.3c6139.04e1.GAE@google.com>
Subject: Re: [syzbot] [sound?] kernel BUG in filemap_fault (2)
From: syzbot <syzbot+263f159eb37a1c4c67a4@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, chaitanyas.prakash@arm.com, davem@davemloft.net, 
	david@redhat.com, edumazet@google.com, hdanton@sina.com, horms@kernel.org, 
	jack@suse.cz, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, perex@perex.cz, 
	ryan.roberts@arm.com, syzkaller-bugs@googlegroups.com, tiwai@suse.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit bdb86f6b87633cc020f8225ae09d336da7826724
Author: Ryan Roberts <ryan.roberts@arm.com>
Date:   Mon Jun 9 09:27:23 2025 +0000

    mm/readahead: honour new_order in page_cache_ra_order()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1100b934580000
start commit:   b4911fb0b060 Merge tag 'mmc-v6.16-rc1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f6ddf055b5c86f8
dashboard link: https://syzkaller.appspot.com/bug?extid=263f159eb37a1c4c67a4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157cf48c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146a948c580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm/readahead: honour new_order in page_cache_ra_order()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

