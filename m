Return-Path: <netdev+bounces-281254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBEZL3IZ72mB6QAAu9opvQ
	(envelope-from <netdev+bounces-281254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:08:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2775846EC40
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F6B9301CFA4
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC07399023;
	Mon, 27 Apr 2026 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sS2k5mmQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704AB390C95
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277265; cv=none; b=gCD1vQlislb2tZ4Rmw4i8/tUTUh4f2kmjmGPf1lRgGkV0b+pf9NWVVg0e2PdeMD54L/M6FL8SvFQBnoe/xjxZoVbVMAh1aI5np3bKcPOMdPgwfb59uuCmpnGn5U/FtTq8z9E4nkv+uANesk1g+RCtS3d8zwiCfmbblCMnXKdqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277265; c=relaxed/simple;
	bh=NmleoNkeAR3Ndp8dp1vkK8TK0y1144rekpDYcW1gZUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFrhhojWs3xpcFFYR+tvF6UjG8MAfulDK0XSdBLDz/Y/9rN0Au6Ou04Lx91qGVLhmRQiB5eulhyRt/88sLZzwN0LCWz31lEvu35k4ZiDNseegQDOT361Ox2w00QjowPRKqYWJRZlfkNLFNK9bx7TxTZ6nVO/tm0UpqocXa4k9Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sS2k5mmQ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6D2411A343C;
	Mon, 27 Apr 2026 08:07:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 40F85600D1;
	Mon, 27 Apr 2026 08:07:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2C8D1072227A;
	Mon, 27 Apr 2026 10:07:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777277256; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=V5TkgjwxbUuArCO4ICwo8xJ3fv0RVK8UqGSazM8m0Bg=;
	b=sS2k5mmQAU4Zb7zznUnG859IoZPkdpzVfbBEqSt2jdp3iibOyd685Y3UoWN8fV1P2FA6DF
	RwuoebpIjbLNXLCXAdZYOBwssrqtL3Wo1rvYugVJdkLpqsLU/D5ua1v7PK4RUfTJD1k0JD
	QLzZucGMsbZzapITl7u1LR0NwXlj6BhPXKUb+nknCxQD7381AKuojgb0Fh7ck7UPmKyAoT
	lypZEI24eyFSSzHnH+5SiBlyRK0uFd6pscE/hNu4iwqRRwdb5vOhMneFZTuYzqfcXZaDE3
	tPscWq0H0c3SLSHSn3Fyc8/B5EdtMjlVcEp7zy2BZPKvyzeRcuGs+kco/GMxkA==
Message-ID: <d83c971e-659c-433e-888a-dc1bdffe975e@bootlin.com>
Date: Mon, 27 Apr 2026 10:07:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: fix RX DMA leak on TX alloc failure
To: dev.taqnialabs@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260425-stmmac-rx-desc-cleanup-v1-1-1a18a704c422@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260425-stmmac-rx-desc-cleanup-v1-1-1a18a704c422@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 2775846EC40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281254-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foss.st.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid]



On 25/04/2026 14:38, Abid Ali via B4 Relay wrote:
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
>  }

This change looks correct, however you're missing a Fixes: tag
indicating when was this issue introduced. You must also indicate what
tree you're targetting (in this case, net) :

Please look here for the process information :

https://docs.kernel.org/process/maintainer-netdev.html

Maxime
>  
>  /**
> 
> ---
> base-commit: 028ef9c96e96197026887c0f092424679298aae8
> change-id: 20260425-stmmac-rx-desc-cleanup-440f05845492
> 
> Best regards,


