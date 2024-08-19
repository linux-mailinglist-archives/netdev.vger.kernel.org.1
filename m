Return-Path: <netdev+bounces-119615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AAE956575
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8F51F21E7E
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 08:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893E215AAD6;
	Mon, 19 Aug 2024 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BtXdHtIt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED00157A67
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055774; cv=none; b=X2GXt+VbI+cLTpUUessb+D7qckM9xdVqHS3pOGpkFqzwYSDI/Uig3ac4KhOlPqasvRiIzaYvxeQlS63yUkA0DBBUAgCSpAiyqInlle5VmVTlTvyF2WzeikMDg4AgPpWsouw/lD2rELlgE85qZBrzZETq+ictrS4oMTRMHA/9ovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055774; c=relaxed/simple;
	bh=JAmf45XlYbijZ6QzNH8suYSO0Xa759mHLc4EAK6EGpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CG4iP3Zzzvf1JgwB8vCvgf6QRu7OKwcdN0qFfeBsgZzKsu+crQBk6ObM0Wg/y1L0tkx4GiFfUluTvjCmxx95Ul2MSxnZPPQQGq7y+lBvac71CDQHjeHHeU0kVuqNBPBFCcuw0bh17yZm8K1LMZls11HD3v0B+Yz7DqnE8PtLy9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BtXdHtIt; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso5111295e87.2
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 01:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724055771; x=1724660571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAmf45XlYbijZ6QzNH8suYSO0Xa759mHLc4EAK6EGpI=;
        b=BtXdHtItn9km8qaQT573wSLXmrlqlPs9sK5ikHQyKk2+UNqb5j3EkWUYbzz2gaCnrD
         mhTX5wLO/3tHlt8MMDHuJWdkpbnV9ZMzFo8Tz+lCK18p8nH9mNBZsX+GLJmVFkP0yfPp
         U+R4BmsIJLJSLX089zyraB68zFrZxEjk1uJwoMTKpUom+4EBbaKvlNFkbdDcqxJ3YWK5
         VlqQsQE8f5/7tTDXQhwcTOaDCqVsCQr5pgQ0V9oubj6+4ppdlCIZnYEi9gR69Qq7qoDW
         zC+3LJq/MXTh89aaMLX211rf/QsTVCVplxgxWGiDtTR3Uzy/qbYfLpZ+n4VHg5AEmlGg
         l7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724055771; x=1724660571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAmf45XlYbijZ6QzNH8suYSO0Xa759mHLc4EAK6EGpI=;
        b=hXs+aZLgVAaj4BiBgkZL3hOxR+oP+wjosxDmJcSPKTV0RTaZt3GJtEAz+Ez2DOAPI7
         bFLvFc6J0a8ScT9KCqyTPEQkgf1hYa9ksZM4kICWo78IIz3ubaR5y5qwsbkEDIfS1kLs
         2pYA6wCP+UFc3HfEYcTKGj/x0WtpqVYJlP/1YMx2Hc1JszJw8AxRlOAB1GE/V0wv5t5y
         wccN7g+BgeAWt0lFH5xyGfqx7XcbZ7CA2ZJ8AKEY7a6mQ1E0oRYHXurf8OFovhaDMqrj
         SIjr/JmSV6wEjw5EoDnFwS9Ly0rYu3aUjaLWcn0z0Q7wEQgVV0V981eJuYWMZPfjnQ6u
         kBUg==
X-Forwarded-Encrypted: i=1; AJvYcCVb0rkIQntO/GZaLCA44ua7F95Bv9rhRZvX/LTnQLr7+33yrS/0N2WabhwaeqQjQ9VuKznTRS2JPXS8dHFqnkvFdOL3jsk4
X-Gm-Message-State: AOJu0YwZxAS4CGr3vXeStpEbOXm8Hgmb0qaSom8K7b5/RMuveT2fxU6q
	tj2pcZBIxEb98DVE7kR9+UX3RTyKHkR81LFgOVPwjebtunhrik86v9VquMoa49ODpYJOqVoFx4L
	u6oRFkcltoMTmEpKcuGNAFwLpvzUqHNMyrHEj
X-Google-Smtp-Source: AGHT+IFg11ieEDaBztBm1e+NqXvm27tqIfEHLTKfshtN712hRSwFSG2UztJ69U45M77CzAXsOvZuwlW5ISly4lqmCy8=
X-Received: by 2002:a05:6512:10c2:b0:530:da95:b54c with SMTP id
 2adb3069b0e04-5331c6acec2mr7512129e87.23.1724055770215; Mon, 19 Aug 2024
 01:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817163400.2616134-1-mrzhang97@gmail.com> <20240817163400.2616134-3-mrzhang97@gmail.com>
In-Reply-To: <20240817163400.2616134-3-mrzhang97@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 10:22:39 +0200
Message-ID: <CANn89iKPnJzZA3NopjpVE_5wiJtxf6q2Run8G2S8Q4kvwPT-QA@mail.gmail.com>
Subject: Re: [PATCH net v4 2/3] tcp_cubic: fix to match Reno additive increment
To: Mingrui Zhang <mrzhang97@gmail.com>
Cc: davem@davemloft.net, ncardwell@google.com, netdev@vger.kernel.org, 
	Lisong Xu <xu@unl.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 6:35=E2=80=AFPM Mingrui Zhang <mrzhang97@gmail.com>=
 wrote:
>
> The original code follows RFC 8312 (obsoleted CUBIC RFC).
>
> The patched code follows RFC 9438 (new CUBIC RFC):

Please give the precise location in the RFC (4.3 Reno-Friendly Region)

> "Once _W_est_ has grown to reach the _cwnd_ at the time of most
> recently setting _ssthresh_ -- that is, _W_est_ >=3D _cwnd_prior_ --
> the sender SHOULD set =CE=B1__cubic_ to 1 to ensure that it can achieve
> the same congestion window increment rate as Reno, which uses AIMD
> (1,0.5)."
>
> Add new field 'cwnd_prior' in bictcp to hold cwnd before a loss event
>
> Fixes: 89b3d9aaf467 ("[TCP] cubic: precompute constants")

RFC 9438 is brand new, I think we should not backport this patch to
stable linux versions.

This would target net-next, unless there is clear evidence that it is
absolutely safe.

Note the existence of tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
and tools/testing/selftests/bpf/progs/bpf_cubic.c

If this patch was a fix, I presume we would need to fix these files ?

