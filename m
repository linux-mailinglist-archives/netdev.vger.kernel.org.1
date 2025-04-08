Return-Path: <netdev+bounces-180270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2056A80DA7
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446EE4A7F6C
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0554D1DE3C0;
	Tue,  8 Apr 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aP+dfGPS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FBD1AF0CA
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744121814; cv=none; b=piCxcy27KG0aTxAK97fxevoBCnV54+JV92NmppLXY7zW3N5mfWnbqRVWD/XbdPFY2gv9Rjyy5yADrMvmWQU64Gl2yvf+U2wSruotF/uKznn/gqi8iT3Cz5p4ytPzAniezThNBM/QY/baKC7MnMs12Ij3C7U0OD8f4UOjpSBBKCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744121814; c=relaxed/simple;
	bh=LPJ5DC/qJdNwC6BaugmZeWV0dPB1/Q4W000XRyMqt98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RI8bmJ+ax71DQL+qdTN7JAaLpAmFdaMnF2bBt3eSZqCdng+mB+xmUS88GDdmPFe2/B4CoNCGkqusFOSniQEPiXPcZzs3UHYuoW6HwGM+GmODKN7E5jGZt3nma+g8L3+WvTJk8WdZQxWua0vq/VBUiDXH0gJgC9YJYfYCzzuBpkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aP+dfGPS; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4767e969b94so95554061cf.2
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744121811; x=1744726611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPJ5DC/qJdNwC6BaugmZeWV0dPB1/Q4W000XRyMqt98=;
        b=aP+dfGPSKmirZPV8tjGdr3KDeDyNcXmfHJs1Aip61R5A5tf+2prq/TK02tGnfLn0TT
         +fgVZvYgflJyv+wh2El/jm1zMoHTH1lCNd2h6dHcqWSm5NM8/QK9c8yPLJIa75esu0q2
         y1N6SD8saKUtGGfNgHt29N7ph6ahbQhbNBwPZwmfRz88Nx6DeERpcgc5Gu1xhY7tyFd1
         jADaiI6cebEcthFF3zrfYDgZP8VvKOT3D+e3gio9pXCeKvbB6LiEI55g3YZvy89C7X+h
         QKfsavgYPxJuLmlImr4m2WsK7VFdxuHJgVXwVsdSAHmRAdrTQmqV9zue7y52ZeBcq0f/
         GFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744121811; x=1744726611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPJ5DC/qJdNwC6BaugmZeWV0dPB1/Q4W000XRyMqt98=;
        b=UitV+RNoizsmZGpowqka8LwCzIvIoUEjoW9OwOg+pcTfY4rZ/czmHHHG0Y/FD4Yinz
         kahtXScpum6oGN2+mXp4ZRN4KUqmhd4raFlj4YAUFzhh+hLfCC9wJ0pEIvU2Y7iEKTRS
         HzI20SjkkIWXMk0bOfdzp7UNF3Z36/PZqxJdY4oHQ5FzwZnMWdwbr59sZhBjQSHlwDoh
         XwnKGIrBXGTJs5Xd5zz0dEZBQgaOWSW2FsY8A+9LBN3xNpE6ZXrIOlowbDs5+Yg91Ew1
         bElC9VtFXfKSa+yzdifr5UNCRUYs1IudXHOQ9FzGh4Va/4vaXUFnIkYb+aJTXphtuGJ2
         kicg==
X-Forwarded-Encrypted: i=1; AJvYcCXPuSZgwfsNpq3gIfDNFp1zc/2TBBgStBpA3j7pnebfbuScveS6yfuMSkgEklqHTaxQXqUGPxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1HoY//DU+kafESRy5KHhL+LNaVVF4ITh1TB4+wnlAMDfOm120
	hCEfWvb93dIGjdVHRsQLcBVwVXs9dD/h4iUu8YVb4SVxpIBSR7g+9pA2+yVwpaXV8v7Yn4Pk8w2
	KRpM0M9gdPc8cYbzI8vi/f24dxSaGTrh2QavC
X-Gm-Gg: ASbGncs0GYn+l7RdZ3H2jT0as1VmdDzN5JQvoleQ5qygd7452WsXsbe+C3B/B1lPEC6
	6hEr4+uSYYO+zen68UCAxa+/TKVYgnBLl9iuDcbPUXyZlC8MelTYAhzwMklTQPpp0ZSJj1BEg5X
	JvY/JBzZrar6RgAuLeGaPlR3582RM=
X-Google-Smtp-Source: AGHT+IHUjVyFD7izpuiUpvmNnf+FDUH75moOoGezgMNusboh88UNsivDmQCcYc+G4RahQGt7lDjXkGMaNSEWhyim3Q0=
X-Received: by 2002:a05:622a:20b:b0:476:7199:4da1 with SMTP id
 d75a77b69052e-479249bd49dmr285747491cf.46.1744121810231; Tue, 08 Apr 2025
 07:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407140001.13886-1-jiayuan.chen@linux.dev> <20250407140001.13886-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250407140001.13886-2-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Apr 2025 16:16:39 +0200
X-Gm-Features: ATxdqUGjCQjPmmLIhcLV4VA-4isczJrM0_7BiR56nk0Heb7yBGKhT8w790UEEEE
Message-ID: <CANn89i+a2tbuEJgzQ-yvSt-jqXq6S5y6=C90jNB4QXGseg0mDw@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next v3 1/2] tcp: add TCP_RFC7323_TW_PAWS drop reason
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, mrpre@163.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Antony Antony <antony.antony@secunet.com>, Christian Hopps <chopps@labn.net>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 4:00=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> PAWS is a long-standing issue, especially when there are upstream network
> devices, making it more prone to occur.

This sentence is quite confusing. I do not think PAWS is an issue at all.

>
> Currently, packet loss statistics for PAWS can only be viewed through MIB=
,
> which is a global metric and cannot be precisely obtained through tracing
> to get the specific 4-tuple of the dropped packet. In the past, we had to
> use kprobe ret to retrieve relevant skb information from
> tcp_timewait_state_process().

>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>

