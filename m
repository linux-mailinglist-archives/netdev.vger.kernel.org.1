Return-Path: <netdev+bounces-220236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EABB44E04
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 08:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBF01BC7646
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 06:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1452D2BF011;
	Fri,  5 Sep 2025 06:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IzulrF9u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EADE2BEC23
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 06:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757054210; cv=none; b=UlXwWyq74uoUjCcoHMnqI/uVaZx3k81szHMmVNi8P/dAJmUgIZSHBU3mJbFaX1htMDDkUToiEIV4i0ZB2TLOEvesH4tNu9+Z80ZWSf+aIe5zC/ljRo1XhjQJV16ESJ1e15GnsgvZghfZqzCzB3h9z+Ku1RUKl1V5eKd0JRMZ5vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757054210; c=relaxed/simple;
	bh=wFJS1RHxYpPdjfElWjyoww5Tm6gmIS00MsIdtooweP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAsyz6Xa9kRXuqKtqSSVRw36Y4liLjrCl3GW0De+O8tCdHB5Rb//Z6J6/Fz8kbmvgbqlv7AL+JbRb3CRCTpKqcK7QVacKOt937gj9iFLRsqmWHG+Q5agvzJWo+Vxve0vxoH0r/1cEq5wQ0tl/bzG9wtxwZXkBr+7XLo4kwIQgUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IzulrF9u; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-333f918d71eso16956031fa.3
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 23:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757054206; x=1757659006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFJS1RHxYpPdjfElWjyoww5Tm6gmIS00MsIdtooweP0=;
        b=IzulrF9u/DSrT3zqQPUsDOY21AVLbnTTjCEcARRgy+OT8PlJcHAQS2yebbq6X5XqAI
         duf0IS7+JJA0PmNyMahxFhjyjto1zT3e/bruHK35GFkh4cfA2R3kdPC5QsbW3Vrvd55b
         7kjrMqfl55s/CSa4u6ru9TyGum0qbFn4WRis0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757054206; x=1757659006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFJS1RHxYpPdjfElWjyoww5Tm6gmIS00MsIdtooweP0=;
        b=r2ikf0m008kLV2SgtvTnuUiZ8TI3hmzB/TbF9aF0KcaHvVlWApkkhatTWKazDePh3R
         ck/Al6sfKTrn9AonEcIf0nTHdAQpcaWFyg9yDxKGDlYO5d0cNXlYwTvAfZyCvHrPrQ40
         UyPdHBTL9rmP0ilyXc1meqMOIWUGOqv7r1hknhA2o4VbriY3e/bAzajL1YmnfSBum4ua
         45XkfRbVrIgKF9aqD2hdS8+JgvB8ulX5VKWM2U9eFlVgwim511B57+CeBgko/csgkjgM
         LSS4UEuFQeXFbGNLSQaNIvYKzc9pfU3Z67JUMfrblUzl6QcFnegGlL5Sm4D3FZH6m1A7
         XELA==
X-Forwarded-Encrypted: i=1; AJvYcCVsX11AtI+s+OiTBNjeHdB5azBK4BiJVMGGE+jRL/pbUErs11kLmoP/RzXzY1Ak7N6L7pmXEB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgJ/rsXSFSMpO7/tyEoqgAa1Z252mjeK55Rj82wlYmR061SpE1
	lAA4ZZQuFrT5SQA9YLJGHWpleQmXWovqD/nbLErVJNTOGL4YOQ89cc9QO5rOHEIGwlV78Ht2MBd
	9Nl+T21/bbsOQwaXs/JzGufEg29cELW5gtuaePtSq
X-Gm-Gg: ASbGncvRjmZ15n1eH0N5YRaJbbu3mvfXK4ztN7pLkxgoMLY4kGYeuG6Idw06ImKKRma
	IRSDCUlg1MAGYp3VYyiCBIHkSqe4fN2/11A24gLGboA1fMhreM+1+e4vqrKqGTaIcps27/pRngl
	XWwadhLPxndY6W2hih1iSE4ehqGs1vO2xL3axogQu5CSFa+0gsFpBfPas4ql0IRBhnBVH1F297E
	Q/tU42zxkcdTWwdh5yVYRADLgtDxB3V5BcIkA==
X-Google-Smtp-Source: AGHT+IEgVbxQy/DxXsDzvdrcOfC49jBWiMtOAGepTowcEVXECREwr9aIaRDx8B4CTbXxL/deN9wUH95NSxy3a5X8TKE=
X-Received: by 2002:a05:651c:20cd:10b0:337:d2e2:d467 with SMTP id
 38308e7fff4ca-337d2e2dcfbmr42859621fa.43.1757054206408; Thu, 04 Sep 2025
 23:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829091913.131528-1-laura.nao@collabora.com> <20250829091913.131528-16-laura.nao@collabora.com>
In-Reply-To: <20250829091913.131528-16-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 5 Sep 2025 14:36:35 +0800
X-Gm-Features: Ac12FXwXWypau4EdANuUrgXmxAn5bymNrHkP7HBNlw9rFp2Nbb7jmA3VYZ8UsYk
Message-ID: <CAGXv+5GjZusKNCe+EshMktmyDcfjm6i5oD+h8LvObymvD9QXqg@mail.gmail.com>
Subject: Re: [PATCH v5 15/27] clk: mediatek: Add MT8196 ufssys clock support
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 5:21=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> Add support for the MT8196 ufssys clock controller, which provides clock
> gate control for UFS.
>
> Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Assuming the previous reviews for the bits are correct, the removal
of CLK_OPS_PARENT_ENABLE IMO is the right thing to do.

However if the hardware ends up does having a requirement that _some_
clock be enabled before touching the registers, then I think the
MTK clock library needs to be refactored, so that a register access
clock can be tied to the regmap. That might also require some work
on the syscon API.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

