Return-Path: <netdev+bounces-87853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310F28A4C96
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 12:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5CB91F21047
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDA95B20F;
	Mon, 15 Apr 2024 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG5HhCcv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1046C79E4
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177299; cv=none; b=KmvYubNyodldPAaWPT9VJHXwrBOb8LHGuOkzwz77LntSSv4azBVXyjVEy2hFTLwjfNEBnImJpa0NiI50CO/au7zXnBlTT5uXKzb8B44CDv+g78vog4wh2RkVl+nggLYSmxobwScwePYa1LGO/+v8b4kSKe5YvmhbyA6Kx5NQvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177299; c=relaxed/simple;
	bh=sIkGD+UlTio5VwUPjYHrkrecbxnJD8tokNkDyiOrefk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVcVyPyvB3lOhf0+99eMY5+wINgBykgT3hpicy7HGimdppTzogHw8yVeZdbKABjdWz28e5uk9CTp0fwGQ658rCB6ElLZFlvHAQrRR/WoEb8/MjpdhpEamCtZIQZu69bhGWBNMaNDxUfXgxOB0skxLLgP5oSPnhHIlpwrBuK5svI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eG5HhCcv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41879f3d204so1532765e9.3
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 03:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713177296; x=1713782096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MzmAEVbhsnmBQmDcqWmoGxaX8bUPK6xwQF3hL58f3tI=;
        b=eG5HhCcv42sqsuIoFi/9HlqRpp8he1fiNB0bZkGIdiRluVttInvUin/4GGPe8hKtIB
         amliA7gCT41sADiFsoNv218XVeIGb221UvjnxLWTLPr0UityNuGgBZiSlhY5OvMHRCqN
         CcuXifIj3kfgWD2KpCF5Q8ypXnbq6bN5RdHgc88NyBrQtmco2dS7X1+v9KyNVnUIWFQ5
         8JJUi6kiBs75bNEZ6/s/X4d0GUmlhF/ySq6mbt8Q/lT5rDt9zsG63PJ5ehA5LUujjpag
         3SGCaDFfk26WfoKC8LXBXK25LXVpOkqOpK+842wbimfTHwIUzOUw7wv1bPQ1WoZBXnyd
         eovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713177296; x=1713782096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzmAEVbhsnmBQmDcqWmoGxaX8bUPK6xwQF3hL58f3tI=;
        b=CAg+DUgBUalYhOOGYq+p6lFmMHfV02vCxl5Dt0TooqF7dKPo51E2KUFP80FVh+y3K9
         ZjxmlZwr7Xej6JuhsQD/MQ/F9+dQwYsyEZyjfHB/D7cTOE0OGBUl7maGAfcHSlPNa6vE
         UMFvxG1reA3LKWk0utylWsz4Asw3R6QQ1fQTS63EVXUgmrHKua0Sel27LkCvE+f79LoN
         ynnC74Lgx+8xElp3u14N8UL3V6xxpnYKJ3C4QotUV6l4ewGzDBONnKGopFMrW1I86ev7
         +O1OXZX3THANzuEAi24IPSXpYiTn2R2HsUfBxwpKyIA0IjDIKrBp8s0XsHWBD4f32Wsu
         oKUw==
X-Forwarded-Encrypted: i=1; AJvYcCU6hXhCcugIsNMB1pz93q4cylWudRkIBRwwjW4Lbgfl7Fy9FYOO+A4XzvZknxeiJ7VVB2NAuSoq/X0AbJAYEDvOWSoHvOsi
X-Gm-Message-State: AOJu0YzEOQHEyuqMCxras3vL2bwrxZzzsQJHOuScmro4rbpMfta58qLB
	rJ3tvKoBI5COtAggHKiKM3z3yCtVBVsv9fO6IixSK+PF7T9mvFvr
X-Google-Smtp-Source: AGHT+IGkrQtZHQV1zcIjVmX3u+QzY+SzQ4vM99MvPoAblRznBtSQrop76LKXWCtSlXeLSzhJavug/g==
X-Received: by 2002:a05:600c:1547:b0:418:681c:f214 with SMTP id f7-20020a05600c154700b00418681cf214mr1023041wmg.8.1713177296067;
        Mon, 15 Apr 2024 03:34:56 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d108:9b00:f547:f722:ecdd:8689])
        by smtp.gmail.com with ESMTPSA id gw7-20020a05600c850700b004146e58cc35sm19216910wmb.46.2024.04.15.03.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:34:55 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:34:53 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Colin Foster <colin.foster@in-advantage.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: felix: provide own phylink MAC
 operations
Message-ID: <20240415103453.drozvtf7tnwtpiht@skbuf>
References: <E1rvIcO-006bQQ-Md@rmk-PC.armlinux.org.uk>
 <E1rvIcO-006bQQ-Md@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rvIcO-006bQQ-Md@rmk-PC.armlinux.org.uk>
 <E1rvIcO-006bQQ-Md@rmk-PC.armlinux.org.uk>

On Fri, Apr 12, 2024 at 04:15:08PM +0100, Russell King (Oracle) wrote:
> Convert felix to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> diff --git a/drivers/net/dsa/ocelot/ocelot_ext.c b/drivers/net/dsa/ocelot/ocelot_ext.c
> index 22187d831c4b..a8927dc7aca4 100644
> --- a/drivers/net/dsa/ocelot/ocelot_ext.c
> +++ b/drivers/net/dsa/ocelot/ocelot_ext.c
> @@ -96,6 +96,7 @@ static int ocelot_ext_probe(struct platform_device *pdev)
>  	ds->num_tx_queues = felix->info->num_tx_queues;
>  
>  	ds->ops = &felix_switch_ops;
> +	ds->phylink_mac_ops = &felix_phylink_mac_ops;

There are actually 2 more places which need this: felix_vsc9959.c,
seville_vsc9953.c.

>  	ds->priv = ocelot;
>  	felix->ds = ds;
>  	felix->tag_proto = DSA_TAG_PROTO_OCELOT;
> -- 
> 2.30.2
> 

---
pw-bot: cr

