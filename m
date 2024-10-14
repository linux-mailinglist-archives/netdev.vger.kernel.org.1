Return-Path: <netdev+bounces-135365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 363B299D9E5
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 00:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF17C2828D2
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417901CC158;
	Mon, 14 Oct 2024 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tce+0bqv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3E155A5D
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728946084; cv=none; b=G1kdC3oluEPpsm2SaTX2mzkSTpdO57OM94GoQI9QUDMzbs3St5ZI9AiSWmCT3SoPHh3uEG++362Gk+NXpcQy8imkEiOqpX7FCr+ScyU1S0NuaBa+kemQa/Pcc2IhPoaou+wr4mBC6NeWO7XEnBw8HMHlac85d63VwIE2SvBEj34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728946084; c=relaxed/simple;
	bh=h01itfcR9qRaWa19N85yiNugdjtIHwIJxtddaVAAxzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+MW6QDTJ23T03501Fp2qY8GrRHIVLrThLdFfIVnw3MMbZC/w7Z/hNQXGGhICWye5fcPqqHyeqi/HLYJGZ8Pp8UrteQc9zhXNNtJhtrdNldO5MP1X0Msa9KJeeLo+B7+BE/UYeAAdrnsTgLk3CJMRSlPB5hPji4WojayO3AiZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tce+0bqv; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460395fb1acso542111cf.0
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 15:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728946081; x=1729550881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AM5iQOXVm81ybdI+9FnK0hKwVljlcVaSvRX3XtC02g=;
        b=Tce+0bqvjweeo6MYEVX6+ZFh/9g3QS/a4hp1B6ao3vXLeXOO0aLMnI/60j9a0/cwL2
         q4mJ0GWcHQsBuX/KdZzHx3E7eAK2p/hpCXez1CHu9N6JslwwvKdy8SAesaiUCsLmrghF
         4ORZC8l4esuQtqjqcpCe1TQ2MWYandDkBiDcgaYc5w/BB0uRs6Wkp5AaeYpO26q5yH9S
         MCdOBdjjw9u2ITHOu86FZtbuyjdHgU8Pk+re298TYR/P43tJ7kmtKXQsKl4S8NoDBx0l
         kmnxYasFflAnizkknW4C0hB55pWZoIGOP1SLl2bfWUz7+CUbBzUdNGdtmu2RUFjPqs2f
         iXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728946081; x=1729550881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AM5iQOXVm81ybdI+9FnK0hKwVljlcVaSvRX3XtC02g=;
        b=RfrmaSvpXeB84nh5TqaShV2a6tcrdFTyJRV8wVtU3yZtnvasibh444XtLOmXX8zNg4
         zXL8IaA9qiN1w3aL94XKVJTr/j9LFyv8bwT7eD97GkZq6r/9wOnt5XvgXIgr/Sex2LFV
         8wqSIBvkHv1+uIQ8h/bVwHHcOUVpD/UB0P6S/M87aiEk6N5et25xtSYJEUtE0xY/IqiP
         FCSEtyxm++3xv+Seuw3qkp/vnegitW3Zq/2kVIoE4QwMdYCvRv2YyCvpGGv3kuQ32bTN
         g62IYBkdKtsj+3Z/e9ALoO/TyBi9qb94L8S7wFFpgk0Rv3tEx7MU33Fwjn+yv1z64Ixy
         5pnQ==
X-Gm-Message-State: AOJu0YwJnR8EFC2X66lPGO/CU7BwQnb5aBNkthPZlJXzTrTntkgON3CU
	jasArw1I7v33KoqgXDMTzZWHDxSuLpTv8PAvS+h3dhCHe5d3CZ/HGD38rYsnyRo5M88ZkLpBL9K
	zT/wP637EKXWOP5vWqSQF2WZ68DlfH8wwynH7
X-Google-Smtp-Source: AGHT+IGyAUVEVxHjwjwQ1XvK7UprmNMIKUgGJafvbxHnY3vCBJZ+YhutCw4qPXx5J0DKWvoMexEzirB+/mhzmet7m7g=
X-Received: by 2002:a05:622a:528c:b0:460:481a:d537 with SMTP id
 d75a77b69052e-46059c77be0mr6064101cf.25.1728946081288; Mon, 14 Oct 2024
 15:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009171252.2328284-1-sdf@fomichev.me> <20241009171252.2328284-11-sdf@fomichev.me>
In-Reply-To: <20241009171252.2328284-11-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 15 Oct 2024 01:47:48 +0300
Message-ID: <CAHS8izMCwm+iW2u_jTTzNW0DPV7Rc3HHev+t8N+iof4XmaeChw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 10/12] selftests: ncdevmem: Run selftest when
 none of the -s or -c has been provided
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 8:13=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.me>=
 wrote:
>
> This will be used as a 'probe' mode in the selftest to check whether
> the device supports the devmem or not. Use hard-coded queue layout
> (two last queues) and prevent user from passing custom -q and/or -t.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 42 ++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selft=
ests/net/ncdevmem.c
> index 90aacfb3433f..3a456c058241 100644
> --- a/tools/testing/selftests/net/ncdevmem.c
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -64,7 +64,7 @@ static char *client_ip;
>  static char *port;
>  static size_t do_validation;
>  static int start_queue =3D -1;
> -static int num_queues =3D 1;
> +static int num_queues =3D -1;
>  static char *ifname;
>  static unsigned int ifindex;
>  static unsigned int dmabuf_id;
> @@ -706,19 +706,31 @@ int main(int argc, char *argv[])
>                 }
>         }
>
> -       if (!server_ip)
> -               error(1, 0, "Missing -s argument\n");
> -
> -       if (!port)
> -               error(1, 0, "Missing -p argument\n");
> -
>         if (!ifname)
>                 error(1, 0, "Missing -f argument\n");
>
>         ifindex =3D if_nametoindex(ifname);
>
> -       if (start_queue < 0) {
> -               start_queue =3D rxq_num(ifindex) - 1;
> +       if (!server_ip && !client_ip) {
> +               if (start_queue < 0 && num_queues < 0) {
> +                       num_queues =3D rxq_num(ifindex);
> +                       if (num_queues < 0)
> +                               error(1, 0, "couldn't detect number of qu=
eues\n");
> +                       /* make sure can bind to multiple queues */
> +                       start_queues =3D num_queues / 2;
> +                       num_queues /=3D 2;
> +               }
> +
> +               if (start_queue < 0 || num_queues < 0)
> +                       error(1, 0, "Both -t and -q are requred\n");
> +
> +               run_devmem_tests();
> +               return 0;
> +       }
> +
> +       if (start_queue < 0 && num_queues < 0) {
> +               num_queues =3D 1;
> +               start_queue =3D rxq_num(ifindex) - num_queues;
>

Nit: this can be written into the more readable:

// set start_queues =3D rxq_num / 2;
if (!server_ip && !client_ip) {
  // set num_queues rxq_num/2
  run_devmem_tests();
} else {
  // set num_queue =3D 1.
  run_server();
}

With build error fixed:

Reviewed-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina

