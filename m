Return-Path: <netdev+bounces-152135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761739F2D3B
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 10:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F23166924
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0255202F64;
	Mon, 16 Dec 2024 09:45:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B09202C2A
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342326; cv=none; b=cvQMog0A9S49vAWF8842SjRvRQd/EuwUL1JZ4mtYDuFRkVuntRL3+n/LVNfGH6aP5I4LOdD6TGqz5/7cCG44Kie08FyD0r8H4+2yxvCPIgdqvzDtMOlJTsirlglRtvSmSpGbqLhyIu+IRlRwJQwBFMUS5D+pNydZ2QkyRVO2fZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342326; c=relaxed/simple;
	bh=Q6h/nO8TuVO7jzDEwFHGTDo66cCKemGOAtYAERJc79k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=vCYQ1s2ni5IbnFKVZQ88cm9ip9567lSpftO0F9t8u4IH+0kTMhiPwAkLduWKYKym4MPzjmDWx3aLjW+dGUoazCrzQ3vlfCVgM8/qizLEB7fDuqdmVW4HU57u4T5LPpIIqMnH2nL4VoNxrrV/rZT7Xr9FBw6sqxaS01coOlcfvTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7e0d7b804so39418375ab.0
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 01:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734342324; x=1734947124;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ubWKXdrA/E68ihQoeoxqOPqTUE0dKIAj5I7TAzTO6Q=;
        b=NkUjdA152Z/W+WYqVNbUyXTTNNY9DHZNPO18riIdS8MEmRKgjtSbhWgH7zzYpuSJ6Q
         nK54Ftfam2CtQ5rFwBRQqXki0GBp5k7TffIXPEYp4qvAyhkWl5jPLFqRaiwLIlP8I+2y
         ealtdrQNsJPZXHcrygHpZexA0r1Lk8fUSwpUGB/hWsY9fjwzgPaLetcdIg9BCqJpT4Z9
         +GySrekJrXhOEy556PGxsbvwcawmKY8vwMZnK4aQQIwPGwpbGnymlp8en7MxTIiR7reT
         AZnVpLMOactxNGkfF13SGjhGnI2/hRG+4c8p9Ch5rezyy75/TrnaTw89Cb21LNlkiP/v
         ie4g==
X-Forwarded-Encrypted: i=1; AJvYcCVBQyTi8Kc8eVNSbePZJq77qJU9SJhLhQ6QU5DvWEXCbkdGn4ebFlOUQN3FLo8EdFciW5NPUHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAGoZVU+46DO4Xs9kGdZMSelkeknnzIwP5Z2JvbSzlQ6iEEoB5
	ZgbBHXtahFXiUxpxP487D6KW1MPiHc8g64NNOzpSey5kfHQFMtKTWum/YwcMJcjx6duOMxuXFdH
	PhEXV9S+dgr8+ZOlBd7p4zGWr6ZEqsWWxo7mpQdOphRwoTyi+WU+TnNc=
X-Google-Smtp-Source: AGHT+IGsz6VRN5TlLoO2HiHFgqVGp7Yd54JUrPjF7PyBaU8jZarOsl5vZLipEtYxf2dUNO7xDg7cwQ4MC+qwTuibeJ/cJKhj7l1g
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188d:b0:3a7:e286:a56b with SMTP id
 e9e14a558f8ab-3aff6213bf9mr125576895ab.5.1734342323845; Mon, 16 Dec 2024
 01:45:23 -0800 (PST)
Date: Mon, 16 Dec 2024 01:45:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675ff6b3.050a0220.37aaf.0127.GAE@google.com>
Subject: [syzbot] Monthly hams report (Dec 2024)
From: syzbot <syzbot+lista1101e5680fc7c361c62@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 1 new issues were detected and 1 were fixed.
In total, 7 issues are still open and 36 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2218    Yes   WARNING: refcount bug in ax25_release (3)
                  https://syzkaller.appspot.com/bug?extid=33841dc6aa3e1d86b78a
<2> 453     Yes   KMSAN: uninit-value in ax25cmp (3)
                  https://syzkaller.appspot.com/bug?extid=74161d266475935e9c5d
<3> 44      No    possible deadlock in serial8250_handle_irq
                  https://syzkaller.appspot.com/bug?extid=5fd749c74105b0e1b302
<4> 44      No    KASAN: slab-use-after-free Read in rose_get_neigh
                  https://syzkaller.appspot.com/bug?extid=e04e2c007ba2c80476cb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

