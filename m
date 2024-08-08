Return-Path: <netdev+bounces-116983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FFB94C428
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 20:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C076A2872CD
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 18:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E0413F435;
	Thu,  8 Aug 2024 18:20:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E6412CDAE
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141205; cv=none; b=NzKDp3XWFNGWQu69JtDbeQsCoTVAbEaAs9rf6ME1GfpstZIgY20G9JcpEogxVc8QtcuXgSvKFN/TwyeiyN7pp9B3W7MsdftMxLaXnEu/kH7l/dyPOjwnwQREghB6H1VB1HNXkaj7D8hHymCLwEi5B3EjXt5V2WEmplHknDsdXk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141205; c=relaxed/simple;
	bh=A4csGmWCoPZ74aoudsl4h8T9HLs5pNqrw2WZK4uPKRU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Tf2JAvhAXYNcs0Drn/wpPaJ01SoV9cPrC9QX+FIV+8utHUclrdRmi4NjpLLJPVnHwT2MptMkObaQ1LkE4DW8AC43tvf7HkNlLVDjvny9erGAeXwdA2pfkxy/WKbvcm4ununyHx3PwYxYy/0h/mDqgco1qLqxl40mTSIQq3+qfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f8293cdb1so145837739f.2
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 11:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723141203; x=1723746003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ncqslw7BK1CqqZmrGSWzwTBOiICY9xk/ffH8fZ5hP68=;
        b=hBM+B6jYD/wkRpiK8q6O8z/t51gXtr4sqSHneXM/POJ4NCbDO8ORrrSzeMsB+ydvSY
         u/m44gcwow9FMEZcjXPesuS42ukCpqHQyJB/O0U70D14gMSjEp2ntRmLjTP7opjHdh1k
         crUsDDbp2CPOKOjiPk0IbwN4OBQCaI1C2HJre5cZR9lYltu6+4bA8K/kuKWLcSGVsrW9
         du1ON9l7QFzqgcgMgYbjPmupX/ZQV4G/3cq4zDtBi4uveVfcImwSm0/zW+5hMilaMalK
         BiQYXsntmAt4DS8sHUOVMVGhfGwrbNf5oQRD5j/YqM3gqVe9Ncit7WoGk5cUU6BMH+w1
         WBnA==
X-Forwarded-Encrypted: i=1; AJvYcCWinVdoXpKa1ffFcGQmxiBd9vBfOXa16LEaVHuyh5ErRyTMxeKE/BbKMHUSk1PLum17g5z0USTp3S+6eZoE9j9MJP+YkFDE
X-Gm-Message-State: AOJu0Yy/26+JFpw5d4FvStBDN1c6mVLmCpWqpXkp2t27DRBM1k9Ilmm3
	xs8QkD5R4PqbpXri8HonaYyBxUn4TM8MbgpKkbWrpDMLcVp5kUAiM3YCirN8Dg9QA8HHbUbC5xG
	4K72gbG0DP2wuxEo3wuEQ+XZn8GvjEZ0LNV2uUqQD1mFhm+w+J+s/xAk=
X-Google-Smtp-Source: AGHT+IHbhNaK62W4K7+QUWq3BdqL/7ruRlRKk3wLISGUKGyTl1h6WiBzkoJhNDWZunJHnppnZq8wpHW5FFDkYjLuN+LN9lzK035j
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fd1:b0:803:85e8:c40b with SMTP id
 ca18e2360f4ac-8225383303dmr7731539f.3.1723141202901; Thu, 08 Aug 2024
 11:20:02 -0700 (PDT)
Date: Thu, 08 Aug 2024 11:20:02 -0700
In-Reply-To: <0000000000004cc3030616474b1e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c081f061f3013d1@google.com>
Subject: Re: [syzbot] [bpf?] [net?] WARNING in __xdp_reg_mem_model
From: syzbot <syzbot+f534bd500d914e34b59e@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, d.dulov@aladdin.ru, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	hawk@kernel.org, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, lorenzo.bianconi@redhat.com, lorenzo@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	toke@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 7e9f79428372c6eab92271390851be34ab26bfb4
Author: Daniil Dulov <d.dulov@aladdin.ru>
Date:   Mon Jun 24 08:07:47 2024 +0000

    xdp: Remove WARN() from __xdp_reg_mem_model()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10df4a5d980000
start commit:   f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=f534bd500d914e34b59e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ac600b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1144b797180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: xdp: Remove WARN() from __xdp_reg_mem_model()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

