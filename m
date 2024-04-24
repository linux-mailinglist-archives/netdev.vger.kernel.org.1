Return-Path: <netdev+bounces-90729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D288D8AFD9A
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 03:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110511C22284
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 01:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320314C7C;
	Wed, 24 Apr 2024 01:11:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE5B23BE
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 01:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921065; cv=none; b=PbVF0bX/VNRs9gGBmTlAD9h71Auo3lQt99X5UT08STiQyeI4T+f3Vg6A1iCfE1uhjx6S6yPiXbDela12vFZj1IJEncufKma68+nv912EE7JNsfHqChtKJwJN0ym+8J4XR6mFYpteDAPiH6rt/EIvDEZLtfWJxctMMDSArxsyRYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921065; c=relaxed/simple;
	bh=p+apt1bR0v8EiC2bw0KoyvzEkgdsqCnHoH6rTibZ+PA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HiKVX3KO+gph4X9YjB+RAhpD/dtLgNCjH4PVIEXXt90u0Rj51msxuOKrmrVZpKKVEio1qlZlswyKaAQsG4HEnabQxuzu48feLCZmxZwHHcx7ahR6fr6579oMr8HzvDln2wuZCo9fR7LKfad1ZLqIv3nkX4Ex5ZdwtF4X/JRNuzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36b31fda393so75568425ab.1
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 18:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713921063; x=1714525863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiMDi9wPq/XQ1uLsGRZ2p1sizE8VAAKGMDKM1cC19j8=;
        b=sV7G9vfDo83RG4KkEc2jfvx2yLdoRaK5wrDwlhrJSbk7fC1HC5eHPyMdtAYFFR3VOj
         uU4vwyUrf1zzoG+09Z/YrDG2CRSHMdhgFuZ5OQraWYsd3Ij9yncgTo2bUVUxRl04MvHQ
         BkkzetUioSZ3P7kGND7FwKhXMY/JzNguWlG2q/rSbzFb/HuGYRS8KVzVTEocaYN0nSla
         sQ7Xx0QwPNpYAaw2Yy938mdhmpPzPo6ZaHuppt9Dt+15urk/xkg4j9E7cuy2+WSSgkMN
         rLmR3CUkd9jEoXuFUitD367P2eNQEEZdBG248rOx5TiOLzY6J6fVaVJ53kih8URp/hqi
         0qFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy0mgS/eYrWzxfsjYSyHd4AJUetHiDtuIUBtgX87blii0FpQO9/nY7V6TKLMFI3ioSAu3lPAIMAaSzzhpGZGguW/mZNxhU
X-Gm-Message-State: AOJu0YwsCxzRlvZQ96ds8ydRYnBMRJaaoXkOYhmjLBKHA4S5A0/bHdK7
	QVopDPfsIvnvI7BMv5DNQ7N82rcLZd3Es87h9rbdUugh69nFZFpkrocP9R7Tbdyuu/+fyLOrNlL
	OevhcZK9T3UQ5cA7pDAWY/nnAaLQWkyir0PeaQDc2xLPF/C6F1z9Rs5s=
X-Google-Smtp-Source: AGHT+IEaEsWAddfUwiEwqNU06n9hWA2ox6XhTGJYO3+GwwQ3U3ZRErvoKuSBGSJTDeY4iKqzWUYZ18RWmWYFJSILHV6NMMyCNO+p
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d99:b0:36a:1813:d85c with SMTP id
 h25-20020a056e021d9900b0036a1813d85cmr134603ila.4.1713921063075; Tue, 23 Apr
 2024 18:11:03 -0700 (PDT)
Date: Tue, 23 Apr 2024 18:11:03 -0700
In-Reply-To: <20240424004334.10593-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002355ef0616cd581c@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in __unix_gc
From: syzbot <syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com

Tested on:

commit:         4d200843 Merge tag 'docs-6.9-fixes2' of git://git.lwn...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1756ad73180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=fa379358c28cc87cc307
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11beab4f180000

Note: testing is done by a robot and is best-effort only.

