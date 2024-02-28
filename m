Return-Path: <netdev+bounces-75779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A51E786B286
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 15:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B01BCB23D9B
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A74315B972;
	Wed, 28 Feb 2024 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHGCC82G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B68F15B11F
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132380; cv=none; b=orurzL9lEb2QDRK1L8+uF/Z/3a+QluxhzAW7oTO8OXnYMFmiWCWNStqcVa36+IRjJwYePb57CF6i+epHYXYoXTZDwKqa1XmHv8uDcDqRh1mHqyyT2QUPt0GEa6t173FH37oJ14AXieeYIc9CfD9XrcBgtWjIptQya1A8vL+JtKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132380; c=relaxed/simple;
	bh=DGibxGXROfONoqQx0DYX48YEs23do8kEJg5PaBmKah8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V698VaUnw5d60stPg8YmQJzptoy43nlrBREnFE7zP4JU7z18/f9NKt/ggp9wjocooMzy6LSHKfoNs81DrES88h4caVHJEizLj9/Zxdcz4aGnLhW51yIrvfvmI9wVBXxzx8SMb2Bf5aDZRFAlg9grihOtV2U/B7YqHoRO4Z0eBPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yHGCC82G; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412a9e9c776so6056385e9.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 06:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709132377; x=1709737177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rbrx7HVa2y5fUE9QU+x+EKnMvXEJQXBHESgYcH8oieA=;
        b=yHGCC82GKurxUf1GMdZo7v8eQMvPo0SYB9A5P3+tWrRxZCGGp57JCZefy73yrc30Xm
         06b6GUF60XNXLtiLpH515CyWM8edfDpEyHZ4QVrga07VV4V8Pp/tIN2RQIlaRKdFGwjH
         J5isN3+YK5/RMeMochXSUcV5NIQ4OeNndG/MXoitUA86Dllyes1pL4DAJmrHF4ffC2KT
         iU7kLbUbVCM2sUG39gcpoJxENypeA0Es6K0mh53HsqlYbkg4/9DxzelzjAY0CMBWhlaN
         zmfy3dVyb7Qb8ltOsn4EPaB8fncQuDqpeDxiZBRiINxudo69oAAb2FAgdOHvCvyOx0ar
         oTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709132377; x=1709737177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbrx7HVa2y5fUE9QU+x+EKnMvXEJQXBHESgYcH8oieA=;
        b=q2HEg0Xv2b8ZsnZnDCRW0mYU6vFRxVHX9DKxIJYSO5pnvM8F88Sq+PdNWzLfm2Slyb
         xjxPP0zRN+po6aKdvZcOXi+vxHSx1H2NhcbtGGWYfmQ6QoVwaAqP4EEmqB84cVE6MQic
         7UUfTUig2dRAXO4jve7Umy6fHGudF+QbC+LxzP1yQaOnhKsUpgkIttFwpVE3kBRhjBgf
         frGxhLLA0oZ0VWLlATFOQIxdPRUuJJcmfu8y45clzEtPG/POIw6Fxk6igwgL3MAAfuJr
         TqcjCz5NuDtJ3rbqRUAEk69Bklnv/UkzqjWwnrH6PWIjXxvOBwOxlviigz/UR5qJZgSB
         eucg==
X-Forwarded-Encrypted: i=1; AJvYcCXJCEwBYRmU7p2IcLG+OmHLHT1Y/ITsblKPfffIHfrjYR9siqzbYzTD4P9Z5pIHJbwErYqDwUBkRZ0bqk3PUCZ3Cm3LbXeM
X-Gm-Message-State: AOJu0YxwrSuy40LxeYQpwBAApQfxWf3hjIRz3EBb1DBNKFKQr5txlvYT
	3byyPbtUPbuHSB4CMdmk8JEGfHa8ThCrSM6BO/Jki1gF4nlJXUQtD+gKlsAMSY0=
X-Google-Smtp-Source: AGHT+IFchycGMykpHbANjTJFoomdujpktccrhzPLJQUuqBou81fEAjdXv27WGdHHfvK2TAZOUqVLxg==
X-Received: by 2002:a05:600c:4f0c:b0:412:b431:eb31 with SMTP id l12-20020a05600c4f0c00b00412b431eb31mr1837067wmq.18.1709132376444;
        Wed, 28 Feb 2024 06:59:36 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id k8-20020a7bc408000000b00412b011458fsm2304389wmi.30.2024.02.28.06.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 06:59:36 -0800 (PST)
Date: Wed, 28 Feb 2024 17:59:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@seco.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: fman: Use common error handling code in dtsec_init()
Message-ID: <8e3b3338-d2f9-44ac-bcf6-e53ccc3c9cb2@moroto.mountain>
References: <9b879c8d-4c28-4748-acf6-18dc69d8ebdf@web.de>
 <20240227184657.76ec4e82@kernel.org>
 <Zd7mFe3-kbqjGpxh@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd7mFe3-kbqjGpxh@nanopsycho>

On Wed, Feb 28, 2024 at 08:51:49AM +0100, Jiri Pirko wrote:
> Wed, Feb 28, 2024 at 03:46:57AM CET, kuba@kernel.org wrote:
> >On Tue, 27 Feb 2024 14:14:52 +0100 Markus Elfring wrote:
> >> Adjust jump targets so that a bit of exception handling can be better
> >> reused at the end of this function implementation.
> >
> >Okay, but..
> >
> >>  .../net/ethernet/freescale/fman/fman_dtsec.c  | 19 +++++++++++--------
> >>  1 file changed, 11 insertions(+), 8 deletions(-)
> >
> >..you've added more lines than you've removed so what's the point.
> 
> To have cleaner error path? Not always lines of code is the correct
> indicator of patch quality :)
> 

I really don't like those goto e_nomem type of things.  When you're
laddering gotos you should do that kind of thing before the gotos so
that when people add new gotos it doesn't make a mess.  It's the same
for unlocks, do that before the goto unless it matches a lock at the
very start of the function.  Or if you're doing a goto from inside a
loop then clean up the partial iteration through the loop before the
goto.

regards,
dan carpenter


