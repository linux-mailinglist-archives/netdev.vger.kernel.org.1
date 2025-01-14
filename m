Return-Path: <netdev+bounces-158162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FEAA10B49
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 16:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8650D188AAE1
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83742063FB;
	Tue, 14 Jan 2025 15:40:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17378205ABA
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869204; cv=none; b=e1KyWuHmDBgbWNIj2siQo8P7kGgYt2RNSl2dGoRYUuEUuqDw8ZmOtt0P6gbLYbP/T+3oBlYaWJYFWHnpHkLpk5TFMw4oTqBpEnDmPZouIAAkcfQaZCQC3w3pUIKvJZISoAfu6JTxpCmDJeuwxs4rsWQO3weSdu5c/LI/8Kq88oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869204; c=relaxed/simple;
	bh=zB03Yo5a4TSm7+8uAwJffWydukNUQMholn/bwNbrDtI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hzf3ze18o5li9e/cxLWjXlliFktzO8m3kDOs7o46iibF2u3k8mP6whjsTNlAO0Fi2/EehOfMgq2Wm+ktQPVHvCmOjF7fvUM9j588HjljBaEZrt3MUdynUyzzo5IBHUpiPGat19Z1A4UEwPJUZrwmJtL1zIgBgMn2+denLU2t710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ab68717b73so44621045ab.2
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 07:40:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869202; x=1737474002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0bWR7N4+h8vCSRDid3JssGaHiwFg+XTpVB6YEkMB/Q=;
        b=mhDQCbLykhAbReE+/l/h/8IdC1Cycj1xFJ4M9DA2j2/geSl2CjHrHwUKq4CfMLRD3M
         sH3SJfa1QQJ7XKdIb2EDpexeLCPQZeRnso+oktSn8JL5dx2xEkEF20QOgg3AZsiFxGSt
         Rj7iTQPgzEP9nzQxz+i8Oi/PcBac652BcwnHzCmLrtjfk9+57Vf3aIpLF3MJyB8SHWK9
         jsf8ZkNb6Hq2OksRBuKP0DNz5bPjiCYdYqkvQqFcfGqQoXLq9HT75w+tpgEYKGXi4yMm
         +d6hqXf8MJvP2Nyoh0IUez4+P6Fx2y9LzvUmelg5zj2VIQxuBebVp1m1C/krqvyfwfFr
         JNjg==
X-Forwarded-Encrypted: i=1; AJvYcCVwziWWOPKTholDWQ9ZF8lZOGUXtq2LsKa/23YwKAXzKICpt4uzWBlAJ1bi3pGi6bBK4h69uYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+9V/GDK6Xh2DVgjBYSJZFgxRC0yihXbskbdQZuvi6fzQrPNK6
	nqt0KBYPFGiuj2JJkclBL6XGTrpnMbi5v5U7M4hWuAa7emUwcDdMGVgPulY+r8oNJsCjG8/V57h
	j2O79kVl73MZq7aLq/78xoxK7kNm2PO9NPuLUPQ1p1MzIi/nW2r2giDQ=
X-Google-Smtp-Source: AGHT+IGiyndoZey2535kRoagwEuVr7g7Uci1iK4DaPJhsEeErehD2LR/OVK5TYjFdc45HpMPVs9u7NwCXD7vvMMq1w1qWXDrspbm
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0a:b0:3a7:a553:72f with SMTP id
 e9e14a558f8ab-3ce3aa5b1ddmr200152395ab.18.1736869202240; Tue, 14 Jan 2025
 07:40:02 -0800 (PST)
Date: Tue, 14 Jan 2025 07:40:02 -0800
In-Reply-To: <g3mn4fcltag3c6l46s3rxqzpl6mo5hxbv7cnv4fxh2x234t34w@r4zh3zfql4s2>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67868552.050a0220.216c54.0080.GAE@google.com>
Subject: Re: [syzbot] [net?] [virt?] general protection fault in vsock_stream_has_data
From: syzbot <syzbot+71613b464c8ef17ab718@syzkaller.appspotmail.com>
To: bobby.eshleman@bytedance.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sgarzare@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux-foundation.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+71613b464c8ef17ab718@syzkaller.appspotmail.com
Tested-by: syzbot+71613b464c8ef17ab718@syzkaller.appspotmail.com

Tested on:

commit:         665bcfc9 Merge branch 'vsock-some-fixes-due-to-transpo..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14e95bc4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ef22c4fce5135b4
dashboard link: https://syzkaller.appspot.com/bug?extid=71613b464c8ef17ab718
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

