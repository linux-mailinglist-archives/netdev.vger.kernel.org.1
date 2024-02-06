Return-Path: <netdev+bounces-69649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF48A84C0D6
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 00:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0291C21708
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 23:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A13D1CD26;
	Tue,  6 Feb 2024 23:24:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41681CA8E
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707261847; cv=none; b=utPH38L5Nq6rlVFO2ksJs+KSboQlAyHRjM9QBlecWj92wDMrcJBQBurd0u7GkuvGQHkimWsiNKb7/kdJMOE3FkokOvVPVV11Ww3Wmr246g1JALcSsCu2tt29fiDYp/p3m8clfhd3yn+stcC8FVqsxpd7Q9ZWNpZIgW3mYxqRbfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707261847; c=relaxed/simple;
	bh=avaOUcgWWADF6KLGwzoW9QsC+X9ueBhEDEJuX1SutnY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YEdDfY44y7Q4IyTQZEGgDPwi1A96EXkWDYb6ms0Ho7mjZqZecQbDh9EXygjWXwVYXQ/v0qE7zz5EyAXis7LgvbPh4zoF8Un05FwKeK0F/Ef5ebJ1r9viQykQynjZOIXeDYpoHeOa6402hI42sk8EmJc475V1HUjPBeq+jYgD6qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363c3eb46e3so82915ab.3
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 15:24:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707261845; x=1707866645;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyU9aBXxURAl9A5KuV1JqmHm0E55rA4SNAlAUuaADxs=;
        b=mIdrz7BX29SXL3W0tab7A5Q8MWrZAkd6CsFiddWtO49oehqtel40GzuoeF1D0FzOhh
         xg6L06atmyyIwR/SHZ2ikVBkjux3jGHBZxyOhp4DXmqdcaX7+P93S8l1IJPTGCA4KGmd
         SOXeu61FI3vM0ifQMgesQqn4mY49JG/MbAtcJ04ATPSpj92YyxVV4wdSU2tv43FTRAU3
         bVmi8noeq/YN2q+PO5OZg6nVmMNN2iSedaC0hyX6a14ZvsC1Ru0z5EpQDQ4NxWiQ32wX
         FDoXU0fVqFJ1/vH37v+fJlwtdivcBI+MMDBGJek/7vEn5x6DdWKH0xFgwTnsg4eXfDB8
         DQyg==
X-Forwarded-Encrypted: i=1; AJvYcCXROK1t2WIeNU7M2pkhMuOG5mhpnTjQ8oTLCqK7yuGyuyK8JPwVxN6DXuUjr4ptUOqZ0HuO5jY7Cc9Am1YHCfb+NwJE2RqB
X-Gm-Message-State: AOJu0YzgxvFHSwT2exZYcEcmHrgcxtIRBhyUDtZ48yOudDWa0bXMhgd9
	02k6xbbOc4qn1KPlYfuP3+W+s8HdZD7nrQ1r/9ed7i+gEIcF3F+3uLZkiiFbK87xLxvfvHzmtWI
	+6NhMOsXzRznYqR1Jqbh7siA8pKtWWvVAvaVebWQu5eCzJdpco1qcrkI=
X-Google-Smtp-Source: AGHT+IGSXSHoJP49btDMUUbQR8POUN20RhhYPv9Heu/t1qcOYXiDcq7JQgRofse+fmN8ylccOMewqdmAQJFGKKPWHm8kVCz6GLrK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9e:b0:363:ca65:7d12 with SMTP id
 h30-20020a056e021d9e00b00363ca657d12mr207768ila.6.1707261845064; Tue, 06 Feb
 2024 15:24:05 -0800 (PST)
Date: Tue, 06 Feb 2024 15:24:05 -0800
In-Reply-To: <0000000000009655270610aafce1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d053f20610bedf3b@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING: suspicious RCU usage in hash_netportnet6_destroy
From: syzbot <syzbot+bcd44ebc3cd2db18f26c@syzkaller.appspotmail.com>
To: 00107082@163.com, coreteam@netfilter.org, davem@davemloft.net, 
	edumazet@google.com, fw@strlen.de, justinstitt@google.com, 
	kadlec@netfilter.org, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 97f7cf1cd80eeed3b7c808b7c12463295c751001
Author: Jozsef Kadlecsik <kadlec@netfilter.org>
Date:   Mon Jan 29 09:57:01 2024 +0000

    netfilter: ipset: fix performance regression in swap operation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15790a38180000
start commit:   021533194476 Kconfig: Disable -Wstringop-overflow for GCC ..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17790a38180000
console output: https://syzkaller.appspot.com/x/log.txt?x=13790a38180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f204e0b6490f4419
dashboard link: https://syzkaller.appspot.com/bug?extid=bcd44ebc3cd2db18f26c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16329057e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b8fe7be80000

Reported-by: syzbot+bcd44ebc3cd2db18f26c@syzkaller.appspotmail.com
Fixes: 97f7cf1cd80e ("netfilter: ipset: fix performance regression in swap operation")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

