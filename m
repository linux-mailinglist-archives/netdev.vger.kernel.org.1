Return-Path: <netdev+bounces-207372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF76B06E6E
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2A3503BA6
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59378289E03;
	Wed, 16 Jul 2025 07:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EDDjHDi9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBA5289836
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 07:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649310; cv=none; b=ebZ8tnkLetffjiXb3j35oyti02XFSEmGABG2hJLVPVxYO1R1q698YPW4gUrYcKI0zWzzmM/8C9RHwe57SA0DB29f5b1PpoeFnhL5eHJs8EPK1FeeOJi1rS0iEWW4s+RVJDfi5mOQJol8El32sOcMh+t+hebI4lD7fWlro+iMqm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649310; c=relaxed/simple;
	bh=TjBxw0ZbYUxDd09Gus5OTIQeRa01nmdnRJ/nFwZmdkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgSaT4GEPe8a8Ty7aD207OCwWDYCmps/+vT64jN4aBX6rjqVxxZ30kZWH7NSmJuzghhYMNkJUJv57OxhmDhxEtdYnNF0FklfZAiin25ovTJ+whbrs9WkQNoSiRgdCPxx6Fc2QqvAw9fYPdGa2w00O0vOImOcoA/a5axSbvbryYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EDDjHDi9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-311e46d38ddso5688964a91.0
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 00:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752649308; x=1753254108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLPGDz8hFCdQ6XIcuG3Zs9O2wfWHRs5I4iEshbfFHc=;
        b=EDDjHDi9Ir37EhPYckiuL+GMIrvbD02ItEeN8VAU7NAa8XUAgChWY1kQJBTUiZZIbC
         TFnDtMm52VhVweHlv4aU9UCfV6OvsuGk/1ha1YPgpWLFaaLEV1vEY9uyl8nplT6OVayP
         Dn5f34rJXxy4WsrA2g0vTEODAOlE1J7rvVEdfiphANWqDPMQ2gVRH9y9ZXz7WisIyo6a
         jXwej64qCIUTOJAQ8kRtJeVQlgLAkF4+C0Kv24Q8+jFOtPaEhdz1m9LjktQghdbIpzxR
         LB4uHFnKrjmmFSzVvB/FUDOXT4cpKdMtcJuAgRYqGlMHoAnlmCL9CUuUD8CAIyM56/R2
         USWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752649308; x=1753254108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLPGDz8hFCdQ6XIcuG3Zs9O2wfWHRs5I4iEshbfFHc=;
        b=O+7CGlvY9cWFdJ7bLqW0QyKWWpu4TgcD8jDCdU1c2wmGQ6x2yp6PrG6Q5MiFklOWdd
         9UO9A1dTMm+5mJoN98pR4ilo862E580MhaHGok7elG8SCrGv0oLGjvFyOPKVoxXwhZD4
         hIVS17U0CfZ4jqbjLWLJCMFLGaR90dnz4Z7xkm0y/Nj2LwoO9uxIsF3fkJU3OPM4YGGi
         TLm9Kc+y6XxRLLMVPpLvzvMaQzvxbtB33xSdMaCF496hkf0gAA1LfSaiReZ9OMuauy1s
         lbdv67uJ9ovd7t3Woj0IB49BrwVyc8OMJ73mS9T9zV/QlQ8eogtVgT1MFocyw+E1oR70
         VJAA==
X-Forwarded-Encrypted: i=1; AJvYcCUh3RVPyQIWSsBV9+W8jIP/hA19dbSgnGtsPTKa1SLWFYiN/F/Z2sWGdn0cM64fCPzBWrShBYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD8/qym6Hs1H8SPV6XOMRiipr8B46nm+7WdQuaIg/4W4tQxvml
	4jz/JCTt5AfSR8dfGZzPCd7hIkcm9Cv1swq+8QIex+VKn0iKIXHXd23rHyjO1TBtZg9qUhPDwhn
	LI23toU8GQ9WIdpYgsF2keBfMW3l1UOHUge5Gzp+odvnL2Fn9N72m33neWGA/Lw==
X-Gm-Gg: ASbGncve/x1j8s5wVStvAN/S7xkDfG4M8huVTCGQUBia84C6tCfvXetcYl/RiQMogIr
	gSicjChCUmVui7UAd7fHB7bCf1ASkGCSqPMEdcBtWSWGXhf4xiawVA0t6cnngzQVYAzGFFPzpyT
	Y/jkXuvQUi+OPBq5vV0ZvetR2elxOkV60R/fIEEdryexPXprbyqS0KC4L74Lj8ZD+erIEw30n/2
	u18Ot7uo33tbM3sq5TOzgsZAqly+cLjcMtUNCwjQzki3DNyaqY=
X-Google-Smtp-Source: AGHT+IFNVe/yoy2l22ab9a8GjdEdDIX9GsBXaUmi7UloQQLi1IbEUFastxWzuBZLTUKoAueLenbE61C+yyu0VmMxO1U=
X-Received: by 2002:a17:90b:47:b0:311:b005:93d4 with SMTP id
 98e67ed59e1d1-31c9e778b03mr2963391a91.25.1752649307866; Wed, 16 Jul 2025
 00:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712203515.4099110-1-kuniyu@google.com> <20250712203515.4099110-4-kuniyu@google.com>
 <20250715182343.5ed6f8fc@kernel.org>
In-Reply-To: <20250715182343.5ed6f8fc@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 16 Jul 2025 00:01:35 -0700
X-Gm-Features: Ac12FXwkenjYF0GiHvzBKPeiKiezm-3f7ny4LAVRHq1pjrxCal8Eu1BRLTgrxA8
Message-ID: <CAAVpQUDmsjJ+5u9YNe3+Z6eck7eafEFzR4DBD=Tu8fi03UcqoQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 03/15] neighbour: Allocate skb in neigh_get().
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 6:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 12 Jul 2025 20:34:12 +0000 Kuniyuki Iwashima wrote:
> > +                     err =3D -ENOENT;
> > +                     goto err;
>
> nit: maybe name the label ? err_free_skb ?

I think this was not to rename all labels to unlock: later in patch 9,
but unlock or something will look better exactly.

---8<---
 err:
+       rcu_read_unlock();
        kfree_skb(skb);
        return err;
 }
---8<---

