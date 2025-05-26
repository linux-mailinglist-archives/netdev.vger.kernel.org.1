Return-Path: <netdev+bounces-193496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2F4AC43DF
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 20:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FF13A3759
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 18:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D3A212B2B;
	Mon, 26 May 2025 18:41:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BC819D087
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748284864; cv=none; b=ne5w6nDL4r6BtiZKhU2TTvGcDh3jjfPpsO3CTW3jJeL+TpGHlDhcnSrOMQKyogsuE/H+t0U2+FmgG5QkA1y3H6TF5kHE242BJGwl+GDmzPNIJc4V1e8IgBD4xJzwLKgiotJ9yAapvnhn0Qf92ICs/Ds0ML9N1KSDYrdtkaP8WVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748284864; c=relaxed/simple;
	bh=4MBI4QO0e293H7noLQoz6P5dBJwn2LMrwVmWKAE5s04=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oxpI0BSJYWYpQheYAUPGJVAXPV7A5a0rSGMrU7y8SZuK7WwOZ+wkm1y0KFYYnsB7Smz0QCYMZqvu9znOBifTl5XdT3rU1oQYzM4/mNtkfRTt+9yc7OtVSUGXL6ii3JGwX5VuCiu3kXP4tKgo/lXLfVwZTl3eZmUJKEJmA6VeN3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85b3b781313so497578139f.1
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 11:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748284862; x=1748889662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sANgMpkFwYeHTrhiuhnnFxkTIiQM3rzX2qKXmUr0/18=;
        b=VXZ5rpKkB6XFkpdbk2tFWTkBIg61fsfCfp2e8lhHh3+oQn/mjOilr79Dr06NZewcYp
         mMcmyxJlSGotKtmKHLj1rm9GaDfnfDEQjfS8ey/iO8dZeCjxduS4EQGr2U5Afg3mjS9A
         cEtRimD4So+7+FZCeuENP1fmkc2U+yxYDnVofCnEU4kVCnrvyembM8p8OwYq31fOFFaK
         pCnrOK3qL9ZkokG6v8AQp3eSJRBxjWgf8NMOFvSNikHeWlKmqQzUAAdiFPYVdPlduNkB
         6bA0xXfeckYsnPAZ6ZjwkZ9db6Q/cvJsushCzNmVz4toSJMVwu02m/4Lq4NjMNBeyFnI
         5YoA==
X-Forwarded-Encrypted: i=1; AJvYcCXwa4KAmHZZ9w/p1V8b/iO2sO4OFilK+hkK8VR/cjD7u2Z98Hp611L2Pz/gkXRi3gbFAMaO4tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU00h4ai0yDdvsthUY3LaZrkd2Ya+kKmUzz0wdprwWtz3fXJhD
	OpvNnQX7Fuph0ZCZvW8WHmZQszzPV1pcEeq/4pNaIkPfC/jdheue74LCqgc002eRIbHdByzNWTN
	RaiLmxlH9dcHQPNpSf18CJZr1k9S4ubYBUkvY1nY83x16K6PH7FOmh2u0ASs=
X-Google-Smtp-Source: AGHT+IHRJsvNtQ+zTrI31so/FnEBD39zhnMae+3fgekqUVucYEztyvYDcfcX84YX5ySL0/x+WxuW+mPR+3BhY8lNxlIYPI9F5gTg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:389a:b0:85d:b7a3:b84d with SMTP id
 ca18e2360f4ac-86cbb8bee3emr795868839f.13.1748284862621; Mon, 26 May 2025
 11:41:02 -0700 (PDT)
Date: Mon, 26 May 2025 11:41:02 -0700
In-Reply-To: <87msazftff.fsf@posteo.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6834b5be.a70a0220.253bc2.009a.GAE@google.com>
Subject: Re: [syzbot] [tipc?] WARNING: refcount bug in tipc_crypto_xmit
From: syzbot <syzbot+f0c4a4aba757549ae26c@syzkaller.appspotmail.com>
To: charmitro@posteo.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jmaloy@redhat.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net, 
	wangliang74@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f0c4a4aba757549ae26c@syzkaller.appspotmail.com
Tested-by: syzbot+f0c4a4aba757549ae26c@syzkaller.appspotmail.com

Tested on:

commit:         d72ee421 net: tipc: fix refcount warning in tipc_aead_..
git tree:       https://github.com/charmitro/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10369df4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9fd1c9848687d742
dashboard link: https://syzkaller.appspot.com/bug?extid=f0c4a4aba757549ae26c
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

