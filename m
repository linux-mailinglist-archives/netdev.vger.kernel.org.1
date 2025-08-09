Return-Path: <netdev+bounces-212325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BFAB1F451
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 13:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9BD18C2B8D
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 11:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A09B25228C;
	Sat,  9 Aug 2025 11:08:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D9923A997
	for <netdev@vger.kernel.org>; Sat,  9 Aug 2025 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754737686; cv=none; b=myHykZ4mFWB9UX+dAPUCLpSVBgtqahpI31GMuMWR/mC3SyKsuZ3iGQ1EUfeVMtCHf/jBW8QHmnX8MfgdUP6m1USX8hMTkjiNO8J9gw058TyQt6LN5oTKkGZMwhe+mON1oyA6dtH4WRdOqC0BrpCfr50GGrsoBCMaxwqVKjbrl1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754737686; c=relaxed/simple;
	bh=t6qLLP9Rz8mssywd0ufPhKeYTotDncfutg9w7wbI55Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lC/VNn2w+5j2fBxym5jjB/3pj+uX4ITxLyxzLpYc6MAfEXVaNydYe9mYsCe7ahSCa501T0TN4BKrdY9LNL6GzBkC2WubitRhLvUgY797DSAHY3PMNhYIV/1YwOeFZCdkPx8pd7KMCQDtmFJJqzzRAHge1LpIMpZNQ88xmYPaIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8760733a107so336072739f.3
        for <netdev@vger.kernel.org>; Sat, 09 Aug 2025 04:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754737685; x=1755342485;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbEzHNHqfjiCuUufwBJO2evFDMLd4HVgOd4AQLnCVEk=;
        b=rs5laTSjspYkg/F/8KV7QGjA9nnZ5MBWWdddFb35s6KvL6c/oOdR0OEBGTWYKK9jfs
         r9ll5x2sCNi0qYRbKcyhsdJ03SK9DVrLxjzKkYdJr1Jq6tQAxqDuCpVVZjUNbyKDgjzh
         ZrxgxXy5RDhBEFiK81yefKp40Eei2Ot7wtDwlnfnH2tuJehwg4i9s+aH9bIchPI00JQS
         qdsrBX5lZ8snG0smEn76SE/39fKdu08N4M8F3Q2qU/WnP5cIpIZ+BoVSCYnxH8gICghK
         BWVWVUpl9frAIsskjUtYgLQFgZoBb2dCtJYX7YYAtUqX2oiR8FODYEYcq2yPaiDUReJl
         ffiA==
X-Forwarded-Encrypted: i=1; AJvYcCVijAdUuPNMXkizyEleEymSChqcs1t9xi0pfg6dDzQ9rtl27kJD6+Yfy7v4M5W2McY7CvA0g8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Q+IxLj9gByxm1wvA0EmNXm2ao9LPkjlD/36YEjEqKOQpRgjK
	fg27TmS2D8QZKtDMLVF/Lv9nl/c3YBlQrdaU7J8X8cr1dVlWpK+97jPDZQV1rpNz2siQRybKMCR
	nYisA3GCCDWXRN3/175nY6XBiqTBMqAuyZhIa6CU8FURBX5n9cSG+SeU3C2w=
X-Google-Smtp-Source: AGHT+IFpmNIROBnotn/eZ20nh2RW8rf5uIFcU/r7kNwFI7QL+wiDjwTaCcDbw8svHpcr4zXxO/E0ty25Rw81cWk4FhlwT2lxc7fD
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c85:b0:881:7627:b0a3 with SMTP id
 ca18e2360f4ac-883f1273eafmr1248942339f.14.1754737684757; Sat, 09 Aug 2025
 04:08:04 -0700 (PDT)
Date: Sat, 09 Aug 2025 04:08:04 -0700
In-Reply-To: <20250809075631.4090-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68972c14.050a0220.7f033.00aa.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING: ODEBUG bug in __sk_destruct (3)
From: syzbot <syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com>
To: edumazet@google.com, hdanton@sina.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, sven@stegemann.de, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com
Tested-by: syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com

Tested on:

commit:         c30a1353 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10927ea2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ae1da3a7f4a6ba4
dashboard link: https://syzkaller.appspot.com/bug?extid=d199b52665b6c3069b94
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=134a5434580000

Note: testing is done by a robot and is best-effort only.

