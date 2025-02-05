Return-Path: <netdev+bounces-162846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F5EA2822A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 03:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4AE21631B9
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 02:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59192AF0E;
	Wed,  5 Feb 2025 02:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="WEagKtPu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71BD25A65E
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738723838; cv=none; b=iNl3pC1+MndtSGH8rVUpkd7bZ09ff0x/q4JvdgdcR66bpUiJbOKpCJIKMXzZ2V/6ZjEKNmO00GXIUgVYI512+VpdiU6smHbSPs6wAtsMygMlxLfYpQRTU+By8qADuVR0+IZPGGSo3zwliezpHTEfqNQ+njXfB9jrojkFwTLCmKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738723838; c=relaxed/simple;
	bh=1sb3/ahxNhGPqn3Ek8khnC9JCTBHsN4aldmyPk+bDuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpDroygHIHMYxXqZc9g0Wa7ZkN3l87VSh4bqnkYdV4bPu+85Nmn8VykQjTc7D6l4QRzD/aJznY8kgpBWdvD8sVNBsQwZddy0FGav7xnqUP6SknO1lxFHQfTdBzuZJVKJ1RmAGlkanLbmXzQQovsw50oc7HPCbgNuQe3RXEy0uM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=WEagKtPu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21628b3fe7dso116902095ad.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 18:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738723836; x=1739328636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9WFawQnQKVVGNaorOpLxep2o/ls514ITpMsMgu0qKM=;
        b=WEagKtPuvzDhaZnMQAZYzP4j5NyNUOWxxAyuSeZKbasJwKLpay2aq++w7uAydoNVzh
         aLEicCknIx3OoPu4lAOqBsUAZ9Ey9HN7G6t6gnhi7lhXb4RluL/soia1DJ5tz+ioiBFG
         ljTwNwErKRAr3i3lAZ0RjQMAfa1Ltw5JoNdsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738723836; x=1739328636;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q9WFawQnQKVVGNaorOpLxep2o/ls514ITpMsMgu0qKM=;
        b=UIWH6OABE9WZqA9nQQhd7E0wyYz0ut2oRa833OqFXQ9MVEr7tAqk72UxtyCZVX7pOu
         q6m0uvhWyc3AT3Gigr83xZbNOvfJiGoJ1YNF4+Sb/YXGfTLyWyLaWH2i4Ncr90BF6KO6
         gUrEFEbdSTeIQvXo3/bv0m1HzwtIoNPSU+jaIAQDHWcJVFBGvBRXxYlaLc2+wFMofvtT
         eLSx4o1skd/LiZjLaBeZzEEpd+wwNP5ZuoBZsSlQP2AIoQaAUjhJMBmBD91vEM2BiAEk
         i3cSjZ5NjBQKQ+mkjv1f/Olwj5aaIIs1j10jX0EDO4/YXi+tARFy8ma9R+WcWtVmTJ4B
         w5xw==
X-Forwarded-Encrypted: i=1; AJvYcCWk1H431Yi9/rFuDGdI8q4lfGPZTTN22Ue+KoGEehtcp/sWqHhPJj3yH6WlOki5o6hhStjb5tU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqgHC478+mRgbcFlrQF/P5hOuZcjbtVa1QEUBmgWMsvGEQV7zC
	tfL3YryiKKqAw1Sclo0sIY/U/HZVrO3iCmGz7t8FFMO/MbJdz/Eitgey9AYKwYI=
X-Gm-Gg: ASbGnctSWK8g/k6i4Q3eGkMXuJTSdOMKyGciw/LtvDPwAW4s2YxfAKMqQ1svQ7VNP4Y
	08mGZrYa7i3n6flGyx9POK9obTGXwGfXwdj34M75Du8NPC2mKd9iFMlspWxkTubRS3R/eG84K2y
	eZPs03bmsWrZWA0iY3sasTg3phZmf+b5xNBdNBCe9r/2kgf74mZHUMEfBatUaJczGnfrOquB1f1
	HR8pe1NUhkYofWc4FtsUcqh8/OP1wX1tsq7fDmaG7ZAa/oybi0rctB15ofxJ0CJru1cbHtj7lsS
	EjICw/ykEc1fy2jl5vymudMFDER3LfM2QD2SaYa7R4JmovAEUN9SrnohWaxPEe0=
