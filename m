Return-Path: <netdev+bounces-115419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1999C9464D6
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1171F2161C
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 21:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8125A74BED;
	Fri,  2 Aug 2024 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XjcRQXPi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA89E130495
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632949; cv=none; b=oEbgd9YIXDA0/p7ZQl7sNONrunzhpz3Ih+IZTEv+GCh0OLXaCJqVlRmxXduayX49lWR8A1jUQO5IOcnNTLdkeghWpLboUS+PJYAjLX9iW3WY5P5544aBkoaXFVbciafVLbVYVd2aIdqcLQcIyrVzlfdWWiDWvl4w3A4jnBpfF00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632949; c=relaxed/simple;
	bh=P7g9T+8YJ8GVeScpcyOp0pJaSiqtooOVaooHR4xFC30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCC/Pad6sP5xDlKzzVU9YGfHoq2eI4+OlZafaDweXBbaC0nIgngsF79hY45tFpzIphTbSQDqU0iGZbEODAkGuZlBlYjWI+rdL4l8XfJhezJIzLOooAFtuZPAbLPXUVwvHlFbM4ce6xDXAxsbA/I2QXB6kM0fE8YgnQq4wuEZ4KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XjcRQXPi; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ee920b0781so92289371fa.1
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 14:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722632946; x=1723237746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7g9T+8YJ8GVeScpcyOp0pJaSiqtooOVaooHR4xFC30=;
        b=XjcRQXPi1ZQEHg8+qhOm4HA9811DDs8VTA49AZ4PpbOrhhHXLAWoBp4rP7msEFYGb9
         UYVnbYcCn0aWUShcL3Auzwr1abfxrpwPeWITlFKQU4PsF3Q+qO5/NhpwRlBMSBJaWlZC
         N9P1qFMg7cj27KCFsKJNYd2UnnP3olyGagZeXnXE9clWotwcXOHDMKaTmC2krIQEw4Cb
         Ei2FNiVcKC1Pm0aTApqt+NUw5y7S0wwaLdXq7epBXulVOQCQZzj1uzQo6XzkSqwLKUQu
         RPCRpx3TPm60bBD+PHQgnNM2IYdqqlfVsJADapEHF/zhzGxhTMKyCsuxBg+vIksLXo81
         A0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632946; x=1723237746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7g9T+8YJ8GVeScpcyOp0pJaSiqtooOVaooHR4xFC30=;
        b=rGd4HelSd/09BVzn37bli7LKYPjUvZ1wbr06kTOyC8VItLI1glxT5whN3eZkHoiWRW
         +09mNuMX/aPJIo2NTvEGTXmRHsHQO9ghEj7LG99hO4xpeJR05DWmLR35+UesiAww1kmS
         tnHCaOvlkQwfOVIyjy4V3xQLFwwnksXBVrCbRlTshp3jJHqc919FG+qh0n14nWhLw0z+
         smqgidrTK/KbEUSdtYJekP9bBBZjcHk/L4bhtVtoU2RCfoM8QWS69kKcSEgMJtzwp6eG
         vVHDwl8o30s25F+E9yJdU4KK493Vb1Kl7qj+AJzjXNY/2KGUcR/ytifaAbJ7IApmbLZ/
         aCvw==
X-Gm-Message-State: AOJu0YyTU/BGJQa9VU1FX0TO1WHcVLMyeElEVI45oW2087WzKk9QJyqA
	0BHRwkeLuHVw2dg3VBTCRzOp6pTi8pPJlfdRDh+JyovTlLrE7uXImyWbELaSzTb0qF4xstkPVtQ
	tzUhGY609JQu1QD0H4R37cFKsE0skLsylqpQG+Q==
X-Google-Smtp-Source: AGHT+IGQXPKOPq6mXlRxwa/OZvDGlY7D3/zXW+vcnsb9KdOGySiXKSQPIw353s/l9s+yQpPz9GFodXHeb3EwsMHAtYc=
X-Received: by 2002:a2e:9d87:0:b0:2ef:2b6e:f8c8 with SMTP id
 38308e7fff4ca-2f15ab35361mr30379221fa.42.1722632945768; Fri, 02 Aug 2024
 14:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802080403.739509-1-paweldembicki@gmail.com> <20240802080403.739509-7-paweldembicki@gmail.com>
In-Reply-To: <20240802080403.739509-7-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Aug 2024 23:08:55 +0200
Message-ID: <CACRpkdb7Bw5WofEbzxYrDHnzEZv0Ekj+9Y_neHeJdiz5TiBDXw@mail.gmail.com>
Subject: Re: [PATCH net 6/6] net: phy: vitesse: repair vsc73xx autonegotiation
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 10:04=E2=80=AFAM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> When the vsc73xx mdio bus work properly, the generic autonegotiation
> configuration works well.
>
> Vsc73xx have auto MDI-X disabled by default in forced mode. This commit
> enables it.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Looks good to me, as Russell points out there are further improvements
we can make but this patch stands on its own as well.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

