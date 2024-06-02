Return-Path: <netdev+bounces-99983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CDF8D761D
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 16:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8F82827B3
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 14:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFAC40861;
	Sun,  2 Jun 2024 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQNuF2ni"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8C32628D;
	Sun,  2 Jun 2024 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717337731; cv=none; b=ILdq/t7Luoa4vRCzldzdXZog86vtEeREyZ9nC7GM0Hf7gxhB4MAXoldp2bbyKkP5rF3JAJcI3kcEzW/onMsHH25v+2qD4whDNFyqge/v62bQFduPJErhF3T+99S7Ak/nFbc6NybHDPMV6yBxE8ctAU9pgJAt9SRh2oWyn2Ku/iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717337731; c=relaxed/simple;
	bh=yRl0Zy6wzI7m8PsJn21x3czS9XtE5+g9dbkMjfOVvSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlCHbRkFSt4WZfZIoWqorkN1V0eSeaTfOZK1y/g4d6Cx1Jq9zxgAJqWtHhKjD9cxQYO8T0+QrWPmZV9ylLjgEgZ4Vy3QAHpUWB1jbMcbG6Q/WAt54uZ3nDTpd5MD7DsKpjHgpUpeIQ5AdLfkVqYtIB3in8LLEbzUwVjDsyPkKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQNuF2ni; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e95a75a90eso37786681fa.2;
        Sun, 02 Jun 2024 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717337728; x=1717942528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KpXeC176RaICWlSlxpJ+NDHy2MPx5eaGXOEoT5L913w=;
        b=aQNuF2niJA3QVpSN2o5KWli9J/p0jlLW+Qm0PkZRCQgo7ojgrmYFoFn9Ziq+YavUBb
         k7znzSNeHn6rKlOGIyMQfwleISloEn4DuUd0cGAHMx8fBl9hrcClZObeMPIGaw/9s2S5
         K0NDyFZUpJtg7iZ40y3S0qVguQeu5LDcPFdBxkqFcbhhwpMkFwdAY5epXBfcUgD6fW1d
         gvmBQMpGDqNL4co+YzF8vyphrP+SFdigt3w0IS0uOJoSSr99HXo12VuowY9E5LbL3Tk0
         M/1TBCgGbpq0jwXup0X0aMnhmSCRRByikEs9SlLxnRCQLVglpjZRm+hVt85DVUSNIZZW
         qNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717337728; x=1717942528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpXeC176RaICWlSlxpJ+NDHy2MPx5eaGXOEoT5L913w=;
        b=Xlzx6DarQFBZbQu/lso4JXnnuk9GPOOnCVh0VsicAx5nBo6wrue4b53nOWdSIE9QQn
         6hJhBFMP9LcA0N6l7zyVw88NL7Tjqg43bGhomM9IzwNo36jNdUHKi8R1AXRDiZVga3Mg
         oeO0ejNksHl6n+cBMwGyW7DoJFrpcz0YWNiy2ZGrb9+5lk04UfflYYXMaIIQRk/SFPQ8
         pTTrVHaK2rzghgcgvq8BgInfE67N+eqqbcSfjxyFwmQTYNVept/5qEQ5nAhkM/8tUgIB
         PCQ6OUNJzPdyHY/xEKR1PqKK5DC8ykVBcBGfLowzwBXxdltqFaczsWLwMycfJploL44M
         WIBg==
X-Forwarded-Encrypted: i=1; AJvYcCWOVka6FnvMho/I8+6lqZeohSDYT8taGY6aSNGVIBeSWMTqZsP2fmCXlOYLGbMjiN4cQtGrguxGyTeadE6DvZgksHIj0eyhq2pyugp82g+Tz7dnzCEg7sXohIhFKfi15ZtjFi6U
X-Gm-Message-State: AOJu0YzSRA2UwDYWUwj0s0GkSBfS2I00UFPa0RDKzXZMN6X3wk6uovg2
	6xL7lKPp3tLbA3cIU0ElA7teoDzD0QgIWc2bTd5HTTyHOkwOdcuK
X-Google-Smtp-Source: AGHT+IHhCeDc8Zsm3l7ZPMhThg8eoRnqf8HB2t/6rIPuOLXgMXpgQd1zMhnyuc4dATN2jc6yS4R9jA==
X-Received: by 2002:a2e:99c2:0:b0:2ea:8abe:2319 with SMTP id 38308e7fff4ca-2ea94f69880mr43253701fa.0.1717337727848;
        Sun, 02 Jun 2024 07:15:27 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a5dc1e2d6sm760305a12.59.2024.06.02.07.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 07:15:27 -0700 (PDT)
Date: Sun, 2 Jun 2024 17:15:24 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Tristram.Ha@microchip.com
Cc: Arun Ramadoss <arun.ramadoss@microchip.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net] net: dsa: microchip: fix wrong register write
 when masking interrupt
Message-ID: <20240602141524.iap3b6w2dxilwzjg@skbuf>
References: <1717119553-3441-1-git-send-email-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717119553-3441-1-git-send-email-Tristram.Ha@microchip.com>

On Thu, May 30, 2024 at 06:39:13PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> Initially the macro REG_SW_PORT_INT_MASK__4 is defined as 0x001C in
> ksz9477_reg.h and REG_PORT_INT_MASK is defined as 0x#01F.  Because the
> global and port interrupt handling is about the same the new
> REG_SW_PORT_INT_MASK__1 is defined as 0x1F in ksz_common.h.  This works
> as only the least significant bits have effect.  As a result the 32-bit
> write needs to be changed to 8-bit.
> 
> Fixes: e1add7dd6183 ("net: dsa: microchip: use common irq routines for girq and pirq")
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> ---
> v1
>  - clarify the reason to change the code

After v1 comes v2.

> 
>  drivers/net/dsa/microchip/ksz_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 1e0085cd9a9a..3ad0879b00cd 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -2185,7 +2185,7 @@ static void ksz_irq_bus_sync_unlock(struct irq_data *d)
>  	struct ksz_device *dev = kirq->dev;
>  	int ret;
>  
> -	ret = ksz_write32(dev, kirq->reg_mask, kirq->masked);
> +	ret = ksz_write8(dev, kirq->reg_mask, kirq->masked);
>  	if (ret)
>  		dev_err(dev->dev, "failed to change IRQ mask\n");
>  
> -- 
> 2.34.1
> 

What is the user-visible functional impact of the 32-bit access? Justify
why this is a bug worth sending to stable kernels please.

FWIW, struct ksz_irq operates on 16-bit registers.

