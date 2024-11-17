Return-Path: <netdev+bounces-145643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BF59D042D
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 15:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48FB71F216BC
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1015F1D90D1;
	Sun, 17 Nov 2024 14:03:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FB21922E5
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731852186; cv=none; b=rXIib6N8wEHUTywc5tVyd3gn2+g3FcgsV9HIE4XyN4DSdHCEjDmNlYHrmq/5QK/ZkNuP2VINhzUbhTOtCGPqPBUNmz898/+KdQiqIpEVvZqzR2OZHP4Ji9zL0diSbmANSvg2LcOl8A2cTPNr9mlO5p+lO/uLNa6eQzZ74shWXgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731852186; c=relaxed/simple;
	bh=t2uHVMYp7iXp+o0/F+cYkAZoh2d2psBzk/GeopJjg0M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PB8ZDsxd68uKqC55qPXAgSfIAx0jIeqVsoG1xsyNl4B4uYC7f7ho+7DVZekJjKrsQfRCRxNmnnIBkchuJbG5NPWvGriKXOKGwAxhjqBbfU6ZSAtNzk7HlMXDuX65RIAwOoyczSkiD0YJAL3efxVVqax+c+mWjkv4Qy893Qyoi9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7191aa79cso25187115ab.1
        for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 06:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731852183; x=1732456983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUssD4OF1/0W4ulVXXYWglqzpn1NTprdCx53eur2zFw=;
        b=Tk7YQG7LqQ17AnYw0Z/RcO2vB+b8vbWb28ZzdwQt8crJK1OkiYhthO2lw1wdV35YiT
         t8ZWiH8TFdg7lY9sPcRMJ+LJsNSLESQKCD2OGy7LZNzMUzCBN+c8QEdA67aZZmojaWK2
         ewX768cjLSww5kZkgOcHVeuWhHEx6i2YWAd7mjn3djg+ZBtlKoFhPTfdYpiOe2rMvJ6u
         /8dqHkfxPurntkDQYeBnQ8JpLEvW2e5O299Thn9hCAnt3+PAAB0fT0wlrIs5oSpogQEb
         2rD3LKcpkwTBiXQzIFfWrT2Kr+++uJ6mXjMDw7C04hKtub0dgTwY63XSr+XeDqF4AS6k
         0cKg==
X-Forwarded-Encrypted: i=1; AJvYcCWAr0jQow/3zoolCqCcJcR25XrvfsiEU9hXTcLcfe6xwYzxURYUIw5OxaPr6bqGIN9Q3a/KoM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz817sWsgSAVeP5krURYahFle3clQEvbuCPGlnqhWBWQWXWoKew
	MHy39EpwCvP8cw17uwq+tkc2E3Gdef0KQMZiGNssaUzzwr+pJgupjZZD/BRzG8AUarW3dixTMsg
	CbLoHPkZGcY6HfzWogvHL8TOOxGFQ9aNTeymPUDKIHtsjzbPDBfqnSrQ=
X-Google-Smtp-Source: AGHT+IGpPscsTKcEqBtvy667IuN2y2ojokY1wvLLrtmso7y8ucb+MsA5Aa7h+kCOP7Ws8bgrOxutXJzm1W2hGXSN+35UuaRYEzFV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaf:b0:3a6:aa64:dc9 with SMTP id
 e9e14a558f8ab-3a74802f569mr80874525ab.13.1731852183560; Sun, 17 Nov 2024
 06:03:03 -0800 (PST)
Date: Sun, 17 Nov 2024 06:03:03 -0800
In-Reply-To: <0000000000006477b305f2b48b58@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6739f797.050a0220.87769.000f.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in rfcomm_dlc_exists
From: syzbot <syzbot+b69a625d06e8ece26415@syzkaller.appspotmail.com>
To: axboe@kernel.dk, davem@davemloft.net, edumazet@google.com, 
	hdanton@sina.com, johan.hedberg@gmail.com, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	yangyingliang@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 08d1914293dae38350b8088980e59fbc699a72fe
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Mon Sep 30 17:26:21 2024 +0000

    Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11bcdb5f980000
start commit:   5847c9777c30 Merge tag 'cgroup-for-6.8-rc7-fixes' of git:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=70429b75d4a1a401
dashboard link: https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1097b049180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168a5bde180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

