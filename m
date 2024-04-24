Return-Path: <netdev+bounces-90740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4817E8AFE1A
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 04:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2AFF1F23A82
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 02:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F7CD29E;
	Wed, 24 Apr 2024 02:01:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7526BE6C
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 02:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713924065; cv=none; b=DsCt0ExQ8uSZzuW8dWqQ9q/gInVaPQEU9eAH3uUWQrQSsReeXg9DNVSaqaq+3ZHNWFHI6ra5uJeuTZCFAUL9+qUw3z0upFN0m76uPvtcRuGw3wHBSfXSx41QEQH42Vj+AXlGf1Eof+A2feeE056LigbvEIjYItv0VLB+1yQmNgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713924065; c=relaxed/simple;
	bh=TUP9FkX2lJl7zbsImkQch4ciYMMyBDiJtF6VqMtpXM0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e31HwqgaVb6UhZATRDFBERXZMEOJjgMJs3KUerAQGcnS+VLzJZ6T+yoUynSewkKiu4JdyU2/+ESYV0/qyBPiaQyGu75JkXyGd+LVvmDRy3RCbhj/D3PQXag+LRR7wyRhoVMlDaqxxCl/2wG/PzlPD6OdSI1z16pwsdbDSv4lbYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d5f08fdba8so33990039f.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 19:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713924063; x=1714528863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ifim8rK+5Cn5AylRfbIwtbU4eq2GAjVjQaY82cuTstU=;
        b=UpuCdnBeD099i95/tT2uSONGTYse+IYbEaSwMpaJAXX2gbuI6FediMD0nyrmmKzVy4
         j5HFwagDXFT7hWoxZqfGKvq0wWnCT10tRzncUABWF6z6Zlvi21HlT3swHxbVu4S6dhlA
         RJAvHm37uCCedfWKnlVNtq99Yl8Yjsvh25dBHGwh6RMkQooAZ30Xsw9oewUGOfpoV+tL
         yyAAa6MHq/MrP//TQlP1g8lz1goWMKVrGTrE1TP4nAICeK3MbJUlGCsqd43awbEX/8mh
         KeSQWkiPYhDrkNmVmdA8nLDuvkH6piN35a9vou/xsyAvqGA9HyjICwL4q/Lwd7JI4AHZ
         JwFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgZDvAVbIFdH7Vs+QbLKwFdBXsZ3klqmlqz2cKkFSyKqGUEoIm44tVnMKHtdbUwo1k0mMwLwcB5qjI9Rr3r7vn7cc2pEPd
X-Gm-Message-State: AOJu0Yw33njt8iHah9YTaAaFnxFGbWfH75ea943ZN//YKTYJjBoXPJWu
	/SOiblqO5SUVjU75L7pPqS7mzsn3bD0iBatv20yGRAeK5xMo2D5g3jS85ypJdv41Is/hr8zZUbf
	VDuQg89dugM7XX83od8XiUjgfSL55G1l/n/76VM9Z8EeV1y8wkZ3dTbQ=
X-Google-Smtp-Source: AGHT+IFb2GitKyqtyomAW5D/rDPBgckqBsgxNNOhYgMZPpoxfwrLMRBdrlj7GvDWAclxs7KfwPhmIkStqRgo4TlEKYioi51ypkQv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cac:b0:36b:1b8b:75f4 with SMTP id
 x12-20020a056e021cac00b0036b1b8b75f4mr165809ill.2.1713924063116; Tue, 23 Apr
 2024 19:01:03 -0700 (PDT)
Date: Tue, 23 Apr 2024 19:01:03 -0700
In-Reply-To: <000000000000f1761a0616c5c629@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f450900616ce0aa5@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in __unix_gc
From: syzbot <syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com>
To: axboe@kernel.dk, davem@davemloft.net, edumazet@google.com, 
	hdanton@sina.com, horms@kernel.org, kuba@kernel.org, kuni1840@gmail.com, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, mhal@rbox.co, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 47d8ac011fe1c9251070e1bd64cb10b48193ec51
Author: Michal Luczaj <mhal@rbox.co>
Date:   Tue Apr 9 20:09:39 2024 +0000

    af_unix: Fix garbage collector racing against connect()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f440d3180000
start commit:   4d2008430ce8 Merge tag 'docs-6.9-fixes2' of git://git.lwn...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=100c40d3180000
console output: https://syzkaller.appspot.com/x/log.txt?x=17f440d3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=fa379358c28cc87cc307
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a8fb4f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ceeb73180000

Reported-by: syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com
Fixes: 47d8ac011fe1 ("af_unix: Fix garbage collector racing against connect()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

