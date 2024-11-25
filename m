Return-Path: <netdev+bounces-147220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0889D856B
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 13:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89492B29EC0
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 11:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615FE17DFFD;
	Mon, 25 Nov 2024 11:30:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C422E18FDDB
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534205; cv=none; b=B3Otu6L+MjKRzLMviKUkj4IswoQSQcQ0T87+rf/1OlfGskvqdCeOEfkHccPteTKJjCROBDmuEMRQR4f13oEK8QbZ8Ei+PahyNZ/zG3yEtn05rDV2LZc0rOMApiloC7xM9RyuVFim4NS0BlgmItfw0V1LEF02jxVVaXpKI4PaMMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534205; c=relaxed/simple;
	bh=ICHCbrzwtzX5WoXiFrU5K0CKA/+UcGu1uL8e4qhnC/4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mTKOJGRlZohCnpm3pwVIANGuR+J2afVwTej+MPDTC+iY3cb/C6tD2lQEyMmV9sPhGh3DtCcLQ0qEfNrn7S8YBiN+hB9ge3802esya9PnLcMBvLXAtUm6sAmwR/1HZ+w+QU7V8ExCinQQqRhK0ws/x3jm/1kAJQ/mEr0zSBYn0yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7abbe394dso19760095ab.1
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 03:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732534203; x=1733139003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy9JYi0xiCmZo9Y6IW6hmnOwU7Z6Pz/+nyr8wGUguNo=;
        b=tKO7Fal4pjHujYI+Hi+yOr9tRXcL4snkhhLyJ+dJ5ksJeTyti6N63NrcTpOIv0UNvP
         ZK2KTTtTsfsnGiYZk63sic2IpjoM03xLXtFbPAJr/hzLU42nDL8IJNDA9UsKZ6DsoSfw
         GdSf3yxFqL5GM3ppTzbxHOAqYhvu907KlleUjV6byouHCz1pC4bmNF/YXWvo8TD4RRVP
         p/4FzAhUeYBOYAQj+0W2EBbvtYoe6QApX2siLoQqYWr2fpEWQBevyHOnAqZMDgVU+RZb
         Aba3YprPQit5S2CiuSYg5a+z9vL1FVbqc+vKWCZVTw1Zd18c4wLsdu0wtC+w18+Fu0sB
         s00A==
X-Forwarded-Encrypted: i=1; AJvYcCWTBTGodCLPjhkO7Fr+6J7Xi0B+OfYM3631KZOV00aD1ci+PupxjcGwNfpRzGwL0j20XhMMBAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl0zZtsLGavLAr7ekGYbu1klqVjk1UrCH3X8rQNVz1ATLynF78
	MXHxOPfR41BYRBVvnY07tMD87t7PQY3o7XBdVZt1ilM8FEuuQvMCG2T8yOkiQXYHLCubbtR+TcS
	lZsAGAEgXL7CiJHUA+aAt3wna5Y9RR7P/21gseaNbhYKLI9inSswblY8=
X-Google-Smtp-Source: AGHT+IHgbIdGmzlwzkUbredCvt6hMXFV9IvreNknHrTgMRRtYGk0sW67a4h1dLCTt1oqS3vbSiPjC8ZmM/IKXJbqW/UXMNsxOIM8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184a:b0:3a0:915d:a4a7 with SMTP id
 e9e14a558f8ab-3a79ad10db6mr129531615ab.2.1732534202990; Mon, 25 Nov 2024
 03:30:02 -0800 (PST)
Date: Mon, 25 Nov 2024 03:30:02 -0800
In-Reply-To: <00000000000009ff2e061ce633d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67445fba.050a0220.1cc393.0078.GAE@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in ip_mroute_setsockopt
From: syzbot <syzbot+e227429f6fa77945d7e4@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, davem@davemloft.net, dsahern@kernel.org, 
	dust.li@linux.alibaba.com, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, schnelle@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d25a92ccae6bed02327b63d138e12e7806830f78
Author: D. Wythe <alibuda@linux.alibaba.com>
Date:   Thu Jun 13 18:00:30 2024 +0000

    net/smc: Introduce IPPROTO_SMC

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15fc6530580000
start commit:   fcc79e1714e8 Merge tag 'net-next-6.13' of git://git.kernel..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17fc6530580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13fc6530580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=275de99a754927af
dashboard link: https://syzkaller.appspot.com/bug?extid=e227429f6fa77945d7e4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175459c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dc0ee8580000

Reported-by: syzbot+e227429f6fa77945d7e4@syzkaller.appspotmail.com
Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

