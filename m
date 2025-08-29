Return-Path: <netdev+bounces-218367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B57B3C375
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 21:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA435174052
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 19:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FFA242D9D;
	Fri, 29 Aug 2025 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q0q1XCc+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4452566;
	Fri, 29 Aug 2025 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756497366; cv=none; b=RPb4ZK9UUpkM5nBFiltrs/5UOSzp9UFdPjGcakDTCecj0yFTo2CAYBVLLuukOGA0WR4S8/DpWyozhe7ivjX3tNUbhiDF/QxC4xLpXtp5FhP2xxYF+3s3U2oU0pIvsYIZQsPEwB9DcoId8zD1ldYAy03QUCue3gMCCO7Lz8NZ7to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756497366; c=relaxed/simple;
	bh=A3A3aF1R2lowUvenwhS7OWZI5YA6aw9UxDbAPid2PFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eadsOss3x+jVtTHNGogLAe0AhD9FppVkL72kOSSBjedHpDqVOcESHXd9Z9x5w1DPjFLk1SHMQwIKGYUrhh+y3hCmc1rMnf8HZJy6I7FJJHNmnnIBuJpiyvCAAdv/TOFCMu8oI5V5TuczsLD+zQ90z3nQbkTrQgvsXxii8XFgcEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Q0q1XCc+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KKLghzmewlqrbz3omzcx1pAoI3gSKvJa6gMHpz1XKh4=; b=Q0q1XCc+QOmHGO4e0vcHZeZbeN
	ZHpkQpEHxzNc1mrLEce54ABqjB3SMWV37E5CcOS37OeyudnaBr6ZBkXqtXHE94jjA63lupJ8dNZD9
	WCh/j7TCqhZxZoaPcD3PXeIxwU2WJ4VeztfQ2By2pjYCbPxr5KZoopq6h4zSc7/q9Sqs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1us5CS-006WJ7-M9; Fri, 29 Aug 2025 21:55:52 +0200
Date: Fri, 29 Aug 2025 21:55:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next v2] net: stmmac: use us_to_ktime function to replace
 STMMAC_COAL_TIMER macro
Message-ID: <75da63fb-c658-4595-86c1-847590ba68b7@lunn.ch>
References: <20250829064722.521577-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829064722.521577-1-zhao.xichao@vivo.com>

On Fri, Aug 29, 2025 at 02:47:22PM +0800, Xichao Zhao wrote:
> Removing the redundant STMMAC_COAL_TIMER macro and replacing it
> with us_to_ktime enhances standardization and improves code readability.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

