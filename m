Return-Path: <netdev+bounces-228384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 261A5BC9986
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 16:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D44E4FCF01
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 14:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618232EB5CF;
	Thu,  9 Oct 2025 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="A9VabX1f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C138C2EAD13
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021029; cv=none; b=br/SN00DJcEXWZWi5M6splNC/kDIWoqn/dBKltTGfTfZ3Zg7wrnVkzdaUJJVYGV0tDG6vIaZYgFwBU6LIhP2I5JO9gNqiYxoIrptF/MHSVcbvotjbqwv5sL4NCWnniI1nK6HfxhIX47dXaN7ORhE/kaMcERstKZhmM0HJkJJ+Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021029; c=relaxed/simple;
	bh=hRicmbLQWEJ8+bPspecCmobqh1Mt64hI1L8Yhs3vPYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsESR8rBAdiUZ/Gx41cbKuMapT1zuSBf5sO2oJMiXU6hmEJBWz8I9gUiChOZOF1X7CiD0Ps4+cTvn/T/t/AwdKGNGamVMkSpOU4nD2MjKIWk5NyYnxTC3cTCCne72TzxI0S9mzkcfoik0RrPceZiXIsEPREW+ZF1nDkkMYxEm8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=A9VabX1f; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-330631e534eso1230086a91.0
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 07:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1760021027; x=1760625827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82eJnEG3a2gfzvtAFqHYyT6W99N4n+MkixpvA8b26PM=;
        b=A9VabX1fKTfAj0vBmzcnMWQSmxIpDQognGLwtLAAFw6J7PvLiEI7zm4gO6hNh5tHH/
         hvQkvFmjtHDA+AmOSpgX6XRaSyT+drTwYh4LFGLenigAy3FQHbOZ66WoW0FFakEbzOWQ
         qTTf9+/mtmQcdkToN1BZLL6xX85NAygIYzvRc3GnIyKLt1qb03/jjwdknFXw6mTvZfCF
         UgQzrH24YklzgNYfH5811xVZTZtB0dN9oyB6dS0DDVzAdEdSX88IrspEH4v73UYnzcmt
         B8xECq99sCToB7tDI1ymkSzPGDoOTJf9/h+FNYwgjYzr9pFIreOMmmxotuOrkCmON4Uf
         Tn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760021027; x=1760625827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82eJnEG3a2gfzvtAFqHYyT6W99N4n+MkixpvA8b26PM=;
        b=Hc4XHKNdruyNNyUBBjVa48G4MMGEc0HH9t7enwLo+fMnhspmZmsHiKg+Imq6ULMoSL
         GCcXP6zssMRvXS4sPRHw6FfpQAluZlWWlrbj2nVcAPNAZeyzoA1cZrU9XKDqDlkvlqkH
         WbInbGKiE+xpT+Rc1bFmSkfkt808uqVJjv+9/WvwErI0iBkIoJ77+wT8QoXWA1yyT+pb
         4xMPGnvzLWT9t7g47Sp6CBBVzrw6AKlPqXtNMvqJDBuM7X9atqO5ziuLQeTRUibqLOdy
         wfDGiqsSoMMQbS7XSb7zJF8h+qJLFk9kfe20GRzYRSMZX3wUdERWv/Eth7LVXZTDl8ZR
         2zWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW76LunFK8aCLywNAKckyMT5k4JP4FQQMa/Y8qknKdcI0AabYI4nIL66OENYvrXtZAbi0uIylI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcLhETCYD40QA0VEg1PyemixIucnvTum0lYBnsOp8y5Tm8abaq
	6Gd6vNzR1LbWOeNgehyfmB4F/cR5rPrv+NV86NctIFU1xYHwK1O8kP2lRBI0PQ4z20fZJcrsn+U
	VsYYQnJdByscmT2scZsTCKo/oIPlL8tuXAAGqAlSN
X-Gm-Gg: ASbGncuGO6i+voGnM7VaZol31SkP4ayFA4oG3IjsmDEIcj4H9YLM8wcjjUTZnNWD741
	yobc7i85lEsZD/TFS+F3RO86+oZeNcH8enBnF6OBRXSQ8SwTSCogqpogzr1j4p/elTrHS46KHN9
	s/xEDwyrU6TcvRNmIWc3eWNU7M99s1TzqHQx4FqyN8UU+wg8L7wyUk/yfSylnaT4hPacS7IdQmK
	x1hgdsMbwz6q+f6AyMK1ZN8JH9vTFK5/IZxuplhPY24uQ3BDuFzIZJBXRyImGLiMAN3moi1FV2N
	MoZ3sW54CrXa3MUBTAsRKkEiR4lO7LX2NDLRZQUy3eRAiLeke/4VC1ekDMPnTh56DWo=
X-Google-Smtp-Source: AGHT+IH805V7OJYS76B/rqvAegpKx0ru2dDHeH6i2pmIfcb1qUFIZrvtv/9KKjkxayYPFQ3wLu7QgWNtfXP6qRGTo60=
X-Received: by 2002:a17:90b:4b87:b0:339:a4ef:c8b4 with SMTP id
 98e67ed59e1d1-33b513861d8mr9700512a91.28.1760021026889; Thu, 09 Oct 2025
 07:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-ip6_tunnel-headroom-v1-1-c1287483a592@arista.com> <20251007183721.7654cd3c@kernel.org>
In-Reply-To: <20251007183721.7654cd3c@kernel.org>
From: Dmitry Safonov <dima@arista.com>
Date: Thu, 9 Oct 2025 15:43:34 +0100
X-Gm-Features: AS18NWBQGRh6-gDD8buab9A_yPyWA20bkiesKGCiJxTSNNu73FtqaTqUrITm5KY
Message-ID: <CAGrbwDQB-x6t6cHS3prVxWXPuOPYQXF8mqUTuzmSn_95SBXK1Q@mail.gmail.com>
Subject: Re: [PATCH] net/ip6_tunnel: Prevent perpetual tunnel growth
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Tom Herbert <tom@herbertland.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Florian Westphal <fw@strlen.de>, Francesco Ruggeri <fruggeri05@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 2:37=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 07 Oct 2025 07:08:36 +0100 Dmitry Safonov via B4 Relay wrote:
> > +     static const unsigned int max_allowed =3D 512;
>
> nit: could we drop this 'static' while we move the code?

Yep, thanks, will send v2 with static dropped.

Thanks,
            Dmitry

