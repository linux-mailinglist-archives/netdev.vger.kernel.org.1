Return-Path: <netdev+bounces-94570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 253308BFE8C
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A94B24D69
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0282A6D1B0;
	Wed,  8 May 2024 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8Slb87X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E536A33F
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174338; cv=none; b=YkbdL1R31GK9rAmGrOXo58WrJMUnIIV5B3DSws3xQTwK7CVt34sBt8M65cE6lj82QvOvKnyzhIwUAaAIbF5QIeElyLRws4oiWE72UP5V0ToMTYG+KZGmDRMUT9979Ho7zyKq+5XEUexRARHNZRUmAZtA3//m+vqbnc77fg9po3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174338; c=relaxed/simple;
	bh=7W9AaIllb6ak1NfcIyBdZHHaSUx4zTJeeA1oiTTlioY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NHNjZ9YpB4IPhO3foVVqUqKE9gkiTCzo4McM35E8qMq4Fjx8Y7kaEF6z9SOyDGLqqrkM5npQLAHkv2A/PzwdZJAPz+aILafmoWHybh2B5zfrbg0zSd5V1VRdkQXTVxGSaS1delgJGTHHtw+hCNwnravKqA1Xsf80prEwLlO4b1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8Slb87X; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-632922a69beso9010a12.0
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 06:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715174335; x=1715779135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LdI+A987HMuVO6XmITvp2Pr2b2c868z0K1gL3SCWSAk=;
        b=d8Slb87X9hHMuAs86T3h7f6Mj1U+7n/9Ly6UA0SeqEHXUfJoG21p4tNhqNu1J6mKjF
         7FsbGtnPRfTRCoPROGMAe2jn3oj3P4y8sSq+daTmT/I8G8cpD0z7oFldIatFYncKgwB2
         O4pbpekrdyYOWqKfkv7wtIDCwlxmOGJjU7Uq9EbnsKCET3H888owRqmJvegr5dcVkYSx
         mQKKfWy2IQyBzK4GdbKojETtmm/cHSY4oUJ+4kRxBQf34bJiDskxtt6z7gy906VQsKRN
         9FKZNaROm/RmZpyuhnOgp8rI0GwjTr6J1iPvCg3wUTr/11O8hGD4tEpOeVkufs0S3qaV
         ZSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715174335; x=1715779135;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LdI+A987HMuVO6XmITvp2Pr2b2c868z0K1gL3SCWSAk=;
        b=T/1LRq1PxLspT997xXLZAHdBZtVCSb/cnXP0TyxQ8rq94jrlDAF+wHbnYjMJElGxnd
         eRtRIsfmHAz/WR39C2PvXUkDq874ASKIZFHaCH3XjbkLSX9kpMAJbXmS5CIeou30054K
         8Z+E/mtylaL3coK12rfIJY17rWqd3ZqAeqgjvE+8i++AzZkF5VKbDPHiPI+bSJDY5kxK
         QhebqC2bg+C5XNTs9mo+ZzvlyZss/MjzfZKNIZV/j2b8/hQnZaK/cH/Sfz4xm6AZy9KF
         Ag/Eejwj0QcuwsVyB4hVu6nTDJ0RRbgOh7uXIFLe+U18NwWUV5CVNBNOQTym/wOVC55/
         wE2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3gMfgdlOm6PqXREHgmBN0SVTd7WgwZvQmiFsyjHv0e4UqYpyjvMz9A9wj+uip7LNaYXqtXfeYPu0HsYPloz8Lc0nF2NYa
X-Gm-Message-State: AOJu0YxbNkcAvTdFAhabL4VHDbBEAJQhRYNwhw44ZhmBEKmiJQOgW4vb
	R5BrY9A7IdcO+fArjA2QiUoSY59kVNg+zkZJCBfWUKMIpo1lD+vTyviUWBrx
X-Google-Smtp-Source: AGHT+IF6EK2Pyn6ut34TmhaxHjTNkpNydtebgzfhik18bH5+7RrM8miyRd/ZUxEY95Q7APjZ8mMtSA==
X-Received: by 2002:a05:6a20:7f9b:b0:1ae:37f8:646a with SMTP id adf61e73a8af0-1afc8de7f48mr2947364637.5.1715174335111;
        Wed, 08 May 2024 06:18:55 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id kt25-20020a056a004bb900b006ea7d877191sm11099781pfb.2.2024.05.08.06.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 06:18:54 -0700 (PDT)
