Return-Path: <netdev+bounces-161138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9437A1D980
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 16:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBFF18872F2
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 15:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B5260B8A;
	Mon, 27 Jan 2025 15:31:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4235D1AAC9
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991865; cv=none; b=Q9d0XryDV1GGwz79/MM9GBEYUQzbfV3wcDDOsfg25H7Hh0BLu9jT1YkotA3pzbY2o71I5q/nQYknTiR6lrZfygerdRg4CZF/ZBH8ToniyoQz0kqgbeyTQQKTbPi5MotlU/nLSA+x2IFg+LpZIHBanuBDd2Kc0dr0B2QvlFUhhfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991865; c=relaxed/simple;
	bh=pk0falugNVXW9YaSYAKN1kLbELC3pSSmtTENQHaRLYc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DePmig7xWYQzwZPD12p3r8K8sbYfROzBehVDJm8eUhN3qMW6BRHcoNPAODiUx4NBB46NyF+sxfkQtiAXQNiYUqTw281w8XD8kmWbvao5/i7k0PcPEBqIMzuwi5l6SWqFyTYuEd1lfuhvY1M6Db6p3LzQ/2m8lTF17XWlZv98370=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ce81a40f5cso73165045ab.1
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 07:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737991863; x=1738596663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTNYafEybL4lXeY2S2Qmsrv13OQGCeTdEc6zMRGI760=;
        b=cBOynXCVMVq7hURHd2SqbgtrCGvtrJAz03Bhftj2Uv+E4XNHEjKKpb6WgseMsepEy1
         weEAi1b4cIpS7nFUs04jQKF6UlHr/HgDbB5fIMFM1RalFmYNTxUXI7ovAVa19Soc8DZh
         L9j+mGHJJM3ziZ739/9z/6Oi4VsqxYGqhnMytca+ae4NUmJG0ifZsvwH8udcaSHVXQae
         xXl+tqTcjyTjsLe4rcbtBzKb9HeOo3ZoK/isBgaU8rlpLkoqNXbxS9P8cfAnbxs5XCoF
         JS2JQyd/oyEobuMYGH80uec+Ouxfzgs8WoEAnJBpGSwEULXRv1W740MEEP4bng4Ocx2d
         t4Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVEFHfmWW+hP8keFrIzVh+B1liNTcgVZbrR+xwiANzMsN9XGcHZZvhkxa0tX7yVFuYSix+JAKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsNkDV5hrj5zhiuK70M6aYyxFoARI6yJDleXZ/9kIBocVYW55u
	lXJsLRYMs1nv+70VXhLMW5fP9z91TrOFq4bdDXDgRdj+5w/ihqoxArLOi4fRkRzk/YPEXf2FKMa
	LzC1FZ4QyUNgWQ2BXPe/IcRioQpRuT3/BQyD99jvjn1/SzSZOOgDxVXw=
X-Google-Smtp-Source: AGHT+IF0k5Aqucvj2ffNiCSgdgQE4Eik8GYb/V1Y57DZpMfTifsnu9wpqZCJNhjDBi3HTM+7rzOrPAIeuRSdWD4dQZM8q6G+xIjV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4c:b0:3a7:e86a:e803 with SMTP id
 e9e14a558f8ab-3cf743f8834mr360037455ab.8.1737991863199; Mon, 27 Jan 2025
 07:31:03 -0800 (PST)
Date: Mon, 27 Jan 2025 07:31:03 -0800
In-Reply-To: <67555b72.050a0220.2477f.0026.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6797a6b7.050a0220.ac840.01cd.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_umount (3)
From: syzbot <syzbot+1ec0f904ba50d06110b1@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bigeasy@linutronix.de, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, edumazet@google.com, haoluo@google.com, jiri@resnulli.us, 
	john.fastabend@gmail.com, jolsa@kernel.org, kerneljasonxing@gmail.com, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d15121be7485655129101f3960ae6add40204463
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon May 8 06:17:44 2023 +0000

    Revert "softirq: Let ksoftirqd do its job"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1066f9f8580000
start commit:   feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1266f9f8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1466f9f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=1ec0f904ba50d06110b1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c060f8580000

Reported-by: syzbot+1ec0f904ba50d06110b1@syzkaller.appspotmail.com
Fixes: d15121be7485 ("Revert "softirq: Let ksoftirqd do its job"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

