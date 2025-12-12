Return-Path: <netdev+bounces-244467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E885CB843E
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 09:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F0E3300D159
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 08:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B1230FF06;
	Fri, 12 Dec 2025 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LW6hOuHY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A11030FF08
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765527919; cv=none; b=MJ1xZEd8UepD/L8IEzJ/RUkoIQI+kduVThY+6l6LiLh+ZcbsipEAP/e+fjMXYBfPTZj6LAe2To8tr6ujK+lNcTEdl9SryaYtBaR8EcOpH5k1wZia8DkiTWBMH9dYL2uhDuGVXNqpyu0Bfvvti4G8Ssy1VzF+4Mx5Miql9UO2plU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765527919; c=relaxed/simple;
	bh=M1K4jdW7zjizRU9Asf9W0zFt0N9uUrxn++Ov9JPoFd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4QqLPQJkL4SM4wq6qjb+UhhCVBrkd8MtP2ldDhaGPGQNpK3ZXpwz0hMX/GRy3np9iYBttbB+aeBkFcYWGG5i2WSxf7Dq4aaNVipuInbcolzWS9Y29yBfotlh/umN+1+lLOYtIEp9Xx/iwYO3m5XpM0AT0klIiLmXOVf308ikdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LW6hOuHY; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed9c19248bso8309901cf.1
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 00:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765527917; x=1766132717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wwk0vpdmWnTppQn93r2gATsd1xj+BtlsqtMHO9pGpOk=;
        b=LW6hOuHYP8piAGrLOx9qUXnonLbEA+wIX2Ctt++aDz7s6NSRjhNT3Gsgtk5kBsm6iH
         ulI5YzCQ1tTlVWUpYtNsJkA3WX/8Owb0eWUbJ+G/F477rYdiIc6NkfjU6i2SowxVt4sb
         aPeiYW9MOzGDD9t2TS4pyLkyzwq6KMYUCQ0JuZTVqnz4UKC+2Ax2O+z7pWB4jWjot/rh
         UR8M/rvWT18tJ7+AfQyLfwkmuqb+6PjLAPHFGCH4WHooXSVaSQorykwbbRfwCIUvfye8
         kIm97Mq9uh6sFj+m75kKzEvf9cxhbIomhdB+K2klXKNbkoShZHkvnOvfxmpYA+5xTkSn
         OQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765527917; x=1766132717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wwk0vpdmWnTppQn93r2gATsd1xj+BtlsqtMHO9pGpOk=;
        b=J468WFtTVnINUU+tVf02xfEXNRj7nLnZeUXpn2sxncfySeAKBcoyTrd/MLVsEMxW3I
         HFTACbJz3iGJG5F0xVwWeaWSnKjusdpQV2uCpgJlGownJ9fSe1ciDaCijAuIZHZzhF4X
         lvuiiiaeGLD2Wc1EUBzoD0+Vr3a9zyCjdwEIFXQTJ8YDsY4qON03upOAta3Gs3bs9JbY
         dGDRTNvVGqrGfqKoLnzHA1Sh3+vaAOVPkA/x7dLBUg8vtP0JgCZg+ZW8RsbDaPooax43
         yXaxWrkVVhc1HQB330gi43CAoW8hnyEOH7anvfNcy8Go6hoPlwoLp5TsOWscSeSjotDL
         IN6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9jkrIRwMSx7bbuD+bcB7coxllvlEj47CtyrgT/SgX7qPeDPzelHA8Bk5xGa6X7eZ/tsTDByg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMXyU4+9jB5XoO8apDXs3lziWDMFGShSNH5wFAqf6GlRL3iHRV
	mLypXsKK2fD3mCMOndBD/gkm0NoEgwD7SopfnXmzLVjTQZQVC2rc9H9TDE6W/TJMQJ9C/iOkjH2
	0nlU9QtFndLSMu8CRguJJmVGT5tQAQTjzxPZOmSkb
X-Gm-Gg: AY/fxX6SbRYYHvxutAuXPTu9cbt3gubCcYTT4rsV2EN6icIBXMwWLy18BrAf6/sytRg
	g1l7Yk8sJEj9scpNBhUoRxlAccK3S0JoZCDfndAZAVo8ZqWloGxcZfHlsGYohe2aQ/MjgMfGFVy
	bcMwSlttIlA0a1H0j3Eqhglm9H/PwAiviipYoDNiuJNEcXxpXr/zSZ6Wsqq69a7LJ08MPzMkjXq
	IcQlXehHHNaFjzmFUBuPAfUFVj7zCPuAMmN1sxUz9Nxzw9bd+EtzLnyNfKxQcUT2/SQfMUkiOLa
	+bi5CA==
X-Google-Smtp-Source: AGHT+IENyh5tE1ZSVfSUBGnli+cresJ4W+JWe59MuLZErNnVwSXXphlI/PXbDY1R1MLiVWK8UpgDYLsN6Kw7PmN7NzY=
X-Received: by 2002:a05:622a:5c19:b0:4ed:df82:ca30 with SMTP id
 d75a77b69052e-4f1d0462ec1mr16313801cf.13.1765527916642; Fri, 12 Dec 2025
 00:25:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MEYPR01MB7886119A494C646719A3F77CAFA0A@MEYPR01MB7886.ausprd01.prod.outlook.com>
 <willemdebruijn.kernel.3905bafb42307@gmail.com> <SYBPR01MB788187F80FD1A6ED59F0A0E7AFAEA@SYBPR01MB7881.ausprd01.prod.outlook.com>
In-Reply-To: <SYBPR01MB788187F80FD1A6ED59F0A0E7AFAEA@SYBPR01MB7881.ausprd01.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 12 Dec 2025 09:25:05 +0100
X-Gm-Features: AQt7F2r6NAQoofvS5-3MqYrfEG6WWfLn4EkrWXIRKKlCU4TnF6chRhZ9Kxy_jAc
Message-ID: <CANn89iK9=ShciESdwUbKSKH6a4mntV5GuUQgsaWv5b-coOxuJg@mail.gmail.com>
Subject: Re: [PATCH net] skb_checksum_help: fix out-of-bounds access
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yuhao Jiang <danisjiang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 4:30=E2=80=AFAM Junrui Luo <moonafterrain@outlook.c=
om> wrote:
>
> On Wednesday 10 December 2025 09:55:17 PM (+08:00), Willem de Bruijn wrot=
e:
>
> > Junrui Luo wrote:
> > > The skb_checksum_help() function does not validate negative offset
> > > values returned by skb_checksum_start_offset(). This can occur when
> > > __skb_pull() is called on a packet, increasing the headroom while
> > > leaving csum_start unchanged.
> >
> > Do you have a specific example where this happens?
>
> After testing, I found that triggering this condition in practice is
> difficult. In my test cases, normal packet processing does not create
> the conditions where headroom becomes large enough to make the offset
> negative.

I suspect this is virtio fed packet ?

Adding WARN_ONCE(true, "offset (%d) < 0\n", offset) will still trigger
bugs as far as syzbot is concerned.

BTW, the current code following your added code should catch the bug the sa=
me,
so your patch makes no difference ?

      if (unlikely(offset >=3D skb_headlen(skb))) {
                DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
                WARN_ONCE(true, "offset (%d) >=3D skb_headlen() (%u)\n",

Because offset is promoted to "unsigned int", as skb_headlen() is "unsigned=
 int"

Look at commits eeee4b77dc52b ("net: add more debug info in
skb_checksum_help()")
and 26c29961b1424 ("net: refine debug info in skb_checksum_help()")

