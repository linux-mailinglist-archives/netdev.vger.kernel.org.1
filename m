Return-Path: <netdev+bounces-93453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9551C8BBD89
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 20:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC41E1C20E10
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 18:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E1F6BB29;
	Sat,  4 May 2024 18:03:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E309367A1A
	for <netdev@vger.kernel.org>; Sat,  4 May 2024 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714845784; cv=none; b=iNTuFXGCFxVy2LmQxLjIckV05uK59iFgoFSrxUJtKyUnsBhaz+JVUF0eThG+axjuYS2iLJvEBmqZks3JywirIuINfxrCcI4fXCm51eA76Q+tz/j1Z6Dqm3wOt7dlXvVPUlYFQqTMiwMnCtNi8YzBEicS3UDj+sTVcSms48XTTNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714845784; c=relaxed/simple;
	bh=TGOyrg0sf81JB2aKmDNGGn/8jsML6d2k85Lh7p/VWc0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vAyqlZCmiJtBrp7uekv5CSn7BOv5Sv3ZBBg48ARPUrBthREP1cV5CDe+OGHDbMIRxw9K2Gz/QNVPtfGLbwG+dO446Aic4UXNK8d54ShvFEa0D6LdhJu2Ykw33UYBuaqhERJbhoVO35hrV0Hj/RPzLDwLPVYQ+VHC1OATbPZrFPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7dee48ec44dso76194639f.3
        for <netdev@vger.kernel.org>; Sat, 04 May 2024 11:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714845782; x=1715450582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUPcGyTMIX5rtLi/ARCE2IxHHhgwhiuh+5Rloinf3xA=;
        b=K/w5qTTmiYhaHASBWxyCbnHOSqFv6Bm9tHWMUzJPjxOEJnjd5ku7BvsBm7Rfx2/Nj0
         j5kD8oN5KL9W9lmZwgPHopuKkSF/8UvV0a5YOIi8VxnQ/SBXw7xqX/yJFr8t8fZEaqPe
         OxXKOlq62sDdOvZZm8xZ8gxvQ9BKEDbDyunME1eGbt8Xf2mb785rXGNaEFLXWeb4lzk8
         YXqDskRU0sCMn2A5bgSIM+aIAVifXWDEX6UBypFSBK2C+8loFrjzpNgNnI8HRKwFT4FP
         RDcedxeqfJqqmbSfn/qSAmhY6AnqX5Y2GZyeRBwWSBKMMJhymzJuZ45PkK27b1UnbX/k
         pTgg==
X-Forwarded-Encrypted: i=1; AJvYcCUNWQp1L1MsoRrPcs1C1v8BdUPf8ZVI2kSwCrVuVv+Tdf97JrZSv4MIySX13QplpokRT7vUCakoDoel5EsIukOUC0Sl6Fn6
X-Gm-Message-State: AOJu0Yy0tEpJKoUrQzE7by8cuaZ5pICikZmtuf/rO9CBqO0zc/wk//zy
	vvJ4RV5/M593SJMopLPTx74lZTO3YeP7ZPjyhz5AsFQUiozWHUTTMkaHh7I2RghbxnlJul4224N
	gt+1+Diab6Zf/FggnLnv7d4aFCC1TSGcpayd702AicSFZXdWHAF/djGY=
X-Google-Smtp-Source: AGHT+IHexZQjdMJ0UcNQiKItATZihzTrma90QUok5tG6gn9gMnSrxE72OaHcLmP4TLDaWgpBh6OjwcQtZdjnOXhshwTFiadLwhWr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2489:b0:488:75e3:f3ce with SMTP id
 x9-20020a056638248900b0048875e3f3cemr9923jat.0.1714845781990; Sat, 04 May
 2024 11:03:01 -0700 (PDT)
Date: Sat, 04 May 2024 11:03:01 -0700
In-Reply-To: <0000000000004cc3030616474b1e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae301f0617a4a52c@google.com>
Subject: Re: [syzbot] [bpf?] [net?] WARNING in __xdp_reg_mem_model
From: syzbot <syzbot+f534bd500d914e34b59e@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	hawk@kernel.org, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, lorenzo@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2b0cfa6e49566c8fa6759734cf821aa6e8271a9e
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Mon Feb 12 09:50:54 2024 +0000

    net: add generic percpu page_pool allocator

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=151860d4980000
start commit:   f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=171860d4980000
console output: https://syzkaller.appspot.com/x/log.txt?x=131860d4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=f534bd500d914e34b59e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ac600b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1144b797180000

Reported-by: syzbot+f534bd500d914e34b59e@syzkaller.appspotmail.com
Fixes: 2b0cfa6e4956 ("net: add generic percpu page_pool allocator")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

