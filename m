Return-Path: <netdev+bounces-242825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B45C95209
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 17:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6D0A3424B0
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A423299952;
	Sun, 30 Nov 2025 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjoa5/qx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FEB222584
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764518631; cv=none; b=Rguntk5sO1CoUcy4csKCgyu2Ehv6wfCIZLiPxGKBxMrOMt/NAlbJDN+wRvFCMttuaeETPMwORl+FIQDcBJmXDwPGt7hqhwV8lpyAGYlOsaKLtFbHgsynsYkkJegwVPfeNS6dgE2YKzJFKbL64+IhosJFRnHxJQR3okLNQWVFfeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764518631; c=relaxed/simple;
	bh=D1Uwr3T9zVEdnDTYoDm7prFl5rfbqeHqErCzNkKrKKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcUASqHHIfpEeZQArz95D1zil8R/3a8dCUPMX50w581HojbILT1Qo/Dl+b6O3i1luat7A4rkm/6xqN+h3FcKbeQ2EPyW+MOr+OLw4Ac2vBR4QVZudbelnF6h3LlnxVih57CiK+UlU4kUU1ABWe5/AJhuV9EEbI6m9eXTLe1/BmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjoa5/qx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C965C116D0
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 16:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764518630;
	bh=D1Uwr3T9zVEdnDTYoDm7prFl5rfbqeHqErCzNkKrKKE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sjoa5/qxZ+5eeY/FDRgGkiSa1+FSkntsezu2cwiV1sMSLPESI9P+phhU3nb7ytlRx
	 i9eY74sUnTurAyajD7q6UbwhANYjCIFSwH0+dTLO9Th+bAQ42CaEeYG8sQnIhCyHF/
	 xhY4KFOSkLJlYUFTXgkvDQLU648IF7B+059VdaK75OC/06lNtmhyAXlLLPQm+hCgqg
	 JM6N59ZxuO9J/CQ5K0YzZ2fjpM2J2443q5d8F7st27eQ56qwrzOYhiOaL19+0M3fOa
	 gfTgkVlx19amwaht0AJKVzeghSaovxlZeJed1g/5yqjK0E4FlA2BxplQeLnZEv4BgR
	 zn3YCaByEN76A==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78a76afeff5so29265197b3.0
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 08:03:50 -0800 (PST)
X-Gm-Message-State: AOJu0YyPqu/PyJ/6GRkgxVUPK6lL0CmSjsvAysC4UfjPkd/N6MC+6oaL
	mu4mhkJG+YiCnNGDLSS6H+CLKVqikCtYeuOhap3n2rUYNP07pJAByrfbuU8p7KhCgRy74rHuN3b
	K6ygbSSA94qnhW0M350ktmWXhSGVSLRM=
X-Google-Smtp-Source: AGHT+IHL+H92Yu3JT3VcjVNEc1+tn5NTSW1xdoEROWl6dzaS09fAVcxPgGt4qhp9PgKwB6ATElUWb3Gkp1Bk/NmcMYY=
X-Received: by 2002:a05:690e:4198:b0:63f:b3aa:d9e with SMTP id
 956f58d0204a3-6432924c187mr16000103d50.23.1764518629844; Sun, 30 Nov 2025
 08:03:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130131657.65080-1-vladimir.oltean@nxp.com> <20251130131657.65080-9-vladimir.oltean@nxp.com>
In-Reply-To: <20251130131657.65080-9-vladimir.oltean@nxp.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 30 Nov 2025 17:03:38 +0100
X-Gmail-Original-Message-ID: <CAD++jLmSbkLURKLxDHJ+5NWmQZ04eN-vaDyEst_VE=ZL4b_YYg@mail.gmail.com>
X-Gm-Features: AWmQ_bntZ4EvbiEtCyOoUytLZL9B90pR74ThTNqzrbVs87nt55oK6lF1Yj4gDgA
Message-ID: <CAD++jLmSbkLURKLxDHJ+5NWmQZ04eN-vaDyEst_VE=ZL4b_YYg@mail.gmail.com>
Subject: Re: [PATCH net-next 08/15] net: dsa: realtek: use simple HSR offload helpers
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 2:17=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:

> All known Realtek protocols: "rtl4a", "rtl8_4" and "rtl8_4t" use
> dsa_xmit_port_mask(), so they are compatible with accelerating TX packet
> duplication for HSR rings.
>
> Enable that feature by setting the port_hsr_join() and port_hsr_leave()
> operations to the simple helpers provided by DSA.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: "Alvin =C5=A0ipraga" <alsi@bang-olufsen.dk>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

This looks correct and I also like where you're going with this!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

