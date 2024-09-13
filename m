Return-Path: <netdev+bounces-127992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E382977702
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 04:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEC15B21966
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 02:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD2273478;
	Fri, 13 Sep 2024 02:47:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D6933F7
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 02:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726195627; cv=none; b=pybQ0L7IQAZsQwEfGC+W66SczCSZafByoacBgP5Jkrr9FSBF++u9TfVvEN55UglYWa5fN0g6inxNhYm+HepqvnxE73MiBfqOPjDha00JF0nquP90i+Fi6e/4A5qj70hihEJfxtLIj7AEZ7ahrqWhbC/inwlOtFAk0HdYR0PY+SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726195627; c=relaxed/simple;
	bh=Z+AyqT0z5slYEKR/EZ2b5K3PKfMdlKBQ0731BYcQt3A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fcIUiZNQO0UOLqlMeZZNxHBf3k18HkvVL7WamWNsOSYbs8kRBPTUK1lYDQXAyPFZOom+q+g0gnHLikfehJeRoEoQe5qDjM2a2/UVj0DUX1rU8gpFa287wVb0J8GYQYCxYcBCDTAhaefi8yewfbPJUIlekMTCWXDOuML2TNfRNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82ad9fca614so194576039f.3
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 19:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726195625; x=1726800425;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j5Qalv+ZWwp2Crs5JzwNX67tlmsezDCid6fcSjz0QvE=;
        b=Mzynhv9QvauOcQG5BZCjUur4YKfNzpbIOGSmAKXOT0hXeJRJV5Suv4kAIjFRw/XVuU
         KFZn1oxaDqx/l+lO1nEfYKU67kKIA6oYN0opk0Rca1RX4yd3IJWGJ+XDVBcgvODDoeR7
         oAahFf2FslA0ARLT/NEc5RzWk0zgmPQWwk+V5AJs4pdUoP6QEnd//2+pkwAMzbVk/yaW
         AGgC3CPE39rrpWK+ZnxtfvBIQ2BEWbMWp5VOprpxoJoqXHQuSFh5U9K8LPMHuKsymaTW
         3DzhYmMNPbeTmgjUmZJejsTyg00pOsXD8TKYSnpXvTlWlnFL8iITgMuwET6qf+WDrzm/
         AwDA==
X-Forwarded-Encrypted: i=1; AJvYcCXDmtWIw5r+pNLLM73FczNRSmoNvvtqIwCO/6MmLjPc1+z0m3pjvnvf2Qv+xBsfmLnAbPvT6+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjbXbK8jbOslexSAyJSU5YALxFBZG90QG+KSGh5D+w6W9t0KW+
	UK3eRbZzOFd1juBNq43pT2LW92d4T98okcaRr/FnqyHhpRGmVbci2Ez7/czlehPAsXviOw/bY6S
	5/5QPEmPDyqfSPkP3RveBg+G/19znln1ZeOi03XGbnsvEZYoWF9aQkCk=
X-Google-Smtp-Source: AGHT+IEkrG2Iu5XrA50NNTPXn13N2q68OiqR/NLLBlttD34N2lXi2VTF7UO4K8Xa4NJ2uTiBsbsgwH6clMCr2/APZL4dOdtDl4v2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190a:b0:39f:500e:2ffd with SMTP id
 e9e14a558f8ab-3a0849551bfmr54323305ab.19.1726195625465; Thu, 12 Sep 2024
 19:47:05 -0700 (PDT)
Date: Thu, 12 Sep 2024 19:47:05 -0700
In-Reply-To: <0000000000005348f9061ab8df82@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011b0080621f73dd2@google.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in neigh_timer_handler (8)
From: syzbot <syzbot+5127feb52165f8ab165b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, gregkh@linuxfoundation.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, marcello.bauer@9elements.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, stern@rowland.harvard.edu, 
	sylv@sylv.io, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 22f00812862564b314784167a89f27b444f82a46
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Fri Jun 14 01:30:43 2024 +0000

    USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17eae0a9980000
start commit:   dc772f8237f9 Merge tag 'mm-hotfixes-stable-2024-06-07-15-2..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
dashboard link: https://syzkaller.appspot.com/bug?extid=5127feb52165f8ab165b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17398dce980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112fa5ac980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

