Return-Path: <netdev+bounces-159383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D81A155C9
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC7E188D6D6
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 17:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA621A23A4;
	Fri, 17 Jan 2025 17:32:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522F9165F01
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737135126; cv=none; b=Rk2QtRfWWZURRcNOa+oiC8yS4NH7COXY3afIRbgxFfIsndsCzD+Z1/EAPqR/oV9UkOlrDfuMRAdGXnae363tQsLj7LdY1tQ32klXRdDXh2qY9JXgDStTNiGaoTgvqY+oKQJA4dhFFCa50CoLEdBUWyC6ilk5jwguAre6JRGHvYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737135126; c=relaxed/simple;
	bh=2Nk2Oy1IWVAKqUUJi2SAb+QprDPIbFPfhxGF+Nkq5bw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=To5+7c7gnNPDvbshAZs/zMudA2h3PNlRNXFMq1zd801Qt8I9fW48T/hS2NF7W49N5XiiBHr87LRN10Ec6KP3Gs46Xw9GzBmzvX9AL6Gq1OSoe5ct0SljMN6VPtuzbHCILQX3w+j0eUgjZdglk8cXjzm6yeX9JOoTlTSShcj3Rvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ce8868a7a5so18748935ab.1
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 09:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737135123; x=1737739923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axNUQUDH1jvBaGJQhc6GPaD1iNkdOyagDPhgOxI6o10=;
        b=nVOvaJ8kpwjeyEmRf4MvPh6L2KM4g07Jijy7b1nXjPWVY4oK8bGo0QatFMehiLO/h2
         oytGT6eyXJsR+0gLnsVg/iTGV59Vwo/YnAQUXC+0jfo1UYh+nB55axXMspwudB9a5Blh
         /74dq9RfD8LSduNo8Hd7QwEedan6pPe9A8ts/6kwN4LjcbcXbgzrz2ZckMZRJj0x6WPr
         h3pvR1g4usAw2VW/fbo1hhaPxWj7cLQF3u0TOnQr3c91zaqxWHBFQfW5gIfuRV2MDr+h
         Cnc16m9GZQT8E4vT5JCqM2U5us6Bsf1xWMs6yVpQ916Nfx7cN/MS3Y0VPG1BBfX+BDVW
         Ts5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhzaJvtwWoWdB9v03YohzZEOw9d/cJ+6TXyTmVhpx3b6S9U6qAxJpi6Amx7VtKPa1sRkfqApo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm6XbBsSa76j0jBSfhFX4q/2giN0aiKDLQBcA5xw4BfADwhI7A
	oZ/1Iys26rLRZBaWo4cE44Hmbzp+2YBP5Gb3YU7kgVDHItpLPp0hTs+GoTqKsuY38bg2RgLh/cZ
	V/LOl52fCbrW2Qf85RWX02LGdQtFaiTr0noxJMEJvqsMFJG8i8r7N2Jk=
X-Google-Smtp-Source: AGHT+IGo3YxZCNQ/w3Z1ipsSeX4bR/eBqKzP/x6yGR1c20N50Nr9fqm006172S4TfgbGkDD9mp3faP9wzzce+9oZyLBLfNmUd+bT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:8e:b0:3ce:7b33:8c3b with SMTP id
 e9e14a558f8ab-3cf747e2027mr28485745ab.5.1737135123486; Fri, 17 Jan 2025
 09:32:03 -0800 (PST)
Date: Fri, 17 Jan 2025 09:32:03 -0800
In-Reply-To: <66fa6c80-4383-479d-b17e-234bee6ed7ad@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678a9413.050a0220.303755.0011.GAE@google.com>
Subject: Re: [syzbot] [mptcp?] WARNING in __mptcp_clean_una (2)
From: syzbot <syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com
Tested-by: syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com

Tested on:

commit:         5d6a361d Merge branch 'realtek-link-down'
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=151669df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aadf89e2f6db86cc
dashboard link: https://syzkaller.appspot.com/bug?extid=ebc0b8ae5d3590b2c074
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10983a18580000

Note: testing is done by a robot and is best-effort only.

