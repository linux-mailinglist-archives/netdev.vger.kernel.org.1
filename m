Return-Path: <netdev+bounces-141566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CC09BB6CD
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 14:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370DA283C3B
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92F680604;
	Mon,  4 Nov 2024 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gw5wGZZP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A5D42A9E
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728458; cv=none; b=EgppuMCHh2o5k2c4BE5h6ZEosuFe7qWZxG1A5kLtyMyQKvvlm3+xaJxcXdJ9HQ4D+WU+pqmVNFI/bXHi2kioL72K5m0zwMZ76PKKB9jWwWO7LN3zfWJ2AH+8vE/4VzYsaoCOT9RSDpFRhHP+V/+xf9+Xea3jw2ebJ1a6VsSH+Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728458; c=relaxed/simple;
	bh=a6qbCKQEzEpwIVI/73kghaXRV/+FRJuP49xHqAq6wYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juoiVldrqyqspw9zRKK0awAc3hvUMsVeecIF3jbyIWlcmmHUsioR4lXvI0Gd41bbRN+G1Up57Xai8aP/0sXjx+c+tFAk+Aiw3CtG/7cOu4ftFoRnxC3FgGNKAPWwIvgn1IbeaLZyhlFZ3f6Rc7YdT+3CytPkR+gZzDKscwD7EK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gw5wGZZP; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a86e9db75b9so677668366b.1
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 05:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730728455; x=1731333255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p969/OPvuNJ6vfmrhxvpC8x27FtnN3go2KUsWKqGhLA=;
        b=Gw5wGZZPMc9gF0Sjkn5Af+/wrdBz7rohFD1vIqNaYHHEfmURkoHFpisRzr9ykEDVF+
         NCAzbX/XBxTjWxqR/dGhKeGn7rJuwvxYiBRnQcYfH1do1YGDZOvq08JUoOafaCN75oDa
         Kn0+duVXeGDbOiMbv98vu/5XCKICW3ua4RKn7dT94RdgzTHGx9mSsuU8EL7aivnXTtD/
         cWffgdCrjY/qNcuqfmv7HdVNf0Dja02MP0MbRRl2wUI/mtXu0804NeH4tGhCpPwuBU2w
         26jghZtY0s4o7sDJlGSefDDaiD/zQE/s4FZTp7IQS6ZN2mRIPYn+zsPtKwUG9Qfwaa+k
         mG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730728455; x=1731333255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p969/OPvuNJ6vfmrhxvpC8x27FtnN3go2KUsWKqGhLA=;
        b=DL5Q+Z3OluqOE3Zlc3EATQyhD2ab8cwAnG2LDFdYyp+BRDsViqtAc3XPxLF1laDiM/
         FwxlLuKs4wCsBwHJIHtUaxW2GZw3xbSUnv06nJNQfrlKz/p+QWXrNLMdZ+GttmMf/pSK
         uunpNoDqfnr7dEwl/5iOmEBMplcG/eioW1CUPJVMXucbgGDTJ5nStKXUK/H/fofZuVMN
         eO5auGEJ/YG5TY/19LMhIoHfwV5vfJ6fwfbHylnyYwfTnA4JncKVBwJf68ICmnfou40U
         sbieE49FwY2pD37Szv0zKdKz2PGz19WqibNoMuvPL3vtU2k+8nCEyFvNMLAWGFcsJyXb
         F6Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWfm5Dj3sKLHk90N5oDvx4W0MZ5avs0tAtQX5Yai9KnC5Hki/FIzgNaJSZKtwU/K9WCKthzfbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv88//GsiG/7T3Of7Mo0ZoZoS3mT1KKk6UTdRtbgIRlOGVaL5c
	Y67Inp0dLZpYF1nmUBHZS1xiJbR7R2yrcdFjnqQ6raiKCMzLAWyWr1bdvBfRGesJOAOsgWfk6ka
	3xQkib+nzNi03CWbGjoeZoPRmaRo6w6Dta0VZ
X-Google-Smtp-Source: AGHT+IF5YBfb9ROIbRP8Q8DNgws9ejazzGb+V2ACxzQj2R1iK2is32eex8L6f7UixSCTHszNSxXfWPtzv8nYHU1xSDY=
X-Received: by 2002:a17:907:3fa9:b0:a9a:3f9d:62f8 with SMTP id
 a640c23a62f3a-a9e508d3430mr1415602966b.19.1730728455044; Mon, 04 Nov 2024
 05:54:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104132434.3101812-1-zilinguan811@gmail.com>
In-Reply-To: <20241104132434.3101812-1-zilinguan811@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Nov 2024 14:54:03 +0100
Message-ID: <CANn89iKdafBUvrCuy2rOu5Hg8qQrFxmD9JU5KuE=zbntMvQK8g@mail.gmail.com>
Subject: Re: [PATCH] ipv6: Use local variable for ifa->flags in inet6_fill_ifaddr
To: Zilin Guan <zilinguan811@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 2:25=E2=80=AFPM Zilin Guan <zilinguan811@gmail.com> =
wrote:
>
> Currently, the inet6_fill_ifaddr() function reads the value of ifa->flags
> using READ_ONCE() and stores it in the local variable flags. However,
> the subsequent call to put_ifaddrmsg() uses ifa->flags again instead of
> the already read local variable. This re-read is unnecessary because
> no other thread can modify ifa->flags between the initial READ_ONCE()
> and the subsequent use in put_ifaddrmsg().

I do not think this last sentence is true. I would rephrase this or remove =
it.

Otherwise, patch looks fine to me, thanks.


>
> Signed-off-by: Zilin Guan <zilinguan811@gmail.com>
> ---
>  net/ipv6/addrconf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 94dceac52884..c4b080471b39 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -5143,7 +5143,7 @@ static int inet6_fill_ifaddr(struct sk_buff *skb,
>                 return -EMSGSIZE;
>
>         flags =3D READ_ONCE(ifa->flags);
> -       put_ifaddrmsg(nlh, ifa->prefix_len, ifa->flags, rt_scope(ifa->sco=
pe),
> +       put_ifaddrmsg(nlh, ifa->prefix_len, flags, rt_scope(ifa->scope),
>                       ifa->idev->dev->ifindex);
>
>         if (args->netnsid >=3D 0 &&
> --
> 2.34.1
>

