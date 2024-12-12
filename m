Return-Path: <netdev+bounces-151484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5399EFADD
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 19:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD44289193
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28D3222D7C;
	Thu, 12 Dec 2024 18:26:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FA9221DBA
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027964; cv=none; b=sSAPgsv764g/7ThIVdgYCMgNt+dsrzi7p9q9oqqncw31ObKCGk3bl9oi2/tTPMm3GvLs8gkKknZbJ1T7W5RvrWLgRSbjmJw9m4q6roZ7ZDlSS8/1koOVsZUYzb6iZIVCDv/2rWvhF75ISvRdk4XeWM4bCvXSJ/c4dK1DRdyDIz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027964; c=relaxed/simple;
	bh=XyuFjvp6r8PXeA4I0Pntfh8Y0Qo8ho8/scw5bsXH1Uc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JtkdVCa8clNcyq5XoHv5MnHowgrFaDt5yUuP3hY5QIJrhG0VRhU8Y1IvqQbHPn5FGV7KgtfLB70mq8Zg7a4Bh2OkS5/5ZvEh1/t9fX3o2LO9zlLHKWO/alYxNs5E1+uOX2tqCdOO+wfWAfjlVuNhN3NIhnggTvZ6VfnMLbURas8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a9cc5c246bso9311435ab.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 10:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734027962; x=1734632762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sW+/lDTC0b8UZh2dxjnr8friPvPYb7EmJIjIeSxBdFA=;
        b=OHDw8isYOztPg6X5rMNPexX0FYzJZ+CMjXvXK23MK0LZaNuwjGaMmaK1orh6jusQ2B
         fO5YkVadeZCF7Y1BDCtYMZO++r4xAuDbzVdXyZePsTAn7+/ZpcdlW8UYGcyDguVaWOzy
         BTsOjhLNpdqY9YMWEL5iqCA05J16bgW1VzjCQDFMN+qNQ+bpgWKGZ3AAf06ApMggRIVK
         cIN+AyIcTCjDUOVNGSMtd6n8KRqhIBXvXGF8OvuHRsLGvfpwcaoFbicJbjY2IhJtO3RC
         eojY4xMRIcOEWrX4QW2OMMRg/XUnt8M3K/+8otsZRl6QYr/LJFUg34WmkUKdiONc+pN0
         RAvA==
X-Forwarded-Encrypted: i=1; AJvYcCU9wiYPp7mvx9wV7ZRMVavNgOQsQmREMIHcbFGzKNh5JWA2JqHdSAg1vdvDoZpqFDId1BAOwMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpcAPka9q7SpUxa7hOmMc6JYa1LJLGuuioqEnxNqKli/04D2+Y
	ILKpLLDK4fxVBJH1KmnUBsj84EmRqeWFl1x8qy/3600YDPU1rldrMyZqnqyKR0dxrpUKJPBkS3J
	/Ec+BbpRD0Kqy9y/x347VP1H4mEHCPwXO8jTADq5GNAc69IoLtpu0y/8=
X-Google-Smtp-Source: AGHT+IExY+GpZhT4LY1EAoJc7FTkyW3lNRAXHgLAc83yB9ShBLWnBx/N0DdUllYOBN1IAvLkPGD6gu0VyXN0oTXaovqXjCyzOagt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160a:b0:3a7:8270:4050 with SMTP id
 e9e14a558f8ab-3ae57c14773mr12942005ab.18.1734027962569; Thu, 12 Dec 2024
 10:26:02 -0800 (PST)
Date: Thu, 12 Dec 2024 10:26:02 -0800
In-Reply-To: <2863838.1734026244@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675b2aba.050a0220.599f4.00b8.GAE@google.com>
Subject: Re: [syzbot] [net?] [afs?] WARNING in rxrpc_send_data
From: syzbot <syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com
Tested-by: syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com

Tested on:

commit:         f3674384 Merge branch 'net-smc-two-features-for-smc-r'
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=13a34d44580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=ff11be94dfcd7a5af8da
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=169d4d44580000

Note: testing is done by a robot and is best-effort only.

