Return-Path: <netdev+bounces-131496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385F798EA8A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3251C20A67
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 07:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5DD126BF2;
	Thu,  3 Oct 2024 07:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dPWb0BBR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6296F54BD4
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941161; cv=none; b=bqoFlCJdyEGtMtSiiLzY7/Jm0uVgFayh1G/0f/E9BiqGmz3Fv/0hh/bK9vDIShifsFSIvd0FhlW8/naz/CMY7ymLDTo1QVkFRVlOm4BwFV794A33YoRyYtRolveBJ3UMYp5YdvknNehbL07k+ZbXPt09AXSdCY4Wxto4b4dcctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941161; c=relaxed/simple;
	bh=AUB6Ug9EvXElzBVM8LPY44zrdJ1uiZhC8u2F3LRgB1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tI9JoELNJpwxk4zCJK2jT9Kt10j8+C3jn8FsaUMpLWwMbWYwh05BuocJE31SN4Of9RJOtf3ghEJ8ywdcOnF1jrfAEUkRiVC/60d3GJ/pnfgK+tk0oxI0MuHawfWKcsuFeumzVPtHqzyKEiPkPzMXSdw/nzq6mYDMeE2EY8MhmKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dPWb0BBR; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4582a5b495cso143931cf.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 00:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727941159; x=1728545959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDtNY5+3bdVdUPbgPru2+aTnoZge5FAIRAJYx9E9HEw=;
        b=dPWb0BBR+WTPA2leFF6mPplynuGydTQ/N5VwZ5VNOBRhGftSJsq84Iflv2zLQo2ydR
         QVOXn8Nmy0gGRqiwkiBurXkgJfVT1oD6SYM7UZ5A8Yy1wt+VGFyPb/AU3cA2l4zj88ss
         gNEzrjsExdM4Uin4UahoBs4rHDSk/y1p55l94RjFr7/TCWTCDXUuHnnJY5stkEVkAbCD
         Sbm2GMu+v0zriCkOKFvFhn1DRY2nntzbwp4KDibwLF4I/Gs8ieQ0R1lH3GL2MKSGdzfN
         2KSN7Cd4CJMk+4OFxy1owY2+IwzLj/rVf1XYzirocRRwVxS124knTKaSJdRoTI4GsdE8
         6Ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727941159; x=1728545959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDtNY5+3bdVdUPbgPru2+aTnoZge5FAIRAJYx9E9HEw=;
        b=q9ctyv0cm3xmTzV7oDQfi52B/TzzpwxAvcYD8sVKAGdas/qmxJCG0W41idu+nHoP6F
         +rj5qJn6YHfS2/00cdPMveN8dZVXo8+Th0ll3ZXZXYVAcH6QXBCHZ96iuLHEp5MfyDl+
         h4NRxBCwSC3fkNld6JJX9Tm/3aRpnyHyc4BH2+5x+q8JLoKUQsOtodFzgoVbb38SByYc
         WcNWcVdec4KD5wvR8t4shC9jSrd84KIYGrCEnHXxM1WDcKfZiE+LGIL/ibVo0C9DZ8J3
         evKFsywSDyGAtGD14FZxmBrgOiC6zdsKuvXnoH87xhXXoI/uQspd/lDQ40a/fQ9zrEtv
         +FAA==
X-Gm-Message-State: AOJu0YyKKf7JP7Ewa4oR/2l/+jQVD1y4oizoJL+prllyhKPuCXGcY75U
	b0QHxa+NLGxBVbHazz73uo4ZnzmyQ3nt1QpETZ7GSGUREhA6HGhW8glDCrdphNdW76GPRPGh1wO
	nWcCKyBZ2E6Ja2OQi17tyXdw8lpHvrC1wlali
X-Google-Smtp-Source: AGHT+IHUAnfrVGyfC+H7xb+pXeqTTyW6XgQTxjc912GMMZIA9L7dEq0NpkUIxHxixfu0YiuLb8+ngMdbaf6yd+zunys=
X-Received: by 2002:a05:622a:7393:b0:447:e847:486 with SMTP id
 d75a77b69052e-45d8f871401mr1576161cf.3.1727941158908; Thu, 03 Oct 2024
 00:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930171753.2572922-1-sdf@fomichev.me> <20240930171753.2572922-13-sdf@fomichev.me>
