Return-Path: <netdev+bounces-124177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A55096864A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 13:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65B12824D2
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 11:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88971D47BA;
	Mon,  2 Sep 2024 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="w+ipWv+C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473051D2F73
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725276769; cv=none; b=VoDWuWwuqs/MiH72qRtOSOgGeATy2JpXrnN8LBzKeeR1DHciH50J4mEcY5Mf7lYJBpt1GjKqnaMZhxczp1ScNfzTSjaNJdUADz+vEqbbVC9M8bqGYZEegI0ptCXW9wVavJKHAPhoB7P6H2z++u35p1W1SEwC5g0Jk2R44PEDXis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725276769; c=relaxed/simple;
	bh=qio//HUwcac13spOXL+XYs3ur/zeJsKHVMAEAUYB00g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4G1S+4iPsZd8TsoTAt00lCBJSJk4mKGe6FTO/h+I2meDuDL+HOwrDn+drP9bhRteMZAFgSyfUDmJp4H7RN6V3RJ0mv7yq9tmb88dGH7VAxvcE1QsDh30wgsXcllRhPpxcNqiKSuvPTPFi7/mmfEnNH+r1okb7V0TkFwG37XJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=w+ipWv+C; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f3f163e379so65904831fa.3
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 04:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1725276765; x=1725881565; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TEdbKEfNp8l5b7UjeJFRI45ydY4UJCRIi0R/wybvHbY=;
        b=w+ipWv+CbBMGb22jh7RqHd781F2Xhwwv36NAlJsUlieslO+zZuwbwX4kHaaBddBEIR
         UxAncyFSL39KyGFjBj8fxnMUJWQMQm38ypEMWWJDQ+uens7jl2leQERgrpAMBFCYnuNd
         X/Ky1T6OKHUfKPb+hRTn7U8C3JDF6opMgo3U4ch+jXCLKveUUrBHX8RqZSPHGs2jm32d
         +Ei4f9YpBykHZ9vbETpiGpg8qp2R87KoPt3r2rL0MQyiW8mlIKrX2/GdonFrT05QL20G
         3gzVV4Hpw+hLws8QM/YfWPFNjqaBKQfbz5XELdOaHni0mub0U50xAo2NQ1vv3N+NnhJf
         d/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725276765; x=1725881565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TEdbKEfNp8l5b7UjeJFRI45ydY4UJCRIi0R/wybvHbY=;
        b=nsjfUR5TMhpczt3GEvuJqoDxElQ2uhreVYqpd/Wd/pE1sLiQmX3bIZJnAgevcjJtSQ
         g0esEYDztleLY8rreiQ03eloXG9FzLaii7qRvYmFloBPT7Gce6PdcE1s6K/HR7M8RuLI
         UKhOZJCmRIf3QT1Sr4sujzmo5szxGGtt218jTLDdN8lfpFZqkhimlZB/1PRPsmh1S3hK
         eUW5UH2wIkmKcFhLdV2xE8LoIPZ+Ayk1loNPTb6Kbt6zHcSNNaKguFTbIzg4+lr6Xi3n
         aQKH59W2CsERTlixhDXvHBwhOUrDAptxGtJOcBJdIMaMelnqdSrT5hHDom3A4l0H3+AZ
         9FUQ==
X-Gm-Message-State: AOJu0Yz9EGQuVB0IQVztkAAEOWtqC6QaVfnqVkUTjT6npl9Ft4cW6VSh
	lOPGjnWarr3Qxp5W5Y6ksMpsaLfJfR2GOXnghByRKeOPwcdvT3VWQr3t6vdMBmU=
X-Google-Smtp-Source: AGHT+IEB/mi5FyufIC2z2Kb7W26FvkVShd0NagHMF9VylDvp9kcYF7OxQjcMQiqj/+KVaajyIxP4Cw==
X-Received: by 2002:a05:6512:31cf:b0:52c:e119:7f1 with SMTP id 2adb3069b0e04-53546bfcc07mr8703769e87.51.1725276764767;
        Mon, 02 Sep 2024 04:32:44 -0700 (PDT)
Received: from localhost (78-80-104-44.customers.tmcz.cz. [78.80.104.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891964e5sm551343866b.98.2024.09.02.04.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 04:32:44 -0700 (PDT)
Date: Mon, 2 Sep 2024 13:32:42 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geethasowjanya Akula <gakula@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [EXTERNAL] Re: [net-next PATCH v11 00/11] Introduce RVU
 representors
Message-ID: <ZtWiWvjlMfROMErH@nanopsycho.orion>
References: <20240822132031.29494-1-gakula@marvell.com>
 <ZsdOMryDpkGLnjuh@nanopsycho.orion>
 <CH0PR18MB433945FE2481BF86CA5309FBCD912@CH0PR18MB4339.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH0PR18MB433945FE2481BF86CA5309FBCD912@CH0PR18MB4339.namprd18.prod.outlook.com>

Sun, Sep 01, 2024 at 12:01:02PM CEST, gakula@marvell.com wrote:
>
>
>>-----Original Message-----
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Thursday, August 22, 2024 8:12 PM
>>To: Geethasowjanya Akula <gakula@marvell.com>
>>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
>>davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
>>Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
>><sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
>>Subject: [EXTERNAL] Re: [net-next PATCH v11 00/11] Introduce RVU
>>representors
>>
>>Thu, Aug 22, 2024 at 03:20:20PM CEST, gakula@marvell.com wrote:
>>>This series adds representor support for each rvu devices.
>>>When switchdev mode is enabled, representor netdev is registered for
>>>each rvu device. In implementation of representor model, one NIX HW LF
>>>with multiple SQ and RQ is reserved, where each RQ and SQ of the LF are
>>>mapped to a representor. A loopback channel is reserved to support
>>>packet path between representors and VFs.
>>>CN10K silicon supports 2 types of MACs, RPM and SDP. This patch set
>>>adds representor support for both RPM and SDP MAC interfaces.
>>>
>>>- Patch 1: Refactors and exports the shared service functions.
>>>- Patch 2: Implements basic representor driver.
>>>- Patch 3: Add devlink support to create representor netdevs that
>>>  can be used to manage VFs.
>>>- Patch 4: Implements basec netdev_ndo_ops.
>>>- Patch 5: Installs tcam rules to route packets between representor and
>>>	   VFs.
>>>- Patch 6: Enables fetching VF stats via representor interface
>>>- Patch 7: Adds support to sync link state between representors and VFs .
>>>- Patch 8: Enables configuring VF MTU via representor netdevs.
>>>- Patch 9: Add representors for sdp MAC.
>>>- Patch 10: Add devlink port support.
>>
>>What is the fastpath? Where do you offload any configuration that actually
>>ensures VF<->physical_port and VF<->VF traffic? There should be some
>>bridge/tc/route offload.
>Packet between  VFs and VF -> physical ports are done based on tcam rules installed by  TC only.

Where is the code implementing that?


>>
>>Or, what I fear, do you use some implicit mac-based steering? If yes, you
>No, we don’t do any mac based traffic steerring.
>
>>should not. In switchdev mode, if user does not configure representors to
>>forward packets, there is no packet forwarding.
>
>

