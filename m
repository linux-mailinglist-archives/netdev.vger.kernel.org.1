Return-Path: <netdev+bounces-160786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 099F5A1B750
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 14:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C522818882E9
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 13:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96538633D;
	Fri, 24 Jan 2025 13:43:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AEC8614E
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737726186; cv=none; b=thjywDZBU5cZx03GCU4f77NDnupoYHzPKKrA6FpqPbkbUgW8oX1gFwmMNm9FGcVmVNtWaI6Dh7YIF2rsvx5OpaZ0GeBy6M9nULWt+E0a0TSYKYW6OFO/gPagTIgB2G7oJSSwhLdBiUMAyStGK1ekA+OFvatKmlk7W47zxz0nYCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737726186; c=relaxed/simple;
	bh=n8OZ3b/yHRWJF9A8gcfHJ7tGWiWPREHXqrj4JQyfRFs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R2TVRaEEMZQUmGXj5XisSGtoAoKKCpuC5GCmwENuoJ0i56P3jvxoqzZKo6KYHwqnziaQWTGWhNvtg2ZGQsfH7U02W8kdhAYRfWr2t58389vdb+JVS5ujXFtoN9axOmXoQI9MTVKz1NHZCWpPU7suw6U8m5/Q78cZ8ep6dqp/Tuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-844d54c3e62so268760739f.2
        for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 05:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737726184; x=1738330984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2pZe/q9uQMTJ1h6+AXXu51oqWvY3EGvpD1rhxTUhiCw=;
        b=u3TL9OlT8WGzQJiaeMGnTUS1JtUcXufK2wcDrivEDjJ+ElcpVUV1Il0Eb6O8WvblUa
         Mg/Mrf34B+I9TV+CiFjOCkxCeI3zE3DvD54YC+HByM6ZWbRrzTMu+pyvlvXTSIX6LSvJ
         GXFFb4xYrPceKWy7YmRYY0W07aBgYbE1zD1NMbbdJuXAxFl3DDjcXBIXPxOh56x7FerQ
         fdJe2Oi+kJeUR4ahpXhr639Sb9+SlITqIqE3ZNTsVYzfoQ6eig3docaXqz8TN1ktJQ5X
         z5+l3JW9e13pKs+X21eazAS+OaQmJ21WUZqIL5zvQckW3jzuYo4ysU3DWSnVwp6pdfpF
         /Xmg==
X-Forwarded-Encrypted: i=1; AJvYcCXV723CbKjD6fj3QlVFr+MSPTCvLYHHr2wzGMichwG6a6PzQf0z+QnUtNtjQwCquAoFR+Nca1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/+GU7QEzumfiiSAU+4oea2fDydeewZ7TC2b192MQ0O/7c6ZO1
	KNE9ecpONaJ/rFBnketSnnyalHVQ1j6olFMMbko616EUdeSxLu0eUmrVLhJRVKOPpMIHc6yOa4p
	XZr05YpNbDIAw3U5GwwCvcwGUry/CGcbzi+y1Q1Vtg+lyITy13O5B21o=
X-Google-Smtp-Source: AGHT+IHK9J8OswljrqskgVtLCWuKfDYf9V/LMLUGMG1IR6LhNN3Im86vudLsPDVLvtHBMCmDTGo+FZJvCui01vqHBrHYGxG8x3MI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4918:b0:3cf:b2b0:5d35 with SMTP id
 e9e14a558f8ab-3cfb2b05ec7mr102563925ab.7.1737726184066; Fri, 24 Jan 2025
 05:43:04 -0800 (PST)
Date: Fri, 24 Jan 2025 05:43:04 -0800
In-Reply-To: <6786ac51.050a0220.216c54.00a6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <679398e8.050a0220.2eae65.001d.GAE@google.com>
Subject: Re: [syzbot] [mptcp?] WARNING in mptcp_pm_nl_set_flags (2)
From: syzbot <syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 322ea3778965da72862cca2a0c50253aacf65fe6
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Date:   Mon Aug 19 19:45:26 2024 +0000

    mptcp: pm: only mark 'subflow' endp as available

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f0bab0580000
start commit:   d1bf27c4e176 dt-bindings: net: pse-pd: Fix unusual charact..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16f0bab0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12f0bab0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c541fa8af5c9cc7
dashboard link: https://syzkaller.appspot.com/bug?extid=cd16e79c1e45f3fe0377
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11262218580000

Reported-by: syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com
Fixes: 322ea3778965 ("mptcp: pm: only mark 'subflow' endp as available")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

