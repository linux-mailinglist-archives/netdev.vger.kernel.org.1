Return-Path: <netdev+bounces-60206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841C281E1B8
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 18:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246B71F21E9D
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 17:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9116C51C36;
	Mon, 25 Dec 2023 17:31:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4374152F6C
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35fe138e332so30197425ab.0
        for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 09:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703525467; x=1704130267;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFqI58q7VNYJmMslCgc+pTUxt4F8ra7+YSzIXJuw1CI=;
        b=P0U2N2n4/RBgZXKRySo4VcH4C/20Sc+p6PQnSIbmbWJrRl/JE3dVFhJGDe3Jubg2Ks
         yzg+j50VDORuqdmvfnUwtuadrC8gRleYD/5lUcD3sPUay8jRXKR3Lg7gifDqbV48Ltlb
         zioPCj5vzte+1BxlToOCt1VaSormEphGQuBvLMRtL75NUsMqRcNz+vVaPL2KJRDA7ePU
         mdfoeNoDAJrUMJtTt3ZEvFmEGjPBP4D07umOppFv3WaBmXCd7XFgdhNv1XdLQPlu1RMl
         7um+onvw0pwkMOrGQqyXPapTU+PM3u+dEj7E9RZanMl2QBSd74L8td0Mnvnkfp48cyko
         YInA==
X-Gm-Message-State: AOJu0YyajfhztDWtJ9IaAAvu3fCa62BwAxn8099yJjw9qeY+WWdcX0fO
	wN0y+Zpa/WZxt75NYe7S8djng2vMRVJU/Qx1qizp/ZdZqRS9
X-Google-Smtp-Source: AGHT+IG150p2eMqab1PfIi2zECmHDFBS0UnssC+uKVBgIAlE5EIKxdwzS9Wj1PI8eSGg+CAuQ8PyuEKXFEI4yjrkYGt1uF1mvnCE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c243:0:b0:35f:e976:3283 with SMTP id
 k3-20020a92c243000000b0035fe9763283mr613348ilo.2.1703525467494; Mon, 25 Dec
 2023 09:31:07 -0800 (PST)
Date: Mon, 25 Dec 2023 09:31:07 -0800
In-Reply-To: <000000000000e8099a060cee1003@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b23dc060d58ee7a@google.com>
Subject: Re: [syzbot] [perf?] WARNING in perf_event_open
From: syzbot <syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	netdev@vger.kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 382c27f4ed28f803b1f1473ac2d8db0afc795a1b
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Wed Nov 29 14:24:52 2023 +0000

    perf: Fix perf_event_validate_size()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170e70cee80000
start commit:   5abde6246522 bpf: Avoid unnecessary use of comma operator ..
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=148e70cee80000
console output: https://syzkaller.appspot.com/x/log.txt?x=108e70cee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f565e10f0b1e1fc
dashboard link: https://syzkaller.appspot.com/bug?extid=07144c543a5c002c7305
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14857e81e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1126ac36e80000

Reported-by: syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com
Fixes: 382c27f4ed28 ("perf: Fix perf_event_validate_size()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

