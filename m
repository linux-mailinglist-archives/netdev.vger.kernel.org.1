Return-Path: <netdev+bounces-108619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0C6924BE0
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 00:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71211F2319F
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 22:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6390C14F135;
	Tue,  2 Jul 2024 22:51:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D2D55C08
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719960664; cv=none; b=V+8s44LMbrlKTw5+U9YqEJDJtleAeanKpyoVzbjX8rWvFSzm3hulPhiqi8qJNJEVJVOV9W7fLqDzbsC0amMZqv7a2ni6pPSh1Xes7EqBUmbD7nEsQwH5qqd9D1CQJhINahFGQ+uUIyYVKbxPm5jxnkLSdUCJTwdAYHkx0U7kuio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719960664; c=relaxed/simple;
	bh=c2pljCvkDCrNdXi8dK8gDV1YRjNyJOZWcO0u3w0ZRO0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DutiqMO4h9+4yzoXO4aAe4FmZj5ZQMwXHdjvDWSMMyDqxKs4A+giFkVa9mOEK+NHguBM31128B30JFrE38UhWcODesIDCTOIkdYb9meXB6DjFTLus10OSAxLP70BTUZND2gy+V6RwV08L+yJ1f8CcwbkdB/SDuYEez2Yovaw7YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e20341b122so475708639f.1
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 15:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719960662; x=1720565462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1zcW/2g69j2qQoiRggn0QFp5HfBY19iLG4r8iDmR7o=;
        b=Cp6Rs0HTaNxICCuYaDZQc3bDfBA3paNnLlrnH7OwR2DkpIes6Hjwc+ApjpQDXkOBbo
         XEqzJxj1B4P3Nm3OJrnsNm39ZHeoWeVuRC3uP2XQ43LcM+MF5iblxz2y3jQcfHFN1zmu
         xwxFETOZ/12LDU9sUpXSfJvKw3TGpUfdI93ozw3IYMXabAky2BoAJ/LdsOg0O13MaOYn
         ur8d8Pycz22ie4zSsK9DIDZkdAiAP7FNJfmK+Pp/8g3tQSQk6HO8oPultkUJNp0T0tZv
         gelSaFLFHbVG/17tcvOaMM2L/Y4Etb18l8gFvVuogw5Ka7ht5qAh/Jg5QylGTm/Jl+1f
         75wA==
X-Forwarded-Encrypted: i=1; AJvYcCUTAo8LC33aX7TASDiuUa6e8Q+bDjC2Py6E/qBZpDiSm7a13t+CleO2beeY0DjAkM7W4NnOYoZXGkSty5AVuWXq9urrgBUg
X-Gm-Message-State: AOJu0YyJyn/VbrMBW5pEzzJEXn0SXzOgL5//CfkgEpkl6w10gakordp/
	DWanZ2zW7QVFrypjvBFssq/NyRmhw8tCxLg0ccalLnGdsNcGTPkNVG/LEQBlfr7t3hlvgdzAzOM
	PciHCp6qU+saUiFnrPUHQqPyZI6irs8/PyUf3OJz1EewbOi7hbYBZ/Z4=
X-Google-Smtp-Source: AGHT+IGFYq+7YQH3JWUdJMQ0+E0mo8gA3VnnRcqAnxlLu4dlVKRiLZ9jwAtGOvpodFI7gcpr+3j4Hx4eplld8naDEf9gWYM3aKn7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14cd:b0:4b9:eee6:40d with SMTP id
 8926c6da1cb9f-4bbb703fba1mr542699173.4.1719960662062; Tue, 02 Jul 2024
 15:51:02 -0700 (PDT)
Date: Tue, 02 Jul 2024 15:51:02 -0700
In-Reply-To: <000000000000454110061bb48619@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a4df5061c4b8cf3@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in l2tp_tunnel_del_work
From: syzbot <syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	jchapman@katalix.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, samuel.thibault@ens-lyon.org, 
	syzkaller-bugs@googlegroups.com, tparkin@katalix.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d18d3f0a24fc4a3513495892ab1a3753628b341b
Author: James Chapman <jchapman@katalix.com>
Date:   Thu Jun 20 11:22:44 2024 +0000

    l2tp: replace hlist with simple list for per-tunnel session list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=110dc9c6980000
start commit:   1c5fc27bc48a Merge tag 'nf-next-24-06-28' of git://git.ker..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=130dc9c6980000
console output: https://syzkaller.appspot.com/x/log.txt?x=150dc9c6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5264b58fdff6e881
dashboard link: https://syzkaller.appspot.com/bug?extid=b471b7c936301a59745b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1094f701980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bf2361980000

Reported-by: syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com
Fixes: d18d3f0a24fc ("l2tp: replace hlist with simple list for per-tunnel session list")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

