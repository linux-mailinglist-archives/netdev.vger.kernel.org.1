Return-Path: <netdev+bounces-224613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3879FB86F00
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01CAF582304
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29D62F3613;
	Thu, 18 Sep 2025 20:44:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3392F28F9
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228271; cv=none; b=o38l8vblsMazZlQP3vaP5NxnICiLddMlYUpEmZ2mwDw8JsNYGsAvD00/BdaoUQx1elj6BZEv9wApa3ZRpD3eD5FWPLMeOiy+u6yS2M5ALwul6pbqLjyYqqIjii3+ryNDNKWhz+jKMsUbpH7HcAH8zWtFlSCkzJTi7t0L4HrIOcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228271; c=relaxed/simple;
	bh=NfiIJR6kIHevsUQujY5aQQ/4j2GVgOuNSAyAHQIKxjE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mS0AeQVDxl2foFiOTRxZZJt76w/yoEhWTV25sbRu7FgZybkI1/YciBzFF/nBCdsa1n/8jIGQB4z/itY9sf4oaG9avh1NR+R8h86vIJOgiUKhOwyV6Ytm3BWf1yyM/f8IcfTRNFlch1KnJpyQUkU8urwy2w1ivMB4h7lUVCJmgDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42404e7bc94so36848125ab.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 13:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758228269; x=1758833069;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jy95kM/qgX/gO/SpA4ej+P7GNTHFDJ+aCcX1GcgB2yk=;
        b=LtOlKCBPiz2FWzIjYvJMc3BvMrHjnmebo5STyOv4NCBAvfb02HdiB7E+QMUXLK96aD
         Aaqzu5DHUGctz+KqxFWW8ys3cUjeNq7Iq79xe71S9rLj8eki0mUevcs722WFpm+dZ14S
         AYQYKMCoWSi0xqo8Rl/y7DlhXFvvuKEK61/9/ZwE1DwjiKiEdhiX5Is7SKw4yxXckuXr
         rH7oqty6EFubmfKtukLtRZ89wf7NrvtP7YuVVfw99cYusgftO7Lip2wdlYz1cLd3AQ2e
         oYCtKvtnjHQ/7STqP9csmSEjo+lF+wfJtdZ7Bb+wMRyRUHdkxCYW+sbpLvixsGVFvlwI
         oatw==
X-Forwarded-Encrypted: i=1; AJvYcCWsyDa/9/E4DQ5zqbsz767uU+eVM0uys6vtuoWd8orafz+6Hzmd7/1xYjx9cRgcNR/myHxM38k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgNzB7JEMLKjOsrttLYXc2RTGWAlrjJoBchobZb2YCwuI74fBi
	TnIIRRKFTal6PZxkRsDPyrL0ttyzT2y34pkYgwxMeacq0DrlWeNOsRVYDI3OkX+2U0gzRTL6Fmp
	qX1QPZad3v9DMXP/frFMi0I5ZyaJ6+LSGr6R7nRwBYid8c5JIsTIwXqiyfMc=
X-Google-Smtp-Source: AGHT+IFu1MADOFwiTOdU5yaJk1ZgNZavxLZ2jQpFx0eMPLtJmGm9swFNp0+N1yEJNO6C9z/DFUwMwah6rUU7Dl2Hk1mJlu3m/iVX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdad:0:b0:424:8160:46de with SMTP id
 e9e14a558f8ab-424819bcc22mr16145105ab.28.1758228269425; Thu, 18 Sep 2025
 13:44:29 -0700 (PDT)
Date: Thu, 18 Sep 2025 13:44:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cc6f2d.a00a0220.37dadf.000a.GAE@google.com>
Subject: [syzbot] Monthly smc report (Sep 2025)
From: syzbot <syzbot+list16381c3f7f9f0890654e@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, sidraya@linux.ibm.com, 
	syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello smc maintainers/developers,

This is a 31-day syzbot report for the smc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/smc

During the period, 1 new issues were detected and 1 were fixed.
In total, 6 issues are still open and 46 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 484     Yes   general protection fault in smc_diag_dump_proto
                  https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
<2> 128     Yes   possible deadlock in smc_release
                  https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
<3> 5       Yes   general protection fault in __smc_diag_dump (4)
                  https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

