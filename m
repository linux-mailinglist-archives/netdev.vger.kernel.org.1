Return-Path: <netdev+bounces-216352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF48DB3340C
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27492015C7
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 02:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28667235041;
	Mon, 25 Aug 2025 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COf7q7vr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4104C92;
	Mon, 25 Aug 2025 02:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756089612; cv=none; b=nOjscYsPm6LSAr3ZIrmXef9fiGmYVxWXeAOjNHfUwFei+JExtvVr3Fc08DSxRMp6lm2kFiNImwzbCWr7+wlgHNzpLRk8neYM4EVtqHD/eql0k42zMed9HRpCGLfDzNqZHHDoVRfECzUeRORXgoF4S96JXlBjb9S9OS40jVfYMZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756089612; c=relaxed/simple;
	bh=1lfLQsN0/U8quahSxrzudcQke/2i5X2JIJom+6NQIuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D84+PhnbUli4pklVh2HUW1E5AXHOzEpQ6UdlKAQzze0DUV3PZEkoaTNXVPNaZPRRKlaCzOuRrzrz8WoGNyNck3Mxhxi4KFn1VDGfEuZJvGDdQyCvVwHcPci/XjpXGzwwA5vGd+4rbP5KBFeZXi77mPuPFpb6hinorqVMcZWns2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COf7q7vr; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3252e4b0f51so1624858a91.0;
        Sun, 24 Aug 2025 19:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089610; x=1756694410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkPUNaruSQ5LOMMRX/W2/pqcUcBVBgOS+e1vxMMUPqo=;
        b=COf7q7vrSljyYyMh8vfsKav4s2+/1ZOEsA2FfOP2I1Oi+VBGsO+oSd/G/wDAVftpSp
         55JURAdtMwtkfzsoM2u/OAOn+Rp7Lnv2KYbRjLn6hMT6xCCsbHcAg2a2z75wwW7Xh3OT
         b4dv7WAPlC1JYvTLPx48uZKOqKywzilJEIaW2C5JWp9L24H042pDxAlKUdyvlBDnm1V8
         6q6f+R4dlIBXpaANZoW+bwgOnwlK7oI4/nMv7CS9YkFZaxubKDRl3JJRhnUZJMT1UMb5
         s8+leg5IE3CRfSj+zT9WE7P5MxkxocsR9FODsAW8U6mY8klZzTwItEJoHpTCfzf7NOq/
         tU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089610; x=1756694410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkPUNaruSQ5LOMMRX/W2/pqcUcBVBgOS+e1vxMMUPqo=;
        b=v6N1uU2T6pcX6ee5puUzIIvpfpzYjsAb/lp+HzFGGMp8wiFmivUlRQzo9WBR0iHlKK
         iCPGoi6ec7clxDCZPPT/WtrQ3WUU1CBNkN5Qp6gRSyz4tMCRDs7TbP+zdvtwFbN+wnBG
         ysaEdGdHkco5dQ+/inFxmW8SwL1OxQwaL5Cg6/K0lPbyYbpdmybya/E65qvQIpp48Bn4
         K9cYx5/pFW30jNO3k7EvLSNRZUIyyzanUM6MAUoj6gCOoi1tqabZzKV4beOdOu223Acu
         hFuZnTcHP/M+MqFbYmEREsZ4XaRn/ciw6x0oCo72loAcAdh36kmSISjFt/6P3Y5IpKKC
         9HlA==
X-Forwarded-Encrypted: i=1; AJvYcCUj1W3pbYAwKqbk2/P5i1rke7k1fEoW2mT2O5Io/eGDuLFdq30jUcTv1l+SV+txhsfO+Y5vzhKkVjkK@vger.kernel.org, AJvYcCVfllYMMlUUXqW/tWp09L9KTNdC2YZ+twtWcjjO8uPc40juGTYsUtqbm5WijZQcXPtqD+v7AJoRmnd3QJYw@vger.kernel.org
X-Gm-Message-State: AOJu0YyDxNPKMUC2XC2ON3Lv0t2NoUmJkcw9wCsMsxAu+QAZ1x++RP+X
	mf2vGxkJw3NUTYreBWDWRX3a84QQ4DJVdxBBFGDD2chITgZUALYmP+/PVKRfUjESoEvJ1Iawklx
	bAZV6ZEIVFQtYW9dCvNIn7mJDkuhnoQkBsxPn9j+nfg==
