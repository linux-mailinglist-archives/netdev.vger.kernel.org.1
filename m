Return-Path: <netdev+bounces-171842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ACEA4F107
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 00:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB56177EC6
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 23:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D682D27BF75;
	Tue,  4 Mar 2025 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtGsNGkA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A929D2780F3
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741129140; cv=none; b=Q61R/zGD48XCOeq3N/UMU+mvDy8lFyIlLyfHylpAj6N+kw2v9xx9jOB/llkmYwburXnY+BBUS2zBrQg3D9LYlWoEbqhXFDAdFlqMZlPIlzDtRZjE2FJoVTbtQo7MtMa07vUJs30SFhnopYgp5Jqr8JmbdWypxaWK1m2Rp8e3cuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741129140; c=relaxed/simple;
	bh=0kAVCLYLBZpcM6/MbGKciBJ6UynpnoUON0CNNgy8EK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBu6U/0DJ7Ga1MBz+BQApDcazyP+W4EL8Yk8CYMA0hptIEtJhbGaFwjTdGwS1t6M6CASN8eyGU1U/J928+9Ktl/XJcFBfXKo6dOUh2dN3tqdgXdwnpHxjyb05FHExrbO3a9T6GU1kV/eXVG3U07Yt56M2AaDr+/T0VjGBCueTbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtGsNGkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D16C4CEE5;
	Tue,  4 Mar 2025 22:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741129140;
	bh=0kAVCLYLBZpcM6/MbGKciBJ6UynpnoUON0CNNgy8EK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YtGsNGkAK25FoS14vUdhU/8MRMVW2DRl8MWHCh39T3IkDwXg10I+N/+QYsRKe2gWH
	 WEnqsSnxduGPTAtzKgEDYiadODLea5dd5jfdrp/qWqLmlHGVv6ioJPYQ9SzYqrSXPp
	 ZWG8znXj9B2zzIlI9imdd1wNwOONwchKrDsMApPX4v4my2K9C6Zt7bW57GqDiarakb
	 kYflZb71Lz+PpssuIvd8JNYn0ZEBNNq7cexSRBjBKtzBXtBlSbOgW06bYW9M4cNeYQ
	 houR56Uts3a4SUXafTCDiHO8o+G+FqLlIO6EIYBjFTXJQQxR3Vm4Je7gmz4r9XeO//
	 8+UKZ4FJdiYcg==
Date: Tue, 4 Mar 2025 14:58:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Arinzon <darinzon@amazon.com>, David Miller <davem@davemloft.net>,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.com>,
 "Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
 <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
 <msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
 <nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
 "Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
 <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
 <amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
 "Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu
 <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v8 net-next 4/5] net: ena: PHC stats through sysfs
Message-ID: <20250304145857.61a3bd6e@kernel.org>
In-Reply-To: <21fe01f0-7882-46b8-8e7c-8884f4e803f6@lunn.ch>
References: <20250304190504.3743-1-darinzon@amazon.com>
	<20250304190504.3743-5-darinzon@amazon.com>
	<21fe01f0-7882-46b8-8e7c-8884f4e803f6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 22:07:39 +0100 Andrew Lunn wrote:
> I've not been following previous versions of this patch, so i could be
> repeating questions already asked....
> 
> ena_adapter represents a netdev?
> 
> /* adapter specific private data structure */
> struct ena_adapter {
> 	struct ena_com_dev *ena_dev;
> 	/* OS defined structs */
> 	struct net_device *netdev;
> 
> So why are you not using the usual statistics interface for a netdev?

I asked them to do this.
They are using a PTP device as a pure clock. The netdev doesn't support
any HW timestamping, so none of the stats are related to packets. 
The PTP clock could as well be attached to a storage PCIe device. 
In that way it's more like the OCP PTP driver or other pure clocks 
in my eyes. And such drivers use sysfs, given they have no netdev.

