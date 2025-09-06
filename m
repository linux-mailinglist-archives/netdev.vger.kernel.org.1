Return-Path: <netdev+bounces-220579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EBEB46CF2
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 14:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE1F583549
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 12:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53EE29B789;
	Sat,  6 Sep 2025 12:41:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2141078F
	for <netdev@vger.kernel.org>; Sat,  6 Sep 2025 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757162465; cv=none; b=TnUhgw8o1IaYQrtaNhsjxwdKkj97GBtIilEzFOwlQigzxw02SaPzkCqQtpyiVbrYEFF5CQUkRUHqdFBzgtS70HGpPBosluFCkR4nf+hM0tkiqNLbSto0NSEiZVEMJbzLvXUDzRk0BFNBOvPoQvXpdclompBmdnwreIE/P88ZtWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757162465; c=relaxed/simple;
	bh=U7G7G+aVkZB2v3V/zUCuzgGGvDKqhdtnY8WhOjRRook=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tAbCyjU++whlohI4/2GdLVXqSiU/fwlgVXK/HIVznl45JGfY5IUx6QTxvVjN6nJPjDx3g7AUw7qPZSK5uqPKeoFnQmz2RGcHNCCPIyCunqAwK6CRLPFoDVowMQQ1XyCYrtpsWEOBT1amT6s5nBqCmpNgeFKx9A4ilX+7YioRAJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3f2b8187ec9so76941865ab.0
        for <netdev@vger.kernel.org>; Sat, 06 Sep 2025 05:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757162463; x=1757767263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEKjptd+e9tTMEG8g0kTtT0/no/OlP4s8sHfIK6Y4+Y=;
        b=HNVBf+MsYPe/e5fR5jwzQCBLZE7Z2DylSo/ZXiDamg/s/4Cn+n3uE9Hm9UdPUnOiGY
         vzXnvHgC1u9KPhjqvxBalIGdHMjxuLXFB+9vwbuIXMSP4HvcaK6CwZtZcnwMcwaq7u2r
         5+cQpg+qZpcSo9rdjglGh1awccZ+TqrBobwyl6hLz/CRSHVc5sLWtP/FxtLKzQwViY1c
         mj9DPohzBRQmD/C0naooOGdpbUTlrXW1ruFxnibYCH2L9v4Z6fgetR1O6dFq12/6bL6T
         8daHRBLgNiriHs/k1oL0zkJhNOMmYJt8K7WlzExe/pHyRR9snUxHRAnz+UeOQXrcZMVp
         Y0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCV6EJx13F3nOYCd/nNnVbtskTJ5QwunOGoDNWL9+yKrezGAjXRx82mRAXkmXXVQhHQ49Q9bXKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEJ2H/VW0UKtv9hg+HRMmXO/t6I9rkzhkxVqZz7x+xN/6jV9db
	KjVYQ06NkydRvrVfkWElVDfHKQJLb6/HZoqNxw94fMhOZUeR8LqQFULOvTmMaJRfQT5K6JnURph
	vdZU+QZpfuNQU0HkkgQRUIbf8UfID4L98s5NL2pWBRcAMo6eVsSpMnY6W8RA=
X-Google-Smtp-Source: AGHT+IHxNVzyRSZvKDEdGlmnC8rBo6tj0A527j9A7QqwnVmZRh2c1L2jvTp4bM80v+o6jg5YbDExuc8bKDS+cnBSnKi+t5QY9sHX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:451a:b0:3fe:f1f4:77b2 with SMTP id
 e9e14a558f8ab-3fef1f4788emr15491265ab.5.1757162463379; Sat, 06 Sep 2025
 05:41:03 -0700 (PDT)
Date: Sat, 06 Sep 2025 05:41:03 -0700
In-Reply-To: <683d677f.a00a0220.d8eae.004b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bc2bdf.050a0220.192772.01ac.GAE@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in __netdev_update_features
From: syzbot <syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net, 
	ecree.xilinx@gmail.com, edumazet@google.com, gal@nvidia.com, horms@kernel.org, 
	jiri@resnulli.us, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, shuah@kernel.org, 
	stfomichev@gmail.com, syzkaller-bugs@googlegroups.com, tariqt@nvidia.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f792709e0baad67224180d73d51c2f090003adde
Author: Stanislav Fomichev <stfomichev@gmail.com>
Date:   Fri May 16 23:22:05 2025 +0000

    selftests: net: validate team flags propagation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a3ba42580000
start commit:   d69eb204c255 Merge tag 'net-6.17-rc5' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15a3ba42580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11a3ba42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c302bcfb26a48af
dashboard link: https://syzkaller.appspot.com/bug?extid=7e0f89fb6cae5d002de0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12942962580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16942962580000

Reported-by: syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com
Fixes: f792709e0baa ("selftests: net: validate team flags propagation")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

