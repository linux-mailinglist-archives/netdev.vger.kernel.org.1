Return-Path: <netdev+bounces-45613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E917DE934
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 01:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6255E1C20B9D
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 00:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120B639D;
	Thu,  2 Nov 2023 00:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A48386
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 00:14:09 +0000 (UTC)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CA811D
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 17:14:04 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b3447c72c4so644132b6e.1
        for <netdev@vger.kernel.org>; Wed, 01 Nov 2023 17:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698884043; x=1699488843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3o8M4olUhxGuYhfUSjcCSpJU5SY7A9yJ4TSgZavfZUU=;
        b=Dpkp+ZKk5fVuJ7AGPeEhw3Pq3wNUR9Xr4R8nzhDbp3LSEQ+K06vKRt4ORzdTTUey/j
         /lDwyUDSV/+tQV9ZDJhhrZ3612zz934RaLjJ/q4ztrnx3Rcsg5jiVI3Y/Vo0n3DfaWkB
         Nz2f2zLv5gssB7w/UxNHg2pjPI19xlm6W413iUWMIbc3TlgUtooLngH6bB9TpzVCN28i
         IjOo2psoOHtntTZMws6Tz/Y6GsAbmLXKW3Cazk/JdgWdSMOUJZ/1ivzk8cnOSqpd/U1v
         /cwAERcMQlHSLt2+3I6+VZHCRtRp1Zm+RG9gKz/gVicrrxQy5tzmmiGBebJV1mz4uvcs
         6l7w==
X-Gm-Message-State: AOJu0Yxy6thwnM3PzKeGSpxDcQMpjVJ9Y1d08Iy0yP5WkNwvOqmMjpBR
	8x93sqEVtJJ5lLzVEN/nQs8UBeUX/FPVnxktPUVLpJOJyYQ/
X-Google-Smtp-Source: AGHT+IGXujbYdoaOwMiOFafFIW9sSBBYTm1Pp7ERXnBxyhbhAcfk6UQLTv/cxWX2Xmxo1xLz6z1fbF2B0KrsJKybb/11d1grAeua
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1304:b0:3ae:15b6:3292 with SMTP id
 y4-20020a056808130400b003ae15b63292mr6713187oiv.4.1698884043406; Wed, 01 Nov
 2023 17:14:03 -0700 (PDT)
Date: Wed, 01 Nov 2023 17:14:03 -0700
In-Reply-To: <0000000000003495bf060724994a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec03e20609204362@google.com>
Subject: Re: [syzbot] [net?] [usb?] INFO: rcu detected stall in worker_thread (9)
From: syzbot <syzbot+225bfad78b079744fd5e@syzkaller.appspotmail.com>
To: admini@syzkaller.appspotmail.com, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, gregkh@linuxfoundation.org, hdanton@sina.com, 
	horms@kernel.org, jiri@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com, twuufnxlz@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c2368b19807affd7621f7c4638cd2e17fec13021
Author: Jiri Pirko <jiri@nvidia.com>
Date:   Fri Jul 29 07:10:35 2022 +0000

    net: devlink: introduce "unregistering" mark and use it during devlinks iteration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1758e1e3680000
start commit:   1c8b86a3799f Merge tag 'xsa441-6.6-tag' of git://git.kerne..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14d8e1e3680000
console output: https://syzkaller.appspot.com/x/log.txt?x=10d8e1e3680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11e478e28144788c
dashboard link: https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155614de680000

Reported-by: syzbot+225bfad78b079744fd5e@syzkaller.appspotmail.com
Fixes: c2368b19807a ("net: devlink: introduce "unregistering" mark and use it during devlinks iteration")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

