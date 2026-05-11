Return-Path: <netdev+bounces-286774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELlLJ30aAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:05:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1595140DA
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3BAD3023042
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0D947884F;
	Mon, 11 May 2026 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="buHgxpeh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7E2371CFF;
	Mon, 11 May 2026 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522736; cv=none; b=m3cOwQjs7ojI7wu0tWB39iY3fneHbxMANItutceafvTDieSrmFqDr/rwAbwPbg+U7kHN10YIrK3NrX2b9xlQhY9NI06hov/NCjFRbqiTmXu8IF/HankwKr4f5VVbTyJmyULaI0CY1yuZOceY+Ak2SexfoNNKy8a+0vxfYPzpWIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522736; c=relaxed/simple;
	bh=xXcn4Rp8hgJmF94zgy9rzHfF5q14gMGoEQCU2/qn9Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+vyylXlMf1pB4JHuScF8bYPh7x8XLGCIhB9T9FmE5R3rO3MCxMcXlV73Ad4CLcFFhRkYFxNkYuJT8wqhQ14qQvQBiJnTUFKTUAypsEL56ZcbFGD9XefiobFdFk9e0gKStfS9LPY4nML/6iO+7UswiMsMQFGUOMMyQ2I2Smr2dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=buHgxpeh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Jh6u29AOADS1fMHBmCiOeXqCU3d+ntmTih5itrIf2Zc=; b=buHgxpehuDjPXoyWstUrVUhMKP
	e96k0inUJUxTp/HH5DA25IGkPmg+FpjdnULd5Oqendp7rrTlEmPLjujsc1DLi1ca92yQREhuAWYr4
	/cpTxpfdq3gkSmbMOwe7CMhbYz+l0r/dU/ibeVITbx/6wXm+kZtrSzujNfcw9i6GdueI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMV0W-002Q6u-Ns; Mon, 11 May 2026 20:05:32 +0200
Date: Mon, 11 May 2026 20:05:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, k.domagalski@samsung.com,
	k.tegowski@samsung.com
Subject: Re: [PATCH net-next 2/3] net/stmmac/dwxgmac: Extend MTL/DMA support
 to 16 queues
Message-ID: <93db358a-4ff2-4cc7-ac89-a0f13ae05597@lunn.ch>
References: <20260511165416.3093015-1-j.raczynski@samsung.com>
 <CGME20260511165431eucas1p28254403c5d4117b900dca4ca613bb532@eucas1p2.samsung.com>
 <20260511165416.3093015-3-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511165416.3093015-3-j.raczynski@samsung.com>
X-Rspamd-Queue-Id: 1B1595140DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286774-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,samsung.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 06:54:15PM +0200, Jakub Raczynski wrote:
> New datasheets for XGMAC (3.20a and 3.40a, depending on product) support up to
> 16 MTL/DMA queues. Before we increase max amount through macro,
> prepare dwxgmac functions to handle that.
> 
> Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 ++
>  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 24 +++++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 51943705a2b0..bd333afe7e1b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -257,6 +257,8 @@
>  #define XGMAC_MTL_INT_STATUS		0x00001020
>  #define XGMAC_MTL_RXQ_DMA_MAP0		0x00001030
>  #define XGMAC_MTL_RXQ_DMA_MAP1		0x00001034
> +#define XGMAC_MTL_RXQ_DMA_MAP2		0x00001038
> +#define XGMAC_MTL_RXQ_DMA_MAP3		0x0000103c
>  #define XGMAC_QxMDMACH(x)		GENMASK((x) * 8 + 7, (x) * 8)
>  #define XGMAC_QxMDMACH_SHIFT(x)		((x) * 8)
>  #define XGMAC_QDDMACH			BIT(7)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index 98b3e0cc84fa..76f8214a6e5b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -266,9 +266,29 @@ static void dwxgmac2_map_mtl_to_dma(struct mac_device_info *hw, u32 queue,
>  	void __iomem *ioaddr = hw->pcsr;
>  	u32 value, reg;
>  
> -	reg = (queue < 4) ? XGMAC_MTL_RXQ_DMA_MAP0 : XGMAC_MTL_RXQ_DMA_MAP1;
> -	if (queue >= 4)
> +	switch (queue / 4) {
> +	// queue 0 ~ 3
> +	case 0:
> +		reg = XGMAC_MTL_RXQ_DMA_MAP0;
> +		break;
> +	// queue 4 ~ 7

I think

	switch (queue):
	case 0 ... 3:
	     reg = XGMAC_MTL_RXQ_DMA_MAP0;

is more readable, and expresses in code what you had in the comment.

   Andrew

