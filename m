Return-Path: <netdev+bounces-246090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADF5CDED2A
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 17:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB87C3000926
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 16:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D728253944;
	Fri, 26 Dec 2025 16:43:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0631E24C076
	for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766767384; cv=none; b=fz276zOjq8OKZ+ZxiSbDNqU3VVs0pNEqj9ahUTQnRBtswTa3tJqomjVoYOFsxU3TdNlQfppmwo/w2lCBmR6TJsDvc2FeQNUqUr+D0t3b/xqSUVDs96wjTV6dMQUPjvL9cGdX7q/7ueIEzR3ZYsuoY9kLJPaPxl9UcWp/mhUWEQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766767384; c=relaxed/simple;
	bh=sy3Wzix1buePedqsF3Wx+MegpWEP1B45sWRV+7ZEQas=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aPWfIektus1CeIsHeaUX3mBzMDYrOr2T91CTN4d6JmTrIVuuP02i/jDnjZuczs4YejdovyJNcq4n8sqfo4y3rq3Ss4WPDZCi3n47sm0vLeY+Itb1+4M65gcQZNdO2PA1P2N1a41Yhd85tZs5gkFbl+N5yJJd8l+xJjzVA2UYl68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-657490e060dso9608954eaf.3
        for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 08:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766767382; x=1767372182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53SAgSKsIJEqDYV+s2VQZXX0ij5NAJJbDSc4ix7LheQ=;
        b=eCZhEFMEjyL/YCUtRSXKgITo1Os7IA5CDmyTw0NYjVwFNAh6jfsQjpx2yfA+/m5I9I
         pMpQDpsGncyoqm5yg047n159YtqYLvynjWmK7gZBMVKQcVfqjwC1AJhwqM/F9wnupmiO
         mKB49u78YZ7g4MOB+uXZb7Xs6zDkWqpr8GmzQHMVktd4TxqKYXJVGn/fisX1ay+yW242
         M9QK6tXoyFTzsmvyilcfqWGmHgLPMGwNfpvUX7Rlw1KheeIyP+Q/qAeDhoT0phzBoBe2
         GOU7iMdsTAdgfFxeoJYD1JNPZI6vX8E8RJ+o2WPhqE3lEs/ADaapVabyx8bgMbSIJvIJ
         ycBg==
X-Forwarded-Encrypted: i=1; AJvYcCVXY5xfu+DN+mOWkAyf+q8Pd4k55MAnkixvLGs9PwO6zRjKTHeil0/IgMIC6WxkaXoZTJ0v/a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNMDgZoYG5w7JNNlJeQ9DKe8Cc6EBaq5lc1hLXoQXzvtwyjQUL
	E3c6yUKZk+QoMMg+WXhCSgjpjhZuH9Ibf3XQALv21dONyUEqE3/7TQD23XSwWk7WxTawqE9UIgW
	56dSQEQU2/Y1ThFlGCSvjM+US2h2BUVZbPW5N+n+YU1f6Io9mtdlaY8o24XU=
X-Google-Smtp-Source: AGHT+IGQPSV7JiVQmAQqG+OQX04xZJqT0KUjhT9g4KHv4Ml5V72eS98RZ9upgzLfwU+miUGHK3gQTCEITzja2y9xosWteVUkes0P
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e252:0:b0:65c:fe8b:53c6 with SMTP id
 006d021491bc7-65d0ea9932dmr6960121eaf.43.1766767381887; Fri, 26 Dec 2025
 08:43:01 -0800 (PST)
Date: Fri, 26 Dec 2025 08:43:01 -0800
In-Reply-To: <6730d6bd.050a0220.1fb99c.0139.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694ebb15.050a0220.35954c.0076.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_pipe2 (2)
From: syzbot <syzbot+693a483dd6ac06c62b09@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bigeasy@linutronix.de, bsegall@google.com, 
	dietmar.eggemann@arm.com, edumazet@google.com, juri.lelli@redhat.com, 
	kerneljasonxing@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mgorman@suse.de, mingo@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 66951e4860d3c688bfa550ea4a19635b57e00eca
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon Jan 13 12:50:11 2025 +0000

    sched/fair: Fix update_cfs_group() vs DELAY_DEQUEUE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c6eb92580000
start commit:   9268abe611b0 Merge branch 'net-lan969x-add-rgmii-support'
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=b087c24b921cdc16
dashboard link: https://syzkaller.appspot.com/bug?extid=693a483dd6ac06c62b09
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e7c2f8580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: sched/fair: Fix update_cfs_group() vs DELAY_DEQUEUE

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

