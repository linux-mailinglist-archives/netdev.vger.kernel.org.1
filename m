Return-Path: <netdev+bounces-188972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D57AAFA9B
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BE21631F8
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4680229B23;
	Thu,  8 May 2025 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4WXuPOH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36724EEAA
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746708837; cv=none; b=rMcb6nVevNovOMyYpXob6rtuTL+jMxEKof2p6pbiImL/hWisw+YS/Trw8m8ry9kWPASY58wDAyDu87VA8MTYnMlHfz4jlSFVyeaAzVMwHyq8wUPU0yrNXm5fCjQ0ndA/7qvx8UhQ1gC6po1/c2OSPIsGNgza021yktZib8PsFpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746708837; c=relaxed/simple;
	bh=7k4JFjTWoqmEmGwxqM8eUh1bCZ3BxAGleaj6TQXurjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nS5GpDESRKqRdNjQuzSBX7V1N9/kJBUan0TmiAl38O6qcKJE98gzDRipY7xlTusFv3V4vX4wbxF2ItBDFNqQOkUfRPNMj1mUYhgffOkqTQBlBb/2+NmSPNg1sSu4pMusJnnMS5v2uGpqUX2SMtT+UytkU267h+BHAlUckR4NXdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E4WXuPOH; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47666573242so330521cf.0
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746708834; x=1747313634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KznC4NyDVNeygPHmYzyMAnp1KdQB+d3H7ZdlNEZpLJI=;
        b=E4WXuPOHaK0nizEPqbUXo9k8sDVhxBNb/jwQl1UPs1Xc8RGWQ3YfxbKknf94p+B3qf
         A+y3qa/UfXrLjCpDQKGggl6L199+6yFHFZINVPGj4uU2jPyxCpddyG5gFYwEAkNUb6Sf
         sHM8hiS+pKvQ+E9p1e5y5vC5IkRgBjmPUEByQrQGkem/ltnHmcLYCmSJmMIvTbywd2OC
         VDyhH2R5TkLeKwGZmzLqWoMBVTbO8Vs1Izxc+vVn/NGmZKgQ2D4o1YbzRLOP16Guzn7Z
         d7qWYSmxvzxSZOWb2qFRYqlrhzbSuvc/5cefgAJLc122pXP7qsr/T3mLG8StsuaIjPLy
         kQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746708834; x=1747313634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KznC4NyDVNeygPHmYzyMAnp1KdQB+d3H7ZdlNEZpLJI=;
        b=FfUXcsvZqOTrQ4QXNg2kdueyjJgR9S2BINVAQKRQK3ThiwmkOjWS/TN4gAQiIiue5a
         kfia6MDSAASywwpHTAlSpvs4aBg9nh9Ycj5KUwqsi2wtPmZH924g/WwMdtmGWJ8vZGbS
         78dGqA6vxRE9HAuTYav+fhJxqU/1iIQm5jL+GbuOdTHA2qnqnNY8t6f15uSNXgHkNcyC
         cFUkLmBae0O7yjs/BN37/CmxaOG8FBATzD7Aue5krA58qbdk2gVC8MrZxWqeWL4Z7ATS
         hX13oHJYy2jI8KvPb/8kEaXx+zwHDeO9od32068ji5Ebh291DB3BSnE8XW1Ru2GcLk8W
         KdKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7f+0ULAgFH/x9irmhlpfjs4hTRGn89N7c0T1DTvOi2oABJRL+0OvUEJAeRyTsvzL44wX2kOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz41pX3XfxMduDY+OFYrl8mGSZQRuQKYNa21Q7HEYU4osuycCcq
	P9Q0Egv8Oi7RjCUhj9Tgpm4RXha0419vVyXwKFy0dffDgrIzrKYhff77738xoadkoZNSIiK/ENj
	ew3D5r8+QDysHeQ22APJzH0iEQmpBi6yp4d85
