Return-Path: <netdev+bounces-96976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA63D8C8839
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 16:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7FB31C237BC
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 14:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309A41A2C2E;
	Fri, 17 May 2024 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vCnJ+/Uv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B26399
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956947; cv=none; b=CZbIVmAX5xtXY8XHM3a9UI6aK7aAXDyAv4e3TUYND/9grNlLtQ96CT9SRo+cI+fnJzGKgtIDbM00T0ukQydI0nMJSnL7GHQmNM53SAjtAy3C/eRV3Jpmr1qNFV2VfJCG2S9PxOOG/fBLSokZKEFNY2eIYZZGkqzKNkxg0NmXLSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956947; c=relaxed/simple;
	bh=ibSlwJS/xLQTxRE6+nhrgDFVHxT8ns7GhMClbT1AoNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UoZ87S64ENQL+KbTLg3aDH3EpZb/uCsbvxroKkb3WbPVQuDFW7CZ68sm/Juz0/383VmjjtVVVQ3DqW5CTDadBEOowQ7Ay4rtiIRC0NBI13hrjc18WHClX1k3gf630/cGKO4aPuRSIlEon7RhGtw5lyUTVN+K7Z8RMvB2e1asRYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vCnJ+/Uv; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-47efd204baeso36702137.3
        for <netdev@vger.kernel.org>; Fri, 17 May 2024 07:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715956944; x=1716561744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/Y42Q4cTcacy9xZmErwJ9Nk8cQMAhDtmPLEq95nkcA=;
        b=vCnJ+/UvhXlbKuOSj8FWM4aKjvsyngagiVLkwok5MHUyab4Ai0J0fYtFdfu18qmIuX
         Me3twv2h/Mt8ZREfEfMBpnY7DkOKeNZQljnle0yNa/5Z97ZsMt0xomABMpshm6yGepdD
         oDOu9RfSMOV9LzXkUP0ICVHEaiYdDe5TWGgiG0S0Vk/lYE6d5z8UfO22dWGd8uIPyHbN
         FS7IOXbUTG5nKtpW+7MMiWbTQ60mBl0eUS5q2o1BINuMuNxkJS/tahNdoMZ5OfsNrxPP
         L5Bon316reknpeRkpANJV3BfqLX6Jtc+/iF5KcKxNpc5Wh5HBDa8MP2ADkK8fdOv9SpN
         Ph0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715956944; x=1716561744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/Y42Q4cTcacy9xZmErwJ9Nk8cQMAhDtmPLEq95nkcA=;
        b=rklhh+uyQtmitJ2J8nXNcZRZbxOIlud2OCfSft7d41S6QvNYN8IWfpQMYsO+Ifp+CT
         zOI9v6AJJZ+Is5bHYshUOfye1Krnx9EqEene8hEvreCZzc20VNWmvgAPpw4nTroe8KiY
         DDWkXQGA5WAktmsobZIR8uNuxVHapGTzHa18EUcl6yekkD/rcTgrrfrGMzgS+7Doc+Ry
         QpW7GJCYOG6sgDC25s+Ck5MVUvER6PEuLyPhNu8khRlyqzuZq28y0NQ8mQWXja9UHRZE
         C0c0mOCOOlCj+zJRH+iXX0edtFy+VuCbfqIJNT/VuiW+dNnupLrRcHqw3hw9V14Iqgne
         SjMg==
X-Forwarded-Encrypted: i=1; AJvYcCWXD+szeCZRUIdzIL7H0n+nglWieRuMYAwcU/gmb0LgghgllC7C5aertF3/r1o+RE5O1mFgvfBVsjMYYrEma5Z/wJUxHiiY
X-Gm-Message-State: AOJu0Ywb+97qNsLm2YaAyIO90txZ4HxAuvxSSqqoKxZP+ihrIykhIMLd
	Z8BnAM5M3Zro7rtl+K9Du0KKkEmtwiDqpJQK4vMqmv5SkRrA66cy15T3IyiDjO9nPkfjJ1fPwlj
	hoPkSvmcrB7u2oOsuZb5pL7zKGkjie6JTxgEz
X-Google-Smtp-Source: AGHT+IHXmZJWp/9+KqHlOTH0i3dBz+cOyec50dBBwXp04uQH3j7PN8Vwvziba1f+1X98Xu53tdbUdbhB63WhkdB6vzo=
X-Received: by 2002:a05:6102:14aa:b0:47f:2c10:24e2 with SMTP id
 ada2fe7eead31-48077e5bfaemr25400905137.28.1715956944279; Fri, 17 May 2024
 07:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517085031.18896-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240517085031.18896-1-kerneljasonxing@gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 17 May 2024 10:42:01 -0400
Message-ID: <CADVnQymvBSUFcc307N_geXgosJgnrx4nziFcpnX-=jU7PronwA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] tcp: break the limitation of initial receive window
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 4:50=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Since in 2018 one commit a337531b942b ("tcp: up initial rmem to 128KB and
> SYN rwin to around 64KB") limited received window within 65535, most CDN
> team would not benefit from this change because they cannot have a large
> window to receive a big packet one time especially in long RTT.
>
> According to RFC 7323, it says:
>   "The maximum receive window, and therefore the scale factor, is
>    determined by the maximum receive buffer space."
>
> So we can get rid of this 64k limitation and let the window be tunable if
> the user wants to do it within the control of buffer space. Then many
> companies, I believe, can have the same behaviour as old days. Besides,
> there are many papers conducting various interesting experiments which
> have something to do with this window and show good outputs in some cases=
.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/ipv4/tcp_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 95caf8aaa8be..95618d0e78e4 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -232,7 +232,7 @@ void tcp_select_initial_window(const struct sock *sk,=
 int __space, __u32 mss,
>         if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_workaround_signed_win=
dows))
>                 (*rcv_wnd) =3D min(space, MAX_TCP_WINDOW);
>         else
> -               (*rcv_wnd) =3D min_t(u32, space, U16_MAX);
> +               (*rcv_wnd) =3D space;

Hmm, has this patch been tested? This doesn't look like it would work.

Please note that RFC 7323 says in
https://datatracker.ietf.org/doc/html/rfc7323#section-2.2 :

   The window field in a segment where the SYN bit is set (i.e., a <SYN>
   or <SYN,ACK>) MUST NOT be scaled.

Since the receive window field in a SYN is unscaled, that means the
TCP wire protocol has no way to convey a receive window in the SYN
that is bigger than 64KBytes.

That is why this code places a limit of U16_MAX on the value here.

If you want to advertise a bigger receive window in the SYN, you'll
need to define a new TCP option type, and write an IETF Internet Draft
and/or RFC standardizing the new option.

If you would like to, instead, submit a patch with a comment
explaining that this U16_MAX limit is inherent in the RFC 7323 wire
protocol specification, that could make sense.

best regards,
neal

