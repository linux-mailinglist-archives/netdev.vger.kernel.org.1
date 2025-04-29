Return-Path: <netdev+bounces-186710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7A0AA0759
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4C73BBA7B
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8CC2BF3CE;
	Tue, 29 Apr 2025 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIlQqPTX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DED82BE7B8
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745919046; cv=none; b=B1UGCpwLd6TAM8eeHaNkAuuKZ3orxXNUHk8cSD3VOQc9L+xoMeht/eSS1HsIyGPNyTwPrNaz/vfAMN8MvmlA6LFYTBoJGJC78xirxjyqXk7O9bcJd5cJIEUUuXUEVkqyOd5u+9gxDhQ9DtqA9BLv/z81CvbzIPK04sCOejRas8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745919046; c=relaxed/simple;
	bh=hXonJzExV6f/cYOmpVW4RG/5EKao+OkAqFLmiQh/hcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpzSkvwjo8YlH3BWe6uZMm+ZP596+JQjLLrektZzUEPzb1tKMfOg/MKd0U4FnWGnywogIgM4yEwjaqZrisWiG14nouuaoqH6BkPXSMhMtdRn6zRxbsT3CdGIKKmYllUz6pIawL2gA9cajqHHkkcj736DRjiMG+I40qLDqPXTd4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PIlQqPTX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745919044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKFEHdgHcLwRfGZHvxEjeWO9rZ2vSungJ+/BDNwcd7k=;
	b=PIlQqPTXKy9v+Kfqa/BsKyuqOhaTWifmzpwvaRhVkknbi4r7WveAjl+ASHrRtS739Mh9YY
	uq7zbTZYFyOYZgMC9rAEUUEC1GZEajUgnB5fG0llt6e7pUb1eKYs/WlmLvWNHaEHC02NsL
	ybxjdPjjavPulruJGDsenj00Lhj+7Pw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-OyJLnkTFMzuzFUxj0sOMFg-1; Tue, 29 Apr 2025 05:30:38 -0400
X-MC-Unique: OyJLnkTFMzuzFUxj0sOMFg-1
X-Mimecast-MFC-AGG-ID: OyJLnkTFMzuzFUxj0sOMFg_1745919036
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5f64bb8ec7dso1197709a12.1
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 02:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745919036; x=1746523836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKFEHdgHcLwRfGZHvxEjeWO9rZ2vSungJ+/BDNwcd7k=;
        b=ok/HhIVut0N+OWOMQ5Uv/3pQtZWfV4hMM4Krgy9rAY/YwsDbTpMq+hp2dtOVU9zp1X
         cyVaB1bPsnzftvsmog4Miy+w/6Ize0GYPb6YOgRDSsoPtAZL7j0ZYNtOgZLL8cg88dMj
         H0Xt8KHRl3BFTxaDufBVThmzmGMmL9ynsp9YlmpBpYvpGemaeOa9LALtxydYLiY8UBPT
         FdxNFbWDRtc2Hn203ErhzkRKwprvEIgrgW2JI0r0a6jdjsBkaQ3k6YC/fcR9trMv6JlP
         yFBtGpnkAob+r0+gh2z0hOgvUK1uj3W8BkoZpTaUh7ERVOC8OSaBzhPdjmr26X+Vu2V8
         TZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCU0msw4nRs3ZNvQ9IFCa8nEJdjsr7u4fzq3N2f/HeagUlOoqkgV5yQqVoeGIZktoCsQlDsYBKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8B7AEm8OW6LYXOjMRDYwb1eoNHRYoGT9m+DLChErxqvZm03rM
	t/wAc3Gr4tWSBaz0HjPsS4HWZ4QvBeMfg2ZNjCdQhab/es6axRmM9qEE2Ini2YAX+9/d14Ca27O
	/tiy/cFk9dkFAyhbJTRCX92Qq+tWB682zO29GfUEpwio7oeA2qWUOxg==
X-Gm-Gg: ASbGncu/vnGis3FLnJFGh1JKp4950TgfdZOued2o6kBWXR1KuNqnUj8cHT6TNQKKuIy
	C2N2GdW+BtCJtU9VRZVhJ5Oof4w55kmfsuSOSPVl4YToedVONuLlzY8vIh1qIXo8xesBfo6O0oX
	QqQ5jqrJ57GKqYUtgLmL0AYZ+K8DTA7Ozpn41hBGiFT3ilvBvAwSIC7P2eeKSE32Pjif4IFEfxs
	HjB17NRGsTNosnIsXy+Vf4BIqbLUffXmaYcvz0B1MzPpYhzBLtmYKNG/TxcywxIcccey56yB71v
	RHWhDG7ZCheeJHXidoTwrEbO3neJ3RT0j5weO+Q4K9Jp0fZSHpvQ7l0ojiQ=
X-Received: by 2002:a05:6402:1e94:b0:5f4:c7b5:fd16 with SMTP id 4fb4d7f45d1cf-5f839224a59mr1942341a12.6.1745919035704;
        Tue, 29 Apr 2025 02:30:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS2Aal7Wz+dVWPGKPbDkIqlChFVLqNPD6xjJGGYetpQ28hV8efTZJRlGmop13TtQQ6QsChxw==
X-Received: by 2002:a05:6402:1e94:b0:5f4:c7b5:fd16 with SMTP id 4fb4d7f45d1cf-5f839224a59mr1942313a12.6.1745919035327;
        Tue, 29 Apr 2025 02:30:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897? ([2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7016f5db6sm7332402a12.44.2025.04.29.02.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 02:30:34 -0700 (PDT)
Message-ID: <60643797-2466-4200-9abe-9956bfdeaa73@redhat.com>
Date: Tue, 29 Apr 2025 11:30:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 07/13] net: pse-pd: Add support for budget
 evaluation strategies
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
 <20250422-feature_poe_port_prio-v9-7-417fc007572d@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250422-feature_poe_port_prio-v9-7-417fc007572d@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 4:56 PM, Kory Maincent wrote:
> @@ -223,6 +237,17 @@ struct pse_pi_pairset {
>   * @rdev: regulator represented by the PSE PI
>   * @admin_state_enabled: PI enabled state
>   * @pw_d: Power domain of the PSE PI
> + * @prio: Priority of the PSE PI. Used in static budget evaluation strategy
> + * @isr_pd_detected: PSE PI detection status managed by the interruption
> + *		     handler. This variable is relevant when the power enabled
> + *		     management is managed in software like the static
> + *		     budget evaluation strategy.
> + * @pw_allocated_mW: Power allocated to a PSE PI to manage power budget in
> + *		     static budget evaluation strategy.
> + * @_isr_counter_mismatch: Internal flag used in PSE core in case of a
> + *			   counter mismatch between regulator and PSE API.
> + *			   This is caused by a disable call in the interrupt
> + *			   context handler.

The name itself of this field is somewhat concerning, and I don't see it
set to any nonzero value here or in later patches.

Possibly it should be removed entirely???

/P


