Return-Path: <netdev+bounces-99774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B688D65B7
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 17:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA6E28208B
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D477476056;
	Fri, 31 May 2024 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLZv25ex"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A406145322
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717169384; cv=none; b=HFUl5XvEh6GasSch/RNFuRZ3yE32DlSv16N2mTKVgiy6PTOKxfARmMso0/hA2uQk65A0uuMxMgY6sD6+M4D1wN4+NV1k9+0TQ4M4Sq/tJYqO6bj+W4z/gLAdQzdw/5HYueKQLQXkm0iydor1WXawhItTyvPn2Pi58J9x+tiWVMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717169384; c=relaxed/simple;
	bh=fllUMioFigpnuXG5v/8MSfQ+cbOEvmiZP2rbUtPRAHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHeGRO9F3SHzhITt3BItAw68g/PuZZ0IHlvYe/d7AVssQIG9IUjeMxOZK4ybL2xPWYxqVov4kgOoRSAjOaN24RfanHGUJS60ywyn93z0XwBlv8Yqm3cqdhQ1CkaegAXKNBwPlk9b0i6aOfvmPeOqn5erFHP7jNHwfkd7slp0j6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLZv25ex; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35dbdd76417so1530548f8f.3
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717169381; x=1717774181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=64eSeeLZfz+l4OXTxOygf1g3YFXP0kCG/ATwKLcSgrE=;
        b=ZLZv25exEGUHVnkRefh4T8dpjM9mSXg8NSvsKvsBqDaD+36ixUvH5H990c9Sen1iXp
         5DNPjDJKLFTeoIVr/OZ6LfjQdv9Sla3VQpA3ee/u/qY6uEhd5zUO32Bvt/pfd8ZRYorV
         fXoFBE2pJwWjWA2t/nygBxTxBUNFXgQZCD9zFpCmcNLxJEuvj2QKYs3Hgea+lnyRiGEw
         PAni0tEmFrwabXunNlOOuBP/i+TZ+Hn9JE27+kOYUMQgfRwDldTL92XYRBU0SAb2uA1Y
         7cDjIwo2DTlkWetVP788dT6X9TnTVM+E/QOfGQHqIq6oZLJ2AzNboxBvAVqfBDA7Ga+q
         CaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717169381; x=1717774181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64eSeeLZfz+l4OXTxOygf1g3YFXP0kCG/ATwKLcSgrE=;
        b=JGVVttSGLW8/Gduqfdm1WvbLOFgRoEYXF2iWTuRHmtlyTMYCD+BOMilXcQRbn/ubDs
         spxOs0b8CQ14+2Z69yeuwkAVDsda5m8I1hzqRrbawNP7B5ef4FwPHvwkOJeq0Fh/yTU4
         bFXi5GV+MYGaJhR2kBVc5gdBsScIeQZcBuA9XZnDHGzqxMMvi9HseJCJt5+pl3coH2yd
         NXLkd4Rsi1bAzPgZhBH2f9VNYBZSLMBVR94WA5n9nBzJAZJkEI4+sn6t5BC9OJOwvmR0
         oH92y+AQlmEn6I9qdVNVl4KfCNooV4Rsgb7GgmDX8TfK5Tb7X6KMNac9IGuPTPJ8FimC
         T4MA==
X-Forwarded-Encrypted: i=1; AJvYcCX5tZEgkTimQ6TmXJ5l5NDCWZ1wOhEgxyOTFGeHO7B28cyFFaRI60Hu7xFmvxKpTkW95H/BNlXsc/eR7XmKxP3pvrjz4E1W
X-Gm-Message-State: AOJu0YzjiWESAX8M5G6RH45oJ77hQshoGjakQro3/LQhdNMe3UXbiP33
	9WuVxvQ8VgTRqoggfEo/w2Uv5F29PvNE4sy0e28ao3UDbsMbAu+a
X-Google-Smtp-Source: AGHT+IGzuCH9vX/otKQW2OYNgml3cLhHfWGuc+tWlj1uYksO/uTaT+GPA8R7XKzjS4/sLTSwmWRSWA==
X-Received: by 2002:a5d:66c6:0:b0:354:de8e:b66b with SMTP id ffacd0b85a97d-35e0f325fecmr2035067f8f.52.1717169380832;
        Fri, 31 May 2024 08:29:40 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd064b5e9sm2084256f8f.96.2024.05.31.08.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 08:29:40 -0700 (PDT)
