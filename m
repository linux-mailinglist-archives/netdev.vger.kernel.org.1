Return-Path: <netdev+bounces-202117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24BCAEC51C
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 07:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B15947A3E61
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 05:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720BC21C18D;
	Sat, 28 Jun 2025 05:14:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93904A33
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 05:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751087644; cv=none; b=qVSR1onYMarFQ+FJa9yKHfJO2V4wU9kVc8CrCVR2qrnDk1uV4UhVcbGpu6im2wXfTMB97qcYaFkhVO1hE9TxvoykVaN7EbLnRyERWMloWcCRoer6v5ok1Z4VP7VVTr5JcA+fGQIj64FX8Xh7tsRMackUkJQn7ZWEO80+chyV18E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751087644; c=relaxed/simple;
	bh=ImkOohW0xoy7J25xzFN6PO5huhiGY4VN5yzgFbX+u30=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=flVOGsiKo1QFP8Jo9Cb2qOAePSkG8O+evLPRvLmNKbKOAlNh3QiWoHCKaf64w1PNVStEsG9GU4MpJuMY3WBW/Tc7wbPtRg+4KfrUoEZude7uNcphCYmftwkQKjm+OZQgDuDNNN90MIix3Rb+FPNKKRDs5wASUM+EvT2v+It3l2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3df2e89fd03so4890535ab.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 22:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751087642; x=1751692442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQtYV1Gyi68LVjdcfdU/eNq3IyRRwC3uv1igzI3erFc=;
        b=NpWtt9vIug0tHrERtwFAF5tvVzYVffTu/9EqJFfnvxiBiqYUMW4Icw2A/75RWjCY06
         PsVKbgvge0G1sGRxCm/3yXjFUD/uXvnd1UTRHLiluLkbA0eLyxMOZxbSSTpLA4xllr5r
         sU0pS/osLRpLZTwhOpuN155kuQfhxYmZkwmwtMaC+BxyF9lGKCzDHJGxrt2+2RTfRZBG
         ET7nbRGdKGZ2JxxmUFhzf7dbykjp+dVGBxjWH/6ElBOhB8b7QmjiCU/nVcEJXj0Wit+5
         zxO45YMvkmt0+ZOm8SkoSoeaw+KzhyUrg9w9ILisFeFgdXyjBPnAmKYBUMLbf51GLEVX
         4anQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4BHYCOPDaT5uNn2d/r6CeXZ0kYAaSTwmuPNSHe3Urijdc5KhXpAv12cM2Q3+zxNwCJAXuGbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5L5e1aYBHSJkStesBPjAp/OEyAHOFBtWwIFCgymxdOy35ogF1
	raWfyTuhJkAaX6iVGILJWn8YvZtUiUKQd7t5Qksx4ornbTWO5a1py/BO0Rbuk2mxUz1f93Z6YMP
	ZViWqnC11DSKrxK8emk/NhxXOYGvS/yHUuJ4swEzOOV+M/XhXwCMC9x9OjwA=
X-Google-Smtp-Source: AGHT+IHhgdgQNjS1nBnWLUNfiv7EE/EHoONqacRJkEf60gWH4jWoK7OhxwwDZCx0AkY52S0u7NOzrVPLBmfL6upFVifarVyjRBcy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3189:b0:3dc:7f3b:acb1 with SMTP id
 e9e14a558f8ab-3df4ab85c3dmr77735685ab.13.1751087642190; Fri, 27 Jun 2025
 22:14:02 -0700 (PDT)
Date: Fri, 27 Jun 2025 22:14:02 -0700
In-Reply-To: <685e86b3.a00a0220.129264.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685f7a1a.a70a0220.2f4de1.0007.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in ip6_mr_output
From: syzbot <syzbot+0141c834e47059395621@syzkaller.appspotmail.com>
To: bpoirier@nvidia.com, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, eric.dumazet@gmail.com, horms@kernel.org, 
	idosch@nvidia.com, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	petrm@nvidia.com, razor@blackwall.org, roopa@nvidia.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 96e8f5a9fe2d91b9f9eb8b45cc13ce1ca6a8af82
Author: Petr Machata <petrm@nvidia.com>
Date:   Mon Jun 16 22:44:18 2025 +0000

    net: ipv6: Add ip6_mr_output()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13bcfb70580000
start commit:   5d4809e25903 Add linux-next specific files for 20250620
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=107cfb70580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17bcfb70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58afc4b78b52b7e3
dashboard link: https://syzkaller.appspot.com/bug?extid=0141c834e47059395621
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138a2dd4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171c5b0c580000

Reported-by: syzbot+0141c834e47059395621@syzkaller.appspotmail.com
Fixes: 96e8f5a9fe2d ("net: ipv6: Add ip6_mr_output()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

