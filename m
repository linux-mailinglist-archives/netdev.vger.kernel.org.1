Return-Path: <netdev+bounces-181873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC79A86B48
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 08:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A33466F0E
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 06:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCCF55897;
	Sat, 12 Apr 2025 06:26:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F6919006B
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 06:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744439165; cv=none; b=Pq9UQ/aTXnpF23psWERp9oUUsENWE+RsLLc+IZNWx3zrt67b78Mo7fNiosdlF6rIzvziTZDNlKSe1nS/o/r0eJR4/LFj5Z94txaJxh2dcTK0Tgyirb2hkYR0fSocxYa+Anx3A1s12tYKG798AoUw9TUglVcvO7cFzjkIIq3j/qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744439165; c=relaxed/simple;
	bh=zjA9IMoXlF2IQ+gWITjMtMmmRvvzM1MQba86M1hAkkE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QDJ07NLQq0s6em3BBEKRlR6oyKd+yNir72irzBmNzEtGW9l+MBP29pK2Ga59nL7+miM09m+4IWi51JMdK1/oCEghhS5LAVm2uPZ6cvfq0u3nwclbXevA17W7+0qsP1X2v/25SaqQggF5AMu8GS1SqXVfLAZdF6GeXwGquFMZHWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d43c0dbe6aso52898875ab.1
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 23:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744439162; x=1745043962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7pttFx1O6P8ng4Jkcmf/T3DH7cXDuHmxWgJ1Rn6+98=;
        b=LxkD6aPKJRy6cyRBKNkEqfshABje4Z68+qEtHePrwS+RWNPcOQA8yYsBFWiGNamoRB
         izI/jKER1kXddKH1DcHIDBhsWXKH7SvnWcYGYBfiZeFwoLwk4fqNRlB+yXbpS7GZkS0z
         XrmVA250QcuFQ3c9UanP3AFsYCFv/Tvpn/USpVQgg49TDJppxcS8BVxEIB7q6fRCGxhf
         eh0HCdk7qfjoeQ+DGzwtBLJ1JaSh4cWrakSjfLAk87ZIOPunEi61ASQDmjmDFZZ/Nzd2
         jax0tvvo+p9PZ4qlyDZJbMTYyvnwY++EckISLlZMTxPTTmRgSu0pukWZ8BcXY9sG+Tzz
         Y5Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVvjVYR28hFpm/9GdhTbmjm6BCWwKJ+4zSOfcw8v/6f8banwfWXreUP4mgznZqgzJClAu8PxKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0auUTOyyHQ+DXh+B2xgXvI0mTNZ8AnBJj2yj2J5tIwdqGw2Gw
	CcMVClVavuaeKEtvP6/C0IN9A6H2SV3dYG3dPjV/hl8axvx2QPVpeQaDUqLLJgrtrXh3srwEtfa
	NCrSNDA+rGywN7I2urJ4b5DHOnSaucGHWpSQsIgYmA86NWRv/UR0eJ+g=
X-Google-Smtp-Source: AGHT+IG34fLR8s87QCkirZyimVSt8DfVCzD5DN1vQwsxH5TRHhPhR+G8guF7fGAgVlg0wM0SP6SIA5hpf73XP5474nqpzyGkCsZb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:6:b0:3a7:88f2:cfa9 with SMTP id
 e9e14a558f8ab-3d7ec225f03mr53785075ab.11.1744439162437; Fri, 11 Apr 2025
 23:26:02 -0700 (PDT)
Date: Fri, 11 Apr 2025 23:26:02 -0700
In-Reply-To: <d16ba399-8ddb-4d4e-9c1c-3f657ea86abe@ovn.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67fa077a.050a0220.378c5e.0003.GAE@google.com>
Subject: Re: [syzbot] [openvswitch?] KMSAN: uninit-value in validate_set (2)
From: syzbot <syzbot+b07a9da40df1576b8048@syzkaller.appspotmail.com>
To: aconole@redhat.com, davem@davemloft.net, dev@openvswitch.org, 
	echaudro@redhat.com, edumazet@google.com, horms@kernel.org, 
	i.maximets@ovn.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, pshelar@ovn.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b07a9da40df1576b8048@syzkaller.appspotmail.com
Tested-by: syzbot+b07a9da40df1576b8048@syzkaller.appspotmail.com

Tested on:

commit:         8c1a4c54 net: openvswitch: fix nested key length valid..
git tree:       https://github.com/igsilya/linux.git tmp-validate-set
console output: https://syzkaller.appspot.com/x/log.txt?x=15a29c04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=36f90188412b4fb8
dashboard link: https://syzkaller.appspot.com/bug?extid=b07a9da40df1576b8048
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

