Return-Path: <netdev+bounces-225447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5505EB93AAD
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 02:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D36B18953EC
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 00:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917D22746A;
	Tue, 23 Sep 2025 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Cw+UJGd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A9B290F
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 00:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758586361; cv=none; b=DzHZYs+JUv4nsHi9CHyMtgs+fxFKBBq7K9fMoBzVMBWA+MT5QPtIgWYen2Ubi5cUXuax7RGG+6miZ9PNkreRXA7e1QtkZuCe4NiYsT7pUye9Hwuvjzh2PbgMvldOSPiYgbplvmYVxvfooYL4fu8c09l0qXMhsiGl9Ex6UizI5Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758586361; c=relaxed/simple;
	bh=FvpPF4ns4VJH1Trs01S7V3rq/0hsf4WM739gAeGBeSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWbJECljO9Xcm5eNEuVXoVOkSaU9IZgVzOttFEbGe8JmpImaHGW7FM1ry8ffcL4j+qLyBcGvxbYWIEHH+5kNWa1GqgQ52cJRoSHwKM2SCehszeKeBB2XRYxYr0+SC0sI47UjG0roqJWzDuBJJ0fPjbjkjGy2bTqlxb4S7u15JhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Cw+UJGd; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-330469eb750so5648503a91.2
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 17:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758586359; x=1759191159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvpPF4ns4VJH1Trs01S7V3rq/0hsf4WM739gAeGBeSs=;
        b=0Cw+UJGdxsQ2UlZtHDdSglz7eiWrIsDM8X49fhm4/dXeg1+nxYycZqIqC9odPQiOex
         a1ieAfO3Pa/cWs/i7PiEMwjIOP+JqyM36sFKBv8Bjcg08j0pw5agRcpNTsnjXpqyrt9y
         JXP4zJXLBnh4LmwE75Siup4y/rDKFcFt2NdbAA9X8hr6bmapieoClYUtIdNTkp920JFJ
         AYPO+9K5FPpZEG9oOLqO1nGEIyz4mcb9QzO5GNqfINlIEOIg9y1RDCZOBM0D8elNK2fz
         krchFesEK/iav40yYWz+B2Pdwb3m/njZl9MHyZ9pF8Up5P1U0VUfEOSi0bs8IeQe8q7/
         5AwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758586359; x=1759191159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvpPF4ns4VJH1Trs01S7V3rq/0hsf4WM739gAeGBeSs=;
        b=Gc3lwsVrwabK9WSKWfRpRen/CMQXLRtgdiXhkaKCoIMk21rk8HXNSPQtAdwdBojTdQ
         dY0ihhAPHZ/59oE1omwiBoT0DPMwvBT1wGkDLVSkssK/jskB0nLHrzp2SY88T5aZQGor
         4WQl/KYNgLyn09qloz+k92+LTNIM+N5ODxNjny8QJhvK1droH1lmqh0YD9DL07nscR6J
         Asj3ZsIdj1WqI3SuKdZIX5rxdz6ZVG73GDvxXXv2XZeWwRBePytnb5Csr3gLQvIoN+Wd
         0ph7xdOgphmlr00IQd+IbX4yWDBbjbkFuIscN1JYpdChHiOaAP7lt8MIEkjAzaqqNhUL
         Ukhw==
X-Forwarded-Encrypted: i=1; AJvYcCUG3KJQ4stEjsWvjRDJGSC9ZYZdBTiHHGgFCrVjs4riCYA16VOFRG9lIVsjD2h+u1WMRxmq00g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGELOqbqtD19eDu2xAf02LnXbqon1kHoZlPBZG++/+YHFTR+g0
	cVR/QW2P4FscHHIdO4oPZ8nbnjuRpXPv4SfZeFtswz1Ei4shnu1L6rAX+0diYR2E2nlSjEzTZbk
	mqIDUHLJizwLD/jzS1v7jp+daTpecb0u1weglVR/t
X-Gm-Gg: ASbGncuthQtdvDr0hajEzJtJroe+ZDukR/SiyAN59zuKghCYn53WdnDH1EVdDval9wU
	zSjrY0yVdJZRVQ2M1XVJoquimGKKaO/rF1Kk8u7VuDh1BIi076OqiElMlBFWh4H0GD/avYUNKxi
	fugAbbHKpBpRAR8ZK2QoDDbZyaLOiUbzXXpf9fxry+3NXuLdkSlZGdiwM1BNpXkJiEVe4/Iumq8
	A/8VcIGwfFRpvgtbf78OS2883KN5eSPJEprfg==
X-Google-Smtp-Source: AGHT+IHc2d9YlHilSBzZLIFuyYhWhddHF/VqA98McZQiGth7+g3gdo7PBHqxf02Y/GwFS/nmVasXtoEyKnJd7uMfGAk=
X-Received: by 2002:a17:90a:d604:b0:32e:4849:78b with SMTP id
 98e67ed59e1d1-332a95369afmr896211a91.16.1758586359129; Mon, 22 Sep 2025
 17:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919204856.2977245-1-edumazet@google.com> <20250919204856.2977245-9-edumazet@google.com>
In-Reply-To: <20250919204856.2977245-9-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 22 Sep 2025 17:12:28 -0700
X-Gm-Features: AS18NWCC-86Oqz13GnBJ7CcZh0rwlC2InqnkkRHrh7SsjPVLADrySwFkr1cYS_4
Message-ID: <CAAVpQUDzuzTXBKCuy4pCuCpnk26cAT4zQXB1_uCeD6b8e=vT2g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 8/8] tcp: reclaim 8 bytes in struct request_sock_queue
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 1:49=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> synflood_warned had to be u32 for xchg(), but ensuring
> atomicity is not really needed.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

