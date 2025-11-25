Return-Path: <netdev+bounces-241640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12EC8708A
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 21:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26F13B6A1C
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 20:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D84C33B974;
	Tue, 25 Nov 2025 20:25:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC63033B979
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 20:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764102304; cv=none; b=lFolrG3cXOC53l/FDprSspjSR7JaJlEgkTIaQAVCcmbxCChS6mr35rCJZzawcWFpEERPmfCJ1VlZdsVmpql1apbzR92FoIly7SIr0PS+oopA0pHOjfRI5ULYP5GuLC/FXC6pyJoBp+o52KqUEkjQ2/rBx3xjnYFngBJg6jg8454=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764102304; c=relaxed/simple;
	bh=FyCIjTOooz0ypkd5y98rjNGYVW5CU746WBmZS8C6zDc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cyrpdTceItbytDa5ff06V1zfkdYmQPniZRyC3lxm4NrraYaDR1qLR0LZWVoYQCGxDU7Z9dPIICiw6iRz5/U5jWdECuHbghw8n55m+5zEaFxTUvu3xfyJUiESa6+Ny9pc4QhpKjLHr4HLbW5x7gjK8UivYDtgeSjZrf9xbSPv5Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9489c833d89so416473839f.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 12:25:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764102302; x=1764707102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QwqtT97VXJ1Jdv1AEvqjGwOixunV0nYgH9yaTaPDIqw=;
        b=W++cR14ltpYBMTZAeH6srIJYldyqEFtS6mFBRp5/FwihsC6GwYJvXJ4r+NYFcfz10C
         QHG9o3sMCx/bLHnZV2jyOh+R6nBf1iKjqNTnb11DHUMt6JhUoJwsP2t779uIiLoPdRYD
         wajuHeqBTZLsREsli7JvLrA744qK0a40g8XXdRq0ZwYhCj0pBCNu/GCBzPezKsxlYuTf
         6rvLziTjiwxHgE9CdR6vo7g+05Si442trQAeShXGed1GIAG+h4nmFi8gnTH26MnxVRP2
         n+DIO+W+x2ge067ElFVEEr4juWpwrvtlnSPqIR4a1AX4XDFt7BwxXJxibhwhmRySyTIN
         ez4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbFoN5BSoQFp61IHDzV/8kOqZ4cWpkEmsiD0lr1Dru9kZ3IO2WViR5Y9+czHYJ4JFiqD0sPpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOqeYOGrymysCGYguX8enRZUGbmqQwbeoC4LRpQWiZyNA2Zjjm
	3tr75/2nzeaZIubb4jHf0DYJzC04AyOaG8MHVm2hP9n3ZP6vBtu+kZRnP6mJpnynAbVrEzhvkjp
	K/Z45s6hMHyv+YDfemC2J7qTenh3zAtQakeRrCdou4uIpaZcQ4E0nlf03eUo=
X-Google-Smtp-Source: AGHT+IGoKfilXKdpo5aY+wyHCrTxR0oR+v76GUnIIrfRVx/lqgN9yH13G9VR/l1X+PAVqEOdiYii7PAK3yhXfCbLs+JbEOfswvI9
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2162:b0:433:30e0:6f68 with SMTP id
 e9e14a558f8ab-435b8eb45c3mr134270635ab.24.1764102302076; Tue, 25 Nov 2025
 12:25:02 -0800 (PST)
Date: Tue, 25 Nov 2025 12:25:02 -0800
In-Reply-To: <38778a8e-ddd2-44a6-8d45-d6871de34f30@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6926109e.a70a0220.d98e3.00b7.GAE@google.com>
Subject: Re: [syzbot] [batman?] KMSAN: uninit-value in skb_clone
From: syzbot <syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ssranevjti@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com
Tested-by: syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com

Tested on:

commit:         30f09200 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169da612580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1db0fea040c2a9f
dashboard link: https://syzkaller.appspot.com/bug?extid=2fa344348a579b779e05
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1768f8b4580000

Note: testing is done by a robot and is best-effort only.

