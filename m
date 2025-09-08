Return-Path: <netdev+bounces-220901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62900B496B6
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 19:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA6A1C22E65
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 17:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3A13126CF;
	Mon,  8 Sep 2025 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tXJiT6Wz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC923126DB;
	Mon,  8 Sep 2025 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351547; cv=none; b=HXhsY37pwfUs447A1y/4nGh8RDcQG3hb8vZQt1cJmelPaIBdPQ9BTsJO3yYWtCVPUZJxqDJBJc26qMGN9CmJzJLKPy8ud6l9XgR3YYHrgdb0LE8R+tjSyHgCyos2UpzwOh0J94lxSBiNlOvUAd/+rpH0NxPumMdGp6amr2FaLgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351547; c=relaxed/simple;
	bh=ZvP4OnQH72PfeD5n51nMs5ezvAhIg30DdTxn0Qi+zas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzvdW9wEQI0CbX3OOc8wIal7OApi8chKsgtqR3hyVR1yFS7ivB0QZBz3enV5PPIBRjJPYSjFDbYNiyS3P2ltoTOR0yvVWYBZnSnm3muV1GKaanBYTdNLuQ7NGz35DQnytbbCrWjcqavsFlfmPj421tzFiT2dsoQ2LjXoajsxoqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tXJiT6Wz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TXCXwC0NDhsYs4wYTRdLYP6UMuK48KjRi9lZKZkCh/M=; b=tXJiT6WzQ7bZSgk76/O9gekcHY
	0Lwd1fiXRG8WaYL1WhtKNysifQf06+gwavdy4OzmR4kpz4XMtGfHNJJrDFaXjrKwBQ6T5ZNpi7xIS
	5BU0RdWUvDUAAPbQcZW/rUk7QJ4TUxPQ0mdpI4VSeJ374yQpeKSL0T2YF87Ik7g/rjAg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uvfPZ-007h8v-3A; Mon, 08 Sep 2025 19:12:13 +0200
Date: Mon, 8 Sep 2025 19:12:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yangyu Chen <cyy@cyyself.name>
Cc: netdev@vger.kernel.org, Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: atlantic: make RX page order tunable via module
 param
Message-ID: <802c483c-c203-4546-bda5-1337e02dd632@lunn.ch>
References: <tencent_E71C2F71D9631843941A5DF87204D1B5B509@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E71C2F71D9631843941A5DF87204D1B5B509@qq.com>

> +static unsigned int rxpageorder = AQ_CFG_RX_PAGEORDER;
> +module_param_named(rxpageorder, rxpageorder, uint, 0644);
> +MODULE_PARM_DESC(rxpageorder, "RX page order");

Sorry, but netdev does not like module params. They are a bad API to
use. Please find a different way to do this.

Also, there is a comment:

	/* Only order-2 is allowed if XDP is enabled */
	if (READ_ONCE(self->xdp_prog)) {

You need to ensure this assumption is not broken.

	Andrew

