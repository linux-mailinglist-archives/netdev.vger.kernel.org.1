Return-Path: <netdev+bounces-113058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41BA93C861
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 20:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017DE1C2104A
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 18:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E603BB32;
	Thu, 25 Jul 2024 18:33:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6244639AD5
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721932398; cv=none; b=LmwPfqMq9/6Yo3hdR/2eO+ADeYB4ChR9/SBEVzMTWZBi92y1Uo7JrD8us28Va2X0mp9S0UUBOfk9+te0CDhmpB4wh0C1RpfqD6YVDNpHjId9fHrQuZuHBmlxCbzZ6OIrOhW+p9jVvD1l2t6yvjUcZL59iqTJEE79+EkA3cckA3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721932398; c=relaxed/simple;
	bh=x3Uplq3g9tRJ63VMtyTiFluF2YqaQGF7G74yVJkKC50=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aYhTMHrT+tkMqcwcDm+dR5uGiq5DsDbFIuBvmetbtZEQzCMtVkGMk9KccC1ruvhxv1XPgrPcPlA+B6KldNLDKhBgaUruGHUNkPA9nEygvfth+ke9FBo3ze/jvvUWl9ZKLG3VEhWH+U/Hbq0Bq6kHFztzoaMbvsv115EOFmKxpMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-397052a7bcbso11265195ab.2
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 11:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721932396; x=1722537196;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3Uplq3g9tRJ63VMtyTiFluF2YqaQGF7G74yVJkKC50=;
        b=Yrbrm8hEzdSmMNHiQDh/iVZ8brxQJe30JWk+h1Bbc709Apy2NR0xR1k0JaKy5vBpl+
         jz9lQz9gacPJNbA0IbCi4G2+vQ3KU7PdlkvwKGgsKCCsOgvXJSkRTmgG2nqZWS8P2Gxa
         AyRF3SOGVV7FslDWMxzqPaEI+Hg57MsUvDYQA0gY8lpsknXPripDMWzAJd/EZbV8kXx7
         mxsi28ZL6QvRG6FWrly8SUEXE4ak2qtYJTpMlK/6jAhkNUfhHkpeG9LUI1+t53fbjOBl
         gi6w+eB+sETOc8a3Pb0kkszVOZ5py6esZIcYWRgyJZ6iFi1vHG5XOK04bRY1CfcBdUMZ
         TBog==
X-Forwarded-Encrypted: i=1; AJvYcCVtFlr/G2P2INfsDXvUSjkQFOgenj2+8Y57b4gHQ/gu+LehNyFNPUkljc4ZBnsornPVLwM8PlC0LQk6s6mr+Oz0bNt26aZQ
X-Gm-Message-State: AOJu0YyGhrz+yTWuxAjWd9rUf+5h01xMuhLa3LOxDKk5Pj7bEJJsM7oO
	e7evtsUgM8TMhdwZoBdt5cyaQTrDUuaVDqjyTKxTCIMjgr5qhjj8V7lGoxOxOK6P3Nb4K7duU0Y
	sWPxx0bGkTg+ftc/gERQDlvw/BvUT4wgWysj9Vn+E3O/bapDze0c/h6w=
X-Google-Smtp-Source: AGHT+IH2jrqSfCw2gZLBit8Qdra7oizjuhXH36fBGkIDykjebFbU4C6K+slm8yVokO3OVjbqARCt15UY+rRic7ZwAjmAWSVEBrNa
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168f:b0:374:9a34:a0a with SMTP id
 e9e14a558f8ab-39a2187f30dmr2884075ab.6.1721932396538; Thu, 25 Jul 2024
 11:33:16 -0700 (PDT)
Date: Thu, 25 Jul 2024 11:33:16 -0700
In-Reply-To: <000000000000a62351060e363bdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2bf2d061e16a028@google.com>
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

