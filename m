Return-Path: <netdev+bounces-113672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E07093F767
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 16:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F8728293F
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 14:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412F114AD19;
	Mon, 29 Jul 2024 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlTE2sBe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213F72D05D
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262667; cv=none; b=iP4OKIOynxsB7jrxko1sesn418zMPEhb7FNglmyE13zlbpD3kzAn24zsCiHrMT32OWq2bjH8UeuC1GzEBPZaCr8JRHTx3quw0a9VoONX7MLMVmOCc5x/p84N7J2BeHTLZpqnymp4BLbhVYqKd1EiTHyIOnlqyE4a+iGM9bxwyKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262667; c=relaxed/simple;
	bh=tiHXvdAGpoYjbwveTSfVyylqXeuMo3NfTeqzKBp9K64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKmX7m6lOa+NQJUxmQ27jICFNQV2j1+CLwDiGuyHRdPqGNS7hkhFo/5Zfdrr8VYLDtopeh8y/bOdj4aH44aap8bJ9c5WKgefL1jU07AhR0ULFSP7yxnwkd5ISwTK0O5W5oIlep8qHpvhoudGksfct6a5HbaOplEldabaa0Iztuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlTE2sBe; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ed9b802ceso4246013e87.3
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 07:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722262663; x=1722867463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QQyA2TCu5n/t647bB+YIyMr/vvqROvP3CKMJVmqiDA=;
        b=hlTE2sBeSPlyDxDj0Fr1H5iX0jpafUiKIX2ESFZx9RB0U7mN50+nAidlSqOGoMGyn/
         R1BlSwB9X+3WJzh+lyq7qJG84f3++q3vHULLrDapoUrxNXf40fcg7PxnUjKMv2nzBmnG
         yBjBHzf1mxl8RTvHxoEG7JidZVREq/1yaobfiFSOWBnzO1EGpTM3uwNeBOn5kfITgEPI
         73KzTaV7KRBUrAAAjHqLfBiyVEZVmLH5OGy0zlJDrryXrH4VrqmBhaWOulYOjPoJcln7
         wuj4QD4WtGPk2zq0YWdAfY+MXwWUFlihDbfB4VRyLU5aqrcZJGsi1sJ4QSXoG6PPafVR
         Fh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722262663; x=1722867463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QQyA2TCu5n/t647bB+YIyMr/vvqROvP3CKMJVmqiDA=;
        b=xF2i1uVd5W5deC8H/oPNIZzEaajOy1NPzJDMKyYSq+67TpoQkLD2o6lp2nrMp2jd/G
         0rC0WRZDIKCaW8QA4AH3Q1Mq4n9S1oknCSyBXzSAumXmoVRZkqu/bcLfVa163j868FfB
         sGCo1cSqsXg907CGgsYBttt5KQFzkfRYHlDKxoxDtzY/2ckKaRwCUgawcWsEQN5qFXzm
         pnbzd0KHZIWcZaraGeXMVj+mf6dxtMwjFqdm4SslGUYx/e0BZKViwwh46yn7tA+yTeWU
         fpV0VeGjQh6jIrWvZfnhRngT64LaYV2LfmuHMg3+eVCw7gzjNdzM3PScwyJjsjszPZW7
         5E9w==
X-Forwarded-Encrypted: i=1; AJvYcCU4yqIZFTd1NveluyoxhNWE1LgubNF6hEg81qU02Bf8rXPWSwhD+G1InFFPfQCGCs7dDU7tOm0t8huNINrmW0Tb//dEaO0a
X-Gm-Message-State: AOJu0YzgGjNYOZVyWDxhadlYzWjmPA/PYfq/0QLVu6rnJ979yaJH3/WW
	iQXDi5/330IlB1TwDLYT2vG+hAc5BYfOuuA+8idVBuqvTqYsXCDFewnhDCgkp9p3b/vKvGfZ2SA
	0QKSCr7li+/kvJ+f9pnjYf3OnpDE=
X-Google-Smtp-Source: AGHT+IHD/YGEtzuRBezTJCJy2dk1yy/R+kdG9woTiT/5WNz+XMXj5RztSahC6/31+0KgXvVB8pBfrIzw+1fCoNuXBcs=
X-Received: by 2002:ac2:5f75:0:b0:52f:cdb0:11da with SMTP id
 2adb3069b0e04-5309b27dd64mr5545482e87.33.1722262662660; Mon, 29 Jul 2024
 07:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729095554.28296-1-xiaolinkui@126.com>
In-Reply-To: <20240729095554.28296-1-xiaolinkui@126.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 29 Jul 2024 22:17:05 +0800
Message-ID: <CAL+tcoB6UifOCMoryMNtMoZc=+erwX1G65FWBZF5O5rThEPAmA@mail.gmail.com>
Subject: Re: [PATCH] tcp/dccp: Add another way to allocate local ports in connect()
To: xiaolinkui@126.com
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	Linkui Xiao <xiaolinkui@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linkui,

