Return-Path: <netdev+bounces-151328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF9D9EE25C
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 10:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334A218874C7
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 09:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCFD20E00A;
	Thu, 12 Dec 2024 09:14:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABD720B808;
	Thu, 12 Dec 2024 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994842; cv=none; b=J4e2plWq4+DQRj10+5Ebz9wluh4zv/9NBk3WUPcD1X953ebGx0M2WgQ8YIw0FAcs4f8HNS/n49mD/4gSzssFVDrqXsi6PE5VxrbNfMfygiMBoCFK38M5iu5A8fG3LUdMZDCPBRGo0lr5Ulecc8gI36xEYsmP8saVGedkcOVW50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994842; c=relaxed/simple;
	bh=jMe5DMsQaVgJD30Fuf7T2bz+p7iJLMSRi7QyfuCSVkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZ3B2PkQWhWMqQs/bE6KvhXg+tgvT4WJ+Gl6f3zLIaLftZo9zMlP4nXa4yzeryCiOQqxgCOGdO6zD4zJK6ozN+/DMktF/iIBaHmlOJFVVEmghPrNCZMu4TqzQRFmWcG7F9dzcjb7tgnSGuA6Qhs6cASx+bqcsxJVC6TJ8tei+Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4afe70b41a8so89789137.3;
        Thu, 12 Dec 2024 01:14:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733994839; x=1734599639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3vOvdd3INn7kkIYe2riOUyRlnXmK2D+iAwEfkSB57Y=;
        b=ZfNMsdDRMZ4ij4wq41fpv9WqKbQEks/pPlebRWDszY5MkgDpc99Oq7Pp3nHM3Atfi7
         QFNNZEAOkf/W/K/d7oRz2GC88jn3beLaLX1MFtjsqUaEfSleDC7Q0+opcKLsYUmlQtS2
         0Tb1yyEQgx1zTImgEtKuw91IYz3l6YF/scjXam3U/PbJWjYoTWT3JYKyyTdfOtueKGoK
         Ad3d2KpoxRUNNGkPShDUPMje3gVO+f22djhZ1tsc4lPyhNHPizMNGryROysX8Oo/u/sQ
         /iBJIWAtX2qyomGJXwHWndcDFgu8wMx48NN4L8aWr+T2ORQ09TBs4mVSjh2IIEoHlEVV
         qzjA==
X-Forwarded-Encrypted: i=1; AJvYcCX4zSMOdKT96tIRZinoAX5cQZj/467fjfjmReDL2O+AeDo9ZuEdPKTrL8hh+1SdUqwwmvGzJNxh+qBzNXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrP0Y+d0JeiqmMzLsAC6mZJcXEZnnWRyBnS8HZCtbScTPnjq/t
	DHbvLCua2oxqCRCNtONs6VTnJ+d7Nd9+v+x87oNTyo17I/dT0lWDtDnHcZ1slyU=
X-Gm-Gg: ASbGncswwa/XwZZa5oc7iNDMgzoCdUD5Ru+9YI+AnOVvJvzCrJ6Iddst4EzwGPXFfxr
	PaWtIDpocUdN0Hhw/phyIV/Z7HIpbG++aX+Fb9o/zRvmN8NYOsRe1Wh+UU9kE4HfM+RsEkq0Rfg
	wJXlAnrpePdtDl1+Tm2XgOceX6xL/iZM3nEpvfIebDfyZ4CXdTE0Uh/+SlUDwLtKSvyU2yppFHz
	088vVuCC6x+wg7x6gg09aQOaB9q9OvP4BjxkvgaTg2r51WxDeqEvFsJmu1crI2reY8iUWFAfboF
	66YThkW5mU7e0nxGzy0=
X-Google-Smtp-Source: AGHT+IHxwhXBD7QtV57GPX18QEqwlJN0xLGrvpFbUNScduT1oj9dMI5+RAQghbnaMwCwSxyGWQpHcA==
X-Received: by 2002:a05:6102:f13:b0:4af:f275:e747 with SMTP id ada2fe7eead31-4b2478aea7amr2352016137.22.1733994838889;
        Thu, 12 Dec 2024 01:13:58 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c5569f71csm1557353241.7.2024.12.12.01.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 01:13:58 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-85bc5d0509bso96347241.1;
        Thu, 12 Dec 2024 01:13:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVg1jq58Z4uR+RvP9oYmFxFSe2DPQ25qUeZab0FKgdzJEGcEdRYPQn2YQGAgdlmcM0hx2P/M5Ly0zpYuls=@vger.kernel.org
X-Received: by 2002:a05:6102:419e:b0:4b1:3b91:a697 with SMTP id
 ada2fe7eead31-4b24780ccb2mr2758608137.15.1733994838008; Thu, 12 Dec 2024
 01:13:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212091100.3154773-1-geert+renesas@glider.be>
In-Reply-To: <20241212091100.3154773-1-geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Dec 2024 10:13:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXg5b21OmYfKfmgj433U+1dR5wriN8Q2cgFtq6S2wq_dg@mail.gmail.com>
Message-ID: <CAMuHMdXg5b21OmYfKfmgj433U+1dR5wriN8Q2cgFtq6S2wq_dg@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: avoid 64-bit division
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 10:11=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Dividing a 64-bit integer prevents building this for 32-bit targets:
>
> ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/rockchip/rockchipdrm.=
ko] undefined!
>
> As this function is not performance criticial, just Use the div_u64() hel=
per.
>
> Fixes: 128a9bf8ace2 ("drm/rockchip: Add basic RK3588 HDMI output support"=
)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Please ignore this patch. Something went wrong with my scripting.
Sorry for the inconvenience.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

