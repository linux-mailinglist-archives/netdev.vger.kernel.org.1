Return-Path: <netdev+bounces-195238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63240ACEF68
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 14:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2723017191F
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 12:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FFB218821;
	Thu,  5 Jun 2025 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EC0aaG6z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7197A1D8A0A
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749127494; cv=none; b=salJbChbGv78cdkvZolSlwxrRVXzP2YOVx1ZcW9dI9am0IUEPSKzx3rgpVmckpM/+rB+gWaHSEmjTUbh+qo8Ac4aDH/I+ltNavfiRI3bx65eI+Wafz7/1k/0KcGe23pfWPjtmxtXZjAuQ6G1w4RJo7rq9YmABnPYGIr72Ol3DnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749127494; c=relaxed/simple;
	bh=1M6Ahw064n/3Pm/ml44MdAZPyTS+I3rtCo7RuL6Pkcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HS0sfWj2c5epQPEanmyqUQ2Pmj6z6EIoBhHis6AW20drKs351AD9KZUaCavlzZsniPHD8fTRtZazVAV2dGzajCkn6K1tp49qGpiAjpCDDuRPf7CnNBLlYmo26Lhu0+cXTBKHGZ8q3MB6oWkhe612LcawqQ5Vu61jYs5va7Xf9pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EC0aaG6z; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a43e277198so6317261cf.1
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 05:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749127491; x=1749732291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+ja4+M2xOWPi6Bygoxn28Zjqtj43MyDHO0fI4xSLYw=;
        b=EC0aaG6zkPKeKpYdPc1IhYcCFR55wssbG0Bq+Okoo0U7gpLGmQBPII47JJNI3Z4kzf
         mRRMBPp4SxK7fwKKa77kYDdjm+ASk4PWFTQXRBONmCA3p9HIpeFsKowQlb5jwJBlC5UH
         mF4ByMVw0eumJRAPnZ5zSHSzlzZXbgQStKH5w6+L0IynVKJjAwepPTBtc1t7wN6k2B8+
         3CDssqzOulTlgbMpGWFGY33lxx6gh+o82EwzvnuSIPeE1jXwCCTQIfAOrTeM8n8mcypY
         8DNwbpc2bhKK0kLiGDdVU+jJLAU01cLTAGT6t/DmWQiUTnrTTyLn+oubzbB1rZ/jqAPh
         aO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749127491; x=1749732291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+ja4+M2xOWPi6Bygoxn28Zjqtj43MyDHO0fI4xSLYw=;
        b=sC6/NNazaklrab1xZKAaz0y8kPXVdLYsFbmcpfpHg5WoBhXEMf0eCHVT1TgcL641nS
         7Qx97dm7pBaNXJ3YhDwoW9D2pVHVBIY4jwV+AyxfLuMnX2l0CceZAMXNNN9Jr9UvvgD5
         8cqPthzATyIbQvIrF5FJ5f4s84PfnfA0VZM8XkIeTndzBuZg0pjoZGtDmPgIdL4ZxmkU
         /aUH/YU6cyA27+cClEKabG7oCcKbpgMfxvZGpScadO1/1GDvUJRMfBDQ4FFw0HoWGMCk
         l47w6xU7JFYKipZGQITdSR26EOexi6QJyJ+P0vFLFMHb2pUkjwjXf79dpbPjV0+hB5W/
         trVg==
X-Forwarded-Encrypted: i=1; AJvYcCVxyXkEN2s7hwxA+j9BeDBt1jiu9PRvmJIHQGhv86+myFnxlnZVAepDBazwerh3QH7CUbr8POk=@vger.kernel.org
X-Gm-Message-State: AOJu0YymlcEnIe16xD7AgifflVSth4t0vpRPtGVW+uyfhMkX5lEVXWak
	Sso9r+50KEY+rDM7BtLHjhcT06dIdbu+z5MUhmeHe//5mJu6pXzsS5YUORiRSXROyXK6D2VyUU4
	s274/FqUCKsEd6/1gSV2e4XfaQOyXSsq0PXIzWEuc
