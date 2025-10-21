Return-Path: <netdev+bounces-231179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7C0BF5FE3
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53F718C876D
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC95235C01;
	Tue, 21 Oct 2025 11:19:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0112F3C20
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 11:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045545; cv=none; b=F2QbeAYSnoHV8v8TePJFtuHSvjjoJ9w2zTFtFQ3NmzyfeBRM5MTRt0X+bNtgR5PYMWVNQB775vNPvtwN7CCrNXNy6Kt6qX/+egKMKha1xD7YuiZCTz9uW7+8Q/E1MBaNx6KRb6jSummEDi2yTTOKFwCKMOaBtUbPtj0wyO/lmJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045545; c=relaxed/simple;
	bh=wMfqNgwnFuW6kaOfH5o5fhpzsdLETYMsMm8MQ+qtlac=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j0gF0ZNhA1g1jQUX37OfGSW7lS179NEO5wjCMXT6bnJg7uIzes6ynVLJK74V+QXInOjBqGa8CXr2DAkhQsboozL5h68PUBI1oaTt2P/73sPoA1YjZv16Xx068cUX/9caxBbkXbfCwtI45K26nuvCWiFhE+owl8YdxzlM8oBeuS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430d4ed5cfcso99024035ab.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 04:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761045542; x=1761650342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNdyPlI5JNwn11Fal6tTcpVingDDGvbnySJfVkaupSQ=;
        b=cKzmouhQ3izKFLHha5iW8PNxiXu9Jzc3OEgRrK9uoZc1qQ9IoKqCYcSv+exBxiX+UN
         kiWsPuQe+BHIUmmF3lojU2XsFceXJIJabX/HznR4c5f0XbvqtfSxZdHzqDOmjN7OYOVF
         +CKkIlXXwhxWUDU8YkKWAhNpgPxMlN14TIsYR0O6y9K7P38RwTwbGmoi4RMa1YC1JXTC
         3d6MuLstjZdnLJN3AZuCWvES6Wg296RK8jzw3yHz5h+gi53PMjQqGV66I/N717nKXS6t
         JjsMkZsnS0mrGkCY9+igrHtqNgspdgcM6Ly+zaHwu34KftEdJRbrJlH7+S4y6M8onO6Q
         tFMA==
X-Forwarded-Encrypted: i=1; AJvYcCXGWqGyCN8//61KOjw+zDz/gN6indf8dhnQ/DFeWXevdIosf6nKaKiEb+/UgPlFXIrlcUGAmp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsNXB3+JzcTdNBmT5L60LqgLOTrbRc+3ASl7DY2+NphacTs0L6
	zlPrmbaD0Vhc2sATyB7WbzdSI9CY+02NkJYBDYE7w+N0b/DtYhr8sLUs6llCUFCaRmOa7UZsExE
	AEo5+S7Jzok6qtUznjNRaoXNJ9vnQWIWlpNWstjWo/1Ee1yh03pcjwJ4ZSew=
X-Google-Smtp-Source: AGHT+IEcIo1pO4xDhDquoKwxmVbPrU03oJXllEdu6f5jSLQeJz66ctdLZISCA/3D47hgXamRzMXq0eAzq6GenTwToWEorDdtJPHH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b02:b0:430:bf89:f7f7 with SMTP id
 e9e14a558f8ab-430c524fb13mr270754915ab.13.1761045542520; Tue, 21 Oct 2025
 04:19:02 -0700 (PDT)
Date: Tue, 21 Oct 2025 04:19:02 -0700
In-Reply-To: <jms5wjabuhoohobldv4zzfa6gurpnbw5xb5ejeha7md4z7atpj@r5b7mk5mn4n3>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f76c26.050a0220.346f24.0014.GAE@google.com>
Subject: Re: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
From: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com
Tested-by: syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com

Tested on:

commit:         6548d364 Merge tag 'cgroup-for-6.18-rc2-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1534c3cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
dashboard link: https://syzkaller.appspot.com/bug?extid=10e35716f8e4929681fa
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11a90d2f980000

Note: testing is done by a robot and is best-effort only.

