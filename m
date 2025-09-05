Return-Path: <netdev+bounces-220506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4704CB46748
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 01:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153015A1A5D
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 23:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C006F296BB2;
	Fri,  5 Sep 2025 23:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCOGK2Hg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907D726B951;
	Fri,  5 Sep 2025 23:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757115850; cv=none; b=iXMjt0/mrpaCW5OPRj/diRxqY80RBODvxklsAtfByDOdHhtcygdXBA25j87yzMTuwdkGPAkpqUnCIOuimS3/579wrA8NM/1JDa37qvRHp+0N24CiaGxnyRB/zi66DLcQVA1xqldf3a6Wqlzzw15fHa6H/5zXrEQLKQeFZDZpTSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757115850; c=relaxed/simple;
	bh=JB2AWdpd6oOew6X8rFejlh9xwJ6u6nBOdsCOLNmJ+Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTreQKwFUiT5CxETW05sLYSlMyKa8au3tNlJodZ3vMha6AH5Zr1TEdbRW3/J8Jvf7rnx12UGgLSsqmNK8BaDUOG+PouI0w1YD3eOX2hBLBysSLx8zYrGulQaS4oAaoumYxM91Ad8Y1NavvTuq4ALE5rXUb/mMcVz5Bl8dDdgtmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCOGK2Hg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF88C4CEF1;
	Fri,  5 Sep 2025 23:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757115850;
	bh=JB2AWdpd6oOew6X8rFejlh9xwJ6u6nBOdsCOLNmJ+Gs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QCOGK2HggWyHfRNIMvAHSZBel8NA3s+j0wOWpxTqBvFsBRu/HRYygjTRaAUDQnDsS
	 jHFBu/uae10GAq1xKndbHoepRwGgtRi24hQ+O+gPMyJzCI4HNqdCztp613XF36F/Sb
	 bCt/7HeC492vUtWTNlKeC+3Bs1kx/Mfk4sNlpOII2/9kwcTTVqAMjK4jvF90LH2bKa
	 hdmIw1m0M/9rAYWoZyD0xsJgAQmPLRFCirHH5YFt9t7pxYb9PQWG1DSJm1BdtbQwt4
	 3jTnBviihlco3zAdb6f6I5d1WR1sNUczi4OjegOu/8drZZtTmSWTWi5X/HeUJIv6Bk
	 8JahsVS1pRAbg==
Date: Fri, 5 Sep 2025 16:44:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 jdamato@fastly.com, kernel-team@meta.com
Subject: Re: [PATCH RFC net-next 4/7] net: ethtool: add get_rxrings callback
 to optimize RX ring queries
Message-ID: <20250905164408.5a87a0f8@kernel.org>
In-Reply-To: <20250905164253.4e9902d2@kernel.org>
References: <20250905-gxrings-v1-0-984fc471f28f@debian.org>
	<20250905-gxrings-v1-4-984fc471f28f@debian.org>
	<20250905164253.4e9902d2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Sep 2025 16:42:53 -0700 Jakub Kicinski wrote:
> On Fri, 05 Sep 2025 10:07:23 -0700 Breno Leitao wrote:
> > +	int	(*get_rxrings)(struct net_device *dev);  
> 
> I think this can return u32..

Two more things, actually - get_rx_ring_count would sound a little bit
more in line with the get_rxfh_*_size helpers. And let's put it
somewhere closer to the rxfh callbacks. It's actually mostly used by
RXFH AKA RSS code.

