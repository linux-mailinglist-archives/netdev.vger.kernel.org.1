Return-Path: <netdev+bounces-108388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22788923AAF
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB582283B19
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD004156980;
	Tue,  2 Jul 2024 09:52:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6CA150987
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913923; cv=none; b=hmU/qmkZ0kO3gyJumR8YrCmn1GN5KORnONg56UwPRNu8Cbw9poB4ZZuoR1syEJYY7KJpZyGQrRI+CQFpujBPRGdQBJJnnZ21c3xeDDLPCuLPncveng6zTZpX4355nC0kJ8EHHQX8LsKcRHNbAnvuYrIU6utMGw/cAs7F6fZO6Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913923; c=relaxed/simple;
	bh=lXY2X8K0XjptrYm6YYDokwI6irXE0xiGwkCu7Dav81E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=llq3jxbRB9sL955S2gdaE/1piFDyFFhqy7xFL+HNn0qus3l40IrZiJAvwv7yH5kZK+i89wz1gTmzj6k5GKAbiJ0dr6cavWO03Md6mVP/qYsOyh6JpmC9oyk+3zOlDFu25GMSSqkhJapFm3PDFFQ/wO4jBWPdn2Uh26723Ta7C+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f6200ad270so428902839f.0
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 02:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719913921; x=1720518721;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9b4bWMFEWWl2Go9Q+boI/fxAFB2QlxWJEGLP8d7bMM=;
        b=lq1mllrUZOaa6hMdaBEleULsj5fPNdM1CgjsMo5CB/d0i0SAhu6DEld2gwOsvNmWkj
         PWzU40XIt3aO1AldUoxoJLJqC00t9EnRi2LywPpv5RJO39HHIHGAx1b5dUwH0quHVcWq
         KvD3EPy4pUasPwpVmWR44mUKnrrtuDFt+xJV2PgT2Hzpr4TWW0LRcMwPyr8NHPmnqf6S
         nfvsFIo0ixxViGYgZII5jAYzO5WiFvMjZ69NHRkkNwkgAAXtbbjA6mMa53pD67Gcg6E7
         dJHFsL7oFKStIXutqJ8hf/85f8lZ2iP2e7gtNgeJGAWbJW2f60NkPvz5zXiBD2lCbhLF
         4/EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKXyukcnmWxFwG5YZwIYqGo9ZzN48KL6ueymw2dGQFgrRE8wf3dPXUx+yr3DbJnUfERQ9LPa+cDgbk+nz49d1c9ikhAy+G
X-Gm-Message-State: AOJu0YzcjLG8cidsn8cQsO7DkoBqVGWruawAG+hQjTBYw2l0If4RiOK6
	2Km3kxJJ85Yu9qylTsYrUBAscXuAkWVVrwo0lPx0cqGOWdI8Qrqc7+eah1g4JTwLgDGNCKADme8
	CBjkFWN1VLTIFViWHtWcP0bq3qMpMeLNSDqHLA/tGRbBRV1zrkYJsDEQ=
X-Google-Smtp-Source: AGHT+IFaEq1cmHnpCH05HIC7Kr/wWnCkdAe6BJFKRNmYd0TIN1/uja/tQKcGOmV9w2Bt2ED/Hd3eqfhFF3Mh85uO5nS/thOv8mzG
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4112:b0:4b9:b9a4:848b with SMTP id
 8926c6da1cb9f-4bbb7042b77mr656074173.3.1719913921615; Tue, 02 Jul 2024
 02:52:01 -0700 (PDT)
Date: Tue, 02 Jul 2024 02:52:01 -0700
In-Reply-To: <0000000000008405e0061bb6d4d5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057abc4061c40aa8b@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
From: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
To: davem@davemloft.net, eadavis@qq.com, edumazet@google.com, hdanton@sina.com, 
	jchapman@katalix.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, samuel.thibault@ens-lyon.org, 
	syzkaller-bugs@googlegroups.com, tparkin@katalix.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d18d3f0a24fc4a3513495892ab1a3753628b341b
Author: James Chapman <jchapman@katalix.com>
Date:   Thu Jun 20 11:22:44 2024 +0000

    l2tp: replace hlist with simple list for per-tunnel session list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f2a512980000
start commit:   185d72112b95 net: xilinx: axienet: Enable multicast by def..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17f2a512980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f2a512980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=c041b4ce3a6dfd1e63e2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12521b9c980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1062bd46980000

Reported-by: syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com
Fixes: d18d3f0a24fc ("l2tp: replace hlist with simple list for per-tunnel session list")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

