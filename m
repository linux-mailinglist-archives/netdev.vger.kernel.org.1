Return-Path: <netdev+bounces-59743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2377081BF29
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 20:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84171F21640
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 19:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BF0651B3;
	Thu, 21 Dec 2023 19:33:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC0D651AD
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b7ccef58c3so120212139f.0
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 11:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703187187; x=1703791987;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRRWrtmdQ4QO34KNLqgmYN4+lhvlz7DaWL6jC1udznc=;
        b=T/N/BaUUvzOdV+C/yNLrNEQm5c0U86ggi5pg2J8p6VTYjxGC3VAlG1oTMH/i/0BENB
         LmkpVfHanTn5dAbbeGS14u+EPbLhqyfB7QBbhnPWYuWU+kQK9NQuaeURuz05nhE227O5
         4jKASLYysr3GrFwv2+l78HpT++e48Rnv+8Bryiu4B/2JO7+oDPJtC66MvbFftNvO44Nb
         7FONuroDuF8BMWUnNRQimSGp7KtdnX5OzU0seWmn1Qj1D+ksr56NycIwSYXPNltmlgBT
         8REgtPyBdJHsfTA2gJAVJn1PYqkgJCdjF606pcS87AIIbbxrxrt+9rV6LNkZCVD/DWIO
         Yhtg==
X-Gm-Message-State: AOJu0YyKcsjPekPcWXtnTRt7wxoy+WxUX3YfqiBRFuviOGPyDjMCoElw
	R8DN6Zc2ddBDqBEWI9kLPnFK/Ddc6+pYCHc37soGQzr818BW
X-Google-Smtp-Source: AGHT+IGTvqe52vto9JB/yF38DIK1v4clMaMiDt988+wbSuKG+wXwGC+P4I1+eCdSOmFi9qV3g78/GGs5f3pwusB6JkcqF8F3ur3q
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b19:b0:46c:e185:86f0 with SMTP id
 fm25-20020a0566382b1900b0046ce18586f0mr11914jab.4.1703187187041; Thu, 21 Dec
 2023 11:33:07 -0800 (PST)
Date: Thu, 21 Dec 2023 11:33:07 -0800
In-Reply-To: <000000000000f3d57d060d0556a1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000450dee060d0a2bc3@google.com>
Subject: Re: [syzbot] [net?] WARNING: ODEBUG bug in advance_sched
From: syzbot <syzbot+ec9b5cce58002d184fb6@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, leandro.maciel.dorileo@intel.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, vedang.patel@intel.com, 
	vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 7b9eba7ba0c1b24df42b70b62d154b284befbccf
Author: Leandro Dorileo <leandro.maciel.dorileo@intel.com>
Date:   Mon Apr 8 17:12:17 2019 +0000

    net/sched: taprio: fix picos_per_byte miscalculation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116aaa79e80000
start commit:   1a44b0073b92 Merge tag 'ovl-fixes-6.7-rc7' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=136aaa79e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=156aaa79e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=314e9ad033a7d3a7
dashboard link: https://syzkaller.appspot.com/bug?extid=ec9b5cce58002d184fb6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d5bc6ee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1465cbd6e80000

Reported-by: syzbot+ec9b5cce58002d184fb6@syzkaller.appspotmail.com
Fixes: 7b9eba7ba0c1 ("net/sched: taprio: fix picos_per_byte miscalculation")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

