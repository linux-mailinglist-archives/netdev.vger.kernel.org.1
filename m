Return-Path: <netdev+bounces-207465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4943B0770D
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 15:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C36561BEB
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489BC1B983F;
	Wed, 16 Jul 2025 13:32:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FDA19E97A
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672756; cv=none; b=bOYBQv9nbF2qRoHiNEWwPhbnu0VmoMC44Flz+mkKhLRB3LePFHiqQ+5of2yHX5UfcNPxGReRf3rQTCXcbMWhiphXUGT+THrP1aKd73bvo9av0LbUXK5xeHsF55LWpmI0eqSpW89uwPZqVVOFlo/WXu1J4MIQ/SW5bo1Hdjpj3UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672756; c=relaxed/simple;
	bh=0LjF+WEpfWxbMuI94iSle2uStVAP8+DyETXP7hJ2nWE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JGN+3bKvzPkD5qQfNhXuYK1Jio0wIr+zZqMbJfhNQ/2e/kZSF2nu+WDD0OTTLwkaLiQWoYRYlamgcWW1r3YR4q2pnz1cj26AKP1JV/wXyf2akPSlCES+GivuML1dgHbENh7AJHuhav8DWKlHACber6G/PwsHi+N3xGF9WXZjjAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86d07944f29so1367725839f.0
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 06:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752672754; x=1753277554;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8FKo4QvDVoH70iqyD4IXeGiSxCF2PDv2mvb9DgjsTuQ=;
        b=obt7b4UvMFnY1rOVlFRnXccfLxzhlmCx9A8eiUKKI/cKSDaniupywzLfT/+Rl5mvms
         +ZBtRuzgcA7EM3ZOT04Gh5FkKA5fjhOMcqyp/QBHNykE3suTZXuVbLG3HgNUchmVT4Df
         EkAASjaNwWcy89GD1RaB1WnSKreD+roQOVavhVptkLZUGJ30mYydkjhfVHuIWZHBv1LS
         DlZXEmgiqFDKwPPk9Gh9k0kgrIP2wcW30kMafEBtbHDaI3PEB3LCwPpvEyV8DNKxl8aw
         eM+NEuRUaiwEYNdhlVi72/VfCKMic8pynJkbFbQxP6Bn2d9SxD8hOZhTR4lNim9TbWZm
         SBbg==
X-Forwarded-Encrypted: i=1; AJvYcCWzAzIJJAjraaO/T7ra9EhyPfcY5K0adZwbkHl8LSVFFpzlsC2dFC8M6JpS/pHpu3PD7bKUhA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaIHX7gSo/yH7/8J7dDGU0nTd9u8JAnApAfFk38sU0ZD0Uzz9u
	MsJERWTssdb1pKupNA4ej4RXnk0heuonZEixGqLiKR5U88ifnGDue908gS/wcgBizE9PHMNJElR
	i0By2VFd8wIqeuW46KpVlfYkMDUY7vCiPmrMpKHWH4Cq37OxgnGeR67JEObE=
X-Google-Smtp-Source: AGHT+IGF/kwqN7mja3XdkF3JMxQnYsfIzdVe8SJG2JlSEMJrev647LnGXH+ZgnnCfb6c21qzpSjvMFXxHCtaE/I2Xx80WB5mV8aY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6305:b0:879:72d5:96e7 with SMTP id
 ca18e2360f4ac-879c28da0b2mr283284239f.8.1752672753981; Wed, 16 Jul 2025
 06:32:33 -0700 (PDT)
Date: Wed, 16 Jul 2025 06:32:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6877a9f1.a70a0220.693ce.002a.GAE@google.com>
Subject: [syzbot] Monthly wpan report (Jul 2025)
From: syzbot <syzbot+list57b57add8873522eb296@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wpan maintainers/developers,

This is a 31-day syzbot report for the wpan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wpan

During the period, 1 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 286     Yes   KMSAN: uninit-value in ieee802154_hdr_push (2)
                  https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
<2> 36      No    KASAN: global-out-of-bounds Read in mac802154_header_create (2)
                  https://syzkaller.appspot.com/bug?extid=844d670c418e0353c6a8
<3> 23      Yes   WARNING in __dev_change_net_namespace (3)
                  https://syzkaller.appspot.com/bug?extid=3344d668bbbc12996d46
<4> 10      No    KMSAN: uninit-value in ieee802154_max_payload
                  https://syzkaller.appspot.com/bug?extid=fe68c78fbbd3c0ad70ee

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

