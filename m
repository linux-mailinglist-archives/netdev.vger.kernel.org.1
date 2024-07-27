Return-Path: <netdev+bounces-113336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB0293DD3A
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 06:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1C3283292
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 04:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD8C4A15;
	Sat, 27 Jul 2024 04:24:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2834A05
	for <netdev@vger.kernel.org>; Sat, 27 Jul 2024 04:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722054244; cv=none; b=LKAWGxyxwEcGTU1xW9OZgEz++mT8zY+71b6T9mgTXjOnkJHvwLkJTAZDEIhDPLFrr2SfuQ4N4k5LJAIl0DUiPb0lWWeSBThLVc1Yt7BSqhGHpv0H7JknIQAHwWERQj7smJ4K/2aoDlVmoY6zdjh1RNVnNhUIcm+D4RlcZB+dHmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722054244; c=relaxed/simple;
	bh=7BEkPCzUWsk8dHlmfgIOkCDnYEaTniLFcu9hth9I/BA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F4cWdUgvo3WgOc4V/CGZuunNBU2/8NvnWN5tAz89h+vPPEBq8KoXgt/6Wi715UEMFzZuUyg3UxwAJXzskjpIiGEvaF97L7Jva+0AH/TlsomyoinTCFRpppTy89P8RvB+KTjHQHFzK9iH9QPGZcZNiVU+iZkoej3nJX1rp899qIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39673758efeso37121285ab.3
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 21:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722054242; x=1722659042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sjiHbD9xpIleZSSJIoPa68ADTlQu90pnfJo0Wp9a1zk=;
        b=kyoZzuNSm86/JYibPwh0P0xZcLkdFTMTre1rUdgZBTGZ4w6wmDn/ZydNAVoLlYm7IT
         tJAh9XVbApzdP8sELthZrao/cxaiS33VB/VDVD+IXo6d1pNr0hNX9jEil3QnYcg29i4U
         fsE6nGsWcbQPjhqE/dCzU7dqkm4ar+1SWkkJu5e7FGlNsxIoPeTqtU1oodVedSZYvhjZ
         o7DJiAykKH7UW2usTbQqukvKnRZNe+JPxCFKCsUSulmgpWoGU2tgJfCfDKYC3B6XlokQ
         EyHSHflYHCKWgwpnsKOlr6OTMxgPwrAaFMPC3mF0Ql1Q1KylqLdttCvKIi0auYbM5zFM
         nurw==
X-Forwarded-Encrypted: i=1; AJvYcCW0YhC29Uktf8TSBoEOyVQernL1N0U2Lus57GEYB1Mg1aYNKlmHaNEp1KV1bJ3fv9Y2kHYVwxjHqKYn/VjR3NwK/7IY2bG4
X-Gm-Message-State: AOJu0YzlMvrbbpV6KW6TnQIXOxRLbhty8MY2ZN6McWxo7RVx21OlDiiA
	rRNfiC4CknoQO/zUNt9aJ8Ya2faQ0tXfSOMVfb+aYCsa0ZjQ3eZo38Mhe2ERDOLDcjx9d9NS8Jn
	Rn5Q5AgpisLDUmA1yExYUyfFHryGSqi2ebMuAgGVVtmqh33GBWzfUMxo=
X-Google-Smtp-Source: AGHT+IEGi7PWzzbLudVmfOSs5KS/tPFjJCAWBXmtRdeOk4jp9lydYB2qhMSs+gRUAC+5bMxR6LNjzd3Wujsn4DjHfwaqBRROHMGe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178d:b0:382:feb2:2117 with SMTP id
 e9e14a558f8ab-39aec44f968mr881395ab.6.1722054242401; Fri, 26 Jul 2024
 21:24:02 -0700 (PDT)
Date: Fri, 26 Jul 2024 21:24:02 -0700
In-Reply-To: <000000000000d4e9e20616259cfe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000067119c061e32ffec@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in sock_hash_update_common
From: syzbot <syzbot+0b95946cd0588e2ad0f5@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 98e948fb60d41447fd8d2d0c3b8637fc6b6dc26d
Author: Jakub Sitnicki <jakub@cloudflare.com>
Date:   Mon May 27 11:20:07 2024 +0000

    bpf: Allow delete from sockmap/sockhash only if update is allowed

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13e441bd980000
start commit:   71ed6c266348 bpf: Fix order of args in call to bpf_map_kvc..
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd214b7accd7fc53
dashboard link: https://syzkaller.appspot.com/bug?extid=0b95946cd0588e2ad0f5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1515d8b2980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167b60dc980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: Allow delete from sockmap/sockhash only if update is allowed

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

