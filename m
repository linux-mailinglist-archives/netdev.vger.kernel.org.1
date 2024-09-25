Return-Path: <netdev+bounces-129817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6977C98663D
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 20:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0B61F26BAD
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 18:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317CA5C603;
	Wed, 25 Sep 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="JecAUayc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1871D5ADD
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727288858; cv=none; b=D6twXz+t1W/D9BOSh1ZxAQ797LVqcWnK9vRD2NSJVTZuaoa1zpxw6QAq38jVyft3UzIXmpuvzzIF2pcYny1AYoOOzHdouKBXsCqO5S91N2PznR02sA7TslOswFarEpce93le4I/xYwxI7n3SMjwAaiXND/7wZ8L0AE4LkulAur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727288858; c=relaxed/simple;
	bh=TnkfzuiXddeWf55wzY8Ww0XUHUt9AFaEwhrgXKzlDsA=;
	h=From:Date:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WD45B3UDfJ0ImzgRHwhkPFCW0mvq6IX5836GqVq08NAM7UHKhN0suLf/ScISY5ZY970WsvzlE0wJ8m0AkbubBbhHTj8jgdCSGd5VMXO673g1PRiYNJGsMAoEZc6a4CW2dTc24UJ1o0a7hYADlOUWogfK8Bm9El/KZFG8oOzsMu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=JecAUayc; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-710e1a48130so70993a34.1
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 11:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1727288855; x=1727893655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnkfzuiXddeWf55wzY8Ww0XUHUt9AFaEwhrgXKzlDsA=;
        b=JecAUaycSDOP5R3PWq3XKkzBciq8jDMH77Bdc42Uj12tgBkzfk36lwzFfcRWRnXDAR
         Wv+JJovvlcR53YKfrWg0o7DothsRD52UHRRKQtQEwz9pskoCtv/EHPMf9rczsGp9AJn4
         0WoXDv4xp9/g++UFlVdrtm8PRUjK3KE/DMTKwsTsrCOVbmuWu56qpJa2xFp6R/z7THim
         TQWlYiCeuLlfyg+d2tONMyK4quxz48kYCo1To/ZdfW4EBJm5/CZ/BUHmDCG/ZR7oK6nQ
         bmKlbL0pyaOEiVp+y0jL8TpjoUKLNbonYf+Navc33BmMgxXSEplOV1r3mviMocIKfQOO
         o/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727288855; x=1727893655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnkfzuiXddeWf55wzY8Ww0XUHUt9AFaEwhrgXKzlDsA=;
        b=KajfTuZU6Fi6Q7fztIGS45RZTncJrTiBNBeyGy4mo6wqOYbplWoBegGE7zPbsn5k1C
         dEF4Rylo3BOUKUJumQrkk8uttK3BQZ3uEYKrMs6CS1J3gI12Q9EKLXI85h1QLIS9XwA4
         pv8E3jUVHj2n0lVYJV6TZuRATxTlXCs8s9bPgcuvV4SG7IF3vTYFi4mXxTPwAp/HgxOf
         c8bUzIqRywv+Jlxq4jRTqe6zSqM4cRmxRFxOjCHlAeyust8mGH5Hu9XIH0nHJx6/8Gnl
         LGxpoKtwAeXn23b+XKvYZZzoJp+/Y5sOGQLvA5zxtgB/KQ0AEr/4opysmV3BKPHkbK2B
         O/Nw==
X-Forwarded-Encrypted: i=1; AJvYcCX2Ls/UiynQDFTrLKcY5fZv5V9tYw8jnfpOf2J0gYKn7kupEBF5dtPJ3LL/pzaLlkxox8fUxcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEBjzkllkzREMevWp2GdQCnk1br8BhM0L4EPDd3cuTGpiH93NY
	GGfIBPFRw1cc2GVPlOQUUe1aCEF2cM19KrlTXH5oT4gA4PrC99xbpPAu5ztP2lY=
X-Google-Smtp-Source: AGHT+IGiWWSlxL/gWavaztC+CEENwUhE8dGZB5PJRKi+S9Xuu8ye+f7V4P+L1fZZPrKrnUx7V5u4wA==
X-Received: by 2002:a05:6358:c82:b0:1b8:2cf8:cf6 with SMTP id e5c5f4694b2df-1bea86a17dbmr187965955d.25.1727288855091;
        Wed, 25 Sep 2024 11:27:35 -0700 (PDT)
Received: from fedora ([173.242.185.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f55437csm18245066d6.103.2024.09.25.11.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 11:27:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
X-Google-Original-From: Stephen Hemminger <steppohen@networkplumber.org>
Date: Wed, 25 Sep 2024 11:27:33 -0700
To: Joe Damato <jdamato@fastly.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>, Jonathan
 Davies <jonathan.davies@nutanix.com>, eric.dumazet@gmail.com
Subject: Re: [PATCH net 2/2] net: add more sanity checks to
 qdisc_pkt_len_init()
Message-ID: <20240925112733.5654dd49@fedora>
In-Reply-To: <ZvRVRL6xCTIbfnAe@LQ3V64L9R2>
References: <20240924150257.1059524-1-edumazet@google.com>
	<20240924150257.1059524-3-edumazet@google.com>
	<ZvRNvTdnCxzeXmse@LQ3V64L9R2>
	<CANn89iKnOEoH8hUd==FVi=P58q=Y6PG1Busc1E=GPiBTyZg1Jw@mail.gmail.com>
	<ZvRVRL6xCTIbfnAe@LQ3V64L9R2>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Sep 2024 11:24:04 -0700
Joe Damato <jdamato@fastly.com> wrote:

> On Wed, Sep 25, 2024 at 08:00:08PM +0200, Eric Dumazet wrote:
> > On Wed, Sep 25, 2024 at 7:52=E2=80=AFPM Joe Damato <jdamato@fastly.com>=
 wrote: =20
> > >
> > > On Tue, Sep 24, 2024 at 03:02:57PM +0000, Eric Dumazet wrote: =20
> > > > One path takes care of SKB_GSO_DODGY, assuming
> > > > skb->len is bigger than hdr_len. =20
> > >
> > > My only comment, which you may feel free to ignore, is that we've
> > > recently merged a change to replace the term 'sanity check' in the
> > > code [1].
> > >
> > > Given that work is being done to replace terminology in the source
> > > code, I am wondering if that same ruling applies to commit messages.
> > >
> > > If so, perhaps the title of this commit can be adjusted?
> > >
> > > [1]: https://lore.kernel.org/netdev/20240912171446.12854-1-stephen@ne=
tworkplumber.org/ =20
> >=20
> > I guess I could write the changelog in French, to make sure it is all g=
ood. =20
>=20
> You could, but then I'd probably email you and remind you that the
> documentation explicitly says "It=E2=80=99s important to describe the cha=
nge
> in plain English" [1].
>=20
> > git log --oneline --grep "sanity check" | wc -l
> > 3397 =20
>=20
> I don't know what this means. We've done it in the past and so
> should continue to do it in the future? OK.
>=20
> > I dunno... =20
>=20
> Me either, but if code is being merged as recently as a few days ago
> to remove this term...
>=20
> [1]: https://www.kernel.org/doc/html/v6.11/process/submitting-patches.htm=
l#describe-your-changes
>=20

Less concerned about commit log or subject.
My patch was more about keeping non-inclusive naming out of current code ba=
se.


