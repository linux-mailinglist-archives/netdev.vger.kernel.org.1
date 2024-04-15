Return-Path: <netdev+bounces-87813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 238778A4B5F
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C7C1F2290B
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 09:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3723EA86;
	Mon, 15 Apr 2024 09:23:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803A23CF58
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713172999; cv=none; b=JVRN/uMHZ+34Qx7FBKV6cEiuX6Gtln+XlRCxSJgeVE5hnVVvRSknJ9t578IOZjh5+haeVNbECVjOFt5J500hy2p2xMMT/vWN4+2wlbT1XX/f2Bik/uLFYz9YYEzlXrGWDOc7qPw968mBIZvzwD0WqETNZNoZ/DWKkcVR1muEsfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713172999; c=relaxed/simple;
	bh=1R3b+01FBqsK89omiuCfSSv5XfBcGhv/E9FDyrklszI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Q2DaCipAxv7uEZBlF1hw4ra/kY+vO/KJxt032Yo3fD8pa3PyaRpyeWQ2F9hZoOqjfWcKYXg5BkqqYldloh2y1HEIVPghvOBLxyn/jGfMyypI+0DfUrLlhMjr/SORzo6r3Dvb+6PNr8Flwlswh+It52V8GOFbqB428KnR0Dm+Sio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d667dd202cso288772639f.1
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 02:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713172998; x=1713777798;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GNp4QZ8G+4M5fH5n//pQKxqEn38eSths+NGC58BJ3gA=;
        b=vggSm6egV8Ftcl47sqf6ZVJDpboRuUeFX1aHHZcPGjeTsMmc9oTrKJEnSgSCyWh3GL
         l4uXVOAZLW5sNlSGLlQasFb2Vo21TBBGxexFXJDUK8tQF3GTRPGHjRj+OjmXtPniX5DX
         X+AkyWw4THJ35g90lEiFOMH5pVQHxvYvDte3j3vMiHGIX486W/n+UWLNnX9SVFs4Npve
         rqsq6MyVw+DB1gn/cRIt/7PH4v2Ey/AU+Bo6S6OWEQGBYwi09XuBLsI/92tlx/vzZ7gE
         8C5HIJeXdUlzq67CghCDdE4Y4qbmGut62X3XFjpgtfJMteFejpxGsDiALs4JBXkPFngy
         Dj1A==
X-Forwarded-Encrypted: i=1; AJvYcCUtvD4PXb9y9v5MFd3NMBSY6UAXYJWtsj1RL6QwHOgAn0TaQwWGEzGuBVFpZigXewZ0ywwWxJjNEXTOU6Fi1wujSumlqbqu
X-Gm-Message-State: AOJu0YxOqMgbeNQuevyAvzXpzW0hlRLa5axKKlqcrJkj6eYY90THioPp
	Bb72g+ausYg5/SuEjPqxKFthouKVe/haHeePSM1QfNwBC0LZKFkpwU5Aefw+6SgCVn0YMQdLwFO
	Zk4S/MTZ2O/V+eGkeJklEUIHeODJVAu7ReE0GogJEN7Dqte+lfCBjTLw=
X-Google-Smtp-Source: AGHT+IHiVaUzy6lx78eL6QuWHokphRvLeb0POIZk1UNBzOjle100VhF6YWBFxZpxxOCZTQgVxZ5p1WiY+CESWkkoDHltH0kUiUej
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2720:b0:482:dafb:95b7 with SMTP id
 m32-20020a056638272000b00482dafb95b7mr530840jav.2.1713172997784; Mon, 15 Apr
 2024 02:23:17 -0700 (PDT)
Date: Mon, 15 Apr 2024 02:23:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8e62006161f2bf5@google.com>
Subject: [syzbot] Monthly nfc report (Apr 2024)
From: syzbot <syzbot+list076b173dc0214a44347c@syzkaller.appspotmail.com>
To: krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 1 new issues were detected and 3 were fixed.
In total, 11 issues are still open and 24 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1024    Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
                  https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
<2> 167     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<3> 45      Yes   INFO: task hung in nfc_targets_found
                  https://syzkaller.appspot.com/bug?extid=2b131f51bb4af224ab40
<4> 33      No    INFO: task hung in nfc_urelease_event_work
                  https://syzkaller.appspot.com/bug?extid=e9e054e7ec32ca9f70da
<5> 26      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
<6> 15      Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

