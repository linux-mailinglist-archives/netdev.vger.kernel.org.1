Return-Path: <netdev+bounces-117576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E1D94E5E6
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 06:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080051F22323
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 04:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4678F14A0B8;
	Mon, 12 Aug 2024 04:53:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CE5139CFE
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 04:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723438385; cv=none; b=nzadwMZXmfn00JuNW3B5k3Gb6JRKMwXT6MRBwF7U+zJ7B8PagfDjEgchzyFE0pg4nYibgupOHLW8PS/Z7BrLXOgb4wGAWRO47+7Ow4Gi5ti6cnpT/N+Qjjw34IjIjUHRBfbtrYbNkVsiyD3oDb/H6MGCL48/d5ZTDdkeJvREyPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723438385; c=relaxed/simple;
	bh=wbPL9xTIQV0fKwjKstFY4ij6hqeFTYyO59yYSlmm7kE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D7486nK4IkowlxG7KFiAfOhzyF1AVpfHzF39hONziQeLaJnieu4i55TiEGxHL34EadU2r1SEljnc41gF22bgnd7my9/SkUkTtcd7+03vlN1u5wN6GaD5T79GmY9UO2appOWBlswmLLh/EztprqX+hefezbRaELBp07RP0pI+Di4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f81da0972so556499939f.1
        for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 21:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723438383; x=1724043183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCIUv5W1hQZANZ1PEvV4VxKZP1pSyOaOOcCYK3C1sQI=;
        b=KC+OtWw3n8U6Mo9/nEOApNRo0WIts2vdfmouUWyC6RobOeuByqbt4v8SFsvwIajE5D
         EX7eo77uwvTpmfpGFFmGxFvUXL0D3KOXYZkHv71+ne6I5U5ra3bPdPfVQ/MnaCqZYggj
         ddtJVSvKGlfFRc/WiLHZo10OUKN94odqk5qsVmDmomZuCaxZpfergZFcMNuzRMRQke7/
         twKOZmzU9Jht5D7RZwsT2oD7YsX6tQkrrALJg/jNn3kH7hFpCN28h7b1VE94OPx5Z2w4
         LLaQKRzAzEVcDn659n4yTFTEW0iLhzq9iaWMbG7GFY4AsACCQJLA6aLQfZzBYbcvotZw
         pQow==
X-Forwarded-Encrypted: i=1; AJvYcCXLomDY97PtOG3qIilA28H1Q4OjhBlyUSKDkvZwd7idmEhF+5u53o0YnXZ5MUOsna58bOxqGeYpRwRB/Tf1x12wf+5x2NWe
X-Gm-Message-State: AOJu0YzAwnQ3QcYJUQfnHRMq+MfH2RT6wepc14ZcdLuutj3nvOOYSjFg
	+/2Z/155xs/8CMXJ8zka+EEOzLHlWjywSFTJOHjOV/QZjCIlRWrZQeBDJDEYueb2LPEkVvlhFxf
	+ecYUCUuo22R47RGQxAhfuKjpN5yKglc8t67/vxlFcAlNt1xMrmiMu9w=
X-Google-Smtp-Source: AGHT+IHYd+OnzWf3WONlYUINKA2XYz4D597wPU1q1yxE0VsRcZoM2LIA3Gz9v5hY/DdXx/pnUZRWQH+QReSO0PWFGZ2UzuXHaJcN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:640d:b0:806:bf73:1167 with SMTP id
 ca18e2360f4ac-8225ee96f73mr27822739f.3.1723438382830; Sun, 11 Aug 2024
 21:53:02 -0700 (PDT)
Date: Sun, 11 Aug 2024 21:53:02 -0700
In-Reply-To: <00000000000061c0a106183499ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099eca4061f754420@google.com>
Subject: Re: [syzbot] [wireguard?] WARNING in kthread_unpark (2)
From: syzbot <syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, 
	gregkh@linuxfoundation.org, hdanton@sina.com, jason@zx2c4.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	oneukum@suse.com, pabeni@redhat.com, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit b3e40fc85735b787ce65909619fcd173107113c2
Author: Oliver Neukum <oneukum@suse.com>
Date:   Thu May 2 11:51:40 2024 +0000

    USB: usb_parse_endpoint: ignore reserved bits

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11ca267d980000
start commit:   dc1c8034e31b minmax: simplify min()/max()/clamp() implemen..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13ca267d980000
console output: https://syzkaller.appspot.com/x/log.txt?x=15ca267d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2258b49cd9b339fa
dashboard link: https://syzkaller.appspot.com/bug?extid=943d34fa3cf2191e3068
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1022b573980000

Reported-by: syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com
Fixes: b3e40fc85735 ("USB: usb_parse_endpoint: ignore reserved bits")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

