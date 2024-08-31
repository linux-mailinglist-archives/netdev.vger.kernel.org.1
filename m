Return-Path: <netdev+bounces-123993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D649967341
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 22:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837791C210D9
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 20:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631F317E900;
	Sat, 31 Aug 2024 20:55:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26AE16BE23
	for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725137704; cv=none; b=HtMAHupzgZgtpz3CcvjDmStvikt+0Pz43+OS3eRKKj9bCe71z8mH8oJ1yf5AQbBF5Uc26VN90FCeswVRJq+wCoF/i5X3jRLZ6I9JDo3UMoEkU36oZ1c+M/K9fyQyYX9o1OtziBZhChmHCEHIclt3MIWdiHr+zUPunVl6BbxdzQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725137704; c=relaxed/simple;
	bh=jFH484BT5R7q2HOiKMJKv1FmMZ4CHygH+s9H6wFYtsY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tz67U1oZsHTaLKy5qbtemo97GPAbmrfpb/J/Xh2trTADx9dZ0JlOR6MmKI4CeaXVUWydI64eNRMEfXcS0qvurYGHJzC8L04nY5+FjjCKnIRacqKenAhR9sN2UzsJuWpDqt39HY7RjXjYnlNXtYz2yXKmeFcNpoJlnqZM4me80OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a20631362so211856339f.0
        for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 13:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725137702; x=1725742502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXinuCcZsAGJ7z0LOnrPbuvxWrzVfa5BPSiAe1GhMOU=;
        b=Ri/sTrPUjfcmI+cSfQ9eOIaRuJV0NHIM1DFMvgO6R3QcS/OPlf1VoK0deTy5CVUiyi
         HnPdwgSdy8ZfmTDGGFOYhD5a40db3aEDfZLbWttlIGd4T3Adoy/tljXwwcaIQCCDHmSN
         JplfHHvrkzf3WKqpCS1GZThFQ5pMnqoIIN0iCL71UOBOh/0xYAxyGx5akl9ud+k5mqLI
         UxXWee+jEgIJpK/B0Oq38cXcLmalFsyd5Gdm+0LMrTp4KbzBdBDUnbV/hP+/acPk8kqG
         ieKJWlwl+qQy5y5ZVz4HXE4WvZGiQ76b9djan+6uju1k2YIn5BYBcgdoX9CR4Bcc3PJp
         IOsg==
X-Forwarded-Encrypted: i=1; AJvYcCX5E6mIvNB7t9tKAaz3zc/9peUlCEvUSGX7uShZ20bd5q1eHj2bXDSu9uX6SbpU9N4qW0s4Rz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi+o9a1Zjw9uUZS2oWU9VPqYkZ0S4hojbeoKA9HHj/jiU57AjE
	WE9c2iZkcJkRzBExGmr00L/8WhtMH1yge2PUIW/COk48GH/PmdQe7a4Ypp4mBmeLsdKM6sR0r7h
	KQShD12QRLvdZUR4QHVR5ExtuLN6Sk+QLT/8VXoCHUHuV3YAFbk3+Wns=
X-Google-Smtp-Source: AGHT+IGM0VYo+phzMqpcyZHt8FGQ9BOhTyofLbSGzhKKdLQqrxnCP6aoFjZSGJSMGF9oIciQZ2cX72Nge3gLhsO5Q6V4uQ+vSiD2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14d5:b0:81a:2abb:48a7 with SMTP id
 ca18e2360f4ac-82a266d18a8mr41499139f.1.1725137702080; Sat, 31 Aug 2024
 13:55:02 -0700 (PDT)
Date: Sat, 31 Aug 2024 13:55:02 -0700
In-Reply-To: <00000000000099cf25061964d113@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebe92a062100eb94@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in
 dev_map_enqueue (2)
From: syzbot <syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bigeasy@linutronix.de, bpf@vger.kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	michal.switala@infogain.com, netdev@vger.kernel.org, revest@google.com, 
	sdf@fomichev.me, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, toke@redhat.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 401cb7dae8130fd34eb84648e02ab4c506df7d5e
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Thu Jun 20 13:22:04 2024 +0000

    net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12597c63980000
start commit:   36534d3c5453 tcp: use signed arithmetic in tcp_rtx_probe0_..
git tree:       bpf
kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
dashboard link: https://syzkaller.appspot.com/bug?extid=cca39e6e84a367a7e6f6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13390aea980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10948741980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

