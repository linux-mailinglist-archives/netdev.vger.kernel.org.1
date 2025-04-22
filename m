Return-Path: <netdev+bounces-184824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8ABA975EF
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 21:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F12189EC81
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 19:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D247C1DFE26;
	Tue, 22 Apr 2025 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="OlBFwOtG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34801096F
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351305; cv=none; b=p1eUYo6Av6l74CVbIR4vRTCIKK1EgW0G+nhUsBcdEKZiELFnFzANER0W+VzbgubLl9cAxFJEHU8hU8L3044xjnGbURScYeQLW+mXVXEFeDBO6jqFKf1CkqbplIjv/IQRxD0mZ70S3YBST4RN4r81pFzpNxocdzskTf780jdCLoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351305; c=relaxed/simple;
	bh=wkFu0wUi6nPlHTBZ70YIY3CQcYpzt5l8aTBIjGGQSO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPFt0VfWcwaSJSdtu/iX765ApkwOiGjtDhNEMidukC++YXNunc0Ly2EnYP7dfVWjwd8GTU0e6hOkexubr2w5U46d36qdDvavDPqpyjFdDwK72xCZQPJt/yZy4plXEuc74FzXM1RTYmiTG7QFdK+RQszDoW6UMWz6ogvkHg2wFx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=OlBFwOtG; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b041afe0ee1so5119463a12.1
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 12:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745351303; x=1745956103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPTaNEEVrW/ss6Gyzs+4nfxu3Si09cGlaCQlKhF72jg=;
        b=OlBFwOtGTRpAne9A7pOkWXvc/JJmVyKC69mNVZViZ9LWztl+rWaeMrqdCcFmTw6kXe
         zO42VfjDvI5cVfBjaUzvi8Ft5vg16BdjJdkh8dRGh+iYOgXpp+dRR7jQCGl7qno6JS9T
         JmaM034xoidO89txTNvbHSis3PBt9cNM1EKUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745351303; x=1745956103;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPTaNEEVrW/ss6Gyzs+4nfxu3Si09cGlaCQlKhF72jg=;
        b=m/LNzQyNWFYSG8RzUGLdLp5gN+bTqEunoceUmDkWUvuf5Y1gfZve5wLRJgwuIuU7hH
         pc8r1iMIjN1eG2OWIAfYnN8ow5j5fbqAq4KlPOQI7TvO2FKGMNWdWSSFqpLpTlAmC3qK
         iS2zODQfFm7DgEkato5G/5mD0BHwAXz0+dSSAlAvFuMOCOamxCx39EntNuATmXAS1Ixi
         ISqLS3SH6JR/Vwm5jLDWazAYJcE63DuBRtCVvGo5O/jdgF7Vl7tg7VoFKTK/a0HavzW3
         jF2nw3+0SWYblpv86VU0a2zikFZjOyDXrw8whYIk9rXO6wcTw9tJOg0RYNV4NqNxupUV
         T0zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHYzZdoZQtBEnlIqCIx1F1Z7DmO4rbZL/NLwp0yFf7mFGPTzzasvb/vu6ryiUdgp0GydY+Z4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw4b0RyjsVnHIXLQ2NPqPPWQ1xTMNVVRzDv+t0HiJuw9kN9d2w
	LSQfh2vTHklDoukdQJE3sbMfl6lPuWJn8p9D+eU6/s5u1ByO8eyBQir8Img6kRQ=
X-Gm-Gg: ASbGncv3WdhXJkGx5OpBRAu626H+B1xBJxC+foQIg/qm1eDoSGKylW3B8iruVOdVGH2
	TJnKOQRvzeMW3WHuFWmtBpkhjM519irUWWbNJ1/ekWH9eZXCk/HDull61LgI6qW9h7j9RphzTrY
	oJ6hrj1+/wKt0QcvWHNigjVNqIQQQsPAULk1sKl/zLAjeL6G26WU2V7Qvhe6frzOu3HM5gLmc1S
	AvjgKvcdPMeT+JY3drwXd2Fick1SDnnm0I6chDJf6+gxnD3+Vp+1Kaww46fLhWM6URM1bxhilqg
	BYdlJGL/QqcV+kbHd57wXhAf2oiAOP4e8ma3SSQ1l1OVHESUG1J30JLLVqnf4eKYZxMT4alTRDA
	k7AZqwD/2UwsaSZ5MtcRCOB0=
X-Google-Smtp-Source: AGHT+IEt8vhDmR4xKySFz2X4yJiR/sUmbO3jYP5HxdvZndyGaLDRLRB/HRzIOW/Qi+tjCg9XPFIiqA==
X-Received: by 2002:a17:903:2f88:b0:223:65a9:ab86 with SMTP id d9443c01a7336-22c535a4b55mr254830935ad.12.1745351303137;
        Tue, 22 Apr 2025 12:48:23 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfa59165sm9358825b3a.93.2025.04.22.12.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 12:48:22 -0700 (PDT)
Date: Tue, 22 Apr 2025 12:48:19 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
	dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
	dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 01/22] docs: ethtool: document that rx_buf_len
 must control payload lengths
Message-ID: <aAfyg5fXv4Q11nEF@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
	sdf@fomichev.me, almasrymina@google.com, dw@davidwei.uk,
	asml.silence@gmail.com, ap420073@gmail.com, dtatulea@nvidia.com,
	michael.chan@broadcom.com
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421222827.283737-2-kuba@kernel.org>

On Mon, Apr 21, 2025 at 03:28:06PM -0700, Jakub Kicinski wrote:
> Document the semantics of the rx_buf_len ethtool ring param.
> Clarify its meaning in case of HDS, where driver may have
> two separate buffer pools.

FWIW the docs added below don't explicitly mention HDS, but I
suppose that is implied from the multiple memory pools? Not sure if
it's worth elucidating that.
 
> The various zero-copy TCP Rx schemes we have suffer from memory
> management overhead. Specifically applications aren't too impressed
> with the number of 4kB buffers they have to juggle. Zero-copy
> TCP makes most sense with larger memory transfers so using
> 16kB or 32kB buffers (with the help of HW-GRO) feels more
> natural.

I think adding something about the above into the docs could be
helpful, but then again I am always in favor of more words.

See below for a minor spelling nit.

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/networking/ethtool-netlink.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index b6e9af4d0f1b..eaa9c17a3cb1 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -957,7 +957,6 @@ Kernel checks that requested ring sizes do not exceed limits reported by
>  driver. Driver may impose additional constraints and may not support all
>  attributes.
>  
> -
>  ``ETHTOOL_A_RINGS_CQE_SIZE`` specifies the completion queue event size.
>  Completion queue events (CQE) are the events posted by NIC to indicate the
>  completion status of a packet when the packet is sent (like send success or
> @@ -971,6 +970,11 @@ completion queue size can be adjusted in the driver if CQE size is modified.
>  header / data split feature. If a received packet size is larger than this
>  threshold value, header and data will be split.
>  
> +``ETHTOOL_A_RINGS_RX_BUF_LEN`` controls the size of the buffer chunks driver
> +uses to receive packets. If the device uses different memory polls for headers
                                                         pools?  ^^

