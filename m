Return-Path: <netdev+bounces-250717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B962D38FEB
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 18:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A07AA300F9D9
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 17:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245382571A5;
	Sat, 17 Jan 2026 17:00:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B162C240611
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768669204; cv=none; b=AWp+NZkfEanjn7KKBPMau8T4Ohvmq5TOqHSc1UxDAeTBUcgv7XwoDrupjQpnD5p11KgQ9TAhcjF2yTWLecx6d8E6uGfzwMU5ev5IR+R3BvqtwCshfk/FAJYemfTDDCjsV3RF6nnjtowbt0NiKekvu8fzF8QQQr60+ZQzSmFwMpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768669204; c=relaxed/simple;
	bh=6F9+pDuLvb8wMjYIzRip030sEnSaVkH0nbJZR7jKfiM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K72F9MjljVFQ1tB+a4xoAHofx+QHQBfcZWtHOGcxYoxEiFy8oO2cXKG+DF6V9s/vbJnCpUc2yc3l/qgkUXG74ZvjwK0AsFToSUDmQCEZoNI8w1p4kTPr9NcyXsjgOLUavh31+n/nE+FSLsCZiopq0wJE7hIlxi0afTUIaTuiiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-65f6d0bd852so8182845eaf.3
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 09:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768669201; x=1769274001;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKusMdsZlLCB78xo6BzsMeO+3r4MZV4WdR4/o1abZH0=;
        b=jJIrb2c1bTvYA126Q8/TSH5YGuDWV7Cn8PZTn7AD4FkDViB2XLfUMurR54GO/816Je
         YXj1SPNqKTfBhCP5EsyUlqoWrR4IdX/jpJ/RIKLQyRb/J7ZlJ7PX3c1l3dvw3sHoI2Kt
         B1u0lGPhzDN/rJZSxQcxZpWZb+q1tC9+r7/lTkuhS5drclbHS79/repcqSwOBSUidm2i
         gP1mXFqpJBtB79hr2YZyHmQ/DaLCM7WwMtNbUAUETfVX3Yx3r3+Rx3Y0Au6z1RF0/qFF
         oSmbYVz6iQcOeA34yY7GsZx6BjwdFwrNLga4ouVsyLSJAn8d72xl2zLOiTqJgKyMZdzE
         fTnw==
X-Forwarded-Encrypted: i=1; AJvYcCVBWm4MSncIU12a0LF9cAvW+8fM3eUqe/WZQH6N+CyK0oVh3HPHOxOtZLy3YNTOPjVkRgd/k/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUqj5IyAYcHGrUlpTQrXiCCRHnSmRZIkE0z/hEiHpVXCKUNNpH
	+vs3HTZLXnoTEO7vVIIz9vigspGolcsgYlPRiyHjV79omlv6eoZTWY4Qt3Ys9pnjZ821bbgufXD
	IGWb/pRu7+rhHTPjkNttfRKwU1dpB20mPXjYiLrjxvY5LLpgscDWqTBPSsDs=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:216:b0:659:9a49:8eca with SMTP id
 006d021491bc7-66117a44ffbmr2699698eaf.78.1768669201514; Sat, 17 Jan 2026
 09:00:01 -0800 (PST)
Date: Sat, 17 Jan 2026 09:00:01 -0800
In-Reply-To: <20260117142632.180941-1-activprithvi@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696bc011.050a0220.3390f1.000e.GAE@google.com>
Subject: Re: [syzbot] [hams?] memory leak in nr_add_node
From: syzbot <syzbot+3f2d46b6e62b8dd546d3@syzkaller.appspotmail.com>
To: activprithvi@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-hams@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3f2d46b6e62b8dd546d3@syzkaller.appspotmail.com
Tested-by: syzbot+3f2d46b6e62b8dd546d3@syzkaller.appspotmail.com

Tested on:

commit:         ea1013c1 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1740b522580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d60836e327fd6756
dashboard link: https://syzkaller.appspot.com/bug?extid=3f2d46b6e62b8dd546d3
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15da13fc580000

Note: testing is done by a robot and is best-effort only.

