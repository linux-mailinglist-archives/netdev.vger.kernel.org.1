Return-Path: <netdev+bounces-80023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF65187C86C
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 06:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162E41C221EF
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 05:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A0BE552;
	Fri, 15 Mar 2024 05:08:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A34D299
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 05:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710479287; cv=none; b=rIuYQGqpSukmecBlK6LKos0wsVWYBiMqUBwScthGkSSTaTlYscKVXC5sAfmqDKjVpUZtvwLz5WXjx930ooOsLN/CLGwC2Sx/GbDfY9zohe4sOGSeQor0ANX9Fu9c6ElvZ4ElEePvSlITXN4/uRuCsyL4LuVXu12Kf91Y8V5zvfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710479287; c=relaxed/simple;
	bh=NmDOUG811XfRB16igaZyw6LFbv7sSn2UAdDeMDEa6OA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MYevh5Xa6rIMqeaNV3sXh95TsxY2/vTAZNSjp0f1wwpMZaDU609YHEgM+U4Fo59BJjXXtEAtk9eJYvZlAwuL2mm2qldhpTz/NxT2cx61dCS8QsHr2v4X/TuVFX/SwCrXUma0YK2v5m1KjgW+SYlcoo5dd1il4aWnVgCWRkQrdbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36696c9cb23so2012475ab.2
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 22:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710479285; x=1711084085;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVU3SwTinQlrbnvG3eYIW9m6xS2x5pbAtn9qvd7kqLU=;
        b=sJl0E2uuO1/JbgPR3pJMgnFyOhmueIkp+S4APPmm/l4yu7Ef8JSnrEVd/yMGspNWTq
         26SE9ZV6AqSJpSH6qEvMKui1ddwBPPuZHqHHMherjcI3lnDWiUNkJChDq9AybT4oR/2r
         WhOHKeOw5fbk/IvO+gCN/7NlaZLFBXcv+fZq/m3iZiIT23IFjJ4trsEge0u3EtgKUtjE
         sb5IvZOL1l8J+GqMYTxk5vhjf+XbCniH7jIGwYIiR675pvekiBeclOWS6zyHDh7exuAS
         x3uFNuLYp1OeTZ3UreLeIhMZAUPgNKjOR4CcNRavSZvFvhuEW1JkMUAg0byOu/715cag
         7PCg==
X-Forwarded-Encrypted: i=1; AJvYcCVl45OWS1jU3oTd5NSrnkTp7o9mQy+lBCgah/RN5pfDWQdP2pKX359I6EV3lG/vJAhQOx2S8tvAafuoLwMQ2p+OYOP+IUpL
X-Gm-Message-State: AOJu0Yydo2zFbkUKgUjCpcyEsJHVbnkep1feDplFPT00MofHBotueWR5
	MY7vovDNoCj28KACHbdhBbx7xcOggqF8r7tChczmt7X1GmWWlH63zjLXn2z2FQUekhqwmSDKnpU
	m0GQP/fHubXZ4wHpwE8NiTUi0K6lJcnZrtwNGjxf/xiaedyviOY2n13E=
X-Google-Smtp-Source: AGHT+IE4etLVdxE7NeSUJez8W2EAutCczB7gCGAguxf71D5ai0qlUnXy0kkyvk7dTFBA4qoM3k9rLzgTfGh9vvILeXfcxtJP6NXG
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218b:b0:365:38db:a585 with SMTP id
 j11-20020a056e02218b00b0036538dba585mr216452ila.1.1710479284985; Thu, 14 Mar
 2024 22:08:04 -0700 (PDT)
Date: Thu, 14 Mar 2024 22:08:04 -0700
In-Reply-To: <000000000000e8364c05ceefa4cf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d73880613abfe48@google.com>
Subject: Re: [syzbot] [can?] possible deadlock in j1939_session_activate
From: syzbot <syzbot+f32cbede7fd867ce0d56@syzkaller.appspotmail.com>
To: astrajoan@yahoo.com, davem@davemloft.net, edumazet@google.com, 
	hdanton@sina.com, kernel@pengutronix.de, kuba@kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org, 
	o.rempel@pengutronix.de, pabeni@redhat.com, robin@protonic.nl, 
	socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com, wg@grandegger.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6cdedc18ba7b9dacc36466e27e3267d201948c8d
Author: Ziqi Zhao <astrajoan@yahoo.com>
Date:   Fri Jul 21 16:22:26 2023 +0000

    can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10c1afc1180000
start commit:   296455ade1fd Merge tag 'char-misc-6.8-rc1' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e8eb82c088a8ac6
dashboard link: https://syzkaller.appspot.com/bug?extid=f32cbede7fd867ce0d56
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d7b3afe80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ba0a4fe80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

