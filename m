Return-Path: <netdev+bounces-230894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84709BF15BB
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 14:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4853B5E89
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 12:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13DE2F7460;
	Mon, 20 Oct 2025 12:54:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B403231C9F
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964844; cv=none; b=ZmQbiW49fmJjvBdUBKUoqkt6uUZikjbnNnOVqbDQprW8l5u9Wp8RMJxTYAVxG44ueKavp+Dc4UbM7sewRSZQUs/AiUtT+58B0nrez7LFpfjSPvOXzafiG0/EqGsXXl51Sw/hq96jNIxR7J47JIUZhjkF0sSWG5y6nGBkcL/wYJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964844; c=relaxed/simple;
	bh=15TmFUnVi0n2NL3DTB1KJr22JGzM6IVF4JxGd/sc92U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HrK3nb9b9JhlVhn0whZjmdVdUGJLA+uhAw6ZXEN3Qx7ztY5AFAKh9f74m/hLEtOl4aL1vct2jXGoFLN7cTlvZXaMf6upXuQdkR16SIXr0FAD/SOHpphH5dEzbc+Dliz7cIhW4frG4hKMGG7eXWZqODXQfTbPqV+8efVAVV8e/dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93e86696b5fso219763939f.1
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 05:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760964842; x=1761569642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qc79c81/Kkhmf27aio+Ww3bL8x8agTKbPF7aeVEHXp4=;
        b=PhF8sYUXpI6yNgfZEkZzvruwPywgmLp429XfulovJLUYRGLcqItkv17+UMh4FEwlVa
         BXZ9JA2aIJT3a3dF8Y24U3PRmA0fNp0sgTnGjyUmubB/8X3IposjGNJ5Ohfh0pTOjrdK
         8PUSdWmhstzfdon+dVqVFQKh1hDBKFio63nseulEklREXRRiy7sK1GTuSo0AJGj6qj6N
         FItUC/jzg1Zzh5R/LvQdafWreDqa1ruggNAg70UzceB1/bZWoYsXckJ26ix2lLfscjxU
         bAEZOfSAH9gZpH3wekD5GkEMmm80jqM4w/MjTR93eIWZ5icenYaalETZdQinrgUum5yX
         VsSA==
X-Forwarded-Encrypted: i=1; AJvYcCVdmhubWetpBCUcZhtOC0kxyRgr857+2O2Nntrmw03+MpwXpoJb9r7znmE5YWwrkMhz8yiIf1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzukFWdEfQkWVxTJngKiGtttpFIk5/OlPNkZlwCrvB6oZlCzeIJ
	Ir0Df6NlPKH+h9eD/EbaqJv71CP4nqgYfx5aEjRrHZROiWtzqv5X/mDN5b46/VwQ5L8rf+kRiyD
	kMr4roxwNaI0R7QSU1s7VKjjr8/MvbSJ0JJefyrUkxgLt/VZ9dw58Kob9N84=
X-Google-Smtp-Source: AGHT+IEx07bEjN9ys4pXUcgB6NMJWCWUOKJt8czLlBtec6J6iYiwLGVawWGKTojyzy6HLsd8mugaK1QTFHVKYxEzCEWJEE/FWjNV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1481:b0:940:d8d6:ca2c with SMTP id
 ca18e2360f4ac-940d8d6cf93mr533451739f.9.1760964842529; Mon, 20 Oct 2025
 05:54:02 -0700 (PDT)
Date: Mon, 20 Oct 2025 05:54:02 -0700
In-Reply-To: <20251020113026.2461281-1-wangliang74@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f630ea.050a0220.91a22.0448.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in xfrm6_tunnel_net_exit (4)
From: syzbot <syzbot+3df59a64502c71cab3d5@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com, wangliang74@huawei.com, 
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3df59a64502c71cab3d5@syzkaller.appspotmail.com
Tested-by: syzbot+3df59a64502c71cab3d5@syzkaller.appspotmail.com

Tested on:

commit:         211ddde0 Linux 6.18-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1564dde2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=3df59a64502c71cab3d5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1450dde2580000

Note: testing is done by a robot and is best-effort only.

