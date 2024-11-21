Return-Path: <netdev+bounces-146697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286D89D50E6
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 17:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A5A1F22A60
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 16:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9139B1AB51B;
	Thu, 21 Nov 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VrZr9KeO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFE619307D
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732207635; cv=none; b=Rb1v6yyu1iaJk5XWme+b9KNsV6OOngfgIk9kU6Faprs1Fvt5wG5rPsL2LJpXRUYny9ar1RbxCgO+lYLn2ztTh7hwNymBJa0l/P18+OZuXgcC0jrK5P/7khqXNY5kq74S/uAru/m85bXAQrwR0NvZYXXZC99F33rBkEiLBjQIWNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732207635; c=relaxed/simple;
	bh=FSh0bBGhrrOK1CDRhKYaX1tSXVKd4tobZNfOnwPsJoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuMckzUTvce69f8oyZJSOilZciZnTmw+0aF+rb06vMCNQVlINQNdmbHKTh6zfDtqe9H8DuLMs6PI7OQ64a3UO8xSF5OuQ+tzri3XqY1rpz25+M9ENaZ6t575zBZaeN78NQAStEsX6WMBU+2C/yIvMqLydbmiTDTU+/XWZZmUua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VrZr9KeO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-211fefc2bc2so1051615ad.2
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 08:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1732207632; x=1732812432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSh0bBGhrrOK1CDRhKYaX1tSXVKd4tobZNfOnwPsJoU=;
        b=VrZr9KeOIDxwQ9W/Qn2wi+7GBwWOo4ITII91IWLS2T5qe52f1NKRo49PYsEEXDxNXT
         St7TKElWxxRGmDWpISzhVlUfd5wf7lA8FFOJuF4L9W+o3wEnl+gk2A3PerZxG3oQ10YI
         qqLLUk56lju7Oc3RZdz8oujd1H5nw44pRtVpE/4Qkr+xNagC24aTl369SvcufkQCeJWl
         U62TKPc7X194IDrSa32zJAnqt7WO4kL4qBZfW67fvPRoTswcxcMHBLdUR+lvx2gbK1gP
         cqO9YSp+FJrbL/Dlu5EZ0lcS6MqtkvTd9km2ryQ9rez5WTii/uGtOBsKmjFJlqtESsqS
         z5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732207632; x=1732812432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSh0bBGhrrOK1CDRhKYaX1tSXVKd4tobZNfOnwPsJoU=;
        b=fxkb1Pgg6bvrrXT+v2zW/FruZmNk2CJWGRr4+yl7QvOn/OfIRL2dD61LXiLkVoCtyg
         2nKnZvnnzGfQ5aaVQ5z2qggWVBw0bCz4MgONqP7a/Vzn8tnJBezymU2RS7Avo7qPrma9
         xd/WLxHLX2WcfPa11B6ipbzsL8oFHKuNoolXxk74A+Nxt90OIuJD0KGyxxjtx5XanPSa
         9imyqMDngkdVgFvDHP01eAD41cyhryMQ8Y9qcZ3gly8GfQNFnMRSE0OSkXRWK5sKLEf2
         hu3+gM9ZKYLzzwoYigikAJmXXAmr/6NmKtm71j9JRdPQI4ACiNQwCSGR4qyM25MeC5nY
         ipXA==
X-Forwarded-Encrypted: i=1; AJvYcCXrYzdXL9OxXAoZ7Vy9vcEgketMqBrKdSj/mRpu92KgcA2pL3sUmeKDXm/6Mbkx1cHK3gX+Rww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFv8LsKjMgg3njFV7hd6obaRWzu3mmNNKW+ak/ChTkgweRQr+G
	HMYOZi7D4Qd9Y+qO2y/bIkt7iZRxWIhTUSThQpT6iLz6kE2iI8WVBB2xvEXfbEHq6IbHJspyFei
	uTd/0K8wmBmMN2RVvsI8/iNyVA55SdEC7LCPJxA==
X-Gm-Gg: ASbGncuFG/jGSr6SZsO1C3Lpj9JknAFVt1qzz6nD4SPE8hFP3Ojf4Ij8xSmDmOCGpMu
	XjNz+KeBoBNh11fPDkI8WRmGtL3NdZQ==
X-Google-Smtp-Source: AGHT+IEk/9vx8VKZ9elTLl71i89UlCMkVZZvP2AUDPYQQ0TAnCaGg+99yW+OV5aFAZYoUZidMionD46GKKhdQsyomcI=
X-Received: by 2002:a17:903:41c4:b0:212:54c0:b523 with SMTP id
 d9443c01a7336-2126a3192cemr40875155ad.2.1732207631026; Thu, 21 Nov 2024
 08:47:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119042448.2473694-1-csander@purestorage.com> <59c96191-3203-4338-9754-ac7c5ee35e78@redhat.com>
In-Reply-To: <59c96191-3203-4338-9754-ac7c5ee35e78@redhat.com>
From: Caleb Sander <csander@purestorage.com>
Date: Thu, 21 Nov 2024 08:47:00 -0800
Message-ID: <CADUfDZpL6ap2gN1KeaxpTA53FPbx+EoLSWm+N-Q27gFd444VxQ@mail.gmail.com>
Subject: Re: [PATCH] mlx5/core: remove mlx5_core_cq.tasklet_ctx.priv field
To: Paolo Abeni <pabeni@redhat.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 12:15=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 11/19/24 05:24, Caleb Sander Mateos wrote:
> > The priv field in mlx5_core_cq's tasklet_ctx struct points to the
> > mlx5_eq_tasklet tasklet_ctx field of the CQ's mlx5_eq_comp. mlx5_core_c=
q
> > already stores a pointer to the EQ. Use this eq pointer to get a pointe=
r
> > to the tasklet_ctx with no additional pointer dereferences and no void =
*
> > casts. Remove the now unused priv field.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>
> [Under the assumption Tariq is still handling the mlx5 tree, and patches
> from 3rd party contributors are supposed to land directly into the
> net/net-next tree]
>
> @Caleb: please include the target tree ('net-next') into the subj
> prefix. More importantly:

Sorry, I realized I forgot to add a subject prefix after I had sent
out the patch. net-next is indeed what I intended.

>
> ## Form letter - net-next-closed
>
> The merge window for v6.13 has begun and net-next is closed for new
> drivers, features, code refactoring and optimizations. We are currently
> accepting bug fixes only.
>
> Please repost when net-next reopens after Dec 2nd.
>
> RFC patches sent for review only are welcome at any time.
>
> See:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#devel=
opment-cycle

Sure, there's no rush to get this in, it's just a small cleanup. I
will resend the patch when the branch opens again. Appreciate the
development cycle reference.

Thanks,
Caleb

