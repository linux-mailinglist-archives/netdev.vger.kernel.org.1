Return-Path: <netdev+bounces-186221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7386A9D76F
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 05:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37AF4A3188
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 03:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E774C1DD529;
	Sat, 26 Apr 2025 03:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AX3tzoUI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706F814D283
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 03:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745639661; cv=none; b=F4Rn6RexzIQOwc+y+kJ9tVGkYbnqJZgZDY33be5AN1O/mi2WOXIMIZqdaWZ+shIq4Fd2GGNhKzSw2B3CEhb6bqBSTLLfHt+U8gaC9L9w6fi56s6jb7grECnVT7ZOw8Vika8O6eXDnb+apDGzA9OUjAeT2AjgqoTvG6DC1l4zCUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745639661; c=relaxed/simple;
	bh=/5fMlbRdTTF9fOcaspDg0mn+neqEvxenHd+TJwKzEYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZbRumGSvMCKb72wsun6MBUutc3Fi474b/7FZlD/vVbP81pII71L5DCd2wbdP6EUufAhshiyDra5tZGXm2Ae9i/yaqcLb/hj5LJ6U0ye1Q212OO8HJLLN/0idng4VdT27LLtxDI74Ctgzk7s79noxg/nwbd0ITO1XX7vIN4rtQK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AX3tzoUI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2240aad70f2so94315ad.0
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 20:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745639659; x=1746244459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rv0nQqFQxIQwbiEoCwEBS/lXrGN47dpus6ZKn17Kc8E=;
        b=AX3tzoUIwHyb0jW0okkv2ZlzBWlO0c3gwB/RHTMyk1H6aWi+cQJeinRmkzCy/+r2Nz
         k8F7cRATFdZPHoltNW0ibl++m2sTgWQANV6w0lqCy55fJjLml47hftMEJ6iYtHV1shlP
         JQBk7DXwqqrRVSLBfvMD3IwSB4WMhN+bXKnbKk5sJb/7ZtCPaLnyVuuJU2HntfXTbh1k
         5Nw3quImmlzjtB5vxwbI2lRaHi5C+Y3h4n1yRpGh4APHO4YM5XN3rHPHWpHUp0lwNWAA
         RulBqNTd7+YqCNBB1e+w56OpIU9P3j5qQE6ISnv4dsnBv6xHo+0pn13rv3jKklsGIPZ3
         iSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745639659; x=1746244459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rv0nQqFQxIQwbiEoCwEBS/lXrGN47dpus6ZKn17Kc8E=;
        b=bCbu5R5Y8GfjJJyWSK8ZYqikRDVQrQvnLLG5w8EeefN249Dn4hI5a3tL+X0H1zCa1v
         IVDl66F+TOH7vnIO+HXfYXsEAy5oR5R24hDp4hSEm3iz2FaCSafJZCrfrOnx189EH67p
         vJnbS+I9f0kzBiRGxueAep7953sdrjFU0NmA52mbw7/szNPsSzG5pY1w6vNEdBwQSJeP
         HhLSd1No9BlVVwkTOgpmEgwUE1QD28rvg6jUH0QPNzJF50W6JBzHN+gfu8IzkH4/ItkO
         xanH16HcJTtU6oUD9S1OwOjPziV8fMoQ5Rh7ZVxprxUiP1hKbOvKTbj7yOny87Xa0v2q
         Ac7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdbCZ4NsTHA8CXP5rsmp+lKmNN6Eg5p/pOagzU4UL1mXYe4FHmJqSmTDQ/UIYBf2W2lPZbQ4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnvUeTDpcXNFe3bc7xRBXh/azAhj7eDCP8lR2FLRzBbMbibMDl
	zVipv9G5YhNbGhglUu89PyjoBBgwgBhyNY6KWtlXOj/8v3xueJVIfwNbLtBxcslU3/yHd91kL1o
	yfkW12dVytQpsOXyIcmGngGT3PoiBXus9ISpC
X-Gm-Gg: ASbGncuOHWLz/0RYWh7yK+qlMdX4lmtREhGaDDOQXF0lCLtFPubq7ADFV0KmJmF6s1P
	KXuVbbB+Q9o0ho7g5tYwtxDON7ulGA8YpV4JMWNr4UnicPYq+HJ3nreXSmfQC+QIZVtYYijT0bH
	D1f8uFTfNl4yk+5C/kfOufsj955v5ihIaemgewK4nX/HjL61V1WJVbbqU=
X-Google-Smtp-Source: AGHT+IFiEtlpi7QqkkrAxeav1ityOslcRgnpy55ggx4p5rqUJayG5AltDKZn+6dYJsFvUol0sUIzNrD4X9NWroLw8IM=
X-Received: by 2002:a17:903:2ecc:b0:220:ce33:6385 with SMTP id
 d9443c01a7336-22dc9086876mr907525ad.9.1745639659209; Fri, 25 Apr 2025
 20:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424200222.2602990-1-skhawaja@google.com> <20250424200222.2602990-3-skhawaja@google.com>
 <20250425183612.19068f23@kernel.org>
In-Reply-To: <20250425183612.19068f23@kernel.org>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Fri, 25 Apr 2025 20:54:06 -0700
X-Gm-Features: ATxdqUFao4LUOIQPTr54I9J8UxdWhCrwk8-CdJqctwSGXLQZgm7DuUCtLJv1ghM
Message-ID: <CAAywjhRMSsMhKzQQsi++upcoOvc8CQ=Q6=J35vnxywhhLrk9AA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/4] net: define an enum for the napi threaded state
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com, 
	jdamato@fastly.com, mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 6:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 24 Apr 2025 20:02:20 +0000 Samiullah Khawaja wrote:
> > -                     dev_set_threaded(ndev, true);
> > +                     dev_set_threaded(ndev, NETDEV_NAPI_THREADED_ENABL=
E);
>
> The drivers having to specify the type of threading is too much.
> The drivers are just indicating to the core that they are too
> IRQ-constrained to reasonably handle load..
>
> Please add a wrapper, something like dev_set_threaded_hint(netdev).
> All the drivers pass true now, the second argument is already
> pointless. For extra points you can export just the
> dev_set_threaded_hint and make dev_set_threaded() be a core-only function=
.
Agree. Will do this

