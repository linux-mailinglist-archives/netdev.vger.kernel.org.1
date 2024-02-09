Return-Path: <netdev+bounces-70476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EB184F263
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44BF81F237A2
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 09:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0879865BB7;
	Fri,  9 Feb 2024 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qL4Gj2b/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rt9TpdZK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qL4Gj2b/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rt9TpdZK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1156E67E66
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707471577; cv=none; b=GWJzroq2I4XuFNkoy6flnizX+CoPazONVnFbUHsX5+DzuEJl9VtyUIEvztfI2vj1PDceeGP+7+jwG+RCIxkWulHhSWY31uHCnHmwNNLSF8nQF217jbV8p2K/K0WNcRc6T2xgE9kLPfmxYpgve15mCjUg4W99RkiUgg8nuM3ZfTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707471577; c=relaxed/simple;
	bh=bgIGG2/6SS5BVvlwnLmhh4w2CXERqzI1gyb0kbbJqAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ryUN0q0wBelM+kFQMSc43ZUhRs5UyvNRkUiANqUGVh2UdvU5Yug8XtKeVBT1imjGSXtKmtC39P+qK79rx3JExOO2x4oW2d21a6HkXVQfaK/dlcRMHtfBgCfWG6TSDclHi9qggbW0ccBA847xDukIdb/zQdE4mn/wrOQrRo8TCT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qL4Gj2b/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rt9TpdZK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qL4Gj2b/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rt9TpdZK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 11B201F7F4;
	Fri,  9 Feb 2024 09:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707471574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XNKUXGZctdHLcLszDvbdfxQjBBnEywsnBcwV5V1nTE=;
	b=qL4Gj2b/TGFAqgRNvXj/plFN9u1Vv2MalPMkzoaz/a47Wtute8b2byPYy8HA7jZ8CiUVBz
	owz5wlWlzDSqpVH188IEmhsFoqfqIg93kSqWmVznWmDfk2RvLRiJHW9djrrDXxk7ln0MdD
	mAAV9fzC/WCkDJ95k3uxETGxrL/y/7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707471574;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XNKUXGZctdHLcLszDvbdfxQjBBnEywsnBcwV5V1nTE=;
	b=rt9TpdZKJCSL/OsuctYxjUe9fm5jYXHXuVReGT1XmC8Dk2WyG2hr2kKZWiKdEy7UYv7UWT
	0tx+TkdcmTtS42Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707471574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XNKUXGZctdHLcLszDvbdfxQjBBnEywsnBcwV5V1nTE=;
	b=qL4Gj2b/TGFAqgRNvXj/plFN9u1Vv2MalPMkzoaz/a47Wtute8b2byPYy8HA7jZ8CiUVBz
	owz5wlWlzDSqpVH188IEmhsFoqfqIg93kSqWmVznWmDfk2RvLRiJHW9djrrDXxk7ln0MdD
	mAAV9fzC/WCkDJ95k3uxETGxrL/y/7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707471574;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XNKUXGZctdHLcLszDvbdfxQjBBnEywsnBcwV5V1nTE=;
	b=rt9TpdZKJCSL/OsuctYxjUe9fm5jYXHXuVReGT1XmC8Dk2WyG2hr2kKZWiKdEy7UYv7UWT
	0tx+TkdcmTtS42Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F752139E7;
	Fri,  9 Feb 2024 09:39:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6YcuDNXyxWU9FQAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Fri, 09 Feb 2024 09:39:33 +0000
