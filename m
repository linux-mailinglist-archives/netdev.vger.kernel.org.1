Return-Path: <netdev+bounces-284384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oE30Ikjp+WnWFAMAu9opvQ
	(envelope-from <netdev+bounces-284384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:57:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2980D4CE09F
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B197300460D
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 12:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F159421EE1;
	Tue,  5 May 2026 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jRUt0o88"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05AB42317B;
	Tue,  5 May 2026 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985860; cv=none; b=qW09emnWHl3/l6uCLoR10ZQuE+AGYCEzHfsFj3whkIKO2WNGUxKENBmcWT4xDvMnh44uFIGfe6w1nFxViDET1lL//jnw87gwk6g1DUP2twy3uejB2eRSEw3ND0fDji6sDq1UY8gvYXAqCzzpljcnh8530DrMPGlRlHKNzpRAmVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985860; c=relaxed/simple;
	bh=wxcasRWYMnZ8UywD3qeKyYvuSCbiyxAE4Ir9NAKPB+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VA3YujtmBNbJjtEgv04kXrJRbcBRlFssNnn15Yo8T9OV3nuiB3PqhInz2/S7BSoDCP0qpu6ycNcf6VgddIANknOimrgbdfn9xZRdpA5b/6GOR/xpHSgyo0EiIxPiYgUr+RdEnioo7ACyTaCkczwN34HUDnxWEvBFYQVHE8dQZVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jRUt0o88; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DbyDCSwMYZk7eG5a6jkCN+qhSVul6PYK1pXIvlezugU=; b=jRUt0o88F1fXqtAQNU2ekCe6DI
	hDxvl96nLo2h2Ye6E6RXzjPlf+HZ4wiITdGhpkIosRr/UEwJkift30vCD599K8o/RTdpK+6wJcL8w
	O7JJhGnQ4dGLKOj4Xhi3NMf2wdzOZtFXU9YSGM4yssuPDHSoGdbWT01Dd4XLO5kFs30s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKFL6-001Scf-Lt; Tue, 05 May 2026 14:57:28 +0200
Date: Tue, 5 May 2026 14:57:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: dev.taqnialabs@gmail.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] net: stmmac: fix RX DMA leak on TX alloc failure
Message-ID: <af3d7a77-048e-4cb8-8980-8462365d2fa9@lunn.ch>
References: <20260505-stmmac-rx-desc-cleanup-v1-1-df85cd095ebc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-stmmac-rx-desc-cleanup-v1-1-df85cd095ebc@gmail.com>
X-Rspamd-Queue-Id: 2980D4CE09F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284384-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 08:23:07AM +0000, Abid Ali via B4 Relay wrote:
> From: Abid Ali <dev.taqnialabs@gmail.com>
> 
> Free RX DMA resources when alloc_dma_tx_desc_resources() fails in
> alloc_dma_desc_resources().
> 
> Signed-off-by: Abid Ali <dev.taqnialabs@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 13d3cac05..8bb843b55 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2370,8 +2370,12 @@ static int alloc_dma_desc_resources(struct stmmac_priv *priv,
>  		return ret;
>  
>  	ret = alloc_dma_tx_desc_resources(priv, dma_conf);
> +	if (ret) {
> +		free_dma_rx_desc_resources(priv, dma_conf);
> +		return ret;
> +	}
>  
> -	return ret;
> +	return 0;

You could keep the return ret, and simplify the code:

	ret = alloc_dma_tx_desc_resources(priv, dma_conf);
	if (ret)
		free_dma_rx_desc_resources(priv, dma_conf);

	return ret;

    Andrew

---
pw-bot: cr

