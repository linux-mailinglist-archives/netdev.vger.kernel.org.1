Return-Path: <netdev+bounces-220725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CC4B4860E
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1C437A7298
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 07:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60B52E88B6;
	Mon,  8 Sep 2025 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rsmMHjhK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8050A2E7F25
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317887; cv=none; b=mQA7pS/aw93D4mxri7PCeKZwG1BUBwNBUjcjf/ooe+nHazeyIr6ZUAJvNd3I60kZpJi0zN1R2SnkwNNpvtbsk551nzC1A2knRpSqxjU7HuV3HI6DCamYg7qRytel7xj9f7Up+eG95+Q1zrB93tMx3O2PaR2Z0ZQd+3MXpJFyZnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317887; c=relaxed/simple;
	bh=kMehjDSkTzuk28YahKrFij+FunqVnt1oKSMf5uBlkL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRRKqEh0zUJ/+UG6c+WA0vsGYm5oRzcrqyXfo1Wl6YtYNlxdz6Mz7UgppbxSYHwAIXKVr1J/EGCmmpwsH7ZRDbm+Pcp+8Vb1PmJuVxa7CGnnegVsa84mjhm79JD8DmsHaa94uEr/VAOAyb/x/UnGpDuQUHJodzQOBuRxrXVaUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rsmMHjhK; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-810e642c0bbso326664885a.3
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 00:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757317884; x=1757922684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMehjDSkTzuk28YahKrFij+FunqVnt1oKSMf5uBlkL4=;
        b=rsmMHjhKimOseAVXVuiajauE3AER+bElyPLg5lBVb9VdOsGLxyHYTlwE1qTX+ydqlE
         EecuhdXPezJjcBiNBMQZx4cLBc95NddeJ/2l0oT+5ZSGuYZeFUlUmtsGiUyX9j1Xpd9n
         oZI3eYP/ROJT0IMn/FDW7Tav6ZAt7mSpTKKomlfakIfomE56/8GWD71nbiHhSPnTkryk
         sGAALW5AbBd76+roIgmtAPyODBSWnw0UZXHBeQWz/Tu3QxCYezXnt8QWo/uho3+8LTAv
         rjWH1A2FE5SAHjbC5iYpqnP7QAzb+j2dxx+IF5lnAkjvQjv8FqALcgbBJbclYySwOtGI
         LIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757317884; x=1757922684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMehjDSkTzuk28YahKrFij+FunqVnt1oKSMf5uBlkL4=;
        b=s+xpGKH4HrWxFJVZCrSRVe0j1PuGnjUWGBz2IB7kaSDLj21PgKuJpFGOGr7UVhWTOc
         we3fViHuIrXYiSt0C3k7InEE9YP9hlGu9n34hYNxyj7NQUHJeF6WqKb/BBbwemw58Z6n
         ApZKT5P8ofViC+DlXB8cjRcsrq1v9l3Sgv/B4csDG/UNxVuuaoFKTh1sYi2zvYLoiNQN
         KoPI/QRI6vvVzN7qPIjpQ13AWuXkmv/B4UIZnawVa82ZT3VmeLORh5g9rRQsYI416T73
         atb04UpEhGjZSg49gbkFMnx2Tiy1BrWzBOqb76koUlJUveH+EAxhVLzdcHZEJZu+WpEA
         jAug==
X-Gm-Message-State: AOJu0YyfVmn/2yu0q5bA81eyherztziORaz2nl8viToSkeYg482UQiA0
	nuDRKkQgSnToMjhe2D0L012YFRvG/Pcv6u/8QnHZ2nwCOg1Y18USFDc6wkm0w0VvUsk0EgVLM30
	3i+W36GWVpRQft74Ituc2psQP0fU7Qqpa0vixyTt2
X-Gm-Gg: ASbGncv3hmZg2FgVcdQ6R5FcisZfe7iC5M7lQdS7w/DmdbN6Rw2LU3kVg0txSEpC6kO
	xYgFFdMisg3nZNH1lmjSgcriSAcF3YLRZqJG6V3k744USb+V4vsHJlBawTGtmLGSaMJUhyeMkeB
	fvYfUUyRtWEZC5XkKrLp7dk8r/KoCEIAonDdVxSbw3CPmhWDCHxoZAkhN1V0ZiytnAsqHI1+oDW
	CozYU1hKNBt/g==
X-Google-Smtp-Source: AGHT+IHhAakUmNgkfHukrapxhUwnzHE8QLHc4/O1oiLMcZSXfgqGNdNJiQtcA8gmS0prV04C3JxmHb2hTprCt/epFAA=
X-Received: by 2002:a05:620a:3f97:b0:7e9:f820:2b7e with SMTP id
 af79cd13be357-813c7963615mr681926885a.84.1757317884045; Mon, 08 Sep 2025
 00:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908073238.119240-1-idosch@nvidia.com> <20250908073238.119240-2-idosch@nvidia.com>
In-Reply-To: <20250908073238.119240-2-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Sep 2025 00:51:12 -0700
X-Gm-Features: Ac12FXwKtbvabH2QGt1i-gWCfIo7jNYLuwa4l6s1ON0SXOaJWQVmtg9-_RcrBhE
Message-ID: <CANn89iJ6aodRDPYRw9hYP6gVai5TAV_J2WU1yzAsPCU-56-Bwg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/8] ipv4: cipso: Simplify IP options handling
 in cipso_v4_error()
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, paul@paul-moore.com, dsahern@kernel.org, 
	petrm@nvidia.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 12:35=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> When __ip_options_compile() is called with an skb, the IP options are
> parsed from the skb data into the provided IP option argument. This is
> in contrast to the case where the skb argument is NULL and the options
> are parsed from opt->__data.
>
> Given that cipso_v4_error() always passes an skb to
> __ip_options_compile(), there is no need to allocate an extra 40 bytes
> (maximum IP options size).
>
> Therefore, simplify the function by removing these extra bytes and make
> the function similar to ipv4_send_dest_unreach() which also calls both
> __ip_options_compile() and __icmp_send().
>
> This is a preparation for changing the arguments being passed to
> __icmp_send().
>
> No functional changes intended.
>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

