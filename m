Return-Path: <netdev+bounces-112283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F97938022
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 11:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BDE31F21568
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 09:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9377655C1A;
	Sat, 20 Jul 2024 09:15:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF304EB5C
	for <netdev@vger.kernel.org>; Sat, 20 Jul 2024 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721466905; cv=none; b=HyggprEBGHRrkg+pn1fMXoCKA78WeLY9Jb7B268Gs3addoD04X0yZWKk1hthgl35BmikgPwALqtXRJp3zczxKrfE2IsA+KZlEDYg1LtooWnzvs5lEHaRbXgm0YT4pFjl+N+/bk9cYqCHBlSsMeoI1eHBTByWPK+IeuUX51HCCZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721466905; c=relaxed/simple;
	bh=ODLI+X9xS97FO4XT1UaElBARAbVdOL/w5b1NhR6HgOA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c1dryjmW0CkT2g22sMGkXM1MzPqhiWxOZ0EiInYaAKUXokpHyzKWFJbjT/nuQoLfi9ZWBtFR7ap4wqJZ8wH1mfAmQVm1NNQa81vjmR0Npcd5ADyoXgyHzeGHDUgPjfoDYEgqHM1duhPGIqkIbYvmRZ9aMEJj8lf51HqP11CBCcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8051524c1f8so413396239f.1
        for <netdev@vger.kernel.org>; Sat, 20 Jul 2024 02:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721466903; x=1722071703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/xW/bfcnBDYLDu6G0bKJTsPYwdeU3e7DSeAVPwwSKE=;
        b=dvlAdwJWshGQmUIi07Twm0bLpbJKk0eUGjmx0eF7ToYrm/zBeJteJrKCeV/qJH/UNj
         sWryVOW7UL/RcLo0XvAgZ39kM/AM9s/5Hlf2OEnEz7UE+BqzPDl25E2oAZKsVc2HSQhN
         ZB6webazMe9mV4mXj6eW/SHmfDUB2N0bbHREuq2sGsn4t9BuUjggK3cVRB6YcRrFL+gK
         l80mTZ/c38mBsF5A8bJUTqLqGwA1UPHtWT2SFkuWcWndAA3c5UUexLqIZfNT1lQ/ebuI
         EuFSow2n3tOSrGw72qVqcOV1NisH89/qan0qdEz3TrfavyMsWsPinyTQkTUO49PhHdNR
         m2rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwGTMCNG3dTKDKI5ZBGPm0cAhFsP2LDdpqEjZJltzaB2CRvkrffnTMkT4BfhkuW+FEWj2msLYy7FZAAko3r/Mi4sUiFg/5
X-Gm-Message-State: AOJu0YxPyg6VIhU6d5p4Tt03B+BC8gyD5M/kUDA1iDBYt/bPWofKVYox
	P0MnCjG8vpO9jamDi6Aign/RU+A1g92KLAKHjLO6Hv2nlEX9RZuNzRBFWViXkzhodoHwzKz9mUD
	SFzdtotv9HAH/5yiOzVaxbbdhvSfTSMJwOa48SiB7nysxCBHHlioKrc8=
X-Google-Smtp-Source: AGHT+IE/QzbDjURoyGylAbqTzkWRv3Z1WWdorDeizpZ2ulTCu+E5V2jt9Lj2vHun3OTt+jKz10+fNjIh2OqQhl0Y58S8XH5KA8L+
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2114:b0:4c0:9380:a260 with SMTP id
 8926c6da1cb9f-4c23ff457dbmr83224173.3.1721466903216; Sat, 20 Jul 2024
 02:15:03 -0700 (PDT)
Date: Sat, 20 Jul 2024 02:15:03 -0700
In-Reply-To: <000000000000943e1c061d92bdd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004257c7061daa3f20@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bigeasy@linutronix.de, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, edumazet@google.com, haoluo@google.com, hawk@kernel.org, 
	jasowang@redhat.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	willemdebruijn.kernel@gmail.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit fecef4cd42c689a200bdd39e6fffa71475904bc1
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Thu Jul 4 14:48:15 2024 +0000

    tun: Assign missing bpf_net_context.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12ddc995980000
start commit:   720261cfc732 Merge tag 'bcachefs-2024-07-18.2' of https://..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11ddc995980000
console output: https://syzkaller.appspot.com/x/log.txt?x=16ddc995980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=93ca6cd6f392cb76
dashboard link: https://syzkaller.appspot.com/bug?extid=707d98c8649695eaf329
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1791eb49980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118cf7a5980000

Reported-by: syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com
Fixes: fecef4cd42c6 ("tun: Assign missing bpf_net_context.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

