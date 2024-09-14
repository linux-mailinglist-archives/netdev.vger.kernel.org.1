Return-Path: <netdev+bounces-128362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BA9979209
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 18:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADD02821FF
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 16:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECAF1D0DD9;
	Sat, 14 Sep 2024 16:12:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75F61D0952
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726330325; cv=none; b=Pw1WF+ozBkAvpyxHt2yQnwFqG6UYfyIv+uAQAFb/mYV6lHYctxsUilBKP91/iOmUV9fjDnzjCSRWPlL8kQ1rzbO8k0LDqpRWr/hT4M7pioLG748Ls1nHxgcomo+CzteY/gCQaPE9VkzxUvFaJUqc4LET4ezeEnGZjZCGDODCuwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726330325; c=relaxed/simple;
	bh=3/RaIZT7WdvooM9BNOa0osJLBSkrxtxxgxDPh4ZRNTU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CZfYmjXZpow7HtZ/ukMAf47UTwHzWs6bOOwqwdu4sEx20RenS2Au5VDoPy56sSK6JgSqNi7NPmwojfV4JmhwFDh1GIx8xxumRmCV/Fijm2SYsLRJ5CWw2mu7cqWfCwYPXdX3yXy+GLM0M7RbMEUiOE9apPJdsjMvpBR+b9APihE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a093440d95so33750565ab.2
        for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 09:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726330322; x=1726935122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elLGdhu/N7XTEKaqxHm49lH0bwEsUUVJ3oDAKjdaD5Q=;
        b=YgLD7KJgWVlW7Hh5EzDTJizYW/qHNWn+doKfGTbjcgIcbNz+tqquES0fgyGyfHseKb
         TkwnTRi8rg7Y7/FVFHB9spNc0cruCjZNMWKCfBiCFnlZzDZ2V3BqhBfNpoVhxbut99mU
         DkuKW8wDYe2jd2XSXm4cbPK4iKsAVT3bCopfZ91jULdHvQKp96kbLyrs4bplvRNlufX0
         diOf3Jz73fgWvMi6wA6qvr9I2FuMsA3xkNanA5gHHB35njkpgJW53xzyc/4lRm/gfYqg
         Q1EWS9qr03HDRT2uyC38w+CgUwwlzPzk7keNPipAqmFzODxgtNrHF5dqklFxQKjkovkh
         lAeA==
X-Forwarded-Encrypted: i=1; AJvYcCVLTWJDzMrY6nSXmHOcMeFum450bukMl+N+ZxdNEH/IYLSx8eYxHcU2fuAP/odpW22xNuvaWzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmEDSqevddxqH4tc6X+8xhRUV7rcVaYSFgD/n1q1I9nhtcMeQl
	4BbFxvsbpYxCyyty3iYuEUbE2tc6n8PrsBIwcZKGBYvNRKvrtNDJsDZu6tGMR/TUpnaW6j6K+SY
	XPOB9Ik1m/xiesykGjhfvsRQ2DGRY+kuBkQB1b1m8KTlLfRS+7OacQ0Y=
X-Google-Smtp-Source: AGHT+IEc++CMyi6bkWbEuObVzejUUGoJZN+8Kp9MFs8scQOh5Rafy+cL57mjP3DXHmucVMmExu3iETWNncLa6nd6JZ8MiIDzZQDF
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2e:b0:3a0:9d2c:b079 with SMTP id
 e9e14a558f8ab-3a09d2cb143mr92265ab.19.1726330321813; Sat, 14 Sep 2024
 09:12:01 -0700 (PDT)
Date: Sat, 14 Sep 2024 09:12:01 -0700
In-Reply-To: <0000000000005c8e95060babfa0e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e5b5d1.050a0220.115905.0008.GAE@google.com>
Subject: Re: [syzbot] [virt?] [netfilter?] INFO: rcu detected stall in
 ip_list_rcv (6)
From: syzbot <syzbot+45b67ef6e09a39a2cbcd@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	jhs@mojatatu.com, jiri@resnulli.us, kadlec@netfilter.org, kuba@kernel.org, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, rjw@rjwysocki.net, syzkaller-bugs@googlegroups.com, 
	vinicius.gomes@intel.com, virtualization@lists.linux.dev, 
	vladimir.oltean@nxp.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit e634134180885574d1fe7aa162777ba41e7fcd5b
Author: Vladimir Oltean <vladimir.oltean@nxp.com>
Date:   Mon May 27 15:39:54 2024 +0000

    net/sched: taprio: make q->picos_per_byte available to fill_sched_entry()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17264407980000
start commit:   753c8608f3e5 Merge tag 'for-netdev' of https://git.kernel...
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
dashboard link: https://syzkaller.appspot.com/bug?extid=45b67ef6e09a39a2cbcd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15abc0e2e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b0c7c2e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: taprio: make q->picos_per_byte available to fill_sched_entry()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

