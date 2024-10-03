Return-Path: <netdev+bounces-131492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 548B098EA49
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0051F2186D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 07:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A10839F4;
	Thu,  3 Oct 2024 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CfWzDwJz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D4884A27
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727940140; cv=none; b=QAB3IT8dC9njvNs8CBodFE28pw4a3L16P4hkw52HNBaYw0xADKIQRZgnG9NZMJQwKKdL5INKgSlhvl6FNnFCnow6btXFZTmmdxYm3sluF2Led6ZjFJKsC+gJCheAhyIinqpFBwX2CEe7n8gI/FKVSyxVLUYXTJEoPn4IvPrh3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727940140; c=relaxed/simple;
	bh=A/EUnslAKnF/Ep4p/Ul6iciHS5TXqGb8C/QBNT1mKsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXgy7KWkEHNweXbYmi74XPpbsndL2eFOCBRBCvFCkNzj1+WQjw+lOBWtSYdyMGHkmKt90Gid6ZTyWz1O5p3TPx9gxNo0fCGjiS1Gmmwm9XeCpoRZchtGuL5HtwoYONrdhRTLm10a1HY2KWV0Y5c1iQfMqi21hLNWfsMN0ltaS3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CfWzDwJz; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-45b4e638a9aso147071cf.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 00:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727940138; x=1728544938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KltriT3AVCkVToN/WleRT3kuM4+VzH/hkBZmS4RPNdM=;
        b=CfWzDwJzSkxUigBtUWPDb2/oDoUxOMj2+Ha1QW2GvADJg66AoL1UrBh3Ue7/Kovv/2
         nhxeNegWLb34xJuuiJuU3/4XxXsM+JUY/mY2Iv2OoN2QusSy2JhCPFGG7ZrlsuOLO9km
         VoNFyZ7yFBMuof+0v/NMTWhdKEt+r3T/1gsCvJrDzTDS041wk9ycsbO9PkmqUnJViREe
         E/MJm7ssXT/icrZIXt0D+KLdM9mSqDUQk0WiecVkUdud9NtYXluOnKAzpyqAXrdhxdYh
         PXkXXYTLlwIwkxfWD/dpRbdG+qMvGvffeYnPysbuFQnBh7N3zsbPBxMwktXrzEIgCGAM
         TLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727940138; x=1728544938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KltriT3AVCkVToN/WleRT3kuM4+VzH/hkBZmS4RPNdM=;
        b=SmC02bkwuMJEOunsCSLViuJmVf56Dv53B+/YW+blslUVpGpA0x+CRrbabNY+a7RdNi
         lrPNNilMfwsJwAkQfkCB7H02TsajH8eeW4HmelZ094Lku2F/dq8tFWls6pq+YOn9SIrw
         YfKKGpiXJhcyoOzytWfIY/VwXtqaexUeSMA5UF3JevfG4GYb3WC/bGjsxq4bHPNrJPUa
         lN66/de+8MoTnO+nfh6YzRK+ga52NjVQ2wIlhuUrqnive/E9RoxUGG5Y3oXm6SxMtL61
         c+kjrP1gEktUBdDW0gBS9ZmfpJVK+LdDQWe2n5VI6Y3fIANvoBKZO7DkugISPLFChuk3
         zQIQ==
X-Gm-Message-State: AOJu0Yz2b3eI7wMri+PNZTBINDWPgBgxN5Cw881fG7t5MesKdmRiBnGj
	kpxbd5PE5s0UueRb+BmKLumzCHc+Ns3rU8EJXimIbZzPfwZSVBlkNPyDYgAiNnEllXf3pcu8Axi
	Ek+t9XTV2s/rdAVvSduBHc4laUsa9FxQa5OPi
X-Google-Smtp-Source: AGHT+IHMabnrC2JvooDoGNTwdP+mHoeNWq+lt6mNynaD61K3z0RMAMalHigLWFHrDjnSzr68eQLNyVKFUcEQb2kXUdg=
X-Received: by 2002:a05:622a:56c8:b0:458:1587:3b79 with SMTP id
 d75a77b69052e-45d8e2a441amr2360711cf.26.1727940137623; Thu, 03 Oct 2024
 00:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930171753.2572922-1-sdf@fomichev.me> <20240930171753.2572922-9-sdf@fomichev.me>
