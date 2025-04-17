Return-Path: <netdev+bounces-183649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AF3A9168E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80AD23B6911
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 08:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D78A22331E;
	Thu, 17 Apr 2025 08:38:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028CB21C17B
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744879108; cv=none; b=mG+t6lGWeDZp8OgP7osa8oDQXBdU84wtpR1Y4JE0Uiquw6HhqCzteiq/R8Yl0tZ/S3dCa7VCDVy6EwL4l+JalDgbf7SDgs9k8Wv1dJ93ZZprUcOEGwg8Ai8OS+MOq6Hs7gBmHxIjomILHLfKXskEXGGWYnuYH1m0q6DV92mHm9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744879108; c=relaxed/simple;
	bh=UH9voSbXHY2ibx2R017hySv+7p94nIaOHgfqFIOkwDg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=em+bn1xlCP+kLvKo80CQWOiY9hx44GXPV396NV7bNiTHddDhTFYUB9J+nQhSG77cAutaCyXzO7M4RQ9YkD9z4k7KzQzd9pl6fUJrpUSho5Z1LfCTCc3fxwsC8yRcgGAdXUYX90Oev0Oxx03vXbxQwUic4KSJVc9Qp/kQkim5tKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d43b460962so10759675ab.2
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 01:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744879106; x=1745483906;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZi5ZNPX9S5wyizuS3a6KFqu7CE6UegjxBqKHLcgHyY=;
        b=OhUfNTrfBb+GSJOCIyD5O9zreQYTPmZH4G8vZso84ix4cmfCv4jQJLoDircPKd+BNG
         jIvjwn73dPHG/6V+M7xdcn+0ipJViHjM0Bsr+Fm9HpLIBFiC8TMq92V/YzjOIOij6TZo
         Q4nsV94OEbHNjOPVfjscM7uQBUP42GL4DJhSOIYqCFHDUI90EAE4Qi7iuFuKrrZMsTCc
         LjwMCmlgHcR8QOb+8JI13SAkebcZXIBjrPOgKo18YkWsf7lLEoLlBQ/6qZp24QFGCMC0
         +4JsTfvEH0md8CnjwyWCVwFHxaigoFVOgtdqkrDsJAbY1qsiCD1zFu+R0Hr863J9G39r
         Qc2A==
X-Forwarded-Encrypted: i=1; AJvYcCXnyvi7ZelduxjpxxB4SWy2OOl/b7n47wS9w1PM49lUE0yTNuwjfMAgweb+SbpzH9t4wbLzXaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmQ97zTriy71+whPUwK0rG6hNpXdyHNPHmpHDnC1cfXmls9+d5
	Ns6z5/rnuiJuitFs94pGo8kaDBqgvrA6yKLCnV56RK9nbyLD5TWvhTNQgrP5zGaD5ONZsDAvTp+
	+HvpLQydUovaY+qt6SEQJVoz/tabhSjnUirOvCIw+1RO+mpWxf65mPy4=
X-Google-Smtp-Source: AGHT+IEqoHGrUKvaaGvRUz8O7WU/jvu68WMIVM/pDoMJBtzCXkfzYf8QDQqXQWmtIka0No0EBP92ntn/wxZjPsEbzeLZ6goADD17
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2402:b0:3d0:4c9c:965f with SMTP id
 e9e14a558f8ab-3d815b70372mr56966505ab.20.1744879106169; Thu, 17 Apr 2025
 01:38:26 -0700 (PDT)
Date: Thu, 17 Apr 2025 01:38:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6800be02.050a0220.243d89.000f.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Apr 2025)
From: syzbot <syzbot+liste217d44efb9077d8089e@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 0 new issues were detected and 1 were fixed.
In total, 10 issues are still open and 185 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 428     Yes   INFO: rcu detected stall in addrconf_rs_timer (6)
                  https://syzkaller.appspot.com/bug?extid=fecf8bd19c1f78edb255
<2> 157     Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<3> 67      Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe
<4> 11      Yes   KMSAN: uninit-value in ip6table_mangle_hook (3)
                  https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

