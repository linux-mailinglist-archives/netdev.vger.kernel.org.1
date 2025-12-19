Return-Path: <netdev+bounces-245452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C9FCCE172
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 01:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BAD37300645B
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 00:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CD21A76BB;
	Fri, 19 Dec 2025 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZ5uCJvH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCA31A4F3C
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766105403; cv=none; b=rIFPEBb0Lq1GScLd7mZ4QJTeYwyf9Tuov/J6iOXHrWZCBvx+y/MA/ZzPp9M1djBzwD3ZUNyzAGYUHDzZ3QYBC1DLYgmtaxSEGhrHiK8Z+N/UxxSX4J0IFbV3gjebQRsqaAWRq1+02im2buJLud2Wodk1mFbvrgBH/9k5NqdZxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766105403; c=relaxed/simple;
	bh=oC84iq763iASMjCrObh9c2BxQ2m1CeFtY7gf/SdnUs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=WtgEgq2ZmVmlAoDtJMhLsGLYrPlij+JV8Xr7i2JmhSEwTEHZ1msCTsm/bvssPWf/8C8GfxYpnPJMJn75WArsSxEG81o6cqXg4fOF5Q6xUXu+FpAoCUSAt0/9dT8U4RKk13oR4rUGzhThJmoNtcxcKeySj1Al11yWE0CglcKWos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZ5uCJvH; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-88888d80590so16117466d6.3
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 16:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766105401; x=1766710201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oC84iq763iASMjCrObh9c2BxQ2m1CeFtY7gf/SdnUs0=;
        b=aZ5uCJvHq/xD578PTYfPFp/xa7evH+GYZ9Cjk9Scx5YWK9xZZw+C02Nv/f6I7dac+A
         I9cEQLRJQwGIVOyhcnEMJhT3OmoULrbi5n94BUrI84GVRLQVKBrK26O5bU7T8BgHexvy
         6meVwa8BWnwuhOW0fHm2t3jCx4pTMcQ/x6+jzirG7HsAAValQtyV4Ry33IFOjqIyFzPV
         tL59jEJ8956VJN0JsrD+Z2Gmb0itb+QM2RbuubDEQx/J0rkfY51BSaZpA6FINeCbXsSI
         LBkzoTlGktTzEwmFO2cJ3wVFWKQVlVCuOpAUGxKqjHt1llhasrvMC+uvFsEtT2Pe9Yld
         MqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766105401; x=1766710201;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oC84iq763iASMjCrObh9c2BxQ2m1CeFtY7gf/SdnUs0=;
        b=KFxmyNvoWkZSe3cJhoP1wZ0tAjF8ifrsJJJaDuKq6RUO1STyLtvaMSU5xLwuCTKIiT
         Qo143WpdUX4gwOIql7qqgC3bTb8J1rNywHr2haIKopdidRYy8RgWGDTD+Dd3xj9dOMgE
         DEce8Q9ufnjKhkp63zSvZit4PyKx71JAwjIKXz0keQjJNKtgmg8v9zln3pSH3pQ5dxkC
         NgIDUUqQk2i+mUglhDawq/OpKN4EY+akPZLn8s5DK3CxMhofZ8Mzo3WV2Gurd+sp5980
         UASnm7yv8ATML4J6K1wsi3k5QK689NOeTTX/NG5fDFVf2VuZmkeLLb6wsMNiI+yNsAWZ
         IjtA==
X-Gm-Message-State: AOJu0Yx3MarzqTJsd0HkuyuWgl17EbsvMjk2ZTfVbXSwLi45l5eZLFs4
	dhmF2S2XqFr47m3js8djZ7gcxy98cdn7EVT75uNntPUKibFuVp6IW6GCdQEkcLuhOSUWfHqzzsp
	9OREFDx/PKE6LdT+KCCg0qaLH77m/LTDqtvIB5FwkpA==
X-Gm-Gg: AY/fxX4rOOeSHRBM93DQRJKr62kFMevBBKGhtHdIUUIkyAjf2D0kGtK5O6IbRoEQLdB
	Qgb7cRehDTDxVkvjW9tmKvjUaliEFOSMBP56G/r4JeJAxUIF/t4DjdovdCZJ7CJ4b471W/1FPKp
	BuuZA4eZhEHCtuCeUUJQpz+pI559NHsEHWFL13gN+DiatfAJabPdBAb1k7q9GNUjP+mlnCB18ec
	zgRdxACwOkprD6S9MvDcbYtOFWFtM8aUc8fsMTKQSeXbkOI/S7mlS0LprF+xD3iR51L7ev/IPfH
	0RBLpC+j/AiMWqET+BW7e0PLo+yiUqlLu/tWv54lLIG1KNpsQVu2mXTg7rAzacWLjA==
X-Google-Smtp-Source: AGHT+IExaglDZDG8B3getYeAcFfGFgeMN/+uk81/wHXy0DVDVzDT4p7VbTOA1X4uNH0dDVq4bs01jJ9jWi8sCacwZwk=
X-Received: by 2002:a05:6214:1803:b0:88a:449e:81a0 with SMTP id
 6a1803df08f44-88d851fc364mr19969626d6.3.1766105401080; Thu, 18 Dec 2025
 16:50:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADkSEUgY=eQz+0VWzAZwH6r6THHEgJaO1-SYemANZGaKEaWkOA@mail.gmail.com>
 <ebb762b3-d69d-446f-a94f-fa27e66ddfbb@lunn.ch>
In-Reply-To: <ebb762b3-d69d-446f-a94f-fa27e66ddfbb@lunn.ch>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Thu, 18 Dec 2025 16:49:50 -0800
X-Gm-Features: AQt7F2ppeu_ki9ACqz357rYNRe4ulTQh1KmDqLrB23b2Tp-3JACUon-Nj5eC230
Message-ID: <CADkSEUh06rmVWYzswCWrX=E+c_3jSzW8qJkmv67UmF1s5h3Aog@mail.gmail.com>
Subject: Re: Merging uli526x and dmfe drivers
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Andrew,

These two drivers are not for actual DEC hardware. They are in the
tulip folder because they are for hardware whose design was heavily
inspired by the DEC Tulip. uli526x was part of chipsets used on
motherboards new enough to support 64-bit AMD Socket AM3 CPUs, and
dmfe was at least used on PCI cards (I'll have to check where else).

On Thu, Dec 18, 2025 at 2:24=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
> When did you last see a DEC machine? Probably in a museum? There is no
> point working on such old drivers unless you happen to maintain the
> museum and like to keep a modem kernel running on these old machines.

