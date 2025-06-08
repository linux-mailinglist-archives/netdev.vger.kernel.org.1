Return-Path: <netdev+bounces-195560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D6CAD12AE
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 16:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A5DD7A56A8
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 14:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583DB24DD10;
	Sun,  8 Jun 2025 14:39:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B727F211A05
	for <netdev@vger.kernel.org>; Sun,  8 Jun 2025 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749393546; cv=none; b=kGZw+vN/KcQQKP5HDH1kZl4mT3aGLHZqJ18kQSf9WN0G2MVV+DEKYlHybRz+e7/2dHz3YjKokFPaD+Z6GDfqT5pazuIv0pdjrAXMafgralWK5huO7Qb3v5bUX9qgY104hRRNx2BUoyVtXThYMxyn98Yhun3cWXDYt2QS5Py+bAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749393546; c=relaxed/simple;
	bh=ANm8RttGvSJuhx0wrKeTt3NL6cimr89RyDzhx2D7RZo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XHgK9HzM7kinUETZEQ8hBidwJzhqyqj71SXZIjkaIyqnUIxrrOaXmLDG8w8Z8e83gGrJsHeOTBRVdNxOlqQVcqgvSate5akNZ3J3l4B9mUdX9ojy9nbPtEhoH7kVmLVeaWIIyYion7rg91q3D4h6T39ncRmSmGyklpReeM+W2rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddd90ca184so6581705ab.0
        for <netdev@vger.kernel.org>; Sun, 08 Jun 2025 07:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749393544; x=1749998344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Byyo7kC3a/3rB2EMu+T1mfO8ZATgul+9Bm2fnUNoq7A=;
        b=Bzce/QYWr+jxEBCIhUZ6aAM8K/S/vozeCvSiRydKMQPSnZwBFig0+o1tCpH3Z36imT
         DgHQvBgwgcmmn7nsglmSiRVu1lismLaxIYJv/sztRSPn5t/uferQsNr2SbWgrNglT1n+
         Qc/oZlvnvYKzT/36Uv2Bprl8qgmocmPseFFpF/MXBpJx/4P3NpeggC0i9odm2zf0QQVr
         65YQI+gpWq6u56H+8hlNBCzVGoFlpjE3CO29xgbfKbZ72FR4jh68w/XkrpLAvZ3syCWB
         RXoYLeODktkspWlk7JV9UHSrQpPiRN66Gv0tc0Od49uXiNQitIdc1yomq7XoIbg8eTg6
         Ce9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMpUaLhHg18o+PHf5P0QraSSoXVzbSnWHmfipTFot/21gg7orhM+PBWnG67vXDwOJl83V6Kto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3x8Z8ylQFjIDhO0cMLh2io+SJT/JXKo545FkQqCDmZWG5hdXj
	j0M1kZe7RKb5CzIXiiRQ8zwN4zY9jyaNsZx8nBo5+/92USOzvZ3+3fq+1dEjWQFhG35ZCdC6MSF
	TAJcw/ofmPCQZYpzsoXoNf8CEhup5mxOv0FTtyZTrzLTerokbEr/vSr9UC5c=
X-Google-Smtp-Source: AGHT+IE3/7VhsAobctqaGXi1Yv2kjR1bAWM4ep3qse+qKfQCsnidE0mOZE8tDfBEq57yMyQTPHpjgfC2CbxduJ0mwt1MtEZU0VYh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8a:b0:3dd:a4f0:8339 with SMTP id
 e9e14a558f8ab-3ddce3fe9damr114184095ab.8.1749393543935; Sun, 08 Jun 2025
 07:39:03 -0700 (PDT)
Date: Sun, 08 Jun 2025 07:39:03 -0700
In-Reply-To: <87frgafi49.fsf@posteo.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6845a087.050a0220.daf97.0af0.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING: suspicious RCU usage in task_cls_state
From: syzbot <syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com>
To: andrii@kernel.org, charmitro@posteo.net, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, yangfeng@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
Tested-by: syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com

Tested on:

commit:         e5c42d49 net: Fix RCU warning in task_cls_state for BP..
git tree:       https://github.com/charmitro/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12750a0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c6c517d2f439239
dashboard link: https://syzkaller.appspot.com/bug?extid=b4169a1cfb945d2ed0ec
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

