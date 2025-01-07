Return-Path: <netdev+bounces-156068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E961FA04D55
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 00:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35DD3A2A21
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 23:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298FB1DFD9C;
	Tue,  7 Jan 2025 23:18:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83267192598
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 23:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291885; cv=none; b=P3neUXS4qcpALC+1eZUBXjNafV0/+jzYCmC3G+GH4zHIuRlXMPBqlhOgQyXuqWgnnODuxQARUMu1hG8f+rW3bjHbCe7KoPyN6yrNbJLajzpch5cZV0hJ6vIRFfDvkno8q2Xz9Gvu2cLT7MOi732YVrJcVuTiIGFiSClwYiWOvZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291885; c=relaxed/simple;
	bh=7edG1e9h/zaRrHdIoCHk/QyHwH5jMmAJD6Ry1+9DpYQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L6BZ4GV0yNsKOzQDL5/0vPjswT0YMlZ6SMXsdOOTkhMNWr6ZHZDrhynH0XYu0Qsw9+3LrHFY7Q4IsWBeKXXVyeRTg1Do8BFpkxvVCQbjqVn1pIIQhTyLj+ZEJ4agQarJvau2hRZWB3vgFYjdBO5AR4QnRNBD/Gsk0opQnu6qwkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a9d3e48637so168778775ab.1
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 15:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736291882; x=1736896682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVozRCOrP9j7sCIgLYFIaV3W/G9uw4bVVy5oL1ovDjk=;
        b=dMqeN3rSFf4GT0G4k1wsL2KyRUu/CakngdMJNnRbi62nEHgF2zHRfhjZiKC7p8kGdT
         HzbCwhl0ILhMnIdNbP5NDBZzdxisiOjzCK7WRxMiaFxv/WADi1taOgOqqa49L5yA5Z1M
         cQUV8jepPASt3MxZi+J+MoMUi3cUq1Mv7rjtbY/HF8KgubOQAkb97B3szEabx7R/uUeu
         Oh6iE9IqVrjqT0pnrqWfVgM6Oa50kXcFfhrWR9sXhJjiKQ2JN4SU05cukozfCkEww40m
         Z8oryjE1oAribnfgQB6vg9tZ4EcaKX5uPaXziBwbAoXuOOB9rEUc9kD4t9JFjkUtOeQd
         652g==
X-Forwarded-Encrypted: i=1; AJvYcCUD6ZzoDKqBxTVI8Pf9yPiy1m62NDbuJu3Ii6dumyWZnTFO5PuG8W8d1j9UdAUaDVvBOFA9/w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFDpmKO8GhmRkMSZMYayTTrkMPG5lT/i3ekfk+5+fFxuaWbcty
	3uSxqG4QtkcMG4xxabNaILVpAy+ao48jZARHlQpsio9quB+vdDv5TLu3EC9DOEpUl9nKRdzAsus
	PE/uqgRUG7JmBsvRzbKmyItNuVlwZ0ClhpMoW7lt7Vx1nPmrNuIznmrU=
X-Google-Smtp-Source: AGHT+IFgrotYn+sT5XPnap5oHb8Kvw1H5ws/ZQCEbslqVW08fmBFMuSLvr1BLmudUKkmq45Kf7n9+Cwa4C5vMNacVqV2Ww6dp5Ir
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8f:b0:3a7:91a4:c752 with SMTP id
 e9e14a558f8ab-3ce3aa76a9bmr7369395ab.23.1736291882724; Tue, 07 Jan 2025
 15:18:02 -0800 (PST)
Date: Tue, 07 Jan 2025 15:18:02 -0800
In-Reply-To: <6730d6bd.050a0220.1fb99c.0139.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677db62a.050a0220.a40f5.0026.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_pipe2 (2)
From: syzbot <syzbot+693a483dd6ac06c62b09@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bigeasy@linutronix.de, edumazet@google.com, 
	kerneljasonxing@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d15121be7485655129101f3960ae6add40204463
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon May 8 06:17:44 2023 +0000

    Revert "softirq: Let ksoftirqd do its job"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1668e4b0580000
start commit:   9268abe611b0 Merge branch 'net-lan969x-add-rgmii-support'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1168e4b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b087c24b921cdc16
dashboard link: https://syzkaller.appspot.com/bug?extid=693a483dd6ac06c62b09
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e7c2f8580000

Reported-by: syzbot+693a483dd6ac06c62b09@syzkaller.appspotmail.com
Fixes: d15121be7485 ("Revert "softirq: Let ksoftirqd do its job"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

