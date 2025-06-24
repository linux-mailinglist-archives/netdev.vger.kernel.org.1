Return-Path: <netdev+bounces-200548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D72AE60BD
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01113BCD6C
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC2226B080;
	Tue, 24 Jun 2025 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJH3iY9d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5620182BC
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756960; cv=none; b=H78L5X8UdhVT2HpomqjaU62vxS+2cuj6RGpL05whjuz98xtTtynvr9g1fMOjKKlA/Tv8SP8bXoxSk5/D1YGD8jRr6R/xfR5GvURu1RjBPmpjnb6Gdli+ntAzkQ324KGZRk6uu5OJXlsi5XwUaKeB4PBaIDviURc7rVUEJeM49zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756960; c=relaxed/simple;
	bh=Ukpq1jm45aKlAkIiV9+KqhS/HWscWUWDsBXAj4p/usI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkB2IyH5YpSY+RYyaLGs1AiH4VS19TmmLrmETAnFP0WlOki83wdWWNGdBtqodTp5uvcqiliy0M/0ZrXIUVY9ov3E7kYRiYkDiGlhCrtuGBCvMnSPilAUTLewoJyqNSJAWHRrFOrqybKb6IMDYzwKw+3IKjhVHpg2XPj6G/BdWhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJH3iY9d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750756957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6i5R+n/vxWexSFBa34cQSzNcknWdUpndgD8c+k05TSM=;
	b=YJH3iY9dCKwFTh9ZDVv178HPgWEgRYAbHWsF2PF26YrQ77g/d9KJQV/WcGX2BqwRiyBzRA
	zOI3f8dPs4h38/UUe1wwfk7EopjRg+br6b0hjW1pFCHxkfQwyg+pkk0zior3gO5KStwdUF
	Ad+Mj0iS3EtEcL7mzvaJ8rhFrUedTgo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-TlvJwDidO4Kpad7hMmNr8w-1; Tue, 24 Jun 2025 05:22:35 -0400
X-MC-Unique: TlvJwDidO4Kpad7hMmNr8w-1
X-Mimecast-MFC-AGG-ID: TlvJwDidO4Kpad7hMmNr8w_1750756955
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so1328645e9.0
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 02:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750756954; x=1751361754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6i5R+n/vxWexSFBa34cQSzNcknWdUpndgD8c+k05TSM=;
        b=Bk5WDOVjEysoegZSw+In6Bv35u50ohH1MEdxn3K+GOwq6Qx23HcAiNfSK65KeibgLW
         4Pl0WcERUH5gwdGUWAkZ1U9qxQtjyG/DNvg/l7TXlT5rAKfNSk3bwJ/r9WwdZ2o0Hk2a
         2VXW4VJQDqckWYpUscSpY9XhwJ13BALATQ6yT0ZUoWMrnjwfjJAVyC1grCYOF599SWda
         bcNjKJhToqdkERWo8f+qvKjZvnczR2bv11X/hCiyukaaBM3i12CL5POtGbZGizMdwAbe
         R3xvJMq1Vaoq6CvXt42UMxioLR9+GToKnhuO6aXqdQX8t/nRedhRLVEZe9GCbbhe9u6j
         gn1g==
X-Forwarded-Encrypted: i=1; AJvYcCW22sRm9v4aVP42aI29gmCESW7NGNEVhGyR8RAFEc/J+fe5X+lPNTwcZMPdYjOlLXIruqeyQA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFpnBKX3cNhtd1HJb3HCI60OyuMS8bsMx0oZauCFttVKf0ZKoz
	8RpmKpOcV7ZBvJAc5Jk73hhYIK0bnPSL7XwA7jbnMigPdhK+P+10G3lZqRxdR9trYaP6gKH7UxN
	zweHUaGFBoXkIazf4NIx2vLaeuZLOJLcFo7f63DLxmACRJDtf+mAzEk76zw==
X-Gm-Gg: ASbGncvaDkjN6ZR9P2lOv/qFGJA5fTwzJrZOUnGQAYpuw+kSdYbaqO7sjOJhvQNBf+t
	goMPD0J5MCdPRf0u3F/cyMITHQHUKCi1SN8XMtivEb0iaPSW+OwQs5bnS1H5ii5bJsQembPukuF
	QIn2TcfjasNDQ2k550EZF1BbSUCZCe+5rvWhDo6ZRV2MJOFlluDdZunRlTUSTz7Y0/cNGGgPxLW
	D5EH0Bg8G5HlfokpM3MnSe9ycb4Q9FD/lt/3wvZiRXW9rh7ChJ96WJGvOXPMSozjJhhHa2r0ALh
	sbEmsmw4sD7ma9XSxpsEs/UrX13i6w==
X-Received: by 2002:a05:600c:358a:b0:442:d9fc:7de with SMTP id 5b1f17b1804b1-453662c4ce5mr114324675e9.22.1750756954556;
        Tue, 24 Jun 2025 02:22:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDjlhoN4Ydt23k3YEBasRRqSzsYV7t/7wCcPkWzugVKQL+QOzhD83UOYUchZtB5g1nQg8jnQ==
X-Received: by 2002:a05:600c:358a:b0:442:d9fc:7de with SMTP id 5b1f17b1804b1-453662c4ce5mr114324445e9.22.1750756954162;
        Tue, 24 Jun 2025 02:22:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453647082a2sm136692175e9.37.2025.06.24.02.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 02:22:33 -0700 (PDT)
Message-ID: <caef5686-961d-43aa-8141-c9c90ada2307@redhat.com>
Date: Tue, 24 Jun 2025 11:22:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 08/13] ptp: Split out PTP_PIN_GETFUNC ioctl code
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
References: <20250620130144.351492917@linutronix.de>
 <20250620131944.218487429@linutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250620131944.218487429@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/25 3:24 PM, Thomas Gleixner wrote:
> Continue the ptp_ioctl() cleanup by splitting out the PTP_PIN_GETFUNC ioctl
> code into a helper function. Convert to lock guard while at it.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/ptp/ptp_chardev.c |   52 ++++++++++++++++++++--------------------------
>  1 file changed, 23 insertions(+), 29 deletions(-)
> 
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -396,6 +396,28 @@ static long ptp_sys_offset(struct ptp_cl
>  	return copy_to_user(arg, sysoff, sizeof(*sysoff)) ? -EFAULT : 0;
>  }
>  
> +static long ptp_pin_getfunc(struct ptp_clock *ptp, unsigned int cmd, void __user *arg)
> +{
> +	struct ptp_clock_info *ops = ptp->info;
> +	struct ptp_pin_desc pd;
> +
> +	if (copy_from_user(&pd, arg, sizeof(pd)))
> +		return -EFAULT;
> +
> +	if (cmd == PTP_PIN_GETFUNC2 && !mem_is_zero(pd.rsv, sizeof(pd.rsv)))
> +		return -EINVAL;
> +	else
> +		memset(pd.rsv, 0, sizeof(pd.rsv));

Minor nit: I personally find the 'else' statement after return
counter-intuitive and dropping it would save an additional LoC.

Thanks,

Paolo


