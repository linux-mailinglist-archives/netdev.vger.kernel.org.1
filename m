Return-Path: <netdev+bounces-92338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592578B6B27
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 09:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1121E1F2280E
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 07:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D602C184;
	Tue, 30 Apr 2024 07:11:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16A2199AD
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461084; cv=none; b=jpfU6A7OxlHeiIbOHbysJXOYosgWCOG/0RKFTaa4hPfRF3cZKJQj0jDxyCsRbRImmTS8P3esy5tziiRm79S9u1tblLbD5vivasJ8tFygM+SEFmALLrMkrj9Ya/rB0xJTk+hKma9MTU/FGjzK87RzdTktUNumQIIXxhSPyR9MxQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461084; c=relaxed/simple;
	bh=DfT3eej2m6KOPnni9bTCDfHoXF4S4yXSjrNpRAl+KZk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DpZ/pGfJIMqxBdLNve7EPNh0+w5HhuH1cJRJpYJ6g5wIjxf/AAGznA6346GmM9Q6weYOUulqdWB3VURTmjtWZYRveQ4Rms6lkV19LEYDQl0Cwuqy1uft4RD7yIYzS7lRe3Slc6SNnLtZa/24vRTG88tSpgZg5nZq30L1DZJkKwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36b3c9c65d7so51659905ab.3
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 00:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714461082; x=1715065882;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hB5JyjSp0fRxJ94Xv9k9vT1D7hNT4E6Sz9ZWtEnTjcc=;
        b=MocvMRg/OB3kwbVN3mrcLU3Tz1n8hb+NcbAUlgNXNgTm4i9U21UXS44OC2soX/63qx
         Be/ModekpHSXOjZBp26yPw1EXG1rX1CvOMhvJxgKMH1pO7H2WT/WqZ+znbL/VZbQLdX/
         ECPZMMRwG+TiLHCRycpUyyH1Ts0Pc7hL5RbRsMnkfZhjvoor3DDK/51yckhgELwwKCJE
         q8NhtaOj8yFwygsbwAV4pK1RmxDVlM8y9dljSxZbuZfYAzx1yK948Y/LWN107RJO8Fg4
         bDxRTgGBD772b3riKbBIztMw5m8acAd6LzUC8EhvuaInTrtm71Dc/X1VW1+bfuuHH/1i
         aDew==
X-Forwarded-Encrypted: i=1; AJvYcCVwQ2H0s8t2HUxCuUvgDeYZ88SiPX81btGTS2lrb/MNGfY5br431SerER3y7eF4No4GZtF1ytMfORQ89IuMfAFR5+rdH9dH
X-Gm-Message-State: AOJu0YwIGjVsn7OSRuw+4TspZtE8lUI+lVJwPMb/xZXOKx59PD4J3GlA
	jQXt4P1txgR33qI0R6XslDYRucjiHEebSlJ+vzFfhoGRwodUWINSypHMAqr1+7qzsI+tRicpAjj
	Fs76gTJLCVZmEVHvb85SpTb1pUJ0YE7QpUjMv5bTcdQQo6DS0xFoVnWE=
X-Google-Smtp-Source: AGHT+IHsjGZ2+aJHmeRDbujWXxotx2yTRH3uY3yuAJQPBFmBl9X2WClPP8lQKMhRmpm9bwcj4RZOK7CPxPpz6+j107mRFPLkv/CL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0b:b0:36c:5bd2:6b92 with SMTP id
 i11-20020a056e021d0b00b0036c5bd26b92mr7923ila.0.1714461082103; Tue, 30 Apr
 2024 00:11:22 -0700 (PDT)
Date: Tue, 30 Apr 2024 00:11:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7c09706174b1395@google.com>
Subject: [syzbot] Monthly net report (Apr 2024)
From: syzbot <syzbot+listd6cd52ac5782bd942fe3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 10 new issues were detected and 23 were fixed.
In total, 79 issues are still open and 1428 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4504    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<2>  1404    Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<3>  1077    Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
                   https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
<4>  993     Yes   INFO: task hung in switchdev_deferred_process_work (2)
                   https://syzkaller.appspot.com/bug?extid=8ecc009e206a956ab317
<5>  914     Yes   INFO: task hung in rtnetlink_rcv_msg
                   https://syzkaller.appspot.com/bug?extid=8218a8a0ff60c19b8eae
<6>  534     Yes   general protection fault in skb_release_data (2)
                   https://syzkaller.appspot.com/bug?extid=ccfa5775bc1bda21ddd1
<7>  457     Yes   WARNING in inet_sock_destruct (4)
                   https://syzkaller.appspot.com/bug?extid=de6565462ab540f50e47
<8>  443     Yes   WARNING in kcm_write_msgs
                   https://syzkaller.appspot.com/bug?extid=52624bdfbf2746d37d70
<9>  377     Yes   INFO: rcu detected stall in tc_modify_qdisc
                   https://syzkaller.appspot.com/bug?extid=9f78d5c664a8c33f4cce
<10> 356     Yes   KMSAN: uninit-value in bpf_prog_run_generic_xdp
                   https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

