Return-Path: <netdev+bounces-201318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3F8AE8FC0
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 23:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E38E27AE94B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F28214236;
	Wed, 25 Jun 2025 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7MmOr7L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FE61FC0EF;
	Wed, 25 Jun 2025 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750885221; cv=none; b=qQtpqfD3fk2GfFKBWZk3SFy1ghADZMS8I2IkvnW19ISu/HvxEdNMgLmEHh/ZF1LkUqaWsUTlwhLowAh58UymzbSiJE5F/mrGjTjFQyhU/Mv4H1X/ZKJ14mscneol5a4SwoiLUaWYjuM67YhS87lE+htZuRRgpHBcr7wwlCTEXvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750885221; c=relaxed/simple;
	bh=OfHpIqLcTHpXdRZRk0FudQdPhydGbCfNuVEN1gTGALc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhiLBl7z5FJ6Q3QfEM5r3Iqukd1wexdz9B1TxGKeaC7xD8Wv0no3oFF50GR29p8ux2HUAPmddST1U3K2I3hIyNqk4duJxSGjjz2pUzQWXUDgQDjaX9e1g98uHYqrbN2+e++tviA6AMIZ54JkQ/znR/HuUyt+xdQwOWLXv8hCMXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7MmOr7L; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ade3ce5a892so6543366b.3;
        Wed, 25 Jun 2025 14:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750885218; x=1751490018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xtDyYW716erUZTye2I7Yx5cC7l6zf3E0f6lveSci/PM=;
        b=I7MmOr7LrhmaGFofK5WG8l1/mxPD7FsdO9jmO+FisDBdPQHfJ6wxC+00wC8PqzNymk
         RR9TzQXAhHeTW+3APm48OGtymlIxwGQ1LIJBzwGq5goRKFqrITC0bW/tFMivtIeOv6Ti
         ysT22tmUhR3Q1fpbwwztwmzloWCXYZ9bbNNVa6oLf1NW9Y5HcsShy05T4stn5AmshgiC
         3wyv/j4LTGuXMnggaQf53E4K5sKcTclL0l9XEWsdB27WX0lzLsEj7zG6beZsqasiSyff
         bExGURBMm7FKhFtx99F8mMVdSWTq1nld13BkxqJX+CnAn05TeUansLG5YuL0+EBKvprv
         umxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750885218; x=1751490018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtDyYW716erUZTye2I7Yx5cC7l6zf3E0f6lveSci/PM=;
        b=HpW2vFXFHDRjV+jlAp/OKJ5PZ53onjHUzShJrP8ILkLgphinbmn8JCaJR5XSGArrq7
         Y51UWV89bBaSdk8+jIW5zSo8qEc/yWNUtQaCjrGh9XGEeudWrPShCsoqtKTfUb+oup0q
         +iePI7yABvQGcggNAad+fsP/JbVeNG7Dm+8LJxU+swPXNYe0HzQwahurq3hKySC8Ba8/
         Ib+at6N4IWzxNh/BKAR4ZLB8hzs8Mx9ZvFF94J34PTRobClq+nmDS6qwi9clkBIixm1n
         N3wzMW5eDOFB8KRDke79fFb/1PY4peBJN1AMdWQJz5x60oSoLvqzJZzl1OilfHO3UZvr
         jhLA==
X-Forwarded-Encrypted: i=1; AJvYcCWFpsqWhSVjYQvJisjh1lpe1R3jS/Nj+Yw6B6TBGUtELqnSM8tlT/J7Uz6yM1hDpePU7WA0NBQKfgfYJnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4cjItLE14zcFj11EvGXC5prjsAhKTR2KuyB8N4MwCA1DaF6eP
	gVp8Dph56UL2MHeBrS1DwZ7IVdh1B57ptebk7clgUgEk2ec4GOW8ybdw
X-Gm-Gg: ASbGncuYzMOVg1U1BiTUJg4MXZ3Je1it4vqFYV7kIhsK9fPPGwiz1By3P5c1yPRI9GQ
	KCI6ztm5p42Agk9MS4E1raEAYzYblUyZcmPB9wDibG7iC+7s/tdWLqISRxAI8O+UIF3rwDGFagw
	3zC3COrGWXZWp9aBl8p/yBs45ZAJ8sk3WmYQJg5mOd7teQkPO6IhP+C9PLotyHqEUy3vdBGTY3T
	gib1K4PS0RwFLaLMtmuqbDTp3cRpZqjxaEk7mQacRPHR5ExFf3PCjVN4qE7B0wuWCed9ZwikoEy
	AU3bhWXsa1YMOjhLmucVftnvmbxpNfaKcTfzpTPhu63d04+tjA==
X-Google-Smtp-Source: AGHT+IHoXq4o4O1lxYBHsSHlr0waxrAX3plNIH8HYR58L9eywjGP/mbTDhqAD9j1ufTf9GCb/8sTSA==
X-Received: by 2002:a17:906:318d:b0:ad2:23d0:cde3 with SMTP id a640c23a62f3a-ae0bef3d062mr123463466b.15.1750885218186;
        Wed, 25 Jun 2025 14:00:18 -0700 (PDT)
Received: from skbuf ([86.127.223.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541bcec5sm1114461166b.143.2025.06.25.14.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 14:00:16 -0700 (PDT)
Date: Thu, 26 Jun 2025 00:00:14 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: nathan.lynch@amd.com, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: packing: Include necessary headers
Message-ID: <20250625210014.eqajfqiqkmycgoy4@skbuf>
References: <20250624-packing-includes-v1-1-c23c81fab508@amd.com>
 <20250624-packing-includes-v1-1-c23c81fab508@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-packing-includes-v1-1-c23c81fab508@amd.com>
 <20250624-packing-includes-v1-1-c23c81fab508@amd.com>

On Tue, Jun 24, 2025 at 08:50:44AM -0500, Nathan Lynch via B4 Relay wrote:
> From: Nathan Lynch <nathan.lynch@amd.com>
> 
> packing.h uses ARRAY_SIZE(), BUILD_BUG_ON_MSG(), min(), max(), and
> sizeof_field() without including the headers where they are defined,
> potentially causing build failures.
> 
> Fix this in packing.h and sort the result.
> 
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
>  include/linux/packing.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/packing.h b/include/linux/packing.h
> index 0589d70bbe0434c418f41b842f92b3300a107762..20ae4d452c7bb4069eb625ba332d617c2a840193 100644
> --- a/include/linux/packing.h
> +++ b/include/linux/packing.h
> @@ -5,8 +5,12 @@
>  #ifndef _LINUX_PACKING_H
>  #define _LINUX_PACKING_H
>  
> -#include <linux/types.h>
> +#include <linux/array_size.h>
>  #include <linux/bitops.h>
> +#include <linux/build_bug.h>
> +#include <linux/minmax.h>
> +#include <linux/stddef.h>
> +#include <linux/types.h>
>  
>  #define GEN_PACKED_FIELD_STRUCT(__type) \
>  	struct packed_field_ ## __type { \
> 
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250624-packing-includes-5d544b1efd86
> 
> Best regards,
> -- 
> Nathan Lynch <nathan.lynch@amd.com>
> 
> 

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

I assume this patch is not necessary for stable kernels, I haven't
noticed any build breakage report in the packing integrations thus far.

Netdev maintainers, can you pick this patch up via net-next? All past
contributions to packing went through networking. Let me see if I can
revive it in patchwork.

pw-bot: under-review

Nathan, if netdev maintainers don't respond within 24 hours, can you
please post a v2 of this patch explicitly targeting the net-next tree,
as per Documentation/process/maintainer-netdev.rst?

