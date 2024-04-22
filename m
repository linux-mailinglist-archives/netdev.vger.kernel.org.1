Return-Path: <netdev+bounces-90178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7B58AD00F
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D231F225FD
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07568152194;
	Mon, 22 Apr 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="u83YW7/5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AE4152184
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798146; cv=none; b=OdNxgj5V+OUh8hw1Bezm66EGF3ZxeHkwhwLNW7MRTr+9c/kIa7Fu7nbEs6ELYtnFx8vmHusTc4pYN9YvhDuKE7QwgYhVSzBH529d8kcD811OdMXKOhLGXRYwe6M7yFXB7+OMl+Ys6d2pQ7kCi3v7bxdt3wgeg2O3RI2PdnocGGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798146; c=relaxed/simple;
	bh=uC7c7kYqSmVQGZp+YTPHZbbns+rkpE7UQYVX9hYf4mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVBvQ3IihuVSVrx4cx/+cRwnlJKHv9pdWqj1zYYVRm9KuHnMBjYohBrTkazPUjP2gQpoGReDfT+f9yuJQWKmyvi2aif1rzQ6fQ2CXFbqnaejJyh1F4J3t7GAHMfgsBrjzE3vXc+h2//3RG8NwTZKxCcgzVGjHDtSP89OQn0wdLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=u83YW7/5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5200afe39eso496313766b.1
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 08:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713798140; x=1714402940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LAekVfGSUIYeilrCxStRbd53k4+SbtJAs1TjJ6PPZkc=;
        b=u83YW7/5c/cs3Rqg13VwIIpngCwEZPvKrNjeEVnpPH9cNNHQ7dgR3dZZBw++geJxMy
         Tv6XfbTVgt/N/PhdHjYnug8rPebrpbfb2iFLITijhBr5QUCBKGOpR8ZHJ5bZkcHIYKuC
         nOqIfS9BItZEPvedEDbylHcETTTpgp3o1FVz/knIs4/cCgpk8imF79J6sqIaBx9BuHOW
         N4jtpVdJ59bYAGJ93f2mr3m0D9BVjHA/XDwrQBS1qxpiIDcUUHNUpX6geRd+P8JQKFuD
         bWZE2z1D6dStT1ECYl1rTh8hHg/KiT0f3sn352gN+wZb4ykWLxbo1ybbkR4X2wS/V5+N
         Eegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713798140; x=1714402940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAekVfGSUIYeilrCxStRbd53k4+SbtJAs1TjJ6PPZkc=;
        b=fyylxXC+Avht3fLgLhklwy9lXtRdAmlN0yuudz2QGZHTBsGr2aPOslhM99MouExiEB
         z5byfO7gjs6xc5zyFs+8DmOmB/TLkGpz68Qvk8xKHOv9ZLdz4zXBkDWvbR9mvmVNV2jD
         U9C4AH/rgWy9COi0KP+bUWfbN83ZSojV26JJhGkcUMhAIPuGpLWBw5dCnc9E8EnvefO9
         UHWbsq25CP+d+H9EjfHPClyrHngG1BVEJvEXGMRSCW9sonf57XLEu07tkv6uPpFJxOHY
         21rZb7t93eOFiGdeq+sTo0O23Iy8N8rHlwL1x1IbI8YIHTA7vW18k8Nt9xpPMEHBG1TK
         PIdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnZEKVXLTZdODl4QKFPOWrylykdXf0+k0JMhvfPGH/RzvyBRpc3GDgY7aI3vGoYOHFutl3g9n2/6zM4cMRkOweUhNSbWR0
X-Gm-Message-State: AOJu0YxXGHRQ3U5I1ROMtrylcAtvdaJcLkaLEoM7/Snv42sYG+HeYcM6
	CWnD+YzFwWZrXT22KfOFm3fwCv2zgn4kCmcW8JMc0YjnatpYWow0un2C2pDgmm8=
X-Google-Smtp-Source: AGHT+IHS6BZ9qlEluvP//9IwElLogHji7WqEThNxj1fC3U2GxC+dWUDgoMi5vcDNYySA8T2tWjoPlg==
X-Received: by 2002:a17:906:830f:b0:a52:3b6a:ab43 with SMTP id j15-20020a170906830f00b00a523b6aab43mr8149446ejx.67.1713798140345;
        Mon, 22 Apr 2024 08:02:20 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id h5-20020a170906590500b00a4a396ba54asm5866471ejq.93.2024.04.22.08.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:02:19 -0700 (PDT)
Date: Mon, 22 Apr 2024 17:02:18 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next v2 2/3] net: pse-pd: pse_core: Fix pse regulator
 type
Message-ID: <ZiZ7-n5q3COmPRx6@nanopsycho>
References: <20240422-fix_poe-v2-0-e58325950f07@bootlin.com>
 <20240422-fix_poe-v2-2-e58325950f07@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422-fix_poe-v2-2-e58325950f07@bootlin.com>

Mon, Apr 22, 2024 at 03:35:47PM CEST, kory.maincent@bootlin.com wrote:
>From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>
>Clarify PSE regulator as voltage regulator, not current.
>The PSE (Power Sourcing Equipment) regulator is defined as a voltage
>regulator, maintaining fixed voltage while accommodating varying current.
>
>Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

This looks like a fix. Can you provide "Fixes" tag please and perhaps
send this to -net tree?

Thanks!

>---
> drivers/net/pse-pd/pse_core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
>index bad29eaa4d01..795ab264eaf2 100644
>--- a/drivers/net/pse-pd/pse_core.c
>+++ b/drivers/net/pse-pd/pse_core.c
>@@ -294,7 +294,7 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
> 	 */
> 	rdesc->id = id;
> 	rdesc->name = name;
>-	rdesc->type = REGULATOR_CURRENT;
>+	rdesc->type = REGULATOR_VOLTAGE;
> 	rdesc->ops = &pse_pi_ops;
> 	rdesc->owner = pcdev->owner;
> 
>
>-- 
>2.34.1
>
>

