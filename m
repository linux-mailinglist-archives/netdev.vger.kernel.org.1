Return-Path: <netdev+bounces-224766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D428FB8964D
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 14:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6909B173B9C
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 12:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1989230F922;
	Fri, 19 Sep 2025 12:15:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C1630F938
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284108; cv=none; b=UlRa0uBTwDlkxjFdEz4f2ajGK1K5NMHrRB/xV/1XGEa4ly0uhD9puUOUQzm4ieWn17k7MOAZUQDRPvWBbV63pksTZ0WNcyosZhlqBTsIup8D6eRS+mgbTGGDSW4dwOw9WXCIBvmHg1VnsXvPzvme7G4ygBG5BSH1dkx/jTI//+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284108; c=relaxed/simple;
	bh=F52Pe6ZzrWg2xOB535H6naWI5/xjhi+X85EvgHGfIVM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IYYaWmX3//m3CdfzaRRdTMq0PzrcnLg9jqdZGRBED2yJT44euohjUbdAK21WQoepH0T+ee+pqSb0vmwPRC1QgEpS/dsx8wr/Sxtr9LQMjiX/EDy7MfMmRhhRTLHJ78i57ZXL2zTGXEXKHlvV9PR0YehW7pjPI6E3Pl39/cpsxAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-888acb964c8so400108639f.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 05:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758284105; x=1758888905;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaASq3nSPIcvtUoCKBtRJSEolffSQ27wcU7lwN8Kr/k=;
        b=rFqTVvojbxiS/IjeMBQHLV9rcWM+tHX46kiCAqvdjt6JEyRF+sY2CCeWT/raipl0Z9
         qx71DQZKP9o1BJcnzEunus2aTF9b1g5/aqqWfe0JKH3JRNealrkED2mUp/vY2LoYs3D9
         j5+VII1mkSgAXGrh3OL1D6akHzvxfPyIIsQKTVQcolgjrPs2cdYgY3e1X9T23iEVA3+n
         iElu2QVO7QQ285qZ52F6iNxSuLCN6/0kWE3n891UcVVa3ump/ebT422tIfQ1mIYANi+h
         DbsELdVMHcYnR3xGSTTJdUUALMqy4Bkrt2wdi1g+ezvgh/1cyag2VjaCaKcSu14Jzjpv
         z90w==
X-Forwarded-Encrypted: i=1; AJvYcCVqi9qpbD5T1VI2hcu9aB7cN2Xph0Nbp32mlAB8uueoEDVCyuHPjSvi8OiK7Zt1P1tdZeBDf4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh7KGSgDi5/l1TykGku4ykAMDE1luaCFJrcHow2Pxzhp8OmdGM
	XR+mKtOeBIZA5WOzlVn2JljBDhFS8lmdLhUWGZKsWeDgKj5ylvKUl+uaS6kOwGKpZ6hAnQFzHpd
	NYAWpaiei3ibPVHrJ3fN2ZvBCwmbiuJKag422c1EF9AOSqC8CxKBbpQz3WgI=
X-Google-Smtp-Source: AGHT+IE1O8Xc6f8LrpO8boudUphXtvq/ClhpDSJmNM3SJDFi102WGVqC7B7iyKEup+Yu/ybdPLc+8ujPyZ6BW73fph6w1dGTVKQY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378f:b0:414:3168:b9fe with SMTP id
 e9e14a558f8ab-42481991ea9mr59920315ab.29.1758284105478; Fri, 19 Sep 2025
 05:15:05 -0700 (PDT)
Date: Fri, 19 Sep 2025 05:15:05 -0700
In-Reply-To: <68caf6c7.050a0220.2ff435.0597.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cd4949.050a0220.ba58e.045c.GAE@google.com>
Subject: Re: [syzbot] [smc?] general protection fault in __smc_diag_dump (4)
From: syzbot <syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com>
To: aha310510@gmail.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	dust.li@linux.alibaba.com, edumazet@google.com, guwen@linux.alibaba.com, 
	horms@kernel.org, jaka@linux.ibm.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, mjambigi@linux.ibm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 98d4435efcbf37801a3246fb53856c4b934a2613
Author: Jeongjun Park <aha310510@gmail.com>
Date:   Thu Aug 29 03:56:48 2024 +0000

    net/smc: prevent NULL pointer dereference in txopt_get

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=131dc712580000
start commit:   5aca7966d2a7 Merge tag 'perf-tools-fixes-for-v6.17-2025-09..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=109dc712580000
console output: https://syzkaller.appspot.com/x/log.txt?x=171dc712580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17aec534580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115a9f62580000

Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
Fixes: 98d4435efcbf ("net/smc: prevent NULL pointer dereference in txopt_get")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

