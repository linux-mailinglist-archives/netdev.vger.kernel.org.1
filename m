Return-Path: <netdev+bounces-173909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676A7A5C339
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B81B168D62
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC5025BAA7;
	Tue, 11 Mar 2025 14:05:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A570C25B690
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701931; cv=none; b=VV5nVPHwVssNy1Abn0VliQ2R4bMdJOgEYas4aRHE0CjafJi7dM+738EK1mgWjms8dS9J1XqvHh2/Dq3NwSFFxEm9DovR+nqryCOCgCTPohF0xK7e954XWxwW47UOFEnM9ubpqvLfhPTCAOx4jCnkoRHTUdGKjbTR73PSC/LS9t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701931; c=relaxed/simple;
	bh=4ViwEQjiuyztLc4xhBTeEvbuR6KNrlXDlWzGWmWXpOI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iGesO9XRLqsPqq0/BTbUvbpyLUowHZZbye407L0VnE2G5Bc1gSkvODcf9hfdFwtE3xUnuNj6t/daRUqusNKm6Wk+36XYo/lbbajKRtwWviuRZgbCVVZExgNCZYRov6VRCBZyeGF62S9PQXTL4lFAqZnQD/cX8t2vxd1t6z4IC6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d44b221f0dso68967045ab.1
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 07:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741701929; x=1742306729;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7pIE7LzGKssZD6z8FJmkqvR5uOSKHU0Z3BJr6I6MvtE=;
        b=YpeaecRsfhMBMIhXWSmklRrhF46nPfvvy7Zepx32L4h9w4BwvyAgdWvLRiYdTxNHQ6
         Vjvm+s/q/dTPSqZ0FQTydw+BM/P/D3dT9Qh1rJstFlARQ9hzUqNrm1fF4DDxA9EacZkF
         AmtoHpATNldhOnUwp+EwCHBOq/HQN8aEXs7Fwlj1yv+yeM+4ivavNZrpzeVdvI2QqCfj
         T0WYSUSZmAxjMPQtDIZQY+fbSmYPuwhD83cBRVISM5RF9H1cutJ5CBV6isOh2SnVc4hr
         eR6cw9rmXU8w5Qdm7xzMjzYpVfMZK3Snf9MEQVkn/ZvcbGGqzP8/nYwJggPglOoI0vjU
         ksMw==
X-Forwarded-Encrypted: i=1; AJvYcCXa64skxavwd9Z+wlOfI6Cck8UF2IwxxGKY+/eCCw87FWOZR5NTnxd8oegekhdvbdz6dkEWVeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4bGHQPk4JeL4by1ANwnOVFML4yx8Z1EhxvOOgCLXI1z4SccQF
	4nHjdxBP0WA6Y5H3koVGrPQGS55dkHkyqbFfSOnv0zTNuJo+zM16W6KPwswMwLxJEnFxGb2TLyS
	/RPz+mD7D9dIaqy+yNAh1GEMaQTHifaRCRywyClzcgha4HW+0ODdgnSk=
X-Google-Smtp-Source: AGHT+IEY6nTprIKbASEGzFSSX2oWyr7YAC7wQPFUhD39nHl/U2n/UW5PK31hujLGXmJFF+bTCyr9hb7Vrj7L3wHwWWl1rVVEIDEK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188b:b0:3d0:4e0c:2c96 with SMTP id
 e9e14a558f8ab-3d44187c11bmr214664045ab.2.1741701928626; Tue, 11 Mar 2025
 07:05:28 -0700 (PDT)
Date: Tue, 11 Mar 2025 07:05:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d04328.050a0220.14e108.0005.GAE@google.com>
Subject: [syzbot] Monthly wpan report (Mar 2025)
From: syzbot <syzbot+listc762ae8193f4e230b47e@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wpan maintainers/developers,

This is a 31-day syzbot report for the wpan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wpan

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 204     Yes   KMSAN: uninit-value in ieee802154_hdr_push (2)
                  https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
<2> 30      No    KASAN: global-out-of-bounds Read in mac802154_header_create (2)
                  https://syzkaller.appspot.com/bug?extid=844d670c418e0353c6a8
<3> 11      Yes   WARNING in cfg802154_switch_netns (3)
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

