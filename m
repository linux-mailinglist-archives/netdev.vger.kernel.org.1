Return-Path: <netdev+bounces-243083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BECC9956C
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 23:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9824B4E2D71
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 22:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E17286897;
	Mon,  1 Dec 2025 22:09:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D84286410
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 22:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626944; cv=none; b=Jgnen6m4nV/NIUgtLlspqM1HfL9PS7JmGJzOmMPqI+OUsZ2Jox3i6S+Irtz/glD3Fb7YaGr7YDixHXFq2sQdbWykLz8WUx0ICfrOBppBudZQzz9Xa/7R/eQAsUnqEAo0fVvdtnNmC3CSB1KEYrzehsk1r4WNpxZY9v3DIN8Rouc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626944; c=relaxed/simple;
	bh=Uw9kUV9EdAkxOYByN1jtz7gLbs5Uy6OVyl/gd7NOE5s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q0ecVGbZeVqbCpc0go+BZVUnxgwYXWyQRn734bu5q+kr5JiBM0axjSDNCbbX/3VFa+928BJR5epokvf9fvmC3cDsBagikqjm4rPpkrC48cvGPxAIrjHMHaKB+lNuhlBZprXqE4Y5+tmdV+AKQfOw/3RwWg2f4tY5TjfitjTDsvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4510650aea0so5321937b6e.3
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 14:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764626942; x=1765231742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vkKw1aMFMsjt7cPjue/zTtcAVsiSrnVVB8Q6f0BvOw=;
        b=mKtXYuBeKvhDfT5dj+CDqixs5kjLjxcofOJl5eHmUq4S7tpUd/A6FZJxF0JKbl3hzF
         WR4blXPaZw6NZy9skWisp/olax1BjeTA5UrvXf5Wqah3VquEc2Niw3HC2A53AqgjKlES
         +qQBw6X9gD7f+EHw2ZPS82tjGvaRaDGkniHX5BIU/BxTzKVennF7GuOJjAnfskXXncZH
         Q4G5FCNsE0m1oOkPyhdlm/cH+uJfA8DXaTw6vVwnTYTUCIfahc3RUdixfkKKpA/sAll6
         gd77i19vPBl/buACZGjPyBNM73msSAOBobkOd1QsiK0IrctAnPzJXIXVLqWR/ckVt/xE
         1VAw==
X-Forwarded-Encrypted: i=1; AJvYcCX9CExrDFtHSf8+dW6X22/iYWLqv9r9ECmpWTgQS0rWQQb3rJUtKtLXwv8JpsUMBlwF+TBvfT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKzkkxzFHVXvlC7KPIbrMhdoT5FoInoG2EXd5JUyGZ7NVfNJ1G
	oJRtMwB8hyvKCw+ABlC7bsYsdenzwchU6YHsd7AiC59p8aRbbWfwcWrdr14fJdhHY9aHSpIe7LQ
	YQWPtmcwU4ZpnkIuZ2uz4VPqbJHQbk1DWLXldrVjP+YybbgT+Y0i7bbhX/kc=
X-Google-Smtp-Source: AGHT+IFCVn9SmBjyBhDsZVB9FNp97B50jkWsVXck4orrLX/hYWor8khmXtZ+VRasjlQ64ebDCoYjuVDiltI/XEWnqYdManqfsXti
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:210c:b0:450:a9d0:b799 with SMTP id
 5614622812f47-45115a10e29mr18815486b6e.17.1764626942248; Mon, 01 Dec 2025
 14:09:02 -0800 (PST)
Date: Mon, 01 Dec 2025 14:09:02 -0800
In-Reply-To: <692d66d3.a70a0220.2ea503.00b2.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692e11fe.a70a0220.d98e3.018e.GAE@google.com>
Subject: Re: [syzbot] [fs?] kernel BUG in sctp_getsockopt_peeloff_common
From: syzbot <syzbot+984a5c208d87765b2ee7@syzkaller.appspotmail.com>
To: brauner@kernel.org, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jack@suse.cz, kuba@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, lucien.xin@gmail.com, marcelo.leitner@gmail.com, 
	mjguzik@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 457528eb27c3a3053181939ca65998477cc39c49
Author: Christian Brauner <brauner@kernel.org>
Date:   Sun Nov 23 16:33:47 2025 +0000

    net/sctp: convert sctp_getsockopt_peeloff_common() to FD_PREPARE()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1136a512580000
start commit:   7d31f578f323 Add linux-next specific files for 20251128
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1336a512580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1536a512580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6336d8e94a7c517d
dashboard link: https://syzkaller.appspot.com/bug?extid=984a5c208d87765b2ee7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a2322c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a3c512580000

Reported-by: syzbot+984a5c208d87765b2ee7@syzkaller.appspotmail.com
Fixes: 457528eb27c3 ("net/sctp: convert sctp_getsockopt_peeloff_common() to FD_PREPARE()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

