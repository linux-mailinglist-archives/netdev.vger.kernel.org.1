Return-Path: <netdev+bounces-81113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F3A885F76
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 18:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F4B1F20FBF
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 17:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1036825742;
	Thu, 21 Mar 2024 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PTNoJZt3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EFA12B70
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041406; cv=none; b=Fx5I9QpETGuY9mzXNhHjif/DG8oAcej3PYLugPRun1mOufN9KKe5v5tnyYL/yWKZBdKhacoqKRmwnYP0YO+4V6w9wsHKTr8bRHm3rfQIUVwxDmrWI01qKHvjRXiCrLftFx2cJr0Tj9IBARXC3FhysJfgDt5KWKaxcjpW5r65DzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041406; c=relaxed/simple;
	bh=3H8yzEixLugThZ6gDV6NOhM7SOQCmh3MHyqTzVOJYUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYnDBJVegXJA7yVdAZi3HvNg3R51a9wIuog+KLd1LWCrK7xSqT+rHbDPtHChC7tsU65MFZVccfDPyJzSY9g+/5kqV1m83bxbnjcfKHPUtkUD0S2xQ2wOa9cK1XWPdC5NdBqEAMhwI0Q6x0jq4OUy38DCIWryTfjyay3IOArssKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PTNoJZt3; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56b98e59018so587a12.0
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 10:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711041401; x=1711646201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/JUieyU6p+t1fz5fZmjTRkLZEL/t4B8kEt2dsm3Nwg=;
        b=PTNoJZt3M0Op6tGm14WIOUt0Ht/Kqj8ffUHcAG6G9u6LMcxXJxKQveggd9qvOCIPQT
         TdI5ErU1NMyjmbCW19FpnL4QASXyO17caYCvfvlqv+VGcVKzgokaQwpW20NBW29cxmTG
         CaRG2awm2tf99dHu5FJnHvAu4DsRnkP1J9TJAiF2R3xXSEsaxQoP8HlltleiiRTRZj9r
         w3MJ3Nbn/oc9557nTWGIhhNpy3kPWpkRYGZCP2edKM8OR4nO+vSFJMJVLgBrYA/o9WkH
         tEiyJqbtrxCMw+4rUBUECMt8WHjMd7UXCNdqxSdIU+eNEOiwKgu4JqdTf1KRNQViLTsP
         fjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711041401; x=1711646201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/JUieyU6p+t1fz5fZmjTRkLZEL/t4B8kEt2dsm3Nwg=;
        b=g6tCxQ9E/ksjALftaLPTczqaPkPvkyYj5xuI6B6XMyJVZ/ofaekC5E7hcRExP5Ovqa
         taZVsrb5MHMBgddTfLXSksu7VIQEKeXL8F6AbI0CrQIOP7hLyPP6I+nqcgrx9WWYdtA5
         XAgn0ETF1/t/b7P9F+OHbjHWUKtOn//LjBM96cXWfk1E9SZ+dYzLW2OVw3zyc4mqsBhr
         2BAqRORaU39tuHgsp3Wn2nThjzyJ6K5qzysHOBRu3hiyabzC3Me+RLndceYlUkBB0plW
         XFRYMvw+QDBTIV8Fxdyu/WFZcekLF9C5GA+zTIaLbp6Ul7pIlzkTklEcyXYWlnH62SHA
         jIQw==
X-Forwarded-Encrypted: i=1; AJvYcCVIf9kk0P+3DXjWTjwws+cIHrvLbzB8AIIQocfJnDbxyJTSxxkWA5DGZuOA7vMk7zmkKI7FeEe/wPOdD5W+epNtzNMTcWx7
X-Gm-Message-State: AOJu0Yx12yUdhpTgbOHMRthAErryZf9Dtv55wRCjHy8/dHGyRPmAlaLo
	2A8YIjPyZXrOXzvQlN1lpDAhF+/WSt9UEFQOZQOQUrDaJZXCVIhXV/z+YEW/0Zhp6s2gtsro2X9
	OXqWS1jT6fzBtjrwvspxKhkdiSCAGMVWvFCjIO8okIaXAj2rFpQ==
X-Google-Smtp-Source: AGHT+IHCEzqZWBHQlpIXQyc9IfRalbHQaIraubeRBBm8PwEixQgIw3CxI4q9Xn0tMElGLlwQP8hM6kE6k5HXg8Ka+bI=
X-Received: by 2002:aa7:c6d7:0:b0:56b:bf41:c0a0 with SMTP id
 b23-20020aa7c6d7000000b0056bbf41c0a0mr222385eds.0.1711041401136; Thu, 21 Mar
 2024 10:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zfrmv4u0tVcYGS5n@nanopsycho> <20240321123446.7012-1-abelova@astralinux.ru>
In-Reply-To: <20240321123446.7012-1-abelova@astralinux.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Mar 2024 18:16:30 +0100
Message-ID: <CANn89iK1SO32Zggz5fh4J=NmrVW5RjkdbxJ+-ULP8ysmKXLGvg@mail.gmail.com>
Subject: Re: [PATCH v2] flow_dissector: prevent NULL pointer dereference in __skb_flow_dissect
To: Anastasia Belova <abelova@astralinux.ru>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 1:35=E2=80=AFPM Anastasia Belova <abelova@astralinu=
x.ru> wrote:
>
> skb is an optional parameter, so it may be NULL.
> Add check defore dereference in eth_hdr.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 690e36e726d0 ("net: Allow raw buffers to be passed into the flow d=
issector.")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  net/core/flow_dissector.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 272f09251343..68a8228ffae3 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -1139,6 +1139,8 @@ bool __skb_flow_dissect(const struct net *net,
>
>         if (dissector_uses_key(flow_dissector,
>                                FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> +               if (!skb)
> +                       goto out_bad;
>                 struct ethhdr *eth =3D eth_hdr(skb);
>                 struct flow_dissector_key_eth_addrs *key_eth_addrs;
>


I think you ignored my prior feedback.

In which case can we go to this point with skb =3D=3D NULL ?
How come nobody complained of crashes here ?

I think we need to know if adding code here is useful or not.

You have to understand that a patch like this might need days of work
from various teams in the world,
flooded by questionable CVE.

