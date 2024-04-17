Return-Path: <netdev+bounces-88650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA228A8048
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 12:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5408D1C20B1E
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 10:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3B313280F;
	Wed, 17 Apr 2024 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oUjva6mL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AAE2207A
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713348270; cv=none; b=mcaaOB5Eugj6vmyNyYl749yZULhiK4HZbdyTaNZQqCeXTiMXbMl78pzd7xXeKTyV2BIMfQ/y+szUiMMXFFBdyGePgV+1NiyYjgxFSlALOtOunlRqY+GNTdHCkWlUvDMbiIDBOXXz/EPH6P0n8knNIf0owX/+cmpQCIEUC1x2loU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713348270; c=relaxed/simple;
	bh=RUvN5g2OB2JxbRGj+DvyKnR8DiFGXY+HzDm3/ykFc84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqbPWD4QCUu3xkxpzdhDvsn5ApElF54Pb+SIcJcEUkf91eGlwYQIzUeG2VAZRh4wt46Nv5+qM+ZGBtDFKL20NQGWO5LNbOH6kGyAGmdbmq63YadmnO71SfZEgVWPkF95nnrtFgt8KBPIMnGn5H0URDhf6idURYziJ0ViqXnFv/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oUjva6mL; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56fd95160e5so7438a12.0
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 03:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713348264; x=1713953064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJuxh4cULuLrMccPUBsbNG2psG+vFcRJwZT3br2vnYc=;
        b=oUjva6mL1jsZfEV5hYk/JfHSGeg1Kg7xQsvz3kGGofkwtcYDOejzm4tS388P/OJtk/
         9+O8YY3aSs2+OCXn/nkUIAigg/ZAuC8oUWr9GEIN1MToiMk0d4sWG0T5qtFe6/P+Z+FK
         A50Imf+L0jJu6sxL9i7Dpe0thl+pQpuRfBggNP6NJZgFbqBMFWZUSXm4ux5IX4bWJyKT
         npg6jYn8oKEFw0OkZun9Bo8ZCoggWS6ShCTpshNX80q0whBsIz/5KmhOuW7Zb6fvNRzH
         g7JqBW3eBD3KdCzmeDyFuYBmWLSLJZJoOwfWARLigLFZxg8Fmu5zDTQbFB7MO8BMzi+N
         gygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713348264; x=1713953064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJuxh4cULuLrMccPUBsbNG2psG+vFcRJwZT3br2vnYc=;
        b=bVxr2DVZWdSeeBqpYJ4wuja/GfguGZ9i6fkSLwwXhEsuAzgjrqGRnQpqmdwk35TFSf
         yHuN56vOIlyWJ3FC+WgFG16WbnsjoLB30lGxd3tx+vPQ9y8MNeGQ4NUyM3NjTFx4Jki5
         naqH9p4seAfatUR8vS8/1UcdkBqbDap9upJi1DfrfKUXVQCe5s/WA/AczzO7xnKEuS4l
         MVHSs9bE09kju3WjYnecMGGbgAA3sH/Tf7U0cMImKdjweFaa9ucSuaLd5oGCEKuYOzdc
         gElQkDupyx4ONENy0mI/3Q/bp2alm/0W6nhUxMJLOrt+XgoeVEg4t0PMDhLFWJaYgMmd
         NFBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh0moVy9cOkeVfRV8bASDgLgF18jThqK7JlPFl2AeXFNTxff+nynKjziyy6OAMfhd+a1/RnxoemiCqI627BQ6bBwUl3bC+
X-Gm-Message-State: AOJu0YxYvENsrO+Lovc/c63GjdT5mQO1yVChk1Kd5ysFMLe/km7BGqGh
	VEJsHQ8OYk0ZFflzxCMbZvB8DK+ewAOVwxdJ79oBNchOjVT9guGyh9aRD3P/5zKsa+cZuesK+4W
	q3Z8aS/u+stFWBXXoqVIO5rO4fX472sr5zTexPJq7qPstqlVuasPo
X-Google-Smtp-Source: AGHT+IECLxTZE2t+acJ70b0boVY2rmrZKQhTjgzYZH+R3WHxjl2P7VwlL5UWiTRK8AQxCwV2xZC/L0rPNNpRZaAEUx8=
X-Received: by 2002:a50:c347:0:b0:570:5cb3:b98 with SMTP id
 q7-20020a50c347000000b005705cb30b98mr101174edb.4.1713348263838; Wed, 17 Apr
 2024 03:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417062721.45652-1-kerneljasonxing@gmail.com> <20240417062721.45652-3-kerneljasonxing@gmail.com>
In-Reply-To: <20240417062721.45652-3-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Apr 2024 12:04:12 +0200
Message-ID: <CANn89iLKxuBcriFNjtAS8DuhyLq2MPzGdvZxzijzhYdKM+Cw6w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net: rps: protect filter locklessly
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 8:27=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> As we can see, rflow->filter can be written/read concurrently, so
> lockless access is needed.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> I'm not very sure if the READ_ONCE in set_rps_cpu() is useful. I
> scaned/checked the codes and found no lock can prevent multiple
> threads from calling set_rps_cpu() and handling the same flow
> simultaneously. The same question still exists in patch [3/3].
> ---
>  net/core/dev.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 2003b9a61e40..40a535158e45 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4524,8 +4524,8 @@ set_rps_cpu(struct net_device *dev, struct sk_buff =
*skb,
>                         goto out;
>                 old_rflow =3D rflow;
>                 rflow =3D &flow_table->flows[flow_id];
> -               rflow->filter =3D rc;
> -               if (old_rflow->filter =3D=3D rflow->filter)
> +               WRITE_ONCE(rflow->filter, rc);
> +               if (old_rflow->filter =3D=3D READ_ONCE(rflow->filter))

You missed the obvious opportunity to use

               if (old_rflow->filter =3D=3D  rc)

Here your code is going to force the compiler to read the memory right
after a prior write, adding a stall on some arches.

>                         old_rflow->filter =3D RPS_NO_FILTER;
>         out:
>  #endif
> @@ -4666,7 +4666,7 @@ bool rps_may_expire_flow(struct net_device *dev, u1=
6 rxq_index,
>         if (flow_table && flow_id <=3D flow_table->mask) {
>                 rflow =3D &flow_table->flows[flow_id];
>                 cpu =3D READ_ONCE(rflow->cpu);
> -               if (rflow->filter =3D=3D filter_id && cpu < nr_cpu_ids &&
> +               if (READ_ONCE(rflow->filter) =3D=3D filter_id && cpu < nr=
_cpu_ids &&
>                     ((int)(READ_ONCE(per_cpu(softnet_data, cpu).input_que=
ue_head) -
>                            READ_ONCE(rflow->last_qtail)) <
>                      (int)(10 * flow_table->mask)))
> --
> 2.37.3
>

