Return-Path: <netdev+bounces-98086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 049338CF431
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 14:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D201C20A82
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 12:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE80D28D;
	Sun, 26 May 2024 12:20:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE03E8F40
	for <netdev@vger.kernel.org>; Sun, 26 May 2024 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716726008; cv=none; b=UaXBYxbKo04D8nOSSQ22Zs0RWuhPXszuZ0aV7llfj+jftJAH114mtzw6RdMZ3udO14V9qc9euIkxG7tFBq2MTf4zbtlal2Q8JH4B8hEvIcRDSqZbkVB8wazwpYWx15LbV7z3HT2KJzE/Wen2iUYxZNLXK9vo+IYwzB+qx5yx7jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716726008; c=relaxed/simple;
	bh=WaRJ+rA5WgS3mFqo4k0lp8UErqbl9DIH6B/VqP7V0ao=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uK2ofNJ7oL7m5kcDhh2bezqD8SrEsJoGpNgpYfoHk4cLlHY1o9aLiGh8EoEIE1R2t4JiyxHpQnQRz7TkAi5c02TC00yhtdIsYwFTF4u63vKTVnzqyiMGry/vCDyOyEEZ+fOjBDJPsjcBfIDtrwl6zAZFYBMMyAWbsqveheHRzy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3738836578aso18105675ab.1
        for <netdev@vger.kernel.org>; Sun, 26 May 2024 05:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716726006; x=1717330806;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/As+RO3hUU+6RkkzFvyl958mmQkvQbWtdetCc5wnIJ4=;
        b=APzd7sFjLaN6AHpXbIJinlbpXT7oJSQ9NkrsfRK9fW9PGtVQ6prjxW6e0ZZAUNbOxm
         COJ7LbpkzV5cFWtcdU/lh4BU7XeP1BpdX65clPZdIrRsIiDpeS6X/xWPPwhOfzRJSVqr
         bYxs0mxpZc2KK9Wy3WwR1xMNma1F/Ww+mqVzQ9ZyYHD0kl1MuVbp6v5M+Q9HcHvd3YQy
         ubSLsoPFQrBRaG8hMKTGYU3leFK2Q5zO+MdRJaUPTvx9i9UeGXICyDocqfEtPQuqlAQL
         4u4zDZwMpSiTojzSiyOE4F9pRdDDGStigJ1umBjUo6PQPM9Uw8gRS00uSM3E/4hQuUjP
         qrBw==
X-Forwarded-Encrypted: i=1; AJvYcCUapV+gmgG7XOKx06qhzgsOE21JY7WbEF7tdj4Xsuw/EUfNWVfdcDAHdgKbZF7JomUPk/3XPyvthZTJRFZCiSIoSogRZkND
X-Gm-Message-State: AOJu0YwFoO8y6kkREEBc79RqY25IeH3HN2MxP12oL8FjdwdzMHyOIWjC
	BUydUfNwsQnU1x8GC8gfXt1sdionz5SoqfkvOiP71UB7kXIswhLR675SNnYk5B9NdgDqxKX0yQF
	rni/jMhwAaK/MRo84cd71LiJDYf07oEXGKgPWCfWr0P5AuJS21czVAqo=
X-Google-Smtp-Source: AGHT+IH83hL1JYz01PPFxLm89qIIXnDgvitXVzrNi/f/Ty1yRl7x7r6QJdsIu+cMLbZ5D756XmkdT0lLxSX8k6f1/G4V3e54gqgl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160f:b0:373:fed2:d934 with SMTP id
 e9e14a558f8ab-373fed2dc57mr3307805ab.1.1716726006095; Sun, 26 May 2024
 05:20:06 -0700 (PDT)
Date: Sun, 26 May 2024 05:20:06 -0700
In-Reply-To: <0000000000005736990617c4fa63@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c53d3206195a6b38@google.com>
Subject: Re: [syzbot] [net?] WARNING in inet_csk_get_port (3)
From: syzbot <syzbot+2459c1b9fcd39be822b1@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, jolsa@kernel.org, kuba@kernel.org, laoar.shao@gmail.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3505cb9fa26cfec9512744466e754a8cbc2365b0
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Wed Aug 9 08:34:14 2023 +0000

    bpf: Add attach_type checks under bpf_prog_attach_check_attach_type

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15dbe672980000
start commit:   977b1ef51866 Merge tag 'block-6.9-20240420' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17dbe672980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13dbe672980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85dbe39cf8e4f599
dashboard link: https://syzkaller.appspot.com/bug?extid=2459c1b9fcd39be822b1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126c6080980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11135520980000

Reported-by: syzbot+2459c1b9fcd39be822b1@syzkaller.appspotmail.com
Fixes: 3505cb9fa26c ("bpf: Add attach_type checks under bpf_prog_attach_check_attach_type")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

