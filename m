Return-Path: <netdev+bounces-131717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE0A98F56B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B1B2B20A44
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7EC15534D;
	Thu,  3 Oct 2024 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZfnvpWh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF53EDDCD
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727977262; cv=none; b=Bpuk1eI8oGqqgvXPcsCaF6q1bW8sq7PxuvBITCpSO/UlqdTEZyzEvZOFcbxeJX1SDv4Zq/YveIUH2mVTV/6blzC7Pnjzfet37BBzFRDpLXzri/dw/vxLpZaza9PcFaEFHa5UJ4CM6nqjcOvyZwH1XwGh9Vl/AWH6zCURnEf6Nqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727977262; c=relaxed/simple;
	bh=OiuIrTXtrSNWK7aN06E4YJvo1NKXuYYQ+ogP7Cl9DoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXB9UXVTS6vTYy3/iYcEifBvuHvwUcupCUbUkldX82yKhFueLdHqewzpGiQAa9tL3wgi2XdcgeyBRqGCcWnVO4mr0AT/hp73jA+X09rg9YP12YWJr8FSF67XWrAvr5aEkoTP5vGGzhykXJRidTgVuRXB7uVBiSx/CegcEglj/gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZfnvpWh; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4582fa01090so20891cf.0
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 10:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727977259; x=1728582059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3f+kbn8HK7W/1Q4WSys0aU5ZfGiuwr7ys/miaH9KndA=;
        b=HZfnvpWhvOBcAzNETgl29Fhb/+deYMO29f3KLrYXiKplhz0ndXMpX8pEA3bixUH5Nh
         /p1WbpvyqPLaia/vzTRfD6tQajYjt7RY8SGiCkxv5j7SEn/eGHYfVnFgGAS9vZz4c6TH
         6j+hltKM3dwm+4nZVIU/XVK0r9ppTAIJsIvRGsxvXpdn3lQBhnlr/Ak2LgY3mcr4pgiO
         xQoA2WwWlTchHyV305qAf6gY91GLTn4fWOeVuyad/0gbSRhldmaMD6/jPhesObVgvHT6
         K2En6yctyqdcOei1Ps+XtXRroKhxrK7pyRQnwMVSCeGdj8T3ByIqE7yoX14U813QsqLT
         h6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727977259; x=1728582059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3f+kbn8HK7W/1Q4WSys0aU5ZfGiuwr7ys/miaH9KndA=;
        b=bHCkPF6v/+0pkO6b/4i5Xrg79WYcodsW46Us8LFfRBpR1WiS8EeT8HBGqM869Iehcf
         GfxHdXSYMmNQNeh1GLlydwR757GBUB6sTIInxz4KF3/OkSXdpAGa3mDVCTuBTk60qj0T
         ZLdrN6Za6uaQJobg65n3sU4tTSCVEpK/VTkJIVuionSVAKgRCx1nU7jjLz85/iiNmSML
         0EIhA8s52NVvRvfs2L3muaSCE5q3eEUyZtXNm2M1aN67o6jatuEedxeMsssJ5mpXKP9Q
         yG5eXUFWvWSI3jm9EooQMGnKeac3OW2r2J7OuuKr/aHsvVb6GGLDauAycphpamqm6xlg
         OvJA==
X-Gm-Message-State: AOJu0YzJiV2qL0F3LnisS9zfDVo2K/eZY0s148Uxs8vaswBMI+3dnhzJ
	SWk8yXqCG+NrYi+/mRau1lJoiQtm3OCMCpijVLHBC4ZOLcGtj8mu+dg4SZSHiXwvLHBxw5gZ5DT
	QfUvnoq2mOCUymjjZTjwhlevEGJJ0r1oJXFwSSlQjOrJE2r0eJA==
X-Google-Smtp-Source: AGHT+IEw02dgFMTNwblC1e+0LOEYSvOSvhZ/U5HNfE79XmlSzXFMpfDvpaCu0BGhJftw+VqBeuAdKdm9+ld3YZ3BdFo=
X-Received: by 2002:a05:622a:568d:b0:456:7501:7c4d with SMTP id
 d75a77b69052e-45d8fa4a07cmr2850661cf.9.1727977259309; Thu, 03 Oct 2024
 10:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930171753.2572922-1-sdf@fomichev.me> <20240930171753.2572922-2-sdf@fomichev.me>