X-Gm-Gg: ASbGncub8ykCITcI1ylOrPZCfG5LAbYT/jabo9+lowP8AOI2DA7Rk1K9MF4IiJn9pV9
	CWecTsrgb+RmbMOzm7XX4ZZpaKO/SNjd63nCyqFkgiucXZDmB7XiiI/pZqoG54bywES7sZhhv58
	h1GAapzj17Tz6KMjOq/8Q+0axGY01RiMYlp6NrT4hhvSFAMIj5ElxaOmjfAO4amQI26WwRKG5Yk
	XkP8PDAsA==
X-Google-Smtp-Source: AGHT+IElR6GRNREDHPCo5sfgDywLw3EE679VHhCQUj042BQylnRA/7J4lG/pFPOCAsc6U9whuXwTeShHa5Zy0P1/0Ak=
X-Received: by 2002:a17:90b:1d06:b0:324:e03a:662e with SMTP id
 98e67ed59e1d1-32515eaeeecmr14743689a91.23.1756089609888; Sun, 24 Aug 2025
 19:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824005116.2434998-1-mmyangfl@gmail.com> <20250824005116.2434998-2-mmyangfl@gmail.com>
 <20250824-jolly-amaranth-panther-97a835@kuoka> <CAAXyoMOfhSWhRCiFudju-DNtvD+8kHGhLzT2NGBF2cK_Ctviyw@mail.gmail.com>
 <0cb62840-845b-4a9f-94c6-e40d0b72ce95@kernel.org>
In-Reply-To: <0cb62840-845b-4a9f-94c6-e40d0b72ce95@kernel.org>
From: Yangfl <mmyangfl@gmail.com>
Date: Mon, 25 Aug 2025 10:39:33 +0800
X-Gm-Features: Ac12FXwWccvVXoRpOo_nSOSW6iaRis3gEis4wHn-eo1XOa6BEcrzKwpgvITLF3s
Message-ID: <CAAXyoMMej5XJmofiY_9cpzscxm2GyZw_v9hcSYu7NvhcNFFV2Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/3] dt-bindings: net: dsa: yt921x: Add
 Motorcomm YT921x switch support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 2:09=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 24/08/2025 11:25, Yangfl wrote:
> > On Sun, Aug 24, 2025 at 5:20=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On Sun, Aug 24, 2025 at 08:51:09AM +0800, David Yang wrote:
> >>> The Motorcomm YT921x series is a family of Ethernet switches with up =
to
> >>> 8 internal GbE PHYs and up to 2 GMACs.
> >>>
> >>> Signed-off-by: David Yang <mmyangfl@gmail.com>
> >>> ---
> >>
> >> <form letter>
> >> This is a friendly reminder during the review process.
> >>
> >> It looks like you received a tag and forgot to add it.
> >>
> >> If you do not know the process, here is a short explanation:
> >> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> >> versions of patchset, under or above your Signed-off-by tag, unless
> >> patch changed significantly (e.g. new properties added to the DT
> >> bindings). Tag is "received", when provided in a message replied to yo=
u
> >> on the mailing list. Tools like b4 can help here. However, there's no
> >> need to repost patches *only* to add the tags. The upstream maintainer
> >> will do that for tags received on the version they apply.
> >>
> >> Please read:
> >> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/proces=
s/submitting-patches.rst#L577
> >>
> >> *If a tag was not added on purpose, please state why* and what changed=
.
> >> </form letter>
> >>
> >>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> Best regards,
> >> Krzysztof
> >>
> >
> > Thanks.
> >
> >>  - use enum for reg in dt binding
> >
> > I made a change in dt binding. If you are fine with that change, I'll
> > add the tag in the following versions (if any).
>
>
> Cover letter must state the reason.
>
>
> Best regards,
> Krzysztof

as requested in the previous version

https://lore.kernel.org/r/f76df98e-f743-4dc2-9f10-93b97f69addb@lunn.ch

