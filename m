Return-Path: <netdev+bounces-220242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E15B44F6A
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 09:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E7E5850A6
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 07:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D062DA777;
	Fri,  5 Sep 2025 07:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T4y7Zqlp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13662D9ECF
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057078; cv=none; b=W2GfTSAfVFBts/VTDP258KkyCrUWdcyc/iZDCT/37FJACHUpFktjg87lLK6soEt5QymfrPmgNDYio7JRqgaoFzWVwoeBMiL1OoewV2Abrq5zW38pfPNEOHnu3w5++DasudSdvEzFigzaDyiXxpMwpTAwx88Piss16LPfKCTd0XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057078; c=relaxed/simple;
	bh=OyKNmBG7aY30CUsH6LThft0vL3sOjRv4PBRyIA8/9NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpRqMLP2AdWcvyJpwDH3kqxtb6L1hKz0KIdTakGkIABJmzm5XF5NHwnQwWaHgh4EM9BwBB9LAX9KX0y9x7W+e/z4WUTsnpNhYox21amfGJaWvSzoMxuEaDtyvJeA/IU7NZjzhm5i9BJU72+rtqHOtzdBPOFFKTlSyycSLbCGN7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T4y7Zqlp; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f7039aa1eso2054397e87.1
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 00:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757057075; x=1757661875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyKNmBG7aY30CUsH6LThft0vL3sOjRv4PBRyIA8/9NY=;
        b=T4y7Zqlp3JbqjDcSuyMxKuQ65s1HSZHa4rQU2jwHDrET83lNTxQ3J/WVUjIKQW+KAP
         Rn49e9We4gvWjVqxJMvRviVxPBwnm0FfrUPugQOOdQu5mcm0lglyMsAW+TLfqvAACVsN
         9jENFECC9J/nFhltr5eUV+hfKbngGFmNNkhSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757057075; x=1757661875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyKNmBG7aY30CUsH6LThft0vL3sOjRv4PBRyIA8/9NY=;
        b=sq+XNdHj2gxsspKAtou/lWdE2PHNJz6j0gjzlOJgUhaTFqcpfzYLqpxZR6IMA27E7X
         8FR55v2zRRnaPR2Hmu32ejR7Uh0mI+MHyCX0Z75F8zHVLEfNq6F7UND3pxYIW2Zoahbf
         eVOjVEJFGRJuC0mXAsAz2MjaeDz/b5Q9C5oyunG1EQ7hEqQZjLbnM7Fac5AM3ekWVEDk
         /S9jN+kD19bhuiMbQi3PWgN3mY91NsFGJqEdgPz/FxJISbNM5qr53Jbkw8YxhkJgUKOL
         BPZJXc++f60Pe7kLsss7uAQfbgA2iKZeaQnShyPhsg+BPbl23hk8mV3dp9lGOD/OdODC
         u8wA==
X-Forwarded-Encrypted: i=1; AJvYcCWC3so10u25SDc/5gbHPJh1StajCrJ+TRzwOAfCOA96RQzr2Ree0umzxHCTU4YeavN9cDQ1+lE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/OzMu+xAdaykXWhPf9D9InpemXEJwsems3PNbycFjTHivZMpD
	UWOu+P9e5k5PYx2s0ZRkIXuyxHMZBKTHgM6aunvVXnkpsqkGl/KC4PbMVVgHW/k6GAYIV912tGe
	6kxBnDq9ht/qttwBonFQOzTlrH73d7GCGLJMOR+qp
X-Gm-Gg: ASbGncsTWzamQJyYkk4sLa42/XID3BmQYcoTeQZbLyII67i2Qw88NHn6LUuDC8Cpg0u
	mLCIQR+g9bcLPooltywjQJa6THH7B451195eXvIsmvPzufU+7YlNi54/e3NoM8Xw/BuxKL/y+wr
	urcllX2abRvonxREgLrn8EprmmXFciymP1OYKpheWJJKPxWq6RzNKbA2jfszGNdjFyyNZ/f8rCP
	NsBiaBzYgOpCs7T1a5nB9xkiEkXZ9Y3NNdhK4pTQa6xv+wf
X-Google-Smtp-Source: AGHT+IHsGV8p2LrSQ+5ebPuG3MwZsxnB0+XdK0d6HB4AboER/GhIXoUDzaGFZTbCNnePZ5YQiB7vHJZTSeMi3MgtzZg=
X-Received: by 2002:a05:6512:3d11:b0:55f:4e8a:199c with SMTP id
 2adb3069b0e04-55f708c2538mr6024739e87.20.1757057074896; Fri, 05 Sep 2025
 00:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829091913.131528-1-laura.nao@collabora.com> <20250829091913.131528-17-laura.nao@collabora.com>
In-Reply-To: <20250829091913.131528-17-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 5 Sep 2025 15:24:23 +0800
X-Gm-Features: Ac12FXxXPTzm9nG4j13NbvkvAJ8eK4LgCQVwRNdKf80aBqhtT_PDYtc5qR-IPds
Message-ID: <CAGXv+5HjrwPJBC-wina4ZrQe_3FBWcyZc3e+iaCCmNOKfMicsg@mail.gmail.com>
Subject: Re: [PATCH v5 16/27] clk: mediatek: Add MT8196 pextpsys clock support
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
> Add support for the MT8196 pextpsys clock controller, which provides
> clock gate control for PCIe.
>
> Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org> # CLK_OPS_PARENT_ENABLE remo=
val

