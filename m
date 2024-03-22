Return-Path: <netdev+bounces-81273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA967886C6B
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 13:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55CD2843B4
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3571E446BF;
	Fri, 22 Mar 2024 12:56:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64CA3B2AD
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711112182; cv=none; b=RBwlvmh/TX4Ucw9H6Gynp+qf7cDkFg3WRnRAE1Hcgm9bOxD3p94QQTyifeLbGt5iC1mL2wDECk+B0NRkxgrCWqtOy6zKpw29kdW/HqeISnswkXR114MHVaOGSS8RB0ZOBqHMDmZ8PEsqN26GqZtCi3pNBYfxUhUk9rFkx05RQU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711112182; c=relaxed/simple;
	bh=AKxsIZe47m3HwkKzZpHYJnNtFzfNN0OZqc8+pBilnfo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GSW97jFmBYv6yT/cseasoEB4s3GLNubCqUDDLmRS3qAfTPvglaR9epvW4g3Av6HmMUUxhZ2KGlRX5KD/7FU4VVzQLLzb3p1ZXBde8xtXKW858xu7to91YN4yyulq9CLtvqpM2bHEPsI+08MaafZ5RPY4SexnT/cWbSPtLu3tUyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c8a960bd9eso187305839f.0
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 05:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711112180; x=1711716980;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=as3kHiPIe02alo97ccAAheYCyCVs1t+AreIadrBewbU=;
        b=g/l5HRXfjDN7Aw+qU0gVRnxR1Yy1q+K6pYdIwAd28SzoQXYRyy/DMeqBk/4OaLEAqc
         8omU77+jVf4xgiu9z1iOPmAnsAYtjQNhzuInvz5rLmx+LLPlF8/R1v55LR5vGN5EqppI
         6Q8ZspwPPmiiw8549MLnjqwK4IOd5+iMDNsG93D5CI1L+AaZOWBwY9+vX/5Jx0JlWGau
         lG/R2ZM5Mh7OuSrCC5tGqmYoQFVTJN5D9ExGMqvIG0keLm/jAZ5ZlSYhpH/13PMkaD9E
         w1jkXM37pwvCPn/xgyaAs7OL1klBz3MXPFHZUTVxRms6/o7iyW6w2TukqOPa2AktlCHA
         Zuzg==
X-Forwarded-Encrypted: i=1; AJvYcCU8vcphmZCr/UpR2MANHFZsQ8BpYMoMWrgS1ZW/BG/JqfBuDpRrFSJM7WuBwMXQ6AmfbVn2TMJ5LZiia5ilNFdC2g5LrI2h
X-Gm-Message-State: AOJu0Yx/S3fIOleO9ZY2E7E6YJSsAFpftWcePWA/QO0F41a/cBx6eOSy
	vR3YqEuNVsWTLBE6jxyNDIZo3854fESWQoquPgHhyhAXjnsRGNqPxCmol5HFlkps5/iDcpIVvJr
	oeUY5c+cs7l+PmcXIlMRq+g9+MRwibcIAOc3NF9DUffiEp7ZVon/lXxg=
X-Google-Smtp-Source: AGHT+IG86pGwdCn0JEExxN2xo64ljJuewF8hAjPl93yXSVAUqGKIY+C7rCnNwzMBrtKUuEATBsFMxnyobTw3G0++DGZZWolC4u6/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3411:b0:7cc:1019:a69d with SMTP id
 n17-20020a056602341100b007cc1019a69dmr138660ioz.0.1711112179969; Fri, 22 Mar
 2024 05:56:19 -0700 (PDT)
Date: Fri, 22 Mar 2024 05:56:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8810606143f5948@google.com>
Subject: [syzbot] Monthly hams report (Mar 2024)
From: syzbot <syzbot+list8065faf9059b8f933690@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 32 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 27      No    general protection fault in rose_transmit_link (3)
                  https://syzkaller.appspot.com/bug?extid=677921bcd8c3a67a3df3
<2> 13      Yes   KMSAN: uninit-value in ax25cmp (3)
                  https://syzkaller.appspot.com/bug?extid=74161d266475935e9c5d
<3> 6       Yes   KMSAN: uninit-value in nr_route_frame
                  https://syzkaller.appspot.com/bug?extid=f770ce3566e60e5573ac

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

