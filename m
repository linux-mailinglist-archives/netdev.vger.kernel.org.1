Return-Path: <netdev+bounces-107424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F167D91AF18
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44291F23F07
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61075198E66;
	Thu, 27 Jun 2024 18:31:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF0D2139AC
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513074; cv=none; b=lS7ZbKBIcqTOokKgb17xNjm8KW9UKx5PWmpi1Jrlb5TSSuN0un1Ef0FYbz4edbiJuiQrOoXbbrFFZcaxlhEQP5z64J6vtULe0aIwfLOtjeuIPNt/0vX8grZpFS1Z3yjBNXYptacOlWdxzUg3+ybKskLO3CeQ1aVyzHgbmtROI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513074; c=relaxed/simple;
	bh=x3Uplq3g9tRJ63VMtyTiFluF2YqaQGF7G74yVJkKC50=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qz1EnNDuPCZ2lEzxHwKhReDTIkn/Zj8xwakO2pod3ovmGQwOEiR6D9qgSJjfcKB9xufp8tuagWjz2GXzdwai0lX8/PoOGcvqB/u+SWbTz3IqW0c3SO6SaL5ChBK9esAiitosjbC2HfSWiHrzF2echOdvKkgqbydnKEBZbuJJliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3762171acdfso127332825ab.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 11:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719513072; x=1720117872;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3Uplq3g9tRJ63VMtyTiFluF2YqaQGF7G74yVJkKC50=;
        b=WfnScKIChVvK1iydxMDzmUNRn+ESVlkmGTfOJYhEd1jLeWMCy1iAftuh1lEICQupO1
         p0zG6ckkP/b20Fds8GbcxPKUdWbilXEKlrbC/nsXr7fIJ/Db/SWgTAywvNS5iUFLjcuQ
         mO3vMMqr8XFKqRjrQfxfRSjJT/qyO7gPqyPZETL/LW6BmN9gxGNOvIAhwetQEH65GkZM
         Ha3YrtZY/Ub3JGS4ts+15zt6B1ubzkAqirdnpR/lYg+ouklTywnSfqCOGSsX63LpXNNd
         yJiFVNNG35+H74vukuQHkVj7lN2siw7YSXHw1iay9V6d/L1aRZd390x9shHfjYpHdpF/
         x5bw==
X-Forwarded-Encrypted: i=1; AJvYcCVGNuZqmqbU0QT2bUXXgTkYmlWwsJC5OfVb/XxLJyfOmyR9IsciTYoxiF38C7EhGlklAZGMGyI8VsrNEO7+xxGcVuKTaQQc
X-Gm-Message-State: AOJu0YwUijx/I73DLdUoju0SpzKnFr4XrHuY3Lb3cJPLrH/IkVRjEnGM
	8ozOpyI0ZywqrfUL54llmPJH3/UUbYrn4V4cwlVC2kQF+XI0ckDQ8uNiwJ+CZn57ogtLwzwDxWF
	5kvCDOyqKO3mrZxrIBtJXPLabNfkETEy/FJtuKONi9nS0/0qLDe5wh4U=
X-Google-Smtp-Source: AGHT+IEmL3EWSm7FPi3bJ0odruTABPFh182qXmdZ2N3NVt8iFWWeNmtnQdIJa4o1xQD7bQTLp3sr9oIxHtM5Nu8MHcWL20arp/LE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1528:b0:376:42a0:b2e5 with SMTP id
 e9e14a558f8ab-37642a0b561mr13669535ab.6.1719513072079; Thu, 27 Jun 2024
 11:31:12 -0700 (PDT)
Date: Thu, 27 Jun 2024 11:31:12 -0700
In-Reply-To: <000000000000a62351060e363bdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d926ef061be35566@google.com>
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

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos

