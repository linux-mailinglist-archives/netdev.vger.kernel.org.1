Return-Path: <netdev+bounces-197596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B938FAD946E
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 20:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63969173BDF
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B92A2E11B0;
	Fri, 13 Jun 2025 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BTeFuZPW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8D1757EA;
	Fri, 13 Jun 2025 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749839440; cv=none; b=XMFfJoTC4Z/pGFrpHtrkh8hqwm0tYEv/Mtz40sv1GMe1tW/F8F2q3D1kCRgy+j8bUqXOKE8AWWX+cvX9zuxdry6fMVVqBsKLnMVAGBzNUZEZkJbg0OfaY39gYuZwsZMoh7lnWalBVUUTd259BlXX6hoZfm6xsJcd0baj/06JVKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749839440; c=relaxed/simple;
	bh=XZQLn+HoJR/0FeiwkXYxiPLVSYLl9Ll/HtMmUW7rhzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtzsBNcpOp8LlqMjr8oDejKVSKwAmo+fwGw49QHNmfgZpjyZIay3z05Dj1kPia3GXbDfGNFkwGt/1Yw8cFji+OSwUMExSgX8+9PmWbNiqXAm65gnufM6/r12lmgjh3pgx5Q1JTPKa+mlo5li4gbD1t9NBgxBlgcY6simQQ+SDF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BTeFuZPW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=paNCNvp4BgQN1E3xRGQ5/dNU8wg6xvReIPZ5+6tjq5o=; b=BTeFuZPWYoQB1Ho4/KW8eoihcL
	mj0KBUiyZtxkiyBplin5zmyxooCRUU4LHBbNx8kyh8NCg3HvVh6BYmLpCj/gLR9c/6+ltQe+iKt/i
	eCTnFIB5niTsheCgqugvmsb3iTRlZ5XfKbTdIMa/AfG2ylK0ohGWSyZMJ9PJlHr0v6Q4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uQ9Ae-00Fkv9-DZ; Fri, 13 Jun 2025 20:30:32 +0200
Date: Fri, 13 Jun 2025 20:30:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next v2 06/10] net: fec: fec_enet_rx_queue(): use
 same signature as fec_enet_tx_queue()
Message-ID: <30c3f258-1eca-4cba-9999-1059cba219d7@lunn.ch>
References: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
 <20250612-fec-cleanups-v2-6-ae7c36df185e@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612-fec-cleanups-v2-6-ae7c36df185e@pengutronix.de>

On Thu, Jun 12, 2025 at 04:15:59PM +0200, Marc Kleine-Budde wrote:
> There are the functions fec_enet_rx_queue() and fec_enet_tx_queue(),
> one for handling the RX queue the other one handles the TX queue.
> 
> However they don't have the same signature. Align fec_enet_rx_queue()
> argument order with fec_enet_tx_queue() to make code more readable.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

