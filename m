Return-Path: <netdev+bounces-101624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4BB8FFA11
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 04:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDC21F23E16
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 02:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ACF12B87;
	Fri,  7 Jun 2024 02:51:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBDEDDD9
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 02:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717728664; cv=none; b=teJ+icqJuOudfyOenmeBo6FA+izB+6ug81dtDVQJEFR91A7B+Qa7HUCfxmyW8mHBJmTQaZKjA69Ae0oC24BbGa5W10HVvR6PZcDRToDrQhK0JJazZa5Zu5TBOj1TgJV25H2T5972kzZVpEP1DOERLglUTVXszb8fyEoTmj9p2KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717728664; c=relaxed/simple;
	bh=si+N1wuZ74OQmZXqp5VNrMsebBeEF3HgK7mZflWf8Ro=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tvztczCo+9F+qlmyEYNSIFn2XOYveq0xrdNJTlnSsKBcbaikjl1w2vPhHFnFRazsXUb1kcmhHstKmMLOzvuO2m0ajIW2oZw5gfcJBffGEmsV4RO+yDCt7lRgFf78f4ANZhEmthkpz2y09FZge8s3UOCcmd9iREoGSrvvChDP998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3748d50473cso14355425ab.1
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 19:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717728662; x=1718333462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoJDbmOuZCo7DgFMWx4zQY5bK5409kRcjvDvOGHuIw8=;
        b=mgeOm8346XGgqmTYLNUAnF9kMzf2jlZi7XsNHTcD7HUzRwjjQEM7ToWD4z+ItL47Su
         52ZAxohFbfsC9SgxxDJ9XlumAX3MKvwe8E/Jbnvi3bM3qyS2KMl9Pu6lo6X55ZPMW2sO
         eqNiuaL5sWjmobSRWbn02AV1pfjRwA7YJGBkdLHG5tglH1dLmUNrERQqDNHLOBd6I6XC
         lIEgdEJVR255dBaE7gsVdQon5kz6jFlhK0xL461DeOEEigvNMm+S/aSG97s1/0gvnEDQ
         dex2njzgSPJL2zqGAmXezt8zWUy9FBw9fwLSyxz9lFVtCu18LEyFMUXyFiNttCTjRYlq
         Ff7w==
X-Forwarded-Encrypted: i=1; AJvYcCWSeCV9t5g0yOhEgTmquRM0KAQT6ntJqH6sv/ES+JxCuHuOJKN4ZK+pF6Tk+yLZvsp/eDqow6M0stauHF1IeXcjA1PyegL+
X-Gm-Message-State: AOJu0YyJBuymSbdd/8eyFQckJabS0cxL6gq0AGBnSbOxc9/7UYZa36zc
	vvHY6pYJukrClgwpLKHBn0fW9CiOodtjcfXYN+8hZU81MVxpMOKMKnP5szQXX9z8KvbRyNeYNbc
	Am90Muq08wQ0H/ujRsC8hq2XylJmyhgXwo7n3VDdfjuyzyZRL/L0EqCQ=
X-Google-Smtp-Source: AGHT+IEIUXUjMuT4JzACmagoV0Bo3SJsrvzkbMMX8Ie8P7ZaGp2FbUDMzisZObkuWRNwNUQdRkPEz5ZA6ZM2UMMjTWxNqJzvzG71
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d92:b0:374:9abd:2788 with SMTP id
 e9e14a558f8ab-37580242e2bmr1025575ab.0.1717728662718; Thu, 06 Jun 2024
 19:51:02 -0700 (PDT)
Date: Thu, 06 Jun 2024 19:51:02 -0700
In-Reply-To: <00000000000002a89b06146e6ecb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c31e9f061a43de90@google.com>
Subject: Re: [syzbot] [kernel?] possible deadlock in __hrtimer_run_queues (2)
From: syzbot <syzbot+bacb240dbeebb88518ae@syzkaller.appspotmail.com>
To: boqun.feng@gmail.com, daniel@iogearbox.net, hdanton@sina.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit ff91059932401894e6c86341915615c5eb0eca48
Author: Jakub Sitnicki <jakub@cloudflare.com>
Date:   Tue Apr 2 10:46:21 2024 +0000

    bpf, sockmap: Prevent lock inversion deadlock in map delete elem

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1169a80a980000
start commit:   61df575632d6 libbpf: Add new sec_def "sk_skb/verdict"
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=bacb240dbeebb88518ae
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1793a2e6180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c8dac9180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf, sockmap: Prevent lock inversion deadlock in map delete elem

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

