Return-Path: <netdev+bounces-51217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B29B7F9A97
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 08:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE811F204E2
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 07:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74465FBF1;
	Mon, 27 Nov 2023 07:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4919F137
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 23:13:05 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cfba9f385aso22241705ad.0
        for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 23:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701069185; x=1701673985;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbhetaEmHDXsErRVxv8JP9G/LWBw8d7TWXbXFegje8Y=;
        b=hhEiFdopegoy0pUPU3tnZyBVAZoZdcRZS31oI6ZJesSN93S/2YuMOfSZHV2Tpm2buc
         nLCpt0IL09ip/gF2eZjhcFmWF1lCVIWIg5mwJ2a/bLeeHiCbTTqIuB8cFJs5RqGpNg/O
         lyoD5m0pWVJUw85b5AKjcKe5DVApcGKY962yHlmXjZl56mPsm6c/jucTEMpkrZE4Lrpk
         P2XT/VLWhJzZ5vph9C83uFoJiW/+Zdk6ixmud+DviJKGHWrbBdYvmyI0fH9FOCVIYBo/
         PuFnrH4RlYurLYffak7bIk/lyYY6+GpnQSIbJzdq90qX95cQ67HQL2HShNZii326kHg5
         1AQQ==
X-Gm-Message-State: AOJu0Yy+O4D8+oiN2vkZQYDYICqzevmLMD0puZ/265XWne9opRbYj49D
	LZeSx3YI36OcFRjJ0FZK/OFSsdJ0ElqdzLM9kLvcZNvuX1Sr
X-Google-Smtp-Source: AGHT+IFNEfof+Dn0EQCh3xoFE/GYY7yEj0K6LHERwW0gKqb6aQluaZTSa9z+QLSO/78XIHCyzPsL9nqq78gmkq4CLWqD4Dtpx1LN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:ce8a:b0:1cf:935b:96e1 with SMTP id
 f10-20020a170902ce8a00b001cf935b96e1mr2751808plg.0.1701069184815; Sun, 26 Nov
 2023 23:13:04 -0800 (PST)
Date: Sun, 26 Nov 2023 23:13:04 -0800
In-Reply-To: <0000000000007f826b06044878ed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007fd73e060b1d08ec@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in __sco_sock_close
From: syzbot <syzbot+dec4d528fb7a7c5d8ce3@syzkaller.appspotmail.com>
To: davem@davemloft.net, eadavis@sina.com, edumazet@google.com, 
	hdanton@sina.com, johan.hedberg@gmail.com, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, pav@iki.fi, 
	syzkaller-bugs@googlegroups.com, william.xuanziyang@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 181a42edddf51d5d9697ecdf365d72ebeab5afb0
Author: Ziyang Xuan <william.xuanziyang@huawei.com>
Date:   Wed Oct 11 09:57:31 2023 +0000

    Bluetooth: Make handle of hci_conn be unique

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=140ffa0ce80000
start commit:   bd6c11bc43c4 Merge tag 'net-next-6.6' of git://git.kernel...
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=dec4d528fb7a7c5d8ce3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145586a8680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13bf8dffa80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: Make handle of hci_conn be unique

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

