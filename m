Return-Path: <netdev+bounces-73756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D8A85E297
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 17:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52DECB21B47
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EFA81736;
	Wed, 21 Feb 2024 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JPfLPTXM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D4785C48
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531386; cv=none; b=qtpeNDAS9A3qQ02OkdwUyFrJFmL+sKMXpNcDd+Zhuj+7+BU6k2Di/qBq4g+KlOCWGfPuBxlmrwzNYnzsHDji6KLO9iM+jkPX+RZ30VtgEDsVTnLRg1lj2rWaPjO/BOEszbP52YS6a75hAMNHzwfiJ+GGTVcbSTaZy677/Dn8vlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531386; c=relaxed/simple;
	bh=dgKPJgYUdNC4HjonLKTL0MnIIXxZ8wVCNFRZsaKzi8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pngw/Xn9s5h4kpLI+qS/PIinMPr8+oUvNWYxcee2qAUcd7eqdy7Rc8KPBBi+Jj/dH0OBp0/aivnXqd9MlhAnWLflNefiSbUsHmVNQ23hcI8YFGzdQ3AtgxKDGZKijFshmt32dpbiNfJEEUHSBnpwQq0DAKJB8apG00atecKO7QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JPfLPTXM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41241f64c6bso5514485e9.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 08:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708531383; x=1709136183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NAyrJ3ysjOKEMv6LdT65oPM2L+c5vBxXeZNYGq9IWlM=;
        b=JPfLPTXMuGZntUA9CW/Un/0aSzIJtdsr7E241b7mEKpFj+WQMJqoG9QzUYnu4kau/M
         VNx2te4sAtgVhubepaMaKMb7QYVIP49i0QM7mkdOTzlnLHRhO8v6uRZfwyNtWwT8LIRf
         MfYWYPK9FOw2HaBW4eICSiHhdGvictavsFVRB7eh2X+V0dykK1syIbDuET9UJ+NDMfYu
         0ds5aVmpVfD0yuHHW1CWh1syGNgncwjeVgcoEY0YG0QetJ+0/zu6JilTgHSaG40HZBnI
         jtU3FJ8U38h6r7SDFHTI0lOEgdBW2XmCasofHt/OOnpH9shqdgPug+DbBMxPrVyco8Cl
         srRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708531383; x=1709136183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAyrJ3ysjOKEMv6LdT65oPM2L+c5vBxXeZNYGq9IWlM=;
        b=GIkPi1zi1yQRPfbbAjDf0eTVcSfjhtI4njRD7HMSzMZDgcP3PmAfnws/geoyracF+l
         fSIVy0C0Igz2sl9xttdxyce41BAGXbDblu+vaS4qHeRdHd8zfz6mSuXSeuXiszblyVYT
         hGQch+NRypu+Ag0h6ERNm3YQHT8BMUHIDoLE3iEIGkX8/l1QSLUvilQURSwTXbzGcRpL
         5ripLrkuPqsrJnzuRrbxx441LKS8bIxu+iNyiCobNWX3mgWD+oLCwSFMaB7PHTY3N2H9
         UvetpH23odMK/Y7lVQm0cUUk5JP1yZ5D7TRx9gpaoF4/58XYE6PeyRkqBWJx/9Nnhd46
         clfw==
X-Forwarded-Encrypted: i=1; AJvYcCW3zT4BrcJtWrXp/nfXZGqWtngaTjFG6n38n3+tIaNJZgI2EqcPrQc7Ub6Qfrq+6w3IqcsfwadmB/3ODu95yZMn0KOilwR0
X-Gm-Message-State: AOJu0YybQrDcgx1D1MPXnRFDRDkYpaac1cYn97LjjPta1F9EKVX6Q8sx
	QGxab9aZUZbVVLHOR+EZKFZktUVVsUR5BMl74v0JAEN6F5v7Mx77JR1SwN2qodY=
