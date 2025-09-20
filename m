Return-Path: <netdev+bounces-224994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38819B8CAAD
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 16:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E5947A9E4F
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 14:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69415226D04;
	Sat, 20 Sep 2025 14:49:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD646217F27
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758379745; cv=none; b=PB/RTrkauRqG7D6aQNqSrmiFDl+DGp8tW0gaW92qUW9vNTalcZo0F2jElRWRrVEsmF3/rtHEr8nWWe4a4F+FuRl4SJBrvT5olo9We6FMRhILK8aHTG+Qy9Xa6KGPhCVYDsdnB7nzDkMM0c4lxTDg3i6aSYsorrcaB933KGYwBQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758379745; c=relaxed/simple;
	bh=py5/X+AXsn/PIbThVFg9G5uJ79Hgd8prIN39YDpJVR8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cR+SsIdPjhHM7m881vIASIFBaiHCDc1p0+TitY1PuH8X0QR8djuEorPNBKPoRCkitnQ1BhKoCg6Fqdgr9M9KwqQptDP8HZGkM1b20DIVNVnBWv6KAn62f0EjdJL3LLGk+E3ESzLg3DDeFnNh96Ouk9RNyCTQpcCNRnMnTpqsYa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42486b1d287so32465185ab.0
        for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 07:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758379743; x=1758984543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Op4wMv0a4zsQn3ohVvJ3vaJLGLY9/uII5+oXVI6nU5U=;
        b=Zc64P26yJQJM4SvBwQQ2417FyKjQPQehzE3ICTpzfzTS0P/DbHp5gqvK3B+0ljiBbY
         F+6w8xLiuw3x85Pfucy9ezVyH4bQiEqt2ltDBCRjpBXVBPs+OdGjphbNsT3kG83+lL14
         lorN82VQ4lx/tm/nDv+ceqDt5U+mQjMu04BTys80PYmRFvvSO+G2u3A/F0x9bTFj2FD/
         9Gf1kq7d2pn4R6AOkCnpMitrBgh7bNjOMyfZWNzVjn3YGvviVNc+174cbnDn/0/B/gUJ
         WByuouhm4Jf395poXX73+pmRSiRBHxr9E4/3+Ke+U284InoF2hTCGL7ficJr0tLcRAer
         DwxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjng0WnEpxOuS1QwQ8vt8S8VhJAUWIVLi5PQy1LmU7uT0UXcdqoAzwdoln3K20zCQK5YMo/Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuzqFqUC1pPLqvK6EzBMKcVgp3sqhZnn2SP/pUYEVwcp1pkATt
	O68lil9BONlyveobaSMLAhDTIonXxOhw0AWB661+5+O5CRQ5agmVft1NHTFfErN47UuEgjNd8Bx
	0R/h424m4dfhjCjNQxm4D8AiLxrW+0DXyYJnr9VGU4gJcb0kaZd2ueBfdvhw=
X-Google-Smtp-Source: AGHT+IFgyLiqZ5vxf2NRc7awgzRJ3gTfgIa75hCA5poxEMAjtksUWSNyk0MLOqXZSFnvr6kPEZ3wkaUmrC4eQ0WKQDX9j/xfuQnV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1707:b0:424:2357:d57 with SMTP id
 e9e14a558f8ab-4248198438fmr122069485ab.25.1758379742868; Sat, 20 Sep 2025
 07:49:02 -0700 (PDT)
Date: Sat, 20 Sep 2025 07:49:02 -0700
In-Reply-To: <688aa543.a00a0220.26d0e1.0030.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cebede.a00a0220.37dadf.002d.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: task hung in hidp_session_remove
From: syzbot <syzbot+234fdcc5f6633833a35c@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, bentiss@kernel.org, chenl311@chinatelecom.cn, 
	frederic@kernel.org, jikos@kernel.org, jkosina@suse.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 4051ead99888f101be92c7ce90d2de09aac6fd1c
Author: Li Chen <chenl311@chinatelecom.cn>
Date:   Fri Jun 20 12:02:31 2025 +0000

    HID: rate-limit hid_warn to prevent log flooding

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1128a712580000
start commit:   afd8c2c9e2e2 Merge branch 'ipv6-f6i-fib6_siblings-and-rt-f..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4bcc0a11b3192be
dashboard link: https://syzkaller.appspot.com/bug?extid=234fdcc5f6633833a35c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f458a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1796c782580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: HID: rate-limit hid_warn to prevent log flooding

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

