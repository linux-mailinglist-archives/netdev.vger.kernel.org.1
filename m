Return-Path: <netdev+bounces-99205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB418D41A3
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCFE2862C8
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 23:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB6E16EBFD;
	Wed, 29 May 2024 23:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VOWffBz4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C716715D5A0;
	Wed, 29 May 2024 23:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717023771; cv=none; b=TMGNG2vVeBDgPphewE01Ssu2bfBxGNfL1HouchnBw1iyuRHkmxQgKyMNE4D3m8CDKaUxMDDEPXDe88At6LTD8xa/GJI2qe6kXVyHwwcwlz5eFy4ds3DtcJ+wFTwr9BbX4XdDiVVk9j9aH8iGxYKfY6/KYnVv4AHsnpMHPqY1Plg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717023771; c=relaxed/simple;
	bh=Ki6OB4kf0d+GQ3AEcaw1nNvdeZ0HvyOOaDOYtve29L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJby1JRCpApU/Knm6VTDz2sPkT3Yhgn25C4/acCC9Ao/2FxLwAdX5FycUo4SdQqZhTMtqPCysVh64fr+qv1cb2nhSz1bCIrcqnCoA3cIMuNLtQIovWdxwoCU4LUfYAO6jmv/qVxbbvk1S/sGp00aSDy5nJvjCUwSi5Zts6iJIY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VOWffBz4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NaqPsF+YNHjwUDf2w9rBdP367AFBYc/O3af88711Nu4=; b=VOWffBz4rAP4fZi7xgoTgXlzwV
	RYdScfYw3LtW64Vt2ZRc6z7jvmHxM0Ed9C8p+BAqiiCwboGFLT8Kpf/KhJtVSIE5MQC9lxjcjL4nY
	37FQfzRc76zBcltN0Pk2q3srKsS9F1Yojw5SaNSJwWlvC19ZE4ot83Rw89980UOh96r0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sCSJZ-00GIaB-AM; Thu, 30 May 2024 01:02:37 +0200
Date: Thu, 30 May 2024 01:02:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH 1/8] net: pse-pd: Use EOPNOTSUPP error code instead of
 ENOTSUPP
Message-ID: <1e80a2aa-fa3a-4f90-ae43-d4e91e4fa80f@lunn.ch>
References: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
 <20240529-feature_poe_power_cap-v1-1-0c4b1d5953b8@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-feature_poe_power_cap-v1-1-0c4b1d5953b8@bootlin.com>

On Wed, May 29, 2024 at 04:09:28PM +0200, Kory Maincent wrote:
> From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
> 
> ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP as reported by
> checkpatch script.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

