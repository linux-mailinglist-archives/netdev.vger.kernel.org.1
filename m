Return-Path: <netdev+bounces-137239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E22339A5107
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 23:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDB61F213DE
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 21:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC991922FB;
	Sat, 19 Oct 2024 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kclr9u9f"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C6F155398;
	Sat, 19 Oct 2024 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729375154; cv=none; b=qnIA9UTAV6IC8Welmrps6UYk4VNBn39hNka7d+3tikA3LVyKwRwLA8cBe4YtUfp5TvyStK/ZJ5JVRG0f36K8jpDX3/3YrOGdDra+gcn0mYm5a+7fm41cxcG2fAoOuJHvfPZ3vM+TrCla6UEkCcB/Fev2S28w2cWVM2kqklKkKBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729375154; c=relaxed/simple;
	bh=yrD63VfEdcugHgSz6cVE0wf++PA5YPtODa3BZ4NeTlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3Hyp6Loo3NU2NLWKJ/JNfiLZE9b3bqecMz0dOCry6agg+YycxdPRHNuUr4i7biWkBQn1rqMbcbJnWqpPK49CzFwV/w1kTwujLp8O9qwmuBHddLSyZ2xnsZ39H0LeP6+DtMh5El3UeQ3D1iwXkjS0pSZeu/iRuyr69D+wx1SQfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kclr9u9f; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aVSnEAGht9JOBvdyIP8ZOD2Yn+/la9YFQuf3QOiYD7s=; b=kclr9u9fiD7knSA3p8YbbED/9R
	Z921HGax6acRFNM7cEr9cBnTGxZTkeH9iKa61ezAHFLB8h8Z60FDu7t7DUHEWn5w1dkX2piDJuVg2
	FrZ0n7iQKaSIMhbyoYC+hZaEkydv4SBSAo7Q2e3zNaycYP/yWEX96nO79Vq1GBbNvqmY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t2HTS-00AcgD-IQ; Sat, 19 Oct 2024 23:59:02 +0200
Date: Sat, 19 Oct 2024 23:59:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: fix unreleased
 fwnode_handle in setup_port()
Message-ID: <11c644b5-e6e5-4c4c-9398-7a8e59519370@lunn.ch>
References: <20241019-mv88e6xxx_chip-fwnode_handle_put-v1-1-fc92c4f16831@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019-mv88e6xxx_chip-fwnode_handle_put-v1-1-fc92c4f16831@gmail.com>

On Sat, Oct 19, 2024 at 10:16:49PM +0200, Javier Carrasco wrote:
> 'ports_fwnode' is initialized via device_get_named_child_node(), which
> requires a call to fwnode_handle_put() when the variable is no longer
> required to avoid leaking memory.
> 
> Add the missing fwnode_handle_put() after 'ports_fwnode' has been used
> and is no longer required.

As you point out, the handle is obtained with
device_get_named_child_node(). It seems odd to use a fwnode_ function
not a device_ function to release the handle. Is there a device_
function?

	Andrew

