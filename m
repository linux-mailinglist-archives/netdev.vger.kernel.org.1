Return-Path: <netdev+bounces-213041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F000DB22E6C
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 19:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA2C1A21BF0
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C8F2FA0E9;
	Tue, 12 Aug 2025 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LLGGXrE2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B222F8BE4
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017807; cv=none; b=Wjga/QR82mFLhm1DQucIU3u/wgqEbCo5DoexQEiXJ3W6Bv5+ckY3cEbx52cinO44VREaCqQimcuxyKDGIwU30li+NlgA4eP7Xp14XxUedUhcv1kgJCdVQxnZGLxm2po2DDobUqLE+7bCODJnyhdTnLsZ9ICrJkeE33bwJeC7rDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017807; c=relaxed/simple;
	bh=vrtEVYCZGAtmjgD47j/50MwVzOUCeaFElaKBka8omMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4vWTopvgt2z0tJUu85XIHrPSTn8rj6CTCfDiNlVpuqcCeaXKoMESyTuROYgrh0HJHNuM9luLPbvhVfdstcrOG6SCoL3sjDAwWe+KZj+Li8uWdlm+wCGLKwzdgbRaqM55+FIHNfoc69z3LpzQnl4B8MC1nhVX2Ey7Du9rl/JOuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LLGGXrE2; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55cc715d0easo334e87.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 09:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755017804; x=1755622604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrtEVYCZGAtmjgD47j/50MwVzOUCeaFElaKBka8omMc=;
        b=LLGGXrE2dmnFHuRrBVp2yNHoMP1Qs3xsLcyfAnglmaI3o14SVte2bmF6skD2cxhyNS
         gzwwbUMjz0Aj9LDULxZHXvBXsXz/xxfyjhoiSZcWTwkCv+SC92FDePYX5C7N+24wzci6
         IGTi0OKNbfPyxUL4zqBBGi39Kdx1mfH9f2LDTdkcRwXrHRZBc7PFEQX4UKQnHYrhegbi
         r1WWowsYOTtBMx5iV4YgwgIwGfxHiOolN54MfkgY0VaY1gaL8a5Yyq/KnGBOyrah8OAH
         zIDx8VcnrVHFGcHYLBmSijbIsv5I0ZRJoPirmkma4b6cSLj7GDnoEspcJqOa1t7perwf
         TPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755017804; x=1755622604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrtEVYCZGAtmjgD47j/50MwVzOUCeaFElaKBka8omMc=;
        b=Ok1WIp6WSyo54dyv6cpyVfE/mnTDEu+xKIoBFYhblPEAyoE06NMkpi/lvvA8bfnUEY
         nXypfcgLdLtQPvWo/bKKRj053CddxxrSyrk7UeQZQHLlGEHvRRePilEB8PTn3vOgthEs
         xg/k7Qyh34snbzwMORE+0/YsglZc+jv6M+hb93o5q9Je/vXWvkznTfzqx8iVcoLU57RF
         QT5sAYoFGRgFVqVgLxt0dST0dX/y+9w5HpsH3tKff2lazeYS+wgrdLeZHqQ5k+VfreNr
         eQZdQy/ko1IASZqmMObStwdTQ5qMFptymNoyLN3Z2Bb44oKXOpjlECQyAfWDXlUUQ1DW
         gPbw==
X-Forwarded-Encrypted: i=1; AJvYcCV0xBe07ZSawLUMP7NusQXOPKSN0JJ/qO8BY9W5IdhAf4pLNYJrGvpf/PgLYJlG+Ydjrcd8TdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRBISfi3waEkt8j80cRhK1YFbpk8Y6GO5TnjXkPWCA9rOCW9hX
	loL5h7J5CQqtVU8nqjoN+1ah3msfjLXdBf4LX6+z2rGuCX+v6KeKX80ZHcOoXcmuDk4mGz9iamp
	ri2tGBhPlGe2FUaoK2DK24R0+Z1aglA8HMPq9ONfY7mSk4YAoHTULDK5C
X-Gm-Gg: ASbGnct8epR1iVSfBLEXAbM7V8GDBao3iizu5o+mDA/4GJAYh/u6ObbKTfXrqeTqrJH
	fvDar8ILKinGojfqUz0CQ68jxqhE/zOJMhvVWVl25KheMACoCQ8Fg7CP9lwUjLEV4Y5dmlC5tq/
	QZFgIzq9V+/eDkkzxZL3Zmvvr7t7o1lqYnIM9wEgr1L4TxYPVZmFQHXlrkDV3mHeCR2VTpT6SXu
	ZsK3ev23e2qxuW1eiaOI0yQ1ktzF2ldhaQJJQ==
X-Google-Smtp-Source: AGHT+IGj+MwSBW0GzCwXET59eHZbSfHtBy1ydi+MWfWetQEamtgZZW3pt2fbjVYXAeK1EjsRNf8pd42QYOtscw2aA2k=
X-Received: by 2002:ac2:4f16:0:b0:55b:5e26:ed7b with SMTP id
 2adb3069b0e04-55cd92926c4mr444025e87.0.1755017804016; Tue, 12 Aug 2025
 09:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811231334.561137-1-kuba@kernel.org> <20250811231334.561137-2-kuba@kernel.org>
In-Reply-To: <20250811231334.561137-2-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Aug 2025 09:56:32 -0700
X-Gm-Features: Ac12FXzolmObLNOQUK7kzAVoLhGNGPgjYQpI2KT_HDG4CcgWFHzfkWXvkHfrYiY
Message-ID: <CAHS8izPcZzyxxVtszv26JOJBOaZhBt-VN0ut8VT=4o8xogDPjQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] selftests: drv-net: add configs for zerocopy Rx
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	sdf@fomichev.me, noren@nvidia.com, linux-kselftest@vger.kernel.org, 
	ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 4:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Looks like neither IO_URING nor UDMABUF are enabled even tho
> iou-zcrx.py and devmem.py (respectively) need those.
> IO_URING gets enabled by default but UDMABUF is missing.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

At first glance I thought CONFIG_NET_DEVMEM=3Dy could also be added, but
that is def_bool y, so it's very unnecessary to add it.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

