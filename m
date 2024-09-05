Return-Path: <netdev+bounces-125329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F5A96CBEF
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 02:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCC20B23FB4
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D056FDC;
	Thu,  5 Sep 2024 00:58:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F323D2F56
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 00:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725497884; cv=none; b=RNppbWk/ZaNYO4qUFAj1UQLVxwsyX5xua4U5iPStFBf5H9pGiOTSJjFbbhDs4cjFpXceREHHByS/4IFUZd9XBTD5AjbyCB49a7HuCuYFYXW53zuyYtzLD/8zkBDUxyymdJ0VGNIB8ykbD+ZN6iFuqVo8++EQVU/jw6yX53RAods=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725497884; c=relaxed/simple;
	bh=/CKTM4kaa8II5li/dqw1AQYFfg9+TnNU8dZcYvGwwak=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PASaULl7fHJ+6rjsezBdkv1CbxwfvegoxAETC9xshFVoSLHCNQuQcwnL0LreIA4JyFDOOOvImAy7+dEMZekPHf5zXzLslVQOxeq6UXfC9/2cX4dHaRCuquXdQ+zDKkk5cBnDcS2TK4TDSQ3lLFTnTor8DkRnU9PBS2QiAQjoFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39f5605c674so3463075ab.3
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 17:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725497882; x=1726102682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZDdNCIFN4mGTaZwK+oYi0RgmIR7b2nHRUUiEY8+dg8=;
        b=UmjMyFHzcroPfPViCQcksHk8S3j3fwnDcCLDpVqHKwEnm2kDQ2TCBM4mRmf0MUquGW
         rkcac5Bq3Ja7+PK9gKUVIMs3PH4R7y2ZSB9ilZ/NZb3HWVIh8WMBDI7cJ6672oIH47S7
         JWNE2bISbx0YX5D01++BWNADnFp1MzKVUsxS5tINeyn4RHtBVvYa5nzz7zCzUcxEWXUz
         45ZZutE6ZBxsDxS7JEqwyCYiNNJ7wZDNq6ApNq7PgmdwUDBwpSxdzatupY2tlnUjG1Eh
         xE2Ybi5tbRnpd8sv3hh3z1NnIij9h+Jbr8hjNz9GYQAVd54BE1KmdMv4txIkhVIylvmT
         gugg==
X-Forwarded-Encrypted: i=1; AJvYcCXhm7JfoBDlkcBaYv0M91MdeKhC1Co2rHvNilW3Yvt28VTfFGXLS3lX6nmi5u+cY1F4EwCHFsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YynlawVP4e1kMoxTL+CLdh6DFtX/Q6Wu8tAbtZyp4IikAbFimiz
	8d9KxM4CtMvHo5n8DQq+5cVo9K8FLyH9SpYdIZc65A3qfh50tTK//8wA6LuiBkNtDzJ9BEweBDx
	pOER8kEQO3JJTiwdSGrzDP/pjHZaThHjBpyggIthJqrzjQiCcyl7H1uo=
X-Google-Smtp-Source: AGHT+IEnsLK2ZSau2MDDBqtNGuj6kmEoDr2dm7p6FqAqPj/l4NzWbC4jEKIwiF0glFEzdNW8Cov1pEHMHrFeSCUDKrFFq93SdJHc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3494:b0:4c0:a8a5:81cc with SMTP id
 8926c6da1cb9f-4d017e6f688mr1169419173.3.1725497882038; Wed, 04 Sep 2024
 17:58:02 -0700 (PDT)
Date: Wed, 04 Sep 2024 17:58:02 -0700
In-Reply-To: <20240904174339.7790-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051e0ce062154c824@google.com>
Subject: Re: [syzbot] [can?] WARNING in remove_proc_entry (6)
From: syzbot <syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@amazon.com, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mkl@pengutronix.de, netdev@vger.kernel.org, 
	pabeni@redhat.com, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com
Tested-by: syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com

Tested on:

commit:         bee2ef94 net: bridge: br_fdb_external_learn_add(): alw..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git HEAD
console output: https://syzkaller.appspot.com/x/log.txt?x=10b70e53980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=0532ac7a06fb1a03187e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=156e82ab980000

Note: testing is done by a robot and is best-effort only.

