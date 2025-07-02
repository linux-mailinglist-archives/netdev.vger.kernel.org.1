Return-Path: <netdev+bounces-203221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0E6AF0CE0
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFDF33B3FDB
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 07:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E99225A47;
	Wed,  2 Jul 2025 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TY+5wL4g"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6321F0991;
	Wed,  2 Jul 2025 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751442407; cv=none; b=Ql8SS5iQ+3U7gJJ6xo0/X6+EAKRGx1imLUOUrlmEXrO6+QbptoPhmJ7oCGQrhpa4vV9eLug6KMbQsnndg2MC8RsAFCHq0rHSQpwFiBV6sXCgJ+qn+klzlfLL4gbCTpn4LPqyf9heDh+9pP27ZtQ7AJMKwfDW41ge0OAwmB58j7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751442407; c=relaxed/simple;
	bh=T1dfQtN0fOnpT3jRKO9/i37AUF1Fx6meJL5vsJcl4c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZXNkHcO7jSVVhi2kdUn91hbdZmrhfvLmO3f4qYTEuQ8Qon8s9xjjc/E+oqVjelPu8prGD8VLY9/rf9o1942isN4tcKJQf756IKmaXTfLo1yG9p5kFN7pgPSwBgNktklDE5GXdrH4Cv7cS8R7nfJOSdQSCZHeK0EdaHIVn3kNUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TY+5wL4g; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OFEn8Mwx7iZb4bcLt1+4BA8J7VwQHTbrRClWAd6OzhU=; b=TY+5wL4gDFSoFVqQeDom46pQ3Z
	DslEO6a82orDnsC9xr7tvmwE9LkDnW1GS1RQeYPD4PSM3xE0VsV6qjCsxtVrRIs7Dt8+xW9DKeK/g
	jEkUCwbXdJFtMPrHOp4p8hlz5likS8jO47le2YGqEcIhCcgzZhZ+Wze7mORKVH0L7ijQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uWsAk-00HYRS-Hx; Wed, 02 Jul 2025 09:46:26 +0200
Date: Wed, 2 Jul 2025 09:46:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>,
	Frank Wunderlich <frank-w@public-files.de>,
	Eric Woudstra <ericwouds@gmail.com>, Elad Yifee <eladwf@gmail.com>,
	Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
	Sky Huang <skylake.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v4 3/3] net: ethernet: mtk_eth_soc: use generic
 allocator for SRAM
Message-ID: <e5d6ac18-4d38-4a01-abd5-8bd4d6c3b05b@lunn.ch>
References: <cover.1751421358.git.daniel@makrotopia.org>
 <88ae2a765ef809d36e153430bf60aac6ce81d6f1.1751421358.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88ae2a765ef809d36e153430bf60aac6ce81d6f1.1751421358.git.daniel@makrotopia.org>

On Wed, Jul 02, 2025 at 03:38:15AM +0100, Daniel Golle wrote:
> Use a dedicated "mmio-sram" node and the generic allocator
> instead of open-coding SRAM allocation for DMA rings.
> Keep support for legacy device trees but notify the user via a
> warning to update, and let the ethernet driver create the
> gen_pool in this case.
> 
> Co-developed-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

