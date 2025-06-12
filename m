Return-Path: <netdev+bounces-197078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65496AD7740
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA70173516
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06E829B200;
	Thu, 12 Jun 2025 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r8I42CbG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C20299A84
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743536; cv=none; b=s+Mhe/GHF3d3gF7Fo1TPmhDqJJREstRZoz5galIzLFjXBjOzHlCP79Luy4oYEk1Nphw8ITwbW9cyKJvFXLY9Gs2p2J7qjLovQHzdApwVRzaYTdhqRfMn8BWB5QIoQSumIHGBdl9q+WdxfU6wukQnhp4sCoc733KioJv6AZFmNtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743536; c=relaxed/simple;
	bh=05K8sF2afmFeFqWrQsAsYfXZ/ssELJRoJefvZcLllmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNTwsWPJ3xK0SRhs8CbR2lSrkt05TicYrsRwppDFp7VAqmPH3pJ5xcl2Ui38a1xYAR97YTwo3s8q0EEWmqNo93a3jSnSEcg82Ct+ymF5UrM1Zp2BoW4Xg93S/XvYh2sSWvMcUq7l6s9C7TxTNzufvMR2iBxpJgFQywctN+YAlIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=r8I42CbG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5LaGnFqvR1wl2qKxehQpdEmDTUc14ihv8MkUpsGD81E=; b=r8I42CbG3KmgA8m6yGXn09zbH2
	VoNW3CfmhK+FQ4PFds4ddyg3xSmwAlteVx5ggFiJCJOynYqI774/qNLarQQWs6MOLWAZDCdT4weho
	+DO2muzKIIMg+UpMkpP9i2CaaKqQdFFqcz3WW+35sh6wpwcrq5ltNxlmp1fkY36PPb8Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPkDn-00FZFl-BH; Thu, 12 Jun 2025 17:52:07 +0200
Date: Thu, 12 Jun 2025 17:52:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 7/9] net: stmmac: rk: simplify
 px30_set_rmii_speed()
Message-ID: <76f78d75-f2a0-499d-89ea-5497f7526062@lunn.ch>
References: <aEr1BhIoC6-UM2XV@shell.armlinux.org.uk>
 <E1uPk3E-004CFl-BZ@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uPk3E-004CFl-BZ@rmk-PC.armlinux.org.uk>

On Thu, Jun 12, 2025 at 04:41:12PM +0100, Russell King (Oracle) wrote:
> px30_set_rmii_speed() doesn't need to be as verbose as it is - it
> merely needs the values for the register and clock rate which depend
> on the speed, and then call the appropriate functions. Rewrite the
> function to make it so.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

