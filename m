Return-Path: <netdev+bounces-204313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E32EAFA0E7
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 18:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51DC1C20F59
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3DD20B7EC;
	Sat,  5 Jul 2025 16:02:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17948209F38
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751731326; cv=none; b=KN6B0iN0WDUuDZVhV1h2jM2nGD1cs5GuHBneF2h0pCtNEmd7IB1rJCcLgC+DsH8zITzDnShdiw0y+ADCaXKQRNS13M6CswGwlXp6gRhVUYb3EzIS2mxxiU6wAx7J+E6P2odjsH5ywHbYSPyK35bXA4YYEC4WTGPfY0v03Mn2rSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751731326; c=relaxed/simple;
	bh=dMygeV5uoVdCI7txzJ9X0V/8gCPQmtr4XJBXZjoRBX4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qjFhL356hO9nwn/KEbi+Rw669Bf4DuTQBNXj1lU5TPb9K1XyKRk0BngCDikNHi8C1ZLQpXNdFLnQ2Df0EIwqMV6EGjuY7twckFmVSgt5nsc7xR/UhNvsFvZ8+Jab8Smn7eCHdUINDSuvYn+Lc8+pTWQkLr/HXECSEnMDRe+ckp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e0548d7e86so11182655ab.0
        for <netdev@vger.kernel.org>; Sat, 05 Jul 2025 09:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751731324; x=1752336124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZ39e8xu9v6JpQ+2Z+vLYy6QZmlP+uXlVIaEn31Hh7g=;
        b=HyF0YMddHDsQZptYAHFU9Wr3IyyByqGvC8R4M5+32NbvZKrhnDlCA9esLzcwszvWJt
         /Bm4Y4e5raJpqFGMU6Okh0MdJA1kCPCwW0FVM3FmQTSmxl8cHUm14TNVy/W6fZbxzgf6
         TwewNoRIh/t7gfQP1SjoD+FwsfZFHJVBfhnAUswoIxyCTrleVkPYtzAkJZhpg7+nNMXQ
         EICjeBI9/yy6RFvehzKF90uEwyoMbOlqQIkN/I53JYiCXmnJN9KkuO5NLiGo1/Xg6/HS
         hCfUEFhUPikxQ9NAPvD0OaNgAkBoYgSqkqPq2OF+DZq8FJea0U8y9RlbvuuYk8LWGXP+
         F4Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWYXLWbOeW6CDGYCClLDkL8hGAJKYIKYxW+ct0JnCghcMUU/RTIIW0YySp+Gj5CqqcyhpufNZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygEGHcG8b39Yvmb0cbaqPP9WpSLVHwUrAOJpeO/FbFymf6wchP
	qTOZraKkmOQBVBi1MmbSO3Bgx3FHGpMfPwnLGoViBoAGtqpi2caSiBLbpHHLaUN1YHZfLoSkQOc
	ggu5+tfyQvhBBxAk1xDN53jKSTYdS+Q24m+2FqpS0dBxaaZp6+LfotizNanM=
X-Google-Smtp-Source: AGHT+IFi8tBZCujWe9RK7k1QOcV+G5qEXxaVcUaY+MeQA3ot4H19x1QqbDxj186yZdLFiJOHIA0EirwQgzraSfb+lrOOnbAkPyxi
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ec:b0:3dd:f948:8539 with SMTP id
 e9e14a558f8ab-3e136ea4c01mr55847905ab.2.1751731324130; Sat, 05 Jul 2025
 09:02:04 -0700 (PDT)
Date: Sat, 05 Jul 2025 09:02:04 -0700
In-Reply-To: <68649190.a70a0220.3b7e22.20e8.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68694c7c.a00a0220.c7b3.0042.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check
From: syzbot <syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	paul.chaignon@gmail.com, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 0df1a55afa832f463f9ad68ddc5de92230f1bc8a
Author: Paul Chaignon <paul.chaignon@gmail.com>
Date:   Tue Jul 1 18:36:15 2025 +0000

    bpf: Warn on internal verifier errors

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1693cf70580000
start commit:   cce3fee729ee selftests/bpf: Enable dynptr/test_probe_read_..
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1593cf70580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1193cf70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
dashboard link: https://syzkaller.appspot.com/bug?extid=c711ce17dd78e5d4fdcf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1594e48c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1159388c580000

Reported-by: syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com
Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

