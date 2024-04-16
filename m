Return-Path: <netdev+bounces-88195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D88A8A63CE
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 08:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEEB71F2197D
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 06:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A876CDCE;
	Tue, 16 Apr 2024 06:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VHU4djId"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFED36BFC2
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249218; cv=none; b=adolGaEpRMjPoY6OWSUytDbVujXXZX8abUNtfPqf5bbu3HZj93s02h89L4tiepwCRO2YGTMCngbqQRl/5eK0V4UnVunK1yAfONoz7wUihYFwpcQwH0FTaHzFzpFl9LiNebK9bB//5ve9VcIV2OLRO4yFfIUthUm0sl1PKZiI7rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249218; c=relaxed/simple;
	bh=WTHD2jkBkYrza/7xYMvE4w1MhuQ+PYI0kMjvR0fKQOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4ao9EYZezZYiXJYS5VXVdGhUTNZX+3b5n3N7yBgxcu/CT71115iAVEGLREviY4A7MlAnnanFaENbXFoFHkkbbgmYM/bPV0r6xMCzS04NAmchb2HLWGCy7IlGiwIWeG1wv4pvOkWfRZE3y0jEWidlryMmOm6XVEklCrK0s421bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VHU4djId; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so6433a12.0
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 23:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713249215; x=1713854015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhHm+pw/eRdnVPPPueSNaVg7FoAccIkjt6byD6hNEeI=;
        b=VHU4djIdFKtJUOqB/+lQ+Bi/HVaCItT1iVl+4FBmoj47xdhA+NCgj27r3SdFNEnWRk
         BKgzHW6h3YP0zAZSZuQOFHmGVtmyb9n7+/fQERAaEd0Tslt7KrJnjX1Pt+K7uugeHdwF
         DrRImEc5206pWwl3jG0+YPDAWbhoctKO+3U84eYeelOFUDv1zmK4EraSVb8Fjtm4KntA
         i8wBOryXGSqFuA22HwGLrAhUWnpUwOJu+kmPasc5dijpVbCMhTDvc8zmMtI0OUJDuFBW
         uQhrMi73H8OBarTLKSPBCRwkvB8Noe70sNYBkLXNs4SzQggTYlmV8ubF/s/ELadCwZL6
         homg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713249215; x=1713854015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhHm+pw/eRdnVPPPueSNaVg7FoAccIkjt6byD6hNEeI=;
        b=kbUsZfQdVl/nTiNb1nV8aEUnESw8hgBERYvbgAyY8IwgS3+NvGvokb8Hm+XukAbWfq
         4v6iPJmw2at8VNveqg69ExPBgOuguZAzOoJzz08NFL0XsKpk/j9pgza51ero33k8kmNc
         5B8NDpA46kqKVJ+eZaDhG7DzAJrMD+ngaIGZwQSFJbsHLg/JZPNlMo+71SWzo7dXsNAm
         izCasGcgMNEqbQf+UgAGlxaDDizR+mNxnwV/gWXhxZNiOQYBcAgpQcuGUXp8Cm6KwhWi
         36gd9LRnHu+W2XDFP5C+bmff6tn/ifEUM+nZjpRV/lk0kt7l93MDnkSE85iE8sj8H+hm
         uLsw==
X-Forwarded-Encrypted: i=1; AJvYcCVZYJrlByU+qcYVoz4DUBhRzud03rVT7eyC4UVPfI6RqlpT/6CkWq8UZf8g1gubo/rKSibfNYoJE7tdoN0X/snr05ptNGDl
X-Gm-Message-State: AOJu0YwSvAqDjwWiC//UJWrGIgIbG8HXAGgLAbOV8p4vzQMZrDQcNQZQ
	KK+o9uBMc+RQX7O/IBI6CVc0tCNfdreMXmXWxONg2vhKvES+HBfKINKGbUvD6Hq8Ry5jwNV2qyb
	E3O/wesi38oh05UMyLfSPCkVfQGeOG712VV+y/yvGwbdrJOKQmQ==
X-Google-Smtp-Source: AGHT+IFOt/KxCo19mR4iJkdl9hLPS2U2D4EmWT2c3QSG6XWl+TkYdWlRgqhHsRnMUjV/CcwRSqwsTD1xVC/nQR+vNlI=
X-Received: by 2002:a05:6402:8c3:b0:56f:d663:cfd9 with SMTP id
 d3-20020a05640208c300b0056fd663cfd9mr77869edz.1.1713249214893; Mon, 15 Apr
 2024 23:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411115630.38420-1-kerneljasonxing@gmail.com> <20240411115630.38420-6-kerneljasonxing@gmail.com>
In-Reply-To: <20240411115630.38420-6-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Apr 2024 08:33:24 +0200
Message-ID: <CANn89iKf7yOUY9XA3M+Sbxhit5grH0PtJ8qyJt5gJHNaS7EHVQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 5/6] mptcp: support rstreason for passive reset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 1:57=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> It relys on what reset options in the skb are as rfc8684 says. Reusing
> this logic can save us much energy. This patch replaces most of the prior
> NOT_SPECIFIED reasons.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/mptcp/subflow.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index ba0a252c113f..25eaad94cb79 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -308,8 +308,12 @@ static struct dst_entry *subflow_v4_route_req(const =
struct sock *sk,
>                 return dst;
>
>         dst_release(dst);
> -       if (!req->syncookie)
> -               tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NO=
T_SPECIFIED);
> +       if (!req->syncookie) {
> +               struct mptcp_ext *mpext =3D mptcp_get_ext(skb);
> +               enum sk_rst_reason reason =3D convert_mptcp_reason(mpext-=
>reset_reason);
> +
> +               tcp_request_sock_ops.send_reset(sk, skb, reason);
> +       }
>         return NULL;
>  }
>
> @@ -375,8 +379,12 @@ static struct dst_entry *subflow_v6_route_req(const =
struct sock *sk,
>                 return dst;
>
>         dst_release(dst);
> -       if (!req->syncookie)
> -               tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_N=
OT_SPECIFIED);
> +       if (!req->syncookie) {
> +               struct mptcp_ext *mpext =3D mptcp_get_ext(skb);
> +               enum sk_rst_reason reason =3D convert_mptcp_reason(mpext-=
>reset_reason);
> +
> +               tcp6_request_sock_ops.send_reset(sk, skb, reason);
> +       }
>         return NULL;
>  }
>  #endif
> @@ -783,6 +791,7 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
>         bool fallback, fallback_is_fatal;
>         struct mptcp_sock *owner;
>         struct sock *child;
> +       enum sk_rst_reason reason;

reverse xmas tree ?

>
>         pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, lis=
tener->conn);
>
> @@ -911,7 +920,8 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
>         tcp_rsk(req)->drop_req =3D true;
>         inet_csk_prepare_for_destroy_sock(child);
>         tcp_done(child);
> -       req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
> +       reason =3D convert_mptcp_reason(mptcp_get_ext(skb)->reset_reason)=
;
> +       req->rsk_ops->send_reset(sk, skb, reason);
>
>         /* The last child reference will be released by the caller */
>         return child;
> --
> 2.37.3
>

