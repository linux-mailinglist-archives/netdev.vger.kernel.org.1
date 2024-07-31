Return-Path: <netdev+bounces-114537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54F5942D98
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 13:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E90EB23E0C
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33231AE871;
	Wed, 31 Jul 2024 11:57:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823E21AE86A
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427024; cv=none; b=F1h0JC2wdT3mPSGRiG/tSOJw/NhueihlrcqmMfZs119VLrNrg4/wcwg/vA+AjCKgJydoG0AXv7npiQisUka2xH4XQQrgNdHr8/2k35DlPjQkKw9aW56uFkC8aGTPMm/aqYxmGQctQwVEfw0gHdVfIVI7vEpMXrdONEBqqt7gbjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427024; c=relaxed/simple;
	bh=hQUoUT6P370vSdku525I9ZyIqVpjyDqZTAwNNZoSxuo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ronZmex5t1svpYx6xQHyvQycMRwQW60A0+bhDti2c7fqWmM44mp1pqj3hlvNCPYiDgYOFplPM34zXDs+vYt5US8136Qj58hm6P0ehOjqPDgHFfCBlAQq4ikSaLDqjj9qQ7FLm3TULPVM2+A18MKdjA4NPkA+9BB/gDkyITOQTxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39b15a6bb6dso957995ab.0
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 04:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722427022; x=1723031822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSrgeN+yuzirQre8G4sG5Sw6kVPo4mH3hIOR53sJbwQ=;
        b=aWBE6Xig2ifAGDn5qKQFNEn9NMwg4Syyu9nbtWYL/WTVMHshSlgLDVBEdE37yCkNrU
         fDK5eLiYb30NUjj88FM4kNsA9lP0CgQPTC1ZzW9tcXzfi7F/azQmziSnSiXbehrEtH03
         OgZE/aOvnaPGnT3P+CEcC+bIfexK0YgGAChlxidHt2FqKIA7DZVJ8hazU+tULdXFC96L
         XLdsbJRy9SJIQyohkrTfZEhXXqv3oZIsCLiOZGMfFc8iYz2wUWbQiQiVLer3gdCxJUxP
         rOg8XSg2ZqkMWgs8wIZaJu3ZiywLxZS/j1hvSYE+TVnw4TeNbqFMKQf6yFz4ws20Oh3Q
         /WbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXONb0tq5QXlY7ze80z5DQ/i6eKxIyBo4cnds8EDMRe4wREN3SYYzCekOzgQoSgJ/gQe/WoFgnjWyMolTB8+Mw60uJz1hmD
X-Gm-Message-State: AOJu0YzePUAPRAbCmhITJwAozMaj1JpE1YXoyiiD7DpehMwnXfmJXJXP
	NNuONfmsRGutt5IftO0J07h9sPCOZ2VjBTVl2Z07xbZynHLhzDAaGG/noiDPeW0If6jjrSxRdmo
	fHwOXkpBbuG0431ZP7Z+WmgA4sdcYSn4Y1bkBEfT6sOkOKxXiKglPMV8=
X-Google-Smtp-Source: AGHT+IG6yJHm71PfnjSzpzV2tajfrhXIQF3DZ9LmFmTF0gSF9zc7EprT5Loy3CMpp2Oq1hqsKdRV7a+B3kc8FcJHdRu9wenzlL2s
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa2:b0:381:37d6:e590 with SMTP id
 e9e14a558f8ab-39b06af47damr3064295ab.2.1722427022641; Wed, 31 Jul 2024
 04:57:02 -0700 (PDT)
Date: Wed, 31 Jul 2024 04:57:02 -0700
In-Reply-To: <00000000000022a23c061604edb3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d61bb8061e89caa5@google.com>
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in __run_timer_base
From: syzbot <syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, davem@davemloft.net, 
	dvyukov@google.com, elver@google.com, glider@google.com, 
	gregkh@linuxfoundation.org, hdanton@sina.com, jhs@mojatatu.com, 
	kasan-dev@googlegroups.com, keescook@chromium.org, kuba@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-usb@vger.kernel.org, luyun@kylinos.cn, 
	netdev@vger.kernel.org, pctammela@mojatatu.com, rafael@kernel.org, 
	stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com, 
	victor@mojatatu.com, vinicius.gomes@intel.com, viro@zeniv.linux.org.uk, 
	vladimir.oltean@nxp.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 22f00812862564b314784167a89f27b444f82a46
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Fri Jun 14 01:30:43 2024 +0000

    USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f906bd980000
start commit:   89be4025b0db Merge tag '6.10-rc1-smb3-client-fixes' of git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
dashboard link: https://syzkaller.appspot.com/bug?extid=1acbadd9f48eeeacda29
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145ed3fc980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c1541c980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

