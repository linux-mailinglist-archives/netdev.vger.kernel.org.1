Return-Path: <netdev+bounces-207373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE8BB06E71
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DA43A7D65
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D0B289806;
	Wed, 16 Jul 2025 07:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GIyrnurI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6F3286D46
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 07:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649381; cv=none; b=L3US0EdXMjFqYBLeLrwJtSMWgKH1G4fkvBVIqqcHh8GlXoAV2wH0bNdFGaUT6AteZAQvGfGK0xJv22lyYTle4ISQ1WfQ3m0qGydAc9KLXF4bL3fsMcN4kN0Yli9W6H50gszh0qzVOamN5BnTa1uGFr+spUyRPKQie7I+zc2je3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649381; c=relaxed/simple;
	bh=YA5e8XgLeH7Y35IYolvp872+6J6dF/iB0usK+D8kICQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5qOhmusN+OCd/TygzM5zZouZm065sGFjNBcky1oGxEEsNQWSc6z/X1XCrG4EcvaqbPHjuSefx0EzVaMMXUnQtfo5BjuabPEkl+JzEpWrg4FE42RMrolXzl7uCSwUeW/9tv+j/6N0VluOsC6hjKfdoUrThclfTeA53d0PhclRe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GIyrnurI; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-311e46d38ddso5689725a91.0
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 00:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752649379; x=1753254179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlHM0w3yktR4XSfjvK9upZ3pyvvJ6wR7Ij5RKEq735E=;
        b=GIyrnurIzGjFgFTo1f422ZBhCXjm4Pn6Od98Y51f71GdrbzUGDE6lSfEJ0dO8eaF9o
         6N42xtA3WUghF5AVqeOEX1ZDTpPaGGL3s/5/MfGPb3sGsVkK6Z0dITTFT4/AtQGZm/wW
         qTOs4iPWUTmTTiNlo7WENdr0yf6TmQHLMjvxeheYSnauDCrn5tLiFEAvMYDOorG4BjFo
         oGCldtu8MomchHC97k03Voeh6KnD6aHhH2Z75y2XE9e+UF8drWPrCOKVH5L2aVGF7Bqs
         CmuM3BgOI1tJpMaSWgZ7IN/M78C3T+U/v3mOFzDlKxPrAYh6uelvR9o1FtjbIwi4Ndd6
         d/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752649379; x=1753254179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlHM0w3yktR4XSfjvK9upZ3pyvvJ6wR7Ij5RKEq735E=;
        b=cqvGetLvagtCbkU2b3QznVV50zCf1qIKh52ytMyMpFOxD7Qt495Zh32IZ+sglw5m/a
         c+0XRpjKWqhQJbJsqgnwYxEWRiZKQzVd7tr2KDRPETyqzKW/iFNscMb07MSYhDWcs/9V
         mjDMjHhst+BzjmdM4bP7AuCM0wfYj6CekwrwXdIdy5BtzZ3OSxZ0fiUNcD54IC1PPjGf
         WoaNIkGkhq0oX/0IINF9+jnjHpxY4TqPquIyPHGOVELMVgoPWGo0b7JNmN0U4PNCMIq1
         5GHKORxMKnibZ9QiN/qNMKCKamZXI90d+kWAqc5DOtBEH/z15VT3dVQid23wW798SDRt
         MLTw==
X-Forwarded-Encrypted: i=1; AJvYcCWj6stDRzTAdCeFc3CHgmhckltR5hbVfsnstiXtGab5XIKBbsTB10KOPNGsgiez/8uthc0EzkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIp1SHtbtZGiDfUU/pgbo8L+z9QP28NjX3XAyP2EliyrK6E6kg
	LzKD6j4nJuputnND7HtvGVtvD8Obp/Fi9bfJ52I7yIqsSF5FIKzBo7eOMdQR9rKeFZuIMm9AdLx
	c6ICe5kt24l3JJ42L5FdopwhKrT5SubPbomSgg8F0
X-Gm-Gg: ASbGncsY1TaLmwr4gvQdyl9oMSuffnI0P/utUUOaokm0Dpa6h4s027B5L3fLyusH6J9
	NUSYC+3xJQuqkgQ5Wa05zUIxROmvc38F7/hvdfH2GSXszxq0StK7PtT6ib+l/eJ6TG6h85XrH1o
	12nZIdiQsGcJW1+mv+oUTTieqiZuJY89872yGTIDpuTGUrZt+B0XhaMew+NEdM0J0C9d5rk4zT+
	atLecqhux4jpMBGphT5NfS7koUmPmW2w7qpNSIP
X-Google-Smtp-Source: AGHT+IG5F8Nhk4gsG2MJN5owtRBkT0kvrQdvHIQJomjpq0+5EcoKG8AQpsMpzjCKnDsWS7EFZGqSGx7P2I5V58m13uI=
X-Received: by 2002:a17:90b:524d:b0:30e:9349:2da2 with SMTP id
 98e67ed59e1d1-31c9e6e9238mr2889254a91.4.1752649378830; Wed, 16 Jul 2025
 00:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712203515.4099110-1-kuniyu@google.com> <20250712203515.4099110-9-kuniyu@google.com>
 <20250715183721.5e574b33@kernel.org>
In-Reply-To: <20250715183721.5e574b33@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 16 Jul 2025 00:02:46 -0700
X-Gm-Features: Ac12FXz-MmgiLWyNO4g17q6iQalIxa2ibiq4MpmKrxfYkELwDN-0XZaXEHaInIw
Message-ID: <CAAVpQUAC=hw0h3Cn77rApn9iNme90DX_wz7zqd3xUu+cMB=ELA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 08/15] neighbour: Annotate access to struct pneigh_entry.{flags,protocol}.
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 6:37=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 12 Jul 2025 20:34:17 +0000 Kuniyuki Iwashima wrote:
> > -     if (pn->protocol && nla_put_u8(skb, NDA_PROTOCOL, pn->protocol))
> > +     if (pn->protocol && nla_put_u8(skb, NDA_PROTOCOL, READ_ONCE(pn->p=
rotocol)))
>
> I don't have a good sense of what's idiomatic for READ_ONCE() but
> reading the same member twice in one condition, once with READ_ONCE()
> and once without looks a bit funny to me :S

Oh sorry, somehow I forgot to cache it.  Will fix it, thanks!


> --
> no real bugs, but I hope at least one of the nit picks is worth
> addressing ;) so
> pw-bot: cr

