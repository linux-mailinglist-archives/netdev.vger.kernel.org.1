Return-Path: <netdev+bounces-182739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E66A89CAF
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA3116A0BB
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4533128E61D;
	Tue, 15 Apr 2025 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="B0eR0mUn"
X-Original-To: netdev@vger.kernel.org
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677881DFD96;
	Tue, 15 Apr 2025 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.35.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744717236; cv=none; b=MdNb7tDwv/r78j+OfHK1kDACJ97cHfroJwP8LA4IZ166Ik+7cSJYz+6inlkKhjJZ6R/9z92wsCWKobLlXcZCRIVDtquPIbaQ2Y1cDt5J3Fh4UxHn5UIp0ihFGm5ArmFz0+1gHZrZG2Ynu07aBJ3Ed3w3HEBpiy+eiGs3y4OpWwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744717236; c=relaxed/simple;
	bh=crUzhLZR6kohcn8ctKDzFw/yNkNnOwRO4xA4Ob5DDd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrfhVHDx3/l7ozKfBgaDv6aoN9EsyQ4Ile6XCcmSnADPIoQOQ2nqQw84sHMmuybInrqFyDy2nR4LIFdLWSfUu/jeVNDmmpwPPO6rGBCJE7t7H9t+E7lXYjhHCUC4XFyblC2uRRPsR4IZfOs3leuYglumbLMQRLZioogukI4rCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=B0eR0mUn; arc=none smtp.client-ip=51.81.35.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 3F9D12142D;
	Tue, 15 Apr 2025 11:34:44 +0000 (UTC)
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [151.80.165.199])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id AA34B2005F;
	Tue, 15 Apr 2025 11:34:35 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id 39FE73E886;
	Tue, 15 Apr 2025 11:34:28 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 9FE7C40009;
	Tue, 15 Apr 2025 11:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1744716867; bh=crUzhLZR6kohcn8ctKDzFw/yNkNnOwRO4xA4Ob5DDd0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B0eR0mUn2B/U7VU0hYTXDvhfRcvzrd4/36BaXkysrHdIZVCxbCsA12ZShTGhWBs0J
	 I/Ld0LOoH0iCHs5+PEW6wgbq/G8PUMkENw7CMlAeAnqcmMyDMKNfsgAJBtJOvjwZzu
	 /NZ9YPS5IHzo0+sgtxy1HyKUMzuBXOUyjys+jpq0=
Received: from [50.50.1.183] (unknown [58.246.137.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id F34364082E;
	Tue, 15 Apr 2025 11:34:21 +0000 (UTC)
Message-ID: <d82b174f-60a7-41e1-8987-c56155c60630@aosc.io>
Date: Tue, 15 Apr 2025 19:34:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] net: stmmac: dwmac-loongson: Add
 Loongson-2K3000 support
To: Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Yanteng Si <si.yanteng@linux.dev>,
 Feiyang Chen <chris.chenfeiyang@gmail.com>, loongarch@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Biao Dong <dongbiao@loongson.cn>, Baoqi Zhang <zhangbaoqi@loongson.cn>,
 Mingcong Bai <jeffbai@aosc.io>
References: <20250415071128.3774235-1-chenhuacai@loongson.cn>
Content-Language: en-US
From: Henry Chen <chenx97@aosc.io>
In-Reply-To: <20250415071128.3774235-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9FE7C40009
X-Rspamd-Server: nf1.mymailcheap.com
X-Spamd-Result: default: False [1.40 / 10.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[chenx97.aosc.io:server fail,chenhuacai.loongson.cn:server fail,dongbiao.loongson.cn:server fail,zhangbaoqi.loongson.cn:server fail];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,lists.linux.dev,vger.kernel.org,loongson.cn,aosc.io];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 4/15/25 15:11, Huacai Chen wrote:
> This series add stmmac driver support for Loongson-2K3000/Loongson-3B6000M,
> which introduces a new CORE ID (0x12) and a new PCI device ID (0x7a23). The
> new core reduces channel numbers from 8 to 4, but checksum is supported for
> all channels.
> 
> Huacai Chen (3):
>    net: stmmac: dwmac-loongson: Move queue number init to common function
>    net: stmmac: dwmac-loongson: Add new multi-chan IP core support
>    net: stmmac: dwmac-loongson: Add new GMAC's PCI device ID support
> 
> Tested-by: Biao Dong <dongbiao@loongson.cn>
> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   | 105 ++++++++++-----------
>   1 file changed, 49 insertions(+), 56 deletions(-)
> ---
> 2.27.0
> 
> 

I have tested This patch series on my Loongson-3A5000-HV-7A2000-1w-V0.1-
EVB. The onboard STMMAC ethernet works as expected.

Tested-by: Henry Chen <chenx97@aosc.io>

      Henry

