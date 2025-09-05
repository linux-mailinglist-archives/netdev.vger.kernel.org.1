Return-Path: <netdev+bounces-220248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F40B450D0
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E16D7A7C87
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 08:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD332FA0F5;
	Fri,  5 Sep 2025 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bGzL0syZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C6B2FD7B4
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059453; cv=none; b=QrHQQq9j4cHvoIm4LeubEwcNzMScvjYro/t4jO0LuoJqPepPgg7obPRxZsIE+uQ2hGLKD55ydu8vRnhJOTR7Cuhbxz9WJKApfXgrMwAS1QTVNId2qeTsGd+CjUA0IUafHp9AmIn8jVp6H5KdfUBCjeFFvDtF9IlznfWICNtqZpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059453; c=relaxed/simple;
	bh=gPfnz/o3iNaHytOqe7truOjcGer8WrwACGpoW942gks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npTJng+uMB0TlBr69f2mR5NWWExlM9xuNOXGng86rFu/9LPNh3r7yj30tmfxtmL88ZD+juSv/GB4/EG/E8NhL/D074vUdtkIedujGvbwT0TfGHgrxppyPs3i0ZSOl8rZhn2084Sh3GtKejcpuNPvT+vZDrZzF2XQfBHX6pnORfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bGzL0syZ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-33730e1cda7so17506181fa.3
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 01:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757059449; x=1757664249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPfnz/o3iNaHytOqe7truOjcGer8WrwACGpoW942gks=;
        b=bGzL0syZP9Tuw2/0AtF/bmdxZuSWwd+gXiqLXNd/9xOGMYNV9rMpUzhjtCVFNo2ZY3
         l78vFVU1pG0AWRrg7iWPp+lGTzRO+dzfsweZ5ZBqPaCH8FYiXGO26yAh+lzo2QBqvwa0
         ykCa59A+0TRJc6P+jYJO2uEWqA4ApH+alnp2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757059449; x=1757664249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPfnz/o3iNaHytOqe7truOjcGer8WrwACGpoW942gks=;
        b=WyTk7YNskhE8C+drTyz3lSBN1X5wOrTO0Wf5PGgVh/rxmK9pDFJdr/KJpWhj6/1gV3
         gz9yGNUqpKscMbyaMGfnleCPBY0Qvq2aXRiQut6UQnODOTxg+33iUXBSL5b0CpXbpnPJ
         S4RyphEfmxXkBwolfo1QuFgiTowlbxQnezcn7BPw86QOAY4Hwyjnn9MN76VHWHxiyDQ/
         MuiK3aBFrlImlASbBuQT2i3oXKggPbm4nqXqHagP882DpCPWmTb4I8ie9r8fE2cqBMIm
         89sqW3+5BhqQFFAJYAy5r4yqFe4aqSDFmn0aRRGPNz/OkGEW4sIy3QG8cIU+bA8d/aKI
         541A==
X-Forwarded-Encrypted: i=1; AJvYcCWX4i+DetjcT8jV2H0qSQVab6qPdOHTq4SLeVwh0SojF23IJ+Zmh+UfVxHShdiISkkKNcDkPNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFrrDrPZcOrbAvWcTcMmslXn09uNb1YATU927RfyLuqSC7nR1i
	LB7CZuKda2FFSy+/yZU4XgrJAr5nQ7NClyu50t7kpyqbW9ZWgCRjUh0Ri2i8MiewVSUQbnIcOkM
	vhyGueQBb/N7Aiwg7rOEQRdrftrxHr+xUYXt7KjQ9
X-Gm-Gg: ASbGncv0G6dEnxtVAGNlzHjCPJ2NCzDVfkZwdsojle2RMU3iinJLPOBg1Q8jAB9rV6r
	o6kY/ObBdl8HjnRRBHKDZv2WcbuxH/nLRKvZMn3+AuuXan7AthUVU5wA7nZJLTew9GY9wwNy4HJ
	dy+jlLS5rGRfITAg6EM/8kb2I3hrRpcwp7+88gq38DLEa3wl7BhtnzS6W2Py7/JJrYVyQJ7bEfI
	IbHbHAO4os5G1NU8oEt9sVY1T4B/5ebHCVE/g==
X-Google-Smtp-Source: AGHT+IHT043Y/TruREpGKZ+/QRl4lPJ5bvgN3xV40J/rToLhwUaxJ8c7vgtH50x+X4YlPrhw0jN/shKQPrGCvcazPsI=
X-Received: by 2002:a05:651c:1a0c:b0:339:1b58:b199 with SMTP id
 38308e7fff4ca-3391b58bbc2mr3260661fa.36.1757059449029; Fri, 05 Sep 2025
 01:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829091913.131528-1-laura.nao@collabora.com> <20250829091913.131528-23-laura.nao@collabora.com>
In-Reply-To: <20250829091913.131528-23-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 5 Sep 2025 16:03:58 +0800
X-Gm-Features: Ac12FXzqjLPg1snoakkIHpjZL3gjVDvpLkfu1BDJJWXmMZBGn3rIna_U1tSPpG8
Message-ID: <CAGXv+5GreKJSz76EiHYzX-ByfyxuYNYB6OyBJk9ZhsKCapPjRA@mail.gmail.com>
Subject: Re: [PATCH v5 22/27] clk: mediatek: Add MT8196 disp1 clock support
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
> Add support for the MT8196 disp1 clock controller, which provides clock
> gate control for the display system. It is integrated with the mtk-mmsys
> driver, which registers the disp1 clock driver via
> platform_device_register_data().
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

IMO removing CLK_OPS_PARENT_ENABLE is the right thing to do.

However if the hardware ends up does having a requirement that _some_
clock be enabled before touching the registers, then I think the
MTK clock library needs to be refactored, so that a register access
clock can be tied to the regmap. That might also require some work
on the syscon API.

Whether the hardware needs such a clock or not, we would need some input
from MediaTek. There's nothing in the datasheet on this.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org> # CLK_OPS_PARENT_ENABLE remo=
val

