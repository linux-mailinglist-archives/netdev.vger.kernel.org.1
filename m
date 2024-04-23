Return-Path: <netdev+bounces-90325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2044A8ADBAC
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 03:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05592810E2
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 01:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D1414292;
	Tue, 23 Apr 2024 01:46:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A337C18032
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 01:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713836768; cv=none; b=sQkvH/UDOr84oJN4vP3BIKZBYS0bmpHxY5+Oq/WblgsaRqVgcAJKoSEVYeclZjY4zIaqE9BBh8x9Q2aIXhEwn/QS7SXgVUYuiC//TwB7IJCEpt9NGz2P8bBvVPsnzCTJVsuDyqVhyk2GBfDPjTn2JVR/I58lbsiWYc+nPMFFzD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713836768; c=relaxed/simple;
	bh=VGeBMKGq9/Hj05caC3kl8lkmEKoFdqUf7+vqK4SSf9U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Lizx4IMImUQ5zP4dTTYz97HRoK33XRgmGUSAMvKmiN8JcKMRwwA8WcCrWXqTT9iuVdP8x/Y+UH8yi4K6a/ky7J5rGaCmDr3QHDQU+D5B+gNVlUhKYuLrvoIrJ79AkEGDwnUDsrlVoxN8YFlUX2zkPVotTJg8Z5t+aj1XX44fkVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ddf08e17e4so36149639f.0
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 18:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713836766; x=1714441566;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WCupfQ1dCDU21cSKiBT3YMKDn110UjiBH0ZicqUxGk=;
        b=qBGdA8sOXh9ydEadmU01dcGpXTb4nUl3dxMeY1D5JS+dwc9H5jJRkgdqlDAde2GgUh
         9rh3kWEUwEnMpB7MFeopPmXchblnUtC6PY++zaLv8rpY78S4f/VomLfnZ754fcGtAxtt
         RBYVn0Qp92iqf/7B9rVe4dpUowV/Rqn+A3hv9gOXK4CPGn4epazvdILaXXJWlSCFJzaA
         jsYhv3lR2vUYto+JcMkogk+BByEiVKO8Ot2cgx/fUnq2Qav7dy9krXvhK6CKslP/LUBA
         Wo0cckroW1/OairIVUHPBde9VwwVAv/v/rQox/yhLArjNPaW4LHaiQSXJsm259IiucMh
         l4Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVH/+csD6C6dH6+bpZK362AzdnuhHNvPkvDBr6MuzqtKY7eMDyA5906bcvDsd65RTqO9be9zLrk7mnPk7/WGZESnwTYW/IB
X-Gm-Message-State: AOJu0YwMj1MCz41rZ/44g+VyXBzHWklMJ13b0EHtX+B3AFWxurfnQ16q
	Xq525b160wzjS4pscKsYc/4tZ3ZW/j8xz15J6XT71TREWja89yFAD60wIa9XUGFe0U5BG2v1Lul
	v6epzrnP/EsPbkYyP7QGcUXCyPjuWle2vBcBgwXJEKhrIbot0JywOpl4=
X-Google-Smtp-Source: AGHT+IH48UqFEkGt1Qqueqq3haIM+KLMvozMjEfBK3G/AergUVQ+XvZS8xlYf1kvWIScJiTdzSLWPApCVy3Ks0Ow5kGE+IM+n69M
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c08:b0:7da:bb15:56fd with SMTP id
 w8-20020a0566022c0800b007dabb1556fdmr40563iov.1.1713836765934; Mon, 22 Apr
 2024 18:46:05 -0700 (PDT)
Date: Mon, 22 Apr 2024 18:46:05 -0700
In-Reply-To: <20240422160728.82185-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a30a9e0616b9b739@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in ipvlan_queue_xmit (2)
From: syzbot <syzbot+42a0dc856239de4de60e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+42a0dc856239de4de60e@syzkaller.appspotmail.com

Tested on:

commit:         f2e367d6 Merge tag 'for-6.8/dm-fix-3' of git://git.ker..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1286b06b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b015d567058472
dashboard link: https://syzkaller.appspot.com/bug?extid=42a0dc856239de4de60e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=117ae96f180000

Note: testing is done by a robot and is best-effort only.

