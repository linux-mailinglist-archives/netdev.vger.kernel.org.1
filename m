Return-Path: <netdev+bounces-224249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2C0B82E68
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 06:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7CB16BF84
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 04:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589102737FD;
	Thu, 18 Sep 2025 04:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yFYovsop"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE022727EB
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 04:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758170701; cv=none; b=UZLStiRT7QnUKN7oqw8jY2j/7KMnYFSIgiWU5CF/NoIu1uP9ied7CKRzGVBwPe4IcylS+lgRmAOVzFuRowBepv/1a+hQORuEz8HkNR5Ajnl+VFb02hIqwiVTe3dzolyWAknLBjnbsHvErTcsgZXPpCp7Ld53ZRdlDo52sfkfiq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758170701; c=relaxed/simple;
	bh=Q6nitg5sHD/9nuFDHOVOXhvd6zby9BM8Be8dvU5F32U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRcUz/rjXzBRUZnZAWlFJzy5Z9By4iG0mRo2FvPo/z8SGXGDiGxwC04QTS4oC37IGt7wDKWVswtZ+GxiL1z4WTKWxKYItBJ7UjY+EgEBFecZlUUF71gZTxZjPo41KR+IsRWSoIbT9r40YxKduVkaJGW8prqdO8Wrml79J0+h9QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yFYovsop; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b5f6ae99c3so6170581cf.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 21:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758170699; x=1758775499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6nitg5sHD/9nuFDHOVOXhvd6zby9BM8Be8dvU5F32U=;
        b=yFYovsopLKTqQOjGRyWzjaHzzeAgBMHpm5VGtgHRHY2GhRo4lIl1uLWpHoB3V3Nqca
         nbsMnqxa34e8MkikOnpk4vaAN3Eb26lf7zznkw5PnT/uufnSCsgSTevOIx6oKWip/fuZ
         mbHb8KeHZ1eqPoV3YqzD6+7eZk9PA0qyfAdvsF6425rVAwepyZZa/KnVRKDLGKSGtLFS
         NjP7IYSRyIGfPQGCboUgrPYe/AqDITu7OLHldzPWD7B2XEVD7FOlhxePttXFPOkkDvlx
         a2g2dRjCMAPM2Ls8eZ/EZZ24C9QS/ptquZlQa5KSpEmbkHHK7KG0utbFvHUuF7b3/r0W
         l1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758170699; x=1758775499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6nitg5sHD/9nuFDHOVOXhvd6zby9BM8Be8dvU5F32U=;
        b=JLEv61kLltazb04eHjT/WZZq7WPEuavZ+T3w/OgJdILU6NkImMsvbcW6srQvkNxv0c
         Fu+ZdONgFQUUQTD/46TqKp0yanwt/Tqd4+Z2EY0WXTdz1H72CaFWE36j9czBh0jr8NSv
         FHkZcGrLfNQ9w2XIolgPoj9BMDOrr59f0Tfjcw0ksGu0FB0jjGnsSFvJj7oufGYInhqM
         74zT/KRE7gl/erEfYds7GGeeriTozgyo7YnwqlCnSQ+OvbZY8Lo6iCoiYc5smV5kXS9j
         FnLaW9tSm7Pp1DGGuLd6HeUUp9hjnXzo0konavt7uMh/fh8u8iUXnslWLauCf4vcq2pr
         AjiA==
X-Forwarded-Encrypted: i=1; AJvYcCWBHMtT6+tH/dki3hkAsDkoz1Np75wJhPfeLlQKsnzj1wyfPcpYoBIZun5NjOb/yeVgkJS4sbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnzJlb40X2fIp8Fya/cAezYigZPZlMoge2RGvHj3ICkDkQcN5L
	GplZnMV9CmnViF9AXBhVSYN9kUa/dq9agQaCSdlwchDx0XaPwVdcywBHw89gjW6hAYicXTkRSkp
	N7QDY8GJqBwRzy0+hLGiiGKSO0MXjqN35VER98B0h
X-Gm-Gg: ASbGncu6yL55r7jz8G1+R8o29Pj4PerpXy9tcoOpxSN3atY7i0is5Jx5MHLQDfT+t/P
	/zS9kxQR/HTfl6SCyKxMS0ybu4LAphoU0l29PDC0d/B5Bf39uNua6/aIyvOSlErETHRkSvoDTac
	xsxWAyiBs71DIX6W8b948TfolndbVgcjWNJxoNbNgIqmAnwgZJsnrZntRNpDjv80g/pbaNUFyVL
	NqWyT9BnGe2TyroEV3KhOnjm3SkjXeJloaSSme/4ls=
X-Google-Smtp-Source: AGHT+IFUX25w3VEOK5Scs/p0FSSXhl/LMX4AZkwAetyD6+n6Wt5mX+SY89/ru119LLAAenOCwtoJYY6umY3e+EcyrxE=
X-Received: by 2002:a05:622a:110:b0:4b7:9abe:e1d6 with SMTP id
 d75a77b69052e-4ba68715070mr47534431cf.17.1758170698233; Wed, 17 Sep 2025
 21:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917000954.859376-1-daniel.zahka@gmail.com> <20250917000954.859376-18-daniel.zahka@gmail.com>
In-Reply-To: <20250917000954.859376-18-daniel.zahka@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 21:44:47 -0700
X-Gm-Features: AS18NWB5rSoWrg4ZTi9lZMLnQ-OF6U2QaR5v8szCmxeXJJ-mGH-VIgYKRBDR5yY
Message-ID: <CANn89iKGka5Y-RZ6DYjMjnSCNZK4vY9qkk5H8E6VUkAj-A3PtA@mail.gmail.com>
Subject: Re: [PATCH net-next v13 17/19] psp: provide decapsulation and receive
 helper for drivers
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Boris Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Patrisious Haddad <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>, 
	Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Kiran Kella <kiran.kella@broadcom.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 5:10=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
> From: Raed Salem <raeds@nvidia.com>
>
> Create psp_dev_rcv(), which drivers can call to psp decapsulate and attac=
h
> a psp_skb_ext to an skb.
>
> psp_dev_rcv() only supports what the PSP architecture specification
> refers to as "transport mode" packets, where the L3 header is either
> IPv6 or IPv4.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Raed Salem <raeds@nvidia.com>
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---

Remark : no mention of csum being not cared for in this helper.
Perhaps add a comment about this (drivers must set skb->ip_summed to

Same for LRO V2 packets (BIG TCP).
I presume mlx5 does not support this yet ?

Again, this can be done later.

Reviewed-by: Eric Dumazet <edumazet@google.com>

