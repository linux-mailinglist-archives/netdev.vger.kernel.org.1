Return-Path: <netdev+bounces-151927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E989F1A3A
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 00:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4976818880BA
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 23:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278761BE871;
	Fri, 13 Dec 2024 23:37:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7881B86CC
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734133026; cv=none; b=s/3/mTwT8bkh9ZUQKVupZD1p6zd+KoVLoLjTh0TwlFmR+fZjrzjZsQT2nSI0hFOW0ugn849LRsfMQOnLgz7agkWvg46Upg3bfxwz0TmhzN3kOJPlS5Bx3BPerA1gkEl9HwklYp+xw0KP20Y9PNoqyvzJdrSndnsPk4gxsSNgGSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734133026; c=relaxed/simple;
	bh=tMo9z0KMvVLPZIk8gJBJFYqrwSB+a0gupKMzd0Lb4sY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YSLR4xZoAZjEdwftp+CYSE4Jmwreh89VEfrg2IpAAvQJk4fDh8RYTmewGm9RGHWQE0BB+RqqffajQyHqs2SxQ+jERPWuVBrnlyQjjh57r53iCplXdt6Z2TzaJZ7vX2JQtIHilz6Q3DFJHaUEJDtl7DNNjaEK1eJSo8n29yRF3+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a78c40fa96so18471845ab.3
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 15:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734133023; x=1734737823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yun2ZwFdy6SoRPdNnMAcn2qkYLCbCofrCyTIGF8v5g=;
        b=S4dtUKUZIC27LAprb5uikcx/QhVbM087xu9/603I/yqZTs7ff7+ycgz0K2tTi0mP4l
         c3G2yAt2gSN8I6+DoIDxkB6NHxJMlhCoJsQvjMk4nrJdB44FW6QiCedQnSDNz5qTPzi8
         10e9hmnmF6EQdo4hasn9Hs8Wbi6Re0P7MFGljtYxWOmIb1BIOwslAnEQdzyY+Nv3d44j
         BdlPFagKYdsqI4WWoAJkB0wOEFIyo0caIh+YdMGO3OR8Y8xQDpv045Z53VApuAu6cF/W
         wMLdnR4exVramxmFuAViY7AmY58ow/qI0Lju64kpPDV4k+56phjgHEo4L55FMBkeXxDv
         8H/A==
X-Forwarded-Encrypted: i=1; AJvYcCXbPMSn5IM0i1qvcEgcPedFg+J3U7Gc/qSnrDzZLltmWGlWrEPnxOHeU1ar+CqccuVouzNUgRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcTTwt9Bl6rm9FxdZtdlYKCach18lxBRXdD3jdzzznb0F0xUL6
	7NxDGkYVnX48VVmxdEefzRgkMuYCVEEjhFIh1C6vF+loztH/orHOC90zi8ZUy2qdTNTAObWv+g+
	Qz8SzvzR9bJy2BMjEFTUr6wHqKzB7XQACkAhsOlnEKGv/dowFzclh8H8=
X-Google-Smtp-Source: AGHT+IG+W6ImB9SjfMRf7eoERjHcXQJViE8cx5y5WtFAXU3eHvoGO5IPYzYQIPGTjtM8onQDXB7p+BGkR7j9vKs331EekEgNvBLS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2169:b0:3a7:e86a:e80f with SMTP id
 e9e14a558f8ab-3aff4616efdmr64163395ab.3.1734133023743; Fri, 13 Dec 2024
 15:37:03 -0800 (PST)
Date: Fri, 13 Dec 2024 15:37:03 -0800
In-Reply-To: <20241213230820.1957-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675cc51f.050a0220.37aaf.00b9.GAE@google.com>
Subject: Re: [syzbot] [tipc?] kernel BUG in __pskb_pull_tail
From: syzbot <syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com>
To: edumazet@google.com, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com
Tested-by: syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com

Tested on:

commit:         2c27c766 Merge branch 'devmem-tcp-fixes'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=121ac730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
dashboard link: https://syzkaller.appspot.com/bug?extid=4f66250f6663c0c1d67e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1042a4f8580000

Note: testing is done by a robot and is best-effort only.