On Mon, Jul 29, 2024 at 5:58=E2=80=AFPM <xiaolinkui@126.com> wrote:
>
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>
> Commit 07f4c90062f8 ("tcp/dccp: try to not exhaust ip_local_port_range
> in connect()") allocates even ports for connect() first while leaving
> odd ports for bind() and this works well in busy servers.
>
> But this strategy causes severe performance degradation in busy clients.
> when a client has used more than half of the local ports setted in
> proc/sys/net/ipv4/ip_local_port_range, if this client try to connect
> to a server again, the connect time increases rapidly since it will
> traverse all the even ports though they are exhausted.
>
> So this path provides another strategy by introducing a system option:
> local_port_allocation. If it is a busy client, users should set it to 1
> to use sequential allocation while it should be set to 0 in other
> situations. Its default value is 0.
>
> In commit 207184853dbd ("tcp/dccp: change source port selection at
> connect() time"), tell users that they can access all odd and even ports
> by using IP_LOCAL_PORT_RANGE. But this requires users to modify the
> socket application. When even numbered ports are not sufficient, use the
> sysctl parameter to achieve the same effect:
>         sysctl -w net.ipv4.local_port_allocation=3D1
>
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  include/net/tcp.h          |  1 +
>  net/ipv4/inet_hashtables.c | 12 ++++++++----
>  net/ipv4/sysctl_net_ipv4.c |  8 ++++++++
>  3 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 2aac11e7e1cc..99969b8e5183 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -269,6 +269,7 @@ DECLARE_PER_CPU(int, tcp_memory_per_cpu_fw_alloc);
>
>  extern struct percpu_counter tcp_sockets_allocated;
>  extern unsigned long tcp_memory_pressure;
> +extern bool sysctl_local_port_allocation;
>
>  /* optimized version of sk_under_memory_pressure() for TCP sockets */
>  static inline bool tcp_under_memory_pressure(const struct sock *sk)
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 48d0d494185b..e572f8b21b95 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -1020,11 +1020,15 @@ int __inet_hash_connect(struct inet_timewait_deat=
h_row *death_row,
>         l3mdev =3D inet_sk_bound_l3mdev(sk);
>
[...]
>         local_ports =3D inet_sk_get_local_port_range(sk, &low, &high);
> -       step =3D local_ports ? 1 : 2;
> +       /* local_port_allocation 0 means even and odd port allocation str=
ategy
> +        * will be applied, so step is 2; otherwise sequential allocation=
 will
> +        * be used and step is 1. Default value is 0.
> +        */
> +       step =3D sysctl_local_port_allocation ? 1 : 2;

Apart from what Eric said, it seems you break the setsockopt
method...? Please look at the 'local_ports'.

Once again, I'm confused about whether we should introduce such a
sysctl knob to do the same thing as an existing method does. Maybe it
suits a private kernel. I'm just saying.

Thanks,
Jason

>
>         high++; /* [32768, 60999] -> [32768, 61000[ */
>         remaining =3D high - low;
> -       if (!local_ports && remaining > 1)
> +       if (!sysctl_local_port_allocation && remaining > 1)
>                 remaining &=3D ~1U;
>
>         get_random_sleepable_once(table_perturb,
> @@ -1037,7 +1041,7 @@ int __inet_hash_connect(struct inet_timewait_death_=
row *death_row,
>         /* In first pass we try ports of @low parity.
>          * inet_csk_get_port() does the opposite choice.
>          */
> -       if (!local_ports)
> +       if (!sysctl_local_port_allocation)
>                 offset &=3D ~1U;
>  other_parity_scan:
>         port =3D low + offset;
> @@ -1081,7 +1085,7 @@ int __inet_hash_connect(struct inet_timewait_death_=
row *death_row,
>                 cond_resched();
>         }
>
> -       if (!local_ports) {
> +       if (!sysctl_local_port_allocation) {
>                 offset++;
>                 if ((offset & 1) && remaining > 1)
>                         goto other_parity_scan;
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index 9140d20eb2d4..1f6bf3a73516 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -45,6 +45,7 @@ static unsigned int tcp_child_ehash_entries_max =3D 16 =
* 1024 * 1024;
>  static unsigned int udp_child_hash_entries_max =3D UDP_HTABLE_SIZE_MAX;
>  static int tcp_plb_max_rounds =3D 31;
>  static int tcp_plb_max_cong_thresh =3D 256;
> +bool sysctl_local_port_allocation;
>
>  /* obsolete */
>  static int sysctl_tcp_low_latency __read_mostly;
> @@ -632,6 +633,13 @@ static struct ctl_table ipv4_table[] =3D {
>                 .extra1         =3D &sysctl_fib_sync_mem_min,
>                 .extra2         =3D &sysctl_fib_sync_mem_max,
>         },
> +       {
> +               .procname       =3D "local_port_allocation",
> +               .data           =3D &sysctl_local_port_allocation,
> +               .maxlen         =3D sizeof(sysctl_local_port_allocation),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_dobool,
> +       },
>  };
>
>  static struct ctl_table ipv4_net_table[] =3D {
> --
> 2.17.1
>
>

