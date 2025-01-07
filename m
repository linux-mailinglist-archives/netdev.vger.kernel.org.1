Return-Path: <netdev+bounces-155857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB47AA040FF
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B9216403A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF061E25EB;
	Tue,  7 Jan 2025 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M1ZAgJtn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B031E1C2B;
	Tue,  7 Jan 2025 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257198; cv=none; b=X8hVzKMdZnJ6HN/epHKjMlfb4m1cQ9m2E2fZDLLZ6vCAzp9JqvAO3HwFD1hI1xfopjuZc6oDoriLTM7BX1wqOWEFedPAL+GvDNv/B1LZ1jv5H91wbjtD4JvB9mpJdVxUiv0uTeSTvkoim1Re80f7BYdzGiYrq3pw607pTcMGelY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257198; c=relaxed/simple;
	bh=fc+rpQovhI9z6HNuLLy8SAZQh6kHqf94pndeUeLrhZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxxG3+1AiTxYirDJOWO2Hm6G/bpjAPokTF2GRPktJ/v2FDd0wNWzKF6jYT73/S6Zo60JFMHdRCklAeX3CrzfMYxKTXn0B2ozZXqKR7PW/9IArFnzk3Gk0SH1iA86vNeyX3Ty3Q9kER0KZHFVoXAVSKjl6PhzMui9wE6gvc8AbmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M1ZAgJtn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DPozk7f2ck1lekTyYQRxycAO00Td6kCk3wOh3bU6cO4=; b=M1ZAgJtndU1q5MC64JZ16ox9ak
	AZQZHJrhWTtBHgy930N2oaZiUwaukNGEmE+JgaqnSySdpI3hvC+mob32gUCqYws2w940neX/sy+zZ
	18mnFrmshJ0YZUJFUI7hG2yAGJJ1YmA/YRGrWv8n0HvSKgnkBSqZI4tObIfUXSHzZETc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tV9o9-002F7p-8S; Tue, 07 Jan 2025 14:39:45 +0100
Date: Tue, 7 Jan 2025 14:39:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v2] net: stmmac: Unexport stmmac_rx_offset()
 from stmmac.h
Message-ID: <0c190dac-dc97-404c-94e6-7a950dcfc8b7@lunn.ch>
References: <20250107075448.4039925-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107075448.4039925-1-0x1207@gmail.com>

On Tue, Jan 07, 2025 at 03:54:48PM +0800, Furong Xu wrote:
> stmmac_rx_offset() is referenced in stmmac_main.c only,
> let's move it to stmmac_main.c.
> 
> Drop the inline keyword by the way, it is better to let the compiler
> to decide.
> 
> Compile tested only.
> No functional change intended.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

