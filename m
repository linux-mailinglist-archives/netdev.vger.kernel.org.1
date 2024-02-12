Return-Path: <netdev+bounces-71097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1618521C2
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 23:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA501F22EDA
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 22:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90BE4E1D2;
	Mon, 12 Feb 2024 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZOzWMZ22"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313794E1B5
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778216; cv=none; b=Y34xAYUUSy0FuzrPuUHL+xlt4W8+9c3q2KqPMLVQg5mEEDO8fYBhx6rst2csufVpadDDDX8PMqvOZj+YCYDRmcYyLj4aajAUpw7ylZns9m2NmX9yddsBuJoyLpf1IbEUO9u+YShNvhjmFWY60PFTKtB+t3PpBbP9ZHUtDF5kdps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778216; c=relaxed/simple;
	bh=qD8UKLBdZY2kK0F8HUsRnxW+15Z0FwvLOlUar5mXRSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OavV80byx5Zh8siLL1leWHoRWjnkHRXKVzp9UwADAIK5S8Ualhy6SXNeHzIO+38HvZ3LCVH/7zujvwshBf7Jofwo+XEHVgBfzsuwTwce5IrewG0Y4rK0S2RvsnWOCjbmtrNKn2p2C8gUqdt0NCiunFJNAqZkGe5CoNMQDPQYX4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZOzWMZ22; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso3827075276.3
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 14:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707778214; x=1708383014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qD8UKLBdZY2kK0F8HUsRnxW+15Z0FwvLOlUar5mXRSo=;
        b=ZOzWMZ224jishYKS0prK36mcZ+2pecA70S/XipHt2/d84xF79wlTXwY9wIJRyBQbbA
         FJPYFjFKEaOdmV0qinyO2eMCifd7bO1fhM1Rt1dUZZEoZO5KxEeIViX+tRxFCNrz8wev
         71WNSRWmKRSF9tix7eod0AouRxRf5A4CewjrS6cASro+EqmIIIbitF3CsSyR7iCmnksS
         mZGK+TvGx3KtJBrLKZp7x/5z5SiqfbxskRL+ZxvGWT8uaXiv/vNU5zO7OxStKQV02i6+
         vGLnAf8gpGHhbW3dabQLW/61XILr86w+NzOlwQ3R9HG6OD0vGhXdTb1JccKu2Kz3mFbY
         7hsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707778214; x=1708383014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qD8UKLBdZY2kK0F8HUsRnxW+15Z0FwvLOlUar5mXRSo=;
        b=GFIalue1Vx5Cx7uWf7izVEU4RAoTND4U6VYcAfF5pHqb5t12SgFUvDwjqczcaQFsMV
         W7B0Yij0qoy3F7MNR0wpKd3vRPwnAu/TBgjgzbCCuRNSSvPXhtVPk+MQEUknIRHq7gSG
         U8njUUGzoN5uNIAStIqLBk1OmLN9s/1cobE5+AOdywycs7SjQOHuqk1R97hcBjAI1bEB
         NAUFCQ9jzla0Z5bOsS8xTCyX8AUwdQUlrkauhagH3zxGiM8yvQgTHBwuS8AKjuFJQP8L
         B5GxmZbk3Y//mpXpuolLc9rJw7E/zUtLMgmDlXEJBEJyGu1LFOVzZ9x/0oAosVGglI4/
         Kb5A==
X-Forwarded-Encrypted: i=1; AJvYcCXcO+tw2L5x+2SBJ7r/+b9E53/8IqI0PraI3UjuZ2VGNdq+9qJzPTVa9o7QqOwm3hVYIoI6OW2NkEpdb9PPG0Xy1c9M3hB8
X-Gm-Message-State: AOJu0Yw32nhiiKyrwOKzNTvo/xqSIIkWJ9w/cQwc0yVNqS3wUtgEKW6L
	aMwmmBJsLQrX646vyV0vO2dEd90wKuvKOUvDvrrIrk3bY8U9y7QJD47PY0VjDpOHJisEwDCQF7c
	A8MkWOD/CQpzTM1+YYt+wyrj5N2hUCOMeAzelCA==
X-Google-Smtp-Source: AGHT+IEdOLxPuhsAdrfItDyVRXigbzOFJkr6GtqwjG5kU8LZoYijo+TvjkKpY/ldTPbLMloC6vQ21/brrZj250gV9S4=
X-Received: by 2002:a25:2688:0:b0:dcc:275e:7323 with SMTP id
 m130-20020a252688000000b00dcc275e7323mr1013341ybm.18.1707778214130; Mon, 12
 Feb 2024 14:50:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-realtek-fix_ext0-v1-1-f3d2536d191a@gmail.com>
In-Reply-To: <20240212-realtek-fix_ext0-v1-1-f3d2536d191a@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 12 Feb 2024 23:50:02 +0100
Message-ID: <CACRpkdakahhg9AZRfGeM_FNwjgyXBAKuEEqsYOxqerR=OFpLbA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: realtek: fix digital interface select
 macro for EXT0
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 10:34=E2=80=AFPM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> While no supported devices currently utilize EXT0, the register reserves
> the bits for an EXT0. EXT0 is utilized by devices from the generation
> prior to rtl8365mb, such as those supported by the driver library
> rtl8367b.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

