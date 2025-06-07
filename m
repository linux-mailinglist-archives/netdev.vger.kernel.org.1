Return-Path: <netdev+bounces-195507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B587AD0B8E
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 09:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A79188E755
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 07:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8F91A8401;
	Sat,  7 Jun 2025 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="SgG/7AIP"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7542B9CD;
	Sat,  7 Jun 2025 07:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749280615; cv=none; b=q24pnhLmxbPcwqQurOwcmOm+j/A4K4zz/8zXKyiEraD5MnQetekv4j6tpjVqdxe+5aQ9wWrqzCUI/xL1yeKAdm4MzXivxD97wJTqnxfltwUJQEPps7qSOhRTXlK7F9tmwKbWWMPh7UCiENjWzumysURAoaMKoYAQwX9Mf5gTV5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749280615; c=relaxed/simple;
	bh=i6tj367JhwNOI0dDOwhWERjHGKsLrDff0c9558hw5n4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F9wlkhz2CipOIPzqJc2XZIyTLiRy07Xn9I1znu++7qjNSFIU+TlVnzPcHPPjuAGp6ofXJGZ3PUh/sfnBB8Ouc+wuoUop7fJ8e1XuNL6ln43wLhVB54Y34u/+i1t6MQW6uXknYK/PDS7evvuftIM4tpR6aF7i6uN7uMM4Roc83QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=SgG/7AIP; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1749280250;
	bh=Guq49YrWSVMpNNOo/KMBViRdcpqUzwE1CdPt0Wb16Rg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SgG/7AIPHj4U7bOxOMzD0QhoCy0e2b71WlOvgI1DdrKx0XGviTcLiHexdQeXHQ6A3
	 AB73rJb0WRMBowL4fH1yyzu3AmEYoO/bBJ8on9visOTXNqxnY6RT1vIMZ/t3LFOdZz
	 Alx3/KanSlHhJHw3DfPIrtYo+AUqzj3lqcZ7VagQPtl+8XugKRTT3w09zD22ZZZf1L
	 5GpgSp27X0vUPdCaIKfruTB+SXg2bvepAPbS9u/yh8rgyp5HBUIamD/jrUQzuyTc84
	 BtwlpK3dbK+kSCov0ql7FoVVyDlbb50+/SpYU6IYz1mjDyt9bxnS7q4HFpoKzUxgv7
	 IYwZxTOLbqLkg==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id ABD1F640B5;
	Sat,  7 Jun 2025 15:10:49 +0800 (AWST)
Message-ID: <0ee86d6d80c08f6dce6422503b247a253fa75874.camel@codeconstruct.com.au>
Subject: Re: [PATCH] net: mctp: fix infinite data from mctp_dump_addrinfo
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Patrick Williams <patrick@stwcx.xyz>, Matt Johnston
 <matt@codeconstruct.com.au>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Peter Yin <peteryin.openbmc@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 07 Jun 2025 15:10:49 +0800
In-Reply-To: <20250606111117.3892625-1-patrick@stwcx.xyz>
References: <20250606111117.3892625-1-patrick@stwcx.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Patrick,

[+CC Peter Yin, who has reported a similar thing]

Thanks for the report and patch. I've been staring at the
for_each_netdev_dump() behaviour, and I'm not (yet) certain that the fix
is sufficient:

> When all the addresses for an interface has been sent, the code reset
> the address to zero and relies on `for_each_netdev_dump` for
> incrementing the index.=C2=A0 However, `for_each_netdev_dump` (which is
> using `xa_for_each_start`) does not set the index for the last
> entry[1].

but that still seems to be acceptable:

 - if entry there is null (and so we're not updating *indexp), then
   xa_find() will be returning NULL

 - if xa_find returns NULL, we're not iterating the for-loop

 - therefore the original indexp value is sufficient to act as the
   loop terminator

If an xa_find() of the index *does* yield a device, we'll increment
index as part of the for_each_netdev_dump() macro (unless we're still
working through the address array, in which case we do want to use the
same index at the next call).

FWIW, I'm not able to reproduce the issue here on v6.15, even when
forcing various combinations of netlink-message splits, but we do have
other reports of it happening. Are you able to share a trace of the
recvfrom() calls for `mctp addr`? That may help to understand the
breakage.

So, it seems like there's something more subtle happening here - or I
have misunderstood something about the fix (I'm unsure of the reference
to xa_for_each_start; for_each_netdev_dump only calls xa_start?). I'll
continue with the debug and update shortly.

Cheers,


Jeremy

