Return-Path: <netdev+bounces-109555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EFA928C83
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 18:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26121C2442A
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 16:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963FC16D33D;
	Fri,  5 Jul 2024 16:53:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291F516ABC6
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198384; cv=none; b=ctWYU9sC+Sy0IV+yjetKD7mA4h7TmB/rw5zm0rM3Uhr//yNn466eUizCOQ+LqzjQKOgBc7IiKYJncob5Y0QrYJ0w7maBSdgLdQzdceVuO+JZ2wFTxKzb3WilwQMG24M/wD1fDd+I0J1ivkHVhD6rSUwB/FqVI8nv04hs5aSWeeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198384; c=relaxed/simple;
	bh=UaM93TGN4iYPCN5uZ5z2UKlaHCz9b8vpxwC7j9MOd+U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DJXJYZyRrM+DVSJUW2uuCU3jeHWKaT08ZcIoa5U+44sCTp9IkjVr7NaL+Bwwk3HvEm4IrvvZuqFy1Nd+WBV/QWJyqtczP+4RDdT2vfdRwGxg9VRf2Io8rU060SxLZdLHzSznQ5YJBBPNCGsokilOp+BljNGRm06Ey1sCb6TCvcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f67a01e796so107865039f.2
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 09:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720198382; x=1720803182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3kqwbkZY7L2l8IVXTuQ2qgComWiD7Adz9v9kn/ngmI=;
        b=lhHCMetQximaM0qbh/E6AHmRJrf3OHnvvjNrDJ9YJDkQkbAkjJKZ1d94j0mK2sZsPF
         o2yPQAxiWMm4OjOS0P4hRZVxWy3wzcjTKQCCVf3qSnXZUvnGZwRmILRKDiUarC35QIer
         LHgB24V+r08dw7H3FSa0EsDikQ4nEcYqvVNSEbFQDUf+aLVNsFZvREs//DeX+H1KP0Z1
         lXxI8IYg5HibAAPdHbK1ZDPaUqW3ghfMbcoZaVGcolovSZ0wkoITNw7XSc6J+2mrs0Aj
         j2MXRfnmteX+joJ9stFAyILRUbECAh2p9ZE/lImDQ07djpWQdFZOelQOZkwZ6vZZw1F8
         ioUw==
X-Forwarded-Encrypted: i=1; AJvYcCURuOiSsK+RsPibCirnxFmfzXzikD9rResYXnHo2shfU0r8oB6omVzuEfoed+8bVfIjCjfVBilYS5qdzDwU2nBxmtQyRiU+
X-Gm-Message-State: AOJu0Yz92fbK4lqbDXuGFZuNK6Td2BwonlYveH3WRklNW6J3NE1ZXdUL
	Hkn2bFIhmLMHLfEqLaUNXbEMIT7MVHsHT2oZMgzjzjdu5pb6H8rZAtdys1Ll+BVXQJsVg8MVc/S
	92vQYdSPu5K1s7QNjioEsb7z8nTuZ5N+qiH6SQa7HQGEuKO/JiCToVr8=
X-Google-Smtp-Source: AGHT+IG/yEhFXD6qQMI81WxcPhdywfcFpk+5U3Vl9g/NRzi3ksxB+siy5qOyZMOIM90GcuOG5Z/mFSN26sRXwVYlJNWTJCpyEAGZ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:144d:b0:4b7:c9b5:675c with SMTP id
 8926c6da1cb9f-4bf63c2f6efmr705928173.6.1720198382283; Fri, 05 Jul 2024
 09:53:02 -0700 (PDT)
Date: Fri, 05 Jul 2024 09:53:02 -0700
In-Reply-To: <0000000000005c2f9906153555b1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084fd82061c82e523@google.com>
Subject: Re: [syzbot] [kernel?] WARNING in emulate_vsyscall (2)
From: syzbot <syzbot+1a55be5c9d955093937c@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, davem@davemloft.net, 
	edumazet@google.com, hpa@zytor.com, jhs@mojatatu.com, jiri@resnulli.us, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org, 
	mingo@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	praveen.kannoju@oracle.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, x86@kernel.org, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 33fb988b67050d9bb512f77f08453fa00088943c
Author: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Date:   Wed May 8 13:36:17 2024 +0000

    net/sched: adjust device watchdog timer to detect stopped queue at right time

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1163e569980000
start commit:   480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=1a55be5c9d955093937c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a64776180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142939b1180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: adjust device watchdog timer to detect stopped queue at right time

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

