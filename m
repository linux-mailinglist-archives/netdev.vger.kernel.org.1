Return-Path: <netdev+bounces-110260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8760092BACE
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 132A0B20C55
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48876158D8C;
	Tue,  9 Jul 2024 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lfTJcDYt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35401EA74;
	Tue,  9 Jul 2024 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720531018; cv=none; b=rYJV2SDge7k9zdwzZYabEKkUEwO9uep8qctqrI4zVTVAsSap0J9h2kGSVM/ctJnXVMzW6Fnqd4UPHX88ucezpHklgG3f2+uhrnfcGF0chZYAwxE/CrMCGyksrIS9wKPIsMB1MYpUF2u+Sj5XXEWth7JemgTMurRi2aGz1HhZQuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720531018; c=relaxed/simple;
	bh=LBHj/lmAAuRIE/ymNS/ChF/AvZS4COSXWYa+xV7YDIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTxEI1CmB/1vYlZILXUMGRCiWaO21aS2HUoWTsSQKuAWvEV4wYO5bpK1QvAIQ0kccYasHzD+xL6gN2pfWbrYEN6//eMfran003Lu9RZI8vyTiu7bVNpvpcA8xtMYRL+V65phZVEVIkZdAQUW6ZieZSKYnkIclnqZs84GBn21zdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lfTJcDYt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6qj/7oST3PJtaaqaVrHFeEu7E6uGuuTvs8tcQZzjNoM=; b=lfTJcDYt1nPiS507mjFeon+nBr
	3O1jub46inJ7gwEzXhbv51zwOVlpAiWACnUqFOZK2x3+crLKr+3gOzxYgU+B0BFcaKcKUVQgFvw2X
	YnYNPB7NdZXRTSUkIZLRETauhvW/Abqy0oMqcpJa11fASifUaX5joRKv6F6yEvXy4Ycs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sRAhv-0028xm-34; Tue, 09 Jul 2024 15:16:35 +0200
Date: Tue, 9 Jul 2024 15:16:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1 1/7] net: stmmac: xgmac: drop incomplete FPE
 implementation
Message-ID: <b313d570-e3f3-479f-a469-ba2759313ea4@lunn.ch>
References: <cover.1720512888.git.0x1207@gmail.com>
 <d142b909d0600b67b9ceadc767c4177be216f5bd.1720512888.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d142b909d0600b67b9ceadc767c4177be216f5bd.1720512888.git.0x1207@gmail.com>

On Tue, Jul 09, 2024 at 04:21:19PM +0800, Furong Xu wrote:
> The FPE support for xgmac is incomplete, drop it temporarily.
> Once FPE implementation is refactored, xgmac support will be added.

This is a pretty unusual thing to do. What does the current
implementation do? Is there enough for it to actually work? If i was
doing a git bisect and landed on this patch, could i find my
networking is broken?

More normal is to build a new implementation by the side, and then
swap to it.

	Andrew

