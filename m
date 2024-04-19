Return-Path: <netdev+bounces-89506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BD58AA6F8
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 04:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D54282E1C
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 02:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0744CEC2;
	Fri, 19 Apr 2024 02:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qwo/o9Am"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506C737C;
	Fri, 19 Apr 2024 02:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713493888; cv=none; b=bUWSZoTiH4cDocy/X8JiUHAwt+o99d0cOA5O5zL7rGL4wpF49+XfszIu0rtrOHabdwIy7fY/CyvyQce9udfrY3a8uzU1drnyoXndNwNj4FUS3lXut4wAP9rMPY2TtvVBVw/rdRGmCtr4pTSOZ8Xr0LMxNyKJ14qliaT7C7z7avc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713493888; c=relaxed/simple;
	bh=k7YCvT9S1zPWE6gr7w35gMD+gW9CyioUt9kwY/OI7kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTThklTwAnUvC/xLz5QimTpuAs8XLKdG5T4ZqKxlYMVgKY7Fgainmpuqwz3LSzNdUSff8yEJpGJLcNYTZpAFnnGJTfvH35P5TzUV9PxMMDSik5lpIw0dLG0k7JylRG0ewmL2B1t2svMynwSfAhqOD1orietYk4Rd/0K8z8NB+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qwo/o9Am; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a51ddc783e3so174494166b.0;
        Thu, 18 Apr 2024 19:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713493886; x=1714098686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4FFDf630SIm2RKLsFh02a/UIvtxYS7bnxqS33DUwxg=;
        b=Qwo/o9AmXCZ7aB9ua5O5WI3QQ/6yMZHUE1XqyEd3A37oPvxo6cabIyTH5BS8UsbeAr
         voiKOjZLVY4YGGmLGkEa4Iswh9EFn3nvc/Qaf723oeHR7qclg+y/NSYHb1FGGgZj8MyV
         wpkp7PcnPI07v3y3q0/9JQxlKoq0uCbtUp8Roqx8nsBhorNxlY3SUB6nCpkzIn7yS4Rw
         PZ2pe62CLDFNSgwG6uGDlqKR7bHaGL0rP9NCaIf4YvrAGQl0/ahu5mRAnpcIzM9eBG3N
         3mlkR0/8h+ZkqFwQmokCTSGKVW6gk4tQA1jKgq0EjCm8DIv7doexPb7AWovYuWDpCFFY
         7alA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713493886; x=1714098686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4FFDf630SIm2RKLsFh02a/UIvtxYS7bnxqS33DUwxg=;
        b=po6QVbzFEGAUrSgQDsKc7pLCYPG3H/xoQlZw2k4hoWp88pNa063Ym/iJnx198VtakF
         moLuPKZf4TS/lesEH8Bjqgh671iwh1hs84+Lo+q85q34jaccrV/reLahypFT0awlxETN
         T3mUlbnDvFP+0g+ueZQQNDAtUhMnKtd4A0Ugg+IECrXQmHoK3G/bCDzbXDwzdbSMOTXb
         pYxizIX/JqzxNJobTEUV3Ge+5X0MHk3A5hgzoCJ0YY7zCqPAX2H27QAnZ2PJtr9L5MJV
         gW3ehI21bpyE0C3EBaNHtAuQ6+P5joIoPkHrmz7LnvDgoW5un/jqk6xDeIRB5ENok7Dy
         /q0A==
X-Forwarded-Encrypted: i=1; AJvYcCVWAV8X5cY2OCb0hROrl4TBZVXp6SGKppBzhEO8WmcYvr643xhx4apULVJlwWO+o2EuG3GAFWpZEZUwlaqoAAFFClo8sze6o5Qhg/fBVxpZGZpGtl9a6EJXqgoRDo1jccqlRi/gG3hPjqBY
X-Gm-Message-State: AOJu0Yz/0nvvKGy2qKNK6pSXOdAig79A0qzUZVsJ+SGfRjRoyEBysC5X
	dC/+NW744srGnO7OIi6YdnkcAkhGBkCx/Apcer0Xoqr23EytjSucBnPl7gu7gsdpDSTshVuwBEC
	fHPEfvUSUCCKYypkXaIh/9WjLj6Q=
