Return-Path: <netdev+bounces-206960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355DDB04DDA
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 04:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4058B161A5D
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 02:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9C3253B56;
	Tue, 15 Jul 2025 02:33:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2474524DCE5
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 02:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752546786; cv=none; b=Srhheas4eESfWpP/LC12ljqV7PhxhdIRSykQkvWFeAARqRN3IQsbZbOWob8iW+Bhb6jvHrumjz46fJd8C8twq1pZFO55bB6zhw98fRfXqS8hxuCDcwrm9hk7+7JMJ3ghDyp2QUyDmqy9Dh6tcK39PrOxACDy80javlRrZqTaBsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752546786; c=relaxed/simple;
	bh=7AndiXTD4sbV5agjvgEfYoTGkIYfFDWFjpNYdv3Xtho=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R3fxNbppRlm4wn/Vsvx4tSyYTWzP1q51spKbUZcL/CugP7/a/rBgdPq5caFu289cF6zSQYJX7OjbxFnBi5snwBBQMnqzPn+EhJbfQmMhrQVM+7/Y7H/qBfQTPwG9vGNnWNohblJga/pQihttCV5X6/WnY8KF5M6JegSjF5pL3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86d126265baso466538539f.0
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 19:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752546784; x=1753151584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yE4JhMmA44lV+WjxvtXYki/dvYzl3IpMsCSep6EbVg=;
        b=umb06cuajGh7ZCad8zk5L/wThxvj7XnoaiyrvewOX4PR1zzQAvkIQRyqC08AXZZ2RM
         gk5XgOFPYqnsWCo2S4kU8GriNRt3aFbUknFqtTeC6RkQ1OOq0Xjv6zoj/yB2UbaeS0ro
         fabui9tQAG1RCBpPWxjmdNULqFt/As3aGqRxCkSMbK88VYj0JcsNl6MguwBwG2e6uMKG
         352FUz8TcXOmHZUaShT8jO1927ANCFV+rzpl6Qk+SCRU/bd2ttX9PjIU3ULZ8h/ttNG9
         vKAStFKLs766xAhTOfSzSVOfqoJuRMqSYsOLxMQP+U1K+eFok1DZ29AIDQRghU4FUtLz
         QpvA==
X-Forwarded-Encrypted: i=1; AJvYcCV+A86APkZReT2wjVeJ3pXj24YS+ce7pNLP3YsD1o5JnqCqinS2G7zO835RFL56IfZaKiKhMmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+MOr8Z8ewy0w+S0hWFwgFAWcdtrFV0fCJdBBXhjd1u2WO/hxw
	eZ4Ex/SNH2IJnPl0c3IMCz0Z8Id5iRrBQIoW6ITVBns+u5j1x8LLk8Y+fCXaGac3m+w7uK87wyG
	iWeecgRQyy6412xyiVXZ6fL1W2dX/WzkK5+hS0wkkIoTguFsNFi+ZB6GxcXs=
X-Google-Smtp-Source: AGHT+IF2UUDClpYWB6viGBXYp28+nczoOwxL4W6ADfPyApY+NBZpSA62Hg8TL78bt20h7n3z9+OWCwAApBxgMoMd2psNr7we5eog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b48:b0:3dc:7f3b:aca9 with SMTP id
 e9e14a558f8ab-3e2532fc02bmr34673265ab.14.1752546784316; Mon, 14 Jul 2025
 19:33:04 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:33:04 -0700
In-Reply-To: <CAF3JpA4QvNvdx-tq-5ogMmmaOuZuYq8Q=JZjQj0egWGE-=Nogg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6875bde0.a70a0220.5f69f.0008.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_tdls_oper
From: syzbot <syzbot+f73f203f8c9b19037380@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, moonhee.lee.ca@gmail.com, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f73f203f8c9b19037380@syzkaller.appspotmail.com
Tested-by: syzbot+f73f203f8c9b19037380@syzkaller.appspotmail.com

Tested on:

commit:         0cad34fb Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=10ad518c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37db4c8907581400
dashboard link: https://syzkaller.appspot.com/bug?extid=f73f203f8c9b19037380
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1183718c580000

Note: testing is done by a robot and is best-effort only.

