Return-Path: <netdev+bounces-213696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8801B2659F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 14:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1E01CC1A51
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 12:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F27A2FE05B;
	Thu, 14 Aug 2025 12:42:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922CF25C706
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175348; cv=none; b=jQcD8CCK4wxuHIOLWQLy9TWGBgb9vQfJ6MAkqTkS1AgLR0UHr8TYykjoWlNiwd2P8g4NseV6c2IDzE8EPi2QxDpRfhHE4wowwy4/RNiZ1bJ6dIHwPrgPdXj95UQFeSOdOUyCgpKtcn/BWYo0msTiYRa0RT09yXA3AP/giuDabos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175348; c=relaxed/simple;
	bh=+jEP63/fwVi2lrN9xFrebDIsSXfRw9oRl5BYut7hPDE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GwOyNU3hi6HziplVhCrAfv9wkeZC2VCPYCSfmah25fFw/OTacjJXDZY+6hFdnWNzTMaXMf04qE75Ox7bdRrY+YRZTAMFYsVikaHRBY34uowzypqATqR1USljwXo3tKIVlwWGzz+TW9LtV0LjN44+MEEjvaS6LYh1Zzz2Iiq4jFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88432d8ddb1so106174639f.1
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 05:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755175345; x=1755780145;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uiRRu9OJFyKeenKqerh2f8im3zeM5epxTzM5uWVDxL4=;
        b=Dp7aeHE96SdEGPEx1TLchewJT7PBJU4An8o4+/ilkR0YvVsEGSxbjtdkavmzLtgJrc
         Ld4vXJa8aTUeAV3KD6xajqbTzCQtH0jm5MbHw1kbURY8KYHMCslLSg459USiJwPwrkZm
         73FjEOPdsR+z5/2QFgsfCmxHSR9X5JNNLNlmwzTXWIVq1uy1KPoDFehXGcthrAcoihps
         D5yfGgajbmbgcW1uCy2NCiogAPTljpBHwPF8yBwJoSPwVobbWnSJTSFJwqLZqdqyGoDT
         h3qO5/AO+naYtEJALax+kVe3Qk4iWg1o2GWW7GF0PdMHu4a5TJ3VDcSzmCOZvZjCUF/2
         n+dw==
X-Forwarded-Encrypted: i=1; AJvYcCVBHhsXFpeKHLIdpY9sd7Jx+OZ0+g+tmyQLzSxJMLfrMLx7XMXBMpeLTigg6Yig33+b74rtqTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylt3M2h5/5+e8OKezjHHBaD3zUHX4S07IJa3fUkWkW3zlYkrVY
	JbO7V44BFZKfQFrjd+zFo7gJA1vruMHzxjsVrb3pg9l2BfDDr+YEPIhp5U+xz3CLlb5EsTqAtPm
	xt4MlRdnUWTS/tTpeUxjV0bjyPNLdXzDhPmsE7dtYg+9A6zm2jgUFkUEyqmw=
X-Google-Smtp-Source: AGHT+IFLTLOk5lm5M0xQ8qibNIbknOd85LTrLoRWuJLHUBvMopNJUjY/dVy1Po/t4iRcG8rrKtakJVdxO8EiiuwNg4DgXPd/z9jn
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1550:b0:879:66fe:8d1e with SMTP id
 ca18e2360f4ac-8843386e0e9mr579219239f.8.1755175345671; Thu, 14 Aug 2025
 05:42:25 -0700 (PDT)
Date: Thu, 14 Aug 2025 05:42:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689dd9b1.050a0220.17479b.0008.GAE@google.com>
Subject: [syzbot] Monthly net report (Aug 2025)
From: syzbot <syzbot+list60930c84dcf19143ccdb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 5 new issues were detected and 6 were fixed.
In total, 128 issues are still open and 1604 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  370101  Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<2>  13108   Yes   BUG: workqueue lockup (5)
                   https://syzkaller.appspot.com/bug?extid=f0b66b520b54883d4b9d
<3>  10021   Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
                   https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
<4>  7473    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<5>  3275    Yes   INFO: task hung in linkwatch_event (4)
                   https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4
<6>  2639    Yes   WARNING in rcu_check_gp_start_stall
                   https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
<7>  1846    Yes   INFO: task hung in del_device_store
                   https://syzkaller.appspot.com/bug?extid=6d10ecc8a97cc10639f9
<8>  1684    Yes   KMSAN: uninit-value in bpf_prog_run_generic_xdp
                   https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
<9>  1506    Yes   INFO: task hung in addrconf_dad_work (5)
                   https://syzkaller.appspot.com/bug?extid=82ccd564344eeaa5427d
<10> 1034    Yes   possible deadlock in __dev_queue_xmit (3)
                   https://syzkaller.appspot.com/bug?extid=3b165dac15094065651e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