Date: Wed, 08 May 2024 22:18:51 +0900 (JST)
Message-Id: <20240508.221851.1563324062182870165.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, kuba@kernel.org,
 jiri@resnulli.us, horms@kernel.org
Subject: Re: [PATCH net-next v4 6/6] net: tn40xx: add PHYLIB support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <7bd09ce5-5844-4836-a044-c507f65c051d@lunn.ch>
References: <20240501230552.53185-1-fujita.tomonori@gmail.com>
	<20240501230552.53185-7-fujita.tomonori@gmail.com>
	<7bd09ce5-5844-4836-a044-c507f65c051d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Wed, 8 May 2024 14:21:29 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> --- a/drivers/net/ethernet/tehuti/tn40.c
>> +++ b/drivers/net/ethernet/tehuti/tn40.c
>> @@ -7,6 +7,7 @@
>>  #include <linux/if_vlan.h>
>>  #include <linux/netdevice.h>
>>  #include <linux/pci.h>
>> +#include <linux/phylink.h>
>>  
>>  #include "tn40.h"
>>  
>> @@ -1185,21 +1186,25 @@ static void tn40_link_changed(struct tn40_priv *priv)
>>  	u32 link = tn40_read_reg(priv,
>>  				 TN40_REG_MAC_LNK_STAT) & TN40_MAC_LINK_STAT;
>>  	if (!link) {
>> -		if (netif_carrier_ok(priv->ndev) && priv->link)
>> +		if (netif_carrier_ok(priv->ndev) && priv->link) {
>>  			netif_stop_queue(priv->ndev);
>> +			phylink_mac_change(priv->phylink, false);
>> +		}
> 
> What exactly does link_changed mean?
> 
> The normal use case for calling phylink_mac_change() is that you have
> received an interrupt from something like the PCS, or the PHY. The MAC
> driver itself cannot fully evaluate if the link is up because there
> can be multiple parts in that decision. Is the SFP reporting LOS? Does

The original driver receives an interrupt from an PHY (or something),
then reads the register (TN40_REG_MAC_LNK_STAT) to evaluate the state
of the link; doesn't use information from the PHY.


> the PCS SERDES have sync, etc. So all you do is forward the interrupt
> to phylink. phylink will then look at everything it knows about and
> decide the state of the link, and maybe call one of the callbacks
> indicating the link is now up/down.

What function should be used to forward an interrupt to phylink?
equivalent to phy_mac_interrupt() in phylib.


>>  		priv->link = 0;
>>  		if (priv->link_loop_cnt++ > TN40_LINK_LOOP_MAX) {
>>  			/* MAC reset */
>>  			tn40_set_link_speed(priv, 0);
>> +			tn40_set_link_speed(priv, priv->speed);
>>  			priv->link_loop_cnt = 0;
> 
> This should move into the link_down callback.

I'll try phylink callbacks to see if they would work. 


>> -	if (!netif_carrier_ok(priv->ndev) && !link)
>> +	if (!netif_carrier_ok(priv->ndev) && !link) {
>>  		netif_wake_queue(priv->ndev);
> 
> and this should be in the link_up callback.
>> +static void tn40_link_up(struct phylink_config *config, struct phy_device *phy,
>> +			 unsigned int mode, phy_interface_t interface,
>> +			 int speed, int duplex, bool tx_pause, bool rx_pause)
>> +{
>> +	struct tn40_priv *priv = container_of(config, struct tn40_priv,
>> +					      phylink_config);
>> +
>> +	priv->speed = speed;
> 
> This is where you should take any actions needed to make the MAC send
> packets, at the correct rate.
> 
>> +}
>> +
>> +static void tn40_link_down(struct phylink_config *config, unsigned int mode,
>> +			   phy_interface_t interface)
>> +{
> 
> And here you should stop the MAC sending packets.
> 
>> +}
> 
>> +
>> +static void tn40_mac_config(struct phylink_config *config, unsigned int mode,
>> +			    const struct phylink_link_state *state)
>> +{
> 
> I know at the moment you only support 10G. When you add support for
> 1G, this is where you will need to configure the MAC to swap between
> the different modes. phylink will tell you which mode to use,
> 10GBaseX, 1000BaseX, SGMII, etc. You might want to move the existing
> code for 10GBaseX here.

Yeah.

The original driver configures the MAC for 10G with QT2025 PHY so I'm
not sure things would work well. I'll experiment once I get 1G SFP.


> For the next version, please also Cc: Russell King, the phylink
> Maintainer.

Sure, I'll do in v6.

