Return-Path: <netdev+bounces-199321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 994F9ADFCEA
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 07:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B36189E189
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 05:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED602417DE;
	Thu, 19 Jun 2025 05:26:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54714A06
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 05:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750310764; cv=none; b=IGLQLaYA6P9ktghclkAeSSFsF3GuHHMz2XLCRrIsYBYOYE58X5raOANP+vgox30bw5exGTCg2tyB8UN+t+Vc+MHRKSGEoldL9RBX/FxwIcR6FAQvoRvDiWpnYmoyAi9i1vHJcj14NHtVcwsE9UsrTjNKEGhpOI6VF7SlxYY1S1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750310764; c=relaxed/simple;
	bh=5Sdqyctg2uKhVTPW+2OeXcl6bZn8/pDFM49RmSq9VbA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IfDYsia0q7/Z1a/keUzqPQzAC8StpOVa6mUQT+v4OKYu7cLIoBIvdRbBrn3AQRozwloQDuF6GXuC7HUnnU21EtN1NrwsSqWy9JY3cHlCOrcdljmsTGDo2iFXnZYWTnRDktU9WoVXOJ+6KiJatcm1HqDDgfPJoSaaRcxY06NdFjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddba1b53e8so4329845ab.1
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 22:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750310762; x=1750915562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5AUYbYuCSXELB32r+LjODOWL/mKYb74pK4CYUXZ6rQ=;
        b=jqidIlnFdNJSnOf1O3sfbnSmYHiZIKnFD0l/uN56nXlH+Olq5zCbENM+sCffcLWmnm
         X3TlpuDU5GAFkOUmiBMd/PnY5ZYXLCMBF+lozmx00QK/Qw4FQ6WDJLqMbOYkR0eJAtHH
         WL2vgWZ5GRF3jhiB7yzsVf+HH3eh3UEkamhvR0Q+mWinN++v1xHYozs8kssbDlQrf7qY
         5S7CjKUM0T474sMd4snE8U7elbmIHZS1+z+3beoDAbAi0g0YODMt7XUHuXg7VnQ+u6Iw
         rCzydzvoY9oNvilRCpwZro8fiF0lCCiuwuPWPBReEQWyT0M0Cag4kBauVbnsnaA5W5mY
         XBjA==
X-Forwarded-Encrypted: i=1; AJvYcCUPj32rBlu5/M7u7hkj7S8cFcLBpSzyoW5ACPluO4ylcne1mfmfheHs1bZd/qEPYciMvDm7nRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/q7x6g+FNIWuJuKY+n04bjoF1K14jfTOqw8AIKy21zDnWAQPn
	fYdTSR0ZzQ/9CCombuWSpApm7UKffrX6vKrW88szxWhc8D5DuuGTNL41jxb6S43ZEpB+iqbpmkE
	LUKMzC90KXC1d2/BH9Bp5GCPVvtgADbPnVWNanOLIe5PfckA/LjNBjWTBSi0=
X-Google-Smtp-Source: AGHT+IFTr/CelEExJAxRfB5tskot6+ZUhO5hVmdtdRw2tFRqT9Tb64tcwaM+F9w1Se6ogn7dmIo9Gb6hZtYQVoh6T/T7B0OUEVkO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ce:b0:3dc:8b29:30bc with SMTP id
 e9e14a558f8ab-3de07cf9efcmr260142635ab.21.1750310762078; Wed, 18 Jun 2025
 22:26:02 -0700 (PDT)
Date: Wed, 18 Jun 2025 22:26:02 -0700
In-Reply-To: <20250618194732.835401-1-kuni1840@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68539f6a.050a0220.216029.017c.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING: proc registration bug in atm_dev_register
From: syzbot <syzbot+8bd335d2ad3b93e80715@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8bd335d2ad3b93e80715@syzkaller.appspotmail.com
Tested-by: syzbot+8bd335d2ad3b93e80715@syzkaller.appspotmail.com

Tested on:

commit:         fb4d33ab Merge tag '6.16-rc2-ksmbd-server-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1223e370580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4130f4d8a06c3e71
dashboard link: https://syzkaller.appspot.com/bug?extid=8bd335d2ad3b93e80715
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=148d3e82580000

Note: testing is done by a robot and is best-effort only.

