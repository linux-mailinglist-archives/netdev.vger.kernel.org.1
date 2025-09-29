Return-Path: <netdev+bounces-227210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0262BAA477
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 20:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728B11921083
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 18:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF85D230BF8;
	Mon, 29 Sep 2025 18:23:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C830230264
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759170185; cv=none; b=DcDUeIqGHsXqQCFzttT16ck4DdoOCzx45G/F3zQRUCl9KvWbH59tMMmOzbuLNJuIfPNhTGb2/RAajcHRKCWzyaFc2HZk6UuJRlv+Fi1HRQbJcqW1GB4fFkzJLIApvcMtTW9v2vWwRZk9fpHAx/sX0B6u4UpVvHFPb9k88Ldn468=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759170185; c=relaxed/simple;
	bh=3KZAsrzTTWqi+8dHxXx0RD7GNMeEQiSWFagohsu82wU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nqK8wiN92ZYOnPHYnCWyKc8WNfqQDREe6bT9plnJfQS39tVwdhjz71eurhdryXYdDsosQ5ZZeQxUL2vsbqQIrU+HCILF9Ntj8Q5en4NlhXFdLoWl1NmS14ZMRFhFUcj4D/zfr7FtC2nE03zgNOUlhr0XzEC1m4BupQ4ddXXLy04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42721b7023eso40752895ab.2
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 11:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759170183; x=1759774983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHGfRCy971BidLIGKmXNRjtiMIrtdrzx8FQpVLEgzT8=;
        b=J1XGd1xiqXJgEOrq+kRgorns0ML6l/euormS60rwxXpk1JkuwtenAsHmWB983DBskL
         /W6pzpnsBxyVBNVCX0iveWxyApm75Ms1Ba8Ssix0VpkWnWPe07uVTgO6pGLjRSI/ssvK
         Yi5r9cPYL3IpDtzaQ7KWidKKX9sfZCO9Yu+78GfOL04omk2PWUDtA996ie6VXqFQXieZ
         IKIV+2LewuAtLDL8jXtrWslPFHpf+0Fv0PG6J32i+zaPgj+2sRU2ofnBYlzN4Cx9PF2p
         JkkRo1Us0IoH+SlCE0190Cb+OW2vgOQuQBubeZr4k3zu1YP8s6ySS14tYX0XV34HBt4G
         utQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL70TPP93LaEU871Y0enbkR8Ju7d4acpHW0yXeUXU9Di79M6eYZRZ1MvimpjIYve3qaZM6DmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+EYwYiLSR/ho+US0FIO6h7WBjXgZmqHt51a5DYHPmPutv/0X
	tkFi6/aA9/pKAbCaBe+kygkfeupD7f5JKqUszUJdkheX6p5J/O8X5muINsda3IxuoICQR9BdN9G
	Y6qhvG431iudrc40DPT2mXkUuu5kekn76O1kb27Q63y1kfKExVG+byx/FUy0=
X-Google-Smtp-Source: AGHT+IEI6GWyUAY++Re/Hf+5q7A+r6rFLnMX/8VZGzS5V/xgJ4OyHU70zkpChbDOVPRp20zNQIUuDHydsiMlfe724N2/IC9up05N
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184e:b0:425:8857:6e3c with SMTP id
 e9e14a558f8ab-425955f47f9mr264351775ab.11.1759170183211; Mon, 29 Sep 2025
 11:23:03 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:23:03 -0700
In-Reply-To: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dace87.050a0220.1696c6.001b.GAE@google.com>
Subject: Re: [syzbot] [bpf?] general protection fault in print_reg_state
From: syzbot <syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kafai.wan@hotmail.com, kafai.wan@linux.dev, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, listout@listout.xyz, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit aced132599b3c8884c050218d4c48eef203678f6
Author: Song Liu <song@kernel.org>
Date:   Wed Jun 25 16:40:24 2025 +0000

    bpf: Add range tracking for BPF_NEG

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13931ae2580000
start commit:   bf40f4b87761 Merge tag 'probes-fixes-v6.17-rc7' of git://g..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10531ae2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17931ae2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=d36d5ae81e1b0a53ef58
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16010942580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12caeae2580000

Reported-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
Fixes: aced132599b3 ("bpf: Add range tracking for BPF_NEG")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

