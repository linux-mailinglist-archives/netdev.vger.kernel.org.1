Return-Path: <netdev+bounces-110585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A22092D4AF
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 17:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1BBDB24020
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 15:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59719193475;
	Wed, 10 Jul 2024 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jXvHMpSq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69A418FA14
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720624108; cv=none; b=s/7clX4b0CasYANau/YMlErRF4f3efKtjj3lexTOlHBbMlhFSyYyqUSW/Ky3Amk4rRVXG2EsxbryQOgZYIK4I0+GqgnpIMCMfYzztNZboedGm5iqVTrXGY+KE4cqjm0+9seak5T3KkUWigkYMIZfR+sI9Od09WnMebnBdyKhMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720624108; c=relaxed/simple;
	bh=eipLGCU/hq0IIG/0ijzclRBDJL5aFpdf5yTcIkiibYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/kclqaBcjebLvbvc5qtSUi7+/O1N/9712us+rtaVwhSf/1djC6Y7bJD2iYgEgX3s2ViLpk45pOrEWCyWa1zEkR0NsYs6x+4+Jl6lQt8MSVNVd3aiuVeP0OdUq+lOhMz/mAgX1+0NBOQ+3FtZAB2e1//0zh7TMMb4jnnV2NMISc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jXvHMpSq; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so13931a12.1
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720624105; x=1721228905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfJ/+7SlU/L63dWFh18JhBUUJFoACA9W4L3mVc5BGN4=;
        b=jXvHMpSqUQ5sxdF5jecqRJWX7XP7vUb/vP2zbxc02ZvIqCSiIWiorGLcJBF66MyqAe
         t23IVht1Y5ABMpbNzm1uPoqaaJEW3uzG+RDi1+BkEPwzU3JODKYSUF9qIxsT4NcDAlfj
         X86A9iztYfiry0teccMeohd78S+9I8aVjCN9lYsvwbBTilTnSw0KgkCo0urZAb4krghL
         hDN/xdtKUtSUT5ZcSBr6/LatCsTXVwjtSNAP+Yo2fx+Ri1ZxVL9BuJAYy2uWQVzyUj+E
         vEk1uX1VPS86p5MTu5twkVS4Hh5f5b+nut6HVzj/naWxWtfnteBEv0S5HLMhSWurX9ps
         Fsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720624105; x=1721228905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfJ/+7SlU/L63dWFh18JhBUUJFoACA9W4L3mVc5BGN4=;
        b=J0rT+HP+UvASFX7bautqmenhTrQuNMkJvd56y1tIG2TQotGIR/G74FDfOSp+IVdOaF
         TZgrvrC7sIlx65AQSNXOGREcJRv6qhxzvgpxvJWOO1GjOJhMelT6yBL7FwMLl7GwReSG
         bXKUJMO/hK3MJ5XPV18oJdYjwoESQuDULYjnC1r39H1hXFmuHwtVkoF1FK+vFiu7zpgC
         H5a3R6c/0T/Wj7hR2hOOinTF/a8jmA2isI0HiePySilMRZOYCAsnMfvyFAqDdpaPdZoR
         4RpN+kbbvLoDrcrBCXxuyY0zxbXjEavqjd8MPWuaz6quW+DhFkcLED8vK2/hRwn+qg3G
         lMsw==
X-Forwarded-Encrypted: i=1; AJvYcCW1RsebXi93bNGJqKCjQEvbZbBstEtCPPaDGDKZwCbni2DI55FoF48Y1JtoeHR6vFmpPOdvcMU7o3TOZ74Mjfhlz9ldSPyA
X-Gm-Message-State: AOJu0YzaL73AoxmHBA9qAy6BgF88elEiAsqzUpxt0OB7zBQcs7ST3mA3
	oricT6b1/w7nG2zwGKbnHMB5xC/T+KMFvP5i1JKJKLhnGn199lCd9+r+dpJC9sVAcv2xQ3BF5w4
	676L9djTWL03HIAjukUift1RScv9tjGXkVbC0BPXyY6hFt89f/A==
X-Google-Smtp-Source: AGHT+IEra1+Wv2z7Zh/tkqMjqlVtZcz/2gd3AvOTZ0ydXtCegIvI5tlD8YurP3XKGu0XhfD1dBJgoWqF91C0m+wdh8M=
X-Received: by 2002:a50:a68b:0:b0:58b:21f2:74e6 with SMTP id
 4fb4d7f45d1cf-596d05f470amr273220a12.0.1720624104963; Wed, 10 Jul 2024
 08:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709230815.2717872-1-edumazet@google.com> <20240709182306.4d57315a@kernel.org>
In-Reply-To: <20240709182306.4d57315a@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Jul 2024 08:08:11 -0700
Message-ID: <CANn89iLJWwQe-iTTMWenk9xVEUtuzJVh8X0jW0fBrijUan_N9g@mail.gmail.com>
Subject: Re: [PATCH net-next] net: do not inline rtnl_calcit()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 6:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue,  9 Jul 2024 23:08:15 +0000 Eric Dumazet wrote:
> > -static u32 rtnl_calcit(struct sk_buff *skb, struct nlmsghdr *nlh)
> > +static noinline_for_stack u32 rtnl_calcit(struct sk_buff *skb,
> > +                                       struct nlmsghdr *nlh)
>
> We only look at a single attribute - IFLA_EXT_MASK. We can change the
> tb size to IFLA_EXT_MASK + 1 and pass IFLA_EXT_MASK as max_attr to
> parse. Parsing the other attrs is pointless, anyway.
>
> Or possibly just walk the attrs with nla_for_each_attr_type() without
> parsing at all.

I certainly can do this, thanks for the suggestion.

