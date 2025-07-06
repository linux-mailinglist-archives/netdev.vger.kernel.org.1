Return-Path: <netdev+bounces-204444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7362AFA800
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 23:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2717F167A39
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 21:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DE81DF27D;
	Sun,  6 Jul 2025 21:47:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E731CD1E4
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 21:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838428; cv=none; b=B2ROucV7jbx/JGRswV6tbs9Q55uq+7DsUW8X6stc3gba3ozI4fiwMMWEHFAn3VSf10BJ8qatablTOLwl3w6BVxKPGnUAZYkRm0SdNl2J7lnT/kPPu/dV5/Ogkg0iEzBwdY2xIhu1dNOL4wiFp46NNYOdXqJf8SZQT3uvrn1UOac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838428; c=relaxed/simple;
	bh=wfC6pb06LVhsTYsLYsVaUHcm+Hi+5WQlNyegKa6NJXs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BviarsWmrzt+45O2LhSnZlYBZ9BMrUSZgktVlXIGvayrm7rEi5C2kwqn0m1mIUuZFfZzGYkVOBt9O4TlIaRVUBY+emAUQG4es+KGkpmyxA6eyZZV9J5r7LXZjWfCAWF1hC4jOUhwH5sfO2QgeKrsafJesfHrRdsG6k48FvOj+0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddd90ca184so19583285ab.0
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 14:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838426; x=1752443226;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ixkLOm92PB3kA5hKonBVF6NTsAkdtIPeB+mFKWDyXEc=;
        b=W3LsLSifrDY2GI+hFsExyEULn4O3YEO1emxx1KMttNCfZr66JF9ZMhYfyFZbgNUA1r
         Y8yoc+40ybGGpTGwiM2uU8bP1e9y1U7TYhs0h+5e5VRc7DX9znKvcSYx1TCix/K+CBTF
         b4Q3riqrB9CopfrSw11I8awrqHS1bD+GGh8b1QKEktA/+lUbeH/R3Kc/bua2X24O5kEr
         7wJOk0XTP2Zv5OV4rhxin7RuTY/++6+9dKhe0c86Hp+vlBUqtxVZ3ahZP0ehU7ltFnJi
         1m8unkOQnJqcLZYd4YS8V/6H4oaLvB64bfearUv03ips1Fdaopo0FE4uKFNEJj8OhfLy
         dCvg==
X-Forwarded-Encrypted: i=1; AJvYcCVHBfvNITNANUNRLWUS+5wQy6s/IZ0JISbLz7sOz8gGCtmpwqBHUl0a8y+lBwFF78dXZEIaR0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0S7x3EY7v14ziFLUSjAaXrL/K4QPCMIM/IJ+OQ4L12yLTrpJv
	+cicKLoV+Iya5PcAvzpamvQIHMvtU1YrzVmcqUlez8RBE0WgfaQOfFTsI3vccekOMZRf3Y439Dy
	uJ2/G5foku/RQJirrvMrP2C0m/3qU9JSqsqVPCbiXoXv4g98tjVatfRdyhg8=
X-Google-Smtp-Source: AGHT+IGOvkaWcRRlxGfeWW9ngMLdfdp6SsnKx5xXDRjn7fDFzE0uyggFtu2AuBaGZuhI/U9YHWkMoTdeW4CSvVR5hl8Svwo0ehVr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:32c3:b0:3df:2fda:e30b with SMTP id
 e9e14a558f8ab-3e13ef15bebmr70223205ab.21.1751838426600; Sun, 06 Jul 2025
 14:47:06 -0700 (PDT)
Date: Sun, 06 Jul 2025 14:47:06 -0700
In-Reply-To: <682dd10b.a00a0220.29bc26.028e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686aeeda.a00a0220.c7b3.0066.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in bpf_check (4)
From: syzbot <syzbot+0ef84a7bdf5301d4cbec@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	paul.chaignon@gmail.com, puranjay@kernel.org, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 0df1a55afa832f463f9ad68ddc5de92230f1bc8a
Author: Paul Chaignon <paul.chaignon@gmail.com>
Date:   Tue Jul 1 18:36:15 2025 +0000

    bpf: Warn on internal verifier errors

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17014bd4580000
start commit:   cce3fee729ee selftests/bpf: Enable dynptr/test_probe_read_..
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14814bd4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10814bd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
dashboard link: https://syzkaller.appspot.com/bug?extid=0ef84a7bdf5301d4cbec
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109df88c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11705770580000

Reported-by: syzbot+0ef84a7bdf5301d4cbec@syzkaller.appspotmail.com
Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

