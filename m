Return-Path: <netdev+bounces-162902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF4AA28548
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 09:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2DB161D7B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 08:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D172144A4;
	Wed,  5 Feb 2025 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3+QQcrPt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D212147E6
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742730; cv=none; b=GpdvYlkFAjIJqsMAyPtLvfv1poQ0cHsHjUwZPyo+Oeu/+f3FgbuzHLfNST6QStAyfyo1frTU4/XBrLLd4D19RfGyUunhQIvzrvQYJjMoqdO9/lnLNS5HNJVK9Jftl7m2ICS1h14OlWzT+aGoaaT0cGjKjXOE/aYwJVWGgWykgJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742730; c=relaxed/simple;
	bh=8zo9UiMtaw4DKOqW5Dg6bGLEtAHpv/+avVSiD07aQjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpyqvZn3e1ULdSQv9BV8ZchYnGTYGU0gYVxndKPOxqgMgwmMF5TvYmKRvq3noJc051AtIxBc9YbNc3IqMzGfDv/SSs05JfU1zEkFMyu7PqfEc4qaHyFZZfnbeggklmKCpn+CrfRSPhA39n5y+gVcxxEI9gIRWd5jzSbJ6rkJVRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3+QQcrPt; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aab925654d9so18715566b.2
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 00:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738742727; x=1739347527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zo9UiMtaw4DKOqW5Dg6bGLEtAHpv/+avVSiD07aQjw=;
        b=3+QQcrPt66sIHWnT1CXj4NDEI0D4E2x1tXinpi0tn3RezigHMbnW5qZaeRnHCRiz2k
         w+fdGs9xMfgbR7Gox2B+K4ok2SKjnoJ1gh5fh/zCb97TfnbWCsZK/wnPVlEO1KWh6Wjf
         Ss4JtzqR2D1ma+/NM+F2Tru8vhyw29jKXkbAzNsx5tdm14p+ttYyuxfw4Yb9z96Xp7Qd
         xxbn7qCry1RYpvNrXe0gAw6Rkg4xC5PX1v8fgbHUhhTmwFpsgU/gMR1yUMNhEXuiSwjt
         8eawd3B5QP6qWT8rN5G37WJNLRVyyVS2C+pOhrR31Pzsvq0r+JHbDYiD236C80ZbxVtJ
         Cueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738742727; x=1739347527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zo9UiMtaw4DKOqW5Dg6bGLEtAHpv/+avVSiD07aQjw=;
        b=DVWV2soSfqDt+HXpgrYDWHZEIkyplxGamCi4ijYxfjEymzOW0XSeDI66Tlwgp9Fp4M
         yWqkoH2xJG89swzj4wOM/5Cr8pOAywnCBvKQrIWS0kDNBBEnnmPCGljPtOKyI+GLdrBd
         s6a20rQTOlZKRBv5w2caSzCU9RdJ+kxEr9wzH0ASI9L5ea6JKNWe2p3yObx4KDxTymQu
         csd+XzSU0W55iFcCBxIaqpJXz7uFDmPLfwN7PRvvGDKQQrNE7DbPARkPoPyOdMfTw1cx
         MzQpkBHnWCo8RFFCTZ1A85grjGpZjtmywO06UIJXEBZ7zyrJGoKL7HDxtZW9LzIjFqEC
         hfIA==
X-Forwarded-Encrypted: i=1; AJvYcCVuDSn2wtt+yha+IOtU9RaY1IJJO71okGrz1wW7J7A4OD85EFx4To3boaI6v1dPvHvAr0f2/KY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8gLwJym9yQT/fBmauTDugvAJrqRUsHqKgJO1HHxrTCneJ4lwS
	68Z3b9HimK1qG2jyDIMOry2iQF3iEypDVsodrRSBCTxFu4cu5xXCHkEVfre2MzfGK4a2P8Pb2w7
	tnme3hWTCfYRwNW8CIl5VP3sVJBGtMUyAqj/8
X-Gm-Gg: ASbGncv0LuT26J/sSGBRyQMbLPTWhEP/HWda51kktAZuasca4ml8MD9CS0cT2fzDEAv
	gSXO7p29JB0J3OOjjtaXIIlx/VeuusULolOLjGg2KoQ4U68b4dyefmfm0VsjMmQUisGi0dcw=
X-Google-Smtp-Source: AGHT+IF/tPS7g8m5Lh0zFFpr42ZF/S4x6y7PIzl/K9hhNU1ZEDrtn3AORwaNSpJDgTzJEEaedLRVmDbrij+UTFPyEqU=
X-Received: by 2002:a17:907:9414:b0:ab2:c0b9:68d with SMTP id
 a640c23a62f3a-ab75e2141f5mr166034666b.1.1738742726840; Wed, 05 Feb 2025
 00:05:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204132357.102354-1-edumazet@google.com> <20250204132357.102354-12-edumazet@google.com>
 <20250204120903.6c616fc8@kernel.org> <CANn89i+2TrrYYXr7RFX2ZwtYfUwWQS6Qg9GNL6FGt8cdWR1dhQ@mail.gmail.com>
 <20250204130025.33682a8d@kernel.org> <CANn89iJf0K39xMpzmdWd4r_u+3xFA3B6Ep3raTBms6Z8S76Zyg@mail.gmail.com>
 <39a1fde2-63f7-4092-870f-ae20156fbb9e@paulmck-laptop> <20250204133025.78c466ec@kernel.org>
 <CANn89i+AozhFhZNK0Y4e_EqXV1=yKjGuvf43Wa6JJKWMOixWQQ@mail.gmail.com>
In-Reply-To: <CANn89i+AozhFhZNK0Y4e_EqXV1=yKjGuvf43Wa6JJKWMOixWQQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Feb 2025 09:05:15 +0100
X-Gm-Features: AWEUYZn2wyo84Ggd9HyZWG5UC81qSqlrX9lj52VMiPkHivRXYrW2OJfDm4-DPgc
Message-ID: <CANn89iKN_HRA5kO_hGghpL8Ly2qFTwjaDz1AQDZkmus28uoadw@mail.gmail.com>
Subject: Re: [PATCH v3 net 11/16] ipv6: input: convert to dev_net_rcu()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 8:57=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>

>
> I will squash this diff to the following iteration, and keep rcu_derefere=
nce()
>
>

I will shrink the series in V4 to only include known bug fixes, to
lower the risk of having 10 more iterations.

