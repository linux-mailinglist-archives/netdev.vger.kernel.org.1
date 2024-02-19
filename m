Return-Path: <netdev+bounces-73005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC5185A9D4
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0191C21FB0
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FA344C93;
	Mon, 19 Feb 2024 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sL45fs6s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA17446BD
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363328; cv=none; b=HL0Bj1xeEzK6Kl8o8m2nbVj9k2ZacDs/naAXFiCXDT57THaJytvnP2SbSq2oU5KupjTEJUHYZAos2gRRkEbcGmVUSg3jrhgif2q5tArNT+k5UCC+ulq9Ig6T80pZc1lW/m0Yu/QPzRupLNlQKRfjKPlPqk+W2iJQ0JUY+Fwy27c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363328; c=relaxed/simple;
	bh=D4hbJX7uGV8vohd/O7pYTtYq3FdJW6tASIcFVTSogHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGYzngy6JhxlfvY8bE+2xJ5dY44aJhfIZ7ZMDQy5f56k67qnxGO4NIARmzb1yXRDNQCPXhwLBh1xyAiABTJyN5XbAmwrmoLnJB4zGLI7n+p3sxJ37TM7x2eAkswPjzX9JGGNQXpU/+mHhNzvTAGXI1/rNdG30G5aKcGJWeqpudA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sL45fs6s; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4126149228bso74175e9.0
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708363324; x=1708968124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzE2ImKo71OrGpPwUdYL/4pHbPBLfbVgHi0cr9m3U8k=;
        b=sL45fs6sLPjwI75d4uFu8XxABRB/V521bZaKwne7qpuU6wrVTEUIA4UD0hzj9EP1O8
         B1KKCZt+3VgGoF7Eo2IK+Ni47YoRntvhkFlPY+A30st5Hr1LZsE870leOriwliLFM4QA
         31E+8KBHTjFLEA+KJaLBmftERuQMO0lMH4rO1dbFlAFgXkw+cHn0FrNw8SCEU0nZGulC
         SwhH+okvFFFS5sgOktS/IHc3YZD6XDQ/hCp7YNUskEC815Xaf5V69Ae0BrsidNm/K/am
         V2+XY8s87cXVXfMS1wl6/JChlHQIJQT+srZdiZQmJw+uP/TycvNIHtGv37Skm41h4kit
         Ly3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363324; x=1708968124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzE2ImKo71OrGpPwUdYL/4pHbPBLfbVgHi0cr9m3U8k=;
        b=oEwhhYFO+d2Qo44aAT2JV747DTDScvKoV5mxG+Z/WYKWxDxY1QSId5iX1x0w/L6W2Q
         /hj26hSZe+B2TiXQa5CLlYy4nD3ilWjB25TzayXe0vJk5UkqHSPuvA2f9huFR/Znv9CZ
         8zpfamW6tQM13e4Gk/PqQwT9ti18l9EXywcyyqrWlvbpoxrmYJa162Xn4TX0DNRntCPt
         5jbChTmjlq4hHIsQl+O4T5jFWbAv87ZQZ09OpYEX0WaRNZ1oLKAO6uDlFJnbHvROLzTk
         fmEtDN7606UISzxBdeSpilciN+Cho9gDnTeq3nAUOHgFxdAWoOBbnnxvLgRVK4x7MK47
         OcFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlTrwoIkG95ufauFnc398D+hVJGz2WUfEKiHPw7jsNq3ISdKQhTttRrzf5IuPVKNlKlNn5g+J02Qi0AX9HeJqWXSXIXH2N
X-Gm-Message-State: AOJu0YyHBWhzXbdxss7y02r2bb2AsIsiu/HvP13lKBFVw9Ntfx3OhckR
	qT22RwgK2VagHZxLu330TQmPYsrqNz8IotPRuwbe0JzBWz7v4GHiOdJ5WFuUk3QlIf83z5Uxhd+
	0YxZcf5J2DER14o1gHzppG4FfFhFxwUX7g0bp
X-Google-Smtp-Source: AGHT+IFtUO3gJmAv9pg3NVlt8jW79fOGFR/YkJjU3AyGWJK7/hjLBpWxiTYoMfGOwmlNssRqFlRN3PKW2DohJYoHKeM=
X-Received: by 2002:a05:600c:c08:b0:412:68a7:913a with SMTP id
 fm8-20020a05600c0c0800b0041268a7913amr116160wmb.4.1708363323800; Mon, 19 Feb
 2024 09:22:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
 <20240215-upstream-net-20240215-misc-fixes-v1-3-8c01a55d8f6a@kernel.org>
In-Reply-To: <20240215-upstream-net-20240215-misc-fixes-v1-3-8c01a55d8f6a@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Feb 2024 18:21:52 +0100
Message-ID: <CANn89iJ=Oecw6OZDwmSYc9HJKQ_G32uN11L+oUcMu+TOD5Xiaw@mail.gmail.com>
Subject: Re: [PATCH net 03/13] mptcp: fix lockless access in subflow ULP diag
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Davide Caratti <dcaratti@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 7:25=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Paolo Abeni <pabeni@redhat.com>
>
> Since the introduction of the subflow ULP diag interface, the
> dump callback accessed all the subflow data with lockless.
>
> We need either to annotate all the read and write operation accordingly,
> or acquire the subflow socket lock. Let's do latter, even if slower, to
> avoid a diffstat havoc.
>
> Fixes: 5147dfb50832 ("mptcp: allow dumping subflow context to userspace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>   - This patch modifies the existing ULP API. No better solutions have
>     been found for -net, and there is some similar prior art, see
>     commit 0df48c26d841 ("tcp: add tcpi_bytes_acked to tcp_info").
>
>     Please also note that TLS ULP Diag has likely the same issue.
> To: Boris Pismenny <borisp@nvidia.com>
> To: John Fastabend <john.fastabend@gmail.com>
> ---
>  include/net/tcp.h  | 2 +-
>  net/mptcp/diag.c   | 6 +++++-
>  net/tls/tls_main.c | 2 +-
>  3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index dd78a1181031..f6eba9652d01 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2506,7 +2506,7 @@ struct tcp_ulp_ops {
>         /* cleanup ulp */
>         void (*release)(struct sock *sk);
>         /* diagnostic */
> -       int (*get_info)(const struct sock *sk, struct sk_buff *skb);
> +       int (*get_info)(struct sock *sk, struct sk_buff *skb);
>         size_t (*get_info_size)(const struct sock *sk);
>         /* clone ulp */
>         void (*clone)(const struct request_sock *req, struct sock *newsk,
> diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
> index a536586742f2..e57c5f47f035 100644
> --- a/net/mptcp/diag.c
> +++ b/net/mptcp/diag.c
> @@ -13,17 +13,19 @@
>  #include <uapi/linux/mptcp.h>
>  #include "protocol.h"
>
> -static int subflow_get_info(const struct sock *sk, struct sk_buff *skb)
> +static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
>  {
>         struct mptcp_subflow_context *sf;
>         struct nlattr *start;
>         u32 flags =3D 0;
> +       bool slow;
>         int err;
>
>         start =3D nla_nest_start_noflag(skb, INET_ULP_INFO_MPTCP);
>         if (!start)
>                 return -EMSGSIZE;
>
> +       slow =3D lock_sock_fast(sk);
>         rcu_read_lock();

I am afraid lockdep is not happy with this change.

Paolo, we probably need the READ_ONCE() annotations after all.

