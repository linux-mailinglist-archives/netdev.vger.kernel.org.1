Return-Path: <netdev+bounces-96604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229BC8C69BA
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 17:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A192832B3
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDE615688E;
	Wed, 15 May 2024 15:29:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DBD156676
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786945; cv=none; b=aX9e8y0DTNSyDLp066cnZn/9hsNMixeH/xhFJWzgqP/zI9QD2BiHtX/1+zQcgzeRQ18QglkxRULLkSI5BInasOnkFtQGAnKJlq3V2v30908ENrRi7BocXv/J2T4TBBwXXA8FmhcjSnHPkQDnfHE6y5rqM9LkogLL/v8MfKnY1Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786945; c=relaxed/simple;
	bh=PqF49Gws6c8IE8QBsjCzrN5yCRLZFu/Gy9G1aU4u6TQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HtJVml2yu4CdiGn4E0uhKCIHfzknPKonlsMu72JG5rrD4kDbZL2HEgLza43diZWvhxlCi8+UNColmX2obAxpGCJm0+IjYJh5+kQg9AeAjGruRF/IZMX8s/NAhsqPf1YIqFTwNqKjdKLdxa6WmLz6y8KK/gr5YQMKxo4eMpzFvqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e1b97c1b19so667432339f.3
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 08:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786943; x=1716391743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNhrORouLQq0zE8Q1N3mawbELctD4U2yYjN8CbPX7CM=;
        b=nDFJRyUNWWh7pF5luHPYvW84VKorT+B/2gpDjJs1XphHHMP+TyDdMIXNlGLi/ZKeQo
         vXuKXgLkN1hw4eb7tg/UBMq5tuZle1fr8d0YOSCCaryU8uFw6TGvCNJb95sHwVlk0mO3
         h5zwSKVAEKFjIwF/ZtnfCUAENMj+qTcj19IbIM3IkQ2kJQyzkuIXqTLXaX/rISybuM8q
         I5AfvkwPsz/m/2u5mHdMtyRATYFzDXSibhV7ptH+PcHlX+uqRaWlJ6dcECKPpLkfH8xP
         kU+hCxc9VOpHTV9lRb4mMioN5YUshCbjzVC9GgwhRvWcq80D/JkBLzXGm7l+3Iu0dXRy
         N06A==
X-Forwarded-Encrypted: i=1; AJvYcCUQGC5jRWm6NR95tvRD1gRYL6txsCfY0Y/r9qCczgGgmkaVjkrnBC8KTjEX0dKfgPP0R/wOIwicrNNotelaEQdhf6Gb2XXY
X-Gm-Message-State: AOJu0YwvNwiXnX2Td0FurjVOydKns8P7d+Je1chGS+XNVfZ+btcJYeWV
	SIZvVfEAN6SmSoLnI+4+NqPU4OSxS6DnZ9tVoOf3r8oZHq0DHYatQlVa7yBsSrmZUueaYdny123
	Su4PU1UJEBUkc4a2ux77wSr5iMUkcPqmPp2Q0stRdxlLrefr6PWguS3M=
X-Google-Smtp-Source: AGHT+IH+Xte0typid77mQsPKT2woVUNNSCR05/igZC6Db/CLD0HuhNNjfiuJzefv2sWGB81JP6W0lDIe2IrKsModHuY5ZxKJgzzk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8725:b0:488:cdbc:72c0 with SMTP id
 8926c6da1cb9f-489586993ecmr1725942173.2.1715786943579; Wed, 15 May 2024
 08:29:03 -0700 (PDT)
Date: Wed, 15 May 2024 08:29:03 -0700
In-Reply-To: <000000000000b97fba06156dc57b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000485a2d06187fc7a7@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: stack-out-of-bounds Read in hash
From: syzbot <syzbot+9459b5d7fab774cf182f@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, houtao@huaweicloud.com, joannekoong@fb.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kafai@fb.com, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, songliubraving@fb.com, 
	syzkaller-bugs@googlegroups.com, yhs@fb.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 9330986c03006ab1d33d243b7cfe598a7a3c1baa
Author: Joanne Koong <joannekoong@fb.com>
Date:   Wed Oct 27 23:45:00 2021 +0000

    bpf: Add bloom filter map implementation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1543bd5c980000
start commit:   443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1743bd5c980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1343bd5c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=9459b5d7fab774cf182f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d86795180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143eff76180000

Reported-by: syzbot+9459b5d7fab774cf182f@syzkaller.appspotmail.com
Fixes: 9330986c0300 ("bpf: Add bloom filter map implementation")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