In-Reply-To: <20240930171753.2572922-9-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 3 Oct 2024 00:22:05 -0700
Message-ID: <CAHS8izMm8kibMU912thkhB9WC=z6SrkfqAkvXeW6Tj9UsGrQSg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 08/12] selftests: ncdevmem: Use YNL to enable
 TCP header split
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:18=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> In the next patch the hard-coded queue numbers are gonna be removed.
> So introduce some initial support for ethtool YNL and use
> it to enable header split.
>
> Also, tcp-data-split requires latest ethtool which is unlikely
> to be present in the distros right now.
>
> (ideally, we should not shell out to ethtool at all).
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/Makefile   |  2 +-
>  tools/testing/selftests/net/ncdevmem.c | 43 ++++++++++++++++++++++++--
>  2 files changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftes=
ts/net/Makefile
> index 649f1fe0dc46..9c970e96ed33 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -112,7 +112,7 @@ TEST_INCLUDES :=3D forwarding/lib.sh
>  include ../lib.mk
>
>  # YNL build
> -YNL_GENS :=3D netdev
> +YNL_GENS :=3D ethtool netdev
>  include ynl.mk
>
>  $(OUTPUT)/epoll_busy_poll: LDLIBS +=3D -lcap
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selft=
ests/net/ncdevmem.c
> index 48cbf057fde7..a1fa818c8229 100644
> --- a/tools/testing/selftests/net/ncdevmem.c
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -28,10 +28,12 @@
>  #include <linux/netlink.h>
>  #include <linux/genetlink.h>
>  #include <linux/netdev.h>
> +#include <linux/ethtool_netlink.h>
>  #include <time.h>
>  #include <net/if.h>
>
>  #include "netdev-user.h"
> +#include "ethtool-user.h"
>  #include <ynl.h>
>
>  #define PAGE_SHIFT 12
> @@ -217,8 +219,42 @@ static int reset_flow_steering(void)
>
>  static int configure_headersplit(bool on)
>  {
> -       return run_command("sudo ethtool -G %s tcp-data-split %s >&2", if=
name,
> -                          on ? "on" : "off");
> +       struct ethtool_rings_set_req *req;
> +       struct ynl_error yerr;
> +       struct ynl_sock *ys;
> +       int ret;
> +
> +       ys =3D ynl_sock_create(&ynl_ethtool_family, &yerr);
> +       if (!ys) {
> +               fprintf(stderr, "YNL: %s\n", yerr.msg);
> +               return -1;
> +       }
> +
> +       req =3D ethtool_rings_set_req_alloc();
> +       ethtool_rings_set_req_set_header_dev_index(req, ifindex);
> +       ethtool_rings_set_req_set_tcp_data_split(req, on ? 2 : 0);

I'm guessing 2 is explicit on? 1 being auto probably? A comment would
be nice, but that's just a nit.

> +       ret =3D ethtool_rings_set(ys, req);
> +       if (ret < 0)
> +               fprintf(stderr, "YNL failed: %s\n", ys->err.msg);

Don't you wanna return ret; here on error?

> +       ethtool_rings_set_req_free(req);
> +
> +       {
> +               struct ethtool_rings_get_req *req;
> +               struct ethtool_rings_get_rsp *rsp;
> +

I'm guessing you're creating a new scope to re-declare req/rsp? To be
honest it's a bit weird style I haven't seen anywhere else. I would
prefer get_req and get_rsp instead, but this is a nit.

> +               req =3D ethtool_rings_get_req_alloc();
> +               ethtool_rings_get_req_set_header_dev_index(req, ifindex);
> +               rsp =3D ethtool_rings_get(ys, req);
> +               ethtool_rings_get_req_free(req);
> +               if (rsp)
> +                       fprintf(stderr, "TCP header split: %d\n",
> +                               rsp->tcp_data_split);

I would prefer to cehck that rsp->tcp_data_split =3D=3D 2 for 'on' and =3D=
=3D
0 for 'off' instead of just printing and relying on the user to notice
the mismatch in the logs.

Consider addressing the feedback, but mostly nits/improvements that
can be done later, so:

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

