Return-Path: <netdev+bounces-127945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27F49772C1
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 22:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 276CCB23AF0
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAD41B4C21;
	Thu, 12 Sep 2024 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RyrDsSmr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9080D18BC19
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173298; cv=none; b=dEbb1+SckJ8iWgqFeYeiFDVi+Cc+ltuDpUDE6TZkadvXcST+fSaIsBnlu4oM7XYVUAGX2j9PRTgQRfu0x8cjgWA5qSU0E69XqaKcla5rT/xoRgh33xMhDDa+74a+k12P1j+QHIieYDyR6HxAGBKwHGF48Apy3n+qzsntDds8MDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173298; c=relaxed/simple;
	bh=6ssNlhg/JFl7SteLcLEJtupjCRQRjhSqECxKZ0vx9j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEH6Ub3MjHfvIPQbQTKDZ472GhWqE6dy1ixpGsaTEzDLJub96pRz07FphoVyNMasVULipEYFn/BL5LAR4U1YI1xCqatFimufmp1DHtN53/JGTrjcHdIZJirDq/GcRTnDfdyOqAYgR6pXfZkZXeZ8smkJ8L7sQqgQub3Q0fhYU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RyrDsSmr; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4582a5b495cso17171cf.1
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726173295; x=1726778095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PELiwfnDOC6zAiAB5SgZ/0zqhz7nxGQJtEXd3szGgs=;
        b=RyrDsSmr3crSYDbg77YDcuPh4+dZaaxsboqyFNrwjyJt1czkSWRmBNi9g1AVFxHRzW
         BKJZKPlmy3CXjnvxPKI0fRciTNS27Ce3OVsSSDWP7P8Eyy58RM5qCtdIDpDXECLod6Bi
         6F/fdG7rdJ4W40KB3GciIs5kqE06NnP4PnIRpk3bty1TT5yc3mvDuSiFzL78h73uo0qf
         NWuzjMxmdkxeLohj5gW/rj7RJ+GeUIoNoCFgHQaUzO6ivejJ7IE0bMf4RvQOOteJc4VR
         51JfbltAydrs9ESq1cGcOUPMtCO6aXWCaidheoMHGwSVkaQE//CxxhunoAcGVxkdiCgo
         V1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726173295; x=1726778095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PELiwfnDOC6zAiAB5SgZ/0zqhz7nxGQJtEXd3szGgs=;
        b=tchQ4kzGcAYhjk4pMZgW3r2+3lUbvNBWQAgZQHilBmLVIq+k+TvWSONzNTAWm+tc6p
         KF9baq2eynfDoQy3OnDwUIAdZzXMmBiNXI5JL3mCMmqAaS2sdIai+yGg384WNrb0akLM
         1rVdh5iq2v3gdohqPwwHGw8vbRXu0/WaUqssdqmONDqPrqUdD/dpPoghH+pxjbEEMNbT
         4bMXMQy8IBOt9qIPNHOMej1chziuwpMqw0qFONLGUhKhmzRvL/XyjEkWKEiCkvq+Ge0e
         OOVeWX1uXTODLEtcmgCPuwo+QwRWnp047Z26cmxiNZo1XD97aXk9y9pf1L/2GjgbeNaa
         H0vA==
X-Gm-Message-State: AOJu0YyeSscMMApGVHnAieyZnKzYKF+o4j8nDoewsJwqFCaH36nOebdX
	jwcfX/PhAMJ1vRYBgjzsYNRFtFshxTFGBsqquOaf1DLnEgOtqWSDwIQ2eEm1+YRK9uyXsCVhWjL
	4sBkZVsPFvMuUT+gjlTkB9/m4A028HKh/lH+h
X-Google-Smtp-Source: AGHT+IGwaLOqx/LUP8zBbk8daEyYzBtXDjGREXTKLxp6CdiaSrgFTXQw9P2wKIECokmcdxdfcoUtj0ZQTtdn2ARXR4w=
X-Received: by 2002:ac8:5845:0:b0:456:7ec0:39a9 with SMTP id
 d75a77b69052e-45864400565mr3916491cf.5.1726173295147; Thu, 12 Sep 2024
 13:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912171251.937743-1-sdf@fomichev.me> <20240912171251.937743-14-sdf@fomichev.me>
In-Reply-To: <20240912171251.937743-14-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Sep 2024 13:34:41 -0700
Message-ID: <CAHS8izPj0r_nARfwrhSz+wHqVDbQ8jqpezXrujfD-CXymRgaVQ@mail.gmail.com>
Subject: Re: [PATCH net-next 13/13] selftests: ncdevmem: Add automated test
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:13=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> Only RX side for now and small message to test the setup.
> In the future, we can extend it to TX side and to testing
> both sides with a couple of megs of data.
>
>   make \
>         -C tools/testing/selftests \
>         TARGETS=3D"drivers/net" \
>         install INSTALL_PATH=3D~/tmp/ksft
>
>   scp ~/tmp/ksft ${HOST}:
>   scp ~/tmp/ksft ${PEER}:
>
>   cfg+=3D"NETIF=3D${DEV}\n"
>   cfg+=3D"LOCAL_V6=3D${HOST_IP}\n"
>   cfg+=3D"REMOTE_V6=3D${PEER_IP}\n"
>   cfg+=3D"REMOTE_TYPE=3Dssh\n"
>   cfg+=3D"REMOTE_ARGS=3Droot@${PEER}\n"
>
>   echo -e "$cfg" | ssh root@${HOST} "cat > ksft/drivers/net/net.config"
>   ssh root@${HOST} "cd ksft && ./run_kselftest.sh -t drivers/net:devmem.p=
y"
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Thank you _very_ much. I had an action item to figure this out, and
awesome to see you beat me to it!

I'll take a deeper look and test and provide reviewed-by.


> ---
>  tools/testing/selftests/drivers/net/Makefile  |  1 +
>  tools/testing/selftests/drivers/net/devmem.py | 46 +++++++++++++++++++
>  2 files changed, 47 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/devmem.py
>
> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing=
/selftests/drivers/net/Makefile
> index bb8f7374942e..00da59970a76 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -5,6 +5,7 @@ TEST_INCLUDES :=3D $(wildcard lib/py/*.py) \
>                  ../../net/lib.sh \
>
>  TEST_PROGS :=3D \
> +       devmem.py \
>         netcons_basic.sh \
>         ping.py \
>         queues.py \
> diff --git a/tools/testing/selftests/drivers/net/devmem.py b/tools/testin=
g/selftests/drivers/net/devmem.py
> new file mode 100755
> index 000000000000..bbd32e0b0fe2
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/devmem.py
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
> +        probe_command =3D f"./ncdevmem -P -f {cfg.ifname} -s {cfg.v6} -p=
 {port}"
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
> +
> +    with bkg(listen_cmd) as nc:
> +        wait_port_listen(port)
> +        cmd(f"echo -e \"hello\\nworld\"| nc {cfg.v6} {port}", host=3Dcfg=
.remote, shell=3DTrue)
> +
> +    ksft_eq(nc.stdout.strip(), "hello\nworld")
> +
> +
> +def main() -> None:
> +    with NetDrvEpEnv(__file__) as cfg:
> +        ksft_run([check_rx],
> +                 args=3D(cfg, ))
> +    ksft_exit()
> +
> +
> +if __name__ =3D=3D "__main__":
> +    main()
> --
> 2.46.0
>


--
Thanks,
Mina

