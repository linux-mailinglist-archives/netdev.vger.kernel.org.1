Return-Path: <netdev+bounces-192739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98261AC0FE7
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 17:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6804E0633
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CCA298254;
	Thu, 22 May 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGuVVlAa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1448528DB45;
	Thu, 22 May 2025 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747927573; cv=none; b=D4guidKqJLQfEMeL2z+W4WlXuedCt34l8NIuyu3W9cRPBak/eGFa0TJCp1ZnDLK64FWLfBdi9A4TTomLEg2ZX1qeNFiYL9IEDidPS0nLPip7WcIS5bSj/kugHuWnxZ69nqohOq0nW2qEoNNbruFTBER4fKZUAfGwY6u54kU3uzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747927573; c=relaxed/simple;
	bh=3x2OI2hN6FkHlJMugBJSqLrZOAa+i37HWdALU1PHbRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cV2puhJ+gw2WNxSTXMah7fucKwP3TYqRy8w5AV5ZxAp1C6kzCblz4pE19fALL8PprTRbaHDwEVAAuLALsjUJOywGNRBisYC1nlHCV6nKMB316+67iGhlQxAnb2/G39XHM0VmfIzJXqgfUYGirOd3UQaodacc+TCA8+6AVLG/JmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGuVVlAa; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54d98aa5981so12225495e87.0;
        Thu, 22 May 2025 08:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747927570; x=1748532370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRu6WJED+68M31gcfdYc3gZ+yqNlhPwEuu4Swc2vtZ8=;
        b=bGuVVlAazCeqXJvSbJYukkZhfVRbD9Y7q9l7ouZH2dSR0OzP4HJ5coEf6XQlGRzXN9
         r7LJ9YgNClZ5yh17KGsNmFo2Ucjt4Anye5QuW63eChnv4ua7g7nas1+k2eSpJw/u6sdE
         OE74sETMA0/EPoBN8eZii+OsepjruyuElCvlUVY0arbTktEJTfUhXv8kT+xlGsRxmzL9
         KuKTQxvuDZ6co0KRJYLdyc2+UoCNwBXrLDgdYP3+UIlLap8ptnG/+Q/vdvrCiUv2464K
         VsG8L1870VQ+ghnqMvP+cMYLrnUvQF75ndi/depEhmQHTcB1YDIO6oT3KllefI/kye82
         /pxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747927570; x=1748532370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRu6WJED+68M31gcfdYc3gZ+yqNlhPwEuu4Swc2vtZ8=;
        b=cVqpkTgHMJ4qW8yPEyZg0SAWiPVVVsMarsUiKJ+pzlN7wm11+zYG/GGZe8zMPNu5qF
         68TaM6ga4HwYcJj0sYhgLCiE2tzquY7bRhAJe+3lTFbcvvSUnb8AsGgjmsTEHip2LcWU
         AGCPVl5dGBYXdwXm7Vna5Ygv+W4sAYq4xEPav+oQEyoZFh02bVemnWje0jqKWK1JIaF7
         UPoNwalsbGfJPapEPqgW+G8LTai7uoJByki9tH+SwFnifuuSW0G1X5cOX5kQZrJksGc1
         fcFev3nQgIDNHU6oc2IdiKZUzgL6VgN5Ue1sytI2R97uF19PlyLjIt7+3Uu8K8MBqHl+
         vKHA==
X-Forwarded-Encrypted: i=1; AJvYcCUEw3DZLrsPGC7wDOhXEVjMnQk6Yad/+fEn3y4+NhQRfQ+dZpcHsziCEUSQGqX76WJBeMpB8dbnf5RLbEY=@vger.kernel.org, AJvYcCWsuzW5DisLp1yuyUDCo9ugq5bqj802avKyt5gX+infRN0wkQ8FoX41SSHidxPiRLBoFNQF2fm6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs9K3vEGV3DTvm0Y+aLlGm/JZLp2CTAGa1UfUZOBYLso0tPIjz
	3r/TpfW3zsbYTy/0nqfHR152JQ4wfqy+M4RQCWtQfBrrDk33WHmc97NOEZ0/n2HvRY9euFVHvOx
	VwEPJ2dasnKRVssebdSWY/2+ndOfiQg==
X-Gm-Gg: ASbGncs4ExkEMGPfNr+av0uWSuWqhM8a/vBvTDGpQMDbwmxO3wZ89wOkS28QhN/go9b
	w/K/w4EzwaBQTeURcQSjO0BwvyNyVDzMXts5TPFKBYRcqMdu6U7vXCVSwyflRIqgut22fpUR0jd
	P8jnCUDnT64OLldy/hLRcGRt6uWPcli6dhZoL5RMIwsRYhRE2mtsF4Jw==
X-Google-Smtp-Source: AGHT+IFhOnWIkdYpld8RKu76IP9OY1WN78GMzUGWbz5auQ3z0uNand2RXMc9LYuxgWLxjvoeyVF1yp8+NZEm81ZBid8=
X-Received: by 2002:a2e:a98e:0:b0:308:f0c9:c4cf with SMTP id
 38308e7fff4ca-328077aee22mr115216181fa.33.1747927569896; Thu, 22 May 2025
 08:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP=Rh=M1LzunrcQB1fSGauMrJrhL6GGps5cPAKzHJXj6GQV+-g@mail.gmail.com>
 <20250521181024.44883-1-kuniyu@amazon.com>
