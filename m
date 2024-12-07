Return-Path: <netdev+bounces-149862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1EA9E7DA4
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 02:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655CA16CFA0
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 01:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B4F22C6E3;
	Sat,  7 Dec 2024 01:01:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F598256E
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733533264; cv=none; b=bsYsHdCuyO155Vs6iOYWi9YOthYT/AfIdK067gdmjJOAFNHB9KqdEbWthlOI1fLDQj+KRCF82ARHab26H6MFKBnwqIzu9jx+7UTVoPNvBtuuO/zJUlha7lGW7ADTPki030Q7Rd8dXG0vbPyTN0PKCAfeR9ba/+rLjylabK3x5OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733533264; c=relaxed/simple;
	bh=u5nYSuuVesD6h7IbFSGckAHDRhurDNBarUCwXsucC0s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gpdqwTK5mpC4fkhpi+Wt9OFtcsoCizbA4mqIIfE3W46kmfXhzHPAz1oWpq7FySLfEzMEcBGR0Wx83PzA5zp7xZKxXUpIU+Eeiz7LH3Bnx6ORw/qr1SiYHE5AmXGEgVFrqJylKaXdKqySYgh3bfJyChMqc9r8t1dQ/tV2N3BM88A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a763f42b35so32228475ab.1
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 17:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733533262; x=1734138062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JvbLDdytkVXjmJCFEeXCmgooAVyAASqwNDMq6NqMYEQ=;
        b=wl2JdRbYiqd5pTiZObpM6ib5t1FXZa9QGGcGGOzpVRo7XFB9xlHwvUzbJ+SUrAQmOx
         tS/DsmDHZ9aC8OKhi86kA1y+U3dDKKbt+cZ4k3WOBI6HqLOEQj9y3H2mYi01JcMqrLYL
         8ao/u1RjV6H/VSfSWRxRivobkPLX4yHdwc6haAmdVUUVLeXuE8kfPadLT2XKg+QSr5BI
         MUsicLcsh8dyKaqqb42fG3h0gKx3g3R6Em1Bljs3ZmX/KuHGUe87flbV7zWTarYTH+vp
         UHgZCA95r/oKeOE/ukIE8w/hr2b34CiCgr9U4kmd6A8ZSd4dDQU7w9YiX6Ap8tcVqFRL
         Ey1g==
X-Forwarded-Encrypted: i=1; AJvYcCWhYp6Hx99nIXvEWjFYpBKskNZ1loJqUkR1FY0qBucZJv1uzE5kbgsU9y7ER0GCygxFxgi/ig0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+p0LE4EZsjIfBApkpWBjvA6mb2AnQ68k+SQSiSXamGxMrD9P
	jxlTLA1QsXxYyD39O4jNElppNXXoPnXatSb60w613dfSxTo3XxDFL3WcZ6t26Xe/PsCVHSUkYLX
	D1dgabklEDmzNnFDxOik0NMTSDrmWnhob+JKyKJk24+yWL11ILkGgow8=
X-Google-Smtp-Source: AGHT+IGWwrqQngiWMnwECL++Pbfxx6p8Bbp69VM3OYAspBdp6DqhMaIJQSDxdHce6v0Fp9jvolV/mRx9u6SQnKRscTy5tRUzIiys
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a7:b0:3a7:8720:9ea4 with SMTP id
 e9e14a558f8ab-3a811d77228mr65586115ab.5.1733533262498; Fri, 06 Dec 2024
 17:01:02 -0800 (PST)
Date: Fri, 06 Dec 2024 17:01:02 -0800
In-Reply-To: <67530069.050a0220.2477f.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67539e4e.050a0220.2477f.000c.GAE@google.com>
Subject: Re: [syzbot] [bpf?] general protection fault in bpf_prog_array_delete_safe
From: syzbot <syzbot+2e0d2840414ce817aaac@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, netdev@vger.kernel.org, 
	olsajiri@gmail.com, rostedt@goodmis.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 0ee288e69d033850bc87abe0f9cc3ada24763d7f
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Wed Oct 23 20:03:52 2024 +0000

    bpf,perf: Fix perf_event_detach_bpf_prog error handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=103530f8580000
start commit:   e2cf913314b9 Merge branch 'fixes-for-stack-with-allow_ptr_..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=123530f8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=143530f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb680913ee293bcc
dashboard link: https://syzkaller.appspot.com/bug?extid=2e0d2840414ce817aaac
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132a2020580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1291d0f8580000

Reported-by: syzbot+2e0d2840414ce817aaac@syzkaller.appspotmail.com
Fixes: 0ee288e69d03 ("bpf,perf: Fix perf_event_detach_bpf_prog error handling")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

