Return-Path: <netdev+bounces-181290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E93A844B2
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 15:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7863D1895131
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 13:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256CD28A406;
	Thu, 10 Apr 2025 13:22:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D622857E6
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291326; cv=none; b=Qkl8i4xVNhUOe0d9c1gityVTA8VceV7ffYv3wngPJB3mWGyavXpAlbnFnRfUYTKt/a1H42jPHl56P0FRI/oXRtk9+qgG+jf0PqwLvb43pLgocksvjkliDn92HUNS0emIebPAjoewzwFNznlNk5vKGpPmsGNDwzYDJRn6tHuS0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291326; c=relaxed/simple;
	bh=TxpinXIVox58balXQ9mjFYVf5poJ3SM1tyO588NrTqc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dKg75qj2x970ww5w+hgAgjl19+0CAyHBmYTu+w2xm6A4O5ggcmb/N4x1rJoAn8xn54zLTFFs3W4CctzuKB/1FGjhp5ZJMAwtHVM5gjjchdL93nZVOaMNwUuxgkNRkJGRD3oodPKAfQkN8kXQkzOPG9YBE3QJtMycI6BMRZ6q7hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85b4ee2e69bso86301139f.2
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 06:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744291323; x=1744896123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b72eM9eMZlRKFXr+o0KTa33dW1ftqcPwLSRLp9ZZfV0=;
        b=D8AxWaIN/aetBY66/Fq9aFBkkTtpCcrEqFZV7ipSUwI4vfbUlGw8BkL4YTuXMm65zy
         OOiopm3k17ydMDHSxx90qmW9bmfSEMXUFL1kW6DNxpV+Z2WvnvujbOerdSXmNLwkk5K7
         9BuhyoVTfCf8BpUR9A4RNNp43AujHVQ6ubacByKIH/9YZI7UlA1NmgRUPQPanAKjFWbo
         3hPTF9RyH1UwEwoY/GXFTc10Yis9tOaiHwtudwPiM8SID0lzv93d9grJRiUMfg1/Y4V+
         Fy3ILpKH5h026wEc17/MAjIl1wRhm1zqvoxYiZFK60Wp81Lg9Zxox6RjjZRjKcVcU/O/
         0kPw==
X-Forwarded-Encrypted: i=1; AJvYcCXO5GePCgjDlzd6YYAtNora9FL/tWpS2SovjKVcsY/k1haPaKKFrkX2gbZXr/yfg7+hHgBPSPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlGEA2vkN/sZPT9onoYqgvEcrB82OYlRIllAeUqn0Zgde7rgY
	seJIaGm8UgQ2sTEnynBEincadNjGwEIXvw8jsGT0LtN40jFcSGqxLG/2UIO3B0WAe4qD/6Gy94A
	8d0/4GzQTzBqghK5kPavZdO9fxzz1O5+ln99DepEqjU1ETtuYYWedPyM=
X-Google-Smtp-Source: AGHT+IGU1BugYKtYSCi9Fl/9FsIbPPTncwjselRA4wXdisDf7Q5xTu9+qCpgT81N6WVOO6wRNToO1AvfSg+/VmOV+eylCgHxBo7S
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f81:b0:3cf:b87b:8fd4 with SMTP id
 e9e14a558f8ab-3d7e47747a0mr30941585ab.15.1744291323816; Thu, 10 Apr 2025
 06:22:03 -0700 (PDT)
Date: Thu, 10 Apr 2025 06:22:03 -0700
In-Reply-To: <20250410124315.1201290-1-memxor@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f7c5fb.050a0220.355867.0003.GAE@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in __queue_map_get
From: syzbot <syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	netdev@vger.kernel.org, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for batadv0 to become free. Usage count = 3


Tested on:

commit:         e403941b bpf: Convert ringbuf.c to rqspinlock
git tree:       https://github.com/kkdwivedi/linux.git res-lock-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1524f23f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea2b297a0891c87e
dashboard link: https://syzkaller.appspot.com/bug?extid=8bdfc2c53fb2b63e1871
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

