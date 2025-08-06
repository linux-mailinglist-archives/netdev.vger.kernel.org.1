Return-Path: <netdev+bounces-211965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602AEB1CBFD
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 20:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20862625695
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 18:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1EC259C94;
	Wed,  6 Aug 2025 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rdurdvBJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3C31C7017
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754505343; cv=none; b=kVtBq5dD8ZLGAFKwxiouFnE8yBMd4aGlgieTo+klqLcrF69zxd4nx27i/vkdQ+RMmLTrxDJWCOUz07cKuFTON7+L3LyJuROlAQjeh1umKCeQ1RiFV/dKA0F7o8c6Hz96gTL9zcQTEaHRL6ENUwHsRcMHig/86qSQh0n3QcAZh10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754505343; c=relaxed/simple;
	bh=TgrtNHfEKGWMcivC2vYOauoxX+koVK4dQWOwxLY3/AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laGxdpu8bgf1tNWcN56E10tRH5nlHg09D7Eepbh0zpauYegZtMr3JwzP+qAUu012T1YsSFZsDXhxv+bCWX5o7XaBGOErKtMdyWA8c69x04S9OfBjpGq19OAsexgXw4BBSWgTho+hC1aR8mW0U/yffSkK7Ndyw/zSj7L+56d4+28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rdurdvBJ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b08a0b63c6so2618541cf.1
        for <netdev@vger.kernel.org>; Wed, 06 Aug 2025 11:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754505339; x=1755110139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLVfa7g9qj0LATfRre2vi5YmjjptK2nX35WVxF2JaUc=;
        b=rdurdvBJrNZ1aiLIokcUX9afav76fttZnMCBUj0LUYNu6u/JLevvfrVKIY/vQnjOuN
         nCvsMmtwIl47cK/04VWFdJbKFApzNz3O6CHmjGoyxn7WTDPyPxVq16aWqM3igyGT0HU8
         VDbcWNXWqJQbwSVHSwsFnlkDhD2PLmxfzcXZMfclyk6wkJT/JjAbD8KJBAUfT+7KLut3
         fZTNAfQlOyA3f9I5qcgYV2ERWR+CHndsaEk2TzldhR0nzEAlutowMIrEAf0naJBtzX9h
         msrBqcPUnvbLTW4ETnYS4HnpSMgVNKK0kfHdrWihwZ3Nr1sulHd36ip/RcYyIrIJcb8g
         z5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754505339; x=1755110139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLVfa7g9qj0LATfRre2vi5YmjjptK2nX35WVxF2JaUc=;
        b=CKpL6c28yP0a03TjMSFlm51FYApI/dAYKMdImREKOjFajxfCzOTpgPzWZ47bwFBLyy
         wVXsZHN7fejsJmFnpIHPID1CTah+OvYpwPxVWMyvvd62RzPQraTkQ/U4szdIt6bkYL7h
         mhS8tKAo0FHMSuIIpRB+Yj1cao0x2CD4dm5zROIMl7eyjOZuBGVd0M7GQFgGuVUdhbJB
         R+mjv9ZYyUCn75nLWfd4QOx/z3hWLnFMxcsqHpt3Lf0wYLeYRVbUe7wW9LjEzK9syrSG
         Gh0GFQOli20yLyCWAHOzzj7nipfrf/de3BOrWHpgcduWNZcZR5wXfAtH6MVkFT+D6+vi
         pTgw==
X-Forwarded-Encrypted: i=1; AJvYcCW/Mca0gKBiurv3T2LsNBZVZ/45dNKLmmXv+rpzS7iRViLabWM1LOt2EUrYffeQH69PnrePnFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvNqNjaUfgku8S3ikrj/bWvzFsVx9I/3nDy4ocKv4/TxY5nUwa
	yKzF5x3rFBIaQ4C0J7AfpMchR8Bb76JdO0K9FrznsREBZk0vzwNdwMyXB0p9fLK6AYxY1112Wch
	JISWNSrDbvpEvU06vowAAVcdD2Te2g4UUfIGRIE7AjtxxREYHSrF052mz
X-Gm-Gg: ASbGnct2g4zoSihAs+LWxh/FKSPWAM4zaDYYzHhdkq+1H4KdcOOuJy2+hYN2/CF0Byp
	OP2pyg1MERoogGNvgjyomM+IXzj9AEjR30ISnCGJsiP1gO4yDcxaS75onZq8ivB0VJOYm7vfZvc
	RlH9MqtfdlXWB3hK0P3YC2hUMCo7EUfLTjUFil6euKFcvVAQ1EZ1WoHo5nIiMgSit4VrXund3a4
	An0ceLzBCccWwowXIU=
X-Google-Smtp-Source: AGHT+IHG/34/fTyIPQKhgcLoz15W/sNxgHYlRwI6JCsBvkZ3p61Hn2tzr3UNF8Rq6YtI+vlJXPKClu4DHzWKlFqJzeQ=
X-Received: by 2002:a05:622a:1f0c:b0:4af:890f:ff8f with SMTP id
 d75a77b69052e-4b0912c42a5mr55715411cf.6.1754505339222; Wed, 06 Aug 2025
 11:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806180510.3656677-1-kuba@kernel.org>
In-Reply-To: <20250806180510.3656677-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Aug 2025 11:35:28 -0700
X-Gm-Features: Ac12FXxwAXt8ppz1WbG4syp66E9ompnViGt1pcP_8fwDRQaf3WP7T-rL0g2vo7I
Message-ID: <CANn89iKvW8jSrktWVd6g4m8qycp32-M=gFxwZRJ3LZi1h2Q80Q@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tls: handle data disappearing from under the TLS ULP
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, borisp@nvidia.com, 
	john.fastabend@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	sd@queasysnail.net, will@willsroot.io, savy@syst3mfailure.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 11:05=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> TLS expects that it owns the receive queue of the TCP socket.
> This cannot be guaranteed in case the reader of the TCP socket
> entered before the TLS ULP was installed, or uses some non-standard
> read API (eg. zerocopy ones). Make sure that the TCP sequence
> numbers match between ->data_ready and ->recvmsg, otherwise
> don't trust the work that ->data_ready has done.
>
> Signed-off-by: William Liu <will@willsroot.io>
> Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>

I presume you meant Reported-by tags ?

> Link: https://lore.kernel.org/tFjq_kf7sWIG3A7CrCg_egb8CVsT_gsmHAK0_wxDPJX=
fIzxFAMxqmLwp3MlU5EHiet0AwwJldaaFdgyHpeIUCS-3m3llsmRzp9xIOBR4lAI=3D@syst3mf=
ailure.io
> Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/net/tls.h  |  1 +
>  net/tls/tls.h      |  2 +-
>  net/tls/tls_strp.c | 17 ++++++++++++++---
>  net/tls/tls_sw.c   |  3 ++-
>  4 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/tls.h b/include/net/tls.h
> index 857340338b69..37344a39e4c9 100644
> --- a/include/net/tls.h
> +++ b/include/net/tls.h
> @@ -117,6 +117,7 @@ struct tls_strparser {
>         bool msg_ready;
>
>         struct strp_msg stm;
> +       u32 copied_seq;

Can a 2^32 wrap occur eventually ?

