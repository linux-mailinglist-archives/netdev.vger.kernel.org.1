Return-Path: <netdev+bounces-185782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2A5A9BB71
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 01:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82CF31BA4877
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 23:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1263A28E605;
	Thu, 24 Apr 2025 23:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="c0AkrhCj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DBB77111
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745538142; cv=none; b=n0GQ1LUhL6J9GFQzac/sLVQ3GNIE1lxFc6ybpDxFNqseDlu5I4xcEguGLW7oARwm3pnjt5KYaAr4A6AB4Ko40nFfhD38SEdavDfHiW9HZS4zC5cpn2oikvzdgRIyr9kgo52h2qLWewmYodZN7k+LuFcLhKWCdvt8PTvnPBbMU3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745538142; c=relaxed/simple;
	bh=zVSzCt2b0/G8FfA2VBCUirv77sApohIvAXD5oNcBT8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXF7407AfQv0LoW+S2QvXqUPyh1/IlVqi3l0Yo6GwgM+Fv35tPILx7cSNQdYcwjWJK46kOoLxVOWLulaXSGqTWc3KwZ++KrC0g98fcvKQDEFxs98V0CWFTsBgaiy5iuxf4KJi58wtYNG+Qh/ksf8GMmZVcopjKKRln1KAPR0BQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=c0AkrhCj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-227b828de00so17412875ad.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 16:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745538138; x=1746142938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dp1JH+xjOPb4muQwzvuvY4BQz8toAnVChrFllJxOrbE=;
        b=c0AkrhCjIZw6PbffhNg/VXe/IMTVefw6F55TCGq21UmLEEToLWsFGJhTu12kCPmx/Y
         vCuly/kj9ti5nlCJSzJYfyIQe41hrTP09XimW/X4NJaXPM1y376tyDxZjMIMG+YLR/1p
         8KK2j/2UOad1ywod8wJg7So1NXGGBljbmpkFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745538138; x=1746142938;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dp1JH+xjOPb4muQwzvuvY4BQz8toAnVChrFllJxOrbE=;
        b=KnWzwPGo9vJUNam3Hh9FBEbDiRQI6CbDGMpwEHrcHmKE/Es66pDxzn7xlSFKEDuSiX
         zmSwyJAugZkqVxnbD8a7YqdJadvKf+VouptAHleajZ7HsBdko5EjP9uOqYv3tgc6rFl2
         /Egp/shJIs8yUPrjQu7BM2alyN7OACoGDFSIuujzjNg/op2r3GsVCj47AESTfjKcX69p
         h11jtWRC/y+raf6Tsc/O93IR5T1Foz2EfGs0EHIk8bm8CyEh6kbAZdLGZl4+NSao14lJ
         SynyS6hZdLGVZob4+VRQDroegp0TeSdWSj/QI4ESabO0ZWt0TtXv2fz4ofocoqevbT3m
         8ulA==
X-Forwarded-Encrypted: i=1; AJvYcCUidBgrj5MlaEa4cvHGAgvIiE/vqTbcvdKp0h04ELzH04JU0Tw/ZRKmDZ6ETm1ZsY+q65tTo8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Q4sybQjj03xjpkbBYwM+PYUCtN987vWfo4tHF4bFFxPgyx0C
	dfx3zxuIs5M65XEp4ZMgDtqJV8fqVZzVDEExgT/XEkgkTOzvJcfC+BnLNl5r6Ig=
X-Gm-Gg: ASbGnctIs+vxXSeOW0chS9Hf980jxAFbQvjlVZhZOztctbXaNBl/iKWlBGs73uJbSMO
	IMJ+nQbDK7rhEMqpjBzU8kUxs1+S83p13USo11K8cZToFJRkYGBxPCKV5V5A8ndaLAFtl6SSVbf
	GpEq5PvNPhONNLZptrStIsLTqtsX1o6z0q53pymHf863hFP/F/QsIMSCcZXIz7Ky8e+arUmOqQw
	eNFFBKvl6zTdTwAt5CKWrxy86e9VYK1LMyO5ze7GVtowqolLBRNcdLHcrDnFcQ99fNWou1J04qC
	p1GbnaaY2UZUeyPSuHMvWZHW4tJhVarDk58cuXiOa5uX87Jr1QouP1m2/Vnv3hccqRnTri/CeLU
	iJsb/Kkk=
X-Google-Smtp-Source: AGHT+IFkZpwsMtUjkFrbFgKrJP+6SOsskFleUb8nrCe1BuFyzJZmZvaIkz5NdF3eBW0WNltJiJEx1g==
X-Received: by 2002:a17:903:2987:b0:223:f408:c3cf with SMTP id d9443c01a7336-22dbf5eaa52mr3167365ad.21.1745538138670;
        Thu, 24 Apr 2025 16:42:18 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52214fdsm19550855ad.251.2025.04.24.16.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 16:42:18 -0700 (PDT)
Date: Thu, 24 Apr 2025 16:42:15 -0700
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/4] Extend napi threaded polling to allow
 kthread based busy polling
Message-ID: <aArMV06U_dQgp832@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
References: <20250424200222.2602990-1-skhawaja@google.com>
 <20250424200222.2602990-4-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424200222.2602990-4-skhawaja@google.com>

On Thu, Apr 24, 2025 at 08:02:21PM +0000, Samiullah Khawaja wrote:
> Add a new state to napi state enum:

[...]
 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 2eda563307f9..c67a7424605e 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -427,6 +427,8 @@ enum {
>  	NAPI_STATE_THREADED,		/* The poll is performed inside its own thread*/
>  	NAPI_STATE_SCHED_THREADED,	/* Napi is currently scheduled in threaded mode */
>  	NAPI_STATE_HAS_NOTIFIER,	/* Napi has an IRQ notifier */
> +	NAPI_STATE_THREADED_BUSY_POLL,	/* The threaded napi poller will busy poll */
> +	NAPI_STATE_SCHED_THREADED_BUSY_POLL,  /* The threaded napi poller is busy polling */
>  };


Now that threaded has three states, doesn't the comment for struct
net_device need to be updated?

