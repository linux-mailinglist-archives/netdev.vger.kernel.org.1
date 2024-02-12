Return-Path: <netdev+bounces-70904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B2E850FCF
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 10:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC95282054
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 09:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426E917988;
	Mon, 12 Feb 2024 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJLTUuoF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907BF17BA2
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707730515; cv=none; b=R8bzxZCXaMfN26GLfhmUXDJTFhwmXsOC2C64oPlwji5yWHas0akqimJ4hML2VqUhgrOBd4Kunh4kqpUGBjefCG6AfeARNIxW9nB6f8n0ow0tmjNng+EMZRkVY1O5YBVtRz4SShuDfyapvwxdgteYoiB+hkftGDogi4QBPEJHWdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707730515; c=relaxed/simple;
	bh=zMsYBJdefRbRS1oJBVQytEShuramaVpb8rAhJF8Xwa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQlvb+J593qabEI/p2WG7Wu2ray4D091XgzOodoT6Z7rP5w4e0aaStIp1OdX/RZZZTgjwQwJOGn2Q2P/m3/6FJ3yXfMdF205OwItM6USzIMyUHemtk5ouLjY9mHLv25Cvr4VWlEVC+Qu7wI0+wXNQ18S4Y+6AvPlYuumIh6rsF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mJLTUuoF; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56154f4c9c8so17070a12.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 01:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707730512; x=1708335312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49Pfy019p7jCH4WHQFV/itn58Ta0gVCaehKec6pDwNU=;
        b=mJLTUuoFzFamWsk/OIv5xNNF9FJFD6dI78VyIkt6paschq7Ubu4I7NCfhITL7qCols
         KyNe8e6taVJYrYFiF29wvesYYdQfvkLXoMB2afLO+t84e21bOHV/qmZeXtWxCmLm1Qg7
         HoApmJQzMAj/vCRGIWYx9zXv8WyC9C8ZqBTy4OHsEqWLENtquEG05clbxkXf1aQifk2T
         3+/ZK1Qi50pR5zJPbYCCHb1oFdwSgsbVF+qQOOhTjjw8xeZqhaihTbifovPNqEuvhYBL
         s5FLfjgwAmVBqmEf2qfn8JPCQEZ/dASPGipoaQWs4uJ+Yn2F7YN9yjXI65+Y3cS9anx+
         aMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707730512; x=1708335312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49Pfy019p7jCH4WHQFV/itn58Ta0gVCaehKec6pDwNU=;
        b=M6JM71Gnt9PNBvuZNTs6SxhcQB8lZqWU9arQaWOQv8Ah8ELcZelFtlxVBV2pDcTzFB
         gIRFKUvSGJx9SVGiO9aa2VuOvIi8KScBI1Af9SG+OX+anU9FlNzTC0UyffL6DjWaCmHC
         o7TMpHZog5iy1DgW4/7AjtYVMMryLreUmePzNDsmGuunfw8mEFGrV3lKiuyjih2T6pmh
         MRGpJdNkt53l1vMEg866a294mqHFAnhphPAidnjJ6c3Cy6p2ggIPeBxHSjFViz1xcguD
         2uGBTsoddGS+peFvvHddmKmJAZgwbIBjODDCOqNHrm8MS0Vlbx7tW+gXA8fvnSsGnSMC
         BKGA==
X-Gm-Message-State: AOJu0YxD8oThOA5KtjeC9f/fWBURQIG/h/QzyGsmPq8NGBGgi7YI67Tu
	pCh37mRQ8jJurprn6BLTRVfH+J7gLupPJc1POnsYdMly0S54bIYZkzpjbJ/6359/VxukkOiv02I
	J1k4ADfZ66LzHeX0s/s+h7X6Jxg0RG8ft/zvU
X-Google-Smtp-Source: AGHT+IE90DP2qYdtoREl/pW8hB5dGkqsSq19HY3bQagXr/qZHS6Eb8/aPBg38eBJHnzPK77uufxVPlon7RmZfubM88I=
X-Received: by 2002:a50:8a93:0:b0:55f:8851:d03b with SMTP id
 j19-20020a508a93000000b0055f8851d03bmr183753edj.5.1707730510754; Mon, 12 Feb
 2024 01:35:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210125054.71391-1-remi@remlab.net>
In-Reply-To: <20240210125054.71391-1-remi@remlab.net>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 12 Feb 2024 10:34:57 +0100
Message-ID: <CANn89i+4SHqf7NCX4uyr0gCJZKSzcmxAGTCwqwrfRPBnMvd1Pw@mail.gmail.com>
Subject: Re: [PATCH 1/2] phonet: take correct lock to peek at the RX queue
To: =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi@remlab.net>
Cc: courmisch@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 1:50=E2=80=AFPM R=C3=A9mi Denis-Courmont <remi@reml=
ab.net> wrote:
>
> From: R=C3=A9mi Denis-Courmont <courmisch@gmail.com>
>
> Reported-by: Luosili <rootlab@huawei.com>
> Signed-off-by: R=C3=A9mi Denis-Courmont <courmisch@gmail.com>
> ---
>  net/phonet/datagram.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Fixes: 107d0d9b8d9a ("Phonet: Phonet datagram transport protocol")
Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

