Return-Path: <netdev+bounces-80105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3837987D098
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 16:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E446D1F21FB4
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7429C3F9E1;
	Fri, 15 Mar 2024 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz/LIGFL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A403D982;
	Fri, 15 Mar 2024 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517690; cv=none; b=eaXYjCPfPTim7wQ9StvVUXIWpNHcHi/BlpVmxZPLPUJXQAKv2TGVC0D/QHn5cP9thtvLsNhmHaPLr+ESZGmBKFKd/Vt5KeTuPVIJXsfJixqfzsMYcUOxRqBGlEZLnKs5/ldF5NJffwYtqb2OuBQYiKlZBN1zHhZILx7jPkL/Wok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517690; c=relaxed/simple;
	bh=rNyGkaVYT9PJLTHVjpoPEHietdSutSFWVRIazh3dZZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubnT6gVWIw+42vootM37EaFgZjcTP8L97w/Yg8t1vPp2VyZcICgC/Y0GH+tG/mYm80c/BZcOKXE/4LZAYTspK/RfzICtb+wuNQJvmBw9vlHzYu7wrMqH4c9pqwdZkB5AQN9sTWPMas1V1XhXw6Qe8VlXqe29UMNZAqV/NqKnvDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iz/LIGFL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-413f76ff0daso11302835e9.0;
        Fri, 15 Mar 2024 08:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710517687; x=1711122487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMDqFaIZpiFWWifm4sf0q2Ickmg+XUFkiKzZeBsRPww=;
        b=iz/LIGFLUwYCtON47fc4+CmILRYHjhQUINdrpSBsIKD+01JbVh8EvWNiz8qL06618I
         IuNgpF1u3IUD9rOjb4R1BqvVaNyS9/nRodWa4Esr4zER7e2ad7rLT2ssC8cPASDbM8VQ
         a+kJA8ITtbS3AIl03k1PJWNIMRUU5pkv/y4yDj7F51GOYgjjuiqQeGwubl1q6Aai3zU6
         SEER3nr9vcztzv6lvShIE2GrhdtVDYh7Fo9T+tAGyZ2F9YwKO0ZZAXEB0/Ru/Uw97Yn8
         w1qT73U4RzygTrrE47ukZFyLTNnEs2TYa48pxE9JB3CfM7FPMV4ZJY0h1uqbpylMjAFS
         NzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710517687; x=1711122487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMDqFaIZpiFWWifm4sf0q2Ickmg+XUFkiKzZeBsRPww=;
        b=n8aDkq4pGybY3VUcRoT5kh6SHoTlvUDS98pYZ8pLADcZ3ZBQJn6Elmm4e/A1QbAXIJ
         e0BH25oEDghQ3S6FZRZmzjKPKj4S8CdGRXM5bGWkkVQwwLK8uTkFNgd9tNCkjQccIzSu
         cu5qoWCqycXSjjO95gn2F8nPtczdxecBmPfT5B4EouiSGjWPskYJhlfvVF68ANNMITf3
         NcFHeZs+cxD9vWXZe/mjcvLeFm1pzKyA9H7mRsfAMMXrGnz16cDldv5eyrEOI5tUFi7d
         7H3ScxIeXL4HiH1M2X79b+8LJSIhdkolWQ9BQ3KUItNCYqUtG/Pht0mcsN8RWGZkRaBI
         WEgA==
X-Forwarded-Encrypted: i=1; AJvYcCUIfdirbnF1bQzuST9t4iyfFXhV0sVt1rXAsBbUjUdRRYohKD2aBjovTPCmrT+HyWzbc0P0qH676ERHJwqbavxhQB+cEiVz
X-Gm-Message-State: AOJu0YwAiBKcEDON7Q2hSL+kk/JrL/S0TWlY6xz2joHNLIGhpMahUzyc
	+wXKPiQOVexb24ij0zPpA5v/fTNbPArLcwnPG2ITE8OmqH7FR7J6OKl5ZFHdUoR672Xz8FYwb/m
	I/jBt8MqrjQIsTI1KiYhEEF1oU73kFLJY
X-Google-Smtp-Source: AGHT+IH1ENPc8GkmfMFAN9ZKZ7R/t6P/M2UcSGlgJ85sT/2ns1o4O5aj/2l/Fhh5HUSF4DxQw7neSzDAshTmtubYkfU=
X-Received: by 2002:adf:f5cb:0:b0:33e:bfb8:7320 with SMTP id
 k11-20020adff5cb000000b0033ebfb87320mr4235066wrp.7.1710517686640; Fri, 15 Mar
 2024 08:48:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315140726.22291-1-tushar.vyavahare@intel.com> <20240315140726.22291-5-tushar.vyavahare@intel.com>
In-Reply-To: <20240315140726.22291-5-tushar.vyavahare@intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 Mar 2024 08:47:55 -0700
Message-ID: <CAADnVQ+BxiKDC2HyztsoFdOLh8ECgnmG2UMH_+741CdBjDx0ZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/6] selftests/xsk: implement set_hw_ring_size
 function to configure interface ring size
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 7:23=E2=80=AFAM Tushar Vyavahare
<tushar.vyavahare@intel.com> wrote:
>
> Introduce a new function called set_hw_ring_size that allows for the
> dynamic configuration of the ring size within the interface.
>
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 35 ++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/sel=
ftests/bpf/xskxceiver.c
> index 32005bfb9c9f..aafa78307586 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -441,6 +441,41 @@ static int get_hw_ring_size(struct ifobject *ifobj)
>         return 0;
>  }
>
> +static int set_hw_ring_size(struct ifobject *ifobj, u32 tx, u32 rx)
> +{
> +       struct ethtool_ringparam ring_param =3D {0};
> +       struct ifreq ifr =3D {0};
> +       int sockfd, ret;
> +       u32 ctr =3D 0;
> +
> +       sockfd =3D socket(AF_INET, SOCK_DGRAM, 0);
> +       if (sockfd < 0)
> +               return errno;
> +
> +       memcpy(ifr.ifr_name, ifobj->ifname, sizeof(ifr.ifr_name));
> +
> +       ring_param.tx_pending =3D tx;
> +       ring_param.rx_pending =3D rx;
> +
> +       ring_param.cmd =3D ETHTOOL_SRINGPARAM;
> +       ifr.ifr_data =3D (char *)&ring_param;
> +
> +       while (ctr++ < SOCK_RECONF_CTR) {
> +               ret =3D ioctl(sockfd, SIOCETHTOOL, &ifr);
> +               if (!ret)
> +                       break;
> +               /* Retry if it fails */
> +               if (ctr >=3D SOCK_RECONF_CTR) {
> +                       close(sockfd);
> +                       return errno;
> +               }
> +               usleep(USLEEP_MAX);

Does it really have to sleep or copy paste from other places?
This ioctl() is supposed to do synchronous config, no?

