Return-Path: <netdev+bounces-220228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C216B44CF3
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 07:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA17588229
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 05:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FE622B8B0;
	Fri,  5 Sep 2025 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LTC40j2N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC71E1DF985
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 05:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757048770; cv=none; b=hb3rqcpA1S2My+rsqcu3IfiD7tBmfxChf0jV7JcV8qaHsHNxc7hlPJCNOR0rT/T+AYZPxYfCsW9lN/8sl6uYjbfuctYZ5Yv0ih6E+0n631nkfQdvMP835TN9eyCaSHDoXn4LpeJa+N6EwBG+XK5VSbNerd3W1nWZ7GrPr0VCmrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757048770; c=relaxed/simple;
	bh=uyMA3OlxBR+8XDI4/fAiYBr3djQIzAJYAC/5TroND18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJ3hZQaaM6TYF+BDoV7gPxD2VXW1cN7+3mHJrjUnEFV2B0/z4QUL4axISC0v3rXNE+BP7qPSlFnA6Bana54vl2JIWfYmPycWcAzQydkZnHo2g76pWl/ZjcyNg7G5yc4tlsntRChl87/ZsWXBtPK6H5u16HWDVp7JSqOViQBeRek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LTC40j2N; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-333f901b2d2so17376861fa.2
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 22:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757048767; x=1757653567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyMA3OlxBR+8XDI4/fAiYBr3djQIzAJYAC/5TroND18=;
        b=LTC40j2NhJIUbfcfiwhuFTP1F4xtwf13zov2SaNIy71Uj+HZhKA4i1+IL+7NQ4ttpm
         I3l3sTpHRneayPf47ZdQGN936BlRMJUJ8ziIHRvjTYZJr2qZ+u811X8NZP1G8yLD538V
         2H6G9DZLCq0iUkxwAQnnJIJEYree7JYI5Efhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757048767; x=1757653567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyMA3OlxBR+8XDI4/fAiYBr3djQIzAJYAC/5TroND18=;
        b=fO3/3IAOuaKFqpHbRLOVeMvgJqymxKzDgTRNXbNlHdIVqp7/wPtuAyidMm8rX1YCrl
         qHH9/WG3H+qXnJkKSMn8B+sNx8VhJCQ2SXF272N1byq4HgW2VH5MlPgVKffruCs0S2/H
         4202Sbyv0aslhxc5JUqCuU+l7iXtwytopclVixWnBe6tnVdY8H1aqqdg+qoqj5d+Gd1q
         LVUgTksBXu75uqbPTkAmOqQT4o/LQDr0xQPMckXKX7KsE2edhWELX8UfoNjMkLdODihz
         GtFp75i5akOZpDXgmmEyOG+SVXPFr6YWVhyXS+U4GZh4NQBFbl7IdJIxi85KERQb1yUK
         x4Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVUKwrMR5YcVW7l7LoFs58CYbDow43FLfP5Cpkg0oFmIekRRPwtZs9Edyu8d3/bN9N542NEzkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr9ifQS6+P+qE766dmrZ3BGSP4tx9J1epxHkkeTvKVvlIgbSzN
	ZfGit1lpnnumKkQ/2ltd6uA+Hr5d78sbUJv9St0HAI6B4xqt4KhBKEZyY2JSDGxZ1h4+uVxtW8A
	hxCa8DFie+SsZUJmnU96MQfTjLxIVD3Rzo/UrROz3
X-Gm-Gg: ASbGncsVT2eD5Rsd4DG1RIIKmvjc1/8HjgoQBp+vP8hacPwZZAqjT6t68MTt0Sr4Hdj
	sT/XDY5Kj+d8ExncThUXxK5yN43WJeLFBoOiSRICb9DeH/cmjeVZ5jdgmy/oic7dyXfAhxZ7wAO
	+4PKb8DB3rYVe+kuzQnm9250xmobwzh+ZKJV9sUIoAkn26JUG8yOdQxh0riIVwLH1yoHQHc/BCT
	zzJGb3JpjvWq0nxOwOAkZA9UG/b3f/Pn7OiyQ==
X-Google-Smtp-Source: AGHT+IHJjUpnhP9a9BCpvVLpzZvdmFRUDDu4oemMG1IXcZXVXfUhtp9wpdL0LzSmbU5jtUN4x+9LhikiWu80XNjJGfk=
X-Received: by 2002:a05:651c:2109:b0:336:d879:140f with SMTP id
 38308e7fff4ca-336d87916c1mr56567881fa.21.1757048766845; Thu, 04 Sep 2025
 22:06:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829091913.131528-1-laura.nao@collabora.com> <20250829091913.131528-15-laura.nao@collabora.com>
In-Reply-To: <20250829091913.131528-15-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 5 Sep 2025 13:05:55 +0800
X-Gm-Features: Ac12FXzUw4mCbky5MPiHj8W2ByhD9sAje7rRwu3IY62BkDBlMB6KCGdwR2WWCfw
Message-ID: <CAGXv+5Fj9Hwmk2y_bZhGX0EUEY42tm3t0nTrjtV-sYhD_B-xVg@mail.gmail.com>
Subject: Re: [PATCH v5 14/27] clk: mediatek: Add MT8196 peripheral clock support
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
> Add support for the MT8196 peripheral clock controller, which provides
> clock gate control for dma/flashif/msdc/pwm/spi/uart.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Not sure why CLK_OPS_PARENT_ENABLE was removed, but it does seem like the
right thing to do, since this block is always on and doesn't require a
clock to be enabled before accessing the registers.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org> # CLK_OPS_PARENT_ENABLE chan=
ge

Note that I did not go through the bit definitions. I assume the other
Collabora folks did a good job of reviewing those.

