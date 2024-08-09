Return-Path: <netdev+bounces-117061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E8B94C8BC
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF661C216DC
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 03:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C031017BCC;
	Fri,  9 Aug 2024 03:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlL7fn63"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FEE28E7;
	Fri,  9 Aug 2024 03:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723172827; cv=none; b=j00VeM0PU4OeJ8UxA1dS1zcvikNqkq79R/FPjmDUtXzyr5E72/fGrd8nw0novyvoTeq05gS53QnBL/afSODp4jHV7o8x5bGyBdRBtk0/GjStSLoORzHdViSlSWCaeAtC53KQJhj2DP8JtiDUw6gc7Qk3TKVX0di1rTT5ok/rtZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723172827; c=relaxed/simple;
	bh=dIHU0BXpxcbDRu80fHaHCCC2/zgvvPwSZLiXB9EUGy8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9vH6RRcGq343DlTecjh/tSxw7qTyUUglygjMKoEUG9I+6dgNXikfCFGc0x1mpHEFMwsoc9j86AYortj6B5PlbqICyMNMuo0aUEsTGYaYlfe1twSyqzIhjO8Ov8SRDTAHYw2osxDdnM+NyLP6Et94XoGxOGkP3GiqKB3Ss9IipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlL7fn63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96738C32782;
	Fri,  9 Aug 2024 03:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723172827;
	bh=dIHU0BXpxcbDRu80fHaHCCC2/zgvvPwSZLiXB9EUGy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IlL7fn63eRgrMziTHUl58NVnNcurqvKyXsx3PEGXBN4T2wWfSED2chmkzM2tO8ia5
	 xv6c7jafVcQZqL2Od1S1S1L8KIT7blI1X4uQtBewTFab0tZMTXn8BI2yAlFsycKZ3f
	 9GLPltvWhpOFf1lrYnwsjEu/Gdt98Qgk7RDKz0Y3YN5vOLoCs8edUxU0Tgn6jUUw/i
	 dNv1RXn3qjpRn3Nlm/ALuYGqsPQXHO5+ysS83npqw7e0Bc0XA2p7oDUmDndmDvNe8r
	 WUISp/OTEcesp6kqRL6jcCAzMUwHiDB3kklFv/J7X+e3Mlq9cU2GMKtldXPouFQNTg
	 q308o7jWvO5PQ==
Date: Thu, 8 Aug 2024 20:07:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
 <jiri@resnulli.us>, <horms@kernel.org>, <rkannoth@marvell.com>,
 <jdamato@fastly.com>, <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v26 07/13] rtase: Implement a function to
 receive packets
Message-ID: <20240808200705.0e77147c@kernel.org>
In-Reply-To: <20240807033723.485207-8-justinlai0215@realtek.com>
References: <20240807033723.485207-1-justinlai0215@realtek.com>
	<20240807033723.485207-8-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Aug 2024 11:37:17 +0800 Justin Lai wrote:
> +static int rx_handler(struct rtase_ring *ring, int budget)
> +{
> +	union rtase_rx_desc *desc_base = ring->desc;
> +	u32 pkt_size, cur_rx, delta, entry, status;
> +	struct rtase_private *tp = ring->ivec->tp;
> +	struct net_device *dev = tp->dev;
> +	union rtase_rx_desc *desc;
> +	struct sk_buff *skb;
> +	int workdone = 0;
> +
> +	cur_rx = ring->cur_idx;
> +	entry = cur_rx % RTASE_NUM_DESC;
> +	desc = &desc_base[entry];
> +
> +	do {
> +		/* make sure discriptor has been updated */
> +		dma_rmb();

I think I already asked, but this still makes no sense to me.
dma barriers are between accesses to descriptors.
dma_rmb() ensures ordering of two reads.
Because modern CPUs can perform reads out of order.
What two reads is this barrier ordering?

Please read the doc on memory barriers relating to dma.
I think this is in the wrong place.

r8169 gets it right.

> +		status = le32_to_cpu(desc->desc_status.opts1);
> +
> +		if (status & RTASE_DESC_OWN)
> +			break;
> +


