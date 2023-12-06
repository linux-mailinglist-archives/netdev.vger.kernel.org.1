Return-Path: <netdev+bounces-54252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2BA8065E7
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506CD282222
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 03:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7261ADDC1;
	Wed,  6 Dec 2023 03:58:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC25C1BF
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 19:58:10 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b8b66d49easo5491198b6e.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 19:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701835090; x=1702439890;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kowtJ3erIuB+junPJVnmZj+8P3bHd7MVP6/UASYAO2Y=;
        b=P0yMsAXYFz4y8298M58yvCkpNl4NdTpUODbCT4APE0VKW+3qQArabeJBMxZn/9XLjP
         TdNUXC+UqYhGgUaWK/2W+0xqaewEmy//YRR2m6eAQcZeriVIey/WxGCmPwQ0zKYdBlIX
         e0NN3c/v2zVT0JsBESgGCD7lueAjQ94DjH4G69cRRgciGfmxZsRlgNIvxqHAROf9NKV2
         5bDSdd9/E8nVg/7/5AmRfthd5ICX+PnHCr4lAFdVt3jitY2E5trwLj45btSpQ5MtCuoK
         NpHKvlVvLVroZj7z2EbOe7OuRFNQ+ADTvKUsXL5jU4sHzjRDYKlLj+2EKxNtXpWY2NLE
         Tp2g==
X-Gm-Message-State: AOJu0YxeHfeOlmZ67yPh1TA+KSN1YVAQFcexFa5wSUX8OvltDnv8o2g7
	4vgolxKcP5+uai5DBylfyXPxyB/aWXwsuFs+Kc3bZCp0C6W/
X-Google-Smtp-Source: AGHT+IFgghFouIRUn3iqyZ5s/Hsf85PRJMmibbGXKnnfFoA3CNAysUkTLcYkwd+dQjrhhNtZ+Mk7dCqwuInXNtLFga8mnTqxKONF
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2009:b0:3b8:931d:d1db with SMTP id
 q9-20020a056808200900b003b8931dd1dbmr299703oiw.3.1701835090175; Tue, 05 Dec
 2023 19:58:10 -0800 (PST)
Date: Tue, 05 Dec 2023 19:58:10 -0800
In-Reply-To: <000000000000797bd1060a457c08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000042dd9060bcf5c23@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
From: syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To: davem@davemloft.net, eadavis@qq.com, edumazet@google.com, hdanton@sina.com, 
	johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, luiz.dentz@gmail.com, 
	luiz.von.dentz@intel.com, marcel@holtmann.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 9a8ec9e8ebb5a7c0cfbce2d6b4a6b67b2b78e8f3
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Thu Mar 30 21:15:50 2023 +0000

    Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=179a65d2e80000
start commit:   bee0e7762ad2 Merge tag 'for-linus-iommufd' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=145a65d2e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=105a65d2e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b50bd31249191be8
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1504504ae80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14685f54e80000

Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Fixes: 9a8ec9e8ebb5 ("Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

