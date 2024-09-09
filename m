Return-Path: <netdev+bounces-126654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 734A8972242
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 21:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6C71F24662
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ABD1898F6;
	Mon,  9 Sep 2024 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UbYs3yU2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886031F942
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 19:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725908493; cv=none; b=M/8ROTBiHOdHD9iJ9PABhyh+FqlFsWKwf/kTqwK850f4PPnV79I78oeDNcnEe5WACEBMMhsZJxrJy/g49tQyaPropTVgc9gFdQqxxUrhL81zuEprtBUvML3+X+plUH8TRsHmSHwY4XnkKLMs8EOO1EiPIl4Yy1BHN3amIVLyl4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725908493; c=relaxed/simple;
	bh=2sHHLz89GL1ndmpov7dE118whI0/kJVLlp5+zGP50eU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmG8NyvY5+HOVJqrXtbEapbN/mQ7nG+nwUPYSQoHVHBn8oU4mllXMAZXRi0qfrBnXStEO0BcUOAOhx4jyhODgQir6G+8GS7xnuRmGpLKjY23jYNgkEakE4GgtXhn0yGtWzB9jNrUTZVQ8EjBaO7CqKSjxySo6KLiqxPRleFoY44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UbYs3yU2; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f75129b3a3so44443371fa.2
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 12:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725908490; x=1726513290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sHHLz89GL1ndmpov7dE118whI0/kJVLlp5+zGP50eU=;
        b=UbYs3yU2pRCLks0XwUzrIUlmzGeSDXvs5AJ0CBk/g2NUPy/tAXHzSQ1ZlaCLkQiqRI
         bh1eZ/uBXgLqp8vqex1W4ek5nV6dpSUEZIZgJtdvGBRmr8D3mh8Ugc5nucv/tm4hWmEV
         2+n6zkbrgET98wGI0Y7MEpY+1XOEum6nXCtk4nwFG4EsXDNcWNwNGmbgQ2EwpL4d9xGJ
         ijynXtgd3fy3HAb9qZ5RIlgdfbu79HYQJmOw+eY3OgnugUTJEMdNYlJhJGLDgfP4hXiD
         VppBjNWizJn6jkGq79aicQhAv9aBgBjriBUM6IYBpVnKTmGBEAz6uztpGe9rf1lhP2U6
         0vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725908490; x=1726513290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sHHLz89GL1ndmpov7dE118whI0/kJVLlp5+zGP50eU=;
        b=vLWxe2QvurVDMtanTzk2SDqcBxhUvHCdiGpRf3LTVegBrRhHNLBsQ2Iv3N043Nb/Du
         RV/0YST5CvKC/3F+vFZ6z5rDsUGB5JseEdvVaDhPFv/PRwcyFUh6OmVPG6oERMO8MmdX
         x++h0SxkUwQLGMCo79UDw8m+1j/QSZhLSiT9AUhCsQc6VRNZ9yTXal1K89bHiJttgKR9
         YKEguiR9THJ32JKFCH6HMy1uEeebjuvwbddcQZq6RIaXF1RxxZpZzDQLXaNX7b3w0EMc
         glSQOHnmLQtQksDrB7P55DgowBT7Dm+ciUgVnZ5fAS6lCmKvUulysbYTPCrapvbBE8Uf
         tBbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXsi6mLTc5yQ4DVxRf76e35cC2MjM71dT8L3abBWIMmICdXVzpZXdI6LU4lYLOtXcVkX6tDeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRKE1P7bGkZPhcHm5CdRgKUh9cjKdO2LaXP6pV7OGMtPKXACAH
	7NfMu6+kgcaADnd01tbj0jQ4ZT7ijJQyLqr661TKdVL5aYfubmInGTdlMa4JM7Z2jfs7WclroJU
	dJODcKaxREJufG8gLeV5VNhSyU6xe6Z3PTzcP
X-Google-Smtp-Source: AGHT+IHN/cNlyxbs1tjAjhwcXcsc8FVkGSNKPajqb0Nhz4L0BuhYYmVZuUT+H/C5Ies6YCrOJtX0R/h9oQdiAvaNGBg=
X-Received: by 2002:a05:6512:b1e:b0:535:3cdc:8763 with SMTP id
 2adb3069b0e04-536587a4249mr8630727e87.4.1725908488958; Mon, 09 Sep 2024
 12:01:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909184827.123071-1-aha310510@gmail.com>
In-Reply-To: <20240909184827.123071-1-aha310510@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Sep 2024 21:01:15 +0200
Message-ID: <CANn89iLmOgH6RdRc_XGhawM03UEOkUK3QB0wK_Ci_YBVNwhUHQ@mail.gmail.com>
Subject: Re: [PATCH net] net: prevent NULL pointer dereference in
 rt_fibinfo_free() and rt_fibinfo_free_cpus()
To: Jeongjun Park <aha310510@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, kafai@fb.com, weiwan@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 8:48=E2=80=AFPM Jeongjun Park <aha310510@gmail.com> =
wrote:
>
> rt_fibinfo_free() and rt_fibinfo_free_cpus() only check for rt and do not
> verify rt->dst and use it, which will result in NULL pointer dereference.
>
> Therefore, to prevent this, we need to add a check for rt->dst.
>
> Fixes: 0830106c5390 ("ipv4: take dst->__refcnt when caching dst in fib")
> Fixes: c5038a8327b9 ("ipv4: Cache routes in nexthop exception entries.")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---

As far as I can tell, your patch is a NOP, and these Fixes: tags seem
random to me.

Also, I am guessing this is based on a syzbot report ?

