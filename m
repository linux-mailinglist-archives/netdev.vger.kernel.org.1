Return-Path: <netdev+bounces-131490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4C298EA33
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA71FB24343
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 07:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA07983CD6;
	Thu,  3 Oct 2024 07:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQAXQ38L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEAA839E3
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939680; cv=none; b=GROukEYgXmI9RSn06k5FjZItSAn6/C2XgGX9H/pOAol97C8KH+DKglpi/DBA1yD9Zy9xnyGqCp4cC2eSaOJihAIMZNdOsd1cE7KHTT+Qtuhn4OSa3KkiJ1RzSn9LjPyF3d0viyBdDjdCii83ssOOwYcIIZsDhuDn/Pg3lpm1OJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939680; c=relaxed/simple;
	bh=jVV8jOhZdzb4iNhy6FgpnRXbN2bvdSfG8IkJGvxsBaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9XSBUirylc9/U5iSyxzQFN6wdWnSXqB1LcsW2uHUvyG8ZSSRvXG0o13cMqYHfl1kqHqOupeODsRn3/K5aF6pfcxYl/CYK+JEVg5LKCvVmBubuB9vcAbd9XLGFi4PYoQph/I3eN9yHRXsRKE1XeSsz38aJflDxRTweyROk06V/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vQAXQ38L; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4582fa01090so188501cf.0
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 00:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727939678; x=1728544478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UT6P3qI8aqfj6sm8kEA9BN2oWMh9ZC2nrd3bGHqEq48=;
        b=vQAXQ38L+VitBK3KxPrOhvi/CwrxdyD/5lEnAbUUziLDRLmKztnP1mJcWsACIKZWVv
         cHd6Oi6352GkJ7ar1P9jk1EO0dbfyC1r9BbyOhWgv26sXTiIKIi+eh6XwK2HbfeM5F/q
         XjKtEKGqLtbYtm/htEzPrK6XMjz/4T6dcPz+gCc/5T0JhqV8qbEfIg36tsXR97+3DUTy
         f7a1qwZ9bqa6HoFVkm/8NQ9xJP4hrG1+NN0GQ6Mf44zMW/pxSyzlkw4ZXzQht6LdcNRc
         TrukoEZjTRodgIZRcO1Y+zGmc/uVBAuhwPd0UC6vmVd+fO12P28z1yplirVmwCEhpTM+
         MRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727939678; x=1728544478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UT6P3qI8aqfj6sm8kEA9BN2oWMh9ZC2nrd3bGHqEq48=;
        b=F6qgV1MH6bir5aPq+Hm9eBg56LD7w7jembRnZON3JU6WC3kLBJkbF6BlsTWtB0kjO+
         SO3ERvJ7/A1hMzmLi0nM2FjLLdX//zVy/paPzYuvIyyPQnjTdd5eWEIxpC0+wohE5HTd
         9vHx6uOZO+0B/1vjPH7ISMlTSPq5ypJZ519ql3PuGGkQwegH+kCnH2+9KggYmkw2usb8
         mhRvR9xIjT3qYP9FXLhYlETupEiQse/1cQvPouiv2IAipEY9C8KzTAduq4CMhF3Mt2vo
         KpREAMDcufaCSlDoe2FLnKyu/cyY6g+qeWxXB90txsc6Hm9PlAhNmrkLmXZnCT+sFufF
         wb9A==
X-Gm-Message-State: AOJu0Yya/xvhGEMAEcuih5Ks8mjTAMFt1robhMjd0HbHBTtCjOazGcbV
	nJqN2hwPBX4z0WhREnCRgVoCY2Paqth53NoQ6NSEAWWlPiD1IaGHYhP3yt8NLFcgFZzYwncDTWL
	yP85afRQmY6ROKdzE369PWmSHTpr1TasiKcbR
X-Google-Smtp-Source: AGHT+IE1jwK+fLdh17wchpTZTlyKKjBUmf8cpDI457MyIR4cMbjE2zBpkUOAcmQFiddSFKKZQntYNjRBaRlQ5xGGtdQ=
X-Received: by 2002:a05:622a:860b:b0:45c:9eab:cce0 with SMTP id
 d75a77b69052e-45d8fa49632mr1747791cf.15.1727939677626; Thu, 03 Oct 2024
 00:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930171753.2572922-1-sdf@fomichev.me> <20240930171753.2572922-10-sdf@fomichev.me>
In-Reply-To: <20240930171753.2572922-10-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 3 Oct 2024 00:14:25 -0700
Message-ID: <CAHS8izNK+DiQUUkkvnPQvBRJiQ32WRO0Crg=nvOW9vn_4kCE+Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 09/12] selftests: ncdevmem: Remove hard-coded
 queue numbers
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:18=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> Use single last queue of the device and probe it dynamically.
>

Sorry I know there was a pending discussion in the last iteration that
I didn't respond to. Been a rough week with me out sick a bit.

For this, the issue I see is that by default only 1 queue binding will
be tested, but I feel like test coverage for the multiple queues case
by default is very nice because I actually ran into some issues making
multi-queue binding work.

Can we change this so that, by default, it binds to the last rxq_num/2
queues of the device?

> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 40 ++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selft=
ests/net/ncdevmem.c
> index a1fa818c8229..900a661a61af 100644
> --- a/tools/testing/selftests/net/ncdevmem.c
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -48,8 +48,8 @@ static char *server_ip;
>  static char *client_ip;
>  static char *port;
>  static size_t do_validation;
> -static int start_queue =3D 8;
> -static int num_queues =3D 8;
> +static int start_queue =3D -1;
> +static int num_queues =3D 1;
>  static char *ifname;
>  static unsigned int ifindex;
>  static unsigned int dmabuf_id;
> @@ -198,6 +198,33 @@ void validate_buffer(void *line, size_t size)
>         fprintf(stdout, "Validated buffer\n");
>  }
>
> +static int rxq_num(int ifindex)
> +{
> +       struct ethtool_channels_get_req *req;
> +       struct ethtool_channels_get_rsp *rsp;
> +       struct ynl_error yerr;
> +       struct ynl_sock *ys;
> +       int num =3D -1;
> +
> +       ys =3D ynl_sock_create(&ynl_ethtool_family, &yerr);
> +       if (!ys) {
> +               fprintf(stderr, "YNL: %s\n", yerr.msg);
> +               return -1;
> +       }
> +
> +       req =3D ethtool_channels_get_req_alloc();
> +       ethtool_channels_get_req_set_header_dev_index(req, ifindex);
> +       rsp =3D ethtool_channels_get(ys, req);
> +       if (rsp)
> +               num =3D rsp->rx_count + rsp->combined_count;
> +       ethtool_channels_get_req_free(req);
> +       ethtool_channels_get_rsp_free(rsp);
> +
> +       ynl_sock_destroy(ys);
> +
> +       return num;
> +}
> +
>  #define run_command(cmd, ...)                                           =
\
>         ({                                                              \
>                 char command[256];                                      \
> @@ -672,6 +699,15 @@ int main(int argc, char *argv[])
>
>         ifindex =3D if_nametoindex(ifname);
>
> +       if (start_queue < 0) {
> +               start_queue =3D rxq_num(ifindex) - 1;

I think the only changes needed are:

start_queue =3D rxq_num(ifindex) / 2;
num_queues =3D rxq_num(ifindex) - start_queue;

(I may have an off-by-1 error somewhere with this math).


--=20
Thanks,
Mina

