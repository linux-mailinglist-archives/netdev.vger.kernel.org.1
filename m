Return-Path: <netdev+bounces-61899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBFF8252EE
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 12:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B902B20D9F
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 11:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE4A2C1A9;
	Fri,  5 Jan 2024 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVv0r2CM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614922D04E
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55569b59f81so1742384a12.1
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 03:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704454370; x=1705059170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLGtZhLw3cgxZbHAxZLx9WNkyjIpH4syuFZZ7gJkum8=;
        b=kVv0r2CMbrESd2AyLB9/4bpFgpInXDpY7HzhmJoU3c+y78ermZRaBtaua5rj7drfWe
         4qcnU8HzCKlO9UFnWxbVuSodS0g0veBMWMsGmrid6sWv+vSV+ln7rSw8r08aJp4lR5Dd
         N8K8yYUJ76SoQ7HSw+AC8ckK8V68CNCSlvTxNPD5RqmAO/up1J8zpJy63u7yiKW9ajV4
         5tdHJA27DSUDOt1/HWJuqVb32uxnszaP+N9w+BJ1Scfu5KXzUlAQ0TBH4eZ7u//aZd3l
         e7zZ0oKDHOYq0pP98Dc/p6H5cdEsskgwaGj1nL3PkUPFc7mYt0XlXht3XdquVW59AOZV
         q3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704454370; x=1705059170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLGtZhLw3cgxZbHAxZLx9WNkyjIpH4syuFZZ7gJkum8=;
        b=DJYzrVCrLYt/Rb3OxWuxCXltQWEVCdPp+0NbT2RZA8pZiGc8JOoKBD+5VpPc9m42Xa
         JVCPL4RT0yfFa/VXSkICr+bD9VQkNNZN+HvFCiUfDE/KmvHnGaybm0zZgaAX3oyxlPuC
         qz9QJKqgGO6jUFUwozganFkJHeWK1/NTweqFy1r5PENmT9WQROYRuOeW6iofYGvti6t9
         nFswKuv3DIiE6yanksHTGYXJrnAa5Rota6rBnVneOS1XiHMzPyn/BKSGTEOdTK5BskbH
         uniscxxM3c/y6mucEaB6scr5cHR1mZ3ttL5KuWxuJB5vgi7EzWTPg5K0l3Ilu3YyxvV0
         W/GA==
X-Gm-Message-State: AOJu0Yz4RkR0iypfg1tHk2xtC8gVJZ1ulSxJYH6skXKBLDdZBjninsEB
	c6cnLX3qz8lxKM/PvRvDuK4Xnl4dOYZwpg==
X-Google-Smtp-Source: AGHT+IFxIv4VXC9y+Q+SMOlBfZf4em5K4Yw7zqjtu8KkOHCSbpFtimVSIM8IWjW7/QhhWHPOQQZ14Q==
X-Received: by 2002:a50:d4c3:0:b0:557:1d4a:ea64 with SMTP id e3-20020a50d4c3000000b005571d4aea64mr582210edj.8.1704454370326;
        Fri, 05 Jan 2024 03:32:50 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id g8-20020aa7d1c8000000b0055703db2c9fsm876713edp.1.2024.01.05.03.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 03:32:50 -0800 (PST)
Date: Fri, 5 Jan 2024 13:32:47 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Household Cang <canghousehold@aol.com>,
	Romain Gantois <romain.gantois@bootlin.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v5 1/2] net: ethernet: cortina: Drop software
 checksum and TSO
Message-ID: <20240105113247.wml4ldq3abvizi2a@skbuf>
References: <20240102-new-gemini-ethernet-regression-v5-0-cf61ab3aa8cd@linaro.org>
 <20240102-new-gemini-ethernet-regression-v5-1-cf61ab3aa8cd@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102-new-gemini-ethernet-regression-v5-1-cf61ab3aa8cd@linaro.org>

On Tue, Jan 02, 2024 at 09:34:25PM +0100, Linus Walleij wrote:
> @@ -1143,39 +1142,13 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
>  	struct gmac_txdesc *txd;
>  	skb_frag_t *skb_frag;
>  	dma_addr_t mapping;
> -	unsigned short mtu;
>  	void *buffer;
> -	int ret;
> -
> -	mtu  = ETH_HLEN;
> -	mtu += netdev->mtu;
> -	if (skb->protocol == htons(ETH_P_8021Q))
> -		mtu += VLAN_HLEN;
>  
> +	/* TODO: implement proper TSO using MTU in word3 */
>  	word1 = skb->len;
> -	word3 = SOF_BIT;
> -
> -	if (word1 > mtu) {
> -		word1 |= TSS_MTU_ENABLE_BIT;
> -		word3 |= mtu;
> -	}
> +	word3 = SOF_BIT | skb->len;
>  
> -	if (skb->len >= ETH_FRAME_LEN) {
> -		/* Hardware offloaded checksumming isn't working on frames
> -		 * bigger than 1514 bytes. A hypothesis about this is that the
> -		 * checksum buffer is only 1518 bytes, so when the frames get
> -		 * bigger they get truncated, or the last few bytes get
> -		 * overwritten by the FCS.
> -		 *
> -		 * Just use software checksumming and bypass on bigger frames.
> -		 */
> -		if (skb->ip_summed == CHECKSUM_PARTIAL) {
> -			ret = skb_checksum_help(skb);
> -			if (ret)
> -				return ret;
> -		}
> -		word1 |= TSS_BYPASS_BIT;
> -	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {

So are you taking back the statement that "Hardware offloaded
checksumming isn't working on frames bigger than 1514 bytes"?

Have you increased the interface MTU beyond 1500, and tested with plain
TCP (no DSA) on top of it? Who will provide the TCP checksum for them now?

I don't understand why you remove the skb_checksum_help() call.
It doesn't play nice with skb_is_gso() packets, agreed, but you removed
the TSO netdev feature.

> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
>  		int tcp = 0;
>  
>  		/* We do not switch off the checksumming on non TCP/UDP
> 
> -- 
> 2.34.1
> 

