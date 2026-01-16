Return-Path: <netdev+bounces-250582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5350AD33C1C
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 18:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C349330213CE
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 17:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F786348479;
	Fri, 16 Jan 2026 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="07Fa+nk3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEFF21FF35
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583783; cv=none; b=N4mfEGc/Ly8eYfff/B2FQuiCPuSZMxcA3ORRLPX6ilsDTSmFQ++2mQ28sPq0hPRKRVp57j3AMK5gvpQ+25cDNHLVRrcDUYkmIUzC3hDv5kcFiRAgUcMjfTXg+iNHrDOw+Kr/a1FDFg5hnImwaFvdCrbm1pYojdMHp/wc8VL4cLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583783; c=relaxed/simple;
	bh=QZakKgMlJB3ZqJfEisSqfL/tfwtXNgut9U2tq1gx9NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMDP9Q815bJKylhOxyFc/jVtfc9SPS983UTgmnZFpK6szCpqeXnGUSpfy5PpQYaWG/eVkvVrqOjUdc/ozkjqpj2VfrcWGON4CE0PlsNhCbswN5zLYwcDhaJe/5SOu6oN1peaS4Y/lLlqwe7PcnIJSFr5+iRjWsWjGbf1f4RUkOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=07Fa+nk3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=x0ZJ6hNAp3es+pWQaJuIpYM6K/K/Nbp/iC8UR6BU5bw=; b=07Fa+nk3JCKzQVixoOBxDAE7S5
	hQ+cTaCcPGXPYyuAK+kMsUo9NrLpVMLEte7j20pbTRUuCbRDcGLorDqkJiEarMgocjcWpLb/Wmfan
	t6xmW9X5LOs6/aT+Wi8CrC8ltjBDwxJhT/Ro/rynnhtrvFfd2ZI2Wo0kmXQLyObOVM5w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vgnQm-0036AM-Ri; Fri, 16 Jan 2026 18:16:16 +0100
Date: Fri, 16 Jan 2026 18:16:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Valerio <pvalerio@redhat.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 3/8] cadence: macb: Add page pool support handle
 multi-descriptor frame rx
Message-ID: <4c74c2c4-7a47-45ff-be17-485e0702cc37@lunn.ch>
References: <20260115222531.313002-1-pvalerio@redhat.com>
 <20260115222531.313002-4-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115222531.313002-4-pvalerio@redhat.com>

On Thu, Jan 15, 2026 at 11:25:26PM +0100, Paolo Valerio wrote:
> Use the page pool allocator for the data buffers and enable skb recycling
> support, instead of relying on netdev_alloc_skb allocating the entire skb
> during the refill.

Do you have any benchmark numbers for this change? Often swapping to
page pool improves the performance of the driver, and i use it as a
selling point for doing the conversion, independent of XDP.

Thanks
	Andrew