In-Reply-To: <20240930171753.2572922-13-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 3 Oct 2024 00:39:05 -0700
Message-ID: <CAHS8izMNHUkufZS_nMD7uTmzSfAqWYqfAiZiuH1OOVDw7WGhQA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 12/12] selftests: ncdevmem: Add automated test
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:18=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> Only RX side for now and small message to test the setup.
> In the future, we can extend it to TX side and to testing
> both sides with a couple of megs of data.
>

This is really awesome. Thank you.

>   make \
>         -C tools/testing/selftests \
>         TARGETS=3D"drivers/hw/net" \
>         install INSTALL_PATH=3D~/tmp/ksft
>
>   scp ~/tmp/ksft ${HOST}:
>   scp ~/tmp/ksft ${PEER}:
>
>   cfg+=3D"NETIF=3D${DEV}\n"
>   cfg+=3D"LOCAL_V6=3D${HOST_IP}\n"
>   cfg+=3D"REMOTE_V6=3D${PEER_IP}\n"

Not a review comment but noob question: does NIPA not support ipv4? Or
is ipv6 preferred here?

>   cfg+=3D"REMOTE_TYPE=3Dssh\n"
>   cfg+=3D"REMOTE_ARGS=3Droot@${PEER}\n"
>
>   echo -e "$cfg" | ssh root@${HOST} "cat > ksft/drivers/net/net.config"
>   ssh root@${HOST} "cd ksft && ./run_kselftest.sh -t drivers/net:devmem.p=
y"
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |  1 +
>  .../selftests/drivers/net/hw/devmem.py        | 46 +++++++++++++++++++
>  2 files changed, 47 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/devmem.py
>
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/test=
ing/selftests/drivers/net/hw/Makefile
> index 7bce46817953..a582b1bb3ae1 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -3,6 +3,7 @@
>  TEST_PROGS =3D \
>         csum.py \
>         devlink_port_split.py \
> +       devmem.py \
>         ethtool.sh \
>         ethtool_extended_state.sh \
>         ethtool_mm.sh \
> diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/tes=
ting/selftests/drivers/net/hw/devmem.py
> new file mode 100755
> index 000000000000..29085591616b
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> @@ -0,0 +1,46 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import errno
> +from lib.py import ksft_run, ksft_exit
> +from lib.py import ksft_eq, KsftSkipEx
> +from lib.py import NetDrvEpEnv
> +from lib.py import bkg, cmd, rand_port, wait_port_listen
> +from lib.py import ksft_disruptive
> +
> +
> +def require_devmem(cfg):
> +    if not hasattr(cfg, "_devmem_probed"):
> +        port =3D rand_port()
> +        probe_command =3D f"./ncdevmem -f {cfg.ifname}"
> +        cfg._devmem_supported =3D cmd(probe_command, fail=3DFalse, shell=
=3DTrue).ret =3D=3D 0
> +        cfg._devmem_probed =3D True
> +
> +    if not cfg._devmem_supported:
> +        raise KsftSkipEx("Test requires devmem support")
> +
> +
> +@ksft_disruptive
> +def check_rx(cfg) -> None:
> +    cfg.require_v6()
> +    require_devmem(cfg)
> +
> +    port =3D rand_port()
> +    listen_cmd =3D f"./ncdevmem -l -f {cfg.ifname} -s {cfg.v6} -p {port}=
"

So AFAICT adding validation to this test is simple. What you would do
is change the above line to:

listen_cmd =3D f"./ncdevmem -l -f {cfg.ifname} -s {cfg.v6} -p {port} -v 7"

then, below...

> +
> +    with bkg(listen_cmd) as nc:
> +        wait_port_listen(port)
> +        cmd(f"echo -e \"hello\\nworld\"| nc {cfg.v6} {port}", host=3Dcfg=
.remote, shell=3DTrue)
> +

...change this to the equivalent of 'yes $(echo -e
\\x01\\x02\\x03\\x04\\x05\\x06) | tr \\n \\0 | head -c 1G"

> +    ksft_eq(nc.stdout.strip(), "hello\nworld")
> +

...then remove this ksft_eq().

But this is just a suggestion, I think you were leaving this to future
work for me, which is fine.

Reviewed-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina

