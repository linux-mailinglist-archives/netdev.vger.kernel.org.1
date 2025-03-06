Return-Path: <netdev+bounces-172359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F391A54599
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84C5171EC0
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A327209F24;
	Thu,  6 Mar 2025 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T//bwE0u"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB9820967F
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251405; cv=none; b=cY3NTHb8EzUC9JRz2z08iQlvCy4+GQYD0J0CZA6rq2Z2b3+Sv4Gq5xxcfsjivCgrKLPuFAtuWUpHjfFhH0sPYA4j2E7Q5wYYS6g5969a6AFNTrvlDPJkR+cd/KZ4Q1VaeyNt52AsWqw5+6qRn9RW2xDegeEbIvTLKH2blErQ7KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251405; c=relaxed/simple;
	bh=l1bk7fve6dMJQv6KaXGDjnZ1grq9bOuxKpexKdP2z9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LpV1Q/+WVwT3eOVhCcZWJ2+yiKnPcgH622y1sV7gbpUda8yCKJ7QSYDxUfX06z12GEsX3Y68Qu3SnA/ogXe65hGRIWFCKcH+wcvGF9Zez0Fbl3sb/HfgrvwYGcTr2K/PP4RDf04V9/93oSJ4oGxVWnbP1NyGOVSsb0qIAUPKrDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T//bwE0u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741251402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHVzKBF1Q9KJq9LGRjL7gm9YWMcdaoIAOjd6Lj0rKZE=;
	b=T//bwE0ufLOzCXZucaZ0YBc09rX2BfmJaD8pZU5E995oFs6zDAP1vrnCL0HcZcy52qTNNW
	QZZW8UOzq6QWBhjuiMNk/HwM4dVHyfacESKe9ZT1aKydAwRqoW+0bS9tMyMb2E29GlObPf
	N22+HC/W6BbHyOcU8jayBePz0GAbeqY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-04t8R8_9PwOQ-547sI_tew-1; Thu, 06 Mar 2025 03:56:36 -0500
X-MC-Unique: 04t8R8_9PwOQ-547sI_tew-1
X-Mimecast-MFC-AGG-ID: 04t8R8_9PwOQ-547sI_tew_1741251395
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43bcb061704so1464835e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 00:56:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741251395; x=1741856195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHVzKBF1Q9KJq9LGRjL7gm9YWMcdaoIAOjd6Lj0rKZE=;
        b=KwxS07BVDBZg7JBp3/szYH0LcNhv6gGRPe0uY8osXiRcJJywfW4TcKDcNyHPmkdbbH
         4s/8PzDmTglxfrc+jRKCwnNnZhJlZGTRvzt4nZTklNf+bCbQ5orUcczT0SGqYej+ir3v
         hEEpUwXAvx/9fk49pF2LecRge0vWCpEDItJ6+UPnI3x6yswDDgWPPpsvDWbvz1mI1L8n
         tYUKG2FF4KmVQM0q9fxZ8aPmNyevE6z9vjY8T84pbLXv7Wlr5QcamvhaVIFQq2kTtQsl
         Cs5rkZDAkRACCJoLuos76qcu9iCbZmiSxcn/DR9mbX/c+iCdIXoyoYYLFPDGnm/hgRPT
         k1yg==
X-Gm-Message-State: AOJu0YxaX7A3fc1PnAuByhBAccgORhRJFaI3vnpZgJ5suGSqgxDWfRv7
	6eyyXwIlfNL4R3/zqs8TxD8VaPbrR/DR9iUzXQUKZCablfJp+vmRI6ZwP/YSC5uBhv538riAIM6
	dq42g3OI+Wa9eeCXHELpEMyBP7vHZRtRopYGUrU3JTfdJWHj6P3P1sQ==
X-Gm-Gg: ASbGnctKX9qtWh2/cynm7wA/+SacZMZhehlPUap7NOC2r9mDAo4SDAo6GqNlNIn3c3G
	bnozZVI8NaosSE7rzlME609EilDg0P2isMvE1B7z3LFBMDCpsCM7Jm+UKVdLcLtJMYsKliudhrv
	BsKQQ32rySwjZlJz+QWbnWVs9gk0rrgJfrBIdKo0D1zqBeZ4nUrMbIMl9ZpfDEWgs1ljehpDihw
	XZ/3wZOtWaU9GJ9Eu9regWlYOY7aFA1MAyaWvZLeA4x92zR+Kq5ZQ3pW84fZxnrq5+lZxj45ob6
	pyqfepQUx1XepT7ZIagkX0Z/9aH9dsGgBFCKtZXuNuFRqg==
X-Received: by 2002:a05:600c:d4:b0:43b:c857:e9c8 with SMTP id 5b1f17b1804b1-43be0661ffcmr7598335e9.31.1741251394944;
        Thu, 06 Mar 2025 00:56:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfwGEtj9NaQs8CRvPvXsv8CwsyiViPjo3ntC+rkCUxEKfACGLB5V95GvmcnS2yafdbLJvCcA==
X-Received: by 2002:a05:600c:d4:b0:43b:c857:e9c8 with SMTP id 5b1f17b1804b1-43be0661ffcmr7598115e9.31.1741251394643;
        Thu, 06 Mar 2025 00:56:34 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bcc135676sm57848145e9.1.2025.03.06.00.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 00:56:34 -0800 (PST)
Message-ID: <350bb4f6-f4b5-44c3-a821-ac53c8641705@redhat.com>
Date: Thu, 6 Mar 2025 09:56:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>,
 Romain Gantois <romain.gantois@bootlin.com>
References: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
 <20250303090321.805785-10-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250303090321.805785-10-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/25 10:03 AM, Maxime Chevallier wrote:
> @@ -879,8 +880,10 @@ static int phylink_parse_fixedlink(struct phylink *pl,
>  	linkmode_copy(pl->link_config.advertising, pl->supported);
>  	phylink_validate(pl, pl->supported, &pl->link_config);
>  
> -	s = phy_lookup_setting(pl->link_config.speed, pl->link_config.duplex,
> -			       pl->supported, true);
> +	c = phy_caps_lookup(pl->link_config.speed, pl->link_config.duplex,
> +			    pl->supported, true);
> +	if (c)
> +		linkmode_and(match, pl->supported, c->linkmodes);

How about using only the first bit from `c->linkmodes`, to avoid
behavior changes?

Thanks!

Paolo


