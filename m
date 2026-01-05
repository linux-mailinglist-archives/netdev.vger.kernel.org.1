Return-Path: <netdev+bounces-247081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D04B3CF441D
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 15:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EE69308110A
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 14:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5534430C619;
	Mon,  5 Jan 2026 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vNd9gtlX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAE430BB87
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767624002; cv=none; b=Av4YI2VQKu7Dc7uM5x8T2dSQ55A5I312PckKdtLKmzXDyaTEUtM9xs7EYINO4wI5Euqeal9/RrOSuCqpFurwqmFD7FO2uH3C7csUsJYMxLRKlXNIl42noNdebR1Mi+iJG0NFhVyRh8MpR9K9zEh8DR0DHZkJkvA7zCWtbwsvjW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767624002; c=relaxed/simple;
	bh=vjFNYRWJGkVJ3JITIIJXEo+UOzybeciQjMM/xTsq89w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOXRGSczn+1wmpAGQiPKud490wDPNjx3RZmCBi9ki6uQSoGwqAZ30FTVrt6QYXf5UFXP14lEtDIXdAhKT/f7eGqTLFMQoLZ6PAY0PPi+QlV/9KLIVEdSUKd1LUNrjMYdziNvW6lV4fSHKkcRKmP5Jvd/oJSHrvUylZuitJkM1tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vNd9gtlX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sH2BS11CsTJutFD/9VrurXk2s2LBZ6kdX5ASQMnhGGU=; b=vNd9gtlX8t2rOLrGts//EekGYc
	s7UTMdBfem8Fcfm1s8AFPR6QDB+vgRai5z5jJ2YDOkZ81AT0AD1Ss0CWYbtBlaJgFx+8DkR5tYeIr
	PJ9CgxYassPbpFbkmRaUa3paRd7IAgZY7kXkXEqZFTajc4W2XU7TSY2xl31lOtyOGa5w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vclkT-001UrY-4i; Mon, 05 Jan 2026 15:39:57 +0100
Date: Mon, 5 Jan 2026 15:39:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v5] net: dsa: realtek: rtl8365mb: fix return value in
 rtl8365mb_phy_ocp_write
Message-ID: <c161c178-e4c1-4b71-beee-002407c28fe4@lunn.ch>
References: <a2dfde3c-d46f-434b-9d16-1e251e449068.ref@yahoo.com>
 <a2dfde3c-d46f-434b-9d16-1e251e449068@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2dfde3c-d46f-434b-9d16-1e251e449068@yahoo.com>

On Mon, Jan 05, 2026 at 09:41:50AM +0100, Mieczyslaw Nalewaj wrote:
> Function rtl8365mb_phy_ocp_write() always returns 0, even when an error
> occurs during register access. This patch fixes the return value to
> propagate the actual error code from regmap operations.
> 
> Fixes: 2796728460b8 ("net: dsa: realtek: rtl8365mb: serialize indirect PHY register access")
> 
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

> ---

This is v5 of the patch. It would be normal to have the history of the
patch under the ---. Please remember that for the future.

	Andrew

