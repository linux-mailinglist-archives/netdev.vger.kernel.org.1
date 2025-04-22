Return-Path: <netdev+bounces-184602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E4AA96587
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8E1189D186
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDB821018D;
	Tue, 22 Apr 2025 10:11:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D72B20B801
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316696; cv=none; b=V/eXrAB5KuweEdiEN3bKZK+QE455ALQNJiaVNNlMSGMrzg4CvMVpAkmdWRu112Dh0uFFQMSsYPcZHLyfES1phEqUeUS2W6MykBJW2gJS51PqNsMVor+tV1n075mO4jfbwcRdU8UpwWS/ySdkzG64eggqPo7CsVDRxRY+48eN/qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316696; c=relaxed/simple;
	bh=MyddPXEqkT/ccEpbWGrSBV3tL1l6iZYEwssAfmCAvZU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m2zFav1OGw/ApijuVsNdbZB9zkECk92GSwFz/haALPVXSVGo0uz3zomWVc9XU+PncJ4w5fzGPWfWxd1tJvbHAJ3Bzd4fhcVUPZMMezdgou8fcPq989FWGXXzxL0kFl32w6M58WlIRbCzDSdSMFHXvyFkVqC1PTD4jX0vyP/CnrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d443811ed2so78822775ab.3
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 03:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745316694; x=1745921494;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJWypGmhAyE0A0ZD6qLvLINF6ckB8EvT9cNMNlbIZ24=;
        b=qEe1xAvhTwlCNsIEPWkeoj5nxzjEgkv0I3XkHNzDbmpTNHlCVkN1Sf6RvornEozcwv
         RWmtMfjrx+EZVfYIfSjENSA7SwbG5boP5i9WihtSeB8mT257zY0HhdwLZAHsT3eQ4Zgi
         mRIpP6QQmEymGBKE/nor0lEUR+geoLLBjwTZbkZv+9dk3v2I2dn4yqrcFdSWt68BeBVC
         WtRXiowNQjFTAI7ElNrQeAJQ+zwKAqqvJEcNCPsp8PQDVPuxi6bSousOcCRTvU6aDOt2
         BEgZno9jI/CdPrnD6HB22UHFwySm+fNU4chqxhYnT67os8YlvPY5bhKy1Y+VhfErWgah
         7Lww==
X-Forwarded-Encrypted: i=1; AJvYcCXveELMDOSfvbp74MPciKmdYIV161iH/+uAT6jPsyia4TxPgHICrIu/h4v6cExbJKVYcn4e3qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAUJ5jtRZN5FUBkpQAH0jKmafFdcniGHyd5VpQCj70IbwiAR8h
	z1nqclGnb7M9Hyvg0L8gPwTwyTFfFJVL9oDzVRCBNMFid7Y5msN1yFGqSEAOSSGzVLgYqZfbMV8
	Aois/pLb7A4IJlIutz+E7wU64GahbSRVOOm8t9sZxNY1CWkNfXw9hlzo=
X-Google-Smtp-Source: AGHT+IF3Pzr6mNNm3jKbTEmt/tdnyT6K4L/LfgukilGYn+EG5iVlnNcj8TwE+lTNnTv55J0AwtB55Iq05Bdjfx8vUwv8lcpJaQDX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c6:b0:3d5:8923:faa5 with SMTP id
 e9e14a558f8ab-3d88edc18eamr129416475ab.10.1745316694304; Tue, 22 Apr 2025
 03:11:34 -0700 (PDT)
Date: Tue, 22 Apr 2025 03:11:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68076b56.050a0220.8500a.0005.GAE@google.com>
Subject: [syzbot] Monthly hams report (Apr 2025)
From: syzbot <syzbot+list7d5d7954b33bdb027232@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 40 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3688    Yes   possible deadlock in nr_rt_device_down (3)
                  https://syzkaller.appspot.com/bug?extid=ccdfb85a561b973219c7
<2> 303     Yes   KASAN: slab-use-after-free Read in rose_get_neigh
                  https://syzkaller.appspot.com/bug?extid=e04e2c007ba2c80476cb
<3> 256     Yes   possible deadlock in nr_remove_neigh (2)
                  https://syzkaller.appspot.com/bug?extid=8863ad36d31449b4dc17
<4> 90      No    possible deadlock in serial8250_handle_irq
                  https://syzkaller.appspot.com/bug?extid=5fd749c74105b0e1b302

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

