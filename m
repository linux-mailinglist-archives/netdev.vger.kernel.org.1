Return-Path: <netdev+bounces-190633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFA1AB7F23
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 09:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031AB4C64FE
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 07:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B711E0E08;
	Thu, 15 May 2025 07:46:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72F4B1E5A
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747295199; cv=none; b=BDGU/P/i5ppVXurp/gsBxhKD+En2rpDHyTLALt+3er5hjOqo/NDmzcp8Yu8H1Sg6QPWph1I1RIckx0qg5MjIXLmMr5oVu+9ZHCysuRsq5CbL2GBcwsKYDC9utHchhfjqPsdOIz/HIVLS2GAd6/2ZlXu0NwBDAbcwbLs62kAlOwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747295199; c=relaxed/simple;
	bh=GcPWC9DTX9rlILvVyRFyZgGWozsdOzRauear8FzHQzY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u4kDgDIl0+AcvLEw0wb14LH+WN1JWsdm8nZDKsI0yJEpnAlv157jhAJxya2YNW2KNk4XVTkRImFTmosK92HL5IP37hvucc3t0jaic4RNVkYk61MiPqXT1IwetdN0PzOsEg40PEhi3+DT576PHG7pHtPXLzi8SnPTVc/9YJ4tWfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86195b64df7so103429139f.2
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 00:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747295197; x=1747899997;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S86UjQFMGu5iYwtVlwx0AEIGx4zFd27s3P2snhatw/0=;
        b=os7h8aHy7M5Q7T4n8ZUou++yoDkr70dTi/snuFfm9TB7xXCdtjTBdNPCD8yx/4efy+
         i6SGlSDE5u5IuQqkV2bgW3nxNTmIDRuymkLqo6UGlOKKi6x7WwHYQ2hQVeBKQUuLK5YC
         FEUpHmBEF1KDqv7QeR7+T+F5OEhUNTZBqkIP1pktyvCDSXgya8fzRB0izAm8NDHSrrZb
         qozTlD2M6f8CJz+L5rWEFW+/0vZLrTIZ6A/oX7E10VpyLGGVhnQ06uAMCIOmbyWgRFPJ
         o7nJ1CVYR7P9kvshrdsBsX84jx+gbormZbV3hGvPmFaeLERHzxxRM+sn0P70jsHQ3Gkm
         CjUw==
X-Forwarded-Encrypted: i=1; AJvYcCUOiqZnMQSQbHyeqKtuCvZFgSP2ovgMQnSr6Fz3zTqEeELEokDEpUGc2FVGZafSLirKS0BNi8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0JKE6BOQmyOdGlPO5NC6hHTx3eRYfQVGPc0WM3+XFB95IoNks
	YfX4KsceV6X2g7eFB7ZgWmMpVhOeYIGtlGG1M6791r0CYAybYkukyZIFqJYYlpbgpnUweA2SwGa
	VTDzeQYRTBTIKy9ngBS+2awXE95ftNiPutp/GgqIYHHSdUUvF4H7T3Kw=
X-Google-Smtp-Source: AGHT+IFoNQrhWrXpNLY7oh5rJ2tJ3Nb5XXwI5DRU6GxO6PTblFimDaCE8hr8eSKPRhk6PwZQLqVfgGYEsjiTdbz8CYNpTJjk9hQY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:dc03:0:b0:86a:93c:f5fb with SMTP id
 ca18e2360f4ac-86a093cf6admr582105939f.1.1747295196799; Thu, 15 May 2025
 00:46:36 -0700 (PDT)
Date: Thu, 15 May 2025 00:46:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68259bdc.a00a0220.a2f23.0198.GAE@google.com>
Subject: [syzbot] Monthly sctp report (May 2025)
From: syzbot <syzbot+listc23b11af384e20c3b1fb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello sctp maintainers/developers,

This is a 31-day syzbot report for the sctp subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/sctp

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 70 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3934    Yes   KMSAN: uninit-value in sctp_inq_pop (2)
                  https://syzkaller.appspot.com/bug?extid=70a42f45e76bede082be
<2> 83      No    KMSAN: uninit-value in sctp_assoc_bh_rcv
                  https://syzkaller.appspot.com/bug?extid=773e51afe420baaf0e2b
<3> 3       Yes   INFO: rcu detected stall in inet6_rtm_newaddr (3)
                  https://syzkaller.appspot.com/bug?extid=3e17d9c9a137bb913b61

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

