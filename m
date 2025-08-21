Return-Path: <netdev+bounces-215602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E07B2F745
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 13:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5150C7A6092
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 11:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3F42E03E3;
	Thu, 21 Aug 2025 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o9dY4L8f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E67A2E11D7
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777399; cv=none; b=VREh9jZvEO7Di8NtzCu7VVTZbK7k9PJJdvPKzS6JrrLzl3BtQrzyli43YmvIyn94DDPUgPZbfmOyAUzO2lpxuizczRxrtmMgtd+viqtgeZpfeWnqQmCI9T82Xevkri0sfCKH819Z7fY6zOk+3v/+qtjKdT8Z/96rDrdAQafKOjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777399; c=relaxed/simple;
	bh=uf6vS3Gl2AuJ7xqaJiaRJedxS56Xesptizd08sfMens=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRR2UaY8lgodNagIdjM/QRhnvKYIDTbhdAP2Yh+lAZS8SjN5kqmsYbdpWcanbyX0JBVwjPPCE47npLl6j0IPDp+uMp521on9oIeN5vCM7pI3LBjN6rbuO5GmNleOhB0d9VrWi7teCF9iFuEXc4vnU/qeFfPBstQkLMDGRyhr/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o9dY4L8f; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-333f8f0dd71so7544761fa.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 04:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755777396; x=1756382196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTRZmz9b45Hl2bTm1apFpY/NlVi3bfWcm6ULUt78zN4=;
        b=o9dY4L8fRM1bgesRcuwCsQbbh9CoT7nEgAEvHTWjMmcrsg5Ae/bAboardwNfBC0b0x
         +52PYLRAZLcwJr/nZ/mNZa3yryQ0S/vnvLdoMTs3KnANoqQLYYjf74eu9UyprDu8hIhA
         Ah5Mzim8Ey07GIGSLTEpJDmYOvkF3iwdR7NgTYfxty/wJNax+cQ1jdtXzfShEit76lYL
         uekFlFe46yrOSHYRUne2eMdd1S4KAphVwJMI+6Q3khPA6SLBiHEqrnDEi9Wk6e9vKR28
         8CjhxLGZQikFNJ7SWA778FzUTvDlNY2KXJCGxc6oyE/cc3eOGVTKEtHEDX63AeS8neAY
         I8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755777396; x=1756382196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTRZmz9b45Hl2bTm1apFpY/NlVi3bfWcm6ULUt78zN4=;
        b=gQPTDI+MNwsi0L2uUukuvAnvgc+93dj9YsMFWssY53zXRmWBh6+Zr34H//Cs70KDzw
         qYaFihTcVwOS6vtVCCjVASJVcMVVG1f50GuKNU2mYhyDiFBdQi/VBKx+4ygIk92wIBBf
         gxkkpmSwQcZoVN51aOOVppTAhYgxyv1Hk8ThBOLBt7SUvGecmG9wj/0pMvalfn/xbFzI
         enpfZzhWhaa2S1QEquwY3AoYeBeUYuhmu3SPCPGV5R99prB1Q+UbghmAFD4l7rueH8IT
         z8NThywSb/2A4jvo6WmKCR+Pt5SnYsQT+AVblgZTQ0Fq760q7v1XxRMcJLvuO9I0Jj1z
         7h/A==
X-Forwarded-Encrypted: i=1; AJvYcCXTU/6c0qqws0qOa2OGezMP+PjxWsuDlzo6tai7CSZwhDJD8JsHLbSF0vq3ybkA3XaE78f/ZBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH4ULHg5GrW+x9465Wy/SX+GTLveCdOIxzGhHf5zENn7zpj1b3
	Ol6w/h9oQmA7Fl/Kjm64K9Yop37dIJuhjfq+JFWj1Sj1m19UY8rX+QIFtafb3pKAn2/GmTRzQwW
	jlF0M8Yg1Wf/+abyt1lrT4qt+u5RvC1alOdlFCEEsiQ==
X-Gm-Gg: ASbGncsVSm+tdu5jCZIlUu5+aql7mcvoE0YhISRoXF6+4+HonQhrIeofXobTJDa6lxh
	3uuFVHP0WFWwpU7XM8M062i42qBTOlmTYPVWiuAz3yWVzy7LNgJvp6ibeJUbNev6R1HFQO1fd9w
	p12UYMtfIjg7jxkgF5pgAWnS5ew562OE5/cdYOtKW4hXt69R9nsf2/rnEzaG5CoIbaRiyHqFAt0
	lnVQo8=
X-Google-Smtp-Source: AGHT+IHLNT7GNgIK+Yc1AUKtRsJ+Pu3qxvF99KQLgmBORucS0GzpXEZZoUCuuB+z9QVIQwaQ+MKKQAluSVZweFngFeU=
X-Received: by 2002:a05:651c:54a:b0:332:57b8:92eb with SMTP id
 38308e7fff4ca-33549e7e81dmr7293611fa.10.1755777395492; Thu, 21 Aug 2025
 04:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820171302.324142-1-ariel.dalessandro@collabora.com> <20250820171302.324142-14-ariel.dalessandro@collabora.com>
In-Reply-To: <20250820171302.324142-14-ariel.dalessandro@collabora.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Aug 2025 13:56:24 +0200
X-Gm-Features: Ac12FXxjp4iK3cFyWU_S6p_GaEq9BIq8dd_UPbgZlXscJTvrfMnMiNgyqvjOGHs
Message-ID: <CACRpkdbpKqKyebADj0xPFq3g0biPh-vm4d6C3sd8r0URyfyYRg@mail.gmail.com>
Subject: Re: [PATCH v1 13/14] dt-bindings: input/touchscreen: Convert MELFAS
 MIP4 Touchscreen to YAML
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

Hi Ariel,

thanks for your patch!

On Wed, Aug 20, 2025 at 7:17=E2=80=AFPM Ariel D'Alessandro
<ariel.dalessandro@collabora.com> wrote:

> +  ce-gpios:
> +    description: GPIO connected to the CE (chip enable) pin of the chip
> +    maxItems: 1

Mention that this should always have the flag GPIO_ACTIVE_HIGH
as this is required by the hardware.

Unfortunately we have no YAML syntax for enforcing flags :/

With that fix:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

