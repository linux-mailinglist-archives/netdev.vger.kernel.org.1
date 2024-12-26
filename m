Return-Path: <netdev+bounces-154281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2B29FC9DF
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 10:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49DF316307E
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 09:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99121D1730;
	Thu, 26 Dec 2024 09:01:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0B15A85A
	for <netdev@vger.kernel.org>; Thu, 26 Dec 2024 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735203691; cv=none; b=Qli3FSX+gnFPPd8kO4smA8F3V37lI2f3G9Mfwa9rAY4V29opTM1fXMqRIpsHGEpAIoVPCg9jkEIFP92i4bimYBA5wTmhNF56/tSUiIZGSx59kGIBW0jB1Ro6gxM7djWxmtHW2kG/DSXcHllLcRSe+Om/S3lBSA61hUuUKDiQtQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735203691; c=relaxed/simple;
	bh=1n2kv7SMgwvHUd51D3IJmhRKQ9EZM247BVEQrJC+mCg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ponBJyAZmI+JaTuM0BycitT2lh7jlT7MJ+k+6kDDvSjnn61eiwOzwY/GW3CafgEe83bWxblsu+ti1ODNrpLuXp7jZf0/uH2E8aj0sA+YA+wD5hJsff0+utozHLd3/8V0dAmxyFAFXlPvQdXUXIjJywOleRKIi4WwXar1vdNMitg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a81684bac0so131005475ab.0
        for <netdev@vger.kernel.org>; Thu, 26 Dec 2024 01:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735203689; x=1735808489;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bp9tKkCAuQ/mUk82Cee4vQoXoncTsTYSSaG8UciEk5U=;
        b=M/AqCJei3v6CJrDFbM6RFqZsnJbRcAgy6SZZ3TXOIXSxc4IM/1fAF7X9gNxbMLvw4i
         BWu2UVgt35QoC1v0Kisvk3Qh2/t1tZeGMVZj2Dz7z7k/EjeoybmyAQIeie/9Ij3CiDTy
         mrAYxIQ+5FHlKlvCLk80v1dzU9dkOmDIC4/enWCViAJid3A4wMRUztebhR17AUlqR4Rc
         DQnLSoyCJ1ADLPBpBJuFPcpCoaiYciAFUXEn6VDDgLxvu3t5vJtarT57upKonZq879Tp
         ivUE9uNs8I6sr1eiqEsd3U2ly0NMye0/QM+v3FFwDCF4OnNFsuB//cyct1zvd05GtuFz
         amZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1pmMmUTtjEQQdtcHu0CiiFMOQjTGPz44dNg/ghz98PULs9UjNwFjVfVPsM0l/9WcL/xuwy1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzngvGeKyskm8NzmT1G3fcWQiGpWW0Mhbndm+hWE1mpG+Z2M+t1
	VOgWhKTZfYSLR6FG6hZGqnyr6dEMmYepNIBI3qe4uhFPqtihe92O9RrorDYiWTdPyUWtUXGibQU
	HTLbQZjbnwVM/oCQjoG4OFhFFUmLie6/WcVJ3ivSl58lG0VZTuTe2xVU=
X-Google-Smtp-Source: AGHT+IHdTuf04TZ07cOEb7uzjG5uOMY425hqGzSFm/TphbmDrUUYrbdL0ySBLKSKwqxl8hqwMXDOstAHnkwyauM4UD6T8tYlXB8U
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:1948:0:b0:3cb:f2e6:5590 with SMTP id
 e9e14a558f8ab-3cbf2e65718mr26619235ab.0.1735203689309; Thu, 26 Dec 2024
 01:01:29 -0800 (PST)
Date: Thu, 26 Dec 2024 01:01:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676d1b69.050a0220.226966.007e.GAE@google.com>
Subject: [syzbot] Monthly wireguard report (Dec 2024)
From: syzbot <syzbot+listbcd07c53ebf03869ffc2@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello wireguard maintainers/developers,

This is a 31-day syzbot report for the wireguard subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireguard

During the period, 1 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 19 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 345     No    INFO: task hung in wg_netns_pre_exit (5)
                  https://syzkaller.appspot.com/bug?extid=f2fbf7478a35a94c8b7c
<2> 98      No    INFO: task hung in netdev_run_todo (4)
                  https://syzkaller.appspot.com/bug?extid=894cca71fa925aabfdb2
<3> 2       No    general protection fault in wg_packet_receive (2)
                  https://syzkaller.appspot.com/bug?extid=c0f4a2553a2527b3fc1f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

