Return-Path: <netdev+bounces-204985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B6DAFCC55
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37F61AA7780
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B852DCF54;
	Tue,  8 Jul 2025 13:41:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E6C1F949
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982086; cv=none; b=LXQbgoagbNvxbbtrG7aMgAWTk3S54UkV7SFYeUy/igzVuB+4cQ3T9p/VrDs3lAaxWvWHy+qVENv30hr3k5tJkfwxYBuSyJYzaoEtVS6Jr/1ddms/v1HPW0hJi/X39e9bOv29t2C/oaMf0qhxVPfbG/hKDAdIYifdf4BSFvyRXkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982086; c=relaxed/simple;
	bh=DtbB4lgJf9UiUqFjNROhOaOtq+Q+ZUvuWg6zmLKxZqc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pGmWvM1j0CXhaOGUfPdYol7jVIlGa6UTJWfbYLmLRDBFt2aN1FGSchcKFt++h4x3vcKvoodYkeTptRhLU6+x6M6yT3YbgbidORmDB4Fiujdinw280eXLVCt5MS6DGk8vcl4WPzHuePT2uo48goUzwDHYDWKD42Hf+u+/jrbiEdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e059add15eso47635475ab.0
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 06:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982084; x=1752586884;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jlqaBHX5Z4gTs5jTlvB1HnLAHIY50wvLNKNDyz6F8Uo=;
        b=HnIfE0xOqoXvc6MCzzVnwbSWvP9jZUMrDfgbYWuDZTNEBf1Ahkc2Hp5T2ma2uPOzlJ
         rpzn+cV8wbC3MGoMk2SACmiG0r8GMBSlk7CiQYBG4gue216HCzHswujOvNe2C1HjDcNR
         3Z4JG4kFUTVYJqZAUD4OcJiRFmU5IZoUS1NnDbCyiqSK/2gbCfPbbJH8x/7cssChwEq/
         g2CXSmKyZdQsXx/7KHJSU+A3I4olqPxFLuavbTYVJS2jR8Tx8RRVekQYRHPTD4bgW4Jn
         B/VO9w6Xdu1atgckbzEsEXWqvTnodWzZgGIEGbTVDU087yLlPwJt25irje/GngiL9oq8
         Fizw==
X-Forwarded-Encrypted: i=1; AJvYcCUOjJKjuvpz+B/dD587PRgzR3O+MZTEWx/KE39C3R0hlvK/ZkdCy+tU/CVzgwjrHyLlK+8AsX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc5jxBQsWxN3rULUsqly27KernpBcqEcCVMap0CPPWl+m+AbH9
	8dWzBsL+8GEPff7CnKgAIuVI3XwlJrn7fL/sAy+nG7c/caE6iRZ2wNTxsiy4wKXLiXJVc+SDIm2
	cJ8H35wQ7dduzp7199kGFX0LdnSEqMY4AjNrU5X1hHYFmjvFYBYL5nXUzRxI=
X-Google-Smtp-Source: AGHT+IEHWDHAzY2BOBD1guc6Dv80BuQF/GE+kymFwnh2q2O4DxQH0bj2bZyWxe0lBsXIvMyxgolCgFnfYM1D3NrBPPPMtUM3bDFf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26a:0:b0:3df:3be7:59d1 with SMTP id
 e9e14a558f8ab-3e154e3ca6amr26140235ab.11.1751982084422; Tue, 08 Jul 2025
 06:41:24 -0700 (PDT)
Date: Tue, 08 Jul 2025 06:41:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686d2004.050a0220.1ffab7.000b.GAE@google.com>
Subject: [syzbot] Monthly nfc report (Jul 2025)
From: syzbot <syzbot+list6b8e21ba94b2aeb18e4c@syzkaller.appspotmail.com>
To: krzk@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 27 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 459     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<2> 329     Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
<3> 63      Yes   KMSAN: uninit-value in nci_ntf_packet (3)
                  https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e
<4> 49      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

