Return-Path: <netdev+bounces-121441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CCF95D2CC
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 18:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB37284045
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 16:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF79192586;
	Fri, 23 Aug 2024 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q7lF8JQx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DB0191F8F
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429558; cv=none; b=Fy4DHUck4GLOXCKTwqR/7UTAUSBkI+fYpOzsGZUyCIGaOMHqgDN/wU7s1bRB2kwm3tX8yyhy7vV05lKbSkFQYTt5oGzsGxmElAZwu2jRjT98pnosJaWYDWkL42HWdDstKCJ2zH7wsc+kAk2NSylRP5WNVFi8pgywgLFCaBpdVDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429558; c=relaxed/simple;
	bh=foDX8nSpdBE7Stl1C+tjFDYcGaddTLXx38TRzjSaijg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iISdx5cdjcgE58SvdaryRdZDI87Wcj5sWSptZOCZOHQpBz0Ed76TheQoQNCpLGkC7YMfT6rCG96opAUrdoo+SNNEyY2V4mpidoOqPBWvt9QmIB0qFjYoENZOsn/AIpN2v/gA4Gm3zHNZmZOZ6MuREQ7vy9Jj7DAQjYqdk/iqWSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q7lF8JQx; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-533462b9428so3756044e87.3
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 09:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724429555; x=1725034355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1jmXMGgCEe3vyECBk95vJ+hBk5w1rZzr4yvt3CADUo=;
        b=q7lF8JQx9kaMQYqIConQky3t+HpxtW3GmsnxciWj2X5f+e6FAQhKUEiPASxiYC9Ubs
         ly45/guzT1gcKdyizYSAT+I/IgQ8qvv+Q8RZoow/GEAbxjdfeCaEZ7gS7eBzMA4O7icu
         P2XGLCnVA4NBCsGjP7FkdPwtZvf0mS6bi8/A5U4k5qhOdqahRHDLuPa7aoHV1orSzX3w
         m+OmPjQXNtDI70BapCyWG4wfxhl8/5n9YgOB2r5dTI/iCsvrqEFcapPRVpe6H2ZrmloI
         kAmtTAUpoooM4By7rNfB21Lfd3kD/B4vBd+7fkUcTWvtZ3c0tgPd03mBXCXFCRfRi0j2
         pClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429555; x=1725034355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1jmXMGgCEe3vyECBk95vJ+hBk5w1rZzr4yvt3CADUo=;
        b=DvpSp1PZHT8YXV+vgd6nu83zHWvZ6Xfcn7uEFV4rtWV34xkzyf4cAvKsKDFt+NBcWu
         M8BFfYeEndz6pObkxAAzkUONHt48eS0pKu+MobAvbfTzfpKj/yHC602219Gpdk68qDur
         Jy/qx/O5QuUJomjMAZrNNVxQCGkOSCiRhFepvYzITsMwoDUl+AkxA6BBbcPAsB+2kz47
         TVu8AIW2jp6hTXTjE5NUnVCJor0sHTFa7KwH+SskID4OKDaEiGT3B4DvZYeanMufhVnb
         a5j/UqQQo1bsSuO3Y/1Odfvn/l7VO7O3XeoAIzvcDzRnRtPLcPu5jI1IFxXZq2H3tSqL
         Ic/A==
X-Forwarded-Encrypted: i=1; AJvYcCUzk59TMCAxYLwMdQYQx3xJOPgK3v17OV9QwLvVOG+ZpS+mnF+aFk0YK3wKmr41h8JMIclhQ3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYABTxERPi24bWwrMhRWLsUEGYJ7HFD/Rg5v6TTPPEOInuMnPy
	/pDYSNKVebLMsUTNwpFth6RTkoaH2MJvFTzYsETO0ozBH3EFSRbTQXuL4iyuThP/9YcbsJqjrPk
	o6y2U2GeXh+ySJTZBPZc9GML8FYgxEDWbb7QDNQ==
X-Google-Smtp-Source: AGHT+IG7mSCIWYZ8bpH8IAQGda1ENwR9WbQciD7o/G7QbH41YO9wcFnvMe+Pbl1EVS7OeQRr0SFN9rrPBxhDD4ALEaE=
X-Received: by 2002:a05:6512:b22:b0:52c:ddef:4eb7 with SMTP id
 2adb3069b0e04-53438846f4cmr2471437e87.20.1724429554337; Fri, 23 Aug 2024
 09:12:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811-dt-bindings-serial-peripheral-props-v1-0-1dba258b7492@linaro.org>
 <20240811-dt-bindings-serial-peripheral-props-v1-4-1dba258b7492@linaro.org>
In-Reply-To: <20240811-dt-bindings-serial-peripheral-props-v1-4-1dba258b7492@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Aug 2024 18:12:23 +0200
Message-ID: <CACRpkdbaHqJfK7989rx8OaS9mpmdYO2Hpna6dUty_fDgYa3chA@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings: gnss: reference serial-peripheral-props.yaml
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Johan Hovold <johan@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Daniel Kaehn <kaehndan@gmail.com>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 8:17=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The "current-speed" property is not a common property for all GNSS
> devices, but only to these connected with serial.  Drop the property
> from the common GNSS properties schema and instead reference common
> serial properties schema (for children of UART controllers).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

