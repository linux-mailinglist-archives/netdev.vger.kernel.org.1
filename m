Return-Path: <netdev+bounces-215600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F85DB2F72F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 13:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7526B7A3120
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 11:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4645C2E0929;
	Thu, 21 Aug 2025 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EeTlcgdw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6178A2DEA78
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777240; cv=none; b=OiKOf1KNPHkE4CtuJEEIdoqZO7WzUv0NHAI6OQTC+dTnDJjcVDF3sMeM/b8v8//P6enpkYIOCyOxeMmnNd5zAZTDG+5pRoLCZxDmnXh79C9LT/v1RuJ6xGiSmzqqruqMSQIto9fabanICGAuQzhYQYm+VgdK5j5cii8zn6NYbCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777240; c=relaxed/simple;
	bh=L7PbAw7tFxkqZThPb3yJ9U2UGY2pHnuSaci2IGV7yfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4eredic0DU8+YkhSC7fGGjrTv75d8Qm3hElZjPqxbBnZxGKMJWJeCy07P1EWYKX3S8VMixNoCVkQlQQuuTEhZEs6EzZlJGQG5g5IbPGUsPJbeKaeLZlMlOyJa197yiu5PdaqxJl0eFWb+eUvwSZreMUZOAv0ONgY2KQ/nQMyaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EeTlcgdw; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-333e7517adcso18494771fa.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 04:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755777236; x=1756382036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7PbAw7tFxkqZThPb3yJ9U2UGY2pHnuSaci2IGV7yfc=;
        b=EeTlcgdwYygVPvWzZ81l5IByZT3GZgdfLnceLEVRtnLKn5kjZAK18d9RTZKllNN3R9
         UXNJuNZYhZL2/q7EIlmuqT/RNnXonu0xTXfM7Mu1hvzHJXxGStRwQ8wUjUvu1nmWe5kJ
         bOvHqJiyfkTBFnPalQCG/zkNmCKpV4C//WOnsggDAKiSq2dxxWaUdzQDpOv4icRLO6jy
         FLT1i4qApSx7t3oDdCbKZI6Uo/XCgFeugJGvh4s4McwDReUaIaDZCi4GNX1+YPb88r4q
         FyMPyu6OD1xEbix9HWqrFIy2K24Qt+lvmhMkS4VLBb67YbyhwsoovUIdJ3elz5ONpvok
         A3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755777236; x=1756382036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7PbAw7tFxkqZThPb3yJ9U2UGY2pHnuSaci2IGV7yfc=;
        b=mafIJjATZqttfI2tFHqfq4PpUFscHfgaZqmZs1SVNHqGMSnviiEhQeqgndKEigvVDF
         DaUJdTNIDKGZzNjhA5Hpwl07TQXIiYVV4EvxnomWZBtdXW3yNxBKXGQc5YZVCCyrKPj3
         W1qghulTgzb0RJec3Gqj+ECytN32cLyg5J8+FucWL3l8miT8MSRadcQcfC5a1EpsJqrA
         fLS8U5MrLDaCKhr+Psqiv7K5Xx5XtqkEXItBCpYbJ3W4mGmgF1JRoEPbkcwM9O4CgoI9
         Nh7WALoFIJsd85yXLqXXGnrOTUfhpHQnfOw9sG3sJK0gddjIsl+I8Xhk5JZ/N4Y2axmf
         InzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYSxeB63CQkzOpjr3QzGEnIFbYoJkb239cJaFcpiXLJUbTdP3s2OWl6JVBMFRzAB/MEWKPGgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLRz+ES8igMDZOSsuK4o2OB8bat0iFDGWoDPKGBwYR1P6zbWE1
	sKjXSolj9HUfhcz+IINIkY7NEiZZDQJr4s/Y52FyWlqSt1Tce3olE36O6jJZNcyKVi92xksNx56
	lf1zTa2Nu9BYgwcFRfbGN9b9A4ZhoS5Q4jvnWSepKXQ==
X-Gm-Gg: ASbGncv+kLN49Mf/15Fjz++Ovx5L4vbTrLcGc2qjPBjlxtmmnzX85S8Wv5MyY8nNWB8
	iyX0ABiy8Fy4465KSvbPS1qHGPJ5DrvSA0bCpBmDPvguxP7NifpvtOPGM/YO3HBbO6QWOhgR5B9
	N7enarn5ZlTnVwtobvN4vwd7I1lJtHcuyaeaYDfOtTC6cN8f1cf/lNeXzpSrcas0pblLmgtNVmi
	MvgZ74=
X-Google-Smtp-Source: AGHT+IFoewdvNuLwpOMDi7tPmb9FEQKLI5JEdERuyolhueuXHZ2+5KnKdkT/j3cc2QMbmt8jG7ipw7ObSBOoHSZHVLc=
X-Received: by 2002:a2e:a013:0:b0:332:2d5c:e171 with SMTP id
 38308e7fff4ca-3354a275fd8mr4061531fa.11.1755777236482; Thu, 21 Aug 2025
 04:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820171302.324142-1-ariel.dalessandro@collabora.com> <20250820171302.324142-10-ariel.dalessandro@collabora.com>
In-Reply-To: <20250820171302.324142-10-ariel.dalessandro@collabora.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Aug 2025 13:53:45 +0200
X-Gm-Features: Ac12FXy1SuiUzS280qDRSJHcA_2jVr4y-FjGItB1ru8eWVK-JVnc9Ql5XGWxM9c
Message-ID: <CACRpkdbVqNpz2HiAz+_vFUkDy1TE6ZDxp6X2g9rRWAt4s=jRgw@mail.gmail.com>
Subject: Re: [PATCH v1 09/14] dt-bindings: pinctrl: mediatek,mt65xx-pinctrl:
 Allow gpio-line-names
To: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
Cc: airlied@gmail.com, amergnat@baylibre.com, andrew+netdev@lunn.ch, 
	andrew-ct.chen@mediatek.com, angelogioacchino.delregno@collabora.com, 
	broonie@kernel.org, chunkuang.hu@kernel.org, ck.hu@mediatek.com, 
	conor+dt@kernel.org, davem@davemloft.net, dmitry.torokhov@gmail.com, 
	edumazet@google.com, flora.fu@mediatek.com, houlong.wei@mediatek.com, 
	jeesw@melfas.com, jmassot@collabora.com, kernel@collabora.com, 
	krzk+dt@kernel.org, kuba@kernel.org, 
	kyrie.wu@mediatek.corp-partner.google.com, lgirdwood@gmail.com, 
	louisalexis.eyraud@collabora.com, maarten.lankhorst@linux.intel.com, 
	matthias.bgg@gmail.com, mchehab@kernel.org, minghsiu.tsai@mediatek.com, 
	mripard@kernel.org, p.zabel@pengutronix.de, pabeni@redhat.com, 
	robh@kernel.org, sean.wang@kernel.org, simona@ffwll.ch, 
	support.opensource@diasemi.com, tiffany.lin@mediatek.com, tzimmermann@suse.de, 
	yunfei.dong@mediatek.com, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-sound@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 7:16=E2=80=AFPM Ariel D'Alessandro
<ariel.dalessandro@collabora.com> wrote:

> Current, the DT bindings for MediaTek's MT65xx Pin controller is missing
> the gpio-line-names property, add it to the associated schema.
>
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

