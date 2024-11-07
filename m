Return-Path: <netdev+bounces-142965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CDD9C0CF7
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988DD1F23ECD
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38926215F58;
	Thu,  7 Nov 2024 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fcuL6baI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4878C6F31E;
	Thu,  7 Nov 2024 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000855; cv=none; b=MAGDUZ1seN6mELz+D82/BOVzF9h3G3r+lt0XcP7DnEiSFBYtkfHVV033nh12dFM6/snOiRwlzr7Adp5OWn/wf4u/9J/LMKIXYpm2nzhtRe5oAsQtUY/DbwiHRQQjE/FkF3K666SdOpBnMazmHbTmIcFndzneW3BVSL/Iw+Ay9xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000855; c=relaxed/simple;
	bh=YYSC3XP+Xu1i5ChZO0iBo/vwS/a0BiSV0IuwAD/KvkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t91w9Fi9F2/y1MAPn7WMJT0S4VyaStoNyshalWpdGcZ1RyhCQr9gxLzwAyOLqtpLhPtXavjaXoiQiAthCLNtdzi/wuJ0bsJDjkwsLyVEIrS9CZ/y77gAqhvPNBf1wiT+tzpTBqofh8TeKGp3MwlTwt9n2EeHpf2q632rsqlGCss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fcuL6baI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Pkgq+RY7AQPvFR+4KdxNeNkDDn55db16uRcxckizCKs=; b=fcuL6baIaAxRq26mnxgBtCe6ga
	YpGmAWy6fOBBWxtoCARbREs+MQnMmsPmOaxRn4F0W176w3I6JONIcWfZYIVL8ZV+D/CZgQsL61QaZ
	fW+EEd42GoN/Inf9s7zdd0vQwlg4rC6Id2GR91KWmBjdwO9bYg8DMSoWMa0Ibr0QJaM4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t96OP-00CUOy-KK; Thu, 07 Nov 2024 18:34:01 +0100
Date: Thu, 7 Nov 2024 18:34:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 1/7] net: freescale: ucc_geth: Drop support for
 the "interface" DT property
Message-ID: <d3b999f1-5e6b-444e-a579-b0af4a39caa6@lunn.ch>
References: <20241107170255.1058124-1-maxime.chevallier@bootlin.com>
 <20241107170255.1058124-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107170255.1058124-2-maxime.chevallier@bootlin.com>

On Thu, Nov 07, 2024 at 06:02:48PM +0100, Maxime Chevallier wrote:
> In april 2007, ucc_geth was converted to phylib with :
> 
> commit 728de4c927a3 ("ucc_geth: migrate ucc_geth to phylib").
> 
> In that commit, the device-tree property "interface", that could be used to
> retrieve the PHY interface mode was deprecated.
> 
> DTS files that still used that property were converted along the way, in
> the following commit, also dating from april 2007 :
> 
> commit 0fd8c47cccb1 ("[POWERPC] Replace undocumented interface properties in dts files")
> 
> 17 years later, there's no users of that property left and I hope it's
> safe to say we can remove support from that in the ucc_geth driver,
> making the probe() function a bit simpler.

17 years seems reasonable.

> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

