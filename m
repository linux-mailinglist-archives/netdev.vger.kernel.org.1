Return-Path: <netdev+bounces-200121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A498AE3419
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 06:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F0C188A597
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 04:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032001C3C14;
	Mon, 23 Jun 2025 04:00:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743DE1C3BFC
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750651204; cv=none; b=Nm3zfaWrL0jrh2+pNs0azMLpNa1G5KZwmb5AlFVCXBpt1fVL1jnROmXJsTadCvZkZVL2k1ru0970C2eoj8n2Ua90RsLkcK3vX7QdWIdUs/kLMkDCQOP0CFMG5Pi7Kv74jz7AyC6dLO4gQGBNcj2EI0p9UEz8HK8G2TZNywqVIzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750651204; c=relaxed/simple;
	bh=pPylR7SsFpH7/9lpOqaCWDfdB08fmgj3mQjIVObOh7M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QoZFpakhm+EQSdnvFlOoBoiZWkOXT55WtKWp8BCKhNLnwXBgucjyTdUE62Jk4Wnq2nlW5Pwy/8TNFrIJ8GE21ShV6zja93KuCSlmznlx3X8OReMoTMCBi85mpWaY783ebLyxvMGFYFLeYiw5DzH1kruRc0YkRBCAl1PU8+C239k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddc6d66787so55293085ab.3
        for <netdev@vger.kernel.org>; Sun, 22 Jun 2025 21:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750651202; x=1751256002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tp5owW5nwFpu5Jnkrm8smrXMQm3hRvUBzgn0oCSlZLE=;
        b=Hf/EW6eWhh+hBqDdcLco393RfO2byfTS7mJyMu4Q8bx2arMcz0JLrKl46M3CpHb+OA
         DMW1oG/7QY/a8dh6IZDHtoHQ8dhjQIhvNQnhqV3oOsl7ZqwEeLRL6k9P4Xz7kXgE1ivj
         b1dPo3xB+boCv4FpIAUHJMtrmSH7xR2mMKhf/gtfaY/GFQPVelz0VjIdNDra1VD2gkkz
         MKhwBANLq14cxHTMbVtvwW1027fkbmhfEoiaDhnxu3SomB15U5irXCwSW8tTJTegIKBH
         sAB4o7KeVSrZ/oMhAbdD7/xqbyv2FUc//cmfoP+3k6TaDfa4zG9W21fBawQnRnwvQmPj
         Lyag==
X-Forwarded-Encrypted: i=1; AJvYcCVMfuq2nXY93ueXL634ONp7WPUUMdGESJd3KL/LrIjjUEgQ/TGrqcKoikXoLbG9WepUrOnIbYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJDBAqzUv9Z+A0F6s11ip5LCXyaU4G/hdPFiHPoQMrOZe5drUc
	6HUI0K7ExxPUUUGC7wEtYzmqVpDHxMfA6rdWSzOzYFazLVVJ/PCA0WGUamYatUfaWT/Bb5mnCxk
	mP2AuEZr6KUgCrbq9ARrn6+nn2WHs22+PR/Y9biYi5jNO3rJgZIUtKtj5uj4=
X-Google-Smtp-Source: AGHT+IGzI3eiBVL0NMFR35KWAlUrxUfo0LV4hyzVNWz6hxCoaIHFjj6zXT0kapv92iCI4EFb+pZdLBWvpe4EvqMzAC+zavsATS4M
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:308f:b0:3dc:8667:3426 with SMTP id
 e9e14a558f8ab-3de38cca231mr119111035ab.17.1750651202731; Sun, 22 Jun 2025
 21:00:02 -0700 (PDT)
Date: Sun, 22 Jun 2025 21:00:02 -0700
In-Reply-To: <6834671a.a70a0220.253bc2.0098.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6858d142.a00a0220.2e5631.0004.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in __del_gendisk
From: syzbot <syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, hdanton@sina.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ming.lei@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Oct 25 00:37:20 2024 +0000

    block: model freeze & enter queue as lock for supporting lockdep

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1024db0c580000
start commit:   e0fca6f2cebf net: mana: Record doorbell physical address i..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1224db0c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1424db0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d11f52d3049c3790
dashboard link: https://syzkaller.appspot.com/bug?extid=2e9e529ac0b319316453
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132f8dd4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14aac182580000

Reported-by: syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com
Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

