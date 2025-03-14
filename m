Return-Path: <netdev+bounces-174958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0905A619C4
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 19:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3139846253D
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 18:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F114204C29;
	Fri, 14 Mar 2025 18:47:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F23C204C1D
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741978027; cv=none; b=RAzUdWlEdeCZhOeXzFGZ2GmWUeDhyb/uoV0HmRv4XQwgcMaslH+Wc7+TeED1Jw10Kp4ABXrEL1G70A9QK9IiBMk0MoqC69L0iYsMB4bKeR8vQ/h1I2huRFwBuHP8wjEuyNFBFD49TI4fQdqE+B+2uUgzAV+VJCLY8BWJC1DuyQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741978027; c=relaxed/simple;
	bh=lP+WWwLeJcNl+xjynrFw4AUeIaxg2oLzPxAdObxBxnM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gGIjtaAGRV+Ai11jYTRISHcabLHrmGJG5USh5uIz5bq+plmcXLCWHr3mjIId6BhBrMgqJ6FJmph1BRlc9cftsE0Unw2UW1cljAmWNWXCwWbgR79EqbBAB2yFw8MJDXLUryPxwrDQcPDoqp+G10UFximw5rD22wijuHl/gx7sesE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so58316955ab.0
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 11:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741978024; x=1742582824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NxkXkYDWiW2oVyldkemU8ucECoqqgSoeCvPEsiTtUu0=;
        b=PBhwXxyrxLnAx9ku5HYKpr+N7LkX2CX1Yxzf1HtcHs62tILBUguDR1anKtDqllt6xK
         vsLi+2AHOZjsKL0DEf5I58eqfMy0QrDHu4bK1HWjQhngGDLFAEdFLl0JsVOBh6Xcpbxi
         g5OP+Iwq6I5XOsiMGMOA5gczcpwaPV+zHt/reDmODFVy9q2f63HX8kyI3gWK87nxBZSG
         sgHeJ0Lsw2yPJbvAjiVPEVMHJv/nECQ7fkwfv2Tt5ZDswe05v4xXq/9uEMH+fQ4bf0Ml
         XW1fC2mGtRjJrxOBtuL51Kp15pSzErg835YU53p0ILAEV7wd7Oe6zIzM16l0TMRRGAdU
         3E8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyWcbxEHgHHYp6emmE4cqzBbAWFM9xqRGM8bpee5uGVDJFUFHVGW9hhxG7OcbzWX7kx7iDqIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh6wiBXEBKi/QebMMwM0yA+YsW3coM/I2WuxKpzl7sW3551dnl
	F2msWpiWdXqAjT/ieaXefB/D3WHdDP0ayqZ85MDILVRZYYtzMzxv4i9vRHRYZ1B69Qh0B7eOFtE
	0UDFNUjhbPfOFWRzPMM27/fhUkINOrEBWOhr8JYdKtRCEcZZOFchizd0=
X-Google-Smtp-Source: AGHT+IF2NJDjExuIXbMXWH2xKdFFik4mQ2Cbteg2XeWs+t07tMq6LOwOI/VHD7UEdRzJmzYoxxADQlr9bGDqb7kO3gZfuHYRjCMG
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b88:b0:3d4:337f:121b with SMTP id
 e9e14a558f8ab-3d483a0afbbmr35023375ab.8.1741978024613; Fri, 14 Mar 2025
 11:47:04 -0700 (PDT)
Date: Fri, 14 Mar 2025 11:47:04 -0700
In-Reply-To: <20250314181925.69459-1-enjuk@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d479a8.050a0220.1939a6.004e.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Read in atomic_ptr_type_ok
From: syzbot <syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, enjuk@amazon.com, haoluo@google.com, 
	iii@linux.ibm.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yepeilin@google.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com
Tested-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com

Tested on:

commit:         2d7597d6 selftests/bpf: Fix sockopt selftest failure o..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=126c419b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=a5964227adc0f904549c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10ecb874580000

Note: testing is done by a robot and is best-effort only.