X-Google-Smtp-Source: AGHT+IFH6g6Zj3ciCGagpT+fKvYUkgSx3d4QE29JqmK/DoLeEGjr/xqSvuzZuP0Em5cIHLh/cKGosTj5Zc2x2u9vnKY=
X-Received: by 2002:a17:906:30c8:b0:a52:5789:9c5d with SMTP id
 b8-20020a17090630c800b00a5257899c5dmr469091ejb.39.1713493885421; Thu, 18 Apr
 2024 19:31:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
 <CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com>
 <20240418084646.68713c42@kernel.org> <CAL+tcoD4hyfBz4LrOOh6q6OO=6G7zpdXBQgR2k4rH3FwXsY3XA@mail.gmail.com>
 <CANn89iJ4pW7OFQ59RRHMimdYdN9PZ=D+vEq0je877s0ijH=xeg@mail.gmail.com> <CAL+tcoBV77KmL8_d1PTk8muA6Gg3hPYb99BpAXD9W1RcFsg7Bw@mail.gmail.com>
In-Reply-To: <CAL+tcoBV77KmL8_d1PTk8muA6Gg3hPYb99BpAXD9W1RcFsg7Bw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 19 Apr 2024 10:30:48 +0800
Message-ID: <CAL+tcoAEN-OQeqn3m3zLGUiPZEaoTjz0WHaNL-xm702aot_m-g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/7] Implement reset reason mechanism to detect
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 7:26=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> > When I said "If you feel the need to put them in a special group, this
> > is fine by me.",
> > this was really about partitioning the existing enum into groups, if
> > you prefer having a group of 'RES reasons'
>
> Are you suggesting copying what we need from enum skb_drop_reason{} to
> enum sk_rst_reason{}? Why not reusing them directly. I have no idea
> what the side effect of cast conversion itself is?

Sorry that I'm writing this email. I'm worried my statement is not
that clear, so I write one simple snippet which can help me explain
well :)

Allow me give NO_SOCKET as an example:
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index e63a3bf99617..2c9f7364de45 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -767,6 +767,7 @@ void __icmp_send(struct sk_buff *skb_in, int type,
int code, __be32 info,
        if (!fl4.saddr)
                fl4.saddr =3D htonl(INADDR_DUMMY);

+       trace_icmp_send(skb_in, type, code);
        icmp_push_reply(sk, &icmp_param, &fl4, &ipc, &rt);
 ende:
        ip_rt_put(rt);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 1e650ec71d2f..d5963831280f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2160,6 +2160,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 {
        struct net *net =3D dev_net(skb->dev);
        enum skb_drop_reason drop_reason;
+       enum sk_rst_reason rst_reason;
        int sdif =3D inet_sdif(skb);
        int dif =3D inet_iif(skb);
        const struct iphdr *iph;
@@ -2355,7 +2356,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 bad_packet:
                __TCP_INC_STATS(net, TCP_MIB_INERRS);
        } else {
-               tcp_v4_send_reset(NULL, skb);
+               rst_reason =3D RST_REASON_NO_SOCKET;
+               tcp_v4_send_reset(NULL, skb, rst_reason);
        }

 discard_it:

As you can see, we need to add a new 'rst_reason' variable which
actually is the same as drop reason. They are the same except for the
enum type... Such rst_reasons/drop_reasons are all over the place.

Eric, if you have a strong preference, I can do it as you said.

Well, how about explicitly casting them like this based on the current
series. It looks better and clearer and more helpful to people who is
reading codes to understand:
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 461b4d2b7cfe..eb125163d819 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1936,7 +1936,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *sk=
b)
        return 0;

 reset:
-       tcp_v4_send_reset(rsk, skb, (u32)reason);
+       tcp_v4_send_reset(rsk, skb, (enum sk_rst_reason)reason);
 discard:
        kfree_skb_reason(skb, reason);
        /* Be careful here. If this function gets more complicated and

Thanks for your patience again.

Jason

