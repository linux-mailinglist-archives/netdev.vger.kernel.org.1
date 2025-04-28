Return-Path: <netdev+bounces-186417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4840DA9F082
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 14:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6393C3B6ABA
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 12:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF0625F796;
	Mon, 28 Apr 2025 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4GQDDo4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896E81D54D1;
	Mon, 28 Apr 2025 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745842831; cv=none; b=MQ2V4PVLVYHv+yDz1Qf4XFNY+rVA9Axwe0fVXPf4Y2pKVWpAqmCFhMlOptWOugEUDjddWbJLjoBamYt8zK/GEi6t9xvR5EyxKhllDPrU1fU8iImd9aV/ylP92jX1KoJ46JYAuL/K7AAepmpketfn40qtrG47FI3KpZ1OsIyAeNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745842831; c=relaxed/simple;
	bh=5LJVD7EEo2QIoCV1sD+YeaR74gXBmkqhDW5rQm+7VG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CM+fUbCx1u8eKrBOE/atWK7QKxknc50Wwofz1N6AffsJ8bZkJcpXS8123J1rkkI99hgotO1pQxkmj0VU/TI9k4QqdV7QJXiZaBZ/b8ny6b8jo1OPBYvoVDmzXAvnAMWqxMn/b3wCkaYOAzXScRYkPyOdg73Rh6Ppo13b50y7qWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4GQDDo4; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-310447fe59aso54014801fa.0;
        Mon, 28 Apr 2025 05:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745842827; x=1746447627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWpWmVQh5LkKQ38Ckz6b68wz7ZGK8S3wIAjuRScvxvk=;
        b=Y4GQDDo4D0JetboM2ofJnJCPDTEsngQR3nHR/tnu5SB/UTgTpmhOjV8OdCAd/Ptugi
         FRJ7Gdrn12yHvl8R+B+dc3mk7LgbAUcMw949aBwPRnrrQbFqiq7IuyehHY6FCxA6plsL
         PL0mF0Vshqi434Bd68SEihnzjPj6AlF3oZbrmfk0L6dPnwOAeflKtFVnwTbBFwgQiZAy
         UUeei3IPU24MKFIESLFZLjoWDdQDSwmZgfgKdZvjoxYOUXZf8x/QKd1s26eM7+Ah9i5d
         dFjHT/TATSK8AdJkL5NxPNpnXba+OGkfTgw2yyybVIe3RLcwYzeAAw3RPCn7C2MsA6GF
         scIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745842827; x=1746447627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWpWmVQh5LkKQ38Ckz6b68wz7ZGK8S3wIAjuRScvxvk=;
        b=J7CZZ34L5mpLDCxs15WNqK6m3UDVhpyFFApm09IQYeHUKwUl5XrPGrpBrSu+bCjOLx
         jt5WArikpSx8Pi/8mPTFrLQeozWkQUEdg2ebvjlWjl2mFoZUV6+wb45Lg+9geeg+b8OX
         A+i4pLQLm1GgkdW3li8dg6G25V8U+HkqnVWK5JtZ2lXo/kb6s7WbMnCSA3kd6gi7e1V0
         N51a7ZfoRMSKWrl91uHdFH4VuHw6BBvS27f0SH+0zWutK0qYuSs9StIo4e7LgIR2b9tP
         +wI54D3zH8/nRG49Op9Qcj2hmeqXh6gJ8moInDh/JXFbTKSynZ+UEI7yv33thCARtKqz
         Duxw==
X-Forwarded-Encrypted: i=1; AJvYcCUzNOywBae+hWxwsZVbmQ0cQ3zXm8VTJtbd5Hm6tR7SKjr0U4SxV+9CLYR8ZthIcPT2+yKjAdv1qj1Sixnn@vger.kernel.org, AJvYcCXnixzhUXFudiTGnLTAStfTrwVDJYRc8LO+CGLCMymI8YkY1osnzOVsdMkqI/Z+dgO1vOIh9c9F6f5K@vger.kernel.org, AJvYcCXrY+ibE2Lh3BAuP3jsrPuU6R1MWnG6fOJWzVN9AQsm+OsMLVwqCZ5kc2sqdXpyFIJkzI3Z5mzB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm6qncv/XoH0Dw5bd7wZzL8M8Og3mR9hIHan5J1T8GwyHuOxDs
	o1cM8bz/F1MD3pXaoTmNIxhlnpQ9PFVQD8/DSiuPgk8QYj+UfoiMPGU2lGCIo2J16PZGi1PLFN0
	6U4yrUZGx4pJzsJ17J6fEW5qYwtU=
X-Gm-Gg: ASbGncsqAb8s/yECzhYaFK8e6IosrPDLQm9y8bTlTJ+soDJ9yPU9FW9DrBwQwtF56G2
	79wmNiFMs3u8IZCRiYCrUH57ofYA29uU70soaUj2fxAx2u3nSwC5YeqqJMAWCuqX0F54dUXuK1h
	oKfjeVbjc1QVMaSzNp/E958d3UZRzOUDROza4FhQoDiXYtbQENt5SMQLGOqmfN5c3g
X-Google-Smtp-Source: AGHT+IEH7MzW5oALwsc/C1WmzilPjbYvu0ys4k1ey8nO0994HXLEhmlKcG8IDGOmdq5NvefT7TwCpG/T3Y0sA3Y96g4=
X-Received: by 2002:a2e:8048:0:b0:31a:56a5:8454 with SMTP id
 38308e7fff4ca-31a56a58783mr13285171fa.15.1745842827247; Mon, 28 Apr 2025
 05:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428074424.3311978-1-lukma@denx.de> <20250428074424.3311978-2-lukma@denx.de>
In-Reply-To: <20250428074424.3311978-2-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 28 Apr 2025 09:20:15 -0300
X-Gm-Features: ATxdqUF9vhWUQdAh6ucd_rpBTSQD6jiO0FGzDnLrY9eVB0nzIxQ7MHR_oHtFiUs
Message-ID: <CAOMZO5CYq8YKZBM6nk2pk8W0005MBBPdVqS_qe-O4-ZzkUG0bA@mail.gmail.com>
Subject: Re: [net-next v8 1/7] dt-bindings: net: Add MTIP L2 switch description
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Stefan Wahren <wahrenst@gmx.net>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Mon, Apr 28, 2025 at 4:44=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:

> +            reset-gpios =3D <&gpio2 13 0>;

The zero here means active high.

I assume active low is more common, and you even used active low in
the XEA board.

I suggest using

 reset-gpios =3D <&gpio2 13 GPIO_ACTIVE_LOW>; in the dt-binding example.

