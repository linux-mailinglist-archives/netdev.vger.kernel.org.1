Return-Path: <netdev+bounces-70811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A911F85087B
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 10:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640BF2825DF
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 09:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FA259B4A;
	Sun, 11 Feb 2024 09:55:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E9F5917B
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707645307; cv=none; b=tcNn3/dMOxH+XxCLgYVHt5FQAvR00AambuwraLgid3Zgyds8ldZfim50QjpJDQb+T12t5C0E6kbria7Vl9fVKt3Rb+Y6Fp5QB37Kr8JdIZdsk8jnTQUikyEboGv1IJD9S4rIk5uuK4JDpGsbqoks+kY4yt9tgXpXonlPal6tFpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707645307; c=relaxed/simple;
	bh=FamyLudsSv714I4GPKAWQ7S6nKsf1K3Kuh25o0PUvSI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MZPjNBsvOa+3qibDoYqMhhZYIpTJEx7zJOlaUGAdwp32x8Fix78ZGgkxmTt4WenNzSMYtV8S1cOkAjv7k9EZ/TsmVd6mZrI+2QdEb7U8g5bBAUxGaPMF2S0q6Kmar06QEI7L+bhNkIBz3y34ZZGosjjpmxinDcZLj88Nt8OLA/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bf863c324dso213379139f.0
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 01:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707645305; x=1708250105;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0XuWyRbY4wXt2Mt6STUVYn8j1a+Yq6fdJoZ0a9NfJrs=;
        b=v1nyXyXC8Kc12oCCq2xlsVMlcZMUu7XYFkTAyCohs9e0NTKxa1cFbla48IcEg07h64
         7Q/BiYmvl6TXEOC/tVIbdeXHXFCjteeMjD3AhMsc74vsTNIcmiu37yzGF3PjS2DRWwHf
         motiROdoR/jlXsNMDVIBmma3LRrCAo0z2dVG35d/Lo4JLIeTE23T/45L8pPUckhm2Phs
         Bg5jJTb+Ta8TwaTP7IMQmcuEF6FLyOiD/UNg8svn/B1ue1nP2AQ+Azt7kKy0RC4d1u7v
         3Yz0vu7InmxQB7QdH11JFlAY0orqeJUpjbuL9LU3AuQSxENwaW4qTR/c3mzrYgLFh9RC
         ji0A==
X-Gm-Message-State: AOJu0YxJwcoKJuyPXemVvd2eHTLyYn6S3AL/hJ93NLe1kAhHeyFJ271c
	rmNyYwrHvrdzjrZQ9yZeyvfpDEpTok0w0dTQa5Uwelx2TLYtg/6smx4QQMqLN1Wf2mTPGXsulb/
	BSQA4P6Ue4jCD6nk7r4en8kiKNfkNm0x8mBVSzYq+X74zVXgPUQhD7wk=
X-Google-Smtp-Source: AGHT+IG3YZniosI/CpDU94Ng7pPafv+1B9bQ4XnJzYI/F435oR3FLGTsEkP6RQryGxVbCbrAEGkfujP1a2FR0BA29P31HNaNZa0p
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ee:b0:363:8b04:6df7 with SMTP id
 q14-20020a056e0220ee00b003638b046df7mr338025ilv.0.1707645305395; Sun, 11 Feb
 2024 01:55:05 -0800 (PST)
Date: Sun, 11 Feb 2024 01:55:05 -0800
In-Reply-To: <000000000000a135c0060a2260b3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4a29506111827e7@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: null-ptr-deref Read in ida_free (4)
From: syzbot <syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, davem@davemloft.net, dvyukov@google.com, 
	edumazet@google.com, johan.hedberg@gmail.com, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, 
	william.xuanziyang@huawei.com, willy@infradead.org, wzhmmmmm@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit af73483f4e8b6f5c68c9aa63257bdd929a9c194a
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Thu Dec 21 16:53:57 2023 +0000

    ida: Fix crash in ida_free when the bitmap is empty

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12fc6ba2180000
start commit:   b46ae77f6787 Merge tag 'xfs-6.7-fixes-3' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ae1a4ee971a7305
dashboard link: https://syzkaller.appspot.com/bug?extid=51baee846ddab52d5230
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127837cce80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12779dc8e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ida: Fix crash in ida_free when the bitmap is empty

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

