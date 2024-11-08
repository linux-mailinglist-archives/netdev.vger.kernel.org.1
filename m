Return-Path: <netdev+bounces-143210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA09E9C1667
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 07:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6961F23CF5
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 06:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422001CF5DA;
	Fri,  8 Nov 2024 06:16:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ADB194A5A
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731046564; cv=none; b=Is5UAJkiIOX08i65qGTj6SnTUpfncUWbZI/A65sXDM06bjQ1Urei9Ttx/a5sTXfPtRzcmg2QDoeWKMB8DqMqXL/U5sEPZQ9C/Y9PCB4ElhCto+kXLEUK+qJIvKOdydbhDwVQIbItPPGDyt6MHNw7+5R/Y2lKYAtcTbrOXJpqVrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731046564; c=relaxed/simple;
	bh=RqQv4WbQIDXLj2sNH9vALbQ1ytIJgGwZWi4pqnDoTb0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YYijf6lo3JNhPOBTbMiCV4NamOFKRWruq3add0FNI0QahVFAdCQhqvbzcoeNoiNyrVNE4cGlpUjHs9UjYBDmDmA6ZLWpAjgSdQYKJ9v76MOkG5l1mC2gEAE+LuYvuEtq7BhjKmY0S46Oexn5Vk/gOBrsgqshFta/A1lC6aer25w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6add3a52eso17196895ab.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 22:16:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731046562; x=1731651362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1dkOBb3SQFXPdGZ4MSv67wsI4Fh7AbjyXh8AbjtZKa0=;
        b=Wrn4Z1zbTQvYeljSinwY1UkLJCK3EFSRUvITTtM8WH/742Ad5++uz0d3rdHngZX2Pz
         Q9+jY3yxspqSwZr5VE3zibzz4/b7m5UTpQGVS1CGuuJWQAX4WZn7vfhUqFzu2r02N72b
         S9trw+5Jwit1pk7V6fBBB0RXwWoaG7Suw7tiwx7Mh8hxLaTFPACQcrT6301zLqiPAali
         NCsZw4nTjq/5HDOc4I086yYdUi9uZyJYm+G/C6Eyy7ue2mS2m6FP38B0vyf7a1S30GXq
         tplEzeGIGJVvMV3GSJODZnYz7D1pxzCZX0H7X9b2O3J1ADEzSpixfZ4y6IncuB1PJ6sM
         prQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBmp+LD0NkpvOkVB/cI+VZrjV32HOap9V3pTY5H7j9upRaYE909+4V6egO258c5rXwgi7LywY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWQAD3Rgq2UPvaE5JCKGDF0FhqFX0WfihmNuMsYLE2cNaMbUHb
	UZqihM+H+fo+nnO8mY6gi+Bu/zd5uAi+XzU497uxP4NOh1oawbNU9FRAMzNxA6TIH0eRRpLtsG8
	qKGoS8tBOpVXZyRhKnuyfhvorkrFxtokU1FPaNor6EM3m7Y+nG58IQRk=
X-Google-Smtp-Source: AGHT+IH7zdDwIblFzHkND/X2fTq2H+dE0aDfkmw2UPK2nlcDwZijZwh8JJxdtJ5qbwrVvbF3AnslsHUH7uN168EqXAwhEtJ/g/sC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca85:0:b0:3a6:bafd:5650 with SMTP id
 e9e14a558f8ab-3a6f11d49f5mr20784055ab.10.1731046561872; Thu, 07 Nov 2024
 22:16:01 -0800 (PST)
Date: Thu, 07 Nov 2024 22:16:01 -0800
In-Reply-To: <6706d42c.050a0220.1139e6.000b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672daca1.050a0220.0db4.01bf.GAE@google.com>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_threads_set_doit
From: syzbot <syzbot+e7baeb70aa00c22ed45e@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, anna@kernel.org, chuck.lever@oracle.com, 
	dai.ngo@oracle.com, davem@davemloft.net, edumazet@google.com, 
	jlayton@kernel.org, kolga@netapp.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, neilb@suse.de, 
	netdev@vger.kernel.org, okorniev@redhat.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tom@talpey.com, trondmy@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit b4d8f228915f98f09974ef84ec028cbfe7a84273
Author: Jeff Layton <jlayton@kernel.org>
Date:   Thu Jun 13 18:34:31 2024 +0000

    nfsd: make nfsd_svc take an array of thread counts

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11b8c0c0580000
start commit:   5ccdcdf186ae net: xilinx: axienet: Enqueue Tx packets in d..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13b8c0c0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=15b8c0c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=672325e7ab17fdf7
dashboard link: https://syzkaller.appspot.com/bug?extid=e7baeb70aa00c22ed45e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13526d5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1654a740580000

Reported-by: syzbot+e7baeb70aa00c22ed45e@syzkaller.appspotmail.com
Fixes: b4d8f228915f ("nfsd: make nfsd_svc take an array of thread counts")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

