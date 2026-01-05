Return-Path: <netdev+bounces-247093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A814CF4803
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 16:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24295310D774
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 15:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B646533858E;
	Mon,  5 Jan 2026 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0LeuMVSp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F65C334C1F;
	Mon,  5 Jan 2026 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627353; cv=none; b=qw7N3P246RoOQMokV2HoJ7iATmMRTrwpn7N9g8xiDEqC4bOfPBAcSSQbYZqzO5D1W4QTwgJYleOavygLe6AHFBu46d4GrZ2de42sizUMlMHVp4klayMT+PCYYebT99wymUqXpodNjYj2gvTDIIn/j8tLkHvoxez47LKH3pjwJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627353; c=relaxed/simple;
	bh=1MTChmLrOZUO1PTrEDIoithmlLSAZlsyb/4VWReOOXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBrUry0JidEek7X1kZjsOqWQsdu41zXe5CbD8tr2ntdLbO0hCOch+SawBlbxKJU10mvmDYkYVsrzwko96dSlL/93k+sMmB/jCapO1AkrluceEofuN0QRGuESSfZuYInQ7xShiZ3O7IFBv/0mQ2VOnhd5n4ORj8stQDsbSEcBhEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0LeuMVSp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=K7yq1732eMKsor7g4md0pKiQDNOJcbfUwif3tEqKzAE=; b=0LeuMVSptPSn/ReUPkVg0wSrce
	YgsRflqh8J4MIf3nMliqMsxR8Ng+uuJcWbounPrNM3MV80WDj7bcPmvTwq3NHMBXk7f4uCPc2Iwpb
	JQBftAqQ2LoqBjKlDZla7qj1qR0QoVrMBCxdvgc3AOM9F/0qjWogWNah30sD9dbxuhWI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vcmcO-001VC9-Nm; Mon, 05 Jan 2026 16:35:40 +0100
Date: Mon, 5 Jan 2026 16:35:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: fec: Add stop mode support on
 i.MX8DX/i.MX8QP
Message-ID: <9acdb8d1-529e-46f2-8931-780287b8cb16@lunn.ch>
References: <20260105152452.84338-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105152452.84338-1-francesco@dolcini.it>

On Mon, Jan 05, 2026 at 04:24:50PM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add additional machines that requires communication to the SC firmware
> to set the GPR bit required for stop mode support.
> 
> NXP i.MX8DX (fsl,imx8dx) is a low end version of i.MX8QXP (fsl,imx8qxp),
> while NXP i.MX8QP (fsl,imx8qp) is a low end version of i.MX8QM
> (fsl,imx8qm).
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

