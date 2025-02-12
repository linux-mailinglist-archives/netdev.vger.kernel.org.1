Return-Path: <netdev+bounces-165650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 959F3A32EFB
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098293A6414
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1647F260A40;
	Wed, 12 Feb 2025 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mojI/bFq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A9825EFA6
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386549; cv=none; b=hXZNxMa//nY8hVEbj38eSTYl9efuv1LMR1QXNg84Dxe20BgnS7PksxEMYj5f4H0IjE/hppRKc8A1oIftcOTmWG79u+yQAXPnu3qr2E8kVhbYfuhriZBCiextBKW+bWYPkMLsHKcBIL9bkEzcSkiMLQ0JN8O2Sr4AeHkKYA9YvD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386549; c=relaxed/simple;
	bh=CVMGdoYDL8T1fr+KrjJAoYlnGkxM8XNvTPZrejVoMJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R11pmYSgkeUdfF8Z5X0//Tp3KmR5QHlMApH51jM3rcBpImzNWlLaRbRWcpSExCOQnBh/ekwX/pWagM3fwPOkI5C0BFQbCoH+HBD9OxoyjJVsYR/LJpv5J3b4aYQPjJHIgWGlyLHEhXGox/XKp1u+fmHFIbOjsCNcm8g0LIK0ynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mojI/bFq; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5de64873d18so8215129a12.2
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 10:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739386545; x=1739991345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zx+Z2zXkUwVDnPf100xV5wq4Riv7VP7gTaMh3dudvK8=;
        b=mojI/bFq64VDLGVn4okoRdSh1uOirl93u3OgiJu2w/yPT9Sdo+70AwCom7n519LHPY
         Z0P5if1rCC++SzpOWaKjswutjKgD+ZZ0a98JuyVLC6DWC/3bo5RS18kg1U4eVCnasrh7
         R5faWFOj1U3gIzlVDMfAfOAnTy9piqC3MApX6ZfndQd8PuA71d/8i32ILePJ0R+Wnxzc
         Pe21mE1TPgKnFm9UNehLL94eCpZEAM3shNPdDTrhPvI4wnQ2ig61EsWOTz2kBWo5MCBl
         UtV8BT8DzIozU41MBcOv8hrklTQ2ooLuR3psH+d8oiFzAnsFhHXjU2Pew0GcolBViwEt
         lKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739386545; x=1739991345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zx+Z2zXkUwVDnPf100xV5wq4Riv7VP7gTaMh3dudvK8=;
        b=SN8AVfkZHy8YgG5givXoqqpOzGR3/c9P3lQ5g5F/tzljzGRajyQVInMpRcZIxE931o
         R0L+XxAFYpl0FSqUobjgzljdCBp1R6HDNSs1Ljq8GxvsA69pwKgD/JY+hQYQlRUIxOmC
         ug3gP8rSawz1pkqtwZ9KopvHh/IqBVAoDsp2slU/y8m60eKVgwj6LENPn45KpLweb4G0
         WMiQbaxTeaDN0EV3KhVA7IaAP6opSOHvNrBRMeFzZ4+zul25Cg5nkNRj+7C/2aGUZAgc
         f9P2TZn8JFoBdI04+CkotblNwENRXqJuoc7a2XyMHHPbJNx7TcLMHe7GdJvCuLv4bb+p
         n0xA==
X-Forwarded-Encrypted: i=1; AJvYcCWiIF2fFL/vAbCeASOCPcY6w01SWuEn10x1f0hNMqqC0CrScHoV6TsGQeOaZPCfxhpNWVPyqoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgJEXVQ31FDCNNRot8TZQWKdTpVWdLNLpI2pqTXhkhULRFZua8
	R5JnZNK3XX4rJx2VnMHXIslKF8NFxYj6YviG4kKKXesDGciKPCEt5YYn5gFNTxzz7Xk0SDjta+w
	zLjZ0xPlD+/iHyKHVf9wKrwhpX5i89zMmO3jT
X-Gm-Gg: ASbGnctxjbCyxbjvPm5EIL+LdXdGGSdygzBVTz/yx2YPsR3jPHaYz5VHqbbXqGeDplr
	9D2+R95a4POwTZROYhiC/4D+PSwtRdezyNHHd1jGLis/5zKMp1Cr9QEdrAEEn3/XQcicl9OIyDg
	==
X-Google-Smtp-Source: AGHT+IG55X34wS789mMJieuUREdopLjA3B44FyJjV3/cSlysBfK2oTbNjkWAOTqEn89wiamATCHt8vdoRDXvCYynFHo=
X-Received: by 2002:a05:6402:913:b0:5db:d9ac:b302 with SMTP id
 4fb4d7f45d1cf-5deca0122e2mr249031a12.32.1739386544998; Wed, 12 Feb 2025
 10:55:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212-netdevsim-v1-1-20ece94daae8@debian.org>
In-Reply-To: <20250212-netdevsim-v1-1-20ece94daae8@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Feb 2025 19:55:32 +0100
X-Gm-Features: AWEUYZleq88KnF_kE4nPNRYzraS7tQ5dHAAtHxK4ii3MnHWveDWf1gwFIVTqsms
Message-ID: <CANn89iKnqeDCrEsa4=vf1XV4N6+FUbfB8S6tXG6n8V+LKGfBEg@mail.gmail.com>
Subject: Re: [PATCH net] netdevsim: disable local BH when scheduling NAPI
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 7:34=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> The netdevsim driver was getting NOHZ tick-stop errors during packet
> transmission due to pending softirq work when calling napi_schedule().
>
> This is showing the following message when running netconsole selftest.
>
>         NOHZ tick-stop error: local softirq work is pending, handler #08!=
!!
>
> Add local_bh_disable()/enable() around the napi_schedule() call to
> prevent softirqs from being handled during this xmit.
>
> Cc: stable@vger.kernel.org
> Fixes: 3762ec05a9fb ("netdevsim: add NAPI support")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netdevsim/netdev.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index 42f247cbdceecbadf27f7090c030aa5bd240c18a..6aeb081b06da226ab91c49f53=
d08f465570877ae 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -87,7 +87,9 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb,=
 struct net_device *dev)
>         if (unlikely(nsim_forward_skb(peer_dev, skb, rq) =3D=3D NET_RX_DR=
OP))
>                 goto out_drop_cnt;
>
> +       local_bh_disable();
>         napi_schedule(&rq->napi);
> +       local_bh_enable();
>

I thought all ndo_start_xmit() were done under local_bh_disable()

Could you give more details ?

