Return-Path: <netdev+bounces-248079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C56F6D03017
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 14:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 768A7302EF22
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 13:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF5D4ADDBF;
	Thu,  8 Jan 2026 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn04lUtm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF5E4B2DE7
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767877958; cv=none; b=WZfSE2Bxt91+meNtO5DneY2ecL0nngbFEn1Jt+1DoLlbb6iIql7yJi02RZrClpNklXloZ4ay1r/ygsSZSnP/uK0QZhLPwCYKqT2TSwKlqYg2T8SkJ0cujRwshWGl/CO6iqPxeinhLk3eILU14aYDrE2ZfjDQI8R3NJxKVnUxEmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767877958; c=relaxed/simple;
	bh=ntcSTOGdH0CKjeTZNLnC8v8dbPtkb/IHzwCftDO6npA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=UnI6KlEB5Y67Kux/oT8fDS3U9hMJ/y/OBWNIxuT/4voPCXTVieOpHZbs2vKqLBVOPKoDiyRG9bOSGIL2KlKabuSrj+cxyBDGU+DYVH8OSiDO3C/6RVpYPbLrSAGuYwbgK+jv5G6eMaqofv9Ve0AIHZ+mkF+haXUsSgy5MTvVkcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dn04lUtm; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43260a5a096so2208427f8f.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 05:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767877955; x=1768482755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ntcSTOGdH0CKjeTZNLnC8v8dbPtkb/IHzwCftDO6npA=;
        b=Dn04lUtmjxRnw732foM/u7Pcx0nfs93aaXSqvQRiMlOLkOV7bn99NEx2H8Sx76C5BA
         3We8ibiB5zeA0D8d9dJKzuu4Uw1+9eyvl/QBJ+ivBPgW6sZxl4+Rp4PUYiEaCn84yWJZ
         oZ7TCKk7sWhuEzF8goUxQoY+yN6H+OE2dGFIySEbrIssMCUvO6dUUP4DgPHuyB7IumCe
         PdqXVRazRY5nPrb5qNdFt4IoRMDF2x7H+P+DibjNumrdj65XrHylus2gSroxt0MP1Sn/
         7uIDXKrpccFlmnhg3JnTrk140KyecTkqFSS8nMBbiapPUpQSnqlRRc6JfrtICQ23NGaP
         lDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767877955; x=1768482755;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntcSTOGdH0CKjeTZNLnC8v8dbPtkb/IHzwCftDO6npA=;
        b=N9eoWdgZIZmTKp7QEPWPajsBPzNWao/xJO33RiqI+dG3B05jYsaWE2rgjdamsm9JYr
         luNaX2KPzl7evVSCdjDhN/EyfvlWbaGgbgXy4tqSyP//tQ6w7KWHh9Vlho2Gb45gKPWM
         bDj45h2RU7E5pAVdlesBHdNtsF8GmuhcvjvIxLR1N4YY3F5gyKpFpQP9xEg1TEF6hQhe
         s/fH5Ty6BzSg4mIB9U9fYGW5G2Kjs/W1FrK4y/XZwyeyOs9XGr+4QEeBs2Gaq5RGqugv
         KD5k+cfENIsU91sQiGT9C+wMnN/jPqLOJ8RCJ4u+cliDJAkokiS8qPfBHrEwGUawGiXI
         Ch3g==
X-Forwarded-Encrypted: i=1; AJvYcCXjCP+FfONWWcvCPEt6ECG0jkgt9PiNb12Msu5qhGK0ZvSWKxOa6ObYt8xbMlDxFSvWpqqTNgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxglfEVTCyPo6mkOSOqgy0hsxtzHZH0SjzGClQTy85Zp3AVAZtT
	Vdh6jKwsSb5VfoOcY7Sd4iIMRN3kLAgAnlnO7vaQp+M+1mm8A1qhBpUg
