Return-Path: <netdev+bounces-117689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D595594ED27
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E531F22213
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBE617B428;
	Mon, 12 Aug 2024 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XechQ9Mo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7701369AE;
	Mon, 12 Aug 2024 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466279; cv=none; b=hDfnZ1UsAPOPZWg4iBAC3qzGSVwZGGQEQr2CD6BngqTSchbgfQtRUUDWUj1q3W0qqwIqQYBJmuyNQFg0cy/EHbqUfNvWX+Fm8bBmINuSmucKw4HlR0uipCLTtLin+qolXa80r1zRQjlnngzNSnaSmbnphPegxpNFxg3PGWZfvDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466279; c=relaxed/simple;
	bh=ll7rKCvIK5FinevpBDDYACR2NNSA00n20xpIFJ7Pggs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuJhw7TxGzND5XqCeKuQgDDah1BOdHdOGOTqOLDH9JcY/15COm6ouXAgJ/PbkvDIfbOmrkbkvr8ztQBHLrmtm+PWZ5sgziR7ynRKYbrS3T3E0Mp+sdSDnlk3IqSTM7wNYhkrJq67ZrvlchqsqzefiHlxCN0fOjHTJ6LgZp55uqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XechQ9Mo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MlyCx97Vj5xKVHsPK8EMQ/utmeFGM8vhocj6gX7aGmg=; b=XechQ9MoG36ki92DOiEHmm2J6i
	PXYlL/7crx2dgDAhR7MMIRwEvvCq2+QzUH0rXL19L9UiUzFc/iaVipyStlVVwhicpgJTZAw5h5mUa
	JB+1vvoiQ33V78qQkQwz5M8suny87XZZlVcKrj5ogzenWSsaqOr+K9tcnfz+fa9gcC1Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdUIq-004Zkw-4k; Mon, 12 Aug 2024 14:37:36 +0200
Date: Mon, 12 Aug 2024 14:37:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 1/3] ipv6: Add
 ipv6_addr_{cpu_to_be32,be32_to_cpu} helpers
Message-ID: <827bbb8a-2d5b-44a4-81a2-258c7713ef59@lunn.ch>
References: <20240812-ipv6_addr-helpers-v1-0-aab5d1f35c40@kernel.org>
 <20240812-ipv6_addr-helpers-v1-1-aab5d1f35c40@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812-ipv6_addr-helpers-v1-1-aab5d1f35c40@kernel.org>

On Mon, Aug 12, 2024 at 01:11:55PM +0100, Simon Horman wrote:
> Add helper to convert an ipv6 addr, expressed as an array
> of words, from cpy to big-endian byte order.

Hi Simon

Is cpy supposed to be cpu?

Otherwise, please add: Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

