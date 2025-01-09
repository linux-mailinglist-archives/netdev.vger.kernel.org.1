Return-Path: <netdev+bounces-156616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE5AA07289
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C4716824E
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E56D216381;
	Thu,  9 Jan 2025 10:15:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2899215786
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417706; cv=none; b=Ma2p8nYyxkQoXYm5f8G2hoRw0zemN341M9Vw6OJjCnoyO6OvVVphaVwrBadWNQbSFqKThOvZew1RUb8OB73meiaLcPNYBlDDIPoeGs93qPzyjGpNYblgP78dFZTxuSVxLltna1AyZ8U33u2DZG8y4rClLqH7EJ0vaL/Gvy558IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417706; c=relaxed/simple;
	bh=kbyruUblBhGqvdvcdX8FQpbEnhYxPFdcdXEruhRjdaY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IPsgv+09HtLef/jcGEoLIiVFvLn1FBmgs4q7Od3HPER5MzLONeCWgmbSNAIV+OXjdIdLBIii3m/DBJRX9JSOhb6+LD/kIiDUEhcQytCSvVmsWOBdwpMyl/pUZceU4L2nbtGYaOIgg+Bhazw+aBbXQ0zAMikL7f9lWXrOsIKN+vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-845dee0425cso60243839f.0
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 02:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736417704; x=1737022504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1KyLOxtLSju+kMk5DlvaCFJoyIAsTFtQb1SI5TVf6g=;
        b=lj36LH+InFO28pz4AvJbFg7Z42FtrIk5pXd2Sy8sAiP/Fc6Lo70AJyBZ/h1bsS2sJ0
         STMUImVvFwYLLkS/I3UYlKF0cLXAJvFWPziw0NJN1ixEvadWpp+XjQFjCQCR1qiqglmJ
         Kn0QX7ckFqBOr7oFNtc7da5QzEDXrrH3HSmEnOyX1VfjX/9h3RvY5cNEVijM5BJ1flSN
         MKJmR7RMlB53iDQUca4Tmdc9+7Hl/1CnOXfzZsznMMVEUIrypUIMNCUkcURWxDou8YsB
         HAh0p6aEGElZwNOG2Nw88tOgUSxqPzsPW2te0IuhUoWFcQjh2UQE0zWOTQ51zpze+SDc
         c53g==
X-Forwarded-Encrypted: i=1; AJvYcCWYu3av8123XhWvISChwJmA3puMZ1l3netvSBPSXV+FkBR5VSBCGtJ+GIQPBV2U9X5nkS0lWuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdou/oYHiamaRbKzJSGpb4h2udhZJgUlTGoTg3fGxVwWyzaqnt
	8CzpM1GN4TD7Tg1TGg4RMsuEh6E/m3nCS+6MviiTe8pPrVFKsgxjSgxMs4l9x6MlULfBKaKm5vC
	24HJu/QoOl66JF07ywgiUKM+bDKnRvpkEmdRwjsmNcYimt/Y9WlXD9bk=
X-Google-Smtp-Source: AGHT+IH2QInG3jDHyiVNPfZgn0++Tkz4Y5LCkLxo9WKy/mclasTAGOgowMoJPjHgAXD1Pi/vi3la0WkAWKV44ggGP4GmCciogWru
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160e:b0:3a7:e86a:e80f with SMTP id
 e9e14a558f8ab-3ce3a9a5b0cmr54427525ab.3.1736417703971; Thu, 09 Jan 2025
 02:15:03 -0800 (PST)
Date: Thu, 09 Jan 2025 02:15:03 -0800
In-Reply-To: <a4n77w3u22efhdnyz5xn5gjvsfq7xncy3lyn32xqobnuw6gb27@kxubdyn4hr2q>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677fa1a7.050a0220.25a300.01b5.GAE@google.com>
Subject: Re: [syzbot] [virt?] [net?] general protection fault in vsock_connectible_has_data
From: syzbot <syzbot+3affdbfc986ecd9200fd@syzkaller.appspotmail.com>
To: cong.wang@bytedance.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3affdbfc986ecd9200fd@syzkaller.appspotmail.com
Tested-by: syzbot+3affdbfc986ecd9200fd@syzkaller.appspotmail.com

Tested on:

commit:         767faff2 vsock/bpf: return early if transport is not a..
git tree:       https://github.com/stefano-garzarella/linux.git fix-vsock-null-transport
console output: https://syzkaller.appspot.com/x/log.txt?x=17c9d4b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ef22c4fce5135b4
dashboard link: https://syzkaller.appspot.com/bug?extid=3affdbfc986ecd9200fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

