Return-Path: <netdev+bounces-73897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBA085F281
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 09:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 702ACB21692
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 08:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E43317BAB;
	Thu, 22 Feb 2024 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uib3iYj+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64307DDB0
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589491; cv=none; b=JcFT22WO8yTkNOMpZICcxwJa/hMZT+abfyqfUQRD4yLTf2sFMbepnlvqsiaZhRjgpilLf3cbrtaDn2kV/eu3lvheV2U0Re1UduUOiZ52mwkzclGBVaCZOj1DZxXbeVg+yS/A2hprNMV8Q95OGGpRpBGeZN+kfimzajJD5VyD02M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589491; c=relaxed/simple;
	bh=1VlaPf32ahaDltA4avThhp5Z/MVVC4FYJnAqSkAlYtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KheYX+mxuw4kLMiEdS/toy6KAjy14RZ6RTeRL+SOpV4Rcm32ypAZWWl/HIgHgd0TRSkdFG6XH8mVUBXIC3jV9Jd4RG3/kwMpNJClnbjkg0pJbkxVXGGapHNj43o7nUP4eUBKk6mdMJnomWfgIkeStpE96WeUw/7fq/GdqYd/huE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uib3iYj+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5650c27e352so6716a12.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 00:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708589489; x=1709194289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SoeetyccpRuL1Zxj2yBO8HRbCXcAY10EuDUckvu6UU=;
        b=Uib3iYj+g3QieLF+0ne6ZuPb13D35rVz0Uo1zYmtFLGSPt7CiJBO3YI0iJoSSpudvj
         nqwxpBS7DyMeX8LvRhdChMirrmpYp7d11Xnbw/Di/d5FR5ue9KaPAFMRmcA6/Dv+vSfH
         o13vPoI1xFyfxr+udl/eZP3H8nCLHaHaNiuydV7RZTpUK1CPes6sOoV0MW6sI4PpRfHy
         HXdUDCzYC6VmbPkbCebs1kunE94VLOFX2YZLx2b4aaCoyWcwikwPyKIDc/rZE8FmtwPK
         JjX7kIoIYZNylsq1nyuaiaHX7yExu8dgtwaePWxVVKB3sy7kT2SIzG/95THdUd76/kJ0
         00HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708589489; x=1709194289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SoeetyccpRuL1Zxj2yBO8HRbCXcAY10EuDUckvu6UU=;
        b=tpPaV6Ha+gyma1+an0kbcnNPrutbRJwvwyW+NwXqTxebSvRC3yqfE9UEf5gYYgB9ss
         3vzJnkoHtfbl9hOb9wLUT5rjy9ryX3NjT2R/ShezEHivrIFX1UotmZKLpLOardHoKOpl
         SuuOD4x9uavJ3O1poWRmlQhQ3bjc5LnUKaDYk+PCN7oPR+LHtMJbegr03drsurDS4m+q
         frrm/2py3JpejcxmlxrYnZNW4ZzJG6jkgKfK1uWiX2NKSM3EUm1NYa40N4T8I9rDvb1c
         R5a6Ze/NRR/6AuF5PKs0teWbsBehJUBuOBmk23k3NsXWsQ/B+2MNNa/StGOyhcsXcsDN
         hITQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwjZij0FC3z5RKxiBCjBdWcXyfdR3jtzGq5aqu/YpfvBX9CJRPTwIF1qBYzPLfUzt1idRXJNFz2wbwLr4WpvSqfYygGxnh
X-Gm-Message-State: AOJu0YznML1IsgFi1WWonJqsX3N/QWdDHkpYld/+Cga3Kgmk+bTFmS1S
	9T6jAF6FFbS70stZ/knKTPh/z/9e9SrKrvDnbTugWWGMYKn6+bzlavJE6otIt0G6fCYrDe6XmpQ
	oqjVxKIgEm87GlArcxB1wu2bW/enRuJG3nk4S
X-Google-Smtp-Source: AGHT+IHWECYeAa3fBiU6PZIpswovGBXlA2lsO96R2gnMxdIx9SKnrxM9Mg/e7pJ/HLnwoBLrYUR5z9mHVVDbUbFHGeo=
X-Received: by 2002:a50:8706:0:b0:563:adf3:f5f4 with SMTP id
 i6-20020a508706000000b00563adf3f5f4mr341023edb.1.1708589488411; Thu, 22 Feb
 2024 00:11:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000043b1310611e388aa@google.com> <20240222040046.2568269-1-lizhi.xu@windriver.com>
In-Reply-To: <20240222040046.2568269-1-lizhi.xu@windriver.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Feb 2024 09:11:14 +0100
Message-ID: <CANn89iKJ=-V7xS2PqpkwrqF=kg7FJdTqYgVEsnvR5hie24aqZg@mail.gmail.com>
Subject: Re: [PATCH net-next] net/mpls: fix WARNING in mpls_gso_segment
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com, davem@davemloft.net, 
	dsahern@kernel.org, fw@strlen.de, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 5:00=E2=80=AFAM Lizhi Xu <lizhi.xu@windriver.com> w=
rote:
>
> When the network header pointer is greater than the inner network header,=
 the
> difference between the two can cause mpls_hlen overflow.
>
> Reported-and-tested-by: syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail=
.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  net/mpls/mpls_gso.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/mpls/mpls_gso.c b/net/mpls/mpls_gso.c
> index 533d082f0701..2ab24b2fd90f 100644
> --- a/net/mpls/mpls_gso.c
> +++ b/net/mpls/mpls_gso.c
> @@ -25,11 +25,11 @@ static struct sk_buff *mpls_gso_segment(struct sk_buf=
f *skb,
>         netdev_features_t mpls_features;
>         u16 mac_len =3D skb->mac_len;
>         __be16 mpls_protocol;
> -       unsigned int mpls_hlen;
> +       int mpls_hlen;
>
>         skb_reset_network_header(skb);
>         mpls_hlen =3D skb_inner_network_header(skb) - skb_network_header(=
skb);
> -       if (unlikely(!mpls_hlen || mpls_hlen % MPLS_HLEN))
> +       if (unlikely(mpls_hlen <=3D 0 || mpls_hlen % MPLS_HLEN))
>                 goto out;
>         if (unlikely(!pskb_may_pull(skb, mpls_hlen)))
>                 goto out;
> --
> 2.43.0
>

I think Florian posted this patch, right ?

We must add a Fixes: tag

Also we should ask ourselves :
Why are we even looking at skb_inner_network_header(skb) if this was not se=
t ?

Lets not hide a real bug, we need to understand the root cause.

