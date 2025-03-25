Return-Path: <netdev+bounces-177320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5522A6EFD6
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A76166D37
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3501E255252;
	Tue, 25 Mar 2025 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xm1dJWDj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9563825522B
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742901208; cv=none; b=E1fPJuBCcJOWaDtJA0L512DqYZNFjjKB8QZJ+vCOkuU7aIT/tUhKCLN1fui+JA2CgdgQnTRf4T9wgFbG+VJyJkFA9aWcsFC7FNCYAXwrdmRpfljWsJhQHCiAZ1fsO4EX6hAiPrweYOSkWg3hln2z3dk5mKjo1teSV9wQBxZJDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742901208; c=relaxed/simple;
	bh=Q2yxI1Q/Hr9sYuRFxV7HJVN5ZugKG70HYOcnNN2SsQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDIjGY0b9J1HClosWWM2YTWWOyhRprRUPdy3LH+LHwjq8wH8csRUtWhJD8GqFws0sKi9w0xefjuWCjzrBertVS9S2eESg/lqNYA7IiNKQcBbUNgFigSWpu8OnLsrK/g/AF9C1wrhk6nw0m7FG4T7K3Rjcdp0OabsQgIKph7ncNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xm1dJWDj; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-477296dce76so29913591cf.3
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 04:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742901205; x=1743506005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3uAc3PYom7+hjEmDD7g7OI0UHuQn+Z+q2xbe5aW1VI=;
        b=Xm1dJWDj3WRCAalg4fS/5qPAFz9O7s0UlPlMU83z2Bq3OYNAeSpcX8hg+k4keOpNsy
         /MWZvhtdSSTbixh8PDw4B08KScshvl0nk8kQ/ol4rTotjalGj0xykb9wRNVE5ubKw/Ns
         lzD76++K9pjb/n6DV9iFaLU/e7hRyQC9KXDetX8vir6DmSv1CCLwQiQ4h02SAhbh0Wlf
         t9lV2MM65WgyLkt1F8RP2twQp+CzGhbbYL8DexZ5eDkRE5hSBCv6yA7F2aGZ+ljOgZI4
         CP9w0RKfMLXrCvdc9VKYB/S5EHBMxGx4Ptc9SaY1lvbkBVVQKYeRmfouDHLU/0sTjwgz
         gDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742901205; x=1743506005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3uAc3PYom7+hjEmDD7g7OI0UHuQn+Z+q2xbe5aW1VI=;
        b=KJ4yXCmbSODtGNcpNsCYYpw3MyTKmIqdH4E360WJcsLEC84D1+hy7ptg7rOTj1IbZr
         mf3SQl3lkXc/P6jyo4WKmC+AP+37lbNbUop1hEVxmI35guzLsZDSCpWkFVfO3XvT6g+Y
         6kBaBCFhw39d+KXJIqS38vUu83JaBLgXIW765Ul/8qQ/2/2LxKxbmrdctnP8omanCsIp
         FWx0Dc7ZfdZtcNqc9YX/Tl2yOwulWveKyiY47qWUDVgOnbqj2ZZd7G/4AGESz1n+9LNf
         706PGqwJNYcBdDTpiL8RIsNKp4TdsC0RH3h2Zatia3et7ujCUYKStbXXWOo790Prnmpz
         j0cA==
X-Forwarded-Encrypted: i=1; AJvYcCWMHgwzw25d0AHl5uXANGnh8J3hPHhHJv+HTMCD7l+kjP4QjW6r3zQq9Ec9VuFsgL5Z0x8vc98=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxw/q33/uYnuPZnd/76dvUMsP6sz/Zt0sA7FtNYfWagPDCPYAT
	X5wYhkgTwUjnFSh6aUFFDot9O0X/s/TbloK4glU1w+fqjJkt2PRiRisPklNWBQvrxoD5AeyeQxM
	Fc1SRwz+Vby1l/0CD4pxN78KltmIASYuNSpy8
X-Gm-Gg: ASbGnctjn+7vcwEdHA4FL+sU5fFPNqB6481gFBpQCmFU7RVPHuMf+OerSvAIr/54PJg
	cbkT3ja1c8J0Uvlt1U1OcMixDcMeCTzqzlKb6nP64zeBU1if1kZQqYnWMhqkfqlR0i2ee3Cqhxp
	U9n3UiuBWHyhRXN48WTobXifzobJ8uDtVtvXiy
X-Google-Smtp-Source: AGHT+IEaAiGe4haR9nqNoPEalHx5BKFJ8fc4bRRrnPOLx3waFpwdRy0EsnxGhW5+bORN877ljDb2w7tjDioIf34Kw/8=
X-Received: by 2002:a05:622a:5196:b0:476:7e6b:d297 with SMTP id
 d75a77b69052e-4771de14bc9mr304101391cf.41.1742901205094; Tue, 25 Mar 2025
 04:13:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317120314.41404-1-kerneljasonxing@gmail.com> <20250317120314.41404-3-kerneljasonxing@gmail.com>
In-Reply-To: <20250317120314.41404-3-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Mar 2025 12:13:13 +0100
X-Gm-Features: AQ5f1JrZPhYNm4XUkAjbB7yDctqve2LA3ai__4h1AShkaxQd003KvKdEFe-8_rs
Message-ID: <CANn89iLTb_JgLAKk5omW82SH-h8qtZLs54nX5c9Y9GbKdmTFgg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] tcp: support TCP_DELACK_MAX_US for
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
> Support adjusting/reading delayed ack max for socket level by using
> set/getsockopt().
>
> This option aligns with TCP_BPF_DELACK_MAX usage. Considering that bpf
> option was implemented before this patch, so we need to use a standalone
> new option for pure tcp set/getsockopt() use.
>
> Add WRITE_ONCE/READ_ONCE() to prevent data-race if setsockopt()
> happens to write one value to icsk_delack_max while icsk_delack_max is
> being read.
>
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  include/uapi/linux/tcp.h |  1 +
>  net/ipv4/tcp.c           | 13 ++++++++++++-
>  net/ipv4/tcp_output.c    |  2 +-
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
> index b2476cf7058e..2377e22f2c4b 100644
> --- a/include/uapi/linux/tcp.h
> +++ b/include/uapi/linux/tcp.h
> @@ -138,6 +138,7 @@ enum {
>  #define TCP_IS_MPTCP           43      /* Is MPTCP being used? */
>  #define TCP_RTO_MAX_MS         44      /* max rto time in ms */
>  #define TCP_RTO_MIN_US         45      /* min rto time in us */
> +#define TCP_DELACK_MAX_US      46      /* max delayed ack time in us */
>
>  #define TCP_REPAIR_ON          1
>  #define TCP_REPAIR_OFF         0
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index b89c1b676b8e..578e79024955 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3353,7 +3353,7 @@ int tcp_disconnect(struct sock *sk, int flags)
>         icsk->icsk_probes_tstamp =3D 0;
>         icsk->icsk_rto =3D TCP_TIMEOUT_INIT;
>         WRITE_ONCE(icsk->icsk_rto_min, TCP_RTO_MIN);
> -       icsk->icsk_delack_max =3D TCP_DELACK_MAX;
> +       WRITE_ONCE(icsk->icsk_delack_max, TCP_DELACK_MAX);

Same comment here as the first patch, I think we should not change
csk->icsk_delack_max in tcp_disconnect(),
otherwise a prior setsockopt() setting is erased.

Probably not a big deal, and if it is, could be fixed in a followup patch.

Reviewed-by: Eric Dumazet <edumazet@google.com>

