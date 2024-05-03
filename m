Return-Path: <netdev+bounces-93351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1598BB468
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 21:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92157285D7B
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 19:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56304158D67;
	Fri,  3 May 2024 19:58:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2AD158877
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714766287; cv=none; b=XYc8PgUnTbLzhs3pmlN8VXSJpAgLGGlZZRjAX7V7b0A7EjNVf2RmGsx9owP2r5g7QK9bUYtiY9xb76OLdN/4ILS+TxYxKalfacgfxs4gxwoIVYIKEFHPRxi5j/RFBKZZ0q+fCMa+dBQGOi0K0HjYYk5XWSUvlZj76nL4IjF2J5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714766287; c=relaxed/simple;
	bh=GxOghFVCZOu1BSfEKDJHdFXujzxM0Vhi46jNlkXNViI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BdYUY7uVstJMo52McjZW/4HhywUgjcq8ybKYqdjbm4F5WmqgXrR7AauhGnl0kf05qv+uHRnof60yJF2H53ZyWx5tfpLiHAs8Xx3013tjOq82Powpg9yZ5tBEAdnK5g8msmym25vcAm1hi2DDLAIh/NEWXLvybCo/KphMy2kjDh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ded5e00bf0so5450139f.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 12:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714766285; x=1715371085;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pwVY/fyH1gQuGakUUTvfCy/Q1T0f0xT1xNncswAUms0=;
        b=DkLl9Esded/vpRQo82KUCCBCUKxHUnB8n6OpR4+FzRY158WJCWPxzxCD3p5Y8A5DU8
         kFWqaGaAefPDMOmOpK8QsNpFkO53XofxC/HwVkkPhOihw8yG5zMu+nawkr+Oa7U+zMaY
         C3lN+FRAMXt8h2jNp658DFA2zotTsbPL+jcKymN5ew4Seig0FggngG1XVUoQZkQFnFtN
         ncQ0Ko1UE++J9wxC/k5emDFT1zDC5koxwQJPxSBsmJ6l6EMGh4VO91KtzSzF5uCkqxJt
         Zk4UfawLzfiQ6jMo5l1yXNQLZHTdlxfpAdvxzaul30kD0m/tmL26+oI0TW8UyMW0nCBR
         Seog==
X-Forwarded-Encrypted: i=1; AJvYcCUz5twE3QgMMh4zwTmoefTJ4sShyvj2c4SZTikC1omOS1QSZykCEc14N3OKU6Ph+U+l+Z/WCp6U3iL2ZlRiSB0KhbhoDWYc
X-Gm-Message-State: AOJu0Yw9coVo/yW7y8wQeHetS6ReJj116MW1Zs4hJR9vaJ7utcb1sFFK
	iOrlUNPkG/+2N5iwAD7Prb0vV+sVqxZLoU4J+e9ST1IQr1tjrqK5+CuAdqY6wac0VE6Zjrz7zuF
	G7McRLKgjLcTnU/psEZCNikMOQ6pDcU5rklaibmRevh6UphPg8LT/Dn4=
X-Google-Smtp-Source: AGHT+IFsKhYlfy6o3M/ol0YgBhmeqITegGAPVwX3qSt2L72wwyPU5neB1NYYig825a03FvrKiVlSZ/AuOfzjIlZAaX292wXvouR3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218d:b0:36c:307b:7f08 with SMTP id
 j13-20020a056e02218d00b0036c307b7f08mr196694ila.0.1714766283713; Fri, 03 May
 2024 12:58:03 -0700 (PDT)
Date: Fri, 03 May 2024 12:58:03 -0700
In-Reply-To: <00000000000022a23c061604edb3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000036c3d90617922353@google.com>
Subject: Re: [syzbot] [kasan?] [mm?] INFO: rcu detected stall in __run_timer_base
From: syzbot <syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, davem@davemloft.net, 
	dvyukov@google.com, elver@google.com, glider@google.com, hdanton@sina.com, 
	jhs@mojatatu.com, kasan-dev@googlegroups.com, keescook@chromium.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, luyun@kylinos.cn, netdev@vger.kernel.org, 
	pctammela@mojatatu.com, syzkaller-bugs@googlegroups.com, victor@mojatatu.com, 
	viro@zeniv.linux.org.uk, vladimir.oltean@nxp.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit da71714e359b64bd7aab3bd56ec53f307f058133
Author: Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Tue Aug 22 10:12:31 2023 +0000

    net/sched: fix a qdisc modification with ambiguous command request

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13b9b317180000
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1079b317180000
console output: https://syzkaller.appspot.com/x/log.txt?x=17b9b317180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=1acbadd9f48eeeacda29
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16435913180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111600cb180000

Reported-by: syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com
Fixes: da71714e359b ("net/sched: fix a qdisc modification with ambiguous command request")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