Message-ID: <b74bc211-d8a3-4d7c-8dcc-d2cc47bd40bf@suse.de>
Date: Fri, 9 Feb 2024 12:39:32 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: fec: Refactor: #define magic constants
Content-Language: en-US
To: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 NXP Linux Team <linux-imx@nxp.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Andrew Lunn <andrew@lunn.ch>, Marc Kleine-Budde <mkl@pengutronix.de>
References: <20240209091100.5341-1-csokas.bence@prolan.hu>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20240209091100.5341-1-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="qL4Gj2b/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rt9TpdZK
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.87 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.37)[77.07%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -1.87
X-Rspamd-Queue-Id: 11B201F7F4
X-Spam-Flag: NO



On 2/9/24 12:11, Csókás Bence wrote:
> Add defines for bits of ECR, RCR control registers, TX watermark etc.
> 
> Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>

Please add net-next prefix

> ---
>  drivers/net/ethernet/freescale/fec_main.c | 50 +++++++++++++++--------
>  1 file changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 63707e065141..a16220eff9b3 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -85,8 +85,6 @@ static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
>  
>  static const u16 fec_enet_vlan_pri_to_queue[8] = {0, 0, 1, 1, 1, 2, 2, 2};
>  
> -/* Pause frame feild and FIFO threshold */
> -#define FEC_ENET_FCE	(1 << 5)
>  #define FEC_ENET_RSEM_V	0x84
>  #define FEC_ENET_RSFL_V	16
>  #define FEC_ENET_RAEM_V	0x8
> @@ -240,8 +238,8 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
>  #define PKT_MINBUF_SIZE		64
>  
>  /* FEC receive acceleration */
> -#define FEC_RACC_IPDIS		(1 << 1)
> -#define FEC_RACC_PRODIS		(1 << 2)
> +#define FEC_RACC_IPDIS		BIT(1)
> +#define FEC_RACC_PRODIS		BIT(2)
>  #define FEC_RACC_SHIFT16	BIT(7)
>  #define FEC_RACC_OPTIONS	(FEC_RACC_IPDIS | FEC_RACC_PRODIS)
>  
> @@ -273,8 +271,23 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
>  #define FEC_MMFR_TA		(2 << 16)
>  #define FEC_MMFR_DATA(v)	(v & 0xffff)
>  /* FEC ECR bits definition */
> -#define FEC_ECR_MAGICEN		(1 << 2)
> -#define FEC_ECR_SLEEP		(1 << 3)
> +#define FEC_ECR_RESET           BIT(0)
> +#define FEC_ECR_ETHEREN         BIT(1)
> +#define FEC_ECR_MAGICEN         BIT(2)
> +#define FEC_ECR_SLEEP           BIT(3)
> +#define FEC_ECR_EN1588          BIT(4)
> +#define FEC_ECR_BYTESWP         BIT(8)
> +/* FEC RCR bits definition */
> +#define FEC_RCR_LOOP            BIT(0)
> +#define FEC_RCR_HALFDPX         BIT(1)
> +#define FEC_RCR_MII             BIT(2)
> +#define FEC_RCR_PROMISC         BIT(3)
> +#define FEC_RCR_BC_REJ          BIT(4)
> +#define FEC_RCR_FLOWCTL         BIT(5)
> +#define FEC_RCR_RMII            BIT(8)
> +#define FEC_RCR_10BASET         BIT(9)
> +/* TX WMARK bits */
> +#define FEC_TXWMRK_STRFWD       BIT(8)
>  
>  #define FEC_MII_TIMEOUT		30000 /* us */
>  
> @@ -1137,18 +1150,18 @@ fec_restart(struct net_device *ndev)
>  		    fep->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID)
>  			rcntl |= (1 << 6);
>  		else if (fep->phy_interface == PHY_INTERFACE_MODE_RMII)
> -			rcntl |= (1 << 8);
> +			rcntl |= FEC_RCR_RMII;
>  		else
> -			rcntl &= ~(1 << 8);
> +			rcntl &= ~FEC_RCR_RMII;
>  
>  		/* 1G, 100M or 10M */
>  		if (ndev->phydev) {
>  			if (ndev->phydev->speed == SPEED_1000)
>  				ecntl |= (1 << 5);
>  			else if (ndev->phydev->speed == SPEED_100)
> -				rcntl &= ~(1 << 9);
> +				rcntl &= ~FEC_RCR_10BASET;
>  			else
> -				rcntl |= (1 << 9);
> +				rcntl |= FEC_RCR_10BASET;
>  		}
>  	} else {
>  #ifdef FEC_MIIGSK_ENR
> @@ -1181,7 +1194,7 @@ fec_restart(struct net_device *ndev)
>  	if ((fep->pause_flag & FEC_PAUSE_FLAG_ENABLE) ||
>  	    ((fep->pause_flag & FEC_PAUSE_FLAG_AUTONEG) &&
>  	     ndev->phydev && ndev->phydev->pause)) {
> -		rcntl |= FEC_ENET_FCE;
> +		rcntl |= FEC_RCR_FLOWCTL;
>  
>  		/* set FIFO threshold parameter to reduce overrun */
>  		writel(FEC_ENET_RSEM_V, fep->hwp + FEC_R_FIFO_RSEM);
> @@ -1192,7 +1205,7 @@ fec_restart(struct net_device *ndev)
>  		/* OPD */
>  		writel(FEC_ENET_OPD_V, fep->hwp + FEC_OPD);
>  	} else {
> -		rcntl &= ~FEC_ENET_FCE;
> +		rcntl &= ~FEC_RCR_FLOWCTL;
>  	}
>  #endif /* !defined(CONFIG_M5272) */
>  
> @@ -1207,13 +1220,13 @@ fec_restart(struct net_device *ndev)
>  
>  	if (fep->quirks & FEC_QUIRK_ENET_MAC) {
>  		/* enable ENET endian swap */
> -		ecntl |= (1 << 8);
> +		ecntl |= FEC_ECR_BYTESWP;
>  		/* enable ENET store and forward mode */
> -		writel(1 << 8, fep->hwp + FEC_X_WMRK);
> +		writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
>  	}
>  
>  	if (fep->bufdesc_ex)
> -		ecntl |= (1 << 4);
> +		ecntl |= FEC_ECR_EN1588;
>  
>  	if (fep->quirks & FEC_QUIRK_DELAYED_CLKS_SUPPORT &&
>  	    fep->rgmii_txc_dly)
> @@ -1312,7 +1325,8 @@ static void
>  fec_stop(struct net_device *ndev)
>  {
>  	struct fec_enet_private *fep = netdev_priv(ndev);
> -	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & (1 << 8);
> +	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & FEC_RCR_RMII;
> +	u32 ecntl = 0;
>  	u32 val;
>  
>  	/* We cannot expect a graceful transmit stop without link !!! */
> @@ -1345,9 +1359,11 @@ fec_stop(struct net_device *ndev)
>  	/* We have to keep ENET enabled to have MII interrupt stay working */
>  	if (fep->quirks & FEC_QUIRK_ENET_MAC &&
>  		!(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
> -		writel(2, fep->hwp + FEC_ECNTRL);
> +		ecntl |= FEC_ECR_ETHEREN;
>  		writel(rmii_mode, fep->hwp + FEC_R_CNTRL);
>  	}
> +
> +	writel(ecntl, fep->hwp + FEC_ECNTRL);
>  }
>  
>  

