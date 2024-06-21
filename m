Return-Path: <netdev+bounces-105726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9979127E5
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BE31C2632B
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7550C2BD05;
	Fri, 21 Jun 2024 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th9ikI8M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CCC21360;
	Fri, 21 Jun 2024 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980378; cv=none; b=bD1QVZmspPzdxhNLJb/4ZQsw4ZUagK3IboeyQv7aiHJFQmHvX6YBOJXpsKJIwCTnH0wA2GWvFWkNGp5hNrqcTBIuG0ZIturxgNratg5o1+REGHYujrlkh4CFOHt6+M2SjyLtVV4C9o2fSac/ZXfCHd/BUpXW2Tv9xd6zpIBCsUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980378; c=relaxed/simple;
	bh=y2udidGE9+3qrr4xwze+WwFEM6tINY0kQsOUc9cRJ8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XM9r/4E712far3ZptenhPXs3bIa7D4GNjcicdvFqFcQTMnFK5S8D26/h9yY9ByBT8IFR6nU8JSDSo7frxMBey5dlCCyyrWp6noIGUwcNZcI9Oaev7/KZZA15dA6Iqn5ZcO0yGC4IEYLlPo6L1EvbJonEub2EY7c9Kq0oQ643IZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Th9ikI8M; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57cbc66a0a6so335420a12.1;
        Fri, 21 Jun 2024 07:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718980375; x=1719585175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bz2rrC9ZL5I956xjZlq5E9/RRfsNS0hX1EdfLss5p84=;
        b=Th9ikI8MeKdcV3m5EkgITjgidu6nxGtUgNlRhzKonsywpMPYOZ+DdhxhdmiaDz3p0k
         0xGBvW1zwa1sseHtRoHVCbzeZiEYavBtnjtUNymB8s1+Njk/qXmwHkfpgTvPYP4V5ZRr
         MdAnzdayMcmkPb16ISOvqYSpzajH8lLBGZkAneHogQTU9CpHfalvkJKwtAgKKReAEGWW
         7X74HA4jyzz77119PEcW030YXlmO4a+d/iYnkY4lSJ+v3Du1TtBe14xY60TcDNacaGJT
         vUfeITTBtLO3URwYNU+g5mnknLS/prYF1cv6+E/lBUGQDf8G39rtWmyyaHGAI5EHhuVI
         95AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718980375; x=1719585175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bz2rrC9ZL5I956xjZlq5E9/RRfsNS0hX1EdfLss5p84=;
        b=FckHNUhE1+ie5moM9IqXbtG5khu1ZWBs7146M2XDYRLV4QMlpimsbOjD4+INhWmOG3
         GvYpBH1jn0AUpUoMcu6FMWOfSRDf5E+uAERNqpMh/M9HC4w5Ov8aYNRH7Xq54qyidVGJ
         3gdXtc3RVKp9jstp/F67ZepkNnnpZxKCiMaCCq4/G3S29YxLSP7Y5fTFKAiO4DbZ6Hh9
         KI2pwDGepClE1QZbNWrtQl0tGcwgdcEox8aLRThCwL39W13ZsCrXDTZOT7iLxUQbfdhy
         mAxmw/XRCDRHndAmVA4VMGc4BcwadZIAWvJ52qCILSM07KNSek8IKx9uRG1tbUHImdnG
         C/uw==
X-Forwarded-Encrypted: i=1; AJvYcCUgYfUE4JXTc1U1QjCpQogUNnJSWg8B74SAZAMTKShd4si0aiM1WsNJkIcHbF7M1tYukCU1f1J/rhC9UOoVUyD5iTFnojxSriEFeSqO
X-Gm-Message-State: AOJu0YzqbXaXjbI5x5mUojOYaAtcrTd+VJyhrgDPXYrG68JCQigFRI/S
	Qtur/kufAFbkUaUWO8602X8ue5zZ1oEGPGHiIBuVDUzrXFH2HFO2
X-Google-Smtp-Source: AGHT+IGS8AR5Fn/djK91tTlDQrcYmUhnQO2DQVytIhnhISToCyjjKJZZHOONQ9w8rlaNNWohTEXVUw==
X-Received: by 2002:a05:6402:165a:b0:57d:1d0a:fc91 with SMTP id 4fb4d7f45d1cf-57d3e03feccmr14176a12.10.1718980374864;
        Fri, 21 Jun 2024 07:32:54 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d303da378sm1003108a12.18.2024.06.21.07.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:32:54 -0700 (PDT)
Date: Fri, 21 Jun 2024 17:32:51 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 04/12] net: dsa: tag_sja1105: absorb entire
 sja1105_vlan_rcv() into dsa_8021q_rcv()
Message-ID: <20240621143251.nnt6ynruwsnhyc4g@skbuf>
References: <20240619205220.965844-1-paweldembicki@gmail.com>
 <20240619205220.965844-5-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619205220.965844-5-paweldembicki@gmail.com>

On Wed, Jun 19, 2024 at 10:52:10PM +0200, Pawel Dembicki wrote:
> +not_tag_8021q:
> +	if (vid)
> +		*vid = tmp_vid;
> +	if (vbid)
> +		*vbid = -1;

I can confirm that the vbid assignment isn't needed here.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Tested-by: Vladimir Oltean <olteanv@gmail.com>

> +
> +	/* Put the tag back */
> +	__vlan_hwaccel_put_tag(skb, vlan_proto, tci);
>  }

