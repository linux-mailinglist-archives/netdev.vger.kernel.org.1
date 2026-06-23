Return-Path: <netdev+bounces-301413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fN2dDU66Omq6FAgAu9opvQ
	(envelope-from <netdev+bounces-301413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:54:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD9C6B8E54
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:54:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=XYQ+4qmb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301413-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301413-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46D55302F778
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80363242B8;
	Tue, 23 Jun 2026 16:54:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE5D3242AC
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 16:53:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233640; cv=none; b=c4CxLeUlNFHFmXWnKjZnq2PY0cmGcVQByThRYmYaWj3vrYFGku20SVbCWujbK1oyrMeTlPasISD0V1ax6CXU9UzQiacSegRBvFGC5nCKG3Kz+OgpqiZldNWsX8+Wh6oMl0P5T8wLSTaggNsHjLysC4S0xuqwwmij5aiPlbks6Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233640; c=relaxed/simple;
	bh=ldiRrZdBa6mW4oKMFxkyvPpg4R5eWCQxoVjoGq2HEGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4zdHZscWaf/LFM0fHuNGw7L1NG0G5DFQvXt8475cs9SbQ2wGMgxqI7IFkiKwQ4V7J17sGH13N/uiQLKieh1gtuL8yIAV4Pf9erxJeS4oulXDVDm3fkzfAvTFcq06ZA+F/jeg4PtXPBHRZqiArrIRbWxQHvez2bBvzU36mA55eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XYQ+4qmb; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A8C3F4E40773;
	Tue, 23 Jun 2026 16:53:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6AF8A601C2;
	Tue, 23 Jun 2026 16:53:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BEDE3106C8382;
	Tue, 23 Jun 2026 18:53:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782233635; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=z14O1Oxv2MwpgYnEYsps2OBdWGQ1E7SU6CsxbrKj0vc=;
	b=XYQ+4qmbXXeldrcn9HdaF60+1YlbI4oqajGsTyoZ3GOmFLAk8mbo9eEIGW387IITgwp/hh
	sqIzohPg5uC0vvhiKcYRo8zkzFRQsYknDD2eT7TO+scjLzEFnPc8LPi/gNX20DcCygj/2L
	DkZW5Jz6kME6LbEAxUP9N2MtjWGNdnSLCfDgqr9VZAl1LxqjihK2+PgWtmsctPyufJta+Z
	QaT31nsU1MLJNsHy7rVPnN4FCwhnegT/9XFBInRwmknfuZicE6kKrdYCYFuDLg9kfMDUkX
	j3K43D2pE51iCCQbjxEOjIFe9DKSg7BNrxq57syQNtK0zTAmUq9APdcO9jHM9Q==
Message-ID: <12bb1713-d620-4db4-b240-fbc911be5ea3@bootlin.com>
Date: Tue, 23 Jun 2026 18:53:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: stmmac: dwmac-spacemit: Fix wrong phy
 interface definition
To: Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Yixun Lan
 <dlan@kernel.org>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
References: <20260623074637.503864-1-inochiama@gmail.com>
 <20260623074637.503864-2-inochiama@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260623074637.503864-2-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-301413-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foss.st.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:inochiama@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:dlan@kernel.org,m:rmk+kernel@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-riscv@lists.infradead.org,m:spacemit@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:dlan@gentoo.org,m:looong.bin@gmail.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,m:looongbin@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,gentoo.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2AD9C6B8E54

Hello,

On 6/23/26 09:46, Inochi Amaoto wrote:
> The current MII interface register definition from the vendor is wrong,
> use the right number for the macro. Also, correct the interface mask
> in spacemit_set_phy_intf_sel() so it can update the register with the
> right number
> 
> Fixes: 30f0ba420ed3 ("net: stmmac: Add glue layer for Spacemit K3 SoC")
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
> index 223754cc5c79..3bfb6d49be6c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
> @@ -18,8 +18,10 @@
>  #include "stmmac_platform.h"
>  
>  /* ctrl register bits */
> -#define CTRL_PHY_INTF_RGMII		BIT(3)
> -#define CTRL_PHY_INTF_MII		BIT(4)
> +#define CTRL_PHY_INTF_MODE		GENMASK(4, 3)
> +#define CTRL_PHY_INTF_RMII		FIELD_PREP(CTRL_PHY_INTF_MODE, 0)
> +#define CTRL_PHY_INTF_RGMII		FIELD_PREP(CTRL_PHY_INTF_MODE, 1)
> +#define CTRL_PHY_INTF_MII		FIELD_PREP(CTRL_PHY_INTF_MODE, 3)
>  #define CTRL_WAKE_IRQ_EN		BIT(9)
>  #define CTRL_PHY_IRQ_EN			BIT(12)
>  
> @@ -118,7 +120,7 @@ static void spacemit_get_interfaces(struct stmmac_priv *priv, void *bsp_priv,
>  
>  static int spacemit_set_phy_intf_sel(void *bsp_priv, u8 phy_intf_sel)
>  {
> -	unsigned int mask = CTRL_PHY_INTF_MII | CTRL_PHY_INTF_RGMII;
> +	unsigned int mask = CTRL_PHY_INTF_MODE;
>  	struct spacmit_dwmac *dwmac = bsp_priv;
>  	unsigned int val = 0;
>  
> @@ -128,6 +130,7 @@ static int spacemit_set_phy_intf_sel(void *bsp_priv, u8 phy_intf_sel)
>  		break;
>  
>  	case PHY_INTF_SEL_RMII:
> +		val = CTRL_PHY_INTF_RMII;

This isn't strictly-speaking necessary as this is 0 and val is already 0, maybe
compilers can figure it out and this leaves us with more self-documenting code ?

So I'm ok with that personally,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


>  		break;
>  
>  	case PHY_INTF_SEL_RGMII:


