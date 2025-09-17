Return-Path: <netdev+bounces-224158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A42AB81532
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 20:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B5B2A803F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CDE2FE56B;
	Wed, 17 Sep 2025 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jPtlavwx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5925E2FE59E
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758133226; cv=none; b=o+YLq+el9bdCfLyWQRt1XlF8rQ81u8DlLKuIGHXM2FxACwfxrx2EEkC2ND4U+r0c6b5UkDi1qNH3VxLoPvSBmSX8Tj88vhs4nWmQRj2kIUZfS/jvLbJOhxat012NtgbVyBB6nbMLj1aacmtfA+yYz4clcCVY09YP0uLAfw5aDcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758133226; c=relaxed/simple;
	bh=bzfyVqViTPZx69h5hl19FhBc4huTCuSezqB9sigAmwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjIEvI2MCcsFiB5xs9RSwwFCV+Hyryccdo8ZqqD47pwlH5cvck4Lo1NPfGK9ki+QcaZyYu1cq7N7g2vaIHX36DI0wYRpjznT6JBny1OAAzzfRUxrjwOfN6iO5quT0h1yuBvW1US18ICvE2/YjhlCf9/A6rE82kAZm1YFJio5Ydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jPtlavwx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2570bf6058aso1469515ad.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 11:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758133224; x=1758738024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzfyVqViTPZx69h5hl19FhBc4huTCuSezqB9sigAmwk=;
        b=jPtlavwxCa1sRlPExMv4kKC9E+12vkVtygDKzjGAeB8XHsdPSAd/eqcW/beUatINQW
         EerAIJcktFSfRe9css8+AVJUvRnEG59lhU8pUKPHu26V0RQOYXVFOWy4vUCbP6txI5Xr
         KNev65wWbdOGA7TmW+xJwC1FDuS8CyY9VFeDTruCtkDdvXHseCB8XRCnr3ZXxp+m31e+
         6BdSwyTKjwCI9/ADx6aUIIAa1/nlnG9TZ4XjVDwcXcNYoFqZCnyP2zbPy7CF7a9SI0FU
         rk8jff+CzR2HUH+0cx9ZwIwtfu4I3ARu3UzyDguQzsJ7zQIA29nTsFBaX/GUUuCLq0kY
         kBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758133224; x=1758738024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzfyVqViTPZx69h5hl19FhBc4huTCuSezqB9sigAmwk=;
        b=CPscSnA5+5+d2xBzw+IuZ8JFRTMUm+Cx55OFBMm7ypyavAEjp3fTy64cCf7kDrZnqP
         46hUB4j2DwbYhUuFFZPytwcZZ7bmeWWWZLtwq1WC1jn+DZCMldgBL9x3DWEWsZM9gBZu
         VM1UpqyUouzVYVlG72zydxRbYS9jFEIoKTK0ivlX/ttyYvDJTh26X/PHnezrF8ZQ+b1c
         lTvWcx0ulVQq84OvDLaJzn8r4FOEkDmJ826u+a7Xa/VA2KBa6nXTdzzeiQ/IVBiQ/ROm
         +E9lzvCPsIf9bCwd8RF3i6HoFN9IeYmCk43yAOD1VqKgYZ0XvoVSq5gockzYDIUkD0EC
         GVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3lwX091++yQnoKfpFpGBe05xAvm7xs756b4+jjDMPwHigd0i4dnqRNfqdZKWvh0Un1UnzpRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdDe9/cOB2jve7UELrtTdSM+7f2o3XGvtIxT0w3iX5VGiXpqLq
	kSTubtP7h/ZBC/4ocEjWYZ/XbWLp7p7yNPcwG8a08zhkukUoYPTscVmhPwnpSN2oG7gE239/NAI
	PdDBdkwvd2f+490dTd9nJ5FxC0TvwVQGRRyal51tN
X-Gm-Gg: ASbGncsDi12bG/mVOj6gJO/Pr7o0UTEs3E+yBATHYeHXJImRbt9R43GFRTwOdBA8Y9J
	ppGJ/nS4ey+oAqKjc59A3UZ+pqMfrHn76QwHqX23kpRIwF8rq8Y8M68BXFukWFz9k5WSVIUEZ/y
	jwZWDJvP4QEyW7jn6XoGgfgubIs3GoqYGuQHOFgYBbmWstP2gMaRSVYW/RwmoQZR1QQrCS8QQA9
	cO5MDxOoOHJmu1lNFlnuBFGgpWoXgiH/IiTTuXcgF5XWEnTjegS+ds=
X-Google-Smtp-Source: AGHT+IGLSNNL17/AwzmuOSAq3cQkdcfYvtgsX88KlxJOHp1Ug/koAm3RCOsMUmIOvv2zxo9p7NWiE8wr1mcnokpEL7c=
X-Received: by 2002:a17:902:ccce:b0:24c:8984:5f9c with SMTP id
 d9443c01a7336-268137f314emr37741095ad.36.1758133224484; Wed, 17 Sep 2025
 11:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com> <20250916160951.541279-11-edumazet@google.com>
In-Reply-To: <20250916160951.541279-11-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 17 Sep 2025 11:20:12 -0700
X-Gm-Features: AS18NWCLuqQ8WsWivv-wN5FNnhCwXpHrD0F5xk-Z7g6StlvGyGOTmPc3vGa3oiM
Message-ID: <CAAVpQUABH60vAgw_wiO3cJ=3uG+E+3AZG-atxDk+cGqd31Jc-Q@mail.gmail.com>
Subject: Re: [PATCH net-next 10/10] udp: use skb_attempt_defer_free()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:10=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Move skb freeing from udp recvmsg() path to the cpu
> which allocated/received it, as TCP did in linux-5.17.
>
> This increases max thoughput by 20% to 30%, depending
> on number of BH producers.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

