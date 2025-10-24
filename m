Return-Path: <netdev+bounces-232354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD15C048AC
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 08:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE4904F5A41
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 06:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB062798F3;
	Fri, 24 Oct 2025 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nHA3U3Ws"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD52C277CA4
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761288221; cv=none; b=bXVZNQGM1GNM5sksqD5iokbDUVc7LVBQiC4d4WUCIsy3sZNAVS+jurKintYnXQYI1aB7XPOLycqGiTUy9HxV7JpLXXU+Z37+BvJMwp18ELU82dNAE7v6Rnd6nQeWV3sqBbRSAlxLGqPoSzU3uAUb3d01Kr9P31gm5oY1zOERYxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761288221; c=relaxed/simple;
	bh=h2do/o72s1S1CroaAeWrkIDYcS+e5vX7dYGFhfPZhPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khQ3tj1u7HNT4VBNOxswW7O0oLmyYKR68JDgzdAYR50pfgPyWHso9MTdVVmoow3ze89717Kjjbg69feheEEiAxLxM4CNfnY/s7MG0nxiOMm8CvEUIA8pCO42njj/ra1LXlf4Cc7RKgrBe0pltrqkjEG2k0qMRF3po1BM0rUWrjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nHA3U3Ws; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63e336b1ac4so2869599d50.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 23:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761288218; x=1761893018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2UFjwfCheMSDPhpGuyj3HSoQ9LJMT/wq2yi5Xk/+fI=;
        b=nHA3U3WsN7mOTeoNeolfMS8TaMNQHYvssmz4Bz1fZaSuZgBr0Dpr2nPpNb06gfzyw2
         m2XglHuFzsyM6eMA33z1GFsrw/LgmiV8+TDJNTl2BJ87DVGjyixDsbvguNWxZHxIJz2Z
         VBT5UwqvqfoKBbdQXHfGT/cqMVCsmtQBTSRfpJhl4OGgFlJl01sqY6P3Oco6Sks4lsDF
         u4q71fA9wwa6Y3zkbLIcvWgUmVUVnaLVnf9WGxmwVOKrJMeQ6iY33gLVVqkX//lOOBt1
         BnLQHgnRWJMGFWB2v/zktoMWsoWBnZXevyitSGwFYS6wa7E5efHudzeyJ7+2wYN8QOLc
         Wz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761288218; x=1761893018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2UFjwfCheMSDPhpGuyj3HSoQ9LJMT/wq2yi5Xk/+fI=;
        b=EdWAfQ3TZHio2d3RHtMtpkoLKq4dFiA1Lm+Z11MpvMLiALt9IWnjXesXlZ+u92Ipkk
         lvWFFk026Kjh5h/Ru4WEapQwhOEDCDMYrR9ds3pHd1eRggrf/6rbqATax/dKGg5jcoym
         YoGZYiNFfVU+BJ5h2FQDrOG70GYM7Nuife+BvL408YaxanKbx/peI5iRiDVWkNtdX/hw
         Nm/Ix3oszr/z4ia2xOx+Oflq+uQDVjMveJpc+Lfp/wTk1fSeY63QdClmnmRf9jOHhTh5
         iVATE8WlajpXNT+hLroYT1FZAeurq/LdSj2YCH9S023LIDcionUjcQlHJe4BpYDFRJrn
         hNOw==
X-Gm-Message-State: AOJu0Yzb446UM8fsHSTJEGxzR8qeNerIZMRJquBTV50P3OI+Nwf4ia/2
	m5LdUH/fLjuYDUBcJwKjHbL1WQfRWeyOJNKh9SANOV25OE4w0MCvDiG827UGZKAdyj15iJfk0Kk
	T75gOCKLHhZV/FHIJlo3egIoauTVAlqzUaFMsZAA9
X-Gm-Gg: ASbGnctPQF/YiEcAYtKyc537S2Eb1FNKfFIBbpfr7EC12L2Rj4f8GXMfLTxwvMXmKr5
	R86eDOmNucWXDH5PCFbTnvZwmyaNQkS83jD264AQfo15jMMcP12XbL0QRYd/LgQ8qraMpscoSc+
	+ZT5U80E13G7Dv+youNX4adH1GT5t7cvg4y9ilFhVk+y/a30K/oAP6KmjgMcPl5t88y8bGUTdIO
	2bRxd5YoOSDUZZzYquH3mqy0qPXbzR040hbcdmQCOLYNfkrZE/UfNFhML3n
