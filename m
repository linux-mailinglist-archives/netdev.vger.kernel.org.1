Return-Path: <netdev+bounces-155539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53601A02E8E
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9CD18863E5
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F951547F3;
	Mon,  6 Jan 2025 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HPbvvjLl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E813597B
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736183066; cv=none; b=fDuyVpyer9RfA5b/eM8EpMHmzQSqR2AKm+88Chsg3iUPHdwI3zatXKATj8zIIvtz4Q327S3yPTs7no7cr1RA9ymjkvw6yMYjMfE9Fs8/M1wCS1d1wAvNJT+RfwTQk+WcaAzzrtNDk2F/txkfiQAAaN7znE0I8Up/7u1k18x0OTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736183066; c=relaxed/simple;
	bh=UuizxQ3empmoGKFJyowvtL9O/US7z/8yp01wDmUechE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecJx4lK1Ba0ZOsu/WQWEL5BvhROtuWCu1HaiosXfkn1iWnA9TnUNOMfGA4LgO2tWJsGWReM6Qw+R63gwt7kTl9YCdZoTjfEuU4kO+PKeRGKQ/66q5mHxUfFVm8WbTjW3ENe7jcDGbt3C63ggIQTJYbX5HxJIN4xDMsFy21nLGVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HPbvvjLl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KL3AKJ2+DZ+9z5bBIltaAldHFwbwaYtHrCuhGiI4EJk=; b=HPbvvjLlJatAB6mq1bcjXWIWDm
	N9uXJ+Vf9SeyrJD27mWCo074zmyb8wFCDDd9FEFdIIwjzw1piL17W5NgbF14yKDX0a5JQMLk7qhpj
	5qvCWNPrVCdvo/TdR885LeZYKYtMHrTHtqrBBUNpyWp91S0YHV0xDAZyTdHLN0MBo9bc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUqWU-001wKd-4n; Mon, 06 Jan 2025 18:04:14 +0100
Date: Mon, 6 Jan 2025 18:04:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 11/17] net: stmmac: move priv->eee_enabled
 into stmmac_eee_init()
Message-ID: <e1f9b24b-d31c-48c3-a4a1-6599f7a81148@lunn.ch>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
 <E1tUmAt-007VXh-TZ@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tUmAt-007VXh-TZ@rmk-PC.armlinux.org.uk>

On Mon, Jan 06, 2025 at 12:25:39PM +0000, Russell King (Oracle) wrote:
> All call sites for stmmac_eee_init() assign the return code to
> priv->eee_enabled. Rather than having this coded at each call site,
> move the assignment inside stmmac_eee_init().
> 
> Since stmmac_init_eee() takes priv->lock before checking the state of
> priv->eee_enabled, move the assignment within the locked region. Also,
> stmmac_suspend() checks the state of this member under the lock. While
> two concurrent calls to stmmac_init_eee() aren't possible, there is
> a possibility that stmmac_suspend() may run concurrently with a change
> of priv->eee_enabled unless we modify it under the lock.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

