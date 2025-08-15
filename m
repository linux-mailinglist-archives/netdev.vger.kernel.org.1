Return-Path: <netdev+bounces-213949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93E4B27700
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 05:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67CC17B5420
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004C529A32D;
	Fri, 15 Aug 2025 03:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kwvNuP2C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409E21E7C34
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 03:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755229404; cv=none; b=BabGjlDKCx339/f04dpYb5tMmUA3uHYFrYUxEZ2Or1+KZbRMcrqE0hSeI97Jef05T7JUiaEhB0tDIDRfyTf9Ujfpk1g7pIfIyLqeqlfjm7BwMLglxPKZSXTdNyuTNSZqD2RTbjLTZqrRWKD+qHZ83c3FU58yLUGqNrQKdAyMVbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755229404; c=relaxed/simple;
	bh=b1bVscfxC4uFT/CEoA/bhRidOult40TJcVZcOy00MCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nd19yGwi9Ez5kmO7aJ0WBfAm1dNkUtVTpk8Ej6w0iDYHD+AYxlDBlFkiEkgSfL7MDUEUV95+EKXmhjBVdQ1QeH0E5PD9cpr3l62CNulIXIRA+1DWfx6UWgts54uhThXmEVlpoArc8k5JzKLK7uzTwZrgxLes81Ov2BMWhdyJPxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kwvNuP2C; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55ce52658a7so1486832e87.2
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 20:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755229401; x=1755834201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1bVscfxC4uFT/CEoA/bhRidOult40TJcVZcOy00MCI=;
        b=kwvNuP2CIZOJMuv6JQVxGZF7wCgfvL/cCINTMjR+jI/e/I80srcqTzD2IdB5OTKOMh
         EjKdYYT91g00ngvRlnd9VdncuLw6ZyCiOPuAYcgMit/ol2jw6VcOU90uXEEYkqmcO70+
         g1GFtDCE8xJdE7Nmm3IKuPmbxweVaak5KzfD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755229401; x=1755834201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1bVscfxC4uFT/CEoA/bhRidOult40TJcVZcOy00MCI=;
        b=A4d1oO4LH9IwSRr15+8SymUBBWF0rMMWjj7BCrF63aEhI7Vf61so9pOMO8yqPybSCh
         msnLLcEd1rtnsbN6dwkUJBfQdDf7M8SskBFn9iVMstDhBjcKaTHi+wup20oCehswan0X
         j4QvDLDKXa+aHczxfKR3mvvHQgyKDTkCOI3ZgaR5i1tEyAteaXqDd51+mpQLFppPA+qc
         KzbOJESmMPwr+8FuJ/+1os6+uIh4pvTxpqMvjGGmXA1n1SIkQVCjXm21p3krbtY3j6c0
         kJYjOWn+zuojqoN3UgqWr91j8EXRE3AlhicoErKNOK+SVloNTwX6YvnBELdKOH0lL5tI
         v2yA==
X-Forwarded-Encrypted: i=1; AJvYcCU8KAcOH0jkB2ahEKhlM81NQQR210b1T9sGOKWkA4VnO+QNTK7J70JwddiyXNTTPGsawPHl6Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMXb7zJOffuVAvEwWKEKmp6mjOcvQ/yLRJ45elHWIeNKePWcC8
	VD0neUc+R/CeGLvC8J+OFsto0WyLQhAGz8GrGZsQohABsPmH3mal0hj3DJ6VB9Ze5yuC9CLnfiZ
	RlMl0Af3S7t7MgVSY8xbPjBQmXe7DIyROr69xAdIm
X-Gm-Gg: ASbGnctO6d/83r3S98hKXBJ7iHS0l2QtRQUAkGSKnlo+iZ+QPOWniYtTDmnOgCTiStc
	XyHcXIUMakAekS3hLZ6lmTG6aztHMfGgxNYJ9PFOFKvxbMIiJh54oGYK31KDZTYa0g0c4WWUUxP
	XFQmyC3FYTYSx1DZtaXwsmsQZN97I9YTsuGPKK0YJQAInaesi3JGYy1pn+VTodQyhYFur/a/Cp1
	5qBoIEPs6ZBqPurljxM7HE/M+jFIu5wBX+uSQ==
X-Google-Smtp-Source: AGHT+IEqCwdjtNotzKv7k6sNon11epPQ9Q7yaZt1pImrKpO8J5PSviVGiMjVATClFXgSR2SA/yoBT6p78Ov7Q+2gotM=
X-Received: by 2002:a05:6512:3e0d:b0:55b:84e7:e14a with SMTP id
 2adb3069b0e04-55ceeb42b0fmr131122e87.25.1755229401420; Thu, 14 Aug 2025
 20:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805135447.149231-1-laura.nao@collabora.com> <20250805135447.149231-9-laura.nao@collabora.com>
In-Reply-To: <20250805135447.149231-9-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 15 Aug 2025 12:43:10 +0900
X-Gm-Features: Ac12FXzyZO_yczjiRVwJ_XiOUJ7K7LAiS8kN-QE11MKfkqUjTCK5j2sczcKt2tQ
Message-ID: <CAGXv+5FwV1YuBoefMAX1UvOd1=cg9Ld1ZawyNts1BR8YMezhKQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/27] clk: mediatek: clk-mtk: Add MUX_DIV_GATE macro
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com, =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 10:55=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> On MT8196, some clocks use one register for parent selection and
> gating, and a separate register for frequency division. Since composite
> clocks can combine a mux, divider, and gate in a single entity, add a
> macro to simplify registration of such clocks by combining parent
> selection, frequency scaling, and enable control into one definition.
>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

