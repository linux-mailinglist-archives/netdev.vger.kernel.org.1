Return-Path: <netdev+bounces-53592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3A4803D67
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8088280F84
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 18:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CBC2F85F;
	Mon,  4 Dec 2023 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAkhKPVn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4DCFF
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 10:45:38 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40859dee28cso47814055e9.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 10:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701715536; x=1702320336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4AIRpBvWkfZCkravhsZi/ZEGDXykOW+FoKHxhfo7MoM=;
        b=GAkhKPVndZIO9eXD7LUXeN+Crb14cnCv77yIXiiEIumul5N+dhb0ybK+25b4WqN8SL
         T42GFCG4FYDqjezOtCnLlH4eKloEqnd0qfG1rcIRH/fFEE1YR5PapnleIFrQkXbWXBWH
         8ra9z7NOl+izl/jX/R+A7ZlH4UVhUQ87qfcAs9bOuH7FpSVNnsIouIn51LRxy5izmaqH
         DdK8MRvuPW5dwRv/PePSekk18zyCNjkGpGg8tmSWvDAUMpkNX4L7JGWeDRIacaSoV0hL
         NCmWI+s6z/JJLTctet1FY+Pn0qR4Q5ST4TWmxyY5VOhu+qdXQmCHAZRJMFDrnuhHUQj8
         S6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701715536; x=1702320336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AIRpBvWkfZCkravhsZi/ZEGDXykOW+FoKHxhfo7MoM=;
        b=wF2OgtUZKq+1U6HEZN1xEvncW1G2/RL9ogO3SNQRice/CGX2NN/YCMac7Jt+TyC3y2
         993oK134djugiSP9yxDDxaPD/SpF12DDcktbKJRenR4mPfR2soFla2VtpLLic7sP1DNi
         Y6hRnpfRtyVHHj+s2weO6VWsfYib5TpPsCiMqCVOQkC7jIA6GjVprmM6zsjo/mXmjJzu
         yGC3DYTO0W5z/lgTgYZgtTCpg6VF/8jdS5r3LGPi9fvR1tQM+xLf1GZtxMcS7Ip8KWqY
         7zQa0zGKKenncQr1X2fz1WPEGr+27tIIqVLY/PaaRbGM7iYfF+hfx/i9UYxHFZbky9o/
         5r5A==
X-Gm-Message-State: AOJu0YxMocfARUZqcR2glv6j2mGqDCQbMyfjmuxMkFkuNiH89K/TUJel
	XBn96KdqjC/blCAJmSPf3fE=
X-Google-Smtp-Source: AGHT+IHgh2KzQcPbMOhXMFPXEoIqG5+aE/DpB7RG0RU+EsefLbQgNgYx3YJ7DCtaqS0jaqS531PKRg==
X-Received: by 2002:a05:600c:45d3:b0:40b:5e22:95b with SMTP id s19-20020a05600c45d300b0040b5e22095bmr3432545wmo.74.1701715536292;
        Mon, 04 Dec 2023 10:45:36 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id iv7-20020a05600c548700b00405959469afsm16010675wmb.3.2023.12.04.10.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 10:45:34 -0800 (PST)
Date: Mon, 4 Dec 2023 20:45:32 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Austin, Alex (DCCG)" <alexaust@amd.com>,
	Alex Austin <alex.austin@amd.com>, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, ecree.xilinx@gmail.com,
	habetsm.xilinx@gmail.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, richardcochran@gmail.com, lorenzo@kernel.org,
	memxor@gmail.com, alardam@gmail.com, bhelgaas@google.com
Subject: Re: [PATCH net-next 1/2] sfc: Implement ndo_hwtstamp_(get|set)
Message-ID: <20231204184532.jukt3qvk7iqv6y4k@skbuf>
References: <20231130135826.19018-1-alex.austin@amd.com>
 <20231130135826.19018-2-alex.austin@amd.com>
 <20231201192531.2d35fb39@kernel.org>
 <ca89ea1b-eaa5-4429-b99c-cf0e40c248db@amd.com>
 <20231204110035.js5zq4z6h4yfhgz5@skbuf>
 <20231204101705.1f063d03@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204101705.1f063d03@kernel.org>

On Mon, Dec 04, 2023 at 10:17:05AM -0800, Jakub Kicinski wrote:
> On Mon, 4 Dec 2023 13:00:35 +0200 Vladimir Oltean wrote:
> > If I may intervene. The "request state" will ultimately go away once all
> > drivers are converted. I know it's more fragile and not all fields are
> > valid, but I think I would like drivers to store the kernel_ variant of
> > the structure, because more stuff will be added to the kernel_ variant
> > in the future (the hwtstamp provider + qualifier), and doing this from
> > the beginning will avoid reworking them again.
> 
> Okay, you know the direction of this work better, so:
> 
> pw-bot: under-review

I mean your observation is in principle fair. If drivers save the struct
kernel_hwtstamp_config in the set() method and give it back in the get()
method (this is very widespread BTW), it's reasonable to question what
happens with the temporary fields, ifr and copied_to_user. Won't we
corrupt the teporary fields of the kernel_hwtstamp_config structure from
the set() with the previous ones from the get()?

The answer, I think, is that we do, but in a safe way. Because we implement
ndo_hwtstamp_set(), the copied_to_user that we save is false (aka "the
driver implementation didn't call copy_to_user()"). And when we give
this structure back in ndo_hwtstamp_get(), we overwrite false with false,
and a good ifr pointer with a bad one.

But the only reason we transport the ifr along with the
kernel_hwtstamp_config is for generic_hwtstamp_ioctl_lower() to work,
aka a new API upper driver on top of an old API real driver. Which is
not the case here, and no one looks at the stale ifr pointer.

It's a lot to think about to make sure that something bad won't happen,
I agree. I still don't believe it will break in subtle ways, but nonetheless
I do recognize the tradeoff. One approach is more straightforward
code-wise but more subtle behavior-wise, and the other is the opposite.

> 
> Report-bugs-to: Vladimir Oltean <olteanv@gmail.com>
> 
> :P

Hmm, I'm not sure if I want to go that far. Alex is free to choose
whichever implementation he sees fit, and so, he is also responsible
for the end result, in spite of any review feedback received. Please
don't consider my message as anything more than a suggestion.

