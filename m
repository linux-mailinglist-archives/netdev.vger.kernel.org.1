Return-Path: <netdev+bounces-186730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABFBAA0AE2
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 13:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B2F3BBDA8
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0DC2147EF;
	Tue, 29 Apr 2025 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Qu3uNUA/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905E71B040D;
	Tue, 29 Apr 2025 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745927705; cv=none; b=kXRwrH5o4yyc0BymaN8dQDv4qwD0Nd3n6D8pxX64Bx/7G8XniJDDANFQUDVaVTEY/x641hQt/sEEqE/gDGyu0MqMIlvSqb1NRoE+YnE5Uq0GUMIY0W0cxlF/g9eJYC6oBT8GQdUZxBck3otk938jO+JJYI3CqEorwnyQ6n+N+vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745927705; c=relaxed/simple;
	bh=+rNyKIl/RBZ5aP/MltKedW1NnaUhMihaKYwfC3GhJNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqctvQ0kxgWSdlwbnxYLknSmbTfRIoRoyzz5toPqg88Lnp7UFCMVLKifNnpTCh/CCawYWEr0SWENWKXJrtXj+08Dp75rigsK9rznRlZQiM5k8YXr3g9+YJ7bEFQTJ2yFMgpKWaG0TI0/ed6N9Gb1Y5BuTun7SXDKw7vUb2Doksg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Qu3uNUA/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Bu4ZHz9O9QAPTcYBsVBqDb2/neVtowMeWzeBjt2mIy8=; b=Qu3uNUA/WAb4oeHv/xwttmfHX1
	OK0eFQObYXoKIwkj92J/xfHxUWQ+0xgDu2MnK6SB8oSgT09OlL0c+ISsqh3xLgCNstGyPj4Chtp6k
	izzHzoWJpWNm0LnaIkSF8ow86GF8a+bV18SBS3xzALAwzrGDT5UbNXjvVM8swanZWfMg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u9jXs-00Avsd-GF; Tue, 29 Apr 2025 13:54:40 +0200
Date: Tue, 29 Apr 2025 13:54:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: mattiasbarthel@gmail.com
Cc: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, troy.kisky@boundarydevices.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mattias Barthel <mattias.barthel@atlascopco.com>
Subject: Re: [PATCH net v1] net: fec: ERR007885 Workaround for conventional TX
Message-ID: <d77b4361-2ff4-4a3d-9506-354c054ae3ca@lunn.ch>
References: <20250429090826.3101258-1-mattiasbarthel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429090826.3101258-1-mattiasbarthel@gmail.com>

On Tue, Apr 29, 2025 at 11:08:26AM +0200, mattiasbarthel@gmail.com wrote:
> From: Mattias Barthel <mattias.barthel@atlascopco.com>
> 
> Activate TX hang workaround also in
> fec_enet_txq_submit_skb() when TSO is not enabled.
> 
> Errata: ERR007885
> 
> Symptoms: NETDEV WATCHDOG: eth0 (fec): transmit queue 0 timed out
> 
> commit 37d6017b84f7 ("net: fec: Workaround for imx6sx enet tx hang when enable three queues")
> There is a TDAR race condition for mutliQ when the software sets TDAR
> and the UDMA clears TDAR simultaneously or in a small window (2-4 cycles).
> This will cause the udma_tx and udma_tx_arbiter state machines to hang.
> 
> So, the Workaround is checking TDAR status four time, if TDAR cleared by
>     hardware and then write TDAR, otherwise don't set TDAR.
> 
> Fixes: 53bb20d1faba ("net: fec: add variable reg_desc_active to speed things up")
> Signed-off-by: Mattias Barthel <mattias.barthel@atlascopco.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

