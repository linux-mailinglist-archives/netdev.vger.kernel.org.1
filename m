Return-Path: <netdev+bounces-72790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B95A85997C
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 22:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA35B20C89
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 21:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F58174281;
	Sun, 18 Feb 2024 21:14:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F5573199
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708290845; cv=none; b=h3aZMxYEipb0QTHJPSYH7cVeZ9FXsiHCgejPm3IaTqbhxhAlXyxvbpR8IQFSXqe6/ursEZ9Kjo6lQG5zD6brWVc6C9bpS/9BakQG5MiHoBewdYuYqug9HQjPkaefY1corQb0pFcerlDCxYOtL/3qce5QU/Ajw3H+1fDU7QwEA8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708290845; c=relaxed/simple;
	bh=kZKNHvPA11XnHmCiDD8vic43Nev9ie+34HsK0oj3sLY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XqdcssXDCjH1IbTypETDPfoO5/nJVM59bUjF3HQ2w3pjZvpWqGtm7lrplFsC8EYkdqmzgFRtBv0DT4Lfw6dm4WN8AW0i5asScR+3rjjUUqJIHdPFBm6WsKkmHn/1aXDOWm6574o68kiG5zGaQEf6E7hHG86S85s4MHuFaDVPXhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3652275e581so6325125ab.3
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 13:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708290843; x=1708895643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+QKk+dnjYUlsWlqOfdeg473+HgIRSWoNZHq9ASOOGE=;
        b=X8/3GJi0btjsdPlYLF3qOjXxDXJvfRLy00DXRIzyjAalS/X1/Kx3NCD/IxZeVpuBga
         XkcXprIQ1s+ffSExtoPELTkhvzC/ZZKnbYoQ6+sVIs22yBkXvsMZlItzFB0t75MeBD0m
         T96IQN7j71syzgGJGqKhORV3BdwBULw10vaXBTiOm8DmxhEdkH2RSrVLgfdj6CWrntk6
         lAvvhxRIUvsT4H3e64Kl4tk8f/GpuvqjRX9PBvQFMlZdQIpunczg31p/jeaq2Xd4xG40
         /4MyOwhbag5nXyCmtQFjvihiqiUZUfy4dK1KOEmmyCkWTv9cUsbN2WQ5za0h/sTO/5Ll
         Qahg==
X-Forwarded-Encrypted: i=1; AJvYcCU/WfeNu3Wz/YNhMA65342C8m4IyQjX5V+/DuiGzmFiVn/4DgdkKKWx6PaSlUbsCAt8w0zg7AWr+Q/zKHq/sFjw5VvYD6Ng
X-Gm-Message-State: AOJu0YxwTCU7n+QzeiMOVQC6X4O1xkF9u3bIqnasvW2gBEueFh8WAohx
	NFe79RCSIK2OjJwkcGbcNaiA7tpPMGMu6RL7iGMqHl7soHAZOYhDh87dHYfy1eq7Lt2vIfkCVUk
	0iegzKaHpKxwhlSWlw0fEs8AHRKpD5l97YlhBW4LQ0ky0Lz6D9y4S59s=
X-Google-Smtp-Source: AGHT+IHXXsnVa+VrZTzUk5qQJP3UU//iE7Igeu4d6qEj8MhJYgk6g5miVd/1JhBsNQlmEAhjFxG6woGnR720lMPI1FVdBB49aEz0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8b:b0:365:177f:6db6 with SMTP id
 h11-20020a056e021d8b00b00365177f6db6mr503872ila.3.1708290843049; Sun, 18 Feb
 2024 13:14:03 -0800 (PST)
Date: Sun, 18 Feb 2024 13:14:03 -0800
In-Reply-To: <20240218204802.51284-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df8ce50611ae74ad@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in unix_stream_sendmsg
From: syzbot <syzbot+ecab4d36f920c3574bf9@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ecab4d36f920c3574bf9@syzkaller.appspotmail.com

Tested on:

commit:         25236c91 af_unix: Fix task hung while purging oob_skb ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=171f722c180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c368c5806a3ee9fc
dashboard link: https://syzkaller.appspot.com/bug?extid=ecab4d36f920c3574bf9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12e5c872180000

Note: testing is done by a robot and is best-effort only.

