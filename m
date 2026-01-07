Return-Path: <netdev+bounces-247655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D886CFCE2E
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 10:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2AB0300A36D
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 09:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C566830FC0A;
	Wed,  7 Jan 2026 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAbLNGcI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCF73043CD
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778065; cv=none; b=RA7y9w77pBNN6ZsSISq5HeOJm7Zb/tnwMzJs307MakNubLvjyeGppIcXIUs0jjh/lZvI1PNRUnLsJnvD2bC+LnwqMosWgO2siwZm9aiMiIYUAwTSruKYifEu8UafEB+zIrg6d453VvZuCjNiNGz3nRhGMDfKO4uAIXrpImoJImQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778065; c=relaxed/simple;
	bh=DleEtKo6vyx1iLpQb4NjV+ZcPK5DeFl3brtvBfL9iS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfzsulhZ0EfZuNjZft/STLZpgyaXT91Zw/f0gL54tzM6UvdlEGqIzrrzKRuQ/2TyvpMICEbI8KyWRgFPNLszGCtAYSmRMXYolG9jNzYp7ZuVxTg4fTQCWBNPhwRRjOXHWHBIhaxNn2+9Uatp5gGSfjMAw2QAj6uu4bDFH07seRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAbLNGcI; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78fb5764382so20872797b3.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 01:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767778063; x=1768382863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvShRozEAK5fws9SMzsHgaw01LyGQA6gU5Nd9Whz02w=;
        b=YAbLNGcIroPbCifMT7JmLFoZPERFZEPF5sE5Y3hoZGruJ7wL5vLccWQYmakZ8IHmk6
         lcZeb9/m82db0DuQbvOsRpWN+9DGZsfu3ei0GMsf6yA+GKi1B0HxF6XJ1nDjTwi4CMC0
         nKfaVHs8LOP4EIisUJzgEIjpPkgvtMkHLbqYeHfsOWCo9UX7qo85EoQ4dbl8WYeW3UeC
         DnHqyUNos1MYbatuafYpW++sH/epitzdkPsFhq4TCO83F9oOd29GkuaQk6jBPiuLX2tQ
         8xr8ciBPBdl+C6PA4Pf6178g/+Eiy/g5sLIhKOK+KBDv64uRwS5eVCi7D2/nBlygF657
         qx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767778063; x=1768382863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YvShRozEAK5fws9SMzsHgaw01LyGQA6gU5Nd9Whz02w=;
        b=cz/nkJG3y0yzc1yB7ycF1fTjKbWh6yktdW+qLq1EqOF7PzHN8m8/RDTU5VuXQNVrKK
         YPDk4laNDNh1Bx0XnxVNF7rIXK9TKT8nFAmJfag+rD4N1wZp6WecaoWiqwlDkawUSL87
         Q0uYy/yzZ05sV1lqVoGNM4ooJwGGv6BjzURaH29bjsoLlv/tuF6opRhpxyRSr9E+YqE4
         lhHL9n6tOFxfLbcYE/1VWYJdJuQZevRbJJJBdhrSm9MBmUv0LrTV5OYEuJuqk88K0WC8
         mUlXmh7YrXoKQH7w4U+oDS8qRDydITiFBXa2LirRI573G2JDZiucTM2gOPqyiTvPKeo/
         8Oww==
X-Forwarded-Encrypted: i=1; AJvYcCUMt5k6l2qe1VUXJH4s5TS+zcSWRZNniuW3/DsaILlqXoUZK5FD56xUoI0DaZE/azdtqa94ScA=@vger.kernel.org
X-Gm-Message-State: AOJu0YypO/1O+G98ZSYZ3WaySYPRrYdhNW+eZcNOtCuCH4ceZE15Hs9W
	05FbYU8i/BbHlWEe3vgcS+xcNtZbRK2Zuf/gplVfUocNq0qkh+PG4ZtENHxC3yGbW2VB7POd+7M
	zW3fMDxjcItAaavjBEpbekGGmWyC6Ryo=
X-Gm-Gg: AY/fxX74f3M9Gb52CwYIRrlcaKapbXSCCCWgoDMWzvs8nt6fpwDeIBUE+/p1q33aB38
	UxjfiVz7Yg4LQ6rCf9z8LkueXsCfnz+9bKkmIk096/WFx5mOYYosUEvOvTejyLTZwmUU3Kec7sU
	2w3CQRZdJfF5J7LZLaTpeE+v59ziQ98Ees3aDk36VbJugpoI5Pe7zz+pa7DCt1kQgvw29OiXQv7
	+OcuEJ8UldT5oaaf02RnInm5E2KHP13R7Z50s9ZOxqkd17612JnB1S8gKSyiGLLqNaLNg==
X-Google-Smtp-Source: AGHT+IH/2ztikIaP7xjRwAAs1YrcHRK4PPm2z5HGF3om27F0/YMI+fC2p+vMoRvZig9Ln2RvIJcMdxzYG1HtBCcVWKw=
X-Received: by 2002:a05:690c:6e07:b0:787:f5c5:c630 with SMTP id
 00721157ae682-790b568d1c7mr17337567b3.41.1767778063279; Wed, 07 Jan 2026
 01:27:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105114732.140719-1-mahdifrmx@gmail.com> <20260105175406.3bd4f862@kernel.org>
 <CA+KdSGN4uLo3kp1kN0TPCUt-Ak59k_Hr0w3tNtE106ybUFi2-Q@mail.gmail.com> <willemdebruijn.kernel.36ecbd32a1f0d@gmail.com>
In-Reply-To: <willemdebruijn.kernel.36ecbd32a1f0d@gmail.com>
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Date: Wed, 7 Jan 2026 12:57:32 +0330
X-Gm-Features: AQt7F2oHzFcRZwE6sxoNYgeV8MQsZtseaW_bGizkhLuT4cxhA7z8GuCYiWEGfHQ
Message-ID: <CA+KdSGOzzb=vMWh6UG-OFSQgEapS4Ckwf5K8hwYy8hz4N9RVMg@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: add drop count for packets in udp_prod_queue
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 10:52=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Mahdi Faramarzpour wrote:
> > On Tue, Jan 6, 2026 at 5:24=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Mon,  5 Jan 2026 15:17:32 +0330 Mahdi Faramarzpour wrote:
> > > > This commit adds SNMP drop count increment for the packets in
> > > > per NUMA queues which were introduced in commit b650bf0977d3
> > > > ("udp: remove busylock and add per NUMA queues").
>
> Can you give some rationale why the existing counters are insufficient
> and why you chose to change then number of counters you suggest
> between revisions of your patch?
>
The difference between revisions is due to me realizing that the only error=
 the
udp_rmem_schedule returns is ENOBUFS, which is mapped to UDP_MIB_MEMERRORS
(refer to function __udp_queue_rcv_skb), and thus UDP_MIB_RCVBUFERRORS
need not increase.

> This code adds some cost to the hot path. The blamed commit added
> drop counters, most likely weighing the value of counters against
> their cost. I don't immediately see reason to revisit that.
>
AFAIU the drop_counter is per socket, while the counters added in this
patch correspond
to /proc/net/{snmp,snmp6} pseudofiles. This patch implements the todo
comment added in
the blamed commit.

> > >
> > > You must not submit more than one version of a patch within a 24h
> > > period.
> > Hi Jakub and sorry for the noise, didn't know that. Is there any way to=
 check
> > my patch against all patchwork checks ,specially the AI-reviewer
> > before submitting it?
>
> See https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
thanks.

