Return-Path: <netdev+bounces-60150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F63681DCDE
	for <lists+netdev@lfdr.de>; Sun, 24 Dec 2023 23:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A3A1C20D10
	for <lists+netdev@lfdr.de>; Sun, 24 Dec 2023 22:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC6BFC1A;
	Sun, 24 Dec 2023 22:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUzc5jdf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DA1101D0
	for <netdev@vger.kernel.org>; Sun, 24 Dec 2023 22:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7811c58ee93so218788485a.0
        for <netdev@vger.kernel.org>; Sun, 24 Dec 2023 14:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703456814; x=1704061614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3Jh/2CeSRvov2QcWQ5b6F4rC5weMXxkwbr30ulDs9w=;
        b=fUzc5jdfDEX30NF8FOwWFzHunNe2PkiJeoYoHSwYR0C1TP1UhgCoWBsINelNWlfDdm
         Pjz6SYeg2uFZtJwpFw+09DbvbMALtaaM3UFDd/TejPGJ7IBNWFKnPn7VeudeHini9Zds
         VF50hOYVIAntg6atwlk3MWMibdgI+9jmLN5u53h4JmHgXkhhYGxQK3bMtkQHHv+9r58y
         v1fFLVTnEIa+XtOXsstEgw86p7kzasMZEqmWpavLQvlFjatnskLxPJf6RCc0K81ImQXT
         oNL/R2djAIgWsOTX0bTGKsNTSzftoXVOSSXzOQfjpfShsLfL9Mj67xSL3jGaN2zAf9bb
         OZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703456814; x=1704061614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3Jh/2CeSRvov2QcWQ5b6F4rC5weMXxkwbr30ulDs9w=;
        b=exYY3V3VpldkxQAzvvLbWPMjHbN8Uo5VQMGZ3niX3gjTJjrvs9I+tz7VnHYr5OlvPo
         MfqYYRmPZCDG0EQzO8tHAI8I74WtYxzfIpHgb0QKQgf9txDM8Ckjz/TZVopQkVEq3M7g
         Kk2eRrkNQVUVmRhJDG+1CRH2N2wz5Oj96+AYL/VgiB1vwh7AfQFXZQYUYhT0ICnMNY4K
         Uj6Oimsi2YMFxoeTgnZ+V40oybT8hYsQ+VPcEjFY5g67330W/IRbfo6+pk/8s6eaN//7
         6lX1M4DWYx58mtgj+gKGDGzzXWFCqs8wRygNwkwbQpolh6FjNNqe4UG2D5ropy+3Bs6c
         CEXw==
X-Gm-Message-State: AOJu0YyEbluSEQwla0lyw2XJacNWTiroKlwS5iq4OzUaBIHjd7rsWQjQ
	3PiNvBg/E6DN3d2nreK8ALr6woQ4KhNA3yH7vOFDKsOFneONkw==
X-Google-Smtp-Source: AGHT+IHyY+ImRr8Mt00sdQQgvA/xRB2o+fX11DmOXhgJM2HpsJOZ/Khb2F3sDwWoJvf1fALr296ZHh5MK1/i60qKvB8=
X-Received: by 2002:a05:620a:2a13:b0:77f:9626:d230 with SMTP id
 o19-20020a05620a2a1300b0077f9626d230mr5781919qkp.72.1703456814158; Sun, 24
 Dec 2023 14:26:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223005253.17891-1-luizluca@gmail.com> <20231223005253.17891-2-luizluca@gmail.com>
In-Reply-To: <20231223005253.17891-2-luizluca@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 24 Dec 2023 23:26:42 +0100
Message-ID: <CACRpkda36RJoBwdQGocikin_AiaiDs_aDXRL6XvxhCvMBovz9w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/8] net: dsa: realtek: drop cleanup from realtek_ops
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 1:53=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> It was never used and never referenced.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Reviewed-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

