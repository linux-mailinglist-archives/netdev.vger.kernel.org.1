Return-Path: <netdev+bounces-220971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BB4B49AC1
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 22:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340843AB5D5
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 20:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E272D7DED;
	Mon,  8 Sep 2025 20:12:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7F51D8A10
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362326; cv=none; b=eoBzuDlq/78ic78YBunK8i8l3ZcBMpZeoKiCHaFrSoivitC8s/KDzDgtiw0iAPbpMsB1DFInFoFzzIwdVmL0y48i1f5xL8KOg9aSivFZ2i17XO5jkVTWXG28MOsEwNYGzyo0Q46mvIKGWRLbZJ+0SjB0CjkNFaOE83n7yKyH1Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362326; c=relaxed/simple;
	bh=WSIoRV+4dq+La932BdB3eUBY+0kr7L5QrWYY7oF+82w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D27eIKVmo8qF63ZBM2MB8JA7w6wOV8Ca/5oY4D6c2uwE9hovzny/Ijd28WtQlqTTzvid1K0i1P+xhZsrK5S9bbKS7lgBvYFJpoLdcjWapjnBvm1tdkTynFfvz4OI2jxDQ7WXhANBXYHdr858qvY5XJ0HxRZEA2VciJidZvj0nxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-40826edb6e1so47648125ab.1
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 13:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757362324; x=1757967124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUVU0Ff8fQ+u+hL7Q5pC0b/mSJVhOT9pIEPHC3xJKiA=;
        b=mWNR63XrWqfU2rfmGkETcUaEigIDpdEpytOhVPPc+5Rrn79nu1z/0iS39gh/2qpPqb
         K4YSrJySMinNGdfcPK9PZz+WVKEIShPnIDCuVJ7FYd/X1AEt4I4b2qppzs8U+CU/wBos
         l/x06W/Vs1pZDld+IRA1rk9+4uJzQVgtGuESX7jLE3eSlZkTkQsaD7+nyyUcs+SW363z
         9L9lRTU08ons6rMic2F+mtZQfnvBbgcJrbIcXTvfJRR7MlFRi/o2422GC6HzbcU2N0eZ
         cNXoyVm9EAIt2GWCrG9P0hIKc/pLzZfUy7Hb4avJIawZQ7D73isl6vgzlbeuV5Yth5Tn
         JebQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj3oBdIxfj4eti6C8843B9qcHYel1+QAIey9FjR0Buc+JNA/pwG/g5PTRCLRT9u5oqXw3j+0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj2Ko6y2N2v7rxEH5Rhj3OR1egD/5UXqH3D4ram7myke5QCGn/
	GAacS/m1l2F6yLaoWc/+FJ1bB9Hz6sjTZlcO/n98X2yQCCZ6ypjkvcloMppbmKgJKfpAKSRgDBe
	DW90NraUEpl9v0uQmcbu4Xe6huJei3ewu3VHtvzIuUXtAh2PTNTLTMrZntTo=
X-Google-Smtp-Source: AGHT+IGVhC7g/XMpsLDsz/IZxR5D5A09ltN1f439U0eM0rM9IOQ0kdLoc8NU3w/85NGnunzKaEklMRswAVaqru7LxbNnoA0qcBEA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a61:b0:3ec:248b:8760 with SMTP id
 e9e14a558f8ab-3fd94a13fc3mr140050635ab.18.1757362323770; Mon, 08 Sep 2025
 13:12:03 -0700 (PDT)
Date: Mon, 08 Sep 2025 13:12:03 -0700
In-Reply-To: <683428c8.a70a0220.29d4a0.0802.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bf3893.050a0220.192772.0885.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING: suspicious RCU usage in corrupted (3)
From: syzbot <syzbot+9767c7ed68b95cfa69e6@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, charmitro@posteo.net, daniel@iogearbox.net, 
	davem@davemloft.net, eddyz87@gmail.com, edumazet@google.com, 
	haoluo@google.com, horms@kernel.org, jiayuan.chen@linux.dev, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, shuah@kernel.org, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	yangfeng@kylinos.cn, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 7f12c33850482521c961c5c15a50ebe9b9a88d1e
Author: Charalampos Mitrodimas <charmitro@posteo.net>
Date:   Wed Jun 11 17:20:43 2025 +0000

    net, bpf: Fix RCU usage in task_cls_state() for BPF programs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13745562580000
start commit:   079e5c56a5c4 bpf: Fix error return value in bpf_copy_from_..
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=c6c517d2f439239
dashboard link: https://syzkaller.appspot.com/bug?extid=9767c7ed68b95cfa69e6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114915f4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15566170580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net, bpf: Fix RCU usage in task_cls_state() for BPF programs

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

