Return-Path: <netdev+bounces-190572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEF2AB797B
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 01:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3086F1B66844
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 23:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DCD225A39;
	Wed, 14 May 2025 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="RfJFW2NJ"
X-Original-To: netdev@vger.kernel.org
Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D0E1BC3F;
	Wed, 14 May 2025 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266083; cv=none; b=GC6p9RCxeefdeXwpC4axNWj7SMTj1nf97Dg1bCkJAmTH9/X7+oAel168OgrCrgGmwiE3wAwmTMLFIZsy88DT2orDB8lOtCrxyxlr8w7OA4+3co6I2RyjfnhDs1/8nRVuzidlpuEyochowb5iN5G0yWe40VwuVSQ0qTN0vRNUc5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266083; c=relaxed/simple;
	bh=MVnaweWEo4Y6RnY7Wm1A+U4LC/8f2Rd0pJscbYacIC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+Sfk/DZd1sXcahfrzSRlBAkrtjH7GIkadvfYsWFNLU+U1TVQaYXZalrDQD81swQRAc2JbIko2ZcuP6Qsfvjod4UJnaiTmrhxZqzwPAQRlPdwu7Bk/kMEc4HOFzu7at7nyDK2kijm2XaB8QYnHhyfhZOBnZN1AGhhZBQoXr3i3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=RfJFW2NJ; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:cca4:0:640:432b:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 4CCBD60C48;
	Thu, 15 May 2025 02:39:50 +0300 (MSK)
Received: from alex-shalimov-osx.yandex.net (unknown [2a02:6b8:b081:7219::1:2e])
	by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id ldRegH0FcqM0-77NODdAj;
	Thu, 15 May 2025 02:39:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1747265989;
	bh=KdXMJfTgHscFFoP2SjCOVf01EBMu0B7G8Vp6MZjzDuQ=;
	h=Cc:Message-Id:References:Date:In-Reply-To:Subject:To:From;
	b=RfJFW2NJYTzl0heTHv6yQoaEl+Mk8w1cXOPrqoYWpxxMG04N/I/A/pEpO/toZbEWu
	 FdUVh4tegq2+6PP+BfWYhwyvAA/Z+gvxwwEf3vqlyg9WNor52Cc0w2ha8C5+kEP87x
	 +sgkpqTPWkk6Rnbj7F8di/r46kmFVf83Ypo/UYTE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Alexander Shalimov <alex-shalimov@yandex-team.ru>
To: willemdebruijn.kernel@gmail.com
Cc: alex-shalimov@yandex-team.ru,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	jasowang@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH] net/tun: expose queue utilization stats via ethtool
Date: Thu, 15 May 2025 02:39:31 +0300
Message-Id: <20250514233931.56961-1-alex-shalimov@yandex-team.ru>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <681a63e3c1a6c_18e44b2949d@willemb.c.googlers.com.notmuch>
References: <681a63e3c1a6c_18e44b2949d@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

06.05.2025, 22:32, "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>:
> Perhaps bpftrace with a kfunc at a suitable function entry point to
> get access to these ring structures.

Thank you for your responses!

Initially, we implemented such monitoring using bpftrace but we were
not satisfied with the need to double-check the structure definitions
in tun.c for each new kernel version.

We attached kprobe to the "tun_net_xmit()" function. This function
gets a "struct net_device" as an argument, which is then explicitly
cast to a tun_struct - "struct tun_struct *tun = netdev_priv(dev)".
However, performing such a cast within bpftrace is difficult because
tun_struct is defined in tun.c - meaning the structure definition
cannot be included directly (not a header file). As a result, we were
forced to add fake "struct tun_struct" and "struct tun_file"
definitions, whose maintenance across kernel versions became
cumbersome (see below). The same problems exists even with kfunc and
btf - we are not able to cast properly netdev to tun_struct.

That’s why we decided to add this functionality directly to the kernel.

Here is an example of bpftrace:

#define NET_DEVICE_TUN_OFFSET 0x900

struct tun_net_device {
    unsigned char padding[NET_DEVICE_TUN_OFFSET]; #such calculation is pain
    struct tun_struct tun;
}

kprobe:tun_net_xmit {
    $skb = (struct sk_buff*) arg0;
    $netdev = $skb->dev;
    $tun_dev = (struct tun_net_device *)arg1;
    $tun = $tun_dev->tun;
   ....
}

Could you please recommend the right way to implement such bpftrace script?
Either better place in kernel for the patch.

