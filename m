Return-Path: <netdev+bounces-156237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA49A05B0C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA911888B8A
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA041F942E;
	Wed,  8 Jan 2025 12:10:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737B91F9407
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 12:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736338203; cv=none; b=Lm/GhCBofOIS3OoPIiuJKQJQd4NSQNnxAGj6LvdVc+I92yl+sCHFKMJz5Wxjuhg3gHAeg7z1mg3eZ7t6t67OJ0ypOiRLS9eByzhj51CpY4Kwo5PjVRZIyCN+lQcVGyloAPmaf2Q+pPQRP2Y3/5PTqhX8oJLaLHECYy3U4gPOips=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736338203; c=relaxed/simple;
	bh=Rxre7t8MARgbNAeP+vbw9qLveWWc45lV4UomHZQAoao=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WKg0ehli8E1hFKZ8aKUGikdhnqFAhTRIAct6zUd/U8oITetb8m31muYAncjA4b1cxIv2KRBWDncuUynbwSf1jyF3UZEATYqLBjsVoBjQT/ETDH9YDGjsXwx6W3n2HvBvW48ui5jNmd9VHSO3sCpTrNEA4NnJ7n8pXOtVeDTukbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a9cefa1969so168412335ab.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 04:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736338201; x=1736943001;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgkJ1R0fraac5fKN0QYVxUewKcy+OYJ/57NQ903/IzQ=;
        b=mP1Md0UHZrURFoQ7dbeLjCEkVqlBaFpBF5+hiEZNS85q2N2vjHuvbKfpVzI50Quvcp
         qGjto1kS7gdRRxt//iLhsw16qW2Pgb2AhagpjeiAtXogqhAcqNeharEtj/zg8wgnZQww
         ql1ephRyvGpgW17mol0+e2XoNewb6736ALtKToHe9fMnmla46GlfSClH0x3RhiaMxbM2
         Fpy3K6099JGx9/4M4sW7+yPfGczqF72BfLn0E/A5O4DrF0O/ohgjHePf7fknRLNcsxBo
         ZLAe7aUy5nTt88h870tTwxte9tC+agzieA01eaP1hxoBoHTqn+KuT0L9bUOxUyRsEZEy
         scNw==
X-Forwarded-Encrypted: i=1; AJvYcCXaSrYiJ+5yOQPSNDMXGU+9dNwjnc5XZ3upNGLZwdRAEvDozyUnCfephSh1nOgoRSgTf4t+grY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzjoreHrS7L4zrLRffQGMIeP4y+SX5dXvHPjRyj4HTYD0kg0Mp
	doDbfLjXFARF0dwWjrGBVePgc1J1IUdvZCOofG2g99j6LANX+8ikSF7+zKsEYz+QU1tLvn9/3UQ
	i93vAR5mAvX4zY+4UlrlYtdfCBcTst9wqrhJ+pXjj1td5MuLVbx2WJEU=
X-Google-Smtp-Source: AGHT+IHVHyodzCGrLoKUa5jYApMoGIPWF97AIKLwvK+c0CL51pjJSXfWco/YSYgNXjo69i87mZ1L2sAsHqCcgAH1CX8TzR0VDXQM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda6:0:b0:3a7:e0d1:e255 with SMTP id
 e9e14a558f8ab-3ce3aa75a70mr21240825ab.23.1736338201693; Wed, 08 Jan 2025
 04:10:01 -0800 (PST)
Date: Wed, 08 Jan 2025 04:10:01 -0800
In-Reply-To: <20250108110457.1514-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677e6b19.050a0220.3b3668.02e6.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in lock_sock_nested (5)
From: syzbot <syzbot+6ac73b3abf1b598863fa@syzkaller.appspotmail.com>
To: borisp@nvidia.com, edumazet@google.com, hdanton@sina.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sd@queasysnail.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6ac73b3abf1b598863fa@syzkaller.appspotmail.com
Tested-by: syzbot+6ac73b3abf1b598863fa@syzkaller.appspotmail.com

Tested on:

commit:         7bf1659b Merge branch 'intel-wired-lan-driver-updates-..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=125b8dc4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=289acde585746aad
dashboard link: https://syzkaller.appspot.com/bug?extid=6ac73b3abf1b598863fa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b38ef8580000

Note: testing is done by a robot and is best-effort only.

