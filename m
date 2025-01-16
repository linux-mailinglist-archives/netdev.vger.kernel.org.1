Return-Path: <netdev+bounces-159098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2693A14564
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 00:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FDE3AB0C2
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 23:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA1D243872;
	Thu, 16 Jan 2025 23:18:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFE21DDC0F
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069488; cv=none; b=gUifylQFbMqBvy/Kgznx2xwt9XC4LXjL1n2+D5SqPsff7y2nwxXsQe9snP/PsRHMDTCxLp4zztwgCmwE3gtcSP9iJNBJBJIdeIqgsZ1BMSBUgEOkuahlV8RLJaGt4SnMuHqmnLgPSl1YFAEvZsq8qr2RtDV7gnwXgMU3TJdVx8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069488; c=relaxed/simple;
	bh=TPnA6U8ghNHu0oo+3co6GMR1pGMkE8ePkE+4Zlez5rs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ual1T3kQLRyms58U8KMLPgw1W01xnIkZ0LC9zt06hh7ylqJhDCB8Hfbv5lv8zwGExYvwFDk3SnjCVWMsr48ygwRv15ixs++gm88Z/P3lktDA/ZEq+ccix60TSdQrm/xcwZnOl+JTDRgyGtFSSo3G/qN01MimP/A/xBH/cLmVDsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce848eae40so23142205ab.2
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 15:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737069485; x=1737674285;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dR18HibPiRxqLQ21bpS857naVam6tjH2PIMB9Rsc8NU=;
        b=u/+n0JbN45x4MUUL1oM2sAOUGTZy1ATqFIUSKh1MHgUY7zg+tdAqgdU+gYS0KjITs7
         cQorj6ztYxKYzDv6LjpIplZ0Yt5KaVhbxtCS66DUofDCoxeuzduPeEvMaCps+d6it5/k
         +qlOLyhKIsp9UAADyW0P0TjvVf5985EXBNZsAPxCDXZ1XuNgFw3nKmpUNYeU2CByYe/x
         vX4BapKSh4uVpLc0EUN1cqq6KPuxVqFa5Anvnw/JLJ4NXeJtxm1cIIK08+wBBdFQYM36
         yexhBnPYYMEh1XcbAnk7COqD/HVTTUFe71jNV+o8sQAsCL5UecW9JZTOyBR5V0rNIAxl
         oGKg==
X-Forwarded-Encrypted: i=1; AJvYcCWsWko8fLmEwi4mcaNiSvmnEwLFFNtYPzR2xOnQjFljxICi99+cJniEDl2J9j3cw49ldaBnc9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8m/noLim8BGqnUeVLXzOcUnY2Snm/Fl00jg6RjyAF4OuDDcIa
	1aJkkgvU61ajfM+QeLSLuYp2dmHsfrln80q+UUWBiyIerjNqrRkrrKN95TpBrIFsmckJL1mZ+zl
	J3y6lNUJNdM0gEKSfQaPUfg8iF7Rx9VvKlaNEHR55auk33O8B7Z3GUrY=
X-Google-Smtp-Source: AGHT+IF8vEPeSDV7ciTfQEkOWuUyRqZNoY7L8GegBFaJuVOiZDYStLmoUQpcYkmhabWhvzgGi9GH7OQFc3q91XPl2DunqYjc5XtY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a03:b0:3ce:8b0e:8a58 with SMTP id
 e9e14a558f8ab-3cf743f75ddmr4303515ab.6.1737069485482; Thu, 16 Jan 2025
 15:18:05 -0800 (PST)
Date: Thu, 16 Jan 2025 15:18:05 -0800
In-Reply-To: <6708ce33.050a0220.3e960.000e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678993ad.050a0220.20d369.0047.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_mprotect (8)
From: syzbot <syzbot+6f7c31cf5ae4944ad6f0@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, davem@davemloft.net, 
	jannh@google.com, jhs@mojatatu.com, jiri@resnulli.us, liam.howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, vbabka@suse.cz, 
	vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Sat Sep 29 00:59:43 2018 +0000

    tc: Add support for configuring the taprio scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=124e5a18580000
start commit:   31eae6d99587 selftests: drv-net: test drivers sleeping in ..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=114e5a18580000
console output: https://syzkaller.appspot.com/x/log.txt?x=164e5a18580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=289acde585746aad
dashboard link: https://syzkaller.appspot.com/bug?extid=6f7c31cf5ae4944ad6f0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d7270f980000

Reported-by: syzbot+6f7c31cf5ae4944ad6f0@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

