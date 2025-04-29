Return-Path: <netdev+bounces-186694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1DBAA06A2
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888565A4B67
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CAB29DB7C;
	Tue, 29 Apr 2025 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtdBdlhb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5043429290D
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745917633; cv=none; b=BSfqPSujGO5E3gZ9ZznVVD4L3sFnx1sfOi9P959JDfF4vp4HHyTrGE0CZYjsf3peDf5hui7HdgVaSLg/ZyyLt1cdLW3Fwd96yBvJpnqwAm/nE9LfuznLK0/pqRHR7lGvMXgzRifUz/BPZ0IQOcFW29GRhyDhM60lXjQRguLgBRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745917633; c=relaxed/simple;
	bh=oh7CCnYDblP4XNung4PYLs6HI3+l/+Uc4f9IBVFDP2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7+6qnNWu1WqZ1Sz4oBYszu6hZws7icnxNGNZ1aYbbcFJKiIdB7IMgeHhIb378t/p69GpEt/u0Tq5zS0W9m0EySC839oRCTokC+/C4Z+Wi9n7xegj979/vvV1MP4+kZIQzStfrI8nrUXYDTI9z4eJiwumAYTZ6RTyCGYhPrho5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EtdBdlhb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745917631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzyYtGASTCZH53kkh5r8Etd3SYnPqWVoda3Vr+Vvexk=;
	b=EtdBdlhb+8XBRCKwFF3oorjfJi9XvQhPwCr9cz2zU0uxup7ryUSB4t4L1YieNBMSrNxGwh
	s4eeQIkinWBX6Rqg+/ECypcvKflivS3Cc0b1zscIDbX0fZ1GaBM/eAI4DNWjk6zaSOkpW5
	4Lxaqk+Rk5PVHEPzMdRrxgk2XxLA5uM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-NDdb_yWsMgyuy3gWXn1a4g-1; Tue, 29 Apr 2025 05:07:09 -0400
X-MC-Unique: NDdb_yWsMgyuy3gWXn1a4g-1
X-Mimecast-MFC-AGG-ID: NDdb_yWsMgyuy3gWXn1a4g_1745917628
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac2a113c5d8so415745866b.1
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 02:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745917628; x=1746522428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzyYtGASTCZH53kkh5r8Etd3SYnPqWVoda3Vr+Vvexk=;
        b=DP6yMbsasnIBFvg59t99xSc8L2+6hob8Y4arzqneVjrg/nbTMQ1t3u7QDdYjzs6dFk
         /QDAdOGyHvw1ck/bH+kq0TE0v5hUWa2q9kW65bj88lcFyMamd3yZvkumyfONkcBPuOTM
         C85bIUMqsYOrYinZJx0eM9jx7EZBUMfxc1bN7XtQaeRwVu5eD2xvJR+BBft5kxo776GR
         CAi6C2WzSGquFpfCQFHMW/mAl1WRFgLnf2Ns1pHQCMhJOpf/ZEzE9DBfbVHt0/ZgtBLd
         T+M4IOPdvbs1WLbXoxw4K/FItWaCugUVJg4PuK/BjwFGDooJ2a2BcBuPnphMAwUzAKGB
         UN5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUHr9+SmL0hN/jqCY/udlNCTPeoFGHtoOBBu7Ld2GIpnACoWgonLpz1zOdBDmEaIwaVduvaVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcjG99Iz48cHEFNDMzUDyMhTuh/KsWYYReTNaV/r5Y2dXc24gF
	YT51NAA4pNzNqJuO8IAeQRJLAQgDkYleY7LwaYNd1xFKfXIp7e2OVjSpK282/yYqMZvAid4xLfI
	uQjg7egmPx4Qr24100wa38l2IzkHB9IgoktKq5liMInHYBEUcvbcydw==
X-Gm-Gg: ASbGncu8I9Ly1KeP4KwP02BqiB37rBq8tdRGPNmyBBCVSkFnrZjbhhXoYPrpEIBcKv7
	Sm/OzBvD+vCVc662ug5T12YjKtIl5ia8jqqJ5eccd8L9brN5hCfCkgiYygFxRh4MCY3HUv4gqUW
	Rtc6cFczKD85rT9pEhbIoje1JRqzPIgkwPGOQ68wO01nYvDk18Etf6BLpLtyoI1CKLzXZs54JY4
	qxuR1Q+ECMKiZ0TTrVP77APUEHOX+TLsiZwdwDXBspQ1QXVWYDP8xMR857IK28phN+WzhbNflhr
	c4tCxrZRNSm5h05ZiYPOoy/6cggdP4M74Wb4pjvaMfi77IavafdbRmlj3wQ=
X-Received: by 2002:a17:906:6b83:b0:ace:cb59:6c4d with SMTP id a640c23a62f3a-acecb596f66mr114678366b.43.1745917627862;
        Tue, 29 Apr 2025 02:07:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0UT9RESKMoOz8328LlBMB1TkH6XGlQcYjJuX9WOxFYoUYjXafd0Mghnrx4VAIMHLBk84pgQ==
X-Received: by 2002:a17:906:6b83:b0:ace:cb59:6c4d with SMTP id a640c23a62f3a-acecb596f66mr114674466b.43.1745917627414;
        Tue, 29 Apr 2025 02:07:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897? ([2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acec171fd52sm141333066b.166.2025.04.29.02.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 02:07:06 -0700 (PDT)
Message-ID: <366c8743-224b-4715-a2ff-399b16996621@redhat.com>
Date: Tue, 29 Apr 2025 11:07:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 03/13] net: pse-pd: tps23881: Add support for
 PSE events and interrupts
To: Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Donald Hunter <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250422-feature_poe_port_prio-v9-0-417fc007572d@bootlin.com>
 <20250422-feature_poe_port_prio-v9-3-417fc007572d@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250422-feature_poe_port_prio-v9-3-417fc007572d@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 4:56 PM, Kory Maincent wrote:
> +/* Convert interrupt events to 0xff to be aligned with the chan
> + * number.
> + */
> +static u8 tps23881_irq_export_chans_helper(u16 reg_val, u8 field_offset)
> +{
> +	u8 val;
> +
> +	val = (reg_val >> (4 + field_offset) & 0xf0) |
> +	      (reg_val >> field_offset & 0x0f);

I'm probably low on coffee but I don't see why the above could not be
replaced with:

	return reg_val >> field_offset;

(given that the return type is u8)

/P


