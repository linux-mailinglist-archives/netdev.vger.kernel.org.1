Return-Path: <netdev+bounces-69555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B2884BABA
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 17:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F714285DCA
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C685F134CCC;
	Tue,  6 Feb 2024 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyE2xX4q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D502412E1ED
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236256; cv=none; b=gRiHP86ynzvnb4Jl2zmNcwce/++A6I3Khh4/+d4M6KnGD5gxFRA+8zWXS/2YUzVxSu/sw/JN4/92LxV69G96VKetrEjEoK8KfSf8YlYcrl8U31hK4GcQhzu98Pauwoq1j/nZdarAbYp8IrGp90X4hHObxzA2RfVK4wQYqf6Bvpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236256; c=relaxed/simple;
	bh=1YgPOl85yyPc5xV29CN/k9kOat45mKw3j2GeUWWyjvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=th4GZaPKRUQQVaCNw1XAZC1IHaKm3Dd6bjl+oI8Dm88QMgLQOWZBhjpQb6srgffxPwG+KGskzADMYknNtfAuF51GmKu0xX72HzScyb/obbEBujLurENqShYqRH6leel0oqdC6uM+JyWZWYZtH0Ga5VTFjxmkNt/Vb1U5e7UTOA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hyE2xX4q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707236253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rjVNrrBbv+vSdoJ+RdtqtP7bE4usPMF+D6CJSRs4s/w=;
	b=hyE2xX4qGlIve8oY+IfuMg6umpBTFIlRD3FFfY7vVWby+ZbNiDKgafh01Pn36zH8tz5I8t
	fGRginizvnu4vSIlDimgBFMYIvMH8Gdj7N653NOrhKz7xQ8C8IKLx/w6wkXMfixUiD/Dcf
	uPlNd051E1kxa8iofWjw9iQSxGB7NUY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-HgA8ufvXMxC0gR3vaivDjw-1; Tue, 06 Feb 2024 11:17:25 -0500
X-MC-Unique: HgA8ufvXMxC0gR3vaivDjw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-680b48a8189so77514336d6.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 08:17:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707236244; x=1707841044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjVNrrBbv+vSdoJ+RdtqtP7bE4usPMF+D6CJSRs4s/w=;
        b=KZAUO/h+nksSdNSjuxuxb52cz42n2g+kJx91O8OCQ9IMTkmq5WDU5qSnLR+aVdoSR6
         15PyKCEp+i+3VdgRbmh0Lcb/BC9unQMPsXXfcndiBo7daIyU2KJ8U0vYaxxradk7OqL9
         JDYnheU3mTtB0fmvnJRDP46Hyz0LG313bWlJ9EVIGdg+EuUVCKGOT9h2CyisBjGPnhEW
         iHRTDiSs8y3rdFT5o1cWxxG8ObNjn9bU0EUovET78OuoQEBmtErNssZD6Q7BGcrBSVwi
         /BwKMu2aueI/iI2hARqp38WsKW8i2zF6559mQDSEG7VFyV6eK01ZKOrUMLZ2BN8slxGH
         MG1A==
X-Gm-Message-State: AOJu0YwlfHc0XKi9IXz+FYM2HXoVnr7M6LGpGif25coathSLXmKDaTct
	iZgtDfwMGOz7JPUDU4rdJOdMYVui1q15txo7eUGy0f6T9UeWcqaDd60zvES/+zYeRAtXQAL9Vg2
	5mJ+BDTi2PEE0icWMKYgkYZskI/6UYKWsVA+8jThlL4RxU12EUHOklQ==
X-Received: by 2002:a05:6214:410e:b0:68c:49a1:5c95 with SMTP id kc14-20020a056214410e00b0068c49a15c95mr3120603qvb.55.1707236244639;
        Tue, 06 Feb 2024 08:17:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgad0kID5syWazkdEZRZ/7PxAEuPnPyD0Ir5Z30gCz9Y1SPZvTT55azPPCIWk39W82ZK7dng==
X-Received: by 2002:a05:6214:410e:b0:68c:49a1:5c95 with SMTP id kc14-20020a056214410e00b0068c49a15c95mr3120586qvb.55.1707236244372;
        Tue, 06 Feb 2024 08:17:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUWMkpTfHCoajAm7rsdJ//Tl8241CoivcLwOsn75rVG0ouoTDL34buRn0yddNkwotukYP7SfSSblfX/M8SyVC87tzFSOtpCrXv1c2TJ7l5Or6VI3QywhuBZX3lMoTqu
Received: from localhost ([78.209.135.42])
        by smtp.gmail.com with ESMTPSA id eb11-20020ad44e4b000000b0068189a17598sm1144388qvb.72.2024.02.06.08.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:17:23 -0800 (PST)
Date: Tue, 6 Feb 2024 17:17:18 +0100
From: Andrea Claudi <aclaudi@redhat.com>
To: Stephen Gallagher <sgallagh@redhat.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@kernel.org
Subject: Re: [PATCH] iproute2: fix type incompatibility in ifstat.c
Message-ID: <ZcJbjmOKMNiNo5LE@renaissance-vector>
References: <20240206142213.777317-1-sgallagh@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206142213.777317-1-sgallagh@redhat.com>

On Tue, Feb 06, 2024 at 09:22:06AM -0500, Stephen Gallagher wrote:
> Throughout ifstat.c, ifstat_ent.val is accessed as a long long unsigned
> type, however it is defined as __u64. This works by coincidence on many
> systems, however on ppc64le, __u64 is a long unsigned.
> 
> This patch makes the type definition consistent with all of the places
> where it is accessed.
> 
> Signed-off-by: Stephen Gallagher <sgallagh@redhat.com>
> ---
>  misc/ifstat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/misc/ifstat.c b/misc/ifstat.c
> index 721f4914..767cedd4 100644
> --- a/misc/ifstat.c
> +++ b/misc/ifstat.c
> @@ -58,7 +58,7 @@ struct ifstat_ent {
>  	struct ifstat_ent	*next;
>  	char			*name;
>  	int			ifindex;
> -	__u64			val[MAXS];
> +	unsigned long long	val[MAXS];
>  	double			rate[MAXS];
>  	__u32			ival[MAXS];
>  };
> -- 
> 2.43.0
> 

Hi Stephen, thanks for taking care of this.

FYI, patch directed to iproute2 or iproute2-next tree should:
- preferrably have [PATCH iproute2] in their subject
- be directed or cc'd to iproute2 maintainers Stephen Hemminger and
  David Ahern, and to the author of the fixed commit if possible.

This should include a Fixes: line on the commit changing val to __u64:
Fixes: 5a52102b7c8f ("ifstat: Add extended statistics to ifstat")
Stephen, David: do Stephen needs to resend this?

That said, patch looks good to me, so feel free to add my reviewed-by to
the following versions of this patch.

Reviewed-by: Andrea Claudi <aclaudi@redhat.com>