X-Gm-Gg: AY/fxX5zn8ih1gQOgvBSblzVPKIe7Z/qlpr7SR6EWi41SlqxoTNMfyJ8QXAmA63MyjJ
	T69Q4sON+GiF67gBUZVQIrNG0Z2o5BfyMz0T6Gb8vr9+F9zBJvu97kL/JlAchqVT8aYAvgdgqlf
	N/1c8Hq+Gh5SivwN2SpUmCZ8NvNwbroOoOit2t3L9C1IQEPqvvWStOvKvDfyEK33omYof0IMjNx
	EGziaKWsFAVRvCNfHJEj1PH8kt4wk1QBrZGx/2aRlK9qmomsIfSME5j8gfRyJqyuTIF/Iqy8czC
	Wepa/uJ3GeWdtxNoHwUFH8zJU/8rHGuuvuE3MLkrTSuJEEP6BV1DaXFGPvy/MvXVrosw3uQ+6gT
	AkTt1nhZ3XA8RGe3Qf5dmxichxV6cGr1TqKc+8sPMJG172Hv86j91NG4Yw0LNzLz5W4RxOj6c6H
	MdCC672e/k9mMm22qZmBmvjB6ysq+sJdgC9Q==
X-Google-Smtp-Source: AGHT+IHJNndQhZwnGqgQG0c42iHvCrFP+LdbnfPpq29bFyRYl+i21rvWLnajXl63MsRsEx5c6KXbYg==
X-Received: by 2002:a05:6000:2881:b0:430:fdfc:7ddf with SMTP id ffacd0b85a97d-432c37d2db0mr7902239f8f.42.1767877954882;
        Thu, 08 Jan 2026 05:12:34 -0800 (PST)
Received: from ehlo.thunderbird.net ([80.244.29.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e175csm16273042f8f.14.2026.01.08.05.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 05:12:34 -0800 (PST)
Date: Thu, 08 Jan 2026 15:12:31 +0200
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Slark Xiao <slark_xiao@163.com>
CC: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Daniele Palmas <dnlplm@gmail.com>
Subject: Re:[RFC PATCH 0/1] prevent premature device unregister via
User-Agent: K-9 Mail for Android
In-Reply-To: <a4d09fa.9614.19b9d445a3c.Coremail.slark_xiao@163.com>
References: <63fddbfb.60e7.19b975c40ea.Coremail.slark_xiao@163.com> <20260108020518.27086-1-ryazanov.s.a@gmail.com> <a4d09fa.9614.19b9d445a3c.Coremail.slark_xiao@163.com>
Message-ID: <A8D63D10-7BE1-4EA9-8020-03D69A81C750@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 8, 2026 1:01:01 PM, Slark Xiao <slark_xiao@163=2Ecom> wrote:
>
>
>At 2026-01-08 10:05:17, "Sergey Ryazanov" <ryazanov=2Es=2Ea@gmail=2Ecom> =
wrote:
>>Initially I was unable to hit or reproduce the issue with hwsim since it
>>unregister the WWAN device ops as a last step effectively holding the
>>WWAN device when all the regular WWAN ports are already removed=2E Thank=
s
>>to the detiled report of Daniele and the fix proposed by Loic, it became
>>obvious what a releasing sequence leads to the crash=2E
>>
>>With WWAN device ops unregistration done first in hwsim, I was able to
>>easily reproduce the WWAN device premature unregister, and develop
>>another fix avoiding a dummy port allocation and relying on a reference
>>counting=2E See details in the RFC patch=2E
>>
>>Loic, what do you think about this way of the users tracking?
>>
>>Slark, if you would like to go with the proposed patch, just remove the
>>patch #7 from the series and insert the proposed patch between between
>>#1 and #2=2E Of if you prefer, I can reassemble the whole series and sen=
d
>>it as RFC v5=2E
>>
>
>Please help reassemble them and send it as RFC v5=2E

Will do it tonight=2E

--
Sergey
Hi Slark,

