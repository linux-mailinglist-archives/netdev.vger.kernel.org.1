Return-Path: <netdev+bounces-135074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3383199C1C2
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 09:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7C41C235F9
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 07:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7EE14A0B7;
	Mon, 14 Oct 2024 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LVeG1lyX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A678C145324
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891820; cv=none; b=uKSq/IFKz8AMkze/r/3x42Uv7Jklpx4BIpOPJ7cOAp7I2PjAloxCfadXQdMDAidrW2hrOSUj1PWQFnPXvBogD0ONON2REawG3mwQqltavWVlQkcYgzmE7NvhXr7f9uBn5UTadU2hQXZ4O6wsL4TlqoaAMf0DHTkOK2mVZOFpM8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891820; c=relaxed/simple;
	bh=+g4VLx1y4rTCco0Bfo9tUTjB1bWOGr7+O8v5/Po4yFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hi6XWxtY+x3xnTCBeYq+cwa1TQO1aPusYmNsC4ZPmTUemQIDVzWIm8IoZO3QbrPfvE9XiXp/xZwgzEOSNMvsTLgNsIOd5ry38TialkTxZ8p1V4U8u/fVK90KAg2h+ZzPbHGBuZcsXxHugErEkbPCOqVMtYrAIKZi/+wO/I0YAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LVeG1lyX; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a994ecf79e7so627737566b.0
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 00:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728891817; x=1729496617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+g4VLx1y4rTCco0Bfo9tUTjB1bWOGr7+O8v5/Po4yFI=;
        b=LVeG1lyXx7hnoLsKQMacLX15ir9sUiYTaPcupelSSfelKngBDLEmH2SQJBpOxHOKPw
         7AbFdBGhZhLzS5NZBKoMMAMjg9SF+2lVAd+oihKGW/dxuFAibJBYoVlvB5KtN2xxQRdM
         YTsUpbZ0YL6sLrTDOp2NdzLjLr+ddA0TlsGig2Ct1QFFJuylM/fWVVlMcgaKMsqGnhsE
         k6OAijEUPshfCXimhnGjxDYbBSICqkYGxsmIScqB0rhlOfrKKFJ1A++zxRkPPWst10R7
         heqzcV6DCxk2c7+kx9AjAtlXEr+JoUjRj78xP25OWtnjUvwKO7t4zLRMZjIpqU/ydEUk
         atxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728891817; x=1729496617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+g4VLx1y4rTCco0Bfo9tUTjB1bWOGr7+O8v5/Po4yFI=;
        b=BCHkEfuUGSQtVtNPZbAn4adaeR+mn6xptDYsWBWt0IIN7dQSeDDuoRt9/tjxPND9zY
         uzVgvjFqDifzjwG3aBKqjLApEEY+itA1apUemMa7p/8vit/RB83LifjlJcxcqA1QPArY
         gg9Mh35UWxNf58zqLG5w4XkxDXmpyA/UNkTjRBvAaKqZW9efQHxvDQnarx62SL2cNkIF
         v2ouW7nzZpr5Dn6TG2ew0TudtOxsaRGPCInlK9Bb1onYQ7HggmjFGWMARi+DZDmL1ESt
         zHeKb0jV2sG0EOpo2M8Exx5Tcnj3i+s7PCuy0MD14maT3buRhkXmm7w6Lzo81FbDNStc
         Hz+g==
X-Forwarded-Encrypted: i=1; AJvYcCUzJSrHZE7m0+yl2EYwkiPYbYFZyrX02dgEnbj9DyMPUHzIxKas8x32yNHWkIMPKIMZEeJWm8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQXcvoTnF8g7pNu1hs1mHlifkQilhrvM6zCtFU1olOdI7h0Jj3
	9tnMSuEzsujMXQFrixveYxTn/YREZ+lEsN2FasumcD62u56GAN3oJdoncdTqhexG4zP8omlbE0U
	jKxrVuUqkTZ9Om/Hcb/eDLrvSjABG995xB/MiQp2O3ni4gAD7yK7A
X-Google-Smtp-Source: AGHT+IHnZkjVP2r7pHiHbF6hr7YjrWQOYu5wNEGh0c/yJ2G4DoqhzAtXz/FASCdsr2WwE42Fq2111yQTmdPNnfSAldE=
X-Received: by 2002:a17:906:f581:b0:a99:f3ab:c58d with SMTP id
 a640c23a62f3a-a99f3abe8b7mr526573766b.16.1728891816887; Mon, 14 Oct 2024
 00:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013201704.49576-1-Julia.Lawall@inria.fr> <20241013201704.49576-5-Julia.Lawall@inria.fr>
In-Reply-To: <20241013201704.49576-5-Julia.Lawall@inria.fr>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Oct 2024 09:43:25 +0200
Message-ID: <CANn89i+EwGme3GEq9j8hPUqZ3+vCy3+73tTNM=1p=51eKPpPGA@mail.gmail.com>
Subject: Re: [PATCH 04/17] ipv6: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: "David S. Miller" <davem@davemloft.net>, kernel-janitors@vger.kernel.org, vbabka@suse.cz, 
	paulmck@kernel.org, David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 10:18=E2=80=AFPM Julia Lawall <Julia.Lawall@inria.f=
r> wrote:
>
> Since SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache=
_destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.
>
> The changes were made using Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Eric Dumazet <edumazet@google.com>

