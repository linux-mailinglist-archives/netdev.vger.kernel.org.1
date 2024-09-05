Return-Path: <netdev+bounces-125653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8821C96E1C3
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 20:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9831C211A9
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 18:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7A414F125;
	Thu,  5 Sep 2024 18:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q8FNV82l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8210113D638
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560348; cv=none; b=Qph2K+UA6qSy27wQi32XxPHK1aHRI7qWuVAKJNTGRiZpDy/TljVjqdeWYr6idc/NR4VnXTmHPNaRD9vjQp9cvU675fF/3hxZyEwsBbHPnIcvGkG51YhKw0Zt9BK77QcZ7ZuOUqJdgilNKaYdTWZ/qGhAYb6tVIn4wcaZE9SVszI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560348; c=relaxed/simple;
	bh=XOw529hsBUMpud4kcsmZqW+0StigjyYhsbCVz7UqkK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEPbsNU4vMSA+bb8UBESxljrvuRjyor0cMig8dGbZUot0UUxPVJwGxCC0PdeR/arBR19CVJ1j6NFed8tSsQZE7N1z2CQ5Rcxyt4Tdy3W0mLEbWOVpKAi38uLHQLF3AxcVWWKE2GebwqUyGbLo45Wlilg7tQf1Rlbut8aEnaUnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q8FNV82l; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c251ba0d1cso1282468a12.3
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 11:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725560345; x=1726165145; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XOw529hsBUMpud4kcsmZqW+0StigjyYhsbCVz7UqkK0=;
        b=q8FNV82lq9tlpWe4rwNE+iRlz7g/YBAmaI5AHyxsQeEFNKJFZ2IAhAlhKaFE/A0tN/
         y9iS5pj8fZPh1yvUsDDONdzY+6/UpvUKXHXdvEaXO9mm++6Wc0uwuZWZWD327pFEYhcP
         w/kIr9rmYnYJF2sxdVn6s4DvjMUnTxPLNfKNpTAozNxQCPL575gXET570XHIIlPhvlgu
         olh2Hd6ol/K93pZ+AvxOWmLs6MVXIqK0CFgtjSLAZiblq8ZHXtaiHTKx+SZwirpNkv8W
         76Tfy1w7RpNVx2XkRiczhkrr1OCKP76rRvMBpbPo+huMzBR6m/S9G8U8F8uA4pejqHRC
         m3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725560345; x=1726165145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOw529hsBUMpud4kcsmZqW+0StigjyYhsbCVz7UqkK0=;
        b=P6Hn1JFhfSMBZyHwtsXyQBAefgrtCu4fQi1sUZtOawCJI/S8P1KzrxZvP1qlbzN/X9
         TqqRxprr2dQh3j7GUAMdKVTAA2f8nVR8qkQbrc6bPNLFoLQDjw01cnxckmuAUi2Q6SEL
         Vea1blMaxxaGtCEGaRyarfK6rZRPeHmWc3UEJa0Eqyh1ub1h/IX7F2VCIHPDKpRztHyE
         zNwyMuZsoFqbb2azoLVmODd7n9Hcvyp2VH88h2fDEHHMttCFIiAdAqvAN4y140HTD/d0
         y06oQ8i0SZU6Q2D2ur2x4zXQ+eeezf0ivnAMke2q7PX8iTZnSWPdlXKLui6efbXI01Yn
         f6CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDdd2jBjVtMrImpCslweAomIcbWc7+YAQrmA8scR6bLxkDT5NnOqx0mpbWkIHknSNXV4gUwkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmVUKDNZ3c55bEeTLBOxnqc4c8eL0JPgkfw9E4G/bAMhsTqFJc
	YI6IbqePHY2FHcVkRHA7N2KjOd79571UtbH+anzgn5ju52siXBQB2fIjNH9x/EPJR0sQYZ2rNds
	Nr+PrT5bWgFYApcenDOyM64Bafa/VKhPyUkIl
X-Google-Smtp-Source: AGHT+IEc25brJGBIN7JpFBhe3rDjgIGmCksNCVV0c1D7/ijR8m5EXnAVCJqcxT8/TkRa5uWlSwKiXx0dxYAQjiSmSvg=
X-Received: by 2002:a17:907:9490:b0:a72:40b4:c845 with SMTP id
 a640c23a62f3a-a8a1d4c36b9mr912193266b.51.1725560343858; Thu, 05 Sep 2024
 11:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822200252.472298-1-wangfe@google.com> <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240831173934.GC4000@unreal> <ZtVs2KwxY8VkvoEr@gauss3.secunet.de>
 <20240902094452.GE4026@unreal> <CADsK2K9_MVnMp+_SQmjweUoX1Hpnyquc1nW+qh2DDVUqPpEw8w@mail.gmail.com>
 <20240903190418.GK4026@unreal> <CADsK2K-vMvX0UzWboPMstCoZuzGsFf2Y3mYpm4nNU4GAXDum3Q@mail.gmail.com>
 <20240905074928.GR4026@unreal>
In-Reply-To: <20240905074928.GR4026@unreal>
From: Feng Wang <wangfe@google.com>
Date: Thu, 5 Sep 2024 11:18:52 -0700
Message-ID: <CADsK2K8XoR-XEskjYby53i4JcHK+1joxtfM4P6Uinmy7B-KwhQ@mail.gmail.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
To: Leon Romanovsky <leon@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, 
	antony.antony@secunet.com
Content-Type: text/plain; charset="UTF-8"

Hi Leon,

I'm currently reading the mlx5e_xmit() function to understand the MLX5
datapath. I'm particularly interested in understanding how packet
offload mode functions.

Could you please clarify if CONFIG_MLX5_EN_IPSEC needs to be defined
when MLX5 employs packet offload mode? Additionally, are there any
specific flags associated with packet offload that I should be mindful
of?

Any guidance would be greatly appreciated.

Thanks, Feng

