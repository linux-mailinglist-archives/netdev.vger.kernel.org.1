Return-Path: <netdev+bounces-247728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E85DBCFDD23
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A59A3083634
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABDE3161BB;
	Wed,  7 Jan 2026 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7LlGH0S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08DC314D13
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767790759; cv=none; b=rIB4s/jPxpV1BngEWzJgfUultnl/Harc52PcY25sgdyIeID1SndeowVbwHSsIv9BidFEQQIfJZHFaO+hWstx8SIp93+x/14t0KFy3HVolti6GGU/mDtaXcKCnHfDYnzWtU2Y11ILpBFk0S+ZN46uxWFwzArLl3wq3qa2Loqd2mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767790759; c=relaxed/simple;
	bh=yVRQvTYqks6WbGzMXjQJfIjrDLN7t/f8i40RrbFnp5E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=O3TzCrEBVygPhLmZcAGBO2WBDkgpBkFNFF7XF9LhFPO0+QIzjRlmLUvgZ0s9d2ykPrt7ST/HTNMZ8YRmoYsM5xQCM/OrfAmADxOHLP0yf5N9immgWiaeewkWmQ1bYKnePlIhQy8l3B1lm1pmcaSV+bFEHEO6W0jUeEYovU/kAx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7LlGH0S; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-11bfa33cb7eso1797078c88.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 04:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767790756; x=1768395556; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c90q6NkDlao/1+SazP175P0A95xZu097+S3xFQ88J8k=;
        b=j7LlGH0Stx34iFsGShuJp5y2QTgVCiqKtqytfSCDwLD3K0/CmbH78JTONuQVQHLrft
         +6YxENsuMAVtrbFjYutiQY2k/+Rzy/1gseYiJt4kpHrm+86im1suoeTx+XjiYBErqfYH
         KplgodcEW52HX8eGb5z8gQxIJ4r6V7RDsAHgYGP5dj0HI7Ls4CvaTF9Diy3qURtsiVtQ
         /lr1ufpBRYb9L4AFW6FQj1dW9HrBMunXqC8GzJGRQtbeASETUmsr8Rg7dZQd4EJ7hOqh
         ys8m9qW0U4+ypnEHWNJdoFvcy9ECnl1tqPrAJ1+wAnuKS0EJ5OWKQRawI+I5ByigcAHU
         WtCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767790756; x=1768395556;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c90q6NkDlao/1+SazP175P0A95xZu097+S3xFQ88J8k=;
        b=dP37B087GHN1/XQustvQnIaPn8LJ6qBoaXPuHFU3il30SJqAMOmhBUoqo9itvZcxWm
         B1jEm0WGloWESXVU/zfBMF+r/XG6ycNAlbpRLq1uMANv8SEZBtiO94cnFs5acDcCChYl
         vBfOft+aymM2zGCM/qUtaqbMw7LSk2zAHQoazjK/8AKtsPb4q6B5B2/faMGdrAo/01OH
         cxTR2D7MwRCCcjgSv9EySe7jck/koRqhJghFFmpd0g39aNMdXsofDkGYv+7OMWHKS5xD
         e4bHfRgFuwQfg36IM63SvCckj3Gw6y6Tublu9SUsLXCO4JVuNKzICXMqfeyOjTsP5bWi
         fPCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuamOxEion5taoQfnosKWPqvfHDMvowho8Eff9/dz+g9Ulr8Xm9g6U+5/wk5XT+XqHf7Irtpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/GyJLMJz2lmpqO4IcwG95j38E+8mJct/r4jjk21ZxjIA5Ipy2
	5HHTasZEvxayStg6QyCWrNlXecrdWpTrtUkI0TD56piiOteEcnh6dFQV
X-Gm-Gg: AY/fxX6N2Hwzx68+kUIXr2yb//XKpetNIFMJT96ayw25liV2/lEebYGpRZPenKS4s0p
	wgW1ZtXusBV7IJv6GbOPcq/w9V/+007VzQNrDzq4FfUFWOjQVNRsEgc9iZR1Bw+KFIDDaoh5aDZ
	YI9u+HFiR5lrG/aRvb8HT3064Go1fHeeGQuNHuYlGhfeVtPyErerDTyUg7dvCTL+5pf2VM4BAzH
	MwW1jKYXlr1efW3WsENuSYTecWXGtikDuOhdHSZK3Oog7ucymfnreGKKwWdC+92ckcWnMbLnF5D
	YL11Gopgash3Z0bQV6vWPwDAYeAz2yxgwobBbdVWOJHWn2R5j6fNMmXWD4/0AP7192vhNA1IBIP
	0lu4xAJ7vC6ctvh9LAs1k4fXo8GNmll6wqB0qjdywT1uw8DsTA7aVE8VeQqfrooUvxuBpaCqIox
	0LX24MrCZaNYBszA==
