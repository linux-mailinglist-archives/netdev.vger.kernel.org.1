Return-Path: <netdev+bounces-241658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 137EEC87477
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 034D94E2A32
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 21:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DDC2E62A6;
	Tue, 25 Nov 2025 21:57:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3733E1A23B9
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764107824; cv=none; b=JPceWgftFR/Iqwe86TO810+7hXg5WQFbL/xB4MEwsH6WqrKHLnkFeP5n/Ksc+jyla6broZWc1vivvuoXHxdB9JWrxdwO6l2XG0Tz35ABb1p7qCpkoWVUKBSs/xFuR13n9wtYwNcN50wBY4w2rATM7EPkOQVw56wg5372TtVGSTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764107824; c=relaxed/simple;
	bh=/2HDgATv3ct8ZJWOt0qr5TSE8QGRIX3SoHWTcWoS5u0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Tzkt37pebJyKCjTM65vI9Ep+I39ZjROq8HSYllzKwhRN2HfVeyVb7QZYROxrHWJrHoeigA35SAIeG9zFuFHrmrWtOVLNBfyVvv5PFUdmLaAQMX4lFArv6z5DDSxpNaqomu3walBUZdUVOP3JCDhXE3AY1Kk/5oMRtnnHDnkb/QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9490b354644so462380539f.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 13:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764107822; x=1764712622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jT+4XkWR7efaDH0BcJaZyxh+BxXocscIcRlgONxMTWw=;
        b=KsduBGNJZRvbUqW5d0Z32+veRQpme+C6TTUIpEzTAORAAsdPvqc0zI0APs3h7fTJkR
         IosTavZ0x+URthqWncCyigFljIEZDHqTmz4TKd/GHvge+vdzF5Sq+k1/SxaNxV+jyvGm
         Pb9NpUe8Cn6fAFq2TCcZ6CrSjZIEB28Upfxwz6rsrl4GJQT5k6YiuUsdSbLwgJCvvDVW
         nj3pAK7yXXYdOjNf+t3h8Y8bIDhJZjKZY0Gv7cfcMJ8ukR+CXegCjrdKlVgi4wl0rzcS
         g+j//ARaFcctGu9SifaKajNxy5o54Gdrs3VKjYMUuyeNUXgW+I21oQHLz8Ru0+ZPqUh8
         q2KA==
X-Forwarded-Encrypted: i=1; AJvYcCXn4S1+FbrjqwbDqT02wBXAw7vvYbmYYksFuFuFd12tJrtQ1YLZWRgvpCeX4mNVcazLnHQhZzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZLOBifC7MTKHcH2UQwAd4yNhIUkn24dChkdz5A5TcScY0Jn12
	LX4QO9vcT5UjjsaadZDS8pbNgVKhtkpjMvMl8pGGaMfMsW2ga9Cb07OfG0O73v+DTqIf1UVHtyb
	jp73tZrWrl3/xbKg9xoTjWP/ogxPsZvKuFbloW1+0EGqGEi+3tua78VCIzaA=
X-Google-Smtp-Source: AGHT+IG3wqjvbKfB2hfB4MeW4puzDDSRkS/RKgAh9Rbe/CaU1DCK2BO1zOrnYry0L1ycMdJdMU6YEb2LFZJVDVeXRJ3lnzUO1OIA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a07:b0:433:2eec:66f7 with SMTP id
 e9e14a558f8ab-435dd065403mr35481365ab.15.1764107822418; Tue, 25 Nov 2025
 13:57:02 -0800 (PST)
Date: Tue, 25 Nov 2025 13:57:02 -0800
In-Reply-To: <9a2b03dc-acd0-467d-a4e6-feb5cf6165f9@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6926262e.a70a0220.d98e3.00c0.GAE@google.com>
Subject: Re: [syzbot] [net?] [can?] KMSAN: uninit-value in em_canid_match
From: syzbot <syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, ssranevjti@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Tested-by: syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com

Tested on:

commit:         30f09200 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13236e92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61a9bf3cc5d17a01
dashboard link: https://syzkaller.appspot.com/bug?extid=5d8269a1e099279152bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1230257c580000

Note: testing is done by a robot and is best-effort only.