X-Google-Smtp-Source: AGHT+IG4DqJrPLByFyqwe4P1waoeLsQpCYIS9pcst8tLvktOHRLaeDPeYFHYT4Kwigg8jiA24CbBNA==
X-Received: by 2002:a5d:5222:0:b0:33d:63c0:3b7f with SMTP id i2-20020a5d5222000000b0033d63c03b7fmr3703675wra.42.1708531383312;
        Wed, 21 Feb 2024 08:03:03 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id bx14-20020a5d5b0e000000b0033d6bd4eab9sm6171198wrb.1.2024.02.21.08.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 08:03:02 -0800 (PST)
Date: Wed, 21 Feb 2024 17:02:59 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 12/13] rtnetlink: make rtnl_fill_link_ifmap()
 RCU ready
Message-ID: <ZdYes3iPqzf0FCTf@nanopsycho>
References: <20240221105915.829140-1-edumazet@google.com>
 <20240221105915.829140-13-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221105915.829140-13-edumazet@google.com>

Wed, Feb 21, 2024 at 11:59:14AM CET, edumazet@google.com wrote:
>Use READ_ONCE() to read the following device fields:
>
>	dev->mem_start
>	dev->mem_end
>	dev->base_addr
>	dev->irq
>	dev->dma
>	dev->if_port
>
>Provide IFLA_MAP attribute only if at least one of these fields
>is not zero. This saves some space in the output skb for most devices.
>
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>---
> net/core/rtnetlink.c | 26 ++++++++++++++------------
> 1 file changed, 14 insertions(+), 12 deletions(-)
>
>diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
>index 1b26dfa5668d22fb2e30ceefbf143e98df13ae29..b91ec216c593aaebf97ea69aa0d2d265ab61c098 100644
>--- a/net/core/rtnetlink.c
>+++ b/net/core/rtnetlink.c
>@@ -1455,19 +1455,21 @@ static noinline_for_stack int rtnl_fill_vf(struct sk_buff *skb,
> 	return 0;
> }
> 
>-static int rtnl_fill_link_ifmap(struct sk_buff *skb, struct net_device *dev)
>+static int rtnl_fill_link_ifmap(struct sk_buff *skb,
>+				const struct net_device *dev)
> {
> 	struct rtnl_link_ifmap map;
> 
> 	memset(&map, 0, sizeof(map));
>-	map.mem_start   = dev->mem_start;
>-	map.mem_end     = dev->mem_end;
>-	map.base_addr   = dev->base_addr;
>-	map.irq         = dev->irq;
>-	map.dma         = dev->dma;
>-	map.port        = dev->if_port;
>-
>-	if (nla_put_64bit(skb, IFLA_MAP, sizeof(map), &map, IFLA_PAD))
>+	map.mem_start = READ_ONCE(dev->mem_start);
>+	map.mem_end   = READ_ONCE(dev->mem_end);
>+	map.base_addr = READ_ONCE(dev->base_addr);
>+	map.irq       = READ_ONCE(dev->irq);
>+	map.dma       = READ_ONCE(dev->dma);
>+	map.port      = READ_ONCE(dev->if_port);
>+	/* Only report non zero information. */
>+	if (memchr_inv(&map, 0, sizeof(map)) &&

This check(optimization) is unrelated to the rest of the patch, correct?
If yes, could it be a separate patch?


>+	    nla_put_64bit(skb, IFLA_MAP, sizeof(map), &map, IFLA_PAD))
> 		return -EMSGSIZE;
> 
> 	return 0;
>@@ -1875,9 +1877,6 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
> 			goto nla_put_failure;
> 	}
> 
>-	if (rtnl_fill_link_ifmap(skb, dev))
>-		goto nla_put_failure;
>-
> 	if (dev->addr_len) {
> 		if (nla_put(skb, IFLA_ADDRESS, dev->addr_len, dev->dev_addr) ||
> 		    nla_put(skb, IFLA_BROADCAST, dev->addr_len, dev->broadcast))
>@@ -1927,6 +1926,9 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
> 	rcu_read_lock();
> 	if (rtnl_fill_link_af(skb, dev, ext_filter_mask))
> 		goto nla_put_failure_rcu;
>+	if (rtnl_fill_link_ifmap(skb, dev))
>+		goto nla_put_failure_rcu;
>+
> 	rcu_read_unlock();
> 
> 	if (rtnl_fill_prop_list(skb, dev))
>-- 
>2.44.0.rc0.258.g7320e95886-goog
>
>

