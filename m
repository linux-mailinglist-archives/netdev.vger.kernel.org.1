Return-Path: <netdev+bounces-187728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5800AAA92B5
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 14:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E98F7A6AC1
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 12:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59ED227EB1;
	Mon,  5 May 2025 12:08:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486F722578C
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746446887; cv=none; b=qHxx+3ZnOGPq6gFUPTr2oRfxNQQqEfOMrGqyeCNGmB9+dgjwDqaT06lptEoqJEfvHfLJvurI9kyZlMd3LKaCk0bi+1nMZcc3rNpyxBEojukxbX5tl22r9lbMS7fQuKNJCbsDJJ82VmOrfpiVXC9my2Z5XmIByL6NdEp5xzLkaoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746446887; c=relaxed/simple;
	bh=DHwp8aDOJDlgugg90sJmF2XyZAUiP69pwzhuX3CPzYM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=E9bdPU0Q6YV+sRsbAuMT4P7u/PxCrL2v14VcZnKBYSKdI2nz50A8eOmBwcrBgnNl8BmMYSBgbKVWKENRySn0oqWjZQdWDsnD1ga0hJJvBdzaJsOdrV2IKnNfE/9zQct3SXFSTgTLe4r8xq/R9SlfEDPjXtaWt5giTyRq4V/m1Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-851a991cf8bso475464039f.0
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 05:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746446885; x=1747051685;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOyl3MaiaAtE/UsGWO9Ub0FNoaYpMHqSsINHLLvPVuY=;
        b=dbOBMIJJJfpzZv1PStBe/lZmx7QZ/YSjWdER+34HCX6M71vTWxrCmzb2FNVs1hQOdA
         Cw7Uxbpjma3orqqHvsaL/UbQjqxwb566ThzTuefO6+S5wJaVqSZZS4HhvfAIxiT1bWGj
         ob8PmZD1QC+hHCmJ8i4P0wVGWfnhLlDVq+VJa9gQVeV+PR6g37axBAzdlnR3xGDzGcLs
         WxZjvejNSgoySl8UvLkdHDiyPtOnkQWf8XtkjKn1iC4E/zrn/lh1Ag0QKPms0lo7dw5n
         EaqYrAM4Tmzl6AMhxAHvSY4Wi1YF3SVPgEo4pHbYu87jb2TpMl3I44b4g9I6+CFgC1ia
         eYOA==
X-Forwarded-Encrypted: i=1; AJvYcCUKDgSMVO7EzkCpZ0ia7h1tqkr270HjWgM5rd3hUB4qephEygIZrvfrMQO8OnPo1tYys13gfaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU7B3Ao9hty9lXkhx15HtFenUBZDMGat0Hc0hO9Pb/YLf5gAT+
	3vkh2S/zUeqEJA/QOtT9H2OX3Wa9/WThjDLc2Wq3LL2bAalTLTXq69ao3hjNeefes5J+Bcxjg1e
	mLfS2+QGlH39gmUb8j8WRYFsVUC1CrDAOvBQwxMw2gbouyFKlzQckwz8=
X-Google-Smtp-Source: AGHT+IHAK8haRRYfwkU6RoGcf8J9F0Vip/rN+oMOWgFiAju7v68UvjjYKW45uWvGfQWIfTnuIyKVyDOwQ3f/Q4nUcONsd26bsijG
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5a5:b0:3d2:af0b:6e2a with SMTP id
 e9e14a558f8ab-3d970ad6a68mr132698725ab.5.1746446885382; Mon, 05 May 2025
 05:08:05 -0700 (PDT)
Date: Mon, 05 May 2025 05:08:05 -0700
In-Reply-To: <681732c5.050a0220.11da1b.002d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6818aa25.a70a0220.254cdc.004f.GAE@google.com>
Subject: Re: [syzbot] [net?] BUG: sleeping function called from invalid
 context in pcpu_alloc_noprof
From: syzbot <syzbot+bcc12d6799364500fbec@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 169fd62799e8acabbfb4760799be11138ced949c
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Fri Apr 18 00:03:56 2025 +0000

    ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=169578d4580000
start commit:   836b313a14a3 ipv4: Honor "ignore_routes_with_linkdown" sys..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=159578d4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=119578d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=734b5f968169d82b
dashboard link: https://syzkaller.appspot.com/bug?extid=bcc12d6799364500fbec
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147be0f4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127be0f4580000

Reported-by: syzbot+bcc12d6799364500fbec@syzkaller.appspotmail.com
Fixes: 169fd62799e8 ("ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

