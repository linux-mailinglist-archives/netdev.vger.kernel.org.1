Return-Path: <netdev+bounces-128402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4043E97973D
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 16:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF4A6B20DA8
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 14:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8560B1C6F54;
	Sun, 15 Sep 2024 14:39:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8FC1EB31
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726411164; cv=none; b=eezhdNPfXQeYih2eQQK2F0XgvT/W+DbEVCdMuWxVNgkQDM4Ufw0mKkh7+15OFGQrZHdiSMNno5YBV4mJhDHyE2E1QRgHGoax4nDafe4IL+bGoqFxbUi5A2wlXGDpF2eltYLFlDnuksv9szEaiAZJAV+zcaw/wY/gjqJJVGUZJrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726411164; c=relaxed/simple;
	bh=sP4jgrmmfEBdugsBMtTm54HDqgh+RebnBva5M7bLO8k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PmmqAYncISh8QhfUEiSJf0pDoflG+wx1H9Aa0yaz+KlaYhjNo+bcpeE9oIViquKqa68+uCkbWGqpSq9fS1Fqg6UdafLD2l8ehmGuUThG8kNfKI768Rz1ygDkwYo24GOgnW7vX+tLVDTiDwtkwKhwfUCfe900uCUqK8KQO3jacd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a049f9738fso68907025ab.3
        for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 07:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726411162; x=1727015962;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pRoQrrO88SaCzlahLfAtzhw8yyIVL+w80a86nD+hlh4=;
        b=RkiutV2OmXsYr8z7vY+VL8Mho0EzgSZrcuXFJbIwAHSnJErGwSKn1BZkHxMwPXs2sx
         ISBkYjEIDIIOI8YbXehOozHiNje/qUDxCp8njA0WI9QNKK1HLPrxsuKPJ8jFmMhcGY5r
         hXFawNALuqyl4Pbowco6LcKzpQK0f9cZCBLgGGWXo7GuZbSUd0viAq0NHjKxV7PcpCgK
         Ye5Udhb4onnMk83iAYdI/kD96R/9VSDWqp8IkyuZg/vUJ2c51y0Z7hSQPDZ/V2J5yAYL
         hIk98hwl7+shHYLUaJb6RL1WRjH4bKrHM3r5ADLmb4qENgPYloLaD5cH2L8B53rzmgjk
         +NCw==
X-Forwarded-Encrypted: i=1; AJvYcCVsapr9cdRBfTWwtX7N8dUy1UNjtajcnIW6ETUShK5UHxH5LKCC2KPMlOD/kjkebZHVeRAWjoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHK1TpXkUd7rAN7j1K7jI5fBGoEUUFXBR6J4/2z14F2Kf9s3JI
	S7wKlzOtIUnabIXbn0b/BH3ALjbbO3b3m+En9rVfdFzuPG21CYupmlze73/eerOvXmyQufFMOIG
	ZT8kVCA1vG0wJjlO2pSat3PvUiJbPNZf8Jm+OnmNYqF5VwHnI9zZNOvk=
X-Google-Smtp-Source: AGHT+IGmQKXv+bq140njVGpBEWOL2SN219VKri4+PIWgXDGb33Z1C7b6Xke3DzLHhzJod9BEerJISpoK8t5gpvnkw8OmJ2ay6r5n
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1543:b0:3a0:4a91:224f with SMTP id
 e9e14a558f8ab-3a08b6f87edmr83293015ab.1.1726411162152; Sun, 15 Sep 2024
 07:39:22 -0700 (PDT)
Date: Sun, 15 Sep 2024 07:39:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e9a0e0622296c4c@google.com>
Subject: [syzbot] Monthly dccp report (Sep 2024)
From: syzbot <syzbot+list8e7646c17f00ffb612e5@syzkaller.appspotmail.com>
To: dccp@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dccp maintainers/developers,

This is a 31-day syzbot report for the dccp subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dccp

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 7 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 107     Yes   KASAN: use-after-free Read in ccid2_hc_tx_packet_recv
                  https://syzkaller.appspot.com/bug?extid=554ccde221001ab5479a
<2> 57      Yes   BUG: "hc->tx_t_ipi == NUM" holds (exception!) at net/dccp/ccids/ccid3.c:LINE/ccid3_update_send_interval()
                  https://syzkaller.appspot.com/bug?extid=94641ba6c1d768b1e35e
<3> 17      Yes   BUG: stored value of X_recv is zero at net/dccp/ccids/ccid3.c:LINE/ccid3_first_li() (3)
                  https://syzkaller.appspot.com/bug?extid=2ad8ef335371014d4dc7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

