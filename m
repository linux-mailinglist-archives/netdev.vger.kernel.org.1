Return-Path: <netdev+bounces-133902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F7F9976D1
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 22:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A138F285EF7
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC7B1E2305;
	Wed,  9 Oct 2024 20:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ziWFYfQ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31F61E22FE
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506657; cv=none; b=D8SBE5Tedu+51IZvS9XVdwmsNOTlXL373cV0X0yxAjwrJF2tduMrPS53w4hgAX8CLsHzAyyoWc6qMV8e1q2foFjZGuYCPF6IovSICVW5RwJnSBAfsFaHDQiBvTrHokNJn5vzc3mcWH0pbkSKv5lvmcljMxPrPZEPvEWlH2XSE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506657; c=relaxed/simple;
	bh=CC1QaoJvJfXxyruUwimxDIcCZokVHhQgEQtyaBgHVSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7RTvFMc2ZinnL8/ZiqV9GabN1JQMkiUfE2Zr6aNEWiZ+2hcVH6otPl+tWLGEA+pHKFAVN4D4Hw+sPXp8ICXgMVKx1omCEmqRJyPLH8AdnBUuoPOuDlY3oHOP+F7Q2TsxJcRTVuRpRVmWsgUonmCxql0IBZsxXn7E5fqCDcG6/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ziWFYfQ5; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4601a471aecso23701cf.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 13:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728506655; x=1729111455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDS/+3Ln6xiCo13VN3LxihYb6/aVhpzm3ZEFvxfUlI0=;
        b=ziWFYfQ5/g393ccNWqHguQV3DVoxGdzZkIFFnRIRw8ntASbtktvt0SZQq6zXEudTGX
         XWapR6oK6BzgP39dL6wNCBiXSvdApj+zStcLqu7LqASwPXn1JhfDsZGfynMuaeV9ZKxS
         FqUFkFVjeSn/cXCrcMf6uMLB8eYrT+agUTqblqfn7cMiKLA+Zqr/cRDQEaIcShLc3d4+
         7Dz2H+ES+77YU5V0Bs8nf5i+dFcf3p8og6BRnVsIHdUsEonI7E3KrECOFS6fZgrFldvH
         c0Yf6bDDyr7voSYW5xUV++hLOHp+dc/fMZUvO62Nww9oVgM7oZ7rms6hwV6miguqcpQx
         UjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728506655; x=1729111455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDS/+3Ln6xiCo13VN3LxihYb6/aVhpzm3ZEFvxfUlI0=;
        b=iRw2lB6gbNAIWY81sCrsMrvmT7QxfvgMmnzQu93oayV+xqRVSV38p7ldZOy9P4WFIN
         E/n8LkrZzyKr05sfDXSu94/WQHak1qkdUQGiLBpoEAymOgE8CldeBPINKaK0flqfhsR5
         /+ZuBfpPZOPqRp1GtX+HTWmleBzMk7Y3t4RaLNAc9mdP99I+oL93T8MpJTCvu+iRysVl
         9FYuvwKVJq0fHxUXqzKVdzxhjLsPThXWm7IBcYZtM6Dnsufk1mWucKM2MXXO+Na2HMYx
         keu0KHBgFeI4RaCHQnlS/iJj8CGFD4sr6qjibLm4LwH5WSDOhiCaBraEpNeG09b2jplG
         DFRw==
X-Forwarded-Encrypted: i=1; AJvYcCURSUvCuR9rXhWj0QMArMt5P+kLXP8N3v26h1mTOix+vfU3AaQcGfgT+sI19d2cd7omU9fFBoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Jm4fpPfmv0TxYPrSvZMkP7CRbXlWe/ZkQvtRY0egbjtnqdPF
	uG1GaB04ik3AhXbbCGILyFTuHxQ69ctpJR0kdLgMa6Dvf4Q1NAar9oR1ojFN0f7mIefpIy0CkPi
	mLCFuImryHKgOGTT8xgmE7XRXT9W9A/Q5WCU/
X-Google-Smtp-Source: AGHT+IHhW+cyKcPoxCzR5miU45uR8b+WqBUbSiEPA1WlLpVtxG38bOk0n5iMS4oVKiLmS3hzXTKa2sTYtMK5fRemY+I=
X-Received: by 2002:a05:622a:8387:b0:45e:f057:3fd6 with SMTP id
 d75a77b69052e-460404743bamr974301cf.20.1728506654737; Wed, 09 Oct 2024
 13:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007221603.1703699-1-dw@davidwei.uk> <20241007221603.1703699-4-dw@davidwei.uk>
In-Reply-To: <20241007221603.1703699-4-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 9 Oct 2024 13:44:00 -0700
Message-ID: <CAHS8izMyOur0_SCrh8CJet2xeW8T39CC8b9K3hzfn5fh7hVB6Q@mail.gmail.com>
Subject: Re: [PATCH v1 03/15] net: generalise net_iov chunk owners
To: David Wei <dw@davidwei.uk>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 3:16=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> From: Pavel Begunkov <asml.silence@gmail.com>
>
> Currently net_iov stores a pointer to struct dmabuf_genpool_chunk_owner,
> which serves as a useful abstraction to share data and provide a
> context. However, it's too devmem specific, and we want to reuse it for
> other memory providers, and for that we need to decouple net_iov from
> devmem. Make net_iov to point to a new base structure called
> net_iov_area, which dmabuf_genpool_chunk_owner extends.


Similar feeling to Stan initially. I also thought you'd reuse
dmabuf_genpool_chunk_owner. Seems like you're doing that but also
renaming it to net_iov_area almost, which seems fine.

I guess, with this patch, there is no way to tell, given just a
net_iov whether it's dmabuf or something else, right? I wonder if
that's an issue. In my mind when an skb is in tcp_recvmsg() we need to
make sure it's a dmabuf net_iov specifically to call
tcp_recvmsg_dmabuf for example. I'll look deeper here.

...

>
>  static inline struct dmabuf_genpool_chunk_owner *
> -net_iov_owner(const struct net_iov *niov)
> +net_devmem_iov_to_chunk_owner(const struct net_iov *niov)
>  {
> -       return niov->owner;
> -}
> +       struct net_iov_area *owner =3D net_iov_owner(niov);
>
> -static inline unsigned int net_iov_idx(const struct net_iov *niov)
> -{
> -       return niov - net_iov_owner(niov)->niovs;
> +       return container_of(owner, struct dmabuf_genpool_chunk_owner, are=
a);

Couldn't this end up returning garbage if the net_iov is not actually
a dmabuf one? Is that handled somewhere in a later patch that I
missed?

--=20
Thanks,
Mina

