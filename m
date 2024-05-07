Return-Path: <netdev+bounces-94240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A578BEB79
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 20:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EB3EB21F05
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F8016D326;
	Tue,  7 May 2024 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3asohX/a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6483316D319
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715106132; cv=none; b=usvkvV/eh0MfToB3eEcjRov6/TUUoJPeEcWLlOMidC9Mcfm5DdYOdwU5cld5Uohv/+7wH8Wrd3K84Z5oSTxOGC/m/4xelhfv9eC+jafuWMVhltLoL7u7rovf/9WDFcV9kP0f5iK7rrPf2az630t89awb3Wx48/89Ps9lZ/1DuNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715106132; c=relaxed/simple;
	bh=WGrDCpLhmXG0OzKkWQlmblE8Fu1o4nkE0xfNOfdBRP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOyJ4gSwMzCsR51lC1ofsRL46vhT6Nek/pbwLCjpHlpJSYADhO9VLkBQExNLKkylBI+5vmvz+N0RdXLADa0RNZxLlCfKbZTHD6oGqDJxwWsWSdp3MbJ1Zxjh8Dttm5LpvH5Rij9dkyKaG3Wi79TfiIByWe2sP0yr95iaYBjeYHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3asohX/a; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso1353a12.1
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 11:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715106130; x=1715710930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wLflVW04KtJjzrqEX38+Aa3dYvsqD/1sar1AfKslmU=;
        b=3asohX/a0thUx9BdUrMrwqOlVpupyx8q+uiV3ouw6117tGqRUyQ6DAxVAZUj2A/TaG
         cnlJdVpMn816RRAvIQIPe6dw4ASO0sD5lzzWIQ2rwmnLsDC1xVNNPgUgBtzHa7L3X8fo
         uxq4gJJe25yEAtOUgTeps5dBXC+bCk/SQtXnWGYuJkXSQS6GOogzIOr6zkdZLjuBE9/t
         780z+x6aMSoqqE6i4sB/e17biCnPlgFNH5Zx6AnRum9MvR8/HEaMUAJgmd9CV63Y4BRt
         AtyZxAKQi9hL4lrsFAmXVTbDUN8XmxqAs8jISldmI+wv1s5k22EYIMNa+4okIPbwYzOm
         ZYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715106130; x=1715710930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wLflVW04KtJjzrqEX38+Aa3dYvsqD/1sar1AfKslmU=;
        b=jAcNgXCXDx20SyGUfUTqLNtd3ikCsFGkN3B2QGhAtYDN4AtoXQlG1oKqbvV5szH/5E
         Eeqt3CX0NwoU9BlFMpVTo06tYZmPKbBWd41aPK6VZrVvz0Bgmiafkx7JUFMddpn3A37Q
         LFNptoao8L8nlOQdwdY8C9kv+JB5t3ZaxI4N3LIKYZnCTfZUUSnGaBQYHjmSmUVuKXlq
         DkfItbt4rp2CXFpOKvtDZYljl0Ws2X6yKWi5ojJAJglJ0RnHTID8IdL56hyXettzLkFN
         t2pj9T4lKEmqCNt7t/h+IpGtPrN0/xovO2MXI4TnLp+TJnLmqk+YMBL1+RsRQIInjuB6
         cdhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtOrRZwGeYZuU0TUV/QuVcdEZKbAkQgcjqsm+jNnaze3nL5NxPE9Zs1Tgeq8+Ivd1x9nk/psb1WIcinTHsATLVEn/dBZBR
X-Gm-Message-State: AOJu0YyT6OVXnFFfSb5jRjjxmBoCfma8C3MBXjzl3X4uRbukoCDr9Lu9
	im3unKxpafHI4qLvIT/lU6aa/GtqtUc/grphhlJ71MRAVlS7Q1ZkUN2IdX11V8nKEuuOZ3Y4OxV
	HslcBQsTW8FPi79m3p6QDCOd0cQfro1URDcan
X-Google-Smtp-Source: AGHT+IEAUzK+Q2fl59QehpxISiQK+7GwZsujcGUtEEc473hSQ+Nch2fZVwYDMTDd1EXoTB5TtIifc+BmsIe9TrH0kP4=
X-Received: by 2002:aa7:c988:0:b0:572:a23b:1d81 with SMTP id
 4fb4d7f45d1cf-5731ffc8a3amr12072a12.5.1715106129590; Tue, 07 May 2024
 11:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507123937.15364-1-aleksander.lobakin@intel.com>
In-Reply-To: <20240507123937.15364-1-aleksander.lobakin@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 May 2024 20:21:58 +0200
Message-ID: <CANn89iLANEp-tjkKSawPTmH8DxaSQZ_OoJaAYHjLPkmwGEJ6nw@mail.gmail.com>
Subject: Re: [PATCH net-next] netdevice: define and allocate &net_device _properly_
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Simon Horman <horms@kernel.org>, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, linux-hardening@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 2:40=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> In fact, this structure contains a flexible array at the end, but
> historically its size, alignment etc., is calculated manually.
> There are several instances of the structure embedded into other
> structures, but also there's ongoing effort to remove them and we
> could in the meantime declare &net_device properly.
> Declare the array explicitly, use struct_size() and store the array
> size inside the structure, so that __counted_by() can be applied.
> Don't use PTR_ALIGN(), as SLUB itself tries its best to ensure the
> allocated buffer is aligned to what the user expects.
> Also, change its alignment from %NETDEV_ALIGN to the cacheline size
> as per several suggestions on the netdev ML.
>
> bloat-o-meter for vmlinux:
>
> free_netdev                                  445     440      -5
> netdev_freemem                                24       -     -24
> alloc_netdev_mqs                            1481    1450     -31
>
> On x86_64 with several NICs of different vendors, I was never able to
> get a &net_device pointer not aligned to the cacheline size after the
> change.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---

...

> -       p =3D kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFA=
IL);
> -       if (!p)
> +       sizeof_priv =3D ALIGN(sizeof_priv, SMP_CACHE_BYTES);

If we have a __counted_by(priv_len), why do you ALIGN(sizeof_priv,
SMP_CACHE_BYTES) ?

If a driver pretends its private part is 4 bytes, we should get a
warning if 20 bytes are used instead.

You added two ____cacheline_aligned already in net_device already.

