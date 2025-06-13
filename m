Return-Path: <netdev+bounces-197593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD70AD945D
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 20:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED027A8470
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0681B22F16E;
	Fri, 13 Jun 2025 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="c9ZM26sB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B351BEF8C;
	Fri, 13 Jun 2025 18:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749839048; cv=none; b=avR3AhK8hyDZE13pG0Gr2iDUZwVT6XSp1GOobmfQIXZGc3o73HhvwqBwfGx/ZgegefaAKAeu7mWOW4MRo3wNVst+58UKfCBWB8MYB41T4A3TqtYxJs3pHW893nq47LDwJPJnjbpcwcVIpt5joP0/Dgcetd095beDuQ1Y2trzCo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749839048; c=relaxed/simple;
	bh=0OMn+Hdxxyi+TFzaXKXgdz4Hs89BdPgdLrH1MYvTjqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBwP51kRhPLoY5UDEDeufGZAuCJ0nY2tuaLlmGjc0BDYdYP/Tm/Z/wFvC5HkF8isq4eYhOcWo8A2aVZ/U2nSJxl/eHTepc8m63jlJ/G8ZEak1LjwVF7NTFns00aRKxZB6RFZGZm4Brafj6iwBdCiC+NE947ujvkUjhCe+LzTiXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c9ZM26sB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mYb4qkiaORzrZtR6dVcN12J6FjA6lM+lNEPJwDgOfEs=; b=c9ZM26sB6ErCD8pQVG2GHcrc5x
	Ousgq+nJrjSHuIjmQ1CAg07QTGVRgJ1IbDFmkuQIdLJDBsxezyGzAKX+gDe3ElIsamy2GzZpHWfUC
	6DbaZxnz+JhKHUshqd9u+sAFiuOEylpeq9GxlDczSRyH3WT42YHr/cDzN37W0vTZ7T48=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uQ94K-00FkrT-NU; Fri, 13 Jun 2025 20:24:00 +0200
Date: Fri, 13 Jun 2025 20:24:00 +0200
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
	kernel@pengutronix.de, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH net-next v2 04/10] net: fec: rename struct fec_devinfo
 fec_imx6x_info -> fec_imx6sx_info
Message-ID: <8d1bb689-97a4-41a5-bf96-d840ce86172c@lunn.ch>
References: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
 <20250612-fec-cleanups-v2-4-ae7c36df185e@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612-fec-cleanups-v2-4-ae7c36df185e@pengutronix.de>

On Thu, Jun 12, 2025 at 04:15:57PM +0200, Marc Kleine-Budde wrote:
> In da722186f654 ("net: fec: set GPR bit on suspend by DT
> configuration.") the platform_device_id fec_devtype::driver_data was
> converted from holding the quirks to a pointing to struct fec_devinfo.
> 
> The struct fec_devinfo holding the information for the i.MX6SX was
> named fec_imx6x_info.
> 
> Rename fec_imx6x_info to fec_imx6sx_info to align with the SoC's name.
> 
> Reviewed-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

