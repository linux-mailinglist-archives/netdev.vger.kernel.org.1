Return-Path: <netdev+bounces-181281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A31AAA8445B
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 15:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FAB4C5BD5
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E9328CF56;
	Thu, 10 Apr 2025 13:08:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7949C28A406
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744290488; cv=none; b=DfbHKvuXja4ET/2hXEzxUWAz8Ss0nloqnVBl4NLMHZa5+2dkFPJaMJ6ivqhq+Zjx4wZs9Yl947R6h/35Vjc3RtthfU5mZeCCWlPEsZkzcnM26E7Lsq96/po3N9v+I+scrCqDZ+GrR+/tMp3fOoB4blBxDqNACEhojYxJZh8gTV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744290488; c=relaxed/simple;
	bh=JdhG3tTrQJhiNkOCK4idU/+3NMmGue4emBCL5uR6tt4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FtlGITmNz+raLmk1ihnbqMnuM2mQJaWkpm9clPMG1Fvvrn0eqiFCYUeOVBogxqRCcUyXJTwwmpFiQEpdgyTktm6h8FURwImTGyNKdnCbSPZKPTaMMOW/pi1XCLrSRHNIzuWbHz6T9bd56zAQ6u1ZYaNopkW3UbA4XNoZu0FKdkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d6e10f8747so6938225ab.3
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 06:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744290484; x=1744895284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAM7Rl7gk8QQiNEfx9Z0fnw4DIGYAK6MNq7KFJWljsQ=;
        b=l+wxlBwZw77+Mm2KfDKGygNja+IFPoo4cdiQSHEAcBQGyPaeh8KWjErk6rauAKT5GM
         jMHUOGes5bD55RNJyD3YaPruEQktBcWa4oZ19ijwemhpInNh1YeSwbliKHy+iKjSX4fv
         YAyY4B5vXhsUqMgxw9N1/QyvKtclFZEtxLfztEwPuHAzvWIE5U7/chPR7nSYbhYEGHdL
         CLCGFoozrN43KeF380RgqK9AQbQXpdnwSbPb+M6vysDUlICCD11YnF/xds1tbHzNR8LH
         /jE1f44vnzP2h/7rb7/1XxccoabVHzLypxAzi1r/EAkGP1cA+6dhNgQgCWE4niuJHbCo
         4IWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+V2Er0xL+1tXnBDuWGx96/TvhV5ZavdC/Kbdqx0Izap0CsnuJScfaCMEDtU6jkqg8grrZjac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiNGPxt8/yhodTQTRufTjdyGnvPqSkyRf9WkcgKX4ZEZ2usOEE
	MJ6gjqU+TGWxKJM37/WawfB+ASLSmXU2TSvx7S8UAuFUvxni0f+lwwwk3nEJ5OLDnJ10m+AmQvA
	HEHELCEJEaEIjmGVi/pY5i4tr3DQ3yEDRNNY3oHNdIxdrjNNjQiEVh24=
X-Google-Smtp-Source: AGHT+IEv2WwHH7NMuPuERfOghvKzL9goTCJuR5/dwuwfsvYgHOe0pNhL/2YDQF31nOzT+efUZ+iSKzdSlaMaI4aGK/0eWmTNs4O0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1909:b0:3d5:893a:93ea with SMTP id
 e9e14a558f8ab-3d7e5f728d9mr15715155ab.13.1744290484617; Thu, 10 Apr 2025
 06:08:04 -0700 (PDT)
Date: Thu, 10 Apr 2025 06:08:04 -0700
In-Reply-To: <20250410124124.1189471-1-memxor@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f7c2b4.050a0220.355867.0002.GAE@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in queue_stack_map_push_elem
From: syzbot <syzbot+252bc5c744d0bba917e1@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	netdev@vger.kernel.org, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for batadv0 to become free. Usage count = 3


Tested on:

commit:         e403941b bpf: Convert ringbuf.c to rqspinlock
git tree:       https://github.com/kkdwivedi/linux.git res-lock-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1511f74c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea2b297a0891c87e
dashboard link: https://syzkaller.appspot.com/bug?extid=252bc5c744d0bba917e1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

