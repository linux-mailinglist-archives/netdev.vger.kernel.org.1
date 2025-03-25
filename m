Return-Path: <netdev+bounces-177318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E243A6EF0B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1448B7A1E35
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D969254AE7;
	Tue, 25 Mar 2025 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xzDGFc8B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546252561A2
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900996; cv=none; b=TAzUOWhkxaelMUEuczGuKGJG+Hvh5gNZj+Gvq0wTefFLX8mv3HyjGjuFZMlJB92XURyHZBnfljGQk2XG4LmpFmPNnEVIx+qy21wF/isTFM8S8heTBsdN5KgKlyw/4ynFnMRsymjrol1ERykEvTYufjt4adRuIi0cUr6OZZ6yQ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900996; c=relaxed/simple;
	bh=5m9GRbRjglRDakQaelVV219IbB7/oiKnd1s77kJAUFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0QTKRJ0ivpk6L8hGNOwRZfCs/aNSpGJx86e2xGYWS85W2djIV8NeYuld7O8Ey147dFQ63Hyo9NN2TudZcR/mi4Tz7RjmuepPj/Xmq6y2tC/Gg9uTNbiiBDNmN9TA7xUxyRwph4d+qTICTXFskAkMEKSfSo66l8xmyOtYqLBZJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xzDGFc8B; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47686580529so52277391cf.2
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 04:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742900993; x=1743505793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6lKJC2tfbfHtPe5PLrFvcl04RkwZzKt1dtg6uU63AM=;
        b=xzDGFc8BkxIvPhXA1PScP6qLLc3ZK+FQovRrK9HxYNFtgozDJI1+SauDUf9DkVOvI/
         N7B7zOBze+dwPNZjaPni6IirRTApIujBeafI2cJrHk0Fcvk3/Xt8r9xQe2CweFbMsVRm
         DxPP77JUB3b7tgUmmegt8xyHRn16wQQeFeCPqTivaOOYn67clOncMPZC3uvebBYHBOnQ
         IcqK0guKBQ3azKfMoybswHZdKf2egAQv/1Vgdy4CB5lCCQsSrSIN+Av4Mz+KSeJZtnZw
         8AmWJs1BB/REzY7uSXOVZedzHj9iPcEaBAXxHcd79pzYsXS602/RRp+7PxdQ17z+Aka5
         dlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742900993; x=1743505793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6lKJC2tfbfHtPe5PLrFvcl04RkwZzKt1dtg6uU63AM=;
        b=ItfSea/2XRAIkXgamZhAX6ZpHtr6BDIXH8Yb7Dpj90Yl79Fv+NAnXJdz9x3pk27sTO
         9g2QvmWkfkmmjufQZAjQBRuOOJZqqgp79SRcjf0b+zg85xM1TjFKyBPBxRdzdKTroYtS
         4MKEA83xi5Q/xZqUH63vvdRfmeMnxxE4YgUnFUn6wmKhgQ3Pe6mMlcpRdHJuVEEV72ss
         uakmgprq4VPg7YYVag3S1Fhm26iCpCddnox+t0XKGz4FdZXOq9uEzZRUykSRA9PA/wSs
         i2spyC4AOi/VAiwE8n9IKyMWIBlS4egMi96DRe/sle68fCjor/usJ4/EpUpzuPt8EWMg
         CwEA==
X-Forwarded-Encrypted: i=1; AJvYcCWzDo4G/1BCa7Cn79ZDbcOvWuf1lYkxPt6/2k6i2QB2Y31OZq5XLy0bgosf0WnV3hP7XI38KyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDLDtNPU66KRuA6BH5FbyorD91VE4MGCBoVpYqJcn3S3lDtcOs
	BbHwnIHICpAnfxiXd4uktoxxWMplwk1Yn/RM7gPeHdlDI2+wbXC1zhdGEYsn9CxmYUIQ97n1TOn
	cxw4mP+I6xw26RgHt08POstO8rn1xSyrEfAWx
X-Gm-Gg: ASbGncvHprSI5ZpIH6Sw/N1B9CaYCHqY0iVQGGjUR2zWarNpwbcPWLfqtkeVBablJUD
	oqTQUGkOcA2sEUErSrZHaTZ6tsUXcrvfeafrb7+nEl3IK1kg9/7r2eZfygtFBJGh/chZi48ognX
	7sBLi04OMw6+wunPYS3paDIWHaSfcpxqpTjD9F
