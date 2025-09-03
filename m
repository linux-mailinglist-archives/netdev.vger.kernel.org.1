Return-Path: <netdev+bounces-219534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBB7B41CE7
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764FA171E39
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BC22E6CAF;
	Wed,  3 Sep 2025 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3+xe0jS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC3D2DA774
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898332; cv=none; b=tll0N/BVC2cRzjcMEj72+cnUQbOGcYAuH8mPnkefSK5J+9yguya/zXwDiTDPXPWP0TaCmrmZgLtKY1S+jp+kzVUWaHEd71P2yXOBrgatvRsoAmDlcYOPjmElLOpLzRWNsjgn72h77400QLfRPO3RtyBxM5Pilpr/rIny2tPqM70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898332; c=relaxed/simple;
	bh=wQiM/5AZS8Rs9dKwc19dQHM6v3kDpVefyLPtNeG0C4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8CiWuHEusb2rL4cYFpFWwJU6bteVdTzNMQgWVI/ZXsnlPEJvqPVXspbLFbQrDg3U1DMerZ1LAS8bah9F+xUHDDuBsdSaQ0yxTqIarfTKxj5Be8471WDCQExutLiOgHnc9jde+Uiwiy1xKgYQb9QUBN5F1Aa9z5Vbl0w/Uya0vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r3+xe0jS; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b30d09da3aso57494061cf.3
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 04:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756898330; x=1757503130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g65usQiEADiywraoPq3aeiL0ohX+1gqW8ybEa5s0ySI=;
        b=r3+xe0jSXqKImdG+ozNYwt2xRHgya4iJQVrTQflJLEFK9lGpOp9Ui5y8S/xNzVi+Ix
         CEuFIVadKR989jjJG0P+Cmw+QPxSH0cM+H9PaeudDEiv3Lel3n8dPbN05gpiKBxJNjja
         8Eoyn3rA/C8hjwht46Osl/u6NARZUyDm0Egh4aDIZf9daV9aVvi6t6ytkz+BtXjcNIqL
         ZhkM1filUybaEPztEkybGcG65QvHRTaxAWIhvbG/5VRFgy4pSDHLnGBEN7OFj1ZDna+I
         y1r+jDBFGIefQ71/YBVk4jaay0/SkWgKvngNn2Fn+fPUZO9ineKbSDWrzBkcGVCWRQs4
         pZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756898330; x=1757503130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g65usQiEADiywraoPq3aeiL0ohX+1gqW8ybEa5s0ySI=;
        b=XVFHUhdFdtlsX+p9pkWEUzFsFcBuztLKO3zjndsFU9jwKuJ6Mh1mW0CffmFc98rgPQ
         beaZcpUuUMO8yIrQbyZu1rqfTgpvWPlSToHSbsJBbkaL+ZKsJmhNin/K8MyCdjxRoRCz
         tTbFXjk0btatbyW34YMhnA7pzvVKHsLSv5izK+rtDdy9XGycAiYl6ezqxefVgWv9zFpd
         /TEtS96tXlIWxjZX0UnCcAtOzvXPxxbkD/tIGD4KS7zekt5eXi9plonuyEcxBfzNLA7u
         f1M8ReOBcGgTnDQFw/i1TkOjrTS+dUBneeSyteD5mU8uPUB4NjHuEHPe8T0oj03qdt/3
         8pbw==
X-Forwarded-Encrypted: i=1; AJvYcCXqNJgNUoOPoo+bsiQGqFLdYdzxyMwMzVdl5AF1b4rpZ7UUQ2woZcyAF+ctqcNOadApvv4ob7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN9fRRAI/3PA6MYyEJBQxW13hisTM1fKPOQxCYCOBtdWP+XawZ
	vdyqaGEWN4+7dFoEPq82kPa+nOoQODJdCWciP7R7HAkbVSEew9Zcu2KA6xSQJ7xCQIw3brfLFaC
	aJJx9qJWDCt6OVtaOL7GT9oURMIgmmvZslMWkASUJGrvuQRqJV5pp80rE
X-Gm-Gg: ASbGncuvfDtp6iufM6WUv1+XZYajfzGquJ0aEP+SEHiE0bRwYPj/GASFyoY+Txi/ZUs
	ZexoR0OmMiqRaSrnC17kCAO+v8v2oiCW4FQwPxYOdkphcn9ta9hu9iqbCenMbqLvsv8Hw/GTBKG
	I/oC39vsHUYECOc0vXUQh1xRCCQ0YavAB9SJlAgln4WuL2MkstlsWTyTx5g9Pol4hUywVSJ3Jmx
	t8soY3qusZ3Xo1L+lm7KAlz
X-Google-Smtp-Source: AGHT+IG7T+o/X0aqJDtHlsUzsDC+Wkotc8u0nlkLWn9pGaI8xqUZoO6jGHO88KFm5axoLJRxpmQLqYaZHmrlg9EeFIk=
X-Received: by 2002:a05:622a:1a8b:b0:4b4:8ec7:2a34 with SMTP id
 d75a77b69052e-4b48ec72b50mr28090041cf.4.1756898329940; Wed, 03 Sep 2025
 04:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903100726.269839-1-dqfext@gmail.com>
In-Reply-To: <20250903100726.269839-1-dqfext@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Sep 2025 04:18:38 -0700
X-Gm-Features: Ac12FXwYWjMG9LIOcl_3Pd2ndTXw74bH4r6NAmReUG5ykZjRGoGz9MTaZaZZBGU
Message-ID: <CANn89iLKpJaF0VcWxqCUuouJw8mZ4Fjk_cc89yMmuZWCLx70-w@mail.gmail.com>
Subject: Re: [PATCH net] ppp: fix memory leak in pad_compress_skb
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Paul Mackerras <paulus@ozlabs.org>, 
	Matt Domsch <Matt_Domsch@dell.com>, Andrew Morton <akpm@osdl.org>, 
	Brice Goglin <Brice.Goglin@ens-lyon.org>, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 3:07=E2=80=AFAM Qingfang Deng <dqfext@gmail.com> wro=
te:
>
> If alloc_skb() fails in pad_compress_skb(), it returns NULL without
> releasing the old skb. The caller does:
>
>     skb =3D pad_compress_skb(ppp, skb);
>     if (!skb)
>         goto drop;
>
> drop:
>     kfree_skb(skb);
>
> When pad_compress_skb() returns NULL, the reference to the old skb is
> lost and kfree_skb(skb) ends up doing nothing, leading to a memory leak.
>
> Align pad_compress_skb() semantics with realloc(): only free the old
> skb if allocation and compression succeed.  At the call site, use the
> new_skb variable so the original skb is not lost when pad_compress_skb()
> fails.
>
> Fixes: b3f9b92a6ec1 ("[PPP]: add PPP MPPE encryption module")
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

