Return-Path: <netdev+bounces-118982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE08953C82
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3903E1F25866
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BA414EC56;
	Thu, 15 Aug 2024 21:19:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEA481AC1
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756744; cv=none; b=i1mK/r9mkvz0mDwztOZeLEOqnoCpRyNtm+58HIiJV9brk+7mbfQ323qdtqZ0KbG3iAabb/vQpXBqRVjXe21I71YkyryVGH0J4kGviqYGXIWQIpGhT400OQ5b3J1C8ne2oMLao1JlF5tgDAPhxgmEu8ZKSxM5sae6wF71OnV8o1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756744; c=relaxed/simple;
	bh=aArgchPkT95Q1Ukr/lBmxz3QXXDbxFb1p0bAQs5jXAU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WMOqSMMq+HeD1mUpfyoiNgtl28phEX/zQgS5GNZ34/0g+nTb7YIWvjFBhpLgxkNaFAavj5MI5S9YvYBK3xpfip1P+aMg4glm0NL6aJkps8cMSj/0yi9AchqrUl5p7TZ62vo4JjBy0o/7DFr1U9bbDb4s4MDnmMkb7RJOhyqtUg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8223aed779aso137422939f.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723756742; x=1724361542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+0T+XqP4Bz2F831yO3gHfxchaB60QBso5aYHjU9iOU=;
        b=QmlbM7hIXPIB5KUzs7yW2wa9Sl8el64yn0PPN4gO3fxjBDBvKKEXUu6yaQBwGueiAy
         nd5Okl56y0pUg+4aERfGjQ3D8oT4ZCLr16KI1nawpcT8nEGlt6w28hOEmqK3sTQAqotu
         esYOvpT90I52G/s8TP0D6zfXsPishjBOVaxhaOF1qoZxXKkgmB2HMaLP6BSXYaAHimlG
         nltxh7SxIL958NXjpsypkJToUIvYvvsGz4Y7yZ/NH6JC2+d4ieQcB9GZWXWLoQt5I8rv
         hvjoWrLcyZdc7cwCa3bgjiTtky1l2WzvDuLBMe1xPB/G7BmbrYa4+ww8kRLl6hnFxtAJ
         0KPA==
X-Forwarded-Encrypted: i=1; AJvYcCXALa3LXALK2OU4Bxnd8mSq63gNrJ1N1D+k0buRtpi+9iIplzr8rlUqPHylhO+a7cTv1X2av+YnzzSlrI5yAcnpDbvSA6ef
X-Gm-Message-State: AOJu0Yx7nKJ5CnrKZbSY1zZ/c89swztF6ruOphneVvVO9CcKwvnRNr/+
	I7fKtQwGmL2u77R+Ipki0A7SwtjMgKiTE1GosxBM49XznD/BEQIKrb8dtJcV807GAfQIsEhfPT+
	AGP/u7SARo3hgp9iRe5igqqAHOFjXdZvdXgGQBHNaeMzHwERTH2vG3mg=
X-Google-Smtp-Source: AGHT+IECJpjiH24a4azW6T2it93pL2Vz92fb+fUnHvZ1hsjPUnB7XczcG1ri/D4d96bHBQnwiyElvwOKW6CIMrcvQgrv5Efg0dXb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35a7:b0:4c2:7179:ce03 with SMTP id
 8926c6da1cb9f-4cce15d7b63mr20874173.2.1723756741579; Thu, 15 Aug 2024
 14:19:01 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:19:01 -0700
In-Reply-To: <20240815200418.44944-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042e430061fbf64e0@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in kcm_release
From: syzbot <syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com
Tested-by: syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com

Tested on:

commit:         9c5af2d7 Merge tag 'nf-24-08-15' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git HEAD
console output: https://syzkaller.appspot.com/x/log.txt?x=17c3f583980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60413f696e3b4be4
dashboard link: https://syzkaller.appspot.com/bug?extid=b72d86aa5df17ce74c60
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1568c18d980000

Note: testing is done by a robot and is best-effort only.

