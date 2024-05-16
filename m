Return-Path: <netdev+bounces-96786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8C88C7C87
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 20:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D59E6B238BC
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 18:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3A0158214;
	Thu, 16 May 2024 18:28:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D2B15821E
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715884105; cv=none; b=fDICFIytKb0cmA4IRbtkH5OSpreNK/ZImFxwhP6ivrzYSo8/Ak0vnk/N0rGiwSaAEzMxAOHOZ4Kuiz7OLoeLtNs0rukTUCOWlNdu9hmn37q8ZXmC1h085Mcl/HLSL8oBKiAmk3GiAYQ1pROa7B+XTBRRYgBtFmsfgBQRAjfGkas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715884105; c=relaxed/simple;
	bh=UzKx2uEzqgslDAiwUDJyVu5c/uy6CYD26vc1Ic3/26A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aIjpvi9zUJ90o5UNqV3eQ7OkHHhcUV6mFsmVP3ZIhr66ckrBvplzmqBwgczc1rg2JpmdBV3RAfFS7WBfFqaDG2fivouwvHFIKVbZVIogc9AGrOhwu6XuUXYP5YE5DxTj1xuqy7VY9+rLYB8zx5n+CSR3RX9vFjqBlq8Kem5bX78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ddf0219685so1011926939f.3
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 11:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715884103; x=1716488903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzKx2uEzqgslDAiwUDJyVu5c/uy6CYD26vc1Ic3/26A=;
        b=XUjrQZFwd0b+rnzmfszKY+EEVK0CZlFMMjlCtNl8PLQ+rHLilSqTFu/ItTpHma7cJD
         KCNpTKUBGgRnF8yYdG0Zw+CspVo6WhI+BkPWEsP0QRPidz1x6S10ugtqNdFW9xiceHxK
         GJhpM1X4RzNG3Ce+RrzVoqK7B1M1Cv6eg2aS04XPt7+sxOh7z3IUF6eL1WogWMaGaqzy
         mu5ILFzWhGqBmtCLFydDrcg/0ThZSK8SzR5FIaur2SnyvZBLkKaaNUiKijnBiDeEzhSQ
         wWaHhcqDHegi/yMQoIIGutNCar2gc1H5NZBJc+zP/cif1Ndkmc8As4996gwcriIoNsYK
         dtuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7VmmpmVlv0A6hX6n3Ku/Fdi8kuVhvch3tBZ/NlzrdWyItwL6bWJrUGP7pY5UUiaadjmWzfKi48VoDA+xACrmerclojzQj
X-Gm-Message-State: AOJu0YwubV5erNI9UI043UPcrwMrT2W2Fq1DzdpOzNXnOXeuQuLwZ3ci
	W9uID141L+8WLyWX5LE8CzH9IyIiPf9rjaxcOEdQbf1J3MJ8utM75poaxeMOTbVBsShigdjapgm
	SLNfm2kXOq8Cb+8cAbWB2yvCdH5muH5kPXwTqGwIj3/i8PjpJ+mxcRl8=
X-Google-Smtp-Source: AGHT+IGKKYnqdAHzrld9TebqrsNNwKIo/KHdQn6r+DkVA7nvsLxlcQmJjp/lh+6pTXx69W6Co6RzpGinzhw/WGufFYsVoBdG0blB
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8506:b0:488:f465:f4cd with SMTP id
 8926c6da1cb9f-4895856fa08mr1523351173.1.1715884101697; Thu, 16 May 2024
 11:28:21 -0700 (PDT)
Date: Thu, 16 May 2024 11:28:21 -0700
In-Reply-To: <000000000000a62351060e363bdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ba4340618966617@google.com>
Subject: Re: [syzbot] memory leak in ___neigh_create (2)
From: syzbot <syzbot+42cfec52b6508887bbe8@syzkaller.appspotmail.com>
To: alexander.mikhalitsyn@virtuozzo.com, davem@davemloft.net, den@openvz.org, 
	dsahern@kernel.org, edumazet@google.com, f.fainelli@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	nogikh@google.com, pabeni@redhat.com, razor@blackwall.org, 
	syzkaller-bugs@googlegroups.com, thomas.zeitlhofer+lkml@ze-it.at, 
	thomas.zeitlhofer@ze-it.at, wangyuweihx@gmail.com
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
net: stop syzbot

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=42cfec52b6508887bbe8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

