Return-Path: <netdev+bounces-211685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FF1B1B2A1
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 13:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA3134E052B
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 11:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1261246BB6;
	Tue,  5 Aug 2025 11:34:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5901F199252
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754393644; cv=none; b=Cx63f0EwOMAQsj4brPGuS8u6jgyrScl/FmOO0Qe9ccmxVGIu1CK5F8SqvTH/T/RRE+XYwHIsmZvtgT4szVCwmpJHpK2nW2Bpau43rLr1eBmknjxk6jn2gy2Sx1tXHeOrxaQ6AyLU4GPeRq8qS8eB39d9vNdnMFjFsEDEOiAYIv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754393644; c=relaxed/simple;
	bh=Sflcpsg0PD5XG5dljOG1ybZHenmBO0Bu1t55tSERMg8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NbmeowSJqZ+dJup2fttQ7XRZPZ7x87uCB9M1yIc6RsbrC6/ALH4nMj7MHsrWqNYdOVjmHmy5jFe0Nv3ZBh6GP5lLFmLlnRSwbz1heWIktDJgiGU4VAmMRw9SqPwxm1jW/oLH414GTdxYxhW/iBfj/3cIdWVaWApDpB40d2IMt6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8760733a107so551928039f.3
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 04:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754393642; x=1754998442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95FWEmXIfrIEO/zYb45Z4W0pP1aqivE7KsjXCppK0uA=;
        b=VssjNnTxk+3UZIAnzl2bShepc4FqGPs/9OuSsKWTaMoAc0TBCKxZ2176GUCqiClqJu
         Mm4cr68gCUVEmO2TINDAXFtq+PIkFqDdnTt/ufZ0zME3oK5Y1UnNhn9x0WBUd3rIIQhr
         C2UK2Wcl9ZZCm+7rQIAuXTt85mPN6QHXmuZnp9HbGUwm3OHcM1W7OEaArhDkuE33jZe5
         l1kyT1RFWZtBf/t9yozkmIY2S7ffn/ELM4f/CQ3BRD7tyWjDWDqYx4d1mmNAmP8aHsBB
         GhhU+PJ9gopGCguh90QKcXcRXWJLMD3nUBGoUiWzvSQ6OAXXupskcxjBSAKNMB4IF3Il
         5XOg==
X-Forwarded-Encrypted: i=1; AJvYcCXvFKHZuBwChQsynOhkzjNqgtut7bnUaUnx0EOnCJEgBd4liQb9htrEX16eN5016LfgrO9osUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJxg8Hlpsd34InYtyxL54RHYAviroDBMXIgvqD3waiGk8M6XsR
	ko4dtGrVF8ncR3iJf2k/UxfhGGUmfwjh1CnjZ83GKar3ghQT6wBTZx9f1fczuqo3GtNOEo4D4QU
	gzs7lD7B8+ZLnSKMjsgC/aF24kcbWrMp2LeVumKajvh5Rb+byj8qkJubuE+o=
X-Google-Smtp-Source: AGHT+IFMu0t0Nn/b9qQTRS7KeyLXQj5B5JqMmtkPaTMaH+YrEoz27P7XhK1L1Ba/Tj2GJG85jei9IWOi9alFMFHti0KIahs+RlUF
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2507:b0:3e3:c918:e3b6 with SMTP id
 e9e14a558f8ab-3e41607aa64mr220823675ab.0.1754393642206; Tue, 05 Aug 2025
 04:34:02 -0700 (PDT)
Date: Tue, 05 Aug 2025 04:34:02 -0700
In-Reply-To: <67f66c9c.050a0220.25d1c8.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6891ec2a.050a0220.7f033.0021.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: null-ptr-deref Write in rcuref_put (4)
From: syzbot <syzbot+27d7cfbc93457e472e00@syzkaller.appspotmail.com>
To: atenart@kernel.org, davem@davemloft.net, dawid.osuchowski@linux.intel.com, 
	edumazet@google.com, gal@nvidia.com, horms@kernel.org, kuba@kernel.org, 
	kuniyu@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit de9c4861fb42f0cd72da844c3c34f692d5895b7b
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Jul 29 08:02:07 2025 +0000

    pptp: ensure minimal skb length in pptp_xmit()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17cb2042580000
start commit:   5c5a10f0be96 Add linux-next specific files for 20250804
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=142b2042580000
console output: https://syzkaller.appspot.com/x/log.txt?x=102b2042580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4ccbd076877954b
dashboard link: https://syzkaller.appspot.com/bug?extid=27d7cfbc93457e472e00
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1628faa2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12490434580000

Reported-by: syzbot+27d7cfbc93457e472e00@syzkaller.appspotmail.com
Fixes: de9c4861fb42 ("pptp: ensure minimal skb length in pptp_xmit()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

