Return-Path: <netdev+bounces-118973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2958E953C2E
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 22:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB75E281875
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 20:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0929614A617;
	Thu, 15 Aug 2024 20:52:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9C2149E17
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755124; cv=none; b=qv5vvO9B4jwyYRXx4EPZ+8lNk4h5b19CciOP7GRj/zAhGKkkt65ll7h50Z9TSyzVRQtdv3m7ANA6YEqtjAEfJaLm8qowiA2TpoAYLWIhJ60Gbj9GpSgxhBdyXkl6h5yzhOxzKFBCPjUDzycAB3Bnp5ZSPehgf0wcvXtRaw6A6Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755124; c=relaxed/simple;
	bh=rd1Cnjg8HqvTRUrkPSu71JAx37ijk2fo18kKgdeESyM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=geK/CvREhHJid9keuiaDaPDPpYullsg1t4yn5nDe/NJVgMDAJmsmTU7IvdzlPh/C7zfk2TQgf3Gj8YuUGISX8dm8bYBfJ1SaLjfnoGTFZy8u7A8ExIKdBx8CZSm3zZqoBGsH7toisl/7kLeuY2MmHv93I7FMhadagSVXnOBIL0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f8c780fe7so134743839f.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 13:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755122; x=1724359922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmfgG2sEu8+G2CG0RoP+yWQdYWCMeIH1e2ClrHYdhNo=;
        b=l1XOMSDgHhLPmXbpoY5a6uEKEfwTV0SAnK6X67e3ddR8GOum/caq6GPOVl+xR4UuJo
         CtDxRz9d4UAy9l+teey0DMndcpoYu/JseojwtJfENsZSSGb4bfoNw6eKJrbYILKAxuNk
         5McFWduJF/VUBv8xd5ykOh7b2fgIQrS2Bj0MbqOki8JLj5qyqyKbdk/9VDta39jGukkF
         2hcMMDb7ja8HYd8Ikcy0oQOfmes4JD/rMtd7YbpBgG6NwaFjkXp80C5VfYFjqZHl/RJS
         0DHFaNTmNF91Hos9UssRSUQ6J/IFh7Wnv+KF6iIqWViBhLRhnUZv4kGjp+rm0HWp/nt9
         wp2w==
X-Forwarded-Encrypted: i=1; AJvYcCWObpFp2FbRyUvIQiHnS7fLycoxaALH2z65nEYCMd9u0KNWJXDk9dX9m7rITqsN8j97gcP6bYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YweSbDK7HKg/JA0ddrRMBvWsiMWZ3dILuVtxr4NeJdv0lNKLibT
	6RZSEyfn15RqmdItwQCwW5PcVg+I1+md3pXXc0DrZfbIgyVv/Mzd94SkhaZDCG3lZAy67fLRu2Z
	NNFa799oUmE2uchZN/dUtUmsSRFk77Agf6iJirfLPTdB2QmNVh1kRfCc=
X-Google-Smtp-Source: AGHT+IGs7lknKx7FKGwrwcQBq/RTU7sOk433dVOXfbde2SVdrkw8EbZkPKVZznsNhq50/MdKqJG7u++q10YXlQD/zoZGK+6GjHrO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:370f:b0:4be:d44b:de24 with SMTP id
 8926c6da1cb9f-4cce15d4602mr24400173.2.1723755122515; Thu, 15 Aug 2024
 13:52:02 -0700 (PDT)
Date: Thu, 15 Aug 2024 13:52:02 -0700
In-Reply-To: <20240815200058.44124-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1f1d4061fbf03cc@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in kcm_release
From: syzbot <syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com
Tested-by: syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com

Tested on:

commit:         9c5af2d7 Merge tag 'nf-24-08-15' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git HEAD
console output: https://syzkaller.appspot.com/x/log.txt?x=1643f583980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60413f696e3b4be4
dashboard link: https://syzkaller.appspot.com/bug?extid=b72d86aa5df17ce74c60
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=123cfde5980000

Note: testing is done by a robot and is best-effort only.

