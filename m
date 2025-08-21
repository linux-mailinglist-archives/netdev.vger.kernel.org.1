Return-Path: <netdev+bounces-215529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFC2B2EFE8
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 09:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E14F1BA4EDE
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 07:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D012E8DFA;
	Thu, 21 Aug 2025 07:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdKK3OKn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED901FBCB2
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761955; cv=none; b=lRBZL70+z4jJjmI5ZTjzWIyYPuj/jfZ0G8TR8/Z/U0DfgKyMOiYabS4PvuqUPlcHmr/E9jVX9vCDe3gSOvcNVROMXIYqR358nKc2YtxDT3yGLDiPMJWMWUGlulo6PXzkTkWZpwbkqjQ2mc0/Y2idn8ah2fUEpGMmaXEnM+8aV7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761955; c=relaxed/simple;
	bh=OA7DP3It9Ng+MBmK/Gpt5GF63doN8zhZBIribwWGfYI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aVbSYKNQhikxD71xpAkSiIU1ev+wBD1KwWNRnAMFl0NJH4eiH42wGypcoEVSTP7taGcMtTCT0OSjPj4EHt+Vyv8DGhl26nW5wwMvaGalgLD3HGMnd11nO6nZ36UCH0om5ddDJSxTqqaeCsxvga4lcYwHnfy4dCCCisSuHj8LSbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdKK3OKn; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e8706c880eso72062785a.3
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 00:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755761953; x=1756366753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V60lkznD2K+KweuMdj8KssLWHfKvvfVUopJyR+zwWtc=;
        b=ZdKK3OKn1jab0G4OyR/B2e8TW1evEj1GmuVucS3ge4v2rxFa60sCQTH65awIG5rEb6
         wLFiPjzyZ/N3tXLzXPJQsF7yOsJwvFWSPJK64NUcevHd1HrzMl5/i9xTVpwJnrDqMrlK
         8CFs9k1ONvirhyuy/R54UH6FsOPuq3+N8nRvZBS9/QHJdIg/TGLzRztWQxvJEyf4kOaq
         2jUytUIYR1ynHBMqVZpUSyFvHgAn4LM11vgD8ET+dPwL9CjCZ6v8Jei5UEJG9tPa/F/A
         CmiVrxkF9XND31GAS08oqlMZTFnG+kxRX7UtHE18ZyITL0LURdz0z710ZaHJpkRxEaj3
         gH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755761953; x=1756366753;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V60lkznD2K+KweuMdj8KssLWHfKvvfVUopJyR+zwWtc=;
        b=qoGLZGrYsGV70DX8G1F3to+BFyrQXsR0Y8g7878GypfBuk9WWeUs5xTZc6LXSE0p41
         unu8socxPXDp6xZqqbG44UHDZAFz+wZvLEfEh/QCAl8C3i0iixKZaZOEVpRoC1hlZ9WW
         1xczdOVVh/Wg3ASL9ZhJ7uXAHdaDpQ+XfsZAePQFatjV33FaUJ0v2MS5ZumMdVam+6aM
         ty6EunZQUIOXs7nc4ERKogeUjhGI5AP1ynlTaiUBCtLzJ4HjH5evKAsP1GAo1Ru4K3Us
         wiqxy+8Yb0J8RFnqirI98u0jNSV/IhRIhR+oWZrZioH10HhqnC90Ywsrw8q6MdZxHSNY
         WDJQ==
X-Gm-Message-State: AOJu0Yz6YNnJLH6ewPJ9urDrvAucay59HbqG5c1LQqoaE1p9dYsSwe0D
	Z3rQEJN8g6lZRWeL5skXWfdqnd+wTojUCvQeIm0/LI/6tAZTWxDbKPQMr3DPpiq6+7ZKTZ7lsfJ
	3nM680wP46bMh6Gn8ZoWHJKKLemC4VPM=
X-Gm-Gg: ASbGncsu3GWEBgMCfB/OjAjSa8UOCnQ+4rAp8GiCH7vN1pvMdGj7dfeTAoJMyUf7M5t
	ZK8X0CAyG2YUV3EyYHOGbuotCu7e4A8aznlCSuQ6NfN3rU/I+/el732uP33qeeKPEQvDwwhg3aV
	PhlFHBhx5EQ3xB19tGwhew8RTyPCI4EhgUpTixHYm778bK9xKsaH8JAQnAwk+kFvJlqbQF7oFiR
	tojy7OW
X-Google-Smtp-Source: AGHT+IEJtsBbE9Fjt1KfNvG82cm58oHuRj7MnPdTIjIQ2j25d0ENFJ8fEbKfoN7PK5S+Yb+ro12WcNClt3I+NLzIVGg=
X-Received: by 2002:a05:620a:4146:b0:7e6:8751:96ae with SMTP id
 af79cd13be357-7ea08deb5a2mr153570485a.31.1755761952697; Thu, 21 Aug 2025
 00:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: jjm2473 <jjm2473@gmail.com>
Date: Thu, 21 Aug 2025 15:39:01 +0800
X-Gm-Features: Ac12FXyGtX0-AxAZ5wyZl8HCl36ySa12ZCvlIT_Z7whCT1czWj6-cjDCQsDEgSc
Message-ID: <CAP_9mL5U+Xs6T89vT7DGvcmzxMvm8qars4o+5EfzbdU=sqzCXQ@mail.gmail.com>
Subject: Maybe a simple bug on rtl8366rb-leds.c
To: linus.walleij@linaro.org, alsi@bang-olufsen.dk
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

rtl8366rb_led_group_port_mask always use RTL8366RB_LED_0_X_CTRL_MASK
whatever led_group it got:

```
static inline u32 rtl8366rb_led_group_port_mask(u8 led_group, u8 port)
{
    switch (led_group) {
    case 0:
        return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
    case 1:
        return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
    case 2:
        return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
    case 3:
        return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
    default:
        return 0;
    }
}

```