In-Reply-To: <20250521181024.44883-1-kuniyu@amazon.com>
From: John <john.cs.hey@gmail.com>
Date: Thu, 22 May 2025 23:25:55 +0800
X-Gm-Features: AX0GCFvd8V_5ptJTy0wsKAANvAjbl_Ina3iW4mLi-zfx-b6fTKDvLfDuyyfCID8
Message-ID: <CAP=Rh=NrrMf_WC-c6VQsWGB66FBTgoNg7hYntjcs5BqhqnuzLQ@mail.gmail.com>
Subject: Re: [Bug] "general protection fault in calipso_sock_setattr" in Linux
 kernel v6.12
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Kuniyuki,

Thank you very much for your prompt reply and support. My full name is
John Cheung. I will continue attempting to reproduce the crash as
discussed.

I will keep you updated on any progress. Thank you again for your time
and assistance.

Best regards,
John

On Thu, May 22, 2025 at 2:10=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: John <john.cs.hey@gmail.com>
> Date: Wed, 21 May 2025 22:50:38 +0800
> > Dear Linux Kernel Maintainers,
> >
> > I hope this message finds you well.
> >
> > I am writing to report a potential vulnerability I encountered during
> > testing of the Linux Kernel version v6.12.
> >
> > Git Commit: adc218676eef25575469234709c2d87185ca223a (tag: v6.12)
> >
> > Bug Location: calipso_sock_setattr+0xf6/0x380 net/ipv6/calipso.c:1128
> >
> > Bug report: https://hastebin.com/share/iredodibar.yaml
> >
> > Complete log: https://hastebin.com/share/biqowozonu.perl
> >
> > Entire kernel config: https://hastebin.com/share/huqucavidu.ini
>
> Thanks for the report.
>
>
> >
> > Root Cause Analysis:
> > The crash is caused by a NULL pointer dereference in txopt_get() (at
> > include/net/ipv6.h:390) due to an uninitialized struct inet6_opt *opt
> > field.
>
> This is not correct.  The splat says the null deref happens at
> np->opt.
>
> > RIP: 0010:txopt_get root/zhangqiang/kernel_fuzzing/Drivers_Fuzz/linux-6=
.12/include/net/ipv6.h:390 [inline]
>
>    385  static inline struct ipv6_txoptions *txopt_get(const struct ipv6_=
pinfo *np)
>    386  {
>    387          struct ipv6_txoptions *opt;
>    388
>    389          rcu_read_lock();
>    390          opt =3D rcu_dereference(np->opt);
>
> and the offset is 0x70, which is of opt in struct ipv6_pinfo.
>
> > KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
>
> $ python3
> >>> 0x70
> 112
>
> $ pahole -C ipv6_pinfo vmlinux
> struct ipv6_pinfo {
> ...
>         struct ipv6_txoptions *    opt;                  /*   112     8 *=
/
>
>
> np + 0x70 =3D 0x70, meaning np was NULL here.
>
> np is always initialised for IPv6 socket in inet6_create(), so this
> should never happens for IPv6 sockets.
>
> But looking at netlbl_conn_setattr(), it swtiched branch based on
> sockaddr.sa_family provided by userspace, and it does not check if
> the socket is actually IPv6 one.
>
> So, the fix will be:
>
>
> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index cd9160bbc919..067f707f194d 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -1165,6 +1165,9 @@ int netlbl_conn_setattr(struct sock *sk,
>                 break;
>  #if IS_ENABLED(CONFIG_IPV6)
>         case AF_INET6:
> +               if (sk->sk_family !=3D AF_INET6)
> +                       return -EPROTONOSUPPORT;
> +
>                 addr6 =3D (struct sockaddr_in6 *)addr;
>                 entry =3D netlbl_domhsh_getentry_af6(secattr->domain,
>                                                    &addr6->sin6_addr);
>
>
> > The function is indirectly invoked during an SELinux policy
> > enforcement path via calipso_sock_setattr(), which expects an
> > initialized inet6_sk(sk)->opt structure.
> > However, the socket in question does not have IPv6 tx options set up
> > at the time of the call, likely due to missing or out-of-order
> > initialization during socket creation or connection setup.
> > This leads to an invalid access at offset +0x70, detected by KASAN,
> > and results in a general protection fault.
> >
> > At present, I have not yet obtained a minimal reproducer for this
> > issue. However, I am actively working on reproducing it, and I will
> > promptly share any additional findings or a working reproducer as soon
> > as it becomes available.
>
> Try setting CALIPSO and calling connect(IPv6 addr) for IPv4 socket.
>
>
> >
> > Thank you very much for your time and attention to this matter. I
> > truly appreciate the efforts of the Linux kernel community.
>
> Could you provide your full name so that I can give proper credit
> in Reported-by tag ?
>

