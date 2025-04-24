Return-Path: <netdev+bounces-185694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FB3A9B689
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08701B81218
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED56E28E61F;
	Thu, 24 Apr 2025 18:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xTlqli5D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1576028F92A
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519965; cv=none; b=CrJKvQDdS2EPUFD19lr8DWi5FrYDOi+UnGxeLDUH6QY6lpufXLDgF3mJMOC3fn9q8wJiRDX6hDE05/RaauEzrlyNhknbM44V8u31mEhxavEKS4XAm3DKoIuc86Z0d8eL6kyVvkF5pkhk9n5YyHbUSQFjvQ1IQ2MtKdqMFdKkPek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519965; c=relaxed/simple;
	bh=HHntclg02aE3QvSZCu0iP1oyCiCoXRfU5bg0zfetSmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nklWCSLiMJl9yR/nqorSakzWuDYu9Fe+ckGMxVsWNHnINJJKgxIE3VQ/sQYz0yXoyeuNvgJ8oKDRMtAuat4r/pbhT9qCnTyHHJNCWcRb4X4UIdPx5qG6YxFeryifCrejGuzUuAEYrDBwiJgZTtwtKegPL7VhIFFSJKdw+O89ooE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xTlqli5D; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d5f10e1aaso8825e9.0
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745519962; x=1746124762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHntclg02aE3QvSZCu0iP1oyCiCoXRfU5bg0zfetSmM=;
        b=xTlqli5Dv3jbHjEnY18jBp+nHvKem/VrQOc7/NYM73+kUVUnzm762ywoeY0gjiJbb3
         cawy8+IeC20/eltoiEi/iWAejD0n+fer0PjaHHeJaL8yP8zHwXTrTgbRsB2pRV71+ZqD
         /tcr3vrO0WpXrLk0TMVtVMvKDbhVh+qVqMmLhkhmbVZ0PbYq0xqd9IUw6A7Ub45DsKoz
         I4lOA7hLgqIcIlp8T3Xvkwyun7Dh89IBzC2fwuIGrg9olnRvvRVewj/YhfxkezE7dD6w
         brbX7mrICZXr8UcMWMfynrOLT0uNdcLHptIf/bqalT2+d/6YKGJ2H7f4KkR0SS03IDa1
         LxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745519962; x=1746124762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHntclg02aE3QvSZCu0iP1oyCiCoXRfU5bg0zfetSmM=;
        b=R7KTZTp6caP79w5/Kf8y+GYnEA6b9EVAC6CjtNH+gpQ6wHB7W6Hk05sGkBK6qj877W
         aUy1nF0f/jqzZtfNHr0APasIslNQ8q6oxmOocCgxr7f4vdWN/1L2gPTSYgpYZNhJAtKy
         M1tGBm8m5yD7NyCYae9iRtP6vlJAXosftIy4Euneaxj5Scq7CMVKeGm/1gbkPAtGVtLQ
         FJBbF59ggL7nITVDVZE4RYo9O0AUEeBTW/QIEJMzapFkm38skDUsPw/Htto9/T5vll3I
         ennoCM4GS8m+RWJrVL+WcUV5KlBu2J4lWVysHEGqxDweKaiCIai2rqZPBm4cRhaMiQgt
         Serw==
X-Forwarded-Encrypted: i=1; AJvYcCVh0q70oToPcwQw6trA74d11i/UPGXoFcfdOCAh3wzgs8blhkk3dZTYFEIA0VsHVk9XCrgFMuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTkDR/lxD+lFbtSxoGdRlbx8zgaE92W/CkD8pvnGw5xdqAsug5
	G+IMfMwP7i9q1bfLjcGk02EhBVS5YGy5/Smfg7YxifK5QKPlS46Y1TKFUhdtPZ350p5Ei6r2nP3
	EwxksAe4BULcysizJq13r4iaIq2a2qpkzYNbq
X-Gm-Gg: ASbGncsNS3Av5zEzYJ2HcPMVkyAyokKtBxHmW+gEie1lTqYmmmQLiliEZ4r1WAIm4Jw
	NdyDEsYzUzPpVihtnPTgR//62cBpKu7FYhsV+/AqNCBAmsOspW+qLe3jDuRuAGszoqCmfCH6Kua
	X2yJ6JIEz+oThQQoYHQIiwyBisXC8TxkLBdJdWVv4H0c0TG6ZH3CO6
X-Google-Smtp-Source: AGHT+IEgclIazfJ+afZgykhy/OrxVQxEpacPbvwDO8iTY2TatSu4aC5rLgtRnnAAjK8iOSfQX717oIm/EvLzW6yrBVI=
X-Received: by 2002:a05:600c:3d8a:b0:43d:5b3a:18cc with SMTP id
 5b1f17b1804b1-440a40e281bmr190475e9.2.1745519961980; Thu, 24 Apr 2025
 11:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418221254.112433-1-hramamurthy@google.com>
 <d3e40052-0d23-4f9e-87b1-4b71164cfa13@linux.dev> <CAG-FcCN-a_v33_d_+qLSqVy+heACB5JcXtiBXP63Q1DyZU+5vw@mail.gmail.com>
 <99b52c22-c797-4291-92ad-39eaf041ae8c@linux.dev> <20250423155636.32162f85@kernel.org>
In-Reply-To: <20250423155636.32162f85@kernel.org>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Thu, 24 Apr 2025 11:39:10 -0700
X-Gm-Features: ATxdqUHYUp1bexngYV8CrablkfZbm2LmJaq8icVIQy-Bgdr5dvFjF-MM_4ZrPrA
Message-ID: <CAG-FcCNwOUQc2gRB83Opf47K0HdbHdw1aCo+aQEBQ5FVqrixAg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/6] gve: Add Rx HW timestamping support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, jeroendb@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, pkaligineedi@google.com, 
	yyd@google.com, joshwash@google.com, shailend@google.com, linux@treblig.org, 
	thostet@google.com, jfraker@google.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Vadim and Jakub for the suggestions. Will send the timestamp
patch series with PTP device together.

On Wed, Apr 23, 2025 at 3:56=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 23 Apr 2025 22:06:22 +0100 Vadim Fedorenko wrote:
> > It looks like it's better to have PTP device ready first
>
> Agreed. Or perhaps it will all fit in one series?
> --
> pw-bot: cr

