Return-Path: <netdev+bounces-239571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EB5C69D49
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77B2C4F41B9
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100DD36403A;
	Tue, 18 Nov 2025 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GwVHwhM0"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB9936403E
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474423; cv=none; b=rR1OuKoRRZGOxtEmFNS9xH/51pt9/R+tqZbnoMaNjwG8JnX79Z0aw2sS+U64S5vaHdCyIVz+A2RaGkjW2Kcm+ilDTeJQodNSqnEMxBuiPQlfi7Dlx4E5iwokudheH28pfMW8u7h+DOwth0jI+GusKkv4LZHhYUjmY8ntNppEDTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474423; c=relaxed/simple;
	bh=3wnO420+7TX5tlRb0vMPDu/XZOnWU0TUBTEtAyLbSnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gA/p/yegZM6aBcUliJuFk3lRh9WhMt4Uc6oMYUiNwn17vsAMFxuLGw0Veix8YKVRTVUmum4hyTxXuRn9udzgpwhcV6BOfkNjuvyL/X6AdNbYwpsGRtQ0G1nfLxL3qQ1SIbvckeIu5QD38Tq1y1Ll9okCRvO2AmURKjIlycVwW3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GwVHwhM0; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8FAA54E4175B;
	Tue, 18 Nov 2025 14:00:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5EF33606FE;
	Tue, 18 Nov 2025 14:00:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E891010371DD3;
	Tue, 18 Nov 2025 15:00:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763474412; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=1T9L6GNFxVeySHO4fK7pztQOaxOzwYo2ILkJ3QC3pyY=;
	b=GwVHwhM0ZXmBzkSyBjZN/AiXpiutG2xbKiY+F25x3Vc8hAaL8BUxv9fCOApJM+edWzt8mH
	MUqOlKjs4IAh/IpCxP/Kg8k+aE8TYWAtuyVjtQTVdLs3+E5WlvAgAAf5thKL5fJdUGhfnt
	xPJJtNJzsX2PR/Jln0+oRXIpRrrjftSacS558PssKLG2Z7FC4ILyvoOA5KThBv72YTxDl6
	0sLDe6Nafd6FapcU6BfDYV0R0IpOSSaF7pgkcciW6PsJHAhvuUuqAFC8fMgflGpnq4e7fe
	Ud0r7ycdege9sLBCX6q+LsFUIMKYoKeYkWU1Yl0x3HoWdkDIy7J1V5vAMdhoog==
Message-ID: <ec621eb4-8a4f-47fd-a544-44d8130fcbb8@bootlin.com>
Date: Tue, 18 Nov 2025 15:00:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: stmmac: stmmac_is_jumbo_frm() returns
 boolean
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aRxDqJSWxOdOaRt4@shell.armlinux.org.uk>
 <E1vLIWW-0000000Ewkl-21Ia@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vLIWW-0000000Ewkl-21Ia@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 18/11/2025 11:01, Russell King (Oracle) wrote:
> stmmac_is_jumbo_frm() returns whether the driver considers the frame
> size to be a jumbo frame, and thus returns 0/1 values. This is boolean,
> so convert it to return a boolean and use false/true instead. Also
> convert stmmac_xmit()'s is_jumbo to be bool, which causes several
> variables to be repositioned to keep it in reverse Christmas-tree
> order.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/chain_mode.c  | 9 ++++-----
>  drivers/net/ethernet/stmicro/stmmac/hwif.h        | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/ring_mode.c   | 9 ++-------
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
>  4 files changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
> index d14b56e5ed40..120a009c9992 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
> @@ -83,14 +83,13 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
>  	return entry;
>  }
>  
> -static unsigned int is_jumbo_frm(unsigned int len, int enh_desc)
> +static bool is_jumbo_frm(unsigned int len, bool enh_desc)
>  {
> -	unsigned int ret = 0;
> +	bool ret = false;
>  
>  	if ((enh_desc && (len > BUF_SIZE_8KiB)) ||
> -	    (!enh_desc && (len > BUF_SIZE_2KiB))) {
> -		ret = 1;
> -	}
> +	    (!enh_desc && (len > BUF_SIZE_2KiB)))
> +		ret = true;
>  
>  	return ret;
>  }
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index 4953e0fab547..f257ce4b6c66 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -541,7 +541,7 @@ struct stmmac_rx_queue;
>  struct stmmac_mode_ops {
>  	void (*init) (void *des, dma_addr_t phy_addr, unsigned int size,
>  		      unsigned int extend_desc);
> -	unsigned int (*is_jumbo_frm)(unsigned int len, int ehn_desc);
> +	bool (*is_jumbo_frm)(unsigned int len, bool enh_desc);
>  	int (*jumbo_frm)(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
>  			 int csum);
>  	int (*set_16kib_bfsize)(int mtu);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
> index 039903c424df..382d94a3b972 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
> @@ -91,14 +91,9 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
>  	return entry;
>  }
>  
> -static unsigned int is_jumbo_frm(unsigned int len, int enh_desc)
> +static bool is_jumbo_frm(unsigned int len, bool enh_desc)
>  {
> -	unsigned int ret = 0;
> -
> -	if (len >= BUF_SIZE_4KiB)
> -		ret = 1;
> -
> -	return ret;
> +	return len >= BUF_SIZE_4KiB;
>  }
>  
>  static void refill_desc3(struct stmmac_rx_queue *rx_q, struct dma_desc *p)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index db68c89316ec..12fc31c909c4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4579,18 +4579,18 @@ static bool stmmac_has_ip_ethertype(struct sk_buff *skb)
>   */
>  static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
> -	unsigned int first_entry, tx_packets, enh_desc;
> +	bool enh_desc, has_vlan, set_ic, is_jumbo = false;
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  	unsigned int nopaged_len = skb_headlen(skb);
> -	int i, csum_insertion = 0, is_jumbo = 0;
>  	u32 queue = skb_get_queue_mapping(skb);
>  	int nfrags = skb_shinfo(skb)->nr_frags;
> +	unsigned int first_entry, tx_packets;
>  	int gso = skb_shinfo(skb)->gso_type;
>  	struct stmmac_txq_stats *txq_stats;
>  	struct dma_edesc *tbs_desc = NULL;
>  	struct dma_desc *desc, *first;
>  	struct stmmac_tx_queue *tx_q;
> -	bool has_vlan, set_ic;
> +	int i, csum_insertion = 0;
>  	int entry, first_tx;
>  	dma_addr_t des;
>  	u32 sdu_len;