X-Google-Smtp-Source: AGHT+IF1HVSnu6HsUGLipnhFezBFZO84eR0OgQFQffQJBEg1eFTIaGcwBZzC2UliCBsgQ5v+CoTvGXzZDqC/JNbTkjE=
X-Received: by 2002:a05:690e:1409:b0:63e:2366:7ce1 with SMTP id
 956f58d0204a3-63f42a200d8mr1145430d50.0.1761288218376; Thu, 23 Oct 2025
 23:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1761286996-39440-1-git-send-email-liyonglong@chinatelecom.cn> <1761286996-39440-2-git-send-email-liyonglong@chinatelecom.cn>
In-Reply-To: <1761286996-39440-2-git-send-email-liyonglong@chinatelecom.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Oct 2025 23:43:25 -0700
X-Gm-Features: AWmQ_blbjdPZKhGT9XBif5vxZmEROBogKMIVtgj_e_I3KnoOsKnizLtuSDPMwUI
Message-ID: <CANn89i+TsY67y-pCkOkJHsh11Leg77Ek7n2-j6X6ed-U20eR=g@mail.gmail.com>
Subject: Re: [PATH net 1/2] net: ip: add drop reasons when handling ip fragments
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 11:23=E2=80=AFPM Yonglong Li <liyonglong@chinatelec=
om.cn> wrote:
>
> 1, add new drop reason FRAG_FAILED, and use it in ip_do_fragment
> 2, use drop reasons PKT_TOO_BIG in ip_fragment
>
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
>  include/net/dropreason-core.h | 3 +++
>  net/ipv4/ip_output.c          | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.=
h
> index 58d91cc..7da80f4 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -99,6 +99,7 @@
>         FN(DUP_FRAG)                    \
>         FN(FRAG_REASM_TIMEOUT)          \
>         FN(FRAG_TOO_FAR)                \
> +       FN(FRAG_FAILED)                 \
>         FN(TCP_MINTTL)                  \
>         FN(IPV6_BAD_EXTHDR)             \
>         FN(IPV6_NDISC_FRAG)             \
> @@ -500,6 +501,8 @@ enum skb_drop_reason {
>          * (/proc/sys/net/ipv4/ipfrag_max_dist)
>          */
>         SKB_DROP_REASON_FRAG_TOO_FAR,
> +       /* do ip/ip6 fragment failed */
> +       SKB_DROP_REASON_FRAG_FAILED,
>         /**
>          * @SKB_DROP_REASON_TCP_MINTTL: ipv4 ttl or ipv6 hoplimit below
>          * the threshold (IP_MINTTL or IPV6_MINHOPCOUNT).
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index ff11d3a..879fe49 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -588,7 +588,7 @@ static int ip_fragment(struct net *net, struct sock *=
sk, struct sk_buff *skb,
>                 IP_INC_STATS(net, IPSTATS_MIB_FRAGFAILS);
>                 icmp_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED,
>                           htonl(mtu));
> -               kfree_skb(skb);
> +               kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_BIG);

This part looks fine.

>                 return -EMSGSIZE;
>         }
>
> @@ -871,7 +871,7 @@ int ip_do_fragment(struct net *net, struct sock *sk, =
struct sk_buff *skb,
>                         return 0;
>                 }
>
> -               kfree_skb_list(iter.frag);
> +               kfree_skb_list_reason(iter.frag, SKB_DROP_REASON_FRAG_FAI=
LED);
>
>                 IP_INC_STATS(net, IPSTATS_MIB_FRAGFAILS);
>                 return err;
> @@ -923,7 +923,7 @@ int ip_do_fragment(struct net *net, struct sock *sk, =
struct sk_buff *skb,
>         return err;
>
>  fail:
> -       kfree_skb(skb);
> +       kfree_skb_reason(skb, SKB_DROP_REASON_FRAG_FAILED);

There are many different reasons for the possible failures ?
skb_checksum_help() error,
ip_frag_next() error
output() error.

I think that having the distinction could really help, especially the
output() one...