X-Gm-Gg: ASbGncsY53PJHRWbXixmyXOPExjXb10ZQPy6TZdkgvGLVnx68RjxybcHnUXlj+/e0oT
	SkrhP8CDd9J3zUQrR46qzd+1sJWolSAcfCk4D2hXJDCJjiTNJfOe+DnPhAtT9rmdCXVUMOGDEgv
	K1IvYba6FHkZl1IXOSa19wi1nmnqft54WJ9nWnvFm0+8o=
X-Google-Smtp-Source: AGHT+IHqFrG2DFMtuDJWcNH3yBa3lwc6UQVRUn1VXB36hEb5kwOFTUcIAYFHWNVi3s25DT33VFaHpvlR/7SkQZ+Uh4s=
X-Received: by 2002:a05:622a:4d48:b0:49d:89bf:298f with SMTP id
 d75a77b69052e-4a5a5768e7fmr95088851cf.22.1749127490981; Thu, 05 Jun 2025
 05:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430085741.5108-1-aaptel@nvidia.com> <20250430085741.5108-2-aaptel@nvidia.com>
 <CANn89iLW86_BsB97jZw0joPwne_K79iiqwogCYFA7U9dZa3jhQ@mail.gmail.com>
 <2537c2gzk6x.fsf@nvidia.com> <CANn89iJa+fWdR4jUqeJyhgwHMa5ujZ96WR6jv6iVFUhOXC+jhA@mail.gmail.com>
 <2531psgzo2n.fsf@nvidia.com> <253y0u7y9cj.fsf@nvidia.com> <CANn89iJ6HROtg3m3z8Ac61e0Ex5HvgOTNavfG_W0j97B0XMZkw@mail.gmail.com>
 <253v7paxv1t.fsf@nvidia.com>
In-Reply-To: <253v7paxv1t.fsf@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Jun 2025 05:44:40 -0700
X-Gm-Features: AX0GCFuwcu_gh1VljBmLTBOpOh6i_LMFTvbsRpVwTihlPW3hlvD6yXK1BWR9a3E
Message-ID: <CANn89i+y4cKYezwQ6Zr0fr=d6ky8K20E9zYOz=EUiRi_vY8e_g@mail.gmail.com>
Subject: Re: [PATCH v28 01/20] net: Introduce direct data placement tcp offload
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org, sagi@grimberg.me, 
	hch@lst.de, kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, 
	davem@davemloft.net, kuba@kernel.org, Boris Pismenny <borisp@nvidia.com>, 
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com, 
	ogerlitz@nvidia.com, yorayz@nvidia.com, galshalom@nvidia.com, 
	mgurtovoy@nvidia.com, tariqt@nvidia.com, gus@collabora.com, pabeni@redhat.com, 
	dsahern@kernel.org, ast@kernel.org, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 4:55=E2=80=AFAM Aurelien Aptel <aaptel@nvidia.com> w=
rote:
>
> Eric Dumazet <edumazet@google.com> writes:
> > Adding one bit in all skbs for such a narrow case is not very convincin=
g to me.
> >
> > I would prefer a disable/enable bit in the receiving socket, or a
> > global static key.
>
> We can move the bit to the socket, within the sock_read_rx cacheline grou=
p:
>
>
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -420,7 +420,7 @@ struct sock {
>  #endif
>         u8                      sk_userlocks;
>         int                     sk_rcvbuf;
> -
> +       bool                    sk_no_condense;
>         struct sk_filter __rcu  *sk_filter;
>         union {
>                 struct socket_wq __rcu  *sk_wq;
>
>
> And then check for it in skb_condense().
> We are still evaluating it but it looks fine for us.
> Would that work for you?

This is a slow path check, you can use one bit after sk_no_check_rx,
because we have a hole there.

