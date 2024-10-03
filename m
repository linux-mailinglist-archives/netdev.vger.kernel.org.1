Return-Path: <netdev+bounces-131485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9F098E9EF
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 08:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECCE1C21D38
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 06:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC617FBC2;
	Thu,  3 Oct 2024 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CQnljsVo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BEA8F64
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 06:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938781; cv=none; b=rtLM//vQ9dNk1/5J2kQLqx7DO0WyCriggPcqKxiM2No9ijhxIsHyy1qOSxkpntpG9D3L5H6O34BU83mWKQehv2UF36ssoDzgiDzopUUTe/gxIfE6hd1ZDObxpxdimXxdTJF9GcGJ/x6pJ6upBOkq7IIL1dumjudfy3CpBTK6/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938781; c=relaxed/simple;
	bh=zQ1FIFKq8D+RXVIc8bi1fyu4wXv2lWOUoiUXchD4vG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6oq6PusnYBhS8pZ/xeKubsWPp1AP7kqv6ycCkysISVs442ucdYLkdXUoQDxizaxRKhRnqlX15eWYbFNXkqzfr2hZMCkUIYVpTmd29uHzpujfetIJtfabD40F0hlfEwBLF95YiwIPiGuXvI+zs4HFVSQ5EjmIsBhxy1Z9uIUKfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CQnljsVo; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4582fa01090so184481cf.0
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 23:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727938779; x=1728543579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NM4UKNqMrpKmu1TycMfUZPeK8tMRrFnZOJHBIPtUSAM=;
        b=CQnljsVoND7D2JAbrz380NJtnFbWrwb57Uy9gD2Oww8gNaeX3JbgzUhSYKumCEMNhV
         eloX/RfEHR0Zad+9MHVhcuu6RnxcacLGIMyEIDDsiXNQxEn/FKsVzUidZVrzJDIV7ace
         UXUQz/BFlCpGYadYPfAmqXsCPq3BXNIhs1yenKvQyBcpFJfR67T3fuZTv8nh3KRQ8z9M
         s+DBtYlAuWy2FZ9SHJk6W7F3UQeDUeXmONyqueKePXtvDA498vmbaNwRsDXFfka46dnD
         ZPxp5lfOvW0c6q+mSoQDPppLdaqD+YZXxxG/YZ0qvNUsk7EURel28KHZEVhSSRmwswMz
         uuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938779; x=1728543579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NM4UKNqMrpKmu1TycMfUZPeK8tMRrFnZOJHBIPtUSAM=;
        b=TMJmrkmsBKMBi2sgGgZL5rqtdnaH2vwaHa+hSpBt0ofo0HKsaXLJNfN3+w3qfIdwtr
         iCblPhH9or6efIcS5nrjHNQfPxLSIBK/1jLr2U4EEgTvsz4qqSEv1m6olpoXyY5tXTN1
         vgm/aHP5PgvePphDRS1uwGQVSaYaqRPggd43k6CRsofhcL8eKtaKveuIJrxMZ8rQh3Pi
         9L9NqBpmcZlCrYjs2CV1xGqLf4KDeEC0WXW2QYU6UHCKZbY0uP2/xo7j2RSOoY+hCxA+
         Wm/xWeiGB7gCdpW0ud4eVWxnxTEv6jcnJOzbukHMSqV9AMN0C5pL2fc1sGdwgYQ73WkX
         AxFw==
X-Gm-Message-State: AOJu0YytfO8/i0qzsJ5PH4JYZkKLs81VDAAluSg1qJF7oj+V3SX4mf42
	EYzEK5IEGpqo2dXB1RmuL5fL9mIt36BZujA4+rITl1aGM4yZJ/OEXracEGUIEImSR1tMHAVuZHl
	0GilgAv++b7yr4qUhBiRkF+iJ8KfkVmTLP6AW
X-Google-Smtp-Source: AGHT+IFJhlJJ2C03IWhyhm+dHkmCyTJGcEox9qABXEg0w6hkmOQhbng8QE6lheL2DZs7zlqv5h2NuN0XQAI7DUMlbpg=
X-Received: by 2002:a05:622a:a707:b0:458:403a:4e77 with SMTP id
 d75a77b69052e-45d8e2a2723mr2349821cf.20.1727938778821; Wed, 02 Oct 2024
 23:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930171753.2572922-1-sdf@fomichev.me> <20240930171753.2572922-6-sdf@fomichev.me>
In-Reply-To: <20240930171753.2572922-6-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 2 Oct 2024 23:59:27 -0700
Message-ID: <CAHS8izPbGa7v9UfcMNXhwLQ6z2dNth92x6MF7zwgUijziK0U-g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 05/12] selftests: ncdevmem: Remove default arguments
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:18=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> To make it clear what's required and what's not. Also, some of the
> values don't seem like a good defaults; for example eth1.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 34 +++++++++-----------------
>  1 file changed, 12 insertions(+), 22 deletions(-)
>
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selft=
ests/net/ncdevmem.c
> index 699692fdfd7d..bf446d74a4f0 100644
> --- a/tools/testing/selftests/net/ncdevmem.c
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -42,32 +42,13 @@
>  #define MSG_SOCK_DEVMEM 0x2000000
>  #endif
>
> -/*
> - * tcpdevmem netcat. Works similarly to netcat but does device memory TC=
P
> - * instead of regular TCP. Uses udmabuf to mock a dmabuf provider.
> - *
> - * Usage:
> - *
> - *     On server:
> - *     ncdevmem -s <server IP> -c <client IP> -f eth1 -l -p 5201 -v 7
> - *

No need to remove this documentation I think. This is useful since we
don't have a proper docs anywhere.

Please instead update the args in the above line, if they need
updating, but looks like it's already correct even after this change.

> - *     On client:
> - *     yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | \
> - *             tr \\n \\0 | \
> - *             head -c 5G | \
> - *             nc <server IP> 5201 -p 5201
> - *
> - * Note this is compatible with regular netcat. i.e. the sender or recei=
ver can
> - * be replaced with regular netcat to test the RX or TX path in isolatio=
n.
> - */
> -
> -static char *server_ip =3D "192.168.1.4";
> +static char *server_ip;
>  static char *client_ip;
> -static char *port =3D "5201";
> +static char *port;
>  static size_t do_validation;
>  static int start_queue =3D 8;
>  static int num_queues =3D 8;
> -static char *ifname =3D "eth1";
> +static char *ifname;
>  static unsigned int ifindex;
>  static unsigned int dmabuf_id;
>
> @@ -613,6 +594,15 @@ int main(int argc, char *argv[])
>                 }
>         }
>
> +       if (!server_ip)
> +               error(1, 0, "Missing -s argument\n");
> +
> +       if (!port)
> +               error(1, 0, "Missing -p argument\n");
> +
> +       if (!ifname)
> +               error(1, 0, "Missing -f argument\n");
> +
>         ifindex =3D if_nametoindex(ifname);
>
>         for (; optind < argc; optind++)
> --
> 2.46.0
>


--=20
Thanks,
Mina

