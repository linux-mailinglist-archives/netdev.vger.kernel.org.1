Return-Path: <netdev+bounces-130783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0929598B853
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7AAC1F23276
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA98F19F426;
	Tue,  1 Oct 2024 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/d2Jnva"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1209119E7EB
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727774854; cv=none; b=twAd1YnvTBx+OcLd+h43MHBFiZi4PJ1D/7smO6zacAuvLjozXJtdrnRDmc2JIABHQ5sl+AAoyFKfJtYZ3i4iTjEDD7VqLbIvPCkOcUrFjWAu90kQfkgeagY4b24Xb6TWj31stlenkLS0YcjT0VJZmKRFk9V2idOT/MuUKZa1PHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727774854; c=relaxed/simple;
	bh=qryTlIw44tljbydI9cM6jr79AdPw0561rlHpH78CKcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0Ggcgm4LbFlW8a+eNE+XzQ9HR7xyhB2FuGE86vRbB8FntT6okvIXaOMvU0iARJSxmg7go92UDcnbQWOft8sfefKxMNC0NAtVT85hsRXkCxuVowiHUbcr40hdhUkeDJ0h0x9MVtc2Jqq+TxP5xGkO35ofotk6xNxv1Vq3n/3/8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i/d2Jnva; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c881aa669fso5638943a12.0
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 02:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727774851; x=1728379651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qryTlIw44tljbydI9cM6jr79AdPw0561rlHpH78CKcU=;
        b=i/d2Jnvaxi0CW2A4eBrLnEIDFAWDoBZefIKeIsMsEIPoABkWSJB9IB9pELJm8NiRFF
         dLtyJjc4+r9YN/uxREOOVo9HgfxEkSnd6OmH3ZU9ARjXYFJHJNFn1Ccch24+LpAQsQU/
         FXYxs6y17JkrXDEwVkhuObu1+GOBKT0wBfEgngMSv4HSQu8ygsaa5o2HKRT6cnk9U0dn
         ahDTyDy+iofssXdcXC+yxr7/5yEv/Brd3TRi3M3xGZhwwDrvwQtSuDmSu0ihQU9jCD9r
         O+AA+nyhGlLfh6N0xyUkJ4L8+3AjrxKizaxPJ9jUCfU4qU+X0TQsjZitKwTiUZJ7Q9i4
         7DbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727774851; x=1728379651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qryTlIw44tljbydI9cM6jr79AdPw0561rlHpH78CKcU=;
        b=G1JLHSW43vFLYPhVCF6WpVTuaLBB9okBbPGdZ3ql0lmEorjujvABbULyfa3L+aLlUG
         Ag053cba8luYOQiLZLOzHNFWtJmiwxMiCAIcnPMQD9xZEaDDkUL7MWG/zTdb+Lu4PRag
         vDNt0nyu/pidcxmejC76ziiy7h9yN3govvKqmT/0xYJyjcfncmdsWSL6zpX918BbD59h
         Y9i+/xq/n6IjjXwSlNxHJX0H4h8HniINGK4RV71w06NIkOghe224pdsH2bUnjPJdegdS
         JUY2IO0t+gDvYpbFYT/HZaS25A7LIK9lSVtdWl5yLh2mi//oyI6YcIlFr/PDUBNmtB9G
         zLsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3Z/AAGfg07psxwE4hISEwkx7eQ5LTqkjDWP36qsSNaYGl1XS8HcLxMglAzkJKMO6OF+C4Tt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfRM49dFIDYitmnO2fWt47IxYbpmiQil19USM9euJ1WhNi5B0P
	7VJdxGwU9VrCTYTvwDHFbUwmTOXcVdI7ygM2AMqn6YGN0bSWC1+jWxR8r4sbitNJugHIanvBuvC
	hqdt5s6uRwr1vVffrzUeEQysObJ/jHDe2mFLy
X-Google-Smtp-Source: AGHT+IHwfLAymGLHpxNJw9wTqBOUzLO4eYX4Zz5BG0jkzXqBtTFO1RDITgETNgs4YxlFdUzPKpw94HnqM46Tpy0KIC0=
X-Received: by 2002:a05:6402:2815:b0:5c5:b682:64aa with SMTP id
 4fb4d7f45d1cf-5c882600342mr13758902a12.26.1727774850922; Tue, 01 Oct 2024
 02:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001024837.96425-1-kuniyu@amazon.com> <20241001024837.96425-6-kuniyu@amazon.com>
In-Reply-To: <20241001024837.96425-6-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Oct 2024 11:27:18 +0200
Message-ID: <CANn89iLhKGoRgxQPm66NfMSWmjQg+Df1oUt9xt5wQnLOxXAWpQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 5/5] ipv4: Trigger check_lifetime() only when necessary.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 4:51=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> DHCP is unlikely to be used in non-root network namespaces, and GC is
> unnecessary in such cases.
>
> Let's count the number of non-permanent IPv4 addresses and schedule GC
> only when the count is not zero.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

I find this a bit distracting honestly.

Lets focus on RTNL first, there are already a lot of reviews.

