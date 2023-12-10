Return-Path: <netdev+bounces-55652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9549780BD5F
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 22:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC35C1C2037B
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 21:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8C71CF88;
	Sun, 10 Dec 2023 21:38:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F44E4
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 13:38:04 -0800 (PST)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-58d336d8f91so4461319eaf.1
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 13:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702244284; x=1702849084;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FxbULe4PoOvzjabcg4fEcKZ0w6jpN2DX8HCoWUa20UI=;
        b=CJuDQIHuxt//wdT5CVkz+E+qPAus3pi1Wa6KSAb5YHpni6mStbv6MwohPAC6Ux2Dmm
         T+KwJlqWSy9KB0gtNMSJnsKRZDPTsxPf8h0hkDqz1aFdGX8NuMVPRzoPCjqOCOpj31jU
         Gj670OrYlWZaFRSJR9Z5DVfd079pFwQykG//ch3IoEMYQupWFV49I4t4ncMpzhEKd6gG
         LlL+hrn4rxlbr+5bSg76AmL5UF6A+oaze9P3e3GGCuEZ6wKTexPfguys31zGVMSKw+52
         9Q2qXEtrbXWhOrhBQtvGUhkETZwAi0qo5lDAkZH/sJ8NDt4ux3MDRGbs5FU+tGJEoUyZ
         P6AA==
X-Gm-Message-State: AOJu0Yz6Nvxd+4M2WAnl9eoxn43RjWLwMvbJVUG6xNOL3PduT0beiOru
	FBucjaM9FJpndcSBa/zdSSPEOru/tFLWRro/YM6+jYMGUK5X
X-Google-Smtp-Source: AGHT+IG9DQLdvnLT0V8GX0PFxpAMf98FGEWIzJmw6MJpQyI9/LylpQvIZnjj43QjmR+t8LtI3LBVYY4Lf7uVAvGv+6QcNI9rEgwO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:4105:b0:6d9:e284:81c5 with SMTP id
 w5-20020a056830410500b006d9e28481c5mr3333431ott.2.1702244284139; Sun, 10 Dec
 2023 13:38:04 -0800 (PST)
Date: Sun, 10 Dec 2023 13:38:04 -0800
In-Reply-To: <0000000000002e8d4a06085267f3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e08cbb060c2ea1ca@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in ptp_read
From: syzbot <syzbot+9704e6f099d952508943@syzkaller.appspotmail.com>
To: davem@davemloft.net, eadavis@qq.com, eadavis@sina.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, reibax@gmail.com, 
	richardcochran@gmail.com, syzkaller-bugs@googlegroups.com, 
	twuufnxlz@gmail.com, wojciech.drewek@intel.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit b714ca2ccf6a90733f6ceb14abb6ce914f8832c3
Author: Edward Adam Davis <eadavis@qq.com>
Date:   Tue Nov 7 08:00:40 2023 +0000

    ptp: ptp_read should not release queue

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10477d6ce80000
start commit:   4bbdb725a36b Merge tag 'iommu-updates-v6.7' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=9704e6f099d952508943
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17233388e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a3f898e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ptp: ptp_read should not release queue

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

