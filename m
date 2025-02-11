Return-Path: <netdev+bounces-165276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AB6A3160A
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4667E3A06FF
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F7A261592;
	Tue, 11 Feb 2025 19:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Vi3rG4MR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9852626562C
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303682; cv=none; b=LIT6X+4/5CKQLywLzKOZbUqlXAq4Yd2y1xsPvaIT/Em1tFzia5stU9nys7+ieVh5uuKmppPN4RC0nmOtD3k9TAMhskAUkxRO76Db8A032nSn4V9yzsw5taECbM5NN74MBQjB5/u3w4OFa2KoA6frD38CO7f2TeoxMyoA1feTb5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303682; c=relaxed/simple;
	bh=/LnRNKsSeHarCEcGt6s7GQnikEoa7tUtmLzliMuwik4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATUsrMOyTVOXW71yJOokzhDYO5NR+0774zY3NhVBD5vqd9eM+xNyY0NGYgdg/GpbhMobkeaEyyfLXJR+syHGJ7qc6pqDrVcExsEJDS0XPFAWL4d0HwqkwJSlZgBkU+TJDZUtFLCBeutx0Z84umyKUCpOdf7seXZ2fdFWBCLw9pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Vi3rG4MR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f2339dcfdso1749115ad.1
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 11:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739303680; x=1739908480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVy/xf6PjorjI/7sJR8fb9keGNyWM2jlUfvzyIc5MAQ=;
        b=Vi3rG4MRXnjhFjQJUK8Sb0NcB6e9naVQHmaYWJgOHo/GmMw5bUnGUnYzO63ZVRNUMV
         xdLPoDISMYayproswD9BKEYt8qkRMoamb4CWD4zMvCYsVg0ZQ0e4FdJdjKy2Tg92eSIk
         1UKtyRyhda9LviOA2sN8rEmcMqKkCFBjVAoGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739303680; x=1739908480;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVy/xf6PjorjI/7sJR8fb9keGNyWM2jlUfvzyIc5MAQ=;
        b=GTiOtRwyj/vh4iTr1UZ0ekIbs5wwXeCdJAq2LCJKkwoCQDgbo6iVVB34Edp7AffdaC
         OwdEmlmEv5YdsepyHYa2EbCrVZA7rvLoF+TzoFNlt/Qo/Vmb35wzd6uYTEyvPCTYaItg
         I6J5AD+VrYxDF4QjF29DplWmD5Ihheb5vXzGS+Hwnzqkp+C9CVLOpGMm77z0+rj91wqF
         AOpetNXLSJ2YSJDQEB+bfwod3VEOxgchwpn8UYXh4SziWnFm5Fc9bBz/DjTV248E1w+o
         jvNSXOvva46do6cqvWegi/tOhe3qcOA8aNErwyOqV+S6fdYVk+wn288tBdUkx4cgID87
         DAeA==
X-Forwarded-Encrypted: i=1; AJvYcCWhf7NAGePSQnBjQR5ocbVY45oTsW6fhV8EsSRcB7l+/zXCrEFiP90RUj/pUUvRc1l+kfQqhkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg9HYprcqqRqzqc5PcgPO41WQLkS5r+xXR7EL9DUc7uCLwbWlJ
	5xfbPORG78z+trcWGADwtegU0qbfo89yrzgQ4iKUjnJYxXFZzjNbZJ69kt5SZ0o=
X-Gm-Gg: ASbGncstW3B4mItqXNBO02jbQl+EOubWFYiU65l+McRQ5soaV4IQWbGd+83PNIAeCNL
	uAx5xzM2qrv28uM1Ls7qmVC6L5G1Pr+Pz8kHLrKfCEqZwCWutxKy49HgKC1MXf3Rx6+hLDDI28a
	UskjAeMKbmexIzaN/I9HNfGt4xb8NvmeNPPHcSzl2LV3lz0BgXeohUagXDR119ycbjbc6SLAFTS
	d4nYctrkf4OvyD2xNYKFJzLDqeJvnmIHDjYiDe9gz8iN/MmVQsfqdPZpmbDd/icjC5k6gXhbyYE
	AqJdlMA5IhDY99WjuKjWpIYZP7AJ+KnfnnfOtfLiNCNyY5Lv/Gkazqnbag==
X-Google-Smtp-Source: AGHT+IFrFg9rcWVRZXYna/afuwk5nqJ9ZR4F4VRSZ67wNYmrzHuUG/NBwTPbkgJtQUp60JdYXqftLQ==
X-Received: by 2002:a17:902:ebd1:b0:215:58be:3349 with SMTP id d9443c01a7336-220bc202f37mr5974295ad.14.1739303679853;
        Tue, 11 Feb 2025 11:54:39 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650cf56sm100217155ad.11.2025.02.11.11.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:54:39 -0800 (PST)
Date: Tue, 11 Feb 2025 11:54:37 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, alexanderduyck@fb.com, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org
Subject: Re: [PATCH net-next 5/5] eth: fbnic: re-sort the objects in the
 Makefile
Message-ID: <Z6uq_f7knvHIhFT_@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	alexanderduyck@fb.com, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
References: <20250211181356.580800-1-kuba@kernel.org>
 <20250211181356.580800-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211181356.580800-6-kuba@kernel.org>

On Tue, Feb 11, 2025 at 10:13:56AM -0800, Jakub Kicinski wrote:
> Looks like recent commit broke the sort order, fix it.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/meta/fbnic/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
> index 239b2258ec65..0dbc634adb4b 100644
> --- a/drivers/net/ethernet/meta/fbnic/Makefile
> +++ b/drivers/net/ethernet/meta/fbnic/Makefile
> @@ -20,6 +20,7 @@ fbnic-y := fbnic_csr.o \
>  	   fbnic_pci.o \
>  	   fbnic_phylink.o \
>  	   fbnic_rpc.o \
> +	   fbnic_time.o \
>  	   fbnic_tlv.o \
>  	   fbnic_txrx.o \
> -	   fbnic_time.o
> +# End of objects

Incredibly minor nit, do you want to remove the trailing '\' after
fbnic_txrx.o which is the new last line to keep the format
consistent with how it was previously?

Your call, but I definitely feel bad pointing that out and
potentially causing a re-spin, so:

Acked-by: Joe Damato <jdamato@fastly.com>