X-Google-Smtp-Source: AGHT+IFAxFoWV0SE3tUrMU2ne7ib+IFgo34EBO6SgV5jZX+GCKCK6GKMZaqZmEjWx4XdZufJbao5O0PjYxpxrFjD/rY=
X-Received: by 2002:a05:622a:590b:b0:476:8825:99ba with SMTP id
 d75a77b69052e-4771dd77e0amr258064921cf.12.1742900992917; Tue, 25 Mar 2025
 04:09:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317120314.41404-1-kerneljasonxing@gmail.com> <20250317120314.41404-2-kerneljasonxing@gmail.com>
In-Reply-To: <20250317120314.41404-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Mar 2025 12:09:42 +0100
X-Gm-Features: AQ5f1Jqb8_hPBOjRuEgw6gbtY8jy79tk9nJU2GHpZf2Vdlgq6Hx3JIg510L9g4g
Message-ID: <CANn89iL3E6TtmoNfHziZJbg-8nTZRg8-D3LyFg6g5GLvTmDfaA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] tcp: support TCP_RTO_MIN_US for
 set/getsockopt use
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, kuniyu@amazon.com, dsahern@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 1:03=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Support adjusting/reading RTO MIN for socket level by using set/getsockop=
t().
>
> This new option has the same effect as TCP_BPF_RTO_MIN, which means it
> doesn't affect RTAX_RTO_MIN usage (by using ip route...). Considering tha=
t
> bpf option was implemented before this patch, so we need to use a standal=
one
> new option for pure tcp set/getsockopt() use.
>
> When the socket is created, its icsk_rto_min is set to the default
> value that is controlled by sysctl_tcp_rto_min_us. Then if application
> calls setsockopt() with TCP_RTO_MIN_US flag to pass a valid value, then
> icsk_rto_min will be overridden in jiffies unit.
>
> This patch adds WRITE_ONCE/READ_ONCE to avoid data-race around
> icsk_rto_min.
>
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  Documentation/networking/ip-sysctl.rst |  4 ++--
>  include/net/tcp.h                      |  2 +-
>  include/uapi/linux/tcp.h               |  1 +
>  net/ipv4/tcp.c                         | 13 ++++++++++++-
>  4 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index 054561f8dcae..5c63ab928b97 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -1229,8 +1229,8 @@ tcp_pingpong_thresh - INTEGER
>  tcp_rto_min_us - INTEGER
>         Minimal TCP retransmission timeout (in microseconds). Note that t=
he
>         rto_min route option has the highest precedence for configuring t=
his
> -       setting, followed by the TCP_BPF_RTO_MIN socket option, followed =
by
> -       this tcp_rto_min_us sysctl.
> +       setting, followed by the TCP_BPF_RTO_MIN and TCP_RTO_MIN_US socke=
t
> +       options, followed by this tcp_rto_min_us sysctl.
>
>         The recommended practice is to use a value less or equal to 20000=
0
>         microseconds.
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 7207c52b1fc9..6a7aab854b86 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -806,7 +806,7 @@ u32 tcp_delack_max(const struct sock *sk);
>  static inline u32 tcp_rto_min(const struct sock *sk)
>  {
>         const struct dst_entry *dst =3D __sk_dst_get(sk);
> -       u32 rto_min =3D inet_csk(sk)->icsk_rto_min;
> +       u32 rto_min =3D READ_ONCE(inet_csk(sk)->icsk_rto_min);
>
>         if (dst && dst_metric_locked(dst, RTAX_RTO_MIN))
>                 rto_min =3D dst_metric_rtt(dst, RTAX_RTO_MIN);
> diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
> index 32a27b4a5020..b2476cf7058e 100644
> --- a/include/uapi/linux/tcp.h
> +++ b/include/uapi/linux/tcp.h
> @@ -137,6 +137,7 @@ enum {
>
>  #define TCP_IS_MPTCP           43      /* Is MPTCP being used? */
>  #define TCP_RTO_MAX_MS         44      /* max rto time in ms */
> +#define TCP_RTO_MIN_US         45      /* min rto time in us */
>
>  #define TCP_REPAIR_ON          1
>  #define TCP_REPAIR_OFF         0
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 46951e749308..b89c1b676b8e 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3352,7 +3352,7 @@ int tcp_disconnect(struct sock *sk, int flags)
>         icsk->icsk_probes_out =3D 0;
>         icsk->icsk_probes_tstamp =3D 0;
>         icsk->icsk_rto =3D TCP_TIMEOUT_INIT;
> -       icsk->icsk_rto_min =3D TCP_RTO_MIN;
> +       WRITE_ONCE(icsk->icsk_rto_min, TCP_RTO_MIN);

Semi-orthogonal to your patch, apparently at disconnect() we throw
away user/eBPF choice.

Most socket options, once set via setsockopt() should stay even if the
socket is re-used.

Reviewed-by: Eric Dumazet <edumazet@google.com>

