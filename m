Return-Path: <netdev+bounces-122626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53861961FA2
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 08:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117972868C0
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 06:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A0E15749A;
	Wed, 28 Aug 2024 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CAQCxK0i"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1B5157A5A;
	Wed, 28 Aug 2024 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724826198; cv=none; b=rlcX/fZECp6cijlAt/OGYTfXfXg34TFyNw48xxkw6qjCIVFvXz35A4APLgyqD1TltraPIFya0hBW7N0Pg7rtUqnVmezIjCtihdAHPP15Z5E+ld7VymmbOYlYObwr3l7qWPIQMNvm2NwA+rPZZlNXHuhOD2xdaPkTFCkiiluOMqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724826198; c=relaxed/simple;
	bh=M4LgZVz4mIn1ZY30fwcbWgsAQnw5a1yuTqVz7xcVGsM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKtKq4bQUQ64G2WXpsNTj+Kd5xZ/fhypzK/q8aQQV3sTqi5PuzOInKyM9BWgx2npfwuSAGPspHLm3+0tI5FjnYMLak8b3BhiGXMBLpIttr9C5R62Ta+E7PrPHuADMzAy9huiTfdgUWbMX8AMpkc3EBrmeoCYZP7eB7pB9LUKFns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CAQCxK0i; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 714C020009;
	Wed, 28 Aug 2024 06:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724826194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MrtVMCBcACVqTWE8JfEJ5Lda89wQNtdQvQ4uwQLo7dg=;
	b=CAQCxK0ig6dlqLuoDPZHh8BeZD3ypyah2ndaFMoNS4Wa5H8SgnUMFrC9+m5M6NEJFt06eC
	tsqn6dD3320TEsuG4EzRxlmix2Xexv1ClIPE3I0BHtrYPAwubHaXmtqEItEdlvxXn7+aAS
	oH24cLr6JnNC9Qgnwi40nVWhlJMNphgr8mhbdZM/0jQaf7QY6cffnxUyVTzilmh9tI+I76
	zm43sKYq+86JEsTyG0rqptnw2ICN0Ss7qmYCfeUqd+wt/kb9NbLjvOqie3kpyN+tSCPOlE
	ZW0ITuYwgMA54rNobWU0kS/akzdOW00sSDB/fAni3SAY3MU5n+OGNkdKIJ66Ng==
Date: Wed, 28 Aug 2024 08:23:11 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: syzbot <syzbot+5cf270e2069645b6bd2c@syzkaller.appspotmail.com>
Cc: andrew@lunn.ch, christophe.leroy@csgroup.eu, davem@davemloft.net,
 edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] general protection fault in
 phy_start_cable_test_tdr
Message-ID: <20240828082311.406c9ebb@device-28.home>
In-Reply-To: <00000000000094740b0620b32b4e@google.com>
References: <00000000000094740b0620b32b4e@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Tue, 27 Aug 2024 17:09:22 -0700
syzbot <syzbot+5cf270e2069645b6bd2c@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f9db28bb09f4 Merge branch 'net-redundant-judgments'
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1656cc7b980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
> dashboard link: https://syzkaller.appspot.com/bug?extid=5cf270e2069645b6bd2c
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1582047b980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100af825980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/585e02f7fe7b/disk-f9db28bb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b9faf5d24900/vmlinux-f9db28bb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f9df5868ea4f/bzImage-f9db28bb.xz
> 
> The issue was bisected to:
> 
> commit 3688ff3077d3f334cee1d4b61d8bfb6a9508c2d2
> Author: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Date:   Wed Aug 21 15:10:05 2024 +0000
> 
>     net: ethtool: cable-test: Target the command to the requested PHY

A fix for this has been sent already :

https://lore.kernel.org/netdev/20240827092314.2500284-1-maxime.chevallier@bootlin.com/

Thanks,

Maxime

