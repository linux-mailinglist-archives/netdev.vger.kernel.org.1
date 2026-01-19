Return-Path: <netdev+bounces-251150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0729CD3AE6C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E060300101B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E892387370;
	Mon, 19 Jan 2026 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MC4ly2iX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79E237F74E;
	Mon, 19 Jan 2026 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835376; cv=none; b=XrazvaoQ6+zfN11CPyZHj2vyL8fbrd599DhiOOkU8yDlqj1wStx0bYQLE/ABuycrGlAcqd48FhMvNJMiEOFPaOxCCDoNCEgqsKpwZei7ZQJ3NKm3EipDRNZp20d3n+9+jz53A1/uPlgi3vqrvSoT0NIsG5WEqAd60sTKVdliFQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835376; c=relaxed/simple;
	bh=76alY5Qj2iPAUaMuzypXkuDTBKlDNOSjJAbCo63xZTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6fspTNeM3G6zF908AZJVAIoYlcgfr/c7tvthgPK5kZ//qfiH1gIM8H18+dLCaMyLoipcpeAjMsQjO/nD7WYth9m2bqdn+vkC11Phs6tbjPoeRzM+MT1PUO3TzwD720jKWkx6FysygBieGC8HAuMC/IWdgDUMqwK58Cmhg4Gqs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MC4ly2iX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=34ElnxDRQbNZrGi1RSpU0QbjEZAsJP9D0opkzbG1cjM=; b=MC4ly2iXpNquh53DTz2ysfgs+h
	krl7wIQO0oWIql0odQRzCSD1domNspeN+8kqQEA4dez2UFKN/DZDiDQVHb/DZSyuRqETDW1H2MYMi
	HLMUq0zmRseIN3UQhmAdpsug8euvRvmc96ilA8C9pnCeVmaeZ4WosWPTg7WE2YzMjSCA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vhqsT-003W6M-VF; Mon, 19 Jan 2026 16:09:13 +0100
Date: Mon, 19 Jan 2026 16:09:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: wangruikang@iscas.ac.cn, andrew+netdev@lunn.ch, davem@davemloft.net,
	dlan@gentoo.org, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org, pabeni@redhat.com, spacemit@lists.linux.dev
Subject: Re: [PATCH 1/1] net: spacemit: Check netif_carrier_ok when reading
 stats
Message-ID: <48757af2-bbea-4185-8cc9-2ef51dbc8373@lunn.ch>
References: <e3890633-351d-401d-abb1-5b2625c2213b@iscas.ac.cn>
 <20260119141620.1318102-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119141620.1318102-1-amadeus@jmu.edu.cn>

> root@OpenWrt:~# ethtool -S eth1
> [   71.725539] k1_emac cac81000.ethernet eth1: Read stat timeout
> NIC statistics:
>      rx_drp_fifo_full_pkts: 0
>      rx_truncate_fifo_full_pkts: 0
> 
> I just discovered that adding "motorcomm,auto-sleep-disabled" to disable
> the sleep mode of the MotorComm PHY prevents the problem from occurring.

This suggests that when the PHY stops the reference clock, the MAC
hardware stops working. It needs that clock to access
statistics. Keeping the clock ticking will increase power usage a
little.

I wounder if anything else stops working? There are some MACs whos DMA
engine stop working without the reference clock. That can cause
problems during both probe and remove, or open and close.

So it would be nice to have a better understanding of this. If this
turns out to be true, maybe a comment by this poll_read_timeout()
indicating if it does timeout, the PHY might be the problem.

	   Andrew

