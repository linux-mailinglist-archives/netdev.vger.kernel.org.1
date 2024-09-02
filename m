Return-Path: <netdev+bounces-124252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD06968B03
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 17:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E427B1F2293B
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 15:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDEB1AB6E2;
	Mon,  2 Sep 2024 15:28:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D551A3027
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725290884; cv=none; b=bTVul8tDFnQM5K7QDX4rOyatONyVRxuhRVBlkYjSviggnQyIVybhu9+3C7J8WIfv51QLRVT+r5S1w5bc9yv+50JPLPDxr5EoKdrdgghi6jpZ+lyEUXbQmY3tXKvrYCAir803yKAl1wvT2UoCDiMvhqZgDJAzxLSd5Gtv1y/0Eek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725290884; c=relaxed/simple;
	bh=fcsvwgJHszrqFYBuVGMJyWBjEoNkn9u8s/Qvo7dREkE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OOQxW2JB1WuGe6yJw+rYIKmGN2x2mpkaFiiY77bqSaOfKw3F+JiMv1eYTnCYMKkwDnleFwNCOmcaG2z1PizuciHtecdPy3t5MkHfEH/AscBQZF1J6Q6UvxpA/2X3myn4s2W3JlukyodQmV4/AfcLfxB8aFDF+wOiabZJphdbbaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a21f28d87so429032239f.3
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 08:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725290882; x=1725895682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPWC6U8f2qBdEbiB/1tHLk14BDYkG8mFDHPKIKYsGpk=;
        b=BTF/lEVdMgqNuiC77JgxV7i3CwySnOOWgt/VH1GZGypr9nw8ZjDUapTucZCS7oe0uj
         3+vJ5oQop317sGqJ3v33gceWiXNshQo3vM6aFbdy0Pb67pOu1sk4MG6ro6aYjtGrFAtg
         RjgG7EOoX/11K0JhD/LLH1fs9vH/jq48z2Jb4u0ij3UKin6ZNSO9HsvJ4mbdw9N3yAG6
         28RJ8zFS5hM6hrKVFG2rc/fdtkH/4i2DYxhb5m3EE6IRs0SAFjGKs4LqniKlqgLhkFP/
         lQjQQDPihBwi3CCdxIf5e5ee/maCvSAgBC1G4PLI6IefB96qosUXmCyt7JUUUZhokAch
         DXYg==
X-Forwarded-Encrypted: i=1; AJvYcCV+KE8jQrfZA+4NfP80NbVOR8LtutD85EP3JjQhhFiS2A38QG9/LhxglJpWvE3RVdF5DkEuzlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFPgg3ZQe7hfG244Oe/kZ7+7VYcgJ8hay5ZT4F5kJtPP0TPZaF
	YoJaEn3x7PIiPODtmBVFJvZ3tXghZJG78GQ+b+daFTkQUDORAbA8qRmF4CbfmiJtga+nBTywuJU
	K4lTWI0dDEet2+Fb6Q0Lx1Q+sz1eeUAKLlc/CBNZ+7kshBXUS9xH09sI=
X-Google-Smtp-Source: AGHT+IGYE7aRkq1QdG5CqeZumrhss9UwB66VHx1USISJdAEcgiBS8pGvcFiBithIiWwzkPxwiT2pBaJMBi9K1YaRPMlswNp5FSto
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8704:b0:4b9:e5b4:67fd with SMTP id
 8926c6da1cb9f-4d017d77c32mr899228173.1.1725290881918; Mon, 02 Sep 2024
 08:28:01 -0700 (PDT)
Date: Mon, 02 Sep 2024 08:28:01 -0700
In-Reply-To: <00000000000087bd88062117d676@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026b5250621249667@google.com>
Subject: Re: [syzbot] [fs?] [mm?] INFO: task hung in page_cache_ra_unbounded (2)
From: syzbot <syzbot+265e1cae90f8fa08f14d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, davem@davemloft.net, johan.hedberg@gmail.com, 
	kuba@kernel.org, linma@zju.edu.cn, linux-bluetooth@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit e305509e678b3a4af2b3cfd410f409f7cdaabb52
Author: Lin Ma <linma@zju.edu.cn>
Date:   Sun May 30 13:37:43 2021 +0000

    Bluetooth: use correct lock to prevent UAF of hdev object

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a579eb980000
start commit:   431c1646e1f8 Linux 6.11-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15a579eb980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11a579eb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=265e1cae90f8fa08f14d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f8f0fb980000

Reported-by: syzbot+265e1cae90f8fa08f14d@syzkaller.appspotmail.com
Fixes: e305509e678b ("Bluetooth: use correct lock to prevent UAF of hdev object")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

