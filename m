Return-Path: <netdev+bounces-238784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC2DC5F5C5
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 22:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0073A6C4B
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 21:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D653557ED;
	Fri, 14 Nov 2025 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XBRab1Gz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5A935505B
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763155630; cv=none; b=lNCfw2DGa3NhR3MFvh0f/1QpmXtE97fzkphS2AaOyl/VHvtYrk7GTa2BNsDHS4/pL/8J5sAhNi0gAIRspPSGnxRkvUZRMdPfZJdpnkdCUuuAaMjzWNmFR2aFL7y+2G4Gieb3aq429aBUlePFd3bwL+DGGdtvB5g0YD6irVZKVfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763155630; c=relaxed/simple;
	bh=QG4Es2w8z9zPw3criN/guc3OygUp38fxeJgv/o1q7ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQWRAkaS1bzv9gwpnuagIacm35zjPTwJazYMQAmAMpxQ9anzFauUUfzuB5tHARS1b+RWw4uy1lwzuuOgkPeT6v9vi7+69lXpsjqgDoJ5tMeeJFMSuEQyjbS7jNGMsmaEWvDdU5J+0RQFGExBwRaABU9gCd29Zm9Tb2Gfhr2OJIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XBRab1Gz; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8823e39c581so30555396d6.3
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 13:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763155626; x=1763760426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QG4Es2w8z9zPw3criN/guc3OygUp38fxeJgv/o1q7ZA=;
        b=XBRab1Gz2RfOIXR7tBrgmh3nGbWB9nD53agu2Ftb7dJ+E6ujGcekcqNz/WfGQcElR1
         JPoshaM3z33zraDvGJ+ACFiukA08zFTEaR0xfndM9gUSUHg9Zs5BQpPQmCn+rlRr5RoL
         +HbcMVTNFh9NUnQ8QYgXpxTd00G1onwclWFt+mTdURK3IQPhRknMwrisGKHWi/MsFWXy
         jA5NpNvuuFz+muixpaYsuX6DT0cS1CY3lOcwFFL0Rq74qeEvPO9xATprJVc6zzJKQAj7
         tPwVb5dyHeWDIbeDVck87WCY/yneLJlXgxVw6dyllbnhJfH75kBVX6IFj+p+Zg+TClod
         lucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763155626; x=1763760426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QG4Es2w8z9zPw3criN/guc3OygUp38fxeJgv/o1q7ZA=;
        b=ADWz5EfcG4uEAD4FT9Xp6nrFvtDepdRrXqeo+3gqL62K5KKgk5ob0bF2t1/+KQA+c8
         Eovu6dQu9wghqqofCPI/hX914bpbpmj1gY07mKRDIgyKKIKaP23FPwwgXbLBqI6z3fJ7
         s4/dA+sUmgRPjIghbDf4vBkrSKR+VoqtzoVvKyOftp+44NW8WACFseGlwjSvGeWo+Iva
         Ce2k0H9MWwtFm8GqiVd2Z1EcKOGNfm4seyYzZV/DcJ5cd6QpQNTz2zWA2S021Eugg5Gd
         uW/pkPHtiiwWrWN9Jd4gxYvU90spMTFH225U3ADbN1L+4z4LjlGDX13C9QPRpwG2I1nm
         Sz/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9kKbgIivqRhNOfvtDMqZU5xjtw6th7kgk5sXHCUj7MFi47yQoQiMfecC++A8EHMWRxKuUqGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlzdpCOYPyJLmpNrAmUVsD5Jdv7KVNvnf+/5pJXV9kZho4UpOn
	9uv0NdxqIHFrO7GZdooWKBvXbF1cJNBOX3LS1YvJVgyM9KXboukppo/Ki2wjnlnFW+AlVTP8bV9
	t/ZMJXBlMsqK0z0jGMDy1ebXayyKnJHVyETnq9psG
X-Gm-Gg: ASbGncuH9tGamhffUTosGMPDBs1Pz7qhSMLN+WDq3WJtHzluCk3U+RrCQDBuvi8eVhp
	urqOuXdysFgCEi9g48wQFyJKCGGpuaP+IIEvdIb+edBGcGLvHtXenPeo6H3PpRU8H6VGxywfjKl
	xSvnZia8Kf5818/Tuw25/YBzMG9NrDv7JW/C9N/gxfjQr3d5priPyokdaLNgUhR5fOsTmTQ+Sxa
	j8kQmhnWDhl0OkkP9Wwvm7E0idNU7+tnLDgNKKOjLpfLBKdHUEPrCcICrwdGJ90XUsD44yxbNdH
	wc5j
X-Google-Smtp-Source: AGHT+IF3yLklavyN8Pcb94PUlW9cqsca5TJcoW99dOtMjSKrJX8ajAa8K+KxtyAU6uN1Vxy/12p9PoNJt7YaZeBzonE=
X-Received: by 2002:a05:622a:11d2:b0:4ed:6601:f46 with SMTP id
 d75a77b69052e-4edf214c22bmr65252631cf.82.1763155626264; Fri, 14 Nov 2025
 13:27:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1763155003-21503-1-git-send-email-gargaditya@linux.microsoft.com> <1763155003-21503-2-git-send-email-gargaditya@linux.microsoft.com>
In-Reply-To: <1763155003-21503-2-git-send-email-gargaditya@linux.microsoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Nov 2025 13:26:55 -0800
X-Gm-Features: AWmQ_bkfwU3Z_aDo9USrVKl7Sexf58jA89bz0HEBOPCB70sLve8OaRqjFD38xwU
Message-ID: <CANn89iJotxTiQQwEJbtRbkAa0XYkuyv4z_La7WjYHQDvon-miw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/2] net: mana: Handle SKB if TX SGEs exceed
 hardware limit
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com, 
	kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com, 
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com, 
	dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com, leon@kernel.org, 
	mlevitsk@redhat.com, yury.norov@gmail.com, sbhatta@marvell.com, 
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	gargaditya@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 1:19=E2=80=AFPM Aditya Garg
<gargaditya@linux.microsoft.com> wrote:
>
> The MANA hardware supports a maximum of 30 scatter-gather entries (SGEs)
> per TX WQE. Exceeding this limit can cause TX failures.
> Add ndo_features_check() callback to validate SKB layout before
> transmission. For GSO SKBs that would exceed the hardware SGE limit, clea=
r
> NETIF_F_GSO_MASK to enforce software segmentation in the stack.
> Add a fallback in mana_start_xmit() to linearize non-GSO SKBs that still
> exceed the SGE limit.
>
> Also, Add ethtool counter for SKBs linearized
>
> Co-developed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

