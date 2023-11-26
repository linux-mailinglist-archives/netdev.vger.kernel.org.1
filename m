Return-Path: <netdev+bounces-51112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A78A7F9271
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 12:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB3D1C2095B
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 11:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474B8C8CC;
	Sun, 26 Nov 2023 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E12FE
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 03:15:05 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cf904825c2so47807165ad.0
        for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 03:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700997305; x=1701602105;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHaxLzHaMrVuEynKFwAXmqb1IBUV1cZFLGQCi6lgPdg=;
        b=thLQ4dem0fSAWhFkeqvfm3Im4RJm2zVkxjyULb/zx30JtHpiQmxQS+RVxzSmXtyyVW
         hDgdzwSA++i1fmlR5Q8jeNsZPOwlecKtkAd4NAdNgE183tF9MV0KY2JZAMq9y3jgsPsr
         dOe6Sm3VSSHt7GdQnRkJspnMulcDOSDyfUUl/moM082bJcosj1K+4L1kz80dCvTNKHJT
         ztGT5xk7yUGFJCGbU67yNbNzQXkPFWAcc87tBP3ZP9nLZZxaQ+/8GoUNvhmWrsHupnLT
         s88xaEDUromQbdbX2wdBeWHL1SibGSM06dqzHrKF8PoD0FCL/ccIQRaOHbM3q1Ssyf9E
         /XBA==
X-Gm-Message-State: AOJu0YzbgORwe9huPa33EucSQLDaaY+tuAShummAzyFnAWeXgX4SmTnR
	54wf4IDg3yEC1YMBGn30l/8FwS6riX0Mv2nk/8BV+dUygAOT
X-Google-Smtp-Source: AGHT+IE0WR/9nta+zaUgKm7UCxRX3Ot8aDCrNULWGKAS247az7Z4XU/pN/NfDGZq7w8qAr1qX/4xDp1eaWge8tvxtmAFd5e2n1Vh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:9883:b0:1cf:9f36:d983 with SMTP id
 s3-20020a170902988300b001cf9f36d983mr1599271plp.8.1700997305280; Sun, 26 Nov
 2023 03:15:05 -0800 (PST)
Date: Sun, 26 Nov 2023 03:15:05 -0800
In-Reply-To: <000000000000a135c0060a2260b3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000252e5e060b0c4ccc@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: null-ptr-deref Read in ida_free (4)
From: syzbot <syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com, 
	kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, william.xuanziyang@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 181a42edddf51d5d9697ecdf365d72ebeab5afb0
Author: Ziyang Xuan <william.xuanziyang@huawei.com>
Date:   Wed Oct 11 09:57:31 2023 +0000

    Bluetooth: Make handle of hci_conn be unique

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1345177ce80000
start commit:   8c9660f65153 Add linux-next specific files for 20231124
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10c5177ce80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1745177ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
dashboard link: https://syzkaller.appspot.com/bug?extid=51baee846ddab52d5230
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d54c08e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160ef1a4e80000

Reported-by: syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com
Fixes: 181a42edddf5 ("Bluetooth: Make handle of hci_conn be unique")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

