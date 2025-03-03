Return-Path: <netdev+bounces-171380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F10A4CC43
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 20:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACF63A8225
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 19:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCA72343AE;
	Mon,  3 Mar 2025 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Een/v3HG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B9A2343AB
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031603; cv=none; b=bIIxc/uG9f+yc97wH4qk4WjSOtt2o1sx/UcxYia+7M7d164VvzLyWKR0AAIK90FTedpiRhgVEJxrKMXFiNu8u1y2RhO9u8HGgcIL9ZtNeYuPV3RqP8a9vf7p67QM7Xkvskeh+akbPLjhkRtC/UOYXLKfz9k4qPqjzN2nrpPSMBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031603; c=relaxed/simple;
	bh=QFTGZif/JgVgVDzzGQgZIl8WC/WC0ykZHCXDdOp8REw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkAad2LLNK4KcRP5E3w6Ys72EPgiYP+mmVcDwM+rugLULeYyCuu22iwPJpPW+ZxbGvQP0/w7C0JIRyfC3sVtT1MKHq+/hy77ywtNqGwYcfZiiJ5JWPf/nglfII4+3GEHGrZAHlT9XI6Eg9e9G73CvXnEQJYNd+mD57jr7lcjln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Een/v3HG; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3072f8dc069so52728311fa.3
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 11:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741031598; x=1741636398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFTGZif/JgVgVDzzGQgZIl8WC/WC0ykZHCXDdOp8REw=;
        b=Een/v3HGrIUsxKLvpK/7nPtnYTaacphMIjptWX0/VuJMJD3H070xA1XR6kTs0Mo0Qd
         +NOCoa/Jo/5AUSoG0ChZRnnea9heys6gnguP8YjQSxml+Ytto9mkOmHzgxt8tqb8DhG/
         7PdcgP5XH/C3n1+2dUCQXK/6Qtt3VvGfVnEwPsornhgflN7+XsagEBSyDbK9GSVqwKBd
         ND2VFZW12cCMLJJEbLtbjYb6VZQwXVL+riMPhLNhS5Vw6moP6tA4UagIaUTgb8S/G21z
         c4Q1bGIuFkKzstiXIIcrMMPupvCJy7BXLh8FWHajQnfvUTIxSTQBZ+2YUzsB0kyfS0wt
         GH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741031598; x=1741636398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFTGZif/JgVgVDzzGQgZIl8WC/WC0ykZHCXDdOp8REw=;
        b=XIBE/GBZVkj5j9Iu88wzEhdN/FckEGi5vrfR/kGTFAOGCILmZuIaONN4DwhxbroJCe
         +4ECXYLZ69/qvhnxuiv/qYjY9Km0NQxKR7Q+sUQCPmUkLLMFWMyBiQ6j1yB+wo1LoijW
         u0CGiaraD9pSju0fZIxdPjFaVXP5jM6VemtvkJ1Xh0pte9z9c3k4RNnaetvbcYWolqxl
         1w+lqIhYQnEKlIwKrCghwCKUB1G8BBuxiz12XQAibHV9BtHO7juMWsc5ZkyAPVRcoemD
         2X+oK52R9Ex4DG6YyjHupMeAPrmjW9skRXSigmOv5VPThWrVXIq8n8LOS0YrZbC6YM0n
         Q9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVt/h+HS1mC1ZvZZPOP0cEgq9vW4Hd1q5bf5XfYZF//gbfs/ofzsW/oaS83Sw1apn6YQxXCBCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRjWhj8Ajv4ffK2Sld/FfNpWC0H4YovKt48+CqujKXVMOBZoCY
	83Bvy0ZMSLIjeG/EUI5SBxUbzqTT/0JyGSIXIFh+vY2yve/W+1R89rj0PLoCfa7Olxx4XIJ34QE
	eT3nZVPejsCS2vQtY5hLDrjiYl5kXuZXLQ3WVgw==
X-Gm-Gg: ASbGncvA0hgLHvDtcYD7o0H3RhxNHc3xV5hENg75Yyb9qJnKzTEASUZhvoZHQZoDPnT
	2VZqoja2zy+7SXZZQGbcZMOpiL7YmtzwBh+k9g0OyDHz2GPg0IKVgw8+RkJwX/jXM+sbmDtMkIS
	1d3sLmgHRDuYuizkBOQc/67j5+cQ==
X-Google-Smtp-Source: AGHT+IGAA1jTPTvt6x1HBPDHZpPdg7RIJLS5NDUt79SNfZEN5S213uxZfLpsDGTLhFe/KqTn7rcm59WJNzLGOylvX74=
X-Received: by 2002:a05:651c:1a0a:b0:30b:badf:75f0 with SMTP id
 38308e7fff4ca-30bbadf7dc2mr20317411fa.2.1741031598367; Mon, 03 Mar 2025
 11:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303164928.1466246-1-andriy.shevchenko@linux.intel.com> <20250303164928.1466246-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250303164928.1466246-3-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 3 Mar 2025 20:53:07 +0100
X-Gm-Features: AQ5f1JrLhAM1wiHutYCTK7Ia19KZ1ZhoXNrkXyL4siFeXMeh8rxos64YMy1PhkM
Message-ID: <CACRpkdbeTG_55VbH3GBVpB31D9uuLHTZpuzjA3PuxwTB+KEq8Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] ieee802154: ca8210: Get platform data via dev_get_platdata()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Access to platform data via dev_get_platdata() getter to make code cleane=
r.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

