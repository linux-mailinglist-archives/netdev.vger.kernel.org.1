Return-Path: <netdev+bounces-212167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ED7B1E873
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9901896224
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 12:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94A6276033;
	Fri,  8 Aug 2025 12:35:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587D62367B6
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656533; cv=none; b=lpBdY/jabMyuX890y/MrCJaVNnH9Npd/ywVrpBmX5MFWBI8tyua4Uorm08qTjAtBLRB82/ZGHIjz5eP8gI9MACqaaRZaLNcVdq5vfhWBC5pDSzkWDWMrlcK5r60yKzHC2oWwHMGSYwdjuDhCRJ0rlOMIED9WSp8YHGeZHGy+Xz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656533; c=relaxed/simple;
	bh=mLWT6GfB0u+D2py9bwCzhfGMwpw5oNOEPQ2NU0v4Y0E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SFrYsyaEFAjDwm17mlPg4Vdr3HrBIuSnRJ85T9ZVI6KFAYOVcIzXuZp7VZcckFILVEYE7/smWPuvFukcVBDXulor9+ipuLyo/KJUYmqPqAXGVBIluidqqaRgBc8JtfdLxiaBZvyyIhu0TbgEkwl6iL+D+LzP31PNtfz6TiwdVIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8817d15cad2so196879639f.3
        for <netdev@vger.kernel.org>; Fri, 08 Aug 2025 05:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754656531; x=1755261331;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IkINT0Y9c0Hnv3yIkXo95dp5zJJHuDi6r/Kkwyne1Uc=;
        b=YnAldY9tsF0E2ObgAcVjBpxUW/sRKd+Z617I3Mxm6xyA+vM8MhExEV7/+lU/8BAq/Q
         bYOJfTTMI+JH7O+qe5hFntVUWorh7Z+OjdETvXzpTy8eiOhLpUw7bNS+/BPrKEe+apEG
         g6GDwSw/g3DPyUDvUXlK7OKQKxe2DwvkP2rR4R6NSOuZoKRiR0fHzzjxW6OI7huaxEGw
         seldr1fs0qeWo6J6H4q+/If3y9XvsUqPesV+Y8fhtnZ6jtMCGu6+huYSHr8ETHXRedht
         26GryISFXmIZUgBMYGjmo6FQxIXrUOnNmM8xlHAWJWaUhz4AIT1+ZJib4Ku/APGSpaWZ
         o+QA==
X-Forwarded-Encrypted: i=1; AJvYcCVAjmT4j/ENAmH+W4s6x9s0A9aU/tH24nWfB2YJ0ujeeagJwJVHNmCcd3ooQS2G3bXO8qIlFq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAK74ru28eX9ph2SQt7vogVUvyu9cqQgRoF4VHoTNRrqDh/3A7
	bIvwkHtT1vabXNXH88Vmt1ERnbi4CPLLkEz/YOy31lXS4eVw1oi/2OvqcYZDwHdHNpg92M2brAr
	uHRE2VPUzbDdFSnkSyS5n/Ht7HTAoYCTSHtLlPBFE2YTmLEfXDMcPjqibxGg=
X-Google-Smtp-Source: AGHT+IGUZ8Ht884aEeUTYVeEe2MqsVO/6u1dp8PISpfM1R+i6QN16MXQTuLiaSEKQ77YDUKMvDvv3vrYkrpfc+9ygLbwyBGFmQVC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1686:b0:87c:2f66:70f9 with SMTP id
 ca18e2360f4ac-883f10e2396mr586699739f.0.1754656531574; Fri, 08 Aug 2025
 05:35:31 -0700 (PDT)
Date: Fri, 08 Aug 2025 05:35:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6895ef13.050a0220.7f033.0062.GAE@google.com>
Subject: [syzbot] Monthly nfc report (Aug 2025)
From: syzbot <syzbot+listbabfe0cb0f5b4dc95616@syzkaller.appspotmail.com>
To: krzk@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 1 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 27 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 489     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<2> 333     Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
<3> 83      Yes   KMSAN: uninit-value in nci_ntf_packet (3)
                  https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