X-Google-Smtp-Source: AGHT+IHX8miKmOyrgTHu8MmwuLGpUEgryuX4KPL3oDrhy7J7dhSDPdHj7rtfKL8DLlA+1CRRyc6D2w==
X-Received: by 2002:a05:6a20:3d90:b0:1e1:a07f:9679 with SMTP id adf61e73a8af0-1ede8810713mr1817022637.4.1738723835782;
        Tue, 04 Feb 2025 18:50:35 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aceef1efc66sm10659793a12.13.2025.02.04.18.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 18:50:35 -0800 (PST)
Date: Tue, 4 Feb 2025 18:50:32 -0800
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/4] Add support to set napi threaded for
 individual napi
Message-ID: <Z6LR-POHxmBV6D7t@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
References: <20250205001052.2590140-1-skhawaja@google.com>
 <20250205001052.2590140-2-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205001052.2590140-2-skhawaja@google.com>

On Wed, Feb 05, 2025 at 12:10:49AM +0000, Samiullah Khawaja wrote:
> A net device has a threaded sysctl that can be used to enable threaded
> napi polling on all of the NAPI contexts under that device. Allow
> enabling threaded napi polling at individual napi level using netlink.
> 
> Extend the netlink operation `napi-set` and allow setting the threaded
> attribute of a NAPI. This will enable the threaded polling on a napi
> context.
> 
> Tested using following command in qemu/virtio-net:
> ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>   --do napi-set       --json '{"id": 66, "threaded": 1}'


At a high level, I think this patch could probably be sent on its
own; IMHO it makes sense to make threaded NAPI per-NAPI via
netdev-genl.

I think its fine if you want to include it in your overall series,
but I think a change like this could probably go in on its own.

[...]

> diff --git a/net/core/dev.c b/net/core/dev.c
> index c0021cbd28fc..50fb234dd7a0 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6787,6 +6787,30 @@ static void init_gro_hash(struct napi_struct *napi)
>  	napi->gro_bitmask = 0;
>  }
>  
> +int napi_set_threaded(struct napi_struct *napi, bool threaded)
> +{
> +	if (napi->dev->threaded)
> +		return -EINVAL;

I feel this is probably a WARN_ON_ONCE situation? Not sure, but in
any case, see below.

> +
> +	if (threaded) {
> +		if (!napi->thread) {
> +			int err = napi_kthread_create(napi);
> +
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	if (napi->config)
> +		napi->config->threaded = threaded;
> +
> +	/* Make sure kthread is created before THREADED bit is set. */
> +	smp_mb__before_atomic();
> +	assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
> +
> +	return 0;
> +}
> +
>  int dev_set_threaded(struct net_device *dev, bool threaded)
>  {
>  	struct napi_struct *napi;
> @@ -6798,6 +6822,11 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
>  		return 0;
>  
>  	if (threaded) {
> +		/* Check if threaded is set at napi level already */
> +		list_for_each_entry(napi, &dev->napi_list, dev_list)
> +			if (test_bit(NAPI_STATE_THREADED, &napi->state))
> +				return -EINVAL;
> +
>  		list_for_each_entry(napi, &dev->napi_list, dev_list) {
>  			if (!napi->thread) {
>  				err = napi_kthread_create(napi);
> @@ -6880,6 +6909,8 @@ static void napi_restore_config(struct napi_struct *n)
>  		napi_hash_add(n);
>  		n->config->napi_id = n->napi_id;
>  	}
> +
> +	napi_set_threaded(n, n->config->threaded);

The return value isn't checked so even if napi_set_threaded returned
EINVAL it seems like there's no way for that error to "bubble" back
up?

