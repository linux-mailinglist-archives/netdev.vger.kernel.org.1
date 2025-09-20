Return-Path: <netdev+bounces-224964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 353A9B8C133
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 08:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD3E1BC1E9A
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 06:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7012EAD05;
	Sat, 20 Sep 2025 06:52:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE03D1F09A5
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758351126; cv=none; b=cnx4HjcY19fih3hjbEsitqdAy7ITMn9BNPs1UunARb+Ks4DxaI2AbplilI1nH9E/JuHUzBRkh/OtyRQpNi1O+x5MtkYPgpecNKqOlkySRaPtN30HjtAoydNCUPs7upgdYwxkxLGi1psny6NOakaQmfvT5YB1cRnbph9ZZhb1yf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758351126; c=relaxed/simple;
	bh=0A3UN6LJOPp/OZfQ1gyQ88jOqiCAaywlt9ynTRCXTOQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mY7x00YybzKAIrT8K8e2A42MKcUMA0tEPE+gFeRqIAncznlc+X8/ILjLF+HF4N/9zc/wLTY5zBRGUw/0RSd1jE5KSqBvVRtFowiWTJyqovFU+5Ci8pghP60MuoUXB67X8szX/4bd4suPaG4ZTh5nsAsC/2NobqnBoyaa3gPawZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8a559429a55so549418739f.2
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 23:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758351124; x=1758955924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4LEO1FGizwQheZAp+/czE31tJW/ITYrqK47/XHpiws=;
        b=j+Df7v9bOT/GfdvJfwfqj2DF36v+Z5m5BlPR5QQPIqpime0Ifb2kvuFkhy0SKUxcH9
         8G1jmEnLZlFVxrOD8BY/csx5JzcMpmm/MBXhcYCNqdyooBqzOro9iy+FBJmnH377RO6Q
         KAd8MQ6lz1MEfV/U4aCF89TSxKB9JwjRxZ4bFMOi6RJckIHfsiXQWL5iZiKivWQJPKE5
         57+iionG160tXfIWA6WU9fy4Oi2Ebyd8G8H83PdbzAW40foRsGreAwXpNCzUfndo+FFp
         yiB918PFCetfb/b7Fc1sMgyRE5vjjW/nDCxHSWAk/B0OY2hl/kn0430hUEnEZjkcG6mK
         os2A==
X-Forwarded-Encrypted: i=1; AJvYcCX8Uizn8E2hGyJAxNwUHlz3sSQqf2s5kieUTN5pKzbth3IyiivxnQGaMdMHQMXQt+WYCiX4pMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAy+2ywFlKTl05izbfCrkN1UuGXM/WCx+Vh96cfDqtgtMY4aIa
	yWhwrwrOLpbbNqA/Ygpk+Vxtq2ohW0I+egKiwU4xUINP9NeRAOd8u2ZcD5tWtajOri+EPzU2UyR
	9guynSyjFet0nB4cdpQpe32rsGzaLEDO+IABvvtIxxKp0YmrKyIHGuyMXMKE=
X-Google-Smtp-Source: AGHT+IFk2ivyv/T41tozdkfanIx6JpttUK1xxhTgZqBmUoSeelYWRE0sOcYZnKVWJMBEFYXr1BsIXV7c521L4jjIKa98VP6cUTpU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b26:b0:424:30f:8e7f with SMTP id
 e9e14a558f8ab-4248199c513mr88966625ab.17.1758351124090; Fri, 19 Sep 2025
 23:52:04 -0700 (PDT)
Date: Fri, 19 Sep 2025 23:52:04 -0700
In-Reply-To: <20250920064813.386544-1-wangliang74@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ce4f14.a00a0220.37dadf.0026.GAE@google.com>
Subject: Re: [syzbot] [smc?] general protection fault in __smc_diag_dump (4)
From: syzbot <syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wangliang74@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
Tested-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com

Tested on:

commit:         cd89d487 Merge tag '6.17-rc6-smb3-client-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10864d04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=102f5c7c580000

Note: testing is done by a robot and is best-effort only.

