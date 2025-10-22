Return-Path: <netdev+bounces-231572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1F8BFAB35
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 592924FB64E
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79312FD676;
	Wed, 22 Oct 2025 07:53:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F392F2608
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 07:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119611; cv=none; b=WQ1HLiFN2VMLqBYF+b+LR0S5x2cQ6LT79HbjhDoVR4YYiZh80jjSoAHPViZaZ1u2xWWyEdRbdVfl86JMWQAC1+LAO6ZCqtHzjCfIPjzEqHfX/6ra1g8xZJyG3CW5vCMLs7wHc5oCtvXfxZMyp30uCC+CxrOOgKYNUnKcsXJlrr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119611; c=relaxed/simple;
	bh=ufaQz49n6GDzpdFGe7nVKvW3X2a8XA6eNMe1oyPxgyU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UkaDXml+MgjmLG25Hl1WRfCwQqZITNK2IIj1g3qNjRIlVcErfUbhdrC7d4NpUGq4eddUlK3dSP5Y4vKFS/IkfXQlcg1GZ+fGIuLR8+dhabKcDvomre0zDvJeZENqFlIL0blhqHiWCwpuMPAwR5XbrGmSNwaPdWVZIqAFlpLDO1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93eaaa7435bso437317139f.2
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 00:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761119609; x=1761724409;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9BZl/sACGkzllJfolRARBo2gSVYuEA7sZCtXyyRozaA=;
        b=qFu4MvuJNmDE4JWRCNM2wuScJaifkJGI4fuwyHEb/NspYHPUAbQAOaCrfmOs4E4KKx
         VZ9EuD9Om2eYgL+tTySh02FFj4Aa0Q5EL4edKiu+P3VLTWyTjZ282BBibDImt4uG2Xx1
         uWr/5d3zjOMLyyMOdAjBUx5bGvX7ZyVqGTm06iqNCWqqr65qErUPS5qna2Mu1HcXYpJl
         uW973ELzbxDGYZZrxuMa+nFY+1d7DrEE9X2E10VtAgRN+KpCKkfklV3x/COQpiOaFCFg
         fQY/H3ccKVkrUIfrNTg6IIL+egAADPu/nt2yG1Amto4EAuVpzjBqvOe7AreIZLQmxfWV
         RUIw==
X-Forwarded-Encrypted: i=1; AJvYcCWVBuPx8T3wnW6dtDc5/Wl0Q+7fCMrQl/BJ3smj5gnEwRBHlHT/CE5NjzRQAsBeju9zXRToqoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxokGWxD1oF2Kx5ZQqTd62Rb4OP7k4BC6p/cE38FGb48/eN60c+
	VdE57SSAvh9yXgCuy6U4VTaLBMKd+/CCUEAVh7stYJhYwAuvWbpTrIqWq49/oH9ullqgEQVvbLE
	RAnnxEAvAMfczC2xlsrHfzwEgQXNNgC+JgnZKIbTnt2bAINaG+DffUuBeJUE=
X-Google-Smtp-Source: AGHT+IH9xYY9rCes5+PP6dDPXa/IwAKtwc/tmp/IjLpaD9sBIBOYjZMLkWP3s5EMxOBU3H/gGQ4hdPoWGEccuBCz8qS+ALCwTcPJ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d8c:b0:93e:7edc:12c with SMTP id
 ca18e2360f4ac-93e7edc1fb8mr2484491039f.0.1761119609102; Wed, 22 Oct 2025
 00:53:29 -0700 (PDT)
Date: Wed, 22 Oct 2025 00:53:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f88d79.050a0220.346f24.0039.GAE@google.com>
Subject: [syzbot] Monthly sctp report (Oct 2025)
From: syzbot <syzbot+list414156adcf2ae8feb6cc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello sctp maintainers/developers,

This is a 31-day syzbot report for the sctp subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/sctp

During the period, 3 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 75 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 111     Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe
<2> 34      Yes   INFO: rcu detected stall in sock_close (5)
                  https://syzkaller.appspot.com/bug?extid=9a29e1dba699b6f46a03
<3> 1       No    WARNING: refcount bug in sctp_generate_timeout_event (2)
                  https://syzkaller.appspot.com/bug?extid=b86c971dee837a7f5993

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

