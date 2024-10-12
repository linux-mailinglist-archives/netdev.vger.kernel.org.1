Return-Path: <netdev+bounces-134865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BC299B685
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 20:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10C25B21660
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 18:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB8B136330;
	Sat, 12 Oct 2024 18:00:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A93813B2A2
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728756005; cv=none; b=YxpLb4ZHBdaUvGw0NCeSw2IpPJHuihzemQ0A8z0f6tCWvlxWTM9Sa1MsgAWB7bh6S2AgvbA9QN0+n6tyA97VzF10Eupj9ACRSieJS5WpwYCuIRfarEh7mRAtoFpONTdwRZEVZ6TbSAVdI2hHfXmRP2WvK6r93jpoVfY1rswyJ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728756005; c=relaxed/simple;
	bh=8hHt5+iGh39sjPHzAaTebYzs9NAavjCpggn19QT5Ygg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UHx/JYLek6zQieR2pPytd0v95CO+Z+EF8v6wLj3OGr9RzWrKDQoQ6m72gzVfpgwa27GrB6a+GbS52RCP0uUHvZMbcmiPPfb+jRMBtSFaFBG4neLM5Ed3efLSt8q4eAhnOgd8TeWEs0u3VFk027hnyfDmK/LbrtMYUgSp6yVYzOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a34988d6b4so48077915ab.2
        for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 11:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728756003; x=1729360803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L47wACq13635XdZjofeiVNe4JkOgqBJXEN4PIFmbHa4=;
        b=ddUoDSCgBGbVaG3489zx0r07uKgOX9nw1p1cApWw9vG5CPrAHcjn6I3OjpmorFdGbb
         E8DElzrzjIa9XFho8hHg2YNf32M9MIglYSCyodwPyX50U/VqyNPny6jKcXHpRk5nYVEw
         FEAx+cwYUcUMyydNVIeoXzbJmBPBGz2Fgernr2TdhGfAU+oPACSHO+TH94g9Yp6GXpbn
         EZUMxu9cvxQ40R0EV0Ji3BHRnii13JiLsTp8nuIWdOMi/G1TJHwZAFLfwH9tm7ygzb5L
         Ti1+MzghyrYSNqsfe54+CQEBxbnUfcemWS4rKJ02pBIrJ4zgsY4URy5OIsLhoFVSbChx
         fMhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtgi5bUREuZK8DX+ucOt6wi+vRYPYsTf5/T+LzALbuwfflnOmrSP/IyKZG8oOGErt1zYiCZd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWzz/Kz7jHr7VY+WDiTb/4siGqkkl7RzUqv1UW/u9Y7VrCxN0j
	jtf46uVQk34ufsAA7S+yLXPTirfndoKuCBNjDsqT9q1a8Q58Grppv9MrPVaOI2FLD1qdG96N/ql
	5P9nO6am3La+GINPsS6scU+975hpYwoyyCcHVJI0UrrYjTrGeopzblos=
X-Google-Smtp-Source: AGHT+IG6LjZwaZf0PkapF36b7e6PJiIgY1UV/fM3a8Ux0q94gT0tk4EZeblrJM6H9JkIA5LDTwp2w+HCtPmT7M+vjB39+784nixA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdad:0:b0:3a1:a20f:c09c with SMTP id
 e9e14a558f8ab-3a3bce0b1e1mr28399625ab.22.1728756003623; Sat, 12 Oct 2024
 11:00:03 -0700 (PDT)
Date: Sat, 12 Oct 2024 11:00:03 -0700
In-Reply-To: <ZwqEijEvP7tGGZtW@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670ab923.050a0220.3e960.0029.GAE@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_ntf_packet (3)
From: syzbot <syzbot+3f8fa0edaa75710cd66e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, krzk@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	qianqiang.liu@163.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3f8fa0edaa75710cd66e@syzkaller.appspotmail.com
Tested-by: syzbot+3f8fa0edaa75710cd66e@syzkaller.appspotmail.com

Tested on:

commit:         7234e2ea Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b63fd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=981fe2ff8a1e457a
dashboard link: https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f87b27980000

Note: testing is done by a robot and is best-effort only.

