Return-Path: <netdev+bounces-295847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MhBzL9bmImrrewEAu9opvQ
	(envelope-from <netdev+bounces-295847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:10:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E358649243
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:10:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=dz21K3Jb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295847-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295847-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4934230E29DB
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC84D3DE45F;
	Fri,  5 Jun 2026 14:55:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249C03E16BB
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 14:55:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671315; cv=none; b=guL1AXKAOhOa0pgAQFs180mlUURy8nzTIjYSV0EhUDm+x7lQFbx80yrU0KYQm60JrO7iWm2aXZx3R3J+uJPFRcyN8pe2ecMZkOvUL9Rrh22L5slWBDoWwkQiVwCPjYsx3MwbQ3+dgzkFISTeAVFQ7xwqLR81bBPeu2BjrjaDZEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671315; c=relaxed/simple;
	bh=1RIjhyMLtv99EBtOuAcd36dJda8OIlnmtL2e3xghDv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKKZJI7ySbUyhU0dobj6YpbnXDFcDXeZ2ZNaBw/QfrPPsOby4wgH3WOqum3vjZ0oj6Fh9DGF8NNUvA1AfIf7ereNH3rdfsxYUqZEqii+z7ViydjFPunNEuPFMlFXCw+TZ8zFthUf34TOYRmwjDOyHzwMmbJ+gu0+VTeUkCZG91Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dz21K3Jb; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7C5524E408EA;
	Fri,  5 Jun 2026 14:55:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3760F5FED1;
	Fri,  5 Jun 2026 14:55:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2859106A21AF;
	Fri,  5 Jun 2026 16:55:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780671310; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=qWXGRwd3dgogIG+Bvu9DUV5PG31p4cZwWp/87lf38RU=;
	b=dz21K3JbykBYP0dGe9k0xmZ+3l5tU+Hx3gj08dAtSVDppefMhtMqpZl4jnL40WxdmZnGt2
	HSn6st3ifIi3VTp8hME8IHDk96OCk+kOeZuQliZaubKA+bU3DNmUKsHuL6+pGPB1US4Ihz
	bsFgKA3S/MBiBB0GjCwPvNT8sW/m3vJrj7Fjh0goXdzmDlsORzno5UJUIJrso+lookTdCn
	jXOIaNFIXugn/xtmJUuqXUAvcBxpByCAXQML7AJJ1LpRuYywMZ7uRTYVmgKEAZANgnS48D
	ti0wFnjaL6MJpvGcO0EAgS+HoImTNqfz9MouwZGZNgMaMvWSKqJM6vSdlp8T6A==
Message-ID: <15d6ff60-cb36-4d61-a4ce-62b72c4429f5@bootlin.com>
Date: Fri, 5 Jun 2026 16:55:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: xgmac: report L3/L4 filter match count in
 ethtool stats
To: muhammad.nazim.amirul.nazle.asmade@altera.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260604083037.24407-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260604083037.24407-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295847-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bootlin.com:mid,bootlin.com:dkim,bootlin.com:from_mime,bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,altera.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E358649243

Hi,

You're missing the 'net-next' in the Patch subject :(

Besides that,

On 6/4/26 10:30, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Read the L3FM and L4FM bits from the RX descriptor status word (RDES2)
> and increment the corresponding ethtool statistics counters. This allows
> users to observe L3/L4 filter hit rates via ethtool -S.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h       | 2 ++
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 51943705a2b0..95fdf3133208 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -429,6 +429,8 @@
>  #define XGMAC_TDES3_VLTV		BIT(16)
>  #define XGMAC_TDES3_VT			GENMASK(15, 0)
>  #define XGMAC_TDES3_FL			GENMASK(14, 0)
> +#define XGMAC_RDES2_L4FM		BIT(28)
> +#define XGMAC_RDES2_L3FM		BIT(27)
>  #define XGMAC_RDES2_HL			GENMASK(9, 0)
>  #define XGMAC_RDES3_OWN			BIT(31)
>  #define XGMAC_RDES3_CTXT		BIT(30)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> index b5f200a87484..6719ac6e395b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> @@ -27,6 +27,7 @@ static int dwxgmac2_get_rx_status(struct stmmac_extra_stats *x,
>  				  struct dma_desc *p)
>  {
>  	u32 rdes3 = le32_to_cpu(p->des3);
> +	u32 rdes2 = le32_to_cpu(p->des2);
>  
>  	if (unlikely(rdes3 & XGMAC_RDES3_OWN))
>  		return dma_own;
> @@ -37,6 +38,11 @@ static int dwxgmac2_get_rx_status(struct stmmac_extra_stats *x,
>  	if (unlikely((rdes3 & XGMAC_RDES3_ES) && (rdes3 & XGMAC_RDES3_LD)))
>  		return discard_frame;
>  
> +	if (rdes2 & XGMAC_RDES2_L3FM)
> +		x->l3_filter_match++;
> +	if (rdes2 & XGMAC_RDES2_L4FM)
> +		x->l4_filter_match++;
> +
>  	return good_frame;
>  }
>  


