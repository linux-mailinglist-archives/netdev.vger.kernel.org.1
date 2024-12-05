Return-Path: <netdev+bounces-149501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7336F9E5D70
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 18:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503EF161760
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAF6221465;
	Thu,  5 Dec 2024 17:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9300921A42B
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420428; cv=none; b=pH7sdwHZMxdgScjVVk43rbM8maENdNonjAoxxHopv7KbV4qumHEfkUrhSUM1b+3o5FYu/uVyO9Ll171OzMcfPS6c00CvE8BU4N8Og2Yq4K+r7cW6si2CDa60ek1e8VoXh5+1V6kUn0/0SOdPKzE0kHp3UJgsDgIFhOaccbEIg5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420428; c=relaxed/simple;
	bh=ckqNK1kFj0hOrtGRecbfTqUnXzQvUTv259nme0vqwJ0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qshNHtXQSfzGT/YgRO/6crH2mzYZZLQLkn9k+ekq8KQNzPrVo5k9SBhfJJSphJntZeiGrYaeh748NVtrPOtL0sJH9QaYRkQwLqcNMeJA00RZj27doZaVjxfWGDTQ7XqYFsioz1zlG5BF3FtBCT2uP6010Sq/4dmkCfGwgHes8eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a77a0ca771so13321885ab.0
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 09:40:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733420425; x=1734025225;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nai+Q+yfGAvS8Ho7NPZXJwCDRmVEaZXI5r28mNwpuR8=;
        b=IG8bAQ1W05QreoUzZ01/mDfM+amk6FfY9SwQkhRX6KgS1oNDm0KABM3KhdPziVZNrM
         PKrgHPAKNWx7XG3UicU/x9KO/GWaoyw0Zibi9WGY5cRB+iHFNJIdaPemSzkYRKkQHBVp
         QdpWU5d/QXlhAI0+ZrOmBjfPs9Br3kL9rIHHh9OLgmKlDgvH+kHI6SD1Fohp6ZQIaDD8
         AE7si82sVfJ2J91TNGOQ9bsu/jUUE5Cf8BUeAt8wo02YfVVuYEJ2sfopNjD02BVt/A+V
         kC8lsGAwRgHhd3Sy7gm7whnc5XFH6iG8uVb+k7Rs0j5aYaB2dBX48dmG3kwoIm3GNX/c
         En7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+w0XjQeMrMfd1nQ7vFQAV7O/BkISyOfbWaYScPjKPZDVSkgRJKRPDHS9KYbxnzf7SCWRtptE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXH1RzdKQgA7me8RF5XaitWMPKc5KU+cG04kvPiNcldrz6Ckej
	10n3YWdbg6/BLVSH8fNsxe5mliD9tIyNxTYwlgRHTHqjgX4dUxHn45JUGmlDr1tvxIGyHjOn5vM
	EFFUfiHjsMzgijHDwqzbrK6+ZtmoBE6ElE6KULgHzlXy/zRrbo3UoK3M=
X-Google-Smtp-Source: AGHT+IFNSNJODWIXbQ394i760sPr6Swl9ckSzqmuHfxCrUVLJz0zVWAEEbVAdJHq/dCMhu2HIigm8ONaBH4FXzvnb8+lzMbUAPaK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1448:b0:3a7:e0e6:65a5 with SMTP id
 e9e14a558f8ab-3a811d94896mr2864845ab.6.1733420425764; Thu, 05 Dec 2024
 09:40:25 -0800 (PST)
Date: Thu, 05 Dec 2024 09:40:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6751e589.050a0220.b4160.01de.GAE@google.com>
Subject: [syzbot] Monthly can report (Dec 2024)
From: syzbot <syzbot+listef3aa534c94f9b108626@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello can maintainers/developers,

This is a 31-day syzbot report for the can subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/can

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 53 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 11504   Yes   WARNING: refcount bug in j1939_session_put
                  https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
<2> 3437    Yes   WARNING: refcount bug in j1939_xtp_rx_cts
                  https://syzkaller.appspot.com/bug?extid=5a1281566cc25c9881e0
<3> 671     Yes   WARNING: refcount bug in get_taint (2)
                  https://syzkaller.appspot.com/bug?extid=72d3b151aacf9fa74455

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

