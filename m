Return-Path: <netdev+bounces-112620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834D393A350
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 16:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F51E282216
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 14:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020CF156C78;
	Tue, 23 Jul 2024 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hraJdBZW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E58F155C90
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746656; cv=none; b=FvUe43jpbYE6d009lqqj9ejb3UVq9BcJAiezcthB9eUEC2d8MDNa4qJsWAMoGcLyI9ghSr+291sB9KNGQd9Hs+zLkY/FT1xyDx3HMALhf1oKB+2DCMVMAqqftn/NAi5LtmrWundVjtvQ8qXnLUPQ0Cr5VEDGSZ360EJFbcAnQcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746656; c=relaxed/simple;
	bh=sH+oKqTIFK7IkaA0Xmt9opuLI58w1t/HPBv+1VNwKbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmBZ/TywTwOV5OPT/dvInY1nWllVplGs0Bd+xsW2LKYnT0R7phLpdMQYgcwyG34MWgFxx5CSSn2qh6UMgZdX70531JGI96UqBIaFDwzpwydo6v21Qh2GFLxKtP4tFEuUpSdogQLU+WEUsoxrNCDW9mYCBwTcRjmaQK5WZ+tMPTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hraJdBZW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266f796e67so29485e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721746653; x=1722351453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQ43fQAr02jJECA44HJricXAK+mZSJSCf0eO/0JNgBQ=;
        b=hraJdBZW7yaLp+cqu7gdFI+j7NqHqh4XZxAv6rKIxD9ci6T0gtZRFXfkjQVCmuKtyn
         ezCtMEdXU4lG3DwnF5os4+uE7T5XO/17unRJHnhleWHyA5CF8Ph2J3cqVIUwI1aVgB9J
         xRZRt9p8MQGdsNXjZGUp8Z2QUCQNZkW5pRJKfnXTgksdFZZqwnNd1hxODIZE3s9gPPtM
         y8Y10JwVWDhtZbk7KVhFU+ZWds3ezFp2XSBA0CXtJwZoV4mCgS7rc/mXysmePvKS3zGc
         fko621s2drrXMLK0wAKdhcwe6pIBgj8HbkpUn5Y6XapoLadEn0hwhjyWhSyAR6bGpw9Q
         4h4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721746653; x=1722351453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQ43fQAr02jJECA44HJricXAK+mZSJSCf0eO/0JNgBQ=;
        b=pK437QKYTAK4PgeJcp2J1kLTpfzZF2vl1D7r7n0iu1hxTmTUsyOiVV8KIyHO5QFpGL
         dtQ3Qt6f/CX42uf5zLAYtbFbE9W3r8XbzA8IJea/XublmZEDD+adh76cF5L6foC9n1uu
         Yz5O2aJVNfGv1p4t4h9i3EFg3koDTnjjPSbwldxKy+Qdb3BnTB6xcBj1hY1XOuwsvZjh
         KwgSBHZjX9hituYkgsL0a8mc8ugpn9mq/U/Dvx3ZXPZNueVL7qQaOfJiVePsMIhECAd9
         cI7jj8bHBB3G/Cjah2Q45WlzpTpbBMpQFmWb1DcjGPXA+AVijMfxunbX9YrBczTF+BeD
         pluA==
X-Forwarded-Encrypted: i=1; AJvYcCXiGI3SmXHlfarrpMhuwTQpqDdYoJ3GfKv3SoRetOLv0w5piEPIISTNV3i3kTuU2qmhWl/6ccuL/55VTaHwuxQvR903Mw1a
X-Gm-Message-State: AOJu0YyQ7yLCkFITvxwgmnDpFNMu2JHOIUaxFsR69JLUCQWS7hAiAPIu
	Cd9aP9UB3rJ9InmCcCCXdq64wxo236bw34SVFg3H75y8AA/mJ0K+DFBubUeXcpLL4xVycbz+p2f
	+wTX/79x0oL+4ceIT6se+Zio3binyX+bt7VOI
X-Google-Smtp-Source: AGHT+IH7RJ3CsE0EWCiqMn8hBvb6RGv/dyt/qpHwJ0gCqBFmK3PZ/l+b4/NJMRXwTm585j64SQrzJa5D6LWk1e81dy0=
X-Received: by 2002:a05:600c:1d0a:b0:426:8ee5:3e9c with SMTP id
 5b1f17b1804b1-427dbb47c03mr4634445e9.6.1721746653220; Tue, 23 Jul 2024
 07:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723135742.35102-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240723135742.35102-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 16:57:19 +0200
Message-ID: <CANn89i+dYsvrVwWCRX=B1ZyL3nZUjnNtaQ5rfizDOV5XhHV2dQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: add an entry for CONFIG_NET_RX_BUSY_POLL
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 3:57=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> When I was doing performance test on unix_poll(), I found out that
> accessing sk->sk_ll_usec when calling sock_poll()->sk_can_busy_loop()
> occupies too much time, which causes around 16% degradation. So I
> decided to turn off this config, which cannot be done apparently
> before this patch.

Too many CONFIG_ options, distros will enable it anyway.

In my builds, offset of sk_ll_usec is 0xe8.

Are you using some debug options or an old tree ?

I can not understand how a 16% degradation can occur, reading a field
in a cache line which contains read mostly fields for af_unix socket.

I think you need to provide more details / analysis, and perhaps come
to a different conclusion.

>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> More data not much related if you're interested:
>   5.82 =E2=94=82      mov   0x18(%r13),%rdx
>   0.03 =E2=94=82      mov   %rsi,%r12
>   1.76 =E2=94=82      mov   %rdi,%rbx
>        =E2=94=82    sk_can_busy_loop():
>   0.50 =E2=94=82      mov   0x104(%rdx),%r14d
>  41.30 =E2=94=82      test  %r14d,%r14d
> Note: I run 'perf record -e  L1-dcache-load-misses' to diagnose
> ---
>  net/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/Kconfig b/net/Kconfig
> index d27d0deac0bf..1f1b793984fe 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -335,8 +335,10 @@ config CGROUP_NET_CLASSID
>           being used in cls_cgroup and for netfilter matching.
>
>  config NET_RX_BUSY_POLL
> -       bool
> +       bool "Low latency busy poll timeout"
>         default y if !PREEMPT_RT || (PREEMPT_RT && !NETCONSOLE)
> +       help
> +         Approximate time in us to spin waiting for packets on the devic=
e queue.

Wrong comment. It is a y/n choice, no 'usec' at this stage.

>
>  config BQL
>         bool
> --
> 2.37.3
>

