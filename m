Return-Path: <netdev+bounces-139388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB969B1D8E
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 13:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E73B20D44
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 12:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B16145A0B;
	Sun, 27 Oct 2024 12:00:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51277152E1C
	for <netdev@vger.kernel.org>; Sun, 27 Oct 2024 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730030406; cv=none; b=YEzWIN0KmVnC34+NvRR5g0LVH5BpHi+kiRLAU3lUyQzZ40OHk87LKSECjq9FcBDEOOIAXt/IGu6S3pLgBG1e/n7IHMlHWiVe848LUgQiGHnfx0xCl3hVWinpYL60Ts1YHjpL6I/F39r7PmIDFBg2ZjlmQ8g0D0+bnocvyRhuVfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730030406; c=relaxed/simple;
	bh=XO1lGRkxLeB+9+Bplf2WMXDq+XPLUt8XczjTuzuUnQ8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CMbR8xHeAOyRHKJK4kTMx4VJ1z/8SRK4zZ6R0JNoYe3fHBIdKyNAlimdp49wIO3vSuUBcrcm2mltSPfQoCtlzilrQgFct8lQgZnsweKkr1k6t6qecXh6TzAR8U4HLD+9TPPRS0UlLc2/XWuwcOibrkQzxUp2cjmFxc761QlQL30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c90919a2so33746355ab.0
        for <netdev@vger.kernel.org>; Sun, 27 Oct 2024 05:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730030403; x=1730635203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=no1ZFOGLUySkY+ghDrsyWwT3pLKnG1CnPDNFguvuHe0=;
        b=IWxE33uXYql82iao3q+xYFN4oNUIhgHNxpUeB+Jl3/nty2fWkeHxcrgDwByV+8AGZ7
         zx60PFLszibQfAhIC8fqganA5aqiDUc7rGu3mj77n1vaokJH7H8LQK0iImMiVHWyjPwx
         BSueE77+QJcD5pd7fQ+J3mhKYOAJVMRDVeX2bLdyn9osSZ3xAqaQpPDWqeDRY/is42iY
         Zudj9Z5xQcR3LT9xKe0Nile2tKWuALUhCVcLDHPbYEr/XwCq8rKIF5KeVlsYPbX4GjeS
         yNSIq/t96fGScE+4UQ9i9ByO5FlQIr4TZb3LOTGCtCzQvoeDW6sWyGzj19iIY6sD2CYG
         jziw==
X-Forwarded-Encrypted: i=1; AJvYcCV0y7J1Spnvx1SZhMXudO7T/0hZlqMQ5ixlHhzuu7Iikloj3mL78Ik96KocP/ukSKfU1kbzRO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBzmiSTvT4mjODQeQWkOVjqVi3MbayqevnejAmEgnhv/M+iz7Q
	Sk8MfnR6zyV/7x4HQZxshhhjEa3qjBPL2rAJR5FbYklmA5kuhgHsP69rgDfgFEfjcsisZ5cGZT1
	Co4Oyc8yDjXWo6N81Ak5LYYI50ZYrOIRiOSzqf04hMsezHr+saYiYCG4=
X-Google-Smtp-Source: AGHT+IHN18d5nvGLfk1zOtpizfizKtdkWBBv3m/+dQNMHigd0YvrEMcYJQnZmE4RBIDiNkwypEIJqmOf467eaXwhojoR4OTkPxAl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca08:0:b0:3a0:4e2b:9ab9 with SMTP id
 e9e14a558f8ab-3a4ed26642amr35233065ab.5.1730030403309; Sun, 27 Oct 2024
 05:00:03 -0700 (PDT)
Date: Sun, 27 Oct 2024 05:00:03 -0700
In-Reply-To: <66fdd08c.050a0220.40bef.0026.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671e2b43.050a0220.2b8c0f.01d5.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in genl_rcv_msg (4)
From: syzbot <syzbot+85d0bec020d805014a3a@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, davem@davemloft.net, edumazet@google.com, 
	kerneljasonxing@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d15121be7485655129101f3960ae6add40204463
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon May 8 06:17:44 2023 +0000

    Revert "softirq: Let ksoftirqd do its job"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1492cca7980000
start commit:   c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1292cca7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fd919c0fc1af4272
dashboard link: https://syzkaller.appspot.com/bug?extid=85d0bec020d805014a3a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d40230580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d40230580000

Reported-by: syzbot+85d0bec020d805014a3a@syzkaller.appspotmail.com
Fixes: d15121be7485 ("Revert "softirq: Let ksoftirqd do its job"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

