Return-Path: <netdev+bounces-186693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1435BAA0672
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDEB4610A3
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9501829DB7E;
	Tue, 29 Apr 2025 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0n+4Tyv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AF329DB99
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745917234; cv=none; b=orlI7QgzwF25zCCkuBf5t+Mf2Buh4ZU3R1EwpIpi1zAZR0PfgJlaNs+3QxObbbhYp6K+U8EQsEQ0OOZKnBXBh4LjxH83jy+iyRFa513aBFPaNgOMgrywit5Gkvzz5g3xNOZdzhpa3bx4kuJULV9UNtfvUyIXRwEbUhQ7XeW+wXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745917234; c=relaxed/simple;
	bh=2KIKuRu81xZaF2280xYX/+R5+wlu8WDBf1ye5GbVH/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=laMDcZS2LDiTl9VKqlwLfMJb3KfJGsE0O1KglLAKHPzH8YjCUMpjSKkTDpTZHK7/IVZsp5eSNyPyKjVuPFy7qs8WkcH45nmA2u/qa+SXf9ngzLPBYY+fLXWhFmSL9tRk//24FWDH4PjAV82E5kEdczIqpRvXzUC7/AJJ00BtkHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0n+4Tyv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745917231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PCHHHLvZcH3BVlqKXz9f7p7K33kY7dzdDWtjNHcUjrA=;
	b=f0n+4TyvabSaehmmUk80NREXlODFh9+aaWNc8RgWSIJqlZMeUovNt33AdSAb9/zhh2Q6NJ
	6AoFal4EZfp4P97UB4h9Dm4f/Q2ssasR1qUms9lKe/6UsDXh9Wuz1Ozo2l1GXVq+hjORap
	7gG7bjEVWMlxkweC9/1PIBzhejspIDo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-kH-VzgrgM4Sj9tsBiwW6sA-1; Tue, 29 Apr 2025 05:00:24 -0400
X-MC-Unique: kH-VzgrgM4Sj9tsBiwW6sA-1
X-Mimecast-MFC-AGG-ID: kH-VzgrgM4Sj9tsBiwW6sA_1745917224
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-acb23361d73so125596266b.0
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 02:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745917223; x=1746522023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCHHHLvZcH3BVlqKXz9f7p7K33kY7dzdDWtjNHcUjrA=;
        b=PFVUMGq8qItRn+x12gwy0lhe08R/eNSqA/b3yM111Xv/tMLr4xO42FT+vF5zKpuFZy
         07W2Yvx2BRA6P2O8LEwn+2u6cPHF2b21gRubgdfoiNw+ULW1e9urTQ88pzmUgyA5DTNC
         BnIfgoBPdI2H/PIT+Uk8Nv9nc24OAWF4YKSSDo74ily33z5JIqw3rca6DRGW5dHZEwRR
         +5gBDOHlZC372ZMgbPJXp7p/n/Lih7nC16YI37URfwT6a7vGWXKQYTV1B2GLaK5x1J2W
         PSn4DUGZduYQK7hF6VMUZW23Wv1LD5MesdP8oBkrIeskqe08M4iBcB7j92waEq3qo01D
         PUug==
X-Forwarded-Encrypted: i=1; AJvYcCXyijFQYiJo/Ivjp7oV01PDHgRJghxHXLP1UR6cZ8C6AK3g/MaPQwYxdLGdFFt3F0+nUCNi4t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJink7PHg7rF/rb0LGwYk0bcOntiYCh3fBXqvhGSlSG52fCVcQ
	kriKu7VDcsHQ2FALK6rV8GWZAzj2la5B/o7xp6coOytVFYf+Txvuq6MJJi1dfUULjodd/fknW2F
	LJvp/U4k0Ec0t/qhQnDpCGoOJRirMxCb5RyvGXo7cyDtLOnw6vSM2VQ==
X-Gm-Gg: ASbGncvOJQecVeF2QKsRndw+bE3cVOmIU4bC60oSWCWEB3ITyQnDa+bORAeERw3WXEt
	l1UCFIK8rPJG0lgVnTOAZWqMPAUtrePN3OXOTegqpVlZCgzTkfXnVvU5sRU54NsV/FU2IywqC4f
	KeOSsLF619VXXo74gSKtDaEYo93XBKzddk1d9uRAU/wDFWuOGVwz0YOSmPJGewPvkhIJnVRAsEk
	EKpxJnqMGytR5zanZD72T/BzDzU9AB7beKMF6InfLhrsyIuD1+CUNH3PC5z8TTZwlJeEG2udnbK
	yliWhhTWe6cv9KpK5R9lyaBwh/uaTnEvXCFOYG2FWGafEg2foD5N1p9IjgU=
X-Received: by 2002:a17:907:1ca4:b0:ac7:b1eb:8283 with SMTP id a640c23a62f3a-acec6a4958dmr218814966b.17.1745917223573;
        Tue, 29 Apr 2025 02:00:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkmrc9oaifrsbfBdKoTCsdQffffsFtg2dW8YPIfDy01PUM4CZM4fNcXpfPUjcXmTBPdpHaIA==
X-Received: by 2002:a17:907:1ca4:b0:ac7:b1eb:8283 with SMTP id a640c23a62f3a-acec6a4958dmr218810366b.17.1745917223187;
        Tue, 29 Apr 2025 02:00:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897? ([2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm741676566b.181.2025.04.29.02.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 02:00:22 -0700 (PDT)
Message-ID: <be2ae666-a891-4dee-8791-3773331ce7d7@redhat.com>
Date: Tue, 29 Apr 2025 11:00:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 02/13] net: pse-pd: Add support for reporting
 events
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
 <20250422-feature_poe_port_prio-v9-2-417fc007572d@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250422-feature_poe_port_prio-v9-2-417fc007572d@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 4:56 PM, Kory Maincent wrote:
> +/**
> + * pse_control_find_phy_by_id - Find PHY attached to the pse control id
> + * @pcdev: a pointer to the PSE
> + * @id: index of the PSE control
> + *
> + * Return: PHY device pointer or NULL
> + */
> +static struct phy_device *
> +pse_control_find_phy_by_id(struct pse_controller_dev *pcdev, int id)
> +{
> +	struct pse_control *psec;
> +
> +	mutex_lock(&pse_list_mutex);
> +	list_for_each_entry(psec, &pcdev->pse_control_head, list) {
> +		if (psec->id == id) {
> +			mutex_unlock(&pse_list_mutex);

AFAICS at this point 'psec' could be freed and the next statement could
cause UaF.

It looks like you should acquire a reference to the pse control?

/P