In-Reply-To: <20240930171753.2572922-2-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 3 Oct 2024 10:40:47 -0700
Message-ID: <CAHS8izNHX-G_AYWrB2sL8AGsfPEDLGZ84L2nGHgaJhjdMg-vmg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 01/12] selftests: ncdevmem: Redirect all
 non-payload output to stderr
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:17=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> That should make it possible to do expected payload validation on
> the caller side.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  tools/testing/selftests/net/ncdevmem.c | 61 +++++++++++++-------------
>  1 file changed, 30 insertions(+), 31 deletions(-)
>
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selft=
ests/net/ncdevmem.c
> index 64d6805381c5..9245d3f158dd 100644
> --- a/tools/testing/selftests/net/ncdevmem.c
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -88,7 +88,6 @@ void print_nonzero_bytes(void *ptr, size_t size)
>
>         for (i =3D 0; i < size; i++)
>                 putchar(p[i]);
> -       printf("\n");
>  }
>
>  void validate_buffer(void *line, size_t size)
> @@ -120,7 +119,7 @@ void validate_buffer(void *line, size_t size)
>                 char command[256];                                      \
>                 memset(command, 0, sizeof(command));                    \
>                 snprintf(command, sizeof(command), cmd, ##__VA_ARGS__); \
> -               printf("Running: %s\n", command);                       \
> +               fprintf(stderr, "Running: %s\n", command);               =
        \
>                 system(command);                                        \
>         })
>
> @@ -128,22 +127,22 @@ static int reset_flow_steering(void)
>  {
>         int ret =3D 0;
>
> -       ret =3D run_command("sudo ethtool -K %s ntuple off", ifname);
> +       ret =3D run_command("sudo ethtool -K %s ntuple off >&2", ifname);
>         if (ret)
>                 return ret;
>
> -       return run_command("sudo ethtool -K %s ntuple on", ifname);
> +       return run_command("sudo ethtool -K %s ntuple on >&2", ifname);
>  }
>
>  static int configure_headersplit(bool on)
>  {
> -       return run_command("sudo ethtool -G %s tcp-data-split %s", ifname=
,
> +       return run_command("sudo ethtool -G %s tcp-data-split %s >&2", if=
name,
>                            on ? "on" : "off");
>  }
>
>  static int configure_rss(void)
>  {
> -       return run_command("sudo ethtool -X %s equal %d", ifname, start_q=
ueue);
> +       return run_command("sudo ethtool -X %s equal %d >&2", ifname, sta=
rt_queue);
>  }
>
>  static int configure_channels(unsigned int rx, unsigned int tx)
> @@ -153,7 +152,7 @@ static int configure_channels(unsigned int rx, unsign=
ed int tx)
>
>  static int configure_flow_steering(void)
>  {
> -       return run_command("sudo ethtool -N %s flow-type tcp4 src-ip %s d=
st-ip %s src-port %s dst-port %s queue %d",
> +       return run_command("sudo ethtool -N %s flow-type tcp4 src-ip %s d=
st-ip %s src-port %s dst-port %s queue %d >&2",
>                            ifname, client_ip, server_ip, port, port, star=
t_queue);
>  }
>
> @@ -187,7 +186,7 @@ static int bind_rx_queue(unsigned int ifindex, unsign=
ed int dmabuf_fd,
>                 goto err_close;
>         }
>
> -       printf("got dmabuf id=3D%d\n", rsp->id);
> +       fprintf(stderr, "got dmabuf id=3D%d\n", rsp->id);
>         dmabuf_id =3D rsp->id;
>
>         netdev_bind_rx_req_free(req);
> @@ -314,8 +313,8 @@ int do_server(void)
>         if (ret)
>                 error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PR=
EFIX);
>
> -       printf("binding to address %s:%d\n", server_ip,
> -              ntohs(server_sin.sin_port));
> +       fprintf(stderr, "binding to address %s:%d\n", server_ip,
> +               ntohs(server_sin.sin_port));
>
>         ret =3D bind(socket_fd, &server_sin, sizeof(server_sin));
>         if (ret)
> @@ -329,14 +328,14 @@ int do_server(void)
>
>         inet_ntop(server_sin.sin_family, &server_sin.sin_addr, buffer,
>                   sizeof(buffer));
> -       printf("Waiting or connection on %s:%d\n", buffer,
> -              ntohs(server_sin.sin_port));
> +       fprintf(stderr, "Waiting or connection on %s:%d\n", buffer,
> +               ntohs(server_sin.sin_port));
>         client_fd =3D accept(socket_fd, &client_addr, &client_addr_len);
>
>         inet_ntop(client_addr.sin_family, &client_addr.sin_addr, buffer,
>                   sizeof(buffer));
> -       printf("Got connection from %s:%d\n", buffer,
> -              ntohs(client_addr.sin_port));
> +       fprintf(stderr, "Got connection from %s:%d\n", buffer,
> +               ntohs(client_addr.sin_port));
>
>         while (1) {
>                 struct iovec iov =3D { .iov_base =3D iobuf,
> @@ -349,14 +348,13 @@ int do_server(void)
>                 ssize_t ret;
>
>                 is_devmem =3D false;
> -               printf("\n\n");
>
>                 msg.msg_iov =3D &iov;
>                 msg.msg_iovlen =3D 1;
>                 msg.msg_control =3D ctrl_data;
>                 msg.msg_controllen =3D sizeof(ctrl_data);
>                 ret =3D recvmsg(client_fd, &msg, MSG_SOCK_DEVMEM);
> -               printf("recvmsg ret=3D%ld\n", ret);
> +               fprintf(stderr, "recvmsg ret=3D%ld\n", ret);
>                 if (ret < 0 && (errno =3D=3D EAGAIN || errno =3D=3D EWOUL=
DBLOCK))
>                         continue;
>                 if (ret < 0) {
> @@ -364,7 +362,7 @@ int do_server(void)
>                         continue;
>                 }
>                 if (ret =3D=3D 0) {
> -                       printf("client exited\n");
> +                       fprintf(stderr, "client exited\n");
>                         goto cleanup;
>                 }
>
> @@ -373,7 +371,7 @@ int do_server(void)
>                         if (cm->cmsg_level !=3D SOL_SOCKET ||
>                             (cm->cmsg_type !=3D SCM_DEVMEM_DMABUF &&
>                              cm->cmsg_type !=3D SCM_DEVMEM_LINEAR)) {
> -                               fprintf(stdout, "skipping non-devmem cmsg=
\n");
> +                               fprintf(stderr, "skipping non-devmem cmsg=
\n");
>                                 continue;
>                         }
>
> @@ -384,7 +382,7 @@ int do_server(void)
>                                 /* TODO: process data copied from skb's l=
inear
>                                  * buffer.
>                                  */
> -                               fprintf(stdout,
> +                               fprintf(stderr,
>                                         "SCM_DEVMEM_LINEAR. dmabuf_cmsg->=
frag_size=3D%u\n",
>                                         dmabuf_cmsg->frag_size);
>
> @@ -395,12 +393,13 @@ int do_server(void)
>                         token.token_count =3D 1;
>
>                         total_received +=3D dmabuf_cmsg->frag_size;
> -                       printf("received frag_page=3D%llu, in_page_offset=
=3D%llu, frag_offset=3D%llu, frag_size=3D%u, token=3D%u, total_received=3D%=
lu, dmabuf_id=3D%u\n",
> -                              dmabuf_cmsg->frag_offset >> PAGE_SHIFT,
> -                              dmabuf_cmsg->frag_offset % getpagesize(),
> -                              dmabuf_cmsg->frag_offset, dmabuf_cmsg->fra=
g_size,
> -                              dmabuf_cmsg->frag_token, total_received,
> -                              dmabuf_cmsg->dmabuf_id);
> +                       fprintf(stderr,
> +                               "received frag_page=3D%llu, in_page_offse=
t=3D%llu, frag_offset=3D%llu, frag_size=3D%u, token=3D%u, total_received=3D=
%lu, dmabuf_id=3D%u\n",
> +                               dmabuf_cmsg->frag_offset >> PAGE_SHIFT,
> +                               dmabuf_cmsg->frag_offset % getpagesize(),
> +                               dmabuf_cmsg->frag_offset,
> +                               dmabuf_cmsg->frag_size, dmabuf_cmsg->frag=
_token,
> +                               total_received, dmabuf_cmsg->dmabuf_id);
>
>                         if (dmabuf_cmsg->dmabuf_id !=3D dmabuf_id)
>                                 error(1, 0,
> @@ -438,15 +437,15 @@ int do_server(void)
>                 if (!is_devmem)
>                         error(1, 0, "flow steering error\n");
>
> -               printf("total_received=3D%lu\n", total_received);
> +               fprintf(stderr, "total_received=3D%lu\n", total_received)=
;
>         }
>
> -       fprintf(stdout, "%s: ok\n", TEST_PREFIX);
> +       fprintf(stderr, "%s: ok\n", TEST_PREFIX);
>
> -       fprintf(stdout, "page_aligned_frags=3D%lu, non_page_aligned_frags=
=3D%lu\n",
> +       fprintf(stderr, "page_aligned_frags=3D%lu, non_page_aligned_frags=
=3D%lu\n",
>                 page_aligned_frags, non_page_aligned_frags);
>
> -       fprintf(stdout, "page_aligned_frags=3D%lu, non_page_aligned_frags=
=3D%lu\n",
> +       fprintf(stderr, "page_aligned_frags=3D%lu, non_page_aligned_frags=
=3D%lu\n",
>                 page_aligned_frags, non_page_aligned_frags);
>
>  cleanup:
> @@ -551,7 +550,7 @@ int main(int argc, char *argv[])
>                         ifname =3D optarg;
>                         break;
>                 case '?':
> -                       printf("unknown option: %c\n", optopt);
> +                       fprintf(stderr, "unknown option: %c\n", optopt);
>                         break;
>                 }
>         }
> @@ -559,7 +558,7 @@ int main(int argc, char *argv[])
>         ifindex =3D if_nametoindex(ifname);
>
>         for (; optind < argc; optind++)
> -               printf("extra arguments: %s\n", argv[optind]);
> +               fprintf(stderr, "extra arguments: %s\n", argv[optind]);
>
>         run_devmem_tests();
>
> --
> 2.46.0
>


--=20
Thanks,
Mina

