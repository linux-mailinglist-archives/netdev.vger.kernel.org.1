Return-Path: <netdev+bounces-241153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A71C807E4
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 13:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931263A7E73
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 12:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731F53002A0;
	Mon, 24 Nov 2025 12:38:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3002FCBF7
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763987908; cv=none; b=JcZp/bg+AD/5s0VChfAmvmLrUXnDctcLnhi50ur4HZWLdc14f1fTkACwb0a450cMZgiU+Gm0sCU6w/eNvljiDZ/rdhYuMtdFBiTKNA5GTKgh04/Z3IlKrt5yp62MCl1UBYkE8tfQw9Zo408DV4IicQb8U0AJBdiboZlT/gjl7+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763987908; c=relaxed/simple;
	bh=CfxO/FUQ8DqY+cNpjG2OI0u6zJ/KGMj326kbDe3qeVA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dekSdHeyTL2eHtzKsKED+1B63D9Pp2f8ziYLQiXRE+avSsv/bHk1Y49cxrkkVO4CLlrQ1tAiflF05AiOj4vFIuDmUWYX/UOPlfwgvt8Ix5gk9llvny/tSsXnqbLAIIBWVG4AKfQWTRMSc0I+hIi36jYjD6gpMVSq+vxHdLcfr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-9487df8723aso293271839f.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 04:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763987906; x=1764592706;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VAkQq1oo8IepXmnYI2hCQyZo9yD9Lb0GzWqHEDsTZQ8=;
        b=ovRuiVM6SROtZ0cSfZS8g5jjECKTsQ0Az1k7vMQ8RtnNuR70XJnfDUyYUJtsTS2Ueb
         G7HpL/FZwb5Zgr8FYeEQMS59p7TGtjr9SMApSMxK4m3FFK1okb0Yn4ZFgxXFBKo47+xV
         98UnwHiodcyCxuiYgw1v2rNea7bOdwWTNJlUvcglyouqDINtcYBn7T/0p1PFWHx9leNg
         Q1WIoLo5U9FgzhJWyeyx2ij54QNo1ren1QxlitPfMt4v37twRGkR2d6qgpwU9dfQKVot
         11pypy4wZ30mIihY92NaiGBTTbsUJSLrfQzzVmtPdAbL4TVr3P1aLGGE5qGi28GB1s92
         v0vw==
X-Forwarded-Encrypted: i=1; AJvYcCVIMojbKQ+c54fLikuTkf01+ZAXfbD4S8OM6j24FmkxeqLsTic01N3h9ff/MkODEU6eSWtvrTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHSOWyH6NnxmEcD3u/s3KmVOSM3nQbFGyxvYAwWJ2i9IrbX5g3
	LU1GHCMVAKxzb/Z6nxsHRta285CiKnlpTzubiIJgPULvrWGxKKNtNZ88POXxVjQMOfHJJrdr5mI
	YwFx70OB0IgjRYuaxjiDmavcLFT4uV8KAQtE6yfxwYfhENFcXB7XQHo96JjY=
X-Google-Smtp-Source: AGHT+IEM+mYlFU8a9XelweezEAs+iFIgGm2XwV2zcVOIEaSuXtmjWxFTq1JTNX8m0y/zbxr2j+HZcW8N9cCaBHDaeUBriMzZNpa9
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b47:b0:433:2389:e0ad with SMTP id
 e9e14a558f8ab-435b9845ecbmr103067995ab.8.1763987906075; Mon, 24 Nov 2025
 04:38:26 -0800 (PST)
Date: Mon, 24 Nov 2025 04:38:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692451c2.a70a0220.d98e3.008b.GAE@google.com>
Subject: [syzbot] Monthly wpan report (Nov 2025)
From: syzbot <syzbot+list74e86652e292993654c3@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wpan maintainers/developers,

This is a 31-day syzbot report for the wpan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wpan

During the period, 0 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 345     Yes   KMSAN: uninit-value in ieee802154_hdr_push (2)
                  https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
<2> 42      Yes   WARNING in __dev_change_net_namespace (3)
                  https://syzkaller.appspot.com/bug?extid=3344d668bbbc12996d46
<3> 16      Yes   WARNING in cfg802154_switch_netns (3)
                  https://syzkaller.appspot.com/bug?extid=bd5829ba3619f08e2341

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

