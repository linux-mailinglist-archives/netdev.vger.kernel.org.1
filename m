Return-Path: <netdev+bounces-79005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C01B387756E
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 06:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8C21F21687
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 05:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B06811187;
	Sun, 10 Mar 2024 05:44:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80B32914
	for <netdev@vger.kernel.org>; Sun, 10 Mar 2024 05:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710049445; cv=none; b=eY/Aqy/TSGH3UdPNQSgOJtdGV0J+qP2EJdVF3X9PCTe/wBOSKXB3gUEJyQ6ABtQjAgyeKytc3JNvNl78WcKeaeKPZ2EWaljUoOL4qDWR0Nm5h8QJTszBwsmbZ2bpcckJ2B8yWCtKDZioGv0Z3m8bGaerkOqF+ltkU0ywRlyn74w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710049445; c=relaxed/simple;
	bh=ZxvTrZvmElY1CLAgfzYeDqqQvYhtj7zE1J1bRkS5iHw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lr8abodhDfIk5T9CMJCgSNVJq0tdoqiWm/ACAWfAY0yJ69b6vJkU0dsYfNs0JcRpT6fE/Z46FygaxMMWqYe1j/bEvTFSKkbrcJvt29L4CTknO5GNb7ehVu4356WbtwY6HatziMIvwQnbBf1F/vlFRFmXVuWaeBkmgZl/tZ0HKlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c8b4d00be6so3662939f.3
        for <netdev@vger.kernel.org>; Sat, 09 Mar 2024 21:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710049443; x=1710654243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fg9QOOfct5u/YyIAQwTiYotjgDmWTjZzqZwfCzBZFWw=;
        b=SiYKull9kAZvl9rnj3unXr4swBQXvSazx8TxbbaHmPAEcR+fpAllfvfrdWo4XHfKC8
         OW7REN+JOJGkt9WSdxS8Xj5urPF919cPgDhmQbj57+Kisupq/qX/EDpnMkhcsivC32Uk
         iUSzWgANKr6Yh3uUo4FQKIlKseWEnFRnmR83Hhqb4wF1e+fOiBHsjdyMsbbGDKdU9l4T
         uHb83zdomE/k3bqk/hqLvXHwhPW1fya78i0bPuk938Mc0pBa52TWW8Pa92jNu8Pi3RT+
         VzCgGgB9KsQOsXBxBlZtnfS4sd2QoYUvo1nrZvIMfzLn5H0i8w7DlM885sqGZaApM3tX
         Cb2g==
X-Forwarded-Encrypted: i=1; AJvYcCXaqKrdfubiAAiVuZXhgPFARlswchsnehBaKj+escdgdVMcckuSQu/l5V5SPzqAg++LYzIGwbTesyTQS3F+Ttq0K/mNCax9
X-Gm-Message-State: AOJu0YxI8CfZvMVK73icGSEKRcnv6CpQ8Jq9wLE2rHbE9+UHcQzdQbHI
	5bKjUzH8/Vi1EXBwUiv/TsRHwfOea5YccyLLZOsHtm5n5DWN6QA0pL0650lSq1o1mdhN+snQ2GE
	KJ6b/ClV/NSxhaxBfgGGihvASE5E2C5tcAK92O/QHZXjeTS3v1vrQa20=
X-Google-Smtp-Source: AGHT+IHGuE8tlKNpBq7UBPAiDHGfgfS32D+fq5AisT1M0C6jjo7+Ub+MTJTJqsrkMo+fWNY8qg3OeFo4P6GJCJ3izohXRV8SZBFU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dc7:b0:7c8:7bdc:c69b with SMTP id
 l7-20020a0566022dc700b007c87bdcc69bmr82809iow.3.1710049443141; Sat, 09 Mar
 2024 21:44:03 -0800 (PST)
Date: Sat, 09 Mar 2024 21:44:03 -0800
In-Reply-To: <00000000000088981b06133bc07b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b68ac061347e975@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in __nla_validate_parse
From: syzbot <syzbot+65bb09a7208ce3d4a633@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	idosch@nvidia.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, petrm@nvidia.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2118f9390d83cf942de8b34faf3d35b54f9f4eee
Author: Petr Machata <petrm@nvidia.com>
Date:   Wed Mar 6 12:49:15 2024 +0000

    net: nexthop: Adjust netlink policy parsing for a new attribute

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13293b36180000
start commit:   d7e14e534493 Merge tag 'mlx5-socket-direct-v3' of git://gi..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10a93b36180000
console output: https://syzkaller.appspot.com/x/log.txt?x=17293b36180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63afafeedf00ef8f
dashboard link: https://syzkaller.appspot.com/bug?extid=65bb09a7208ce3d4a633
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113a3399180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156404d6180000

Reported-by: syzbot+65bb09a7208ce3d4a633@syzkaller.appspotmail.com
Fixes: 2118f9390d83 ("net: nexthop: Adjust netlink policy parsing for a new attribute")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

