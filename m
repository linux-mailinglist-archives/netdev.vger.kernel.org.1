Return-Path: <netdev+bounces-90331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1808ADC48
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 05:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3431F228B9
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 03:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E783118E1F;
	Tue, 23 Apr 2024 03:28:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CC318AF6
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 03:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842885; cv=none; b=mgACn9Z2Hrxfr06++qVjTkKUXyW1GrUoKe21BrCF4ZVtjwDnEILOnsrKECs7C+WX3dCtRDCjDYkqL0r3H/WWL37Gcf8jCWnKXF9/9ycp+vrLCPkkNWiV0xKPkNNnHmScCbhFEaWrINgCEJPVnGFMiOYmc401V6QFmiPrAsvUJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842885; c=relaxed/simple;
	bh=D5ciqGdFeSQggt45cK7G60COItW+ZvydHCOqoDA4sJ8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mS0GS+anbdCb8OMH4aUZVT4NZ9+b7/jX6BFnXbzsatvWaWDR2ki+8jHaQ7dJlWMhouW4d8O2Pab96T++MW8D0EPJpFPuqj6Se8paZx63VKpGRgVzoPeabvQ7+TEobqDWK7+LqQiGBl5zuflikghCz8H0cQwV3XCFS2QEQ6bXLfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7da42114485so568112439f.2
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 20:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713842883; x=1714447683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMls4jzTFq2aaFa5geaJXiDj/xAyYqk+EmXC2QNa7HQ=;
        b=sG7p8HPUMUeQtoK5PxWPH4w3WWXSgByviTkxzS58eJobGNLVXr2g2M2RBIrVxKRfjD
         xj8/0SzAoJydd4vo8eAQpByVFE3EBMK6+uDsm/e7RtkhdISnH2BR6xGf7mHKZYF3KI3h
         sqOeZuaGpmAhxDoYrnn7q1+Ubz8r1DojZ0EJN6I3cKMvx0ow++WYhgE3k4WSghV5urAu
         +QyayIH0GvkaQkyrGnMmEmtHL0akfNi5LF1pdxo4ER4lAjgDArstHvM3ueKPqmdOI6hZ
         2KGZf6QW1IhpPnLQty0RaCsOCdiftFnOgc9t32RsXljoUVQeWeBeyfiuIgmaNJ38jO9a
         iZew==
X-Forwarded-Encrypted: i=1; AJvYcCVcUYHpRnxq6oj0uLT0sl5TLtMLjnMAffArRVYIhifsrF7kz6Aq2CW3KriLsigp6Gjbjh/sPlR07fuZlyRs3rJ5vzCCEdlg
X-Gm-Message-State: AOJu0YxRUJJFio24QyFWMYKFEkSaXv7GBa6+MRLeKmrM9DH4sYRP6hJ1
	D+AtBX3cPSoSPXAGoeTxZCcQMk4pKQ0xn769W7jNo0DZMzas8LYtKWidBJhKPzZx6AqhFtbktSU
	tWG4C/G91zBegTZDIzm8DzSm7Eqoz5HOywgMZ/VSU4GXwNB6uvkKYBQE=
X-Google-Smtp-Source: AGHT+IGkq03g3jNcwhjr216oqgH/1XiAAqU7NsSvpIdHlcEIb/lgfUni6J7+NAbFa5CSmIsxwabmWtP596C3kOzhkX2YVUQ/DgoY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1647:b0:7da:b30e:df80 with SMTP id
 y7-20020a056602164700b007dab30edf80mr193109iow.0.1713842883719; Mon, 22 Apr
 2024 20:28:03 -0700 (PDT)
Date: Mon, 22 Apr 2024 20:28:03 -0700
In-Reply-To: <20240422161108.83595-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004903cd0616bb249b@google.com>
Subject: Re: [syzbot] [net?] WARNING in gre_tap_xmit (2)
From: syzbot <syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, fw@strlen.de, 
	horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com

Tested on:

commit:         219eee9c net: skbuff: add overflow debug check to pull..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1438fd73180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a19cdb0b4b41d5ec
dashboard link: https://syzkaller.appspot.com/bug?extid=c298c9f0e46a3c86332b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12dc1973180000

Note: testing is done by a robot and is best-effort only.