X-Google-Smtp-Source: AGHT+IFyRoeDF8QLM4gvq4mXYpk3Y//U7k/g8364xasTSjDpFWrMntZUAZ1BhFLrd1yzMNyYI7sMdQ==
X-Received: by 2002:a05:7022:113:b0:119:e55a:9bff with SMTP id a92af1059eb24-121f8b7b229mr1585926c88.27.1767790755982;
        Wed, 07 Jan 2026 04:59:15 -0800 (PST)
Received: from smtpclient.apple ([38.207.158.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f23b798asm7651266c88.0.2026.01.07.04.59.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2026 04:59:15 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH bpf 2/2] bpf: Require ARG_PTR_TO_MEM with memory flag
From: Zesen Liu <ftyghome@gmail.com>
In-Reply-To: <20260107-helper_proto-v1-2-21fa523fccfd@gmail.com>
Date: Wed, 7 Jan 2026 20:58:58 +0800
Cc: bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 Shuran Liu <electronlsr@gmail.com>,
 Peili Gao <gplhust955@gmail.com>,
 Haoran Ni <haoran.ni.cs@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <774A6E90-11F3-4EEB-B6DD-210FD4CAB267@gmail.com>
References: <20260107-helper_proto-v1-0-21fa523fccfd@gmail.com>
 <20260107-helper_proto-v1-2-21fa523fccfd@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Daniel Xu <dxu@dxuuu.xyz>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

Hi,

It seems my mail server blocked the cover letter (0/2) of this patchset. =
Please ignore this thread, I will resend the complete series.
Sorry for the noise.

Thanks,
Zesen Liu

> On Jan 7, 2026, at 20:16, Zesen Liu <ftyghome@gmail.com> wrote:
>=20
> Add check to ensure that ARG_PTR_TO_MEM is used with either MEM_WRITE =
or
> MEM_RDONLY.
>=20
> Using ARG_PTR_TO_MEM alone without tags does not make sense because:
>=20
> - If the helper does not change the argument, missing MEM_RDONLY =
causes the
> verifier to incorrectly reject a read-only buffer.
> - If the helper does change the argument, missing MEM_WRITE causes the
> verifier to incorrectly assume the memory is unchanged, leading to =
errors
> in code optimization.
>=20
> Co-developed-by: Shuran Liu <electronlsr@gmail.com>
> Signed-off-by: Shuran Liu <electronlsr@gmail.com>
> Co-developed-by: Peili Gao <gplhust955@gmail.com>
> Signed-off-by: Peili Gao <gplhust955@gmail.com>
> Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Zesen Liu <ftyghome@gmail.com>
> ---
> kernel/bpf/verifier.c | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f0ca69f888fa..c7ebddb66385 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10349,10 +10349,27 @@ static bool check_btf_id_ok(const struct =
bpf_func_proto *fn)
> return true;
> }
>=20
> +static bool check_mem_arg_rw_flag_ok(const struct bpf_func_proto *fn)
> +{
> + int i;
> +
> + for (i =3D 0; i < ARRAY_SIZE(fn->arg_type); i++) {
> + enum bpf_arg_type arg_type =3D fn->arg_type[i];
> +
> + if (base_type(arg_type) !=3D ARG_PTR_TO_MEM)
> + continue;
> + if (!(arg_type & (MEM_WRITE | MEM_RDONLY)))
> + return false;
> + }
> +
> + return true;
> +}
> +
> static int check_func_proto(const struct bpf_func_proto *fn, int =
func_id)
> {
> return check_raw_mode_ok(fn) &&
>       check_arg_pair_ok(fn) &&
> +   check_mem_arg_rw_flag_ok(fn) &&
>       check_btf_id_ok(fn) ? 0 : -EINVAL;
> }
>=20
>=20
> --=20
> 2.43.0
>=20


