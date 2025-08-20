Return-Path: <netdev+bounces-215326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 338D0B2E19F
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 18:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766373BC11A
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 15:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89388322764;
	Wed, 20 Aug 2025 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGxGlvX3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFF426D4E2;
	Wed, 20 Aug 2025 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705414; cv=none; b=IMsF3UPAIfnAVQbXVLq9pz5yx6+JLVIeaDOQBiRpK24iMzJd51AMz7y9o4tm80xsRs/j0VNHQ6JHNW4hcISPdKd9cdczdTFPdGgwHJORFZVwj7WaAIM6aFMrrTjw7onmhqoB9sGvYcpYZxgr9TwD5lpECewSjQwq9jmU+ltUGSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705414; c=relaxed/simple;
	bh=iJ6BWRhcfdGTj+t/9+L3Zt0RuVafSEkJxteervNs1lI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=um58msI+jonIWXaNSwtpB5JfW3N+DT2/KWTSgqoqM9U7PRhrLpeZt4TeXQB3xknEpfIBZwYiczZrw6+/21Dzq/pOoaJavwGtVQmRttra5sXAMHKO/pmDXhS1Alf/7xHXW/iXPNQ8Xu6t9rEMbaSLsqkW9lOwl4uLUq+8lVXFyVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGxGlvX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BD2C4CEE7;
	Wed, 20 Aug 2025 15:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755705413;
	bh=iJ6BWRhcfdGTj+t/9+L3Zt0RuVafSEkJxteervNs1lI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hGxGlvX3nlwc3ojc89fPW2vtB4s4kIpy3ua357hA3xZiE5QSH3XQnpl0F5Bmsvx2V
	 7jAzijmUcR6aR9J7Rv3NVdhqjvYMwQ27ZAgcOz7xAwiMG2Ypc+Hqjqgv63/d7n/99T
	 nKFgggQFP8Hsz0zCb959kTzz1rBTeCT9JWIFFhDQ/LnkiiYDFA498uO+FItjZLMmQS
	 Lo2SNiiReT0SAIau74q2hD+z8mRItbkp6JXalvNA3vvmcM017W2mSp5OLk96/ahaWF
	 iEK2UvaST9JX8WxMstmzd4BYcyLC1+Wnct1RX/x/EgSuu5ZcwjZGm7LFuy/8V33wn9
	 c4aq2sUOaJ2LQ==
Date: Wed, 20 Aug 2025 08:56:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Cc: Rohan G Thomas via B4 Relay
 <devnull+rohan.g.thomas.altera.com@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Serge Semin <fancer.lancer@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>, Jose Abreu
 <Jose.Abreu@synopsys.com>, Ong Boon Leong <boon.leong.ong@intel.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew
 Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next v2 3/3] net: stmmac: Set CIC bit only for TX
 queues with COE
Message-ID: <20250820085652.5e4aa8cf@kernel.org>
In-Reply-To: <20250820085446.61c50069@kernel.org>
References: <20250816-xgmac-minor-fixes-v2-0-699552cf8a7f@altera.com>
	<20250816-xgmac-minor-fixes-v2-3-699552cf8a7f@altera.com>
	<20250819182207.5d7b2faa@kernel.org>
	<22947f6b-03f3-4ee5-974b-aa4912ea37a3@altera.com>
	<20250820085446.61c50069@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 08:54:46 -0700 Jakub Kicinski wrote:
> On Wed, 20 Aug 2025 12:44:18 +0530 G Thomas, Rohan wrote:
> > On 8/20/2025 6:52 AM, Jakub Kicinski wrote:  
> > > Hopefully the slight pointer chasing here doesn't impact performance?
> > > XDP itself doesn't support checksum so perhaps we could always pass
> > > false?    
> > 
> > I'm not certain whether some XDP applications might be benefiting from
> > checksum offloading currently  
> 
> Checksum offload is not supported in real XDP, AFAIK, and in AF_XDP 
> the driver must implement a checksum callback which stmmac does not do.
> IOW it's not possible to use Tx checksum offload in stmmac today from
> XDP.

To be clear -- this is just for context. I don't understand the details
of what the CIC bit controls, so the final decision is up to you.

