Return-Path: <netdev+bounces-210272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D881FB1287F
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 03:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96046AC546B
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 01:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78711C84DF;
	Sat, 26 Jul 2025 01:43:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171E71C6FF6
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 01:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753494185; cv=none; b=jHHwGosEzzfCfh1NG5AqBk94Mxh+oNzXx1hviKhAQIslWvatIE3lE2/b4yh1Moj4HULB+jzEbeYWTydFrL4gPt2UTmfE530h8LS1Ss1nmovoR9JaQLcQfh2XGFYW5YY1zRVP+LGUIv127yWN0ZD4/CRyJWQQUBZ+5+e21JQrVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753494185; c=relaxed/simple;
	bh=EiRZkke/EwWZK+jioE2Brp8brltihridvzQx2QVTP5Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DQDISzBEaleihqoSf6sQuHVCx6bAgqjbKi4tOEGyQqFfAPsEcasmLhuxeQyQFmjTojctUJRLal/JTbGu8/tp9v/Yb3hO2rEz4XvFj4Kme+BNa7WJP55PE8eDZaJ+fzrvwo+ey/Zajuxe1Lt2aKFhVvw20mjPYVFBBX7jtzWpwdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e29ee0fb2dso24891735ab.3
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 18:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753494183; x=1754098983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCUniYILMqleAH3xbE9+O1uxqI2C8yao5yj/kH/o7DI=;
        b=Gng5HfWZtlOlyoB/Kmz10OBn4fZHyvkb7GWPX11zGYOK1Gp1rVs7q2ycDcgCiBN4eC
         Z473ukmF8+smM+V+YhFjMMzxxoOmd4r7+3K4eGKiyht/bgkPhC4E/8R4zDblCkJKEvbm
         QeX0fRzOBHG1CJEXSG/DeNlZVm2f+SiU/G0nd4galFErcw2xZL9Qnx3orvt5bn4pcn8s
         qyrQsgllubWM0F5c11R5sWzJO9DwRqdGZEMuzmgk41OInl3L1i4ftgnQpVxF9NVejfgd
         HXO86rGtu73ZqLysji4lS/+F5XSbrsfypLXvZSlMKQmGWXB2Ab6rIknfqDUeaYSBEHuR
         vhLw==
X-Forwarded-Encrypted: i=1; AJvYcCVEdX3ZHLPYHNP/8LHF+Kf2QAXlHmFGtzkPxxzaMLNaFVQYFhGqrJRfB/kcAVK7AtG159WMYcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzHjbXOf9YBqDvNt0D3Ih0wnCVtDFE+DqO/IC0oVTrbm4+do8N
	12h1qS++W+g0nlIpzr0OM8nisRWNsY1FDW0jjnq2Q6WyfpCUK/9senKmVaeIQMpZMupDtVWXysB
	AV1vtU9HX936Y5budzdNqm9JG/HOxyYli0RNscNHlnu4+sxIEpNf6alVEXWE=
X-Google-Smtp-Source: AGHT+IEThwMXKzDRO0MQ+2RmdbFxFmPNC/OTQrGwiLB1flNLtz2bsAnrcviKrT98ZcLhEMaHQvexFRHwRefEGLWJWAajKGc5UjSj
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b86:b0:3e2:9a13:74fd with SMTP id
 e9e14a558f8ab-3e3c526fbd1mr56688995ab.6.1753494183251; Fri, 25 Jul 2025
 18:43:03 -0700 (PDT)
Date: Fri, 25 Jul 2025 18:43:03 -0700
In-Reply-To: <68837ca6.a00a0220.2f88df.0053.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688432a7.050a0220.1a379b.0001.GAE@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING in nft_socket_init (2)
From: syzbot <syzbot+a225fea35d7baf8dbdc3@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	fw@strlen.de, horms@kernel.org, kadlec@netfilter.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 7f3287db654395f9c5ddd246325ff7889f550286
Author: Florian Westphal <fw@strlen.de>
Date:   Sat Sep 7 14:07:49 2024 +0000

    netfilter: nft_socket: make cgroupsv2 matching work with namespaces

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ff50a2580000
start commit:   94619ea2d933 Merge tag 'ipsec-next-2025-07-23' of git://gi..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1400d0a2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1000d0a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ceda48240b85ec34
dashboard link: https://syzkaller.appspot.com/bug?extid=a225fea35d7baf8dbdc3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bf10a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d27fd4580000

Reported-by: syzbot+a225fea35d7baf8dbdc3@syzkaller.appspotmail.com
Fixes: 7f3287db6543 ("netfilter: nft_socket: make cgroupsv2 matching work with namespaces")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

