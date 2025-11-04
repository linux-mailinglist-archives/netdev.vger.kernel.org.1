Return-Path: <netdev+bounces-235569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0E9C3272B
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE612189DD22
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F4133B947;
	Tue,  4 Nov 2025 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rvAE5AS5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B5F335566
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278778; cv=none; b=KLNzcCEL+xuQNYQvYMFoG+QAg9QqPD2Js8KnuffMsXO7rOL0DNOYpM4ZJglkZagGdu9fz84C8mrPSUsTTnCeaR5V+JhfEAVK1rxPWJtKgaKD1EoNTwxtFkyN6r+6BjnHPDzbgNM7/TFUTbio8j4fsn/l/gXCruBcQI4ekSzERhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278778; c=relaxed/simple;
	bh=zrLtNYBFPvl3oqYx4qnk4MBNpL7BlVhNzb4pjwo/oAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgBljDgUYVrOMjV6Y9XaAl2FKpCEu32BHg2a+xElQ18FqGVyt/97BLdzUdgHxbpOGKIvwmCH1pxylxg/67Pa1vHr0dwMOlbSMqr+ExUSJzWAE/pF+KMOoCj3Rrr8KuGdymjszLtoUmiV8jiB1w6ewzGVzmSJajiNMYxuOkgbouI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rvAE5AS5; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88025eb208bso50718006d6.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 09:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762278776; x=1762883576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrLtNYBFPvl3oqYx4qnk4MBNpL7BlVhNzb4pjwo/oAE=;
        b=rvAE5AS58X+LokdbsgVgDA7CkWs9O89/Y7nkRphrd7WtP9iZwsFfM/kNzZRckIQ3Bq
         buOUSo8jcTceQleNv+T9tQ4xJDLEuuHakxinj/7JJyerNNNw+dMI3TSHZfpQfN0ZACSy
         HaRyAaVx56zSyubBeNrSDRoaK2g06oEVFyvp+sL7Y4fxAeHSNdL1h3aPEfTGbvVwybA6
         6NIV+5P4xoMorIgmu3H/YBxhC3sontgig2YDWUwlHTUjmauPqW3wDh6u/jTshhbTbAVH
         7Be7lEP53vZ7tW4hGBI/UwZqo0VaJOOfYB3W2xeY5SCjN12FHkYB9etkPuf4fz9ieE3f
         nBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278776; x=1762883576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrLtNYBFPvl3oqYx4qnk4MBNpL7BlVhNzb4pjwo/oAE=;
        b=axEEL8R+s9xK+sSxJVzkEjH+FsbowFWM+1SXYPNjsTVlUVWiCha46Dd1dZm4ixF8mJ
         +MdvYa2RV8Mastvadk06RGyLht86IQRyeFZvJEEqJgNKb9gjljuJgtHSGZqnb5pwJZyh
         Y2K1voVEhD1/gKl7hQWyuqMS+/P5lJuRyuww0Wa8atZn8+bFHlCZi5AxMSNvfmpvEUET
         VvmBW/Pucs0QW9aRpFQmdy6xt4y8Ic0xhHr3LpUJ9OQwhpwwblxye42UzWlNoxVczZjb
         XPfZpnXtAhkN9PhfyBOsc6+DIKOr4xTSGizD5p6Z7ctqK6xq/Daaea4UMMcS5IL8W7tW
         31HQ==
X-Gm-Message-State: AOJu0YxAXi4V4tMIegpmpEhziBpHYzzpeVr74sEqVKXtNKWulUcHKMJ4
	2Ygd7FoTSwthyIRjpYh3kfwRtO0vG1oQD448mAvTshu/kv6La1lTB3vMiHRdBQvr+Oirhx7Dtoz
	7A2jEGNdaWYRDfNcwEDGPzFHuMNQnUj8ZJfgE4cQ2
X-Gm-Gg: ASbGnctFIceYucGkx/cQA9RPfkOCflkgVwEuV6KiguWqxS2YZoifjTHRT+WiX4gSbQv
	N8eCDEecWYASrzC50praUK1ECeRsBH5rLk1mDTqdcg2uSC6x9ueUEERDzWsYfthPWRMNGQ2I0K3
	N2vE0QKlGeUg6CdHZyfWAQxCjQhGVoTgDSFCemPaIa8bVrOtEa6pqiu3TBXPnwzqhXccdx4exM9
	37h796uMz2wYAUzlpQuLym0dOs93XtW7yu2u+2IdTirlX9jwSePJt1wHXuUrEUWZVz/OiLrl44s
	Dcgiuv8+/InhrNv1WgkEmR0zmbk=
X-Google-Smtp-Source: AGHT+IEhiPXGoAr1rMM+md5M33x4TqHLmrfar8PhIsAzJAsgMtJupgAN8jFZ83Z/b2BNHrzNotDea4BWOkC2Z2IZvho=
X-Received: by 2002:a05:6214:f27:b0:880:54eb:f65f with SMTP id
 6a1803df08f44-8807119171fmr8078866d6.53.1762278775938; Tue, 04 Nov 2025
 09:52:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104144824.19648-1-equinox@diac24.net> <20251104144824.19648-4-equinox@diac24.net>
In-Reply-To: <20251104144824.19648-4-equinox@diac24.net>
From: Lorenzo Colitti <lorenzo@google.com>
Date: Tue, 4 Nov 2025 12:52:44 -0500
X-Gm-Features: AWmQ_bkW9jpoR_Scm0q2p-Vaht9Im4eBYNfGqffp_PRvtUgjtetEjqq8wO2X_ms
Message-ID: <CAKD1Yr1unmTz4NOU8DDyuy8g4bwiB5GsW8bQgjJX0jWbbDUM7w@mail.gmail.com>
Subject: Re: [RESEND PATCH net-next v2 3/4] net/ipv6: use ipv6_fl_get_saddr in output
To: David Lamparter <equinox@diac24.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Patrick Rohr <prohr@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 9:48=E2=80=AFAM David Lamparter <equinox@diac24.net>=
 wrote:
> Flatten ip6_route_get_saddr() into ip6_dst_lookup_tail (which really
> just means handling fib6_prefsrc), and then replace ipv6_dev_get_saddr
> with ipv6_fl_get_saddr to pass down the flow information.

Reviewed-By: Lorenzo Colitti <lorenzo@google.com>

