Return-Path: <netdev+bounces-185780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA320A9BB66
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 01:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0251BA0C2C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 23:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A5A28B4F2;
	Thu, 24 Apr 2025 23:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Puwb6bxW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F7D1F460B
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 23:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745538026; cv=none; b=Y/302ZhTPSeFrSevwvE2wDHrlKazlksqpox+l9GHSaeR0rhZBE3CBfr4iRcSicwOEf2/lyaFTezWGQ16kVVDWK1k4WdVB7MzG+JBvyztl/QcpLZjOTNb5nBRLXH3l8qAwVAGmfGRAlSkgsspOTZ6uxSkubfWD5xlTekdK6mn9+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745538026; c=relaxed/simple;
	bh=YobbFFqlSYt9wthFA7Lq082xH6XWFfEE6HWq8OtC3m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3NGtSFem/r8SBI6jnfEOEOkuTBw+8sJ2/UADpiKs7yhFaH5Ib/UDgi6vbKsODZonp3HdhZnazgDKrQoXjDv/qH1PI+/FI7ZZqgc09vU2p1iI7lRvVXwcB//qHUM6xY7CH6VRh+1Grxg68hHYRTyu/9eGsEk8S1psc9aEljmrZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Puwb6bxW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-739be717eddso1233414b3a.2
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 16:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745538023; x=1746142823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6sW68/+qgBX5d4BOzhATZAkm4XfWHBYiE4NUkWdu9o=;
        b=Puwb6bxWJts1q7cV8owE81c4SxDWITjPW1MefBVxK0ePgegvRYMULjmlygV/N2FqFD
         Nj7exgOx0F1wUqXBUKb0hWvjX0OWzrWkkAPjgboFQ87Vt5Cezyohy6O/LsHUb0ZA7Iwy
         5gMbopI+e5DpcIWaqNcrKbHs7mqqRjkD1sQgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745538023; x=1746142823;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6sW68/+qgBX5d4BOzhATZAkm4XfWHBYiE4NUkWdu9o=;
        b=T95VAQbXEQo1GACCl4YYM+GLY/xRrSRKJEFNtKHbp7MznJRWgVDsXIloodhaavA4+n
         IO9vkiXHctTXsQRjNTjPUHD4/wIxvZ8PIuHjm5ZM1AzcXySVLE/uJO+PIEafU898ma9h
         B8ylUlgVUZ2bMu1rh5nz8MCZRZbfhOcXoctf7UOZEXDYpjPtZT3ZSLOgrvOApJOj12bX
         J+GdNHw+BA3NgrC6JQW/UNFQneLW/Rpd6+WiG0j/uhf5BIAJvv/axPTAaOEXlHCCmr7c
         mk5rDgeRuLD/I4hj5NA7BHUh91zMa1q4PKyUxRySIAofMu9eJFeFEYe+Pp7BMnL0oxIF
         +Rkg==
X-Forwarded-Encrypted: i=1; AJvYcCVlWUsewaHfyuN6uuu3gkZrUv7cbSLXtXex1WVhcSg88andOuaTdjzT6gb3QwOf3bhi/DXjgn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy12m6cFIdyX/R88f007RW2bbLcwl3RUXx2B3U27S2SdDNnXb5E
	5dzEm4rL06xY1mgiPbBNH5jdE2+/oMwpS1cXCJ07iMo/7IDC3kqFLIlRTW9dkJOLClOZvweMBhv
	N
X-Gm-Gg: ASbGncs/f3lG2wXcznjtUSUY/sYYCXb0OeB46rskAnvZyxa8Pu/hQ/2cfj0doDU9PkL
	J9mYwM0dVTzaD2ac3zicRRDlN8QtGf3Iqee8oePyBT48WCdkfZcjSY2q4vZLBz4YH5iPnhSBis9
	CjotdH7v0+b+Vckvb3s+hiDwZL33GVKBZvsrsdztgHpynHI/50+unLoy3CA0ZMvM1TDuut+2qfd
	OHOrbCMYbSRb4QCMCD8J+ylbC074/dkD1BKLHlDPLi60cF7f3lghBtljizKK0eF5rKkh+Kr4FMZ
	gAoFzPGCvnos3lbsRUDbn8M35ruUekM1ie1I7iNIx6ebPTLLUMcP1PYpL/Y0QZVjVVRsrKbpjYb
	wO0m6vGk=
X-Google-Smtp-Source: AGHT+IFZ+WYJZSjZbTQhwY27nhvmPRhK+kuNDbWirUnhgt3smOBi7g+wotsjh2E121wgQs4nRnnmUQ==
X-Received: by 2002:a05:6a00:ad3:b0:736:32d2:aa8e with SMTP id d2e1a72fcca58-73fd70d8419mr163058b3a.6.1745538023629;
        Thu, 24 Apr 2025 16:40:23 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25967766sm2001148b3a.82.2025.04.24.16.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 16:40:23 -0700 (PDT)
Date: Thu, 24 Apr 2025 16:40:20 -0700
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/4] net: define an enum for the napi
 threaded state
Message-ID: <aArL5Lac5evBAvz1@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
References: <20250424200222.2602990-1-skhawaja@google.com>
 <20250424200222.2602990-3-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424200222.2602990-3-skhawaja@google.com>

On Thu, Apr 24, 2025 at 08:02:20PM +0000, Samiullah Khawaja wrote:
> Instead of using '0' and '1' for napi threaded state, use an enum with
> 'disable' and 'enable' states, preparing for the next patch to add a new
> 'busy-poll-enable' state. Also update the 'threaded' field in struct
> net_device to u8 instead of bool.

[...]

> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index c9d190fe1f05..c8834161e8ec 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml

[...]

> @@ -283,11 +287,10 @@ attribute-sets:
>        -
>          name: threaded
>          doc: Whether the napi is configured to operate in threaded polling
> -             mode. If this is set to `1` then the NAPI context operates
> +             mode. If this is set to `enable` then the NAPI context operates
>               in threaded polling mode.
> -        type: uint
> -        checks:
> -          max: 1
> +        type: u32
> +        enum: napi-threaded

I think this can still be uint even if associated with an enum? IIUC
(I could be wrong) uint is preferred.

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 3817720e8b24..2eda563307f9 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h

> @@ -2428,7 +2429,7 @@ struct net_device {
>  	struct sfp_bus		*sfp_bus;
>  	struct lock_class_key	*qdisc_tx_busylock;
>  	bool			proto_down;
> -	bool			threaded;
> +	u8			threaded;

Looks like there's a 1 byte hole in a cacheline further up after

  unsigned char              lower_level

Not sure if putting the u8 there and filling that cacheline makes you
feel anything in particular.

(I feel nothing.)

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 3ff275bbf6e2..41d809f2a7f7 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[...]

> @@ -6924,12 +6938,15 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
>  	if (dev->threaded == threaded)
>  		return 0;
>  
> +	val = 0;
>  	if (threaded) {
> +		val |= NAPIF_STATE_THREADED;
> +
>  		list_for_each_entry(napi, &dev->napi_list, dev_list) {
>  			if (!napi->thread) {
>  				err = napi_kthread_create(napi);
>  				if (err) {
> -					threaded = false;
> +					threaded = NETDEV_NAPI_THREADED_DISABLE;
>  					break;
>  				}
>  			}

Re the feedback on the per-NAPI threading setting patch, I think if
you used napi_set_threaded in dev_set_threaded (as mentioned in the
feedback to that patch) you might reduce the changes here.

