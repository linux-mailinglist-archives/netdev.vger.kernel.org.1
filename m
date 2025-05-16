Return-Path: <netdev+bounces-190993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EDDAB99EF
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 12:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115FA16A085
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 10:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109DE22F74D;
	Fri, 16 May 2025 10:17:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF311EBFE0
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390652; cv=none; b=Jmcmdg0z6nF4hvNDDNF49+pAx0iWT48438Pi6QXFPu1R1AKB1pcHxTMryzx5OMIg9/LBZl1xzrpU8P/FfYdbFBUSEfkjoNmJqZIpqg6r+OMqEvI+2YvyV/qf8DtpSieec8SyHqTb1XfGJKWYZ/foTK0FQg3hQhOGZ2ULGgPhGcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390652; c=relaxed/simple;
	bh=Xol6wi0uV1fmTpSn2Y8V20Qyl8nzYWBqxDUmPlg3yJM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lUWAorMlH4WqV0q2EFCuvupUdfpuOn3bgZTPuWCkvReDfE+L+IIOtwNnRd9ekJY3cbWxcgva8SChXLTtygpHDdBw/IfumesZG160FX0UisVGWI8bnUuV394SrWK5RFaXCYk+rgkqme3oGR5zAUkrwNoOWk8RL88/wvWZ2aj0kkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3da707dea42so37922065ab.3
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 03:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747390649; x=1747995449;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6M2DPVjlQQj1l7tZgOW7xpWl0T5tZezkpbkFHSK1Y5E=;
        b=hcXw2QxThKKMIHQaBmOIOdPDTZj+UcJeStEQcgKbOTa1syfft0Vd5aeTG9zZgDrQdu
         r7MnUzSNw3yriYCdoyqn5uTEq/PFMYYU/ItC2xT4ifVKz+r1YGKRFNwJdcq1j5mcNjO6
         TGfbi9AwOryqayZH07v264n9Z7yCB4Oej7Zd2nwyg+upykQ29dqO+vUyf0lbTHUBBl4q
         DTbA8Yxahmdvt3ZzvMbZ5v5SKzrdUD4iLTAKlIQtwoutCDqPwVGDMW/azkhxNaae47Xs
         2FV5JUv1S8cP6DRurIGMVPhXBI1NdS9OjtpjFOVsgBtx2hsy7X8dyt0KdS9f+hQZMOY8
         3Dcw==
X-Forwarded-Encrypted: i=1; AJvYcCUF065BWijPFAU9cZCl/cZLpZZHfEmFLYymIawV+CdQE172/pCc2jB3IWz22BeW2Q4gyiVwiE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTL8gkUYRVcfF6AEA2CQQwBGHyhdcUeNtYImvvb0pvx2vWuizR
	4R2iq04rZ1B39fCe8AMkBi5iqctysMgTd1cwam7F/BJueF9DgNR+xbGfgKzSSDuZaJqJzz8D+iw
	hq5EuGR9QiFpCzRjf2FQytmmhr62RIbZauKMe3jjhlIG3hXawHz5uiM+f5PE=
X-Google-Smtp-Source: AGHT+IGfopz6HPz9olGYC+CF+abURQHYa4/P/72pxan4xxCeMOnsBg7LfD2zgeozwxYJl9XRuPS2SrDFjXshZ3Oivd2P5DV71rBk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c7:b0:3d8:1bd0:9a79 with SMTP id
 e9e14a558f8ab-3db84334fa6mr37329945ab.21.1747390649487; Fri, 16 May 2025
 03:17:29 -0700 (PDT)
Date: Fri, 16 May 2025 03:17:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682710b9.a70a0220.38f255.0001.GAE@google.com>
Subject: [syzbot] Monthly smc report (May 2025)
From: syzbot <syzbot+listf6f56d6a8ea41d6b17f7@syzkaller.appspotmail.com>
To: jaka@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello smc maintainers/developers,

This is a 31-day syzbot report for the smc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/smc

During the period, 0 new issues were detected and 0 were fixed.
In total, 12 issues are still open.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 299     Yes   general protection fault in smc_diag_dump_proto
                  https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
<2> 82      Yes   possible deadlock in smc_release
                  https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
<3> 71      Yes   general protection fault in __smc_diag_dump (3)
                  https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

