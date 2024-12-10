Return-Path: <netdev+bounces-150459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C98129EA4AB
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DE218890AA
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4FD136E09;
	Tue, 10 Dec 2024 02:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HGLJ0r6I"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E8D13959D;
	Tue, 10 Dec 2024 02:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796285; cv=none; b=CU+m0aqo8kZx4Oh5t8AdU6I1gdHrSolV5VF91tCCsgoev7BcKse/ZOgWymPWb6i0NH8dMLnY4RYEdVNTv0sGTKswieX1C/kQ6rmV2GuIiAOMEgVsYNK9qCBHswdYVphaIsOnzyMH1kmZf8I0sPK4LwFmFSTuOYdb/AwwTsxSFQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796285; c=relaxed/simple;
	bh=a7sTrcHZITQc14v1fBWxTeO1i4B3T9w5bEyRHIFBrLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luM1TQKCU3f2RimEIcFS+aRDIbMJuWdxAkUhmZBxtjL7WJ590IuQ0NdXHXgzLXhwe6Eaco8ZqL15fZAbD5Aui64D/cr6gw1yo5C1DkFThkwKlDSdMLW6VD8KSLvSTpOtXZ+sKhJEGnmFSRsEDeEtXThtTWKCjMdZaeSMQzU9SwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HGLJ0r6I; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iVu3dU21lp6tZiyps4adjx+PzV2uCgPAhkstxj/HbPA=; b=HGLJ0r6IwIP1wrRFd1O2MPj1zu
	JtXkvWzBz4DAguByO5VolpW2g1+Sg920zHZWjV3d+HG5CJuE527QQNhIjKnL/QRZM4IvtRyrMHMXo
	dHPhYdeO47cbWBoh9RcFOpmLJ6WaG6ZrBqcGZORIAo/s7vU0vC9jUlOsALQPjMP11iuw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKpc5-00Fk5i-W6; Tue, 10 Dec 2024 03:04:37 +0100
Date: Tue, 10 Dec 2024 03:04:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 06/11] net: usb: lan78xx: Fix return value
 handling in lan78xx_set_features
Message-ID: <b6dc9069-a473-4de2-ae54-b18f1f3a96b3@lunn.ch>
References: <20241209130751.703182-1-o.rempel@pengutronix.de>
 <20241209130751.703182-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209130751.703182-7-o.rempel@pengutronix.de>

On Mon, Dec 09, 2024 at 02:07:46PM +0100, Oleksij Rempel wrote:
> Update `lan78xx_set_features` to correctly return the result of
> `lan78xx_write_reg`. This ensures that errors during register writes
> are propagated to the caller.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

