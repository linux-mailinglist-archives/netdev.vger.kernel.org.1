Return-Path: <netdev+bounces-233116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AB8C0CA26
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 10:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE7E401801
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 09:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B492F1FE7;
	Mon, 27 Oct 2025 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6Wo+c1U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694D12E6CAA
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556692; cv=none; b=heHmueYagjes8GpvMKZ3vUvWscHG/Skvl9MzKm57A+X4AmVaUxQigAPc0L7cUyn5M74bR4a7lTOj+kbDPTP/LYj82aMxi8QmpZIZYrDR8m0GhwJcaX+BEcQIjMNt218eupqJN66jlxDdmUAiiV4eswkKPcAh9xw1pY6aoyUzbG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556692; c=relaxed/simple;
	bh=fPskHNpEnASinQ2bx7vkp4RFIOTfzZ4Tr1rU4FC5YBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6WZcXNaIn7SrF6MYM6/7Ke5Qlw0NpkVhGhdbiRHzk1gmBYwuztmAJ2uQFwXvaYKa83jixzwbT9o6AXvCTBI/CeH+aTjnh1mDe1dhdZTakjxk/TTbDqXGf74IcTl5sNvwmY8Gu44Gm4pLXzO8rKcXSu/OOz7EqyC6g4q8BH6iU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6Wo+c1U; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4e8850b09eeso43630011cf.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 02:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761556689; x=1762161489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjuXaDF4nyYws2bQ+7X3zoKeqLCyOBsQRJF/6yWZXpk=;
        b=L6Wo+c1UGYfbusRJKURqQ7YfENnRCvFkLp/MFu+ehh8E2a8uym9+d8rGA+jEpgdBBf
         7RKXqCEBMoUvp0Zegr7yZK0aHf2wTqcc8Fh1kciWnN46aH4nnN7RmTJQ9/d3MKtRV6dn
         lq1ZPCh3qJ674HAmXT9plsZ+GnPo7C1G9EZq/gteJOs7Fex+6/b1wACviXmT0YDR9qoV
         PsrDJswL4U/4UgQypHbBxPZ1sgQh48V1PYFpW2/lwmNQpDwY4xuiUR9yLSMPJkD3NQv0
         tryZwm8gOqbSxhb2z3EuI0axV3gdeDT1VJSIPOWlVvbuH8AKL6LG2PlVPoeFOM20yphn
         nP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761556689; x=1762161489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjuXaDF4nyYws2bQ+7X3zoKeqLCyOBsQRJF/6yWZXpk=;
        b=VeQM2IC33m0PHFH9qpCR+ovmZMwldceoqQOUTFhA8p0aqqRGRzQxByvthT7C0daCaA
         4EJguawBEp3VLm7ngPtFRlxrOyu3nPFxIri7mxAr07HuZ+6WTgG8fDbQc/lbBxDXsRX1
         psZXpDQjBnUuc2sMuu9NrKJOikDz3uKTatdp62XaaBIBG0l+lGq+xK/Ov8t0umb2Im21
         A++NnqMdmUn1RaYY3XlN+VRwXioWf7miAPsR318VAE9ZhJBgBnVfnL3nJeddsNTPSICK
         yP1OzzN5njxQrCdlS8EC1UMMGTX1CYmVGTiIOT8e2nJn513df7vb6iZ6DQBpMsH0nBTy
         ezaA==
X-Forwarded-Encrypted: i=1; AJvYcCUVcmqj9H3XIeVSyBNF4nhXLz6Xb/q3yv+4DAqRGTVT44qFnz2M629Yu7KW+y+5kEEtZae0ENs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqVC93pyMiW2WXenlL1Gt9wFeu1rV2IBOpPauUcXtAxOGjkwYe
	Y3N9AS0u7EbSnD47Z6zWBAc1YdpNtf52MJYY8gIn6NnfSaW+axiY81eMBFvqK85OKpVqMzr0AnF
	uclXgP31v8l2NUL4JLhvLMiF4606I68Wi4CvMWssz
X-Gm-Gg: ASbGncsDWStSB3zFPO3+UAxr0MQtc9u1PMi+DSI+EFX+UdXzWJiuZyTlSHBGbG2AXni
	UUTviPdTN5ujoni1cBjKUMMr9kPGFWrcX0DiTsWIXtBm/J4xiJ55+PLeNPlpNSNlEAKx5BIXRlK
	cM6g0KzReC6hawN5xtF97XJBEcFzc1S4MEMKo1J7odRGR/5FUgPsqH3HEZF4TG48qrIw2u6PyBN
	+5ML0uzMSugaaga0w8eJ54K67f6L8Kuc5fuWl0Ka6dRfApH35zx8Y5tnz8/uYY0Ixutlhs=
X-Google-Smtp-Source: AGHT+IGn9kiXC6v55wZ2Z6kE1uL4cTaogteQRe65Qan4CvgMr20ojg1DZQnSbG0o49HMvVhY7LnDKeEAhavDJCrNcCY=
X-Received: by 2002:ac8:5a43:0:b0:4ec:f1e5:1b21 with SMTP id
 d75a77b69052e-4ecf1e51cc1mr36707271cf.59.1761556688706; Mon, 27 Oct 2025
 02:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027085007.2259265-1-stefan.wiehler@nokia.com>
In-Reply-To: <20251027085007.2259265-1-stefan.wiehler@nokia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Oct 2025 02:17:57 -0700
X-Gm-Features: AWmQ_bnwJIlS1v6l9rdALIdpQrpckWaD6-kZUS-gDcLcLrRu9vSgbv1vyX_nN2c
Message-ID: <CANn89iKbLadNizRB28AoNw8McQXgqtknbH3zdhErDku-m5rjqQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: Hold sock lock while iterating over address list
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Xin Long <lucien.xin@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We need a changelog.

On Mon, Oct 27, 2025 at 1:50=E2=80=AFAM Stefan Wiehler <stefan.wiehler@noki=
a.com> wrote:
>
> Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> ---
>  net/sctp/diag.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> index 996c2018f0e6..7f7e2773e047 100644
> --- a/net/sctp/diag.c
> +++ b/net/sctp/diag.c
> @@ -223,14 +223,15 @@ struct sctp_comm_param {
>         bool net_admin;
>  };
>
> -static size_t inet_assoc_attr_size(struct sctp_association *asoc)
> +static size_t inet_assoc_attr_size(struct sock *sk,
> +                                  struct sctp_association *asoc)
>  {
>         int addrlen =3D sizeof(struct sockaddr_storage);
>         int addrcnt =3D 0;
>         struct sctp_sockaddr_entry *laddr;
>
>         list_for_each_entry_rcu(laddr, &asoc->base.bind_addr.address_list=
,
> -                               list)
> +                               list, lockdep_sock_is_held(sk))
>                 addrcnt++;
>
>         return    nla_total_size(sizeof(struct sctp_info))
> @@ -256,11 +257,12 @@ static int sctp_sock_dump_one(struct sctp_endpoint =
*ep, struct sctp_transport *t
>         if (err)
>                 return err;
>
> -       rep =3D nlmsg_new(inet_assoc_attr_size(assoc), GFP_KERNEL);
> +       lock_sock(sk);
> +
> +       rep =3D nlmsg_new(inet_assoc_attr_size(sk, assoc), GFP_KERNEL);
>         if (!rep)
>                 return -ENOMEM;

If -ENOMEM is returned, the lock needs to be released ?

Please do not rush patches like this.

