Return-Path: <netdev+bounces-106541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 138BB916B14
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31A228691F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8550516D4FC;
	Tue, 25 Jun 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="T4vLDr/y"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BC311CA0;
	Tue, 25 Jun 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327237; cv=none; b=bd/seSAnM5aZMC1PrPxCSBzcaDFC9jN7vQoqJNs7pHtNkkW/BREav/5Ka3B8IlTOGj4hURTn1kpZFVipdCMpGUDzsH2KoE9fmER+/Vj2lBWTWwDNwY43UXELWJ/qaEaG4o1rvISkFaL3/uIwM+xrfIxSMJNjywWMnz2EdsukNJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327237; c=relaxed/simple;
	bh=t3zK8lbxQ6JnlIHILJbeABZJSrGf7HkJ2/1sEEUWtBA=;
	h=Message-ID:Date:MIME-Version:To:References:From:Subject:
	 In-Reply-To:Content-Type; b=PKO6aAkl0gloJFsA1qJv3uu8e97YLwa5hLT+YtuGmtVVkcHwy84ZzMA6EYaHIpH8KG0Ie31xsI2WlmeSME5QaEepWVEp2aKoTugByGZbn+8eUZRIZdF0qAMeIQYhcGfrbjFqXMpjVQVvUW1HMQXTwDDX6RkZM4AOAUvsjjOUY2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=T4vLDr/y; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:2:e181:9992:7c46:d034] (unknown [IPv6:2a02:8010:6359:2:e181:9992:7c46:d034])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id C27B27D57F;
	Tue, 25 Jun 2024 15:53:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1719327228; bh=t3zK8lbxQ6JnlIHILJbeABZJSrGf7HkJ2/1sEEUWtBA=;
	h=Message-ID:Date:MIME-Version:To:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<e286d333-4672-6652-9037-3a50d7ebd6da@katalix.com>|
	 Date:=20Tue,=2025=20Jun=202024=2015:53:48=20+0100|MIME-Version:=20
	 1.0|To:=20syzbot=20<syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotm
	 ail.com>,=0D=0A=20davem@davemloft.net,=20edumazet@google.com,=20ku
	 ba@kernel.org,=0D=0A=20linux-kernel@vger.kernel.org,=20netdev@vger
	 .kernel.org,=20pabeni@redhat.com,=0D=0A=20syzkaller-bugs@googlegro
	 ups.com|References:=20<0000000000008405e0061bb6d4d5@google.com>|Fr
	 om:=20James=20Chapman=20<jchapman@katalix.com>|Subject:=20Re:=20[s
	 yzbot]=20[net?]=20KASAN:=20slab-use-after-free=20Write=20in=0D=0A=
	 20l2tp_session_delete|In-Reply-To:=20<0000000000008405e0061bb6d4d5
	 @google.com>;
	b=T4vLDr/yx5zLbmNQlKsvYYZcl5l8Ii1OVgQrnCN6I2HqfgGRxlgKAY60CfeEAfOjR
	 iqO/DqKeRSITG6zog/YcZwsyZYJyYeMopnzcnBjp9LLmXaPVZpQS51FSCx+SaGQy/1
	 iONna1cnRup9fs2HPHASOmXVmdplpMwdGjlceOQ4hRWjUrk6DU4SNH3ucpsgDWZ3xO
	 OMUy/jlenziMpBwp/w90hNpzLxGI+FfOngJDv2kkmre4NZsdoWXJr15KlYNSrcN/8k
	 6MC7wbKzTMLnF2yqskpTfnjZkCN8cpudo+6q9QssaRTLgNxEgNef+bIG409oi8wWJQ
	 BwPU1J+H0xTuQ==
Message-ID: <e286d333-4672-6652-9037-3a50d7ebd6da@katalix.com>
Date: Tue, 25 Jun 2024 15:53:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <0000000000008405e0061bb6d4d5@google.com>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in
 l2tp_session_delete
In-Reply-To: <0000000000008405e0061bb6d4d5@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/06/2024 14:25, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    185d72112b95 net: xilinx: axienet: Enable multicast by def..
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=129911fa980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
> dashboard link: https://syzkaller.appspot.com/bug?extid=c041b4ce3a6dfd1e63e2
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12521b9c980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1062bd46980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e84f50e44254/disk-185d7211.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/df64b575cc01/vmlinux-185d7211.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/16ad5d1d433b/bzImage-185d7211.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
> BUG: KASAN: slab-use-after-free in test_and_set_bit include/asm-generic/bitops/instrumented-atomic.h:71 [inline]
> BUG: KASAN: slab-use-after-free in l2tp_session_delete+0x28/0x9e0 net/l2tp/l2tp_core.c:1639
> Write of size 8 at addr ffff88802aaf5808 by task kworker/u8:11/2523

I'll look at this.