X-Gm-Gg: ASbGncuR7ywkqvRK4Q8a9Qefuj9Qi5Eatx6RoyPMVytoGzRtt9hlSDeIiS6BxTNGbDU
	y3klxEEg93l7PLxwPzA/rMS/K6618Y7Kyht3Kj0RrekT/ZNMXZH6qFgwCLkEGg8834NsvYOU4A5
	9sdsAabOcjYrtIsqpIclQ/qyHMPqG4n2PWg9NGPKDtuFNifwJ6vfrjRAhtDdrL5m9EaA==
X-Google-Smtp-Source: AGHT+IEUi9zM6NbL+TX47b3DpChxpjMF5gu34vU9JqPlf+hKu3TOQ3H5KOck1TeRNOENBBnP85jb0QbDWibw9ikJyIE=
X-Received: by 2002:a05:622a:2c7:b0:466:8c23:823a with SMTP id
 d75a77b69052e-4944a9eb0edmr3771571cf.17.1746708833813; Thu, 08 May 2025
 05:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvZ6EoGrp9SCvkVKEV0i=NW-7XZmxbmZkmxd8TPFboPTAUF_g@mail.gmail.com>
 <01100196af6a2181-4f17e5a7-799c-46cd-99f3-9393545834b1-000000@eu-north-1.amazonses.com>
In-Reply-To: <01100196af6a2181-4f17e5a7-799c-46cd-99f3-9393545834b1-000000@eu-north-1.amazonses.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 8 May 2025 08:53:37 -0400
X-Gm-Features: ATxdqUFcv-woCivIBlluwJP1Scv8iVAvH_POV_RCoY5PYocAzSSLGFISNZcasOM
Message-ID: <CADVnQykrenhejQCcsNE6JBsk3bE5_rNTeQe3izrZd9qp8zmkYg@mail.gmail.com>
Subject: Re: [PATCH] net: ipv4: Fix destination address determination in flowi4_init_output
To: Ozgur Kara <ozgur@goosey.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 6:21=E2=80=AFAM Ozgur Kara <ozgur@goosey.org> wrote:
>
> From: Ozgur Karatas <ozgur@goosey.org>
>
> flowi4_init_output() function returns an argument and if opt->srr is
> true and opt->faddr is assigned to be checked before opt->faddr is
> used but if opt->srr seems to be true and opt->faddr is not set
> properly yet.
>
> opt itself will be an incompletely initialized struct and this access
> may cause a crash.
> * added daddr
> * like readability by passing a single daddr argument to
> flowi4_init_output() call.
>
> Signed-off-by: Ozgur Karatas <ozgur@goosey.org>

For bug fixes, please include a Fixes: footer; there are more details here:
   https://www.kernel.org/doc/html/v6.12/process/submitting-patches.html

> ---
>  net/ipv4/syncookies.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 5459a78b9809..2ff92d512825 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -408,6 +408,7 @@ struct sock *cookie_v4_check(struct sock *sk,
> struct sk_buff *skb)
>         struct flowi4 fl4;
>         struct rtable *rt;
>         __u8 rcv_wscale;
> +       __be32 daddr;
>         int full_space;
>         SKB_DR(reason);
>
> @@ -442,6 +443,17 @@ struct sock *cookie_v4_check(struct sock *sk,
> struct sk_buff *skb)
>                 goto out_free;
>         }
>
> +        /* Safely determine destination address considered SRR option.
> +         * The flowi4 destination address is derived from opt->faddr
> if opt->srr is set.
> +         * However IP options are not always present in the skb and
> accessing opt->faddr
> +         * without validating opt->optlen and opt->srr can lead to
> undefined behavior.
> +         */
> +        if (opt && opt->optlen && opt->srr) {
> +                daddr =3D opt->faddr;
> +        } else {
> +                daddr =3D ireq->ir_rmt_addr;
> +        }

Can you please explain how opt could be NULL, given how it is
initialized, like this:
        struct ip_options *opt =3D &TCP_SKB_CB(skb)->header.h4.opt;
?

And can you please explain how opt->srr could be set if opt->optlen is
0? I'm not seeing how it's possible, given how the
__ip_options_compile() code is structured. But perhaps I am missing
something.

thanks,
neal

