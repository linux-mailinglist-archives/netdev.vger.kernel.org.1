Return-Path: <netdev+bounces-155879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4038A042AF
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BAF1618D2
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A351F03E8;
	Tue,  7 Jan 2025 14:37:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC781E5738
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260628; cv=none; b=tmS6Im7ehnR0Ex/OChgI1/KpRLKQYZGKOoQI5fI3deWamj/X1NXXjHVhN9WfedUAV9hKqAGUG0kMr+VuNXK4NBJLJUeqSirDbuSrPAn3u3VXjZfM4JIxbF5IgznkwpZi6ygp6XMtmcuTQqAH+FXH2a7q2rnO0N05a4hVE+CR140=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260628; c=relaxed/simple;
	bh=/qNG/k/P+YF//AxCGiJp6BsKDYLJ+unhV40W6k25+Bc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kuTCNK6l9FjrwQ6e0fKdxgG/WRc7qo5DA+THa8gh0rYvv9sg00JCyijneHe7B3wP23FOntujrzepj80UG03IYMk1mckwFRNiAjD8NgDiGUtYleqsaYKtkW904ldQXcJtXtjoHseNWEe7ec3fzkFn6LsLvRtztOXBwp7kSyffp/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7e0d7b804so136253985ab.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 06:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736260624; x=1736865424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2116iHIqWDm9ZK538GLsLvScZAkDxZ1YqfIZyR/Bnkw=;
        b=UXt/IA0OJ015Pay8AroYEHC5Mbha8/OLnhAw7joM9o4pxFwEs/49wthaV4OSjbU40n
         Ub+7w65sC+SaDpHrnUpPh2x53rBZ2pq0FAyFs3R7oOxlCUJrpm3N6q3pW6IgO/JR7klL
         QPDmRZSU60SWmmtn4xlVgDKoD2CmKG3QIwSCl+m38/igHgADlKDcl357iSzqxkoG5Txe
         kbvTyuFqF+MNKwIU58OOLIaQ31G2N/LDA0BP4ltB5j4f2SersAEpmhIGAXkoCMNAglXK
         o5AyyYOvGhHkc1YA9sSQ0DMfuGDbZFUvXTf4kNrvoRlvxjM0aGRDiNaaUH4EgJmCR+g5
         M2WA==
X-Forwarded-Encrypted: i=1; AJvYcCVCjF8ip6FSMW+cOxVAGk/G19/SoiEkUbU4cLPb87ji8FVe33gilHfbdyhfib9r3razro6wnBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgK2BjHnuwVJEYIT7yFswqW6DU5zzZJ+Vetr0ZkiT/mdJeBcIO
	bmik4T4RciCm4YnAnug7lkbCP5+N+rptd9p4e/JfGm3UYiokJ8BxDf+NOWQLT9l2tIMZMrG1Tjf
	5M0Ijhw8BcvCHFxZMfdn3nnPyDSL7j8lmF3HlK08bzdt8MHiFtpGb0dA=
X-Google-Smtp-Source: AGHT+IE+T8leRFXrDAubhP4Al1QTTauq/hCkIwlmLfTxe5g426XrCTe2f/QUsHT7xTDyIPIs4m5IsmvLCumOQ8biSkRtXKNIFGmB
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaa:b0:3a7:86ab:be6d with SMTP id
 e9e14a558f8ab-3c2d51516c2mr476505005ab.16.1736260624535; Tue, 07 Jan 2025
 06:37:04 -0800 (PST)
Date: Tue, 07 Jan 2025 06:37:04 -0800
In-Reply-To: <00000000000086d9cb061828a317@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677d3c10.050a0220.a40f5.001f.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in handle_softirqs
From: syzbot <syzbot+afcbef13b9fa6ae41f9a@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bigeasy@linutronix.de, 
	bpf@vger.kernel.org, bristot@kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, eddyz87@gmail.com, edumazet@google.com, 
	haoluo@google.com, hawk@kernel.org, hdanton@sina.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, juri.lelli@redhat.com, 
	kerneljasonxing@gmail.com, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, peterz@infradead.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, vineeth@bitbyteword.org, 
	yhs@fb.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 5f6bd380c7bdbe10f7b4e8ddcceed60ce0714c6d
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon May 27 12:06:55 2024 +0000

    sched/rt: Remove default bandwidth control

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b2f6f8580000
start commit:   ee5b455b0ada Merge tag 'slab-for-6.9-rc7-fixes' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7144b4fe7fbf5900
dashboard link: https://syzkaller.appspot.com/bug?extid=afcbef13b9fa6ae41f9a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12618698980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105fcb4b180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: sched/rt: Remove default bandwidth control

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

