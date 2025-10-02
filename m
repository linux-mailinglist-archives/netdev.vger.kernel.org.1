Return-Path: <netdev+bounces-227630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F34BB4107
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 15:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD60A16F4D4
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 13:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAB03126DA;
	Thu,  2 Oct 2025 13:35:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DBC308F31
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759412108; cv=none; b=l+kC52Sj5SMAmsKpA48Twudrq/Edbzm1ai73KtC8rUFy5b8PY/LRFxyBvruY6s6ORetBLstt0BRzO2Jws8qLpXK1EnB5PMhszn5rwS35HAgkEgAqy3JMK6YLISRRiGCFj1OwIt+T5U9g6GSgh4t+HxwPwv6e9DLo+dQWUYDobW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759412108; c=relaxed/simple;
	bh=nawsYGieFIT9F5gaofrxj9YLOzYeIyfDFWO/gGppFPg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hp8Yvw99uCX1EVbvpA8Ig/QPrcjAGCClP1z+PkmBt7s1PVsd6D6QbThZ2Pgj7j4AumKkjlFnr7pNtz+uOdHW+6RCORVyyX38fkp/SlHOvYZkhNjW1SsUQmlgDSt+dTTitBSlT3h0a2y3kHWoL+Vcx45V9x4k83KvQI5ZXqPjxZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4294d3057ffso13338915ab.0
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 06:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759412103; x=1760016903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2bZMOz+oKVSx+PlpEBINf9QeMZAUdNl6Bv+63J9ZJc=;
        b=eLcoAfrl8KHO0N7vo/lkq/8BkpukLGKvyoNqHZKoLJ6edEcRod8t44sYH2gha/XV1t
         cZN21S6hbutjCd5MiUj9wBwMeiFuarUYEXzTpFThHjfS8WA0a/cMXKxbXrWZFWv8LMiR
         AGexqz8t4MWfHtTUtP76QPLnlyYTXArgc2EPJgDXQvo2YBz4D/yBPXufjWgcb9Zo4CIJ
         erEeoUIfavqau/KJ+vmlEKpMiLt7x1YALpAUXnx1QSzw9dOdV1gq+3ZTolpbr+mgsOvq
         /z+/8HNTMcO/1WMmx8iEympWHpF0i0UCwHIOiL8D2hfjwcrv0LaMvuEhnp4KAdMTsBt+
         J0xQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+TB+zsAERBtzNjUBcmZXAx2e8LqMkQa81BEEFqbo8iNxTgyKPwzPDlKeCZhiH6uGk78tYgME=@vger.kernel.org
X-Gm-Message-State: AOJu0YziaK0KDfQzGwOsIJVmvdqwvzv4CZi1/PfROP/EHML2p06R6gRg
	Wi0eJDfHNgowGe0OeSc1iPtv7kYMWaEybYrX6jN9r6IoAJAH7dc9GEov1+hBo4n1+EEiTP9wQWQ
	Z6SVQb0EbtIGCw9UIF5yDuXXPhIPP2wFPmB/HQFNQq27qKJrfOx+8ZRqr/fU=
X-Google-Smtp-Source: AGHT+IEQRq/93P1vlQQW6gk27vSZbUYibORnozKjfZjrhOWDxoyWlapnF/W8MSX0jIwjw9gXTkTNpSFyTUz+21o3FyrLcLLpbSex
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:23c8:b0:42d:7d2e:2bff with SMTP id
 e9e14a558f8ab-42d81687a6fmr82693985ab.22.1759412103562; Thu, 02 Oct 2025
 06:35:03 -0700 (PDT)
Date: Thu, 02 Oct 2025 06:35:03 -0700
In-Reply-To: <68dc3ade.a70a0220.10c4b.015c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de7f87.a00a0220.102ee.00a5.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in free_mnt_ns
From: syzbot <syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, anna-maria@linutronix.de, brauner@kernel.org, 
	cgroups@vger.kernel.org, cminyard@mvista.com, cyphar@cyphar.com, 
	davem@davemloft.net, djwong@kernel.org, edumazet@google.com, 
	frederic@kernel.org, hannes@cmpxchg.org, hdanton@sina.com, horms@kernel.org, 
	jack@suse.cz, jlayton@kernel.org, joel.granados@kernel.org, kuba@kernel.org, 
	kuniyu@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mawupeng1@huawei.com, mkoutny@suse.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sd@queasysnail.net, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org, 
	viro@zeniv.linux.org.uk, wei.liu@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit be5f21d3985f00827e09b798f7a07ebd6dd7f54a
Author: Christian Brauner <brauner@kernel.org>
Date:   Wed Sep 17 10:28:08 2025 +0000

    ns: add ns_common_free()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=124fb6e2580000
start commit:   50c19e20ed2e Merge tag 'nolibc-20250928-for-6.18-1' of git..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=114fb6e2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=164fb6e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f1ac8502efee0ee
dashboard link: https://syzkaller.appspot.com/bug?extid=7d23dc5cd4fa132fb9f3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15842092580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132946e2580000

Reported-by: syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com
Fixes: be5f21d3985f ("ns: add ns_common_free()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

