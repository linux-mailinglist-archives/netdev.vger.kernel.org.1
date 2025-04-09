Return-Path: <netdev+bounces-180581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A526A81BBA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 05:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4A01B68007
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23961D5AC2;
	Wed,  9 Apr 2025 03:59:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ACF14BF89
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 03:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744171148; cv=none; b=UY/fWTZD22lF0tZIFNEtj9X2Xg4QPAiTnV57Xjn0tslCDpistlVRA1Q015eoq2Odo8anMtPaXONaiFg4fhtJM17peGWRhC5FeO29FypeyK3ustdX58M1WqTLp8r4GNkfFnzBxW4kO501VOJJAPcdp23YYIxEWKqAZCi+khqDP54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744171148; c=relaxed/simple;
	bh=/hs4mz57QkzD+POEBZdYWPhm87ASHpd3wXi171AOTVE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Dp/oZ3EOM2Wuo8b9azDolkk8EEfbNjkHiMlC2KpCca7cZmve2hbuJFvNYMopjDIhxVJbW9mz2foqEsfQSKi4oqWR4OuE/2pc9L16L9AQci/Nb+6fy7lB9lLRrExH6LTXKiX4xcwzsZkEEGRy6sr0RYNJATODaQX4sjlJnDq3ZyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d44dc8a9b4so69448785ab.3
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 20:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744171145; x=1744775945;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Xmbh9ETjMYYnIqDT5ZMvjmgmJyKPg1AP50uzLWCg0M=;
        b=arwyw1Sdwtu64hejry1edUHCbSHaczsmyg5Urea4RDsl0DV2A0aHFnmnu3jTUYMKbt
         LsETMNcb7okGbZ+o9G5O8UbGhR6Jzzgjr5Xq6JML16fSo2t6LK7G3HRMU9htSwBt/ATB
         BFsEbY0etaRjPRz3B8YcxKjoOugm5RkUn7AKrV+9r6xM7z7uq1lUtCFcmNALiDkj70n+
         3jLrMnMkRvvsBvT5LKgCjByLHoLSXH1fkbpkPkO9BtCScZDHkFjzHpUeop2YzeYfcZaK
         GGgHFOOLhYUS+geVoR0ylftr4Adj3bUef3NUzGM73/IikSW0in+23UjhSk412CdfoWu6
         X8zA==
X-Forwarded-Encrypted: i=1; AJvYcCXlzBvlc4DgPVwTRya+oZQvzbPbCqe9ufL5A/QWPLNjJADbc1RSMIfgM1FxJg0CtOIubu9wE3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7dQeziENqCnsJKGedF0bI9bQveeAJh3lMIfd62By9+jLTlJ1D
	9t4UJPjy5YFBh/DMbCAIVL5vpap7a2rGuUhN1A7jvf2KF6jgAL9YnRb0KgVXNKHaM025xB7bQMz
	NuCzuRlXyNVv0izu0s+wETqh7lgjt5Xej0kKbU2+Z3xJ5R6QmRVYfO6I=
X-Google-Smtp-Source: AGHT+IFjLjZ26x0YTu6iNlhJUnYo5KtlBBw/Aia86NjqsznbuOsPBWlCVziPfDJ8T26S/BmRFOyIO3aIpkN0zXTLzeAKegTiXgZq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1582:b0:3d4:4134:5213 with SMTP id
 e9e14a558f8ab-3d7b462136cmr8112525ab.11.1744171145539; Tue, 08 Apr 2025
 20:59:05 -0700 (PDT)
Date: Tue, 08 Apr 2025 20:59:05 -0700
In-Reply-To: <67f4d325.050a0220.396535.0558.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f5f089.050a0220.258fea.0009.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in __linkwatch_sync_dev
From: syzbot <syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jv@jvosburgh.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	liuhangbin@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, stfomichev@gmail.com, sven@narfation.org, 
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 00b35530811f2aa3d7ceec2dbada80861c7632a8
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu Feb 6 14:04:22 2025 +0000

    batman-adv: adopt netdev_hold() / netdev_put()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=175db74c580000
start commit:   7702d0130dc0 Add linux-next specific files for 20250408
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14ddb74c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10ddb74c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91edf513888f57d7
dashboard link: https://syzkaller.appspot.com/bug?extid=48c14f61594bdfadb086
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11520398580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b1323f980000

Reported-by: syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
Fixes: 00b35530811f ("batman-adv: adopt netdev_hold() / netdev_put()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

