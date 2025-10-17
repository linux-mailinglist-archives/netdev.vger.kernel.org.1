Return-Path: <netdev+bounces-230351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D07BE6EAA
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3751501FBB
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 07:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E00A30F94B;
	Fri, 17 Oct 2025 07:22:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC53D2D9ED8
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760685728; cv=none; b=nYziIqup4gldO0z1widCiZDiLvIEeK3MzHhbYKfRCg3AEZdx7U7Ud7/+Z0iYUlypC5fh9KwWMhwoWxAHGc2AP2ku5JCKZwmo7pxBcCaJ/DUcjZoItjk+pzQEzSuONu5POKLkLqiWzBXfYGSMG2HLFteMRA1imJnmP7nl0EUI9uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760685728; c=relaxed/simple;
	bh=q8lETvLaobuL3XgXbBKnxQsn+bRCtfzBwaEJQjNgDqU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uIXsWoRRCX87W7USLLetg8zRakA4+dPhmaZdC3CJWtYCsZKeWrI2w1Y09/DlqxP0qwYWSs851xNJ1oUkSKPyV7fylAjfPhbQnChJPXMFW/r+g/43/M1vQa4Fh9cU9q2HohsAXCvFgNB4uJiw4asIye5xg2a0DIm6CPJeOysjtQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430b6a78ee9so53056905ab.3
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 00:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760685724; x=1761290524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdCmJA8jhBXmo4IBQnz6DZIBUwH7MMuVcTakMsfhXEo=;
        b=XSfX+ODcZJtaobYMiL47c64S1vQbGbijIHObjziwfhGNEG4/mpeMf7fY0QF6jKaWxU
         AR37WgQ8aAFSOyMo2R2TaOswnqrm8sV7dlPFF2AfY9KNfhW71QEKkw+bgpBeRalUeM4i
         qoYuqiHPjCIgWEq+LlNVwFzcfII864yqI0L2XAoxSLBBAo+dyRw5lN01p9QQCT7X7XAH
         SNIG51wHHKaqdo62s6VgRPHygyQ/rLfdkvy18XGPhePoQQvMAAxzRLXZCAGxexgGzWxS
         Zwu1Z1tkL+yVGPwkh8o9iM7tFS8EjYdiodKFMkYsLDkrpuGXSw2myiZmVXAH4G5Pnszn
         fYaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYSZfjze3EoFbBm41rXYD5ResXfGI+56063Qs5cYcohNqWx8bpUhM5tqoGbhqzmlt8bhxL9JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5YnbeQ/seX2ktC5ZHFRJlsaqsLb+giSZ2wZ02LVi7HbzGhcBv
	VAjQFn5Gm6QUI9U5y9y83dcLoVTwZ/1oQcEmWr1gcuCXV2ikd1/gezj+/UveywJCAts9VKRB/jf
	0xGNijIJkGfDOfV3dI2Uy6feQ/YXAHxu20JwTeqT6mPOT94YogTMmelv/3Z0=
X-Google-Smtp-Source: AGHT+IFgiMVnSrEVd2xDfgd8O4XbUaNXWA/Td+9ca2dZKYpiwJtifThtzyAm7PJLavQJCLBlKSR8+m0MYwlDaOv1TnpxDV8mLMiZ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4506:20b0:430:c8ad:81d3 with SMTP id
 e9e14a558f8ab-430c8ad8410mr14490805ab.30.1760685724070; Fri, 17 Oct 2025
 00:22:04 -0700 (PDT)
Date: Fri, 17 Oct 2025 00:22:04 -0700
In-Reply-To: <20251017065045.1706877-1-wangliang74@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f1ee9c.050a0220.91a22.041a.GAE@google.com>
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

commit:         98ac9cc4 Merge tag 'f2fs-fix-6.18-rc2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10084de2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f81efe6184ed80d7
dashboard link: https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=115ba734580000

Note: testing is done by a robot and is best-effort only.

