Return-Path: <netdev+bounces-182104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA09A87D53
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C353B925E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC8A25F96A;
	Mon, 14 Apr 2025 10:17:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC45258CCF
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625846; cv=none; b=ILKAS1PBwlPQ4KNHUiVq+4n9Y6kUEP8Z2JmkwRnblnPAvW3f2mMeWNrzlWLu89aKGPzNuXONZLcymODPVrPop+l2lBr/BNHm11qakAIZuQJGo5MkiUhEid29HhUkyBZFZBX1MmrGjaOxwV6z4otlFszzvSF1aqhtMVJEPiR1Fhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625846; c=relaxed/simple;
	bh=2c7M1E1lRjaBDF0DTAAPrSRSxY+BYWh8WNPLmGeCIVw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Yi+1qo7lGVv5267whJOnu8rtqWUkSG4zt5om7xa516NWIWFhX7sbtXywNGhDbXPeXWSxA5dnkF+nK/Qm0HZt4XCYRKnF5dxyRiN4WS9XsUiVZnv+nZlvDf3Q2/o0EADeDkPm7U9R6gx9dOgTVuofGbTymfY3mI1pB1j8eleawpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85b3a6c37e2so439529639f.0
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 03:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744625844; x=1745230644;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CtlMRSkBTs7/GQxA1jZuBkOtfqExXnDhTxodFQXsVWE=;
        b=ZXoD+NCQEWRboCtHJPciyoHFwia28XBrS/+fbMnvoXx/0P/7hFlogVmKtwX/zFzGaC
         45BtCYPoGbZQdojSp0XykWkD9N6z+zJmQ6FmKBUg14ibAz0+lh/n4KB0kt+CTvJf4act
         JfSOhsFaD7SQf0AcmL2wK6UQ0OPB2JcHdMmZNoMdmp/rCQPEqZa5+E+8kGAZBsdQtlUr
         IrcheHHUA9+H9SEaIZOs8XHe0WZAe5Gg8X08mnYMNq1xR7E/szOaIoBJ/uLTtuO2E1z7
         zE1deP08Rz8ReQzdG+QQI5WDUBdlWP2Zo5wRLicZNXACTVCZDtqm/jOZ8Q4O0AeQs+O1
         3H8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfVavVx8xdzwgBzPAdpk/XKLS798amCtTjI07fUnKebAnUyxjbymNGB27tkkSTIYP0RHCrCwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYjwVAlO/VnxiiyLxaZDPrjaQpLc+2KdEJDXGPpmWpi8E4tR2X
	bSNXMSUDzt1RqhT80C4akEJSy3yH1Y/9EBWcZoNSTw9XDOMMvAF2UeQ/86y6lf9dZd0m/mHYdm7
	4mV9wVvYaO6sNjGLeMDp82B67ziMxPX+UsKUBuSVVnJVv1ui/G/hwLDk=
X-Google-Smtp-Source: AGHT+IEsWK/XLzkCHRNQgrHF5KhLezLNJO4VLrlEScGVacAR/kgdUOYuphvjLeyiCMwRREts1QtXMXzftrH3GbUhtWKQod+vnsQX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2190:b0:3d3:dece:3dab with SMTP id
 e9e14a558f8ab-3d7ec1dd57cmr100206425ab.1.1744625843764; Mon, 14 Apr 2025
 03:17:23 -0700 (PDT)
Date: Mon, 14 Apr 2025 03:17:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67fce0b3.050a0220.3483fc.0024.GAE@google.com>
Subject: [syzbot] Monthly sctp report (Apr 2025)
From: syzbot <syzbot+list56b130d2c18ef7a5ca58@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello sctp maintainers/developers,

This is a 31-day syzbot report for the sctp subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/sctp

During the period, 2 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 70 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3863    Yes   KMSAN: uninit-value in sctp_inq_pop (2)
                  https://syzkaller.appspot.com/bug?extid=70a42f45e76bede082be
<2> 29      No    KMSAN: uninit-value in sctp_assoc_bh_rcv
                  https://syzkaller.appspot.com/bug?extid=773e51afe420baaf0e2b
<3> 1       No    WARNING: refcount bug in sctp_generate_timeout_event
                  https://syzkaller.appspot.com/bug?extid=c7dd9f1bd1d2ad0e5637

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

