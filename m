Return-Path: <netdev+bounces-99658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEDD8D5ABF
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E811F24B13
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 06:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFA28062A;
	Fri, 31 May 2024 06:49:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026C780600
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138166; cv=none; b=KXZ7Tmqs3JbnHz94d63akzCzWnxiiHhCV0xwNhVSaYEiyjflTJPsugop5s8uCYhjIaV2GLwwNcTo9pplc46TZ8KSFsIprrm3nCX6EnVyCGc8/YpiVUz6FGAf3/kSsVnS03ACRQNT0v44CAsRI2Ydv2lrmR0Fge/ojhTywUvrXPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138166; c=relaxed/simple;
	bh=ucyZLx+dcNq0MD+BYcpKr9gJLBioFK6aiyD8XmcK6Ww=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M/FtjyRyoyWJbcLxJSIsLYygWOcCXxyzm5jMJ5QKlc3zpF0t5glInPVKatv8jDV4u2eCnsLudJylUDsAS9HG3Oqv5rBn3IyzBpPk86pn39Du+asBfCFRd6J/fFWAegbaBNl6Pd41KF21FViHUak32ucVbVfKUFPwNn8qW6BdCEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e212ee8008so227082239f.0
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 23:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717138164; x=1717742964;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OETLcamVayupj2CJ4Ypv0K6iuhlLpiVCriYowgbiKOc=;
        b=MOMkVscpbyIQPMUKSZpXICGyofAe2ZCaa/IRC6jLVYu4qwyxVwQ5SJQUyjuDL/Nz+P
         vxbnsZ6gQ4s6ElFn6K38ps9+OCXya1g80RXO8fJsdJTwQ2rBcDXWseBEGBKIJpsMmhOd
         w0xaFT8KayPlnQvRT7mgnnBgRIDilxgYsMax1WwkiciZRiWckSbTwbW9/9o8vfBUj91q
         JeBDD4wZ/sFid8tw5TsPQzWSW+6jDwEIVcDwnuEJsCvvLeZoxq1UiAD/0imaAV3ocNVx
         rJcY49m1bZQ7hKLPfEuzEtr+tiHxWl+lKn3i3JJPE3L3C2haEQcenPh0beVV6OzyTP2b
         Vs7g==
X-Forwarded-Encrypted: i=1; AJvYcCWw+s/XR/N1ACn3jsn1DnxfPf+hxMPsC2FA+zo22wg2TRxFyxrNBX6ABbooaLKqX0kNYSYrckbBlGtyps+H6DXI6ho0TTwu
X-Gm-Message-State: AOJu0YySbCTUwuaDpz15ubYHidaWfiCs+RjsPolN74q/ncZif0GH5Bbj
	yjGXzCpHyakldw5tjHmS3j3NLkRDP0HOjQMa8yZf0287cBQ4MDPyXkShr0pX722ua6rIQYq4Q0I
	JVI/T77E9w5hI1kPxad+EJgPGnzDrap9+k3JQUjNIMP8MI0tHIkMCL5Q=
X-Google-Smtp-Source: AGHT+IEYiNSxdSbf/7LPOSaesM1l7rlTPMv+/6I8aRQOs7jfWM3gvWJMowUWQcM8g3NvHJea+pRLclKI0wRie4kcyRBwohXGDzk5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:9682:0:b0:488:cdbc:72c0 with SMTP id
 8926c6da1cb9f-4b541b78f90mr6972173.2.1717138164295; Thu, 30 May 2024 23:49:24
 -0700 (PDT)
Date: Thu, 30 May 2024 23:49:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050378a0619ba62e3@google.com>
Subject: [syzbot] Monthly can report (May 2024)
From: syzbot <syzbot+liste4e0cd5f42b83d613fc3@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello can maintainers/developers,

This is a 31-day syzbot report for the can subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/can

During the period, 1 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 50 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 527     Yes   KMSAN: uninit-value in bpf_prog_run_generic_xdp
                  https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
<2> 99      Yes   KMSAN: kernel-infoleak in raw_recvmsg
                  https://syzkaller.appspot.com/bug?extid=5681e40d297b30f5b513
<3> 5       No    WARNING in j1939_xtp_rx_rts (2)
                  https://syzkaller.appspot.com/bug?extid=ce5405b9159db688fa37

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