Date: Fri, 31 May 2024 18:29:37 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: remove obsolete phylink dsa_switch
 operations
Message-ID: <20240531152937.p2qrx6vzximpst4e@skbuf>
References: <E1sCxVx-00EwVY-E2@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sCxVx-00EwVY-E2@rmk-PC.armlinux.org.uk>

On Fri, May 31, 2024 at 09:21:29AM +0100, Russell King (Oracle) wrote:
> No driver now uses the DSA switch phylink members, so we can now remove
> the shim functions and method pointers. Arrange to print an error
> message and fail registration if a DSA driver does not provide the
> phylink MAC operations structure.
> 
> Signed-off-by: Russell King (oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  include/net/dsa.h | 15 ----------
>  net/dsa/dsa.c     |  9 ++----
>  net/dsa/port.c    | 74 +----------------------------------------------
>  3 files changed, 4 insertions(+), 94 deletions(-)
> 
> diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
> index 668c729946ea..ceeadb52d1cc 100644
> --- a/net/dsa/dsa.c
> +++ b/net/dsa/dsa.c
> @@ -1505,12 +1505,9 @@ static int dsa_switch_probe(struct dsa_switch *ds)
>  	if (!ds->num_ports)
>  		return -EINVAL;
>  
> -	if (ds->phylink_mac_ops) {
> -		if (ds->ops->phylink_mac_select_pcs ||
> -		    ds->ops->phylink_mac_config ||
> -		    ds->ops->phylink_mac_link_down ||
> -		    ds->ops->phylink_mac_link_up)
> -			return -EINVAL;
> +	if (!ds->phylink_mac_ops) {
> +		dev_err(ds->dev, "DSA switch driver does not provide phylink MAC operations");
> +		return -EINVAL;
>  	}
>  
>  	if (np) {
> diff --git a/net/dsa/port.c b/net/dsa/port.c
> index e23db9507546..a31a5517a12f 100644
> --- a/net/dsa/port.c
> +++ b/net/dsa/port.c
> @@ -1625,12 +1560,8 @@ int dsa_port_phylink_create(struct dsa_port *dp)
>  		}
>  	}
>  
> -	mac_ops = &dsa_port_phylink_mac_ops;
> -	if (ds->phylink_mac_ops)
> -		mac_ops = ds->phylink_mac_ops;
> -
>  	pl = phylink_create(&dp->pl_config, of_fwnode_handle(dp->dn), mode,
> -			    mac_ops);
> +			    ds->phylink_mac_ops);
>  	if (IS_ERR(pl)) {
>  		pr_err("error creating PHYLINK: %ld\n", PTR_ERR(pl));
>  		return PTR_ERR(pl);

Nack. The highlighted portions break dsa_loop, hellcreek and mv88e6060 [1],
which are currently trivially integrated with phylink through the
default dsa_port_phylink_mac_ops, but have no implementations of
ds->ops->phylink_mac_* of their own.

What I'm trying to point out is that we are not at the stage yet where
we can enforce all drivers to populate ds->phylink_mac_ops.

> @@ -1831,9 +1762,6 @@ static void dsa_shared_port_link_down(struct dsa_port *dp)
>  	if (ds->phylink_mac_ops && ds->phylink_mac_ops->mac_link_down)

Mostly irrelevant, but I'll point out an issue with the patch logic's
consistency anyway: there is no need to check "if (ds->phylink_mac_ops)"
more than once. The earlier probe failure is sufficient (although, as
mentioned, breaking for 3 drivers).

>  		ds->phylink_mac_ops->mac_link_down(&dp->pl_config, MLO_AN_FIXED,
>  						   PHY_INTERFACE_MODE_NA);
> -	else if (ds->ops->phylink_mac_link_down)
> -		ds->ops->phylink_mac_link_down(ds, dp->index, MLO_AN_FIXED,
> -					       PHY_INTERFACE_MODE_NA);
>  }
>  
>  int dsa_shared_port_link_register_of(struct dsa_port *dp)
> -- 
> 2.30.2
> 

[1] Quick way to check: compare the outputs of these 2 commands, and see
which drivers from the first category are absent from the second:
$ grep -r dsa_register_switch drivers/net/dsa/ | cut -d: -f1 | sort | uniq
$ grep -r phylink_mac_ops drivers/net/dsa/ | cut -d: -f1 | sort | uniq

