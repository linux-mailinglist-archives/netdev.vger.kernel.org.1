Return-Path: <netdev+bounces-218937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A44EB3F0D3
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 00:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A616C1A8599D
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B00E27C17F;
	Mon,  1 Sep 2025 22:10:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DCF1E487
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 22:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756764607; cv=none; b=paXPllMjbR8bCZSxcCqSxBfmzA3Vaw0m0iL7TsgbNGWLhaj6OLzAnkaAObutJrsMVQhf20FzDamVLkwBdFGRaHmzgSj2K7FqCw/qxNHr79tYl5BW/uphGuaKuvsh/KT7SQw5hc5VSBINt7FwPUp2vPl0l5dqePlEQZ5RACX1bQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756764607; c=relaxed/simple;
	bh=p0kMM4y7F6N7P9lmCZgTWs3ZjOeXgQCDCsLCsQtEfe0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=scxoo9wDQsEcL6mk1BAhgkwF8a9p9FL320q2B+/pu/+nP+Bl7mMx5ikYwRps/c0L7xGHuzuMJ8nnAwrXHuHD0jJ6s1I+Bqz60A5wFZ2ftUJiujntMRJH/gG4XEiKBslqa5kYw/OQ3Oar7KIzg0J2tUCpKd8muq79sgD1hD9TqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ed0ba44c87so57900835ab.0
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 15:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756764605; x=1757369405;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rONquuup1tA/FntPWjZbG/timt5LNSvQmqhWL+HMBzU=;
        b=YVhXiApua6qFHA/8kinxRatGmVarviIZRjD/nR03p0L6p8vpam+V6s/uqvgoMRm2bp
         3NHD0zuADThf73Kn1XnifZva63nKOZs3G/NvQ/aKjntOTzDXYFyuFHCNtGqTzl9ID6LZ
         nGHDow9582jbgbjYEx5srnlDkhMf0Kh2LWrdNv2h2iIUt5FgN/Tdzh4BbTpkZWg+rSQq
         LaPpyRzSsqJhqvoDac7hO7PMbIRABuJa/rW0aGMsgO9+qPOkcV2gInAPJc9F+0q5ezmn
         lHO8tDzUNxD4aL8fEpxheHrO337zwJ6pXuWlt2Yom+D1twH6dbU5d62QzOCrM72np9Rs
         wRAA==
X-Forwarded-Encrypted: i=1; AJvYcCXAzArk7xHeEg1kmV4p0QGBBGFL7niCKZyAyc//F5OO8gEu5c4OuJwcBukNWLZpS2tU6PdPfRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtfJmEzuAAeqWCvAz6WF3Lt4EzJYAcfa1zmZWiq39L59WqtUNG
	/vNYE9ZOu+GJVrVSMyLAn2uW/INEcfQghQHtbefy2uUfqp3qnG4A3y/7E9khJXmYenyrYgDG6jo
	foV9B00bIiperOwOT8JO8nbHKtlMwkRZPG7vvHSrLVQz8q/kVYe5F6k4kSQY=
X-Google-Smtp-Source: AGHT+IEwWIM0KR32k0CrIYVm5MqXLqvHyE40n+Jbcb7UVXKXi5zhmdRI/WfQizUkVs9bev2AbFsAxIgzU7Q7sbXwGYhdaNj7lYwg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa2:b0:3f0:78c3:8fc5 with SMTP id
 e9e14a558f8ab-3f400097882mr176361265ab.5.1756764604779; Mon, 01 Sep 2025
 15:10:04 -0700 (PDT)
Date: Mon, 01 Sep 2025 15:10:04 -0700
In-Reply-To: <68ac9fd3.050a0220.37038e.0096.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b619bc.050a0220.3db4df.01c5.GAE@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve (2)
From: syzbot <syzbot+fa5c2814795b5adca240@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, hffilwlqm@gmail.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 27861fc720be2c39b861d8bdfb68287f54de6855
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu Aug 21 16:26:00 2025 +0000

    bpf: Drop rqspinlock usage in ringbuf

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=167eee34580000
start commit:   dd9de524183a xsk: Fix immature cq descriptor production
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=157eee34580000
console output: https://syzkaller.appspot.com/x/log.txt?x=117eee34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c321f33e4545e2a1
dashboard link: https://syzkaller.appspot.com/bug?extid=fa5c2814795b5adca240
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142da862580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1588aef0580000

Reported-by: syzbot+fa5c2814795b5adca240@syzkaller.appspotmail.com
Fixes: 27861fc720be ("bpf: Drop rqspinlock usage in ringbuf")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

