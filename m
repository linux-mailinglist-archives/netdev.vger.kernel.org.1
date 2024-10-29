Return-Path: <netdev+bounces-140132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FA19B551C
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 22:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C591C2291E
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982AB208991;
	Tue, 29 Oct 2024 21:33:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A306E207A0B
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730237585; cv=none; b=lH2FolNqGejZI4fRVmK4XPQ/REm2kUeDknm4GYjFQtFD72y0DW3zp+VQMQCbemcWPgYeImCDsBZNPp8sYl6PiK9VqRVScEPGza3S8/pA93kA6ZyFnbVOY5vYgNdxDL1XfQ9TnmOLlzGJCyOapel7g1HrbcOExAzniL8xRhznXXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730237585; c=relaxed/simple;
	bh=VeJvu9Pkvz0Q1axoDH8qBwoYMovix4Mi5VeqyHoqBSw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=efHZNBUX6FIsxu9LgKnTGdhdEkM5t6yBsYsNwKEIXRNuFBdQWwGOmROWY11CGJg0Uv7hK++v8TqQ1WURnashgw48CecSWXlxPyQr6nts2nrz+/oxxg7LscPGiEtG5fuw6ydeCyVXrXFMaZwztAWIeEVziJDrzoLADGvGPfPoSmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a4ed20b313so35976355ab.1
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 14:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730237582; x=1730842382;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52dNbTblZKRoHsNeKZM9928ah3VMeTxHPdRndprncPA=;
        b=KOgeqjI25XO6HBRh1iOJ/fk4GA3lKz1h0t5ELreUpWTLTfc+QkWDhUF/Wo3k0Mih1d
         1naMEgTBltZJYFlFVAvfck78Bd8pguSu07NbPO31V6+CVlk9GHS3R7mTcDNtzm1Rxs2F
         d5msaIJWS3+p+dsYILmYBIzdELYu46UM1attAcSWuAJuj1xtnK++bczmbpHwW/zck8Cs
         ejyXaDdKtm/gorba7yrGj6T2eazebXlSNjBBqu3KZOQBEBwV1xUn7o9J/8rl7bPSJqJo
         GMB5kNtJxJWzlAStjbtaSg6H/3p9JQStO820v6Z/F7RNyQ8hvGYhv9DqVvVOIrGzbIzX
         V3Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXHXa+ivqCBExYQZluvIggnfFEUTjof5zHGUzWPzMTE2DuFYFrL5TWziO46ehE9pRqA/sLqTkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJwyRhPoiB9Stwc85/cfQDQ/7TU8ksxDHDPXNgEGUaTVDLb3sH
	yzZ3ZpWRBBLy+xMtgmopoxLgPv2ioQJbvKmTjBJfT1LCB3OkcssuEHUuF3TxRbJexhoglYtTkPi
	tlXt86O6bZcRG+fo64PawUKYWArukX1T09qcc3+FGG9r/Sz6xA4olJnU=
X-Google-Smtp-Source: AGHT+IGx9vSpZDlzRqdfZWOjJisS50sBONY+503w7BRzuvqYoBx5Fv8wyyTm6o9zRjIw5Bp7ZuYBCqe+zuqWS3AlEXvMAI4l4vG4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2188:b0:3a4:ea4f:ac9e with SMTP id
 e9e14a558f8ab-3a4ed30fef7mr128699265ab.26.1730237582732; Tue, 29 Oct 2024
 14:33:02 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:33:02 -0700
In-Reply-To: <8734ked3op.fsf@toke.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6721548e.050a0220.24951d.0077.GAE@google.com>
Subject: Re: [syzbot] [net?] BUG: Bad page state in bpf_test_run_xdp_live
From: syzbot <syzbot+d121e098da06af416d23@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, davem@davemloft.net, edumazet@google.com, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d121e098da06af416d23@syzkaller.appspotmail.com
Tested-by: syzbot+d121e098da06af416d23@syzkaller.appspotmail.com

Tested on:

commit:         b6260787 Merge branch 'net-phylink-simplify-sfp-phy-at..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=177d4540580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a787ccf76ca91592
dashboard link: https://syzkaller.appspot.com/bug?extid=d121e098da06af416d23
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ad1f57980000

Note: testing is done by a robot and is best-effort only.

