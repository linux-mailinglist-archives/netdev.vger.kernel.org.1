Return-Path: <netdev+bounces-137183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE8E9A4AFE
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 04:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925221C2151F
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 02:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7796217C7B6;
	Sat, 19 Oct 2024 02:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Yu0v8Mf1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD8EA47
	for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 02:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729305938; cv=none; b=FkSb9O03yxuoaVOqk54qNZJm1NLlTuywlQbRKXJOQk4qpjJ4dCtPiP1cwi+jtZtIELdgg2JCM3AhsuTKVSSdQy0YSpGSEmsQRuX0KXcQZouw6zl+QzHzQ3EJz7gpv9BHHvdKAJpybX3Mr4M9pw8vCMkbyhXDsWAYA0pmYkoIfSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729305938; c=relaxed/simple;
	bh=GwB2rMyJ7/y0vB2JHZJoZ2v+U0fGPkFYWsJ5O49Xqb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMrKOzr5wtWgo1qe+b7gQD6k2WxOiqGp86rHicwh2KG37HPKEAlWtGzZ6nzXMwvCLVCslLxBujZKppl6UU8DNh4E+EngR5GhebPMcXam4fy3Oeg4GALL59y+67RotCaaU2ILO4l48zjsIHSry/t9/54tKJ/zzo7GdVRwx0ybg3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Yu0v8Mf1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XutD5Y/NJfkj+RgP2XX0derSZSZl9zc6S02LBDEAnn8=; b=Yu0v8Mf1PxE54xxKFPwtLPn7+B
	3tFtnePq2yyVQP83rRydTBD84FsQfxAc9fZfXjykRLCn9LYibRpe9dhbwI8R8n1zPt8ck2vHjtwDK
	j93VnKrPePPECnKwSGhYa482znZgGYG+uUxpNA60Drhg49Ve+c47ygotF4EOptS3m83k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1zSu-00AaGK-8u; Sat, 19 Oct 2024 04:45:16 +0200
Date: Sat, 19 Oct 2024 04:45:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <horms@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	kernel@quicinc.com
Subject: Re: [PATCH net v1] net: stmmac: Disable PCS Link and AN interrupt
 when PCS AN is disabled
Message-ID: <60119fa1-e7b1-4074-94ee-7e6100390444@lunn.ch>
References: <20241018222407.1139697-1-quic_abchauha@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018222407.1139697-1-quic_abchauha@quicinc.com>

On Fri, Oct 18, 2024 at 03:24:07PM -0700, Abhishek Chauhan wrote:
> Currently we disable PCS ANE when the link speed is 2.5Gbps.
> mac_link_up callback internally calls the fix_mac_speed which internally
> calls stmmac_pcs_ctrl_ane to disable the ANE for 2.5Gbps.
> 
> We observed that the CPU utilization is pretty high. That is because
> we saw that the PCS interrupt status line for Link and AN always remain
> asserted. Since we are disabling the PCS ANE for 2.5Gbps it makes sense
> to also disable the PCS link status and AN complete in the interrupt
> enable register.
> 
> Interrupt storm Issue:-
> [   25.465754][    C2] stmmac_pcs: Link Down
> [   25.469888][    C2] stmmac_pcs: Link Down
> [   25.474030][    C2] stmmac_pcs: Link Down
> [   25.478164][    C2] stmmac_pcs: Link Down
> [   25.482305][    C2] stmmac_pcs: Link Down

I don't know this code, so i cannot really comment if not enabling the
interrupt is the correct fix or not. But generally an interrupt storm
like this is cause because you are not acknowledging the interrupt
correctly to clear its status. So rather than not enabling it, maybe
you should check what is the correct way to clear the interrupt once
it happens?

	Andrew

