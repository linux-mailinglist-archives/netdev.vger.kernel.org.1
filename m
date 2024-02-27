Return-Path: <netdev+bounces-75235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86944868C50
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 10:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D031C20DAA
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 09:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF46C136984;
	Tue, 27 Feb 2024 09:32:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A482136674
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026338; cv=none; b=dOOaj+71WXBUCOUOSqEzVgElFbYieK08uDv4OxpnjrrEUVpziBrFiS+QtbRFZYYb7htHa8zI3bO77JyauB2a1fyzxBgTXS8mXUTY2FaMzFNCrmebW2GSO2uP5mApgs+SAiKOAalCcqpqtvP2/yUzxIZIDTo8diSIrUtoQeltfjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026338; c=relaxed/simple;
	bh=3UlkW27UdpL5WFsTVdJEkJVMGLlMP+znlstRRekB9Ks=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eTp0SrN2CgkjQVCLLSttnLOtxiZWwUa4Lxrfi9O7JXdjK2maG8oAAWqCR2LhkPDpI68/K8Jy5NmtO8YvTr+zb7cn5a8E7aHYSSnUcqhfzcsBGueT29rgB3Fo6M9V/WwTLAshYKdVLcxc0H34irR2aEw9tZh8xvrk4X9P9XAVnvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-365810221f3so31554735ab.2
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 01:32:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709026336; x=1709631136;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSzEE+cK+nSRt2VzOCPLmcohDy07PYkHlPu8819BDPs=;
        b=lIbe0i9Jrd2QaPv3lWYw4ZQhynt1wxmg47GHmRWlywrvjYURUBiap0jjTLBAjas+1w
         3K+UR242Vkl/njMAj976ucljQ/aQPSR39sJOEW5cD8I+6Jw5hV9lAn0BBJIC9TrJLPMw
         4fHsAMocEdg+OnN4/hWlgOXxiWLylbgbisBKjnJ32XOO+hU47yJpv5bsdQLpMQslgH6y
         JzszIBwlUue6KuX9D9F4O72fHiuADLSJmjGcKWOzFKaqpEhPBjJFOiiBMMGiHAJdgUpy
         w1kEXbAD+Ay+dWb33Yku2AmTZChfokX79h8/k41bpm6zMPT98kzTx9XpNCKltv0IY1NO
         MRTA==
X-Forwarded-Encrypted: i=1; AJvYcCX4BfhgaOeUojGbxuHFjLb+VctomQG28wNXnP+oBJMy6P9r1BQOFZupyWdjqUf0PmZ+QLeQAH9D8l+F/F6Pj0YYQtL3WSCU
X-Gm-Message-State: AOJu0YykkC7OI26x/8mUm8yTvAdy4WVJhoqneTIQ/pBYQuCx2vuquenX
	rndKSPCER0AtwcOQDdpM6YITXA1LgVnvzDlwdyjlnEn7YQkQsHOcT/sXZU+ZcVWxsDP98UgePBe
	0KGI+JFwogwsBmxwveRXjyGH083PUTCyAh87FDEHDs/BX4g2nCx2ZBbQ=
X-Google-Smtp-Source: AGHT+IF5u+2XMHoOgvxvA91H49CoSBaKTt/P6Fn0gkG723u0iO2lQXX3Xy+RzGq2OaWY6vaJgF2BWL7HdRTjYBKOy+P0hnbLxnpq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2166:b0:365:afb3:e438 with SMTP id
 s6-20020a056e02216600b00365afb3e438mr8229ilv.1.1709026336557; Tue, 27 Feb
 2024 01:32:16 -0800 (PST)
Date: Tue, 27 Feb 2024 01:32:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3d2ed061259b3b3@google.com>
Subject: [syzbot] Monthly net report (Feb 2024)
From: syzbot <syzbot+listaa3831d981acb8a56caa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 10 new issues were detected and 12 were fixed.
In total, 66 issues are still open and 1378 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4149    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<2>  971     Yes   possible deadlock in __dev_queue_xmit (3)
                   https://syzkaller.appspot.com/bug?extid=3b165dac15094065651e
<3>  956     Yes   INFO: task hung in switchdev_deferred_process_work (2)
                   https://syzkaller.appspot.com/bug?extid=8ecc009e206a956ab317
<4>  835     Yes   INFO: task hung in rtnetlink_rcv_msg
                   https://syzkaller.appspot.com/bug?extid=8218a8a0ff60c19b8eae
<5>  831     Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
                   https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
<6>  473     Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<7>  437     Yes   WARNING in kcm_write_msgs
                   https://syzkaller.appspot.com/bug?extid=52624bdfbf2746d37d70
<8>  307     Yes   INFO: rcu detected stall in tc_modify_qdisc
                   https://syzkaller.appspot.com/bug?extid=9f78d5c664a8c33f4cce
<9>  270     No    INFO: task hung in linkwatch_event (3)
                   https://syzkaller.appspot.com/bug?extid=d4b2f8282f84f54e87a1
<10> 257     Yes   KMSAN: uninit-value in nci_rx_work
                   https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

