Return-Path: <netdev+bounces-72348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9432857A66
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 11:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DFDDB21988
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 10:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D501750264;
	Fri, 16 Feb 2024 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YV83zgHC"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D63B47A61
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079874; cv=none; b=EujyrRAu4mOyHUybhbumrXJrQh/4Mfrer4i87XaoHMocN+guDgwOFrviaowchbzuS4kcdItahWU971Teh9uzg2Xjhz0RfOBSNk1bEZeEfm3cAAOtMaM7orSXd0pQGAyxZSlst6DWRriaTsjtRez63T2/7q6ChrlcExk0eXpXpKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079874; c=relaxed/simple;
	bh=zSxuOcQydPZO/thKgJiAI/eeN26OyT9n+VxXKUnZIOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NXDbs12onPYMk8fRFf3+xg4LhzJpcOM9unx+YC4jCrVXzjRnCVB6oxOALVKyY42LF7ADX5TzC5cUbFERZMbM51WnwEFPu6sJbaMjP88PZpridt7o4/R2eWrHPAqdCAE389yrmsEk/EBkp4vBoDMd4I03JKkf36j6UIAr/Ze2MlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YV83zgHC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=8qSHjqBvLAcDjd38RNeBMUhMumamJFd2MHylRlOvUFI=; b=YV83zgHC3Hi/88R5h+/taKOn7u
	PzuMsdTfNc9jgVSTZNk5KHY09USVw1e5fwA7i59hvpAvfL8IGvcFaeF2gt0pyc29jYWVgAR1FSzK5
	wO5ETNBDKuikS718w/x2hoQe6r4qBFoLWuSWDZMavif40J8px5NP5joWtoQQuYxouwT/WX/fi/2Kn
	GnhuFsTetooUwfG9AizjRGOsOs5nvYsZHOrVk+mgVBm/AUZizpGRn3ZAbaIkrt++IuWH3PpsepyU3
	XmQGfre8UOfZrXKY8RN3Z4YB/XW/19eO+4aMUYR8sHahoCzsKyAJtp6Z5xjY4ix2br8/WuT7CtkX/
	QrNkD1bA==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.6])
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ravbB-0000000HRDr-3iVO;
	Fri, 16 Feb 2024 10:37:42 +0000
Message-ID: <64f7670f-b9b9-4d05-b6b7-630f0e5837fc@infradead.org>
Date: Fri, 16 Feb 2024 19:37:35 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net] ps3/gelic: Fix SKB allocation
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 sambat goson <sombat3960@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <4a6ab7b8-0dcc-43b8-a647-9be2a767b06d@infradead.org>
 <125361c7ec88478e04595a53aacc406ef656f136.camel@redhat.com>
 <7b695ae5-f7ce-454e-b94a-295013efddb5@csgroup.eu>
 <e29708440f07273fe93e3a1a7922428980f3e4a7.camel@redhat.com>
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <e29708440f07273fe93e3a1a7922428980f3e4a7.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/13/24 22:09, Paolo Abeni wrote:
> On Tue, 2024-02-13 at 12:56 +0000, Christophe Leroy wrote:
>>
>> Le 13/02/2024 à 13:07, Paolo Abeni a écrit :
>>> On Sat, 2024-02-10 at 17:15 +0900, Geoff Levand wrote:
>>>> Commit 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures") of
>>>> 6.8-rc1 did not allocate a network SKB for the gelic_descr, resulting in a
>>>> kernel panic when the SKB variable (struct gelic_descr.skb) was accessed.
>>>>
>>>> This fix changes the way the napi buffer and corresponding SKB are
>>>> allocated and managed.
>>>
>>> I think this is not what Jakub asked on v3.
>>>
>>> Isn't something alike the following enough to fix the NULL ptr deref?
>>
>> If you think it is enough, please explain in more details.
> 
> I'm unsure it will be enough, but at least the quoted line causes a
> NULL ptr dereference:
> 
> 	descr->skb = netdev_alloc_skb(*card->netdev, rx_skb_size);
> 	if (!descr->skb) {
> 		descr->hw_regs.payload.dev_addr = 0; /* tell DMAC don't touch memory */
> 		return -ENOMEM;
> 	}
> 	// here descr->skb is not NULL...
> 
> 	descr->hw_regs.dmac_cmd_status = 0;
> 	descr->hw_regs.result_size = 0;
> 	descr->hw_regs.valid_size = 0;
> 	descr->hw_regs.data_error = 0;
> 	descr->hw_regs.payload.dev_addr = 0;
> 	descr->hw_regs.payload.size = 0;
> 	descr->skb = NULL;
> 	// ... and now it's NULL for no apparent good reason

As I mentioned in an earlier mail, the SKB pointer is set to NULL
so we can detect if an SKB has been allocated.
 
> 
> 	offset = ((unsigned long)descr->skb->data) &
>         //                            ^^^^^^^ NULL ptr deref
> 
> 		(GELIC_NET_RXBUF_ALIGN - 1);
> 	if (offset)
> 		skb_reserve(descr->skb, GELIC_NET_RXBUF_ALIGN - offset);
> 	/* io-mmu-map the skb */
> 	cpu_addr = dma_map_single(ctodev(card), descr->skb->data,
> 				  GELIC_NET_MAX_FRAME, DMA_FROM_DEVICE);
> 
> 
> The buggy line in introduced by the blamed commit.
> 
>>  From my point of view, when looking at commit 3ce4f9c3fbb3 
>> ("net/ps3_gelic_net: Add gelic_descr structures") that introduced the 
>> problem, it is not obvious.
> 
> That change is quite complex. It could includes other issues - quickly
> skimming over it I could not see them.

The proposed change was tested by both Sambat and I.  It fixes the
problem, and no ill effects were seen.

-Geoff



