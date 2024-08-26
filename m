Return-Path: <netdev+bounces-121845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0178A95F02F
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 13:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB0E1C2178A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 11:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76EB156241;
	Mon, 26 Aug 2024 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TIbImCOZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71915945A;
	Mon, 26 Aug 2024 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673280; cv=none; b=Oc9tU6zuYRV/+M+/FOGBQ4egHIR4mCsNb4i/VX051SnfDjN5mdwpNsM5+trBea70IjFv7/gL14VkyT+uOOt2Ob41tt/uyblxQ2zbEX8gFDMWNvei3bcq6g4lkgtjMy28ovCQBMYJCjMHWWoaCPPe903QpJIL6oCnAvc4OeCgIb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673280; c=relaxed/simple;
	bh=1dIyNDSZhQ4gGlEKkv3hW/FkDkCp5O0nX0jd85+69Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSxdZH42Pikixl/YXqfm4mUssEmpnpi2Z0e724LQbMCFR4JsCdEvxz2+0BIzpoDLYtEKEX6MCe4PpK8TRd/DJ+JfFHpeH1TgTZLTL8OVN5OE0UY91HtTdfs88y4AluvO0W3mzRsVCDz/UZaE4oSDEpAStSNCEZqk37VWkeSoJcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TIbImCOZ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9DC15E0009;
	Mon, 26 Aug 2024 11:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724673275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6R+ECOUnGZbJEa93c+3rU58LZs7k5IAkYOPVtDZaZ8k=;
	b=TIbImCOZa7RkjylZ4wpaAEQUfyqATHfG7/Qo2OzCV0FVCn9XsX3ZmxippGIuuPCGrQcQ2h
	kGAcf+4A0V3j5rEmQhXaCmutknviT9hYuwpJD4rjnZz50RY4MgPs/4ofoykmWoWXXfUsVL
	CVBMajValp9apJ39ZG16zDAm+7Tkl+LPERBR0aSAACC4JwlNsE0Elm2zHbghZuHn5SY6FQ
	iovo1Ce7u7rCPa891OStx4+j+aZGfErsURRMiKRP3BWyeRfJ2Hm1GND+wnVHE7DD8YqaYz
	NszdeJs7vD6lZVAZUsY8M4eip+Z9nEnyJL+LuHYmVkl1V2NOzJHlISifErRDXw==
Date: Mon, 26 Aug 2024 13:54:33 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: syzbot <syzbot+c641161e97237326ea74@syzkaller.appspotmail.com>
Cc: andrew@lunn.ch, christophe.leroy@csgroup.eu, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux@treblig.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: lock held when returning to user space
 in ethnl_act_cable_test
Message-ID: <20240826135433.47c87f62@fedora-3.home>
In-Reply-To: <00000000000045769206209237db@google.com>
References: <00000000000045769206209237db@google.com>
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

Hello,

On Mon, 26 Aug 2024 01:50:24 -0700
syzbot <syzbot+c641161e97237326ea74@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f9db28bb09f4 Merge branch 'net-redundant-judgments'
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=115eb015980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
> dashboard link: https://syzkaller.appspot.com/bug?extid=c641161e97237326ea74
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d2d609980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1741fbf5980000
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
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=146fcd8d980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=166fcd8d980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=126fcd8d980000

Looks like there's indeed a mistake in the error path for that command,
I'll send a fix for that.

Thanks,

Maxime

