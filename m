Return-Path: <netdev+bounces-248037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37190D0262B
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 12:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C12131F33FA
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 11:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04F73A961B;
	Thu,  8 Jan 2026 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYI109jR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B03739E6D7
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868347; cv=none; b=oOWvvM+1Lk0G2WxMuYb280+1epSugZVKrzXsmA5FxsszFT8Ur8hwKefXXg9j6J4wIlKtqSSUp9hi6gzqGRYd8gzPJPLt11n3lj1W2mSGbf8XNdTB9cQZ5pfhAZQaoy8vtKcNNsGVsJ7PTRh+0VH9wjvMf8DS/zwFoGuFWPIL4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868347; c=relaxed/simple;
	bh=R2K+i1sRQKmSf8yyiZ0axORAp9DYHsv+qjGYYzdkAi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYWZ0Elf66htcgOZpTCUN6DIahCoRrptMaG4Q6LpvnGhElqW+Wj5Oe1HygQQiKRJYIWTtMoABR7zQYGl7Bxw4jZpT0yrPAz83Ppe/PDRa+GIiFzNRmhis+2nUJ7swiu6TNZCWOmy+gXWjHBrshtJFLzWKDNwIP/Be1iMgp97g9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WYI109jR; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4fb68720518so30644311cf.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 02:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767868337; x=1768473137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok3n6452CCn2akqoUJ4qnpNLPbUKwpWUXAR9kiMAF0c=;
        b=WYI109jRM4F/eCVbKIWmEp7Ozmw8Qmb+0LULE++Sn16pPCOjjoE3k+59AXapKEsYiZ
         2wPf4Mlaipiodl3TjRwi8Ti+Etwooye5O6Yq0VucV1mZw9QLpJUbcQKVV/gEflWSv71U
         9aKEVt0N4jf1tRfcMjQjY4tnVj5PYzrx3vh+hIr9K3kqRqvJDjjBru8T0GgffVtEFmvx
         hPFOcxT4m4DnYD66aqP+mIZaiFjH8HVF0684vvFuZU9iWgjkc9FzuUUi5XQT165yKu4G
         KJ//tuwWIGV4hp4AMeiit73tXFIxfHZ82m4XgYYclPdetGuXbSsylP+zmo1dQ5kF4Aik
         bpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868337; x=1768473137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ok3n6452CCn2akqoUJ4qnpNLPbUKwpWUXAR9kiMAF0c=;
        b=TwnMEaWuOhPGWIs6/KEbjyvKFGs7qUuMqP+O+JEP0pLLpCeH9N3qb31IkfTEQYDcrf
         rJyCZv5uJq7aXhaOdHkoxPbMRqATWm9iQjHxoJ/arpKanh7y3FdewCkCvJdbLNOI1kCb
         KARElYjSNUWBxuK0m+KoDE+uxrlhBr5M9+ZUg+WbZriY25Tyrfa3BY0w925bTmp5C4a2
         sce+fRcWWIP4661uQzsAYJ3J81Smm46OIotQoQX+NhcR/nLqhjxlDCPj50Q4ZBEwrctB
         9+9zK32aNtyoUBAnYyVBvvnPdsn4V02ukqaCCRv/OBJWqwt1pz8IIRU4WxSy/rOpuIl7
         ZF8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAx/bUcTj06B1vbxZaS/T39NE3TMBb+uE6xpgJsT2e5A36UFxJBQELDN2Qt8iLY4wtMQkPqfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKRAQRTdQzE7SruMGRiQIr+E14IqM4DjQ+t9cOlFpTX0wvNHpr
	/TbC2l1vnLU8zTr19Ap32FQs1DqkBDDjAynbBASF13WKsEfvG5bVga5zCc6/PNaqE2ZRRyD48mz
	Gh8+HO9QUxMRIbMmeBZ+ig8wxY2ObRBLpkGEGw/gx
X-Gm-Gg: AY/fxX69jJZsBiGMzynAyWfv7Jbwi+60ADfBKc6QSe4yKZdJgaFcAN1DtgDZk3JjFfW
	+ydgYk8nfrfXjkT604l48iDy+R6sKUJTeJW0VBXWho44Y3R5NjvD9hR9Zd60DlVoz8r70JdelEH
	tFws388Vhi6/tyOMq8drUp0czCAxgQe2ILeRckmjnSd6lMIoDrtEJIsK4Rhz4Vm5tfz35eY4uqr
	/l8CSgouZpJTzFxwwtHat07ZOxM8Nqy/zYLi58sUPc4MkNl7cjF1tPphg5P8z8bBiINWA==
X-Google-Smtp-Source: AGHT+IFY03QOD+rpaee6JMJz5V1Q+LtZHzyW9QYCkUaj/PQGgBqN8ctNNUwKRAG43fFXIBU1U0KMnEepQ85YQps45bM=
X-Received: by 2002:a05:622a:248d:b0:4f1:b1f5:277b with SMTP id
 d75a77b69052e-4ffb48a8654mr78118021cf.23.1767868336738; Thu, 08 Jan 2026
 02:32:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108101927.857582-1-edumazet@google.com> <851802c967b92b5ea2ce93e8577107acd43d2034.camel@sipsolutions.net>
In-Reply-To: <851802c967b92b5ea2ce93e8577107acd43d2034.camel@sipsolutions.net>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 8 Jan 2026 11:32:04 +0100
X-Gm-Features: AQt7F2p-y5UbYRv-TWHGNGwam1_iRtt3bbPJlg6n-RcD7sW7wTP_mSOnZxUlj-8
Message-ID: <CANn89iLxDc9viP0Pmj3uC01s46eUR2xu4XAUEo=he-M84aCf9A@mail.gmail.com>
Subject: Re: [PATCH net] wifi: avoid kernel-infoleak from struct iw_point
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 11:29=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Thu, 2026-01-08 at 10:19 +0000, Eric Dumazet wrote:
> > struct iw_point has a 32bit hole on 64bit arches.
> >
> > struct iw_point {
> >   void __user   *pointer;       /* Pointer to the data  (in user space)=
 */
> >   __u16         length;         /* number of fields or size in bytes */
> >   __u16         flags;          /* Optional params */
> > };
> >
> > Make sure to zero the structure to avoid dislosing 32bits of kernel dat=
a
> > to user space.
>
> Heh, wow. Talk about old code.
>
> > Reported-by: syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com
> > https://lore.kernel.org/netdev/695f83f3.050a0220.1c677c.0392.GAE@google=
.com/T/#u
>
> Was that intentionally without Link: or some other tag?

Somehow the Closes: prefix has been lost when I cooked the patch.

Closes: https://lore.kernel.org/netdev/695f83f3.050a0220.1c677c.0392.GAE@go=
ogle.com/T/#u

Let me know if you want a V2, thanks.

>
> johannes

