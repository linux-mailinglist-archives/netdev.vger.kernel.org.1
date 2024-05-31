Return-Path: <netdev+bounces-99638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B0C8D5918
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 05:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A04F284C66
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 03:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6921C697;
	Fri, 31 May 2024 03:41:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6133CA
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717126866; cv=none; b=KRbkUYsnmXdMNE+L4r80A4lQuG2rabkXgFD/hLes3Gx8QveTk9r5eUAxjS5DNkaaWo48Oavzw6RoeIZ9a4GfDQb5VyFB5V39OG2cswD1q6n2Iwj50hSjsVe5nrbnYFGOVNaO3ckvp0jEu5Sf8AZCAd3Pi1I014rJHPHVCz215XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717126866; c=relaxed/simple;
	bh=1rC0NKAONkLy0Oylwnzz5uBXjuFKNURyJe5NXU6R/yQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H3ftyUlYlUnnQhlHSSwOc8NmCSMt6Gy5QmPgwY7dVG1F6Pqas1zUpvwWbC7oPInwWXRAVEcfwHra9vYNFI25WgWayvrep6kWJs7IDMyUfwD6ZcgJzJ4wc+zjCZ5yGzq6VBU9ccdeDSIGyBlp6rDRabY4tYQrZEmIwoK9sRWpklA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3744edd84b1so17022585ab.0
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 20:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717126864; x=1717731664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87j8o62HbkkhT6SZnt8wHJxPfsDOYjfW8V8a3wMHqjk=;
        b=ig+0cw5DpZoOWx86/ePScgOIaB24DZ9zRoUqnsxoKrjF91iry58cv7IsE9PvC0Bs+i
         0xXAXukIj6MsGq5gBdyezleDKK380eMTHJ26oHjoj8HGhVcQkJbGkEJIE4fKf3CHqpbV
         l5iY8zBz1IGu9C9WQLQKeRNHdwp8M6tAkZUNY4e5GAK3DuNi9M7U4ZwQZSTTidX3D1jp
         RoKb8qB5aJxKZ7UvKJ47qp2W25xdBX3COe2c5KEHQv9aVPLsKchDCqBMHbmzr8iHZ/t/
         WUZIneUemfE6Dlwx6y4AjevVRnkr+TXEz6/VjXk0RBZt33dhhBgZbpzwOgj1jzQH2QFW
         UWWg==
X-Forwarded-Encrypted: i=1; AJvYcCUh3tYaCuxgSz/qdEP+J2M1tGVcIvhhMQ3de4Ylbnqcpthy4oPQKTVLSKmCebJqxo5WkFsokfr7AxOW5C2yXUGLn2RjRZFX
X-Gm-Message-State: AOJu0YxEC+Z+f5CAb/qy4jG9z/w6Y+ekoW95JF1Mpty1vRHgwQvvYCXE
	rxl974H8UW+mrJoBrr36iStIO9bObi5nfShPh8tPC0DAotl6MkAsjCht9QpevBYQXSdRyN0PFen
	fFD6fP9zNkLbzlxyv3fgusYVQPQX2l447cexIC/fu3ZZFJYyL1Ghmvrg=
X-Google-Smtp-Source: AGHT+IGCsBUAVeOUsq1Bd0MSppgJvFf3Y3DrIaiDcrLOlhPfacoqnuTlaSqh8WRL67WxbHmUn3DdOa1DZgLuDjt1aCDR7Qa0FR43
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6b:b0:373:89cf:c491 with SMTP id
 e9e14a558f8ab-3748b8f3693mr101875ab.0.1717126864795; Thu, 30 May 2024
 20:41:04 -0700 (PDT)
Date: Thu, 30 May 2024 20:41:04 -0700
In-Reply-To: <0000000000007628d60614449e5d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf8dba0619b7c0db@google.com>
Subject: Re: [syzbot] [bpf?] general protection fault in bpf_check (2)
From: syzbot <syzbot+ba82760c63ba37799f70@syzkaller.appspotmail.com>
To: andrii@kernel.org, aou@eecs.berkeley.edu, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	olsajiri@gmail.com, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	puranjay12@gmail.com, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 122fdbd2a030a95128737fc77e47df15a8f170c3
Author: Puranjay Mohan <puranjay12@gmail.com>
Date:   Fri Mar 22 15:35:18 2024 +0000

    bpf: verifier: reject addr_space_cast insn without arena

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e17d3c980000
start commit:   4c2a26fc80bc bpf-next: Avoid goto in regs_refine_cond_op()
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=ba82760c63ba37799f70
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e6bbb9180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12941291180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: verifier: reject addr_space_cast insn without arena

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

