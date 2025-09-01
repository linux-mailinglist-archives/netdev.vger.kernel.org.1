Return-Path: <netdev+bounces-218650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE238B3DC46
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CAD3173EB1
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F8E2F0C7F;
	Mon,  1 Sep 2025 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dz8uyAzg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2304E26AA93
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714998; cv=none; b=jkleFBz3ByKAjELKROZXGIx8PpymxCEY6MipkC7C7Q09wvx0QmlxSoK9gale4nd6iiCbYQ+a40aGVaHmbJKz+pVLwmeSjn/srtmQ7tRCD4+kbqJEKOIVn2isYNM2mtC52+JfNnYKQltD4Arj3kCycSjKhP3OjeDwB4mPkJN4u24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714998; c=relaxed/simple;
	bh=1GRc8xrxN9zGX5wz5BhvKOO2j5zrzx4fFnKG/lVnDdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9cXV5aDyP8cPCP1/aTi4S8m8fr9TTVNscm+cJ8Vt6vtycRO970mK6CwWigTybYS05JctOKqoW7MR1uE5LJuP77OmF99ml/g5YoemsKMGA7DK/StfBPw0WddVzrudKHZds22vuTszHUJ8UWdDfezXEua8PyNXQ7Kf7C0T/GhMxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dz8uyAzg; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f7204b6aaso1383064e87.2
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 01:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756714995; x=1757319795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6bOX31TOnXa3mSpUgWZIksoOSQJIo6oigebcMiGpVk=;
        b=Dz8uyAzgarZvRBDqWWnP+o0U86ka5hRrkwgV0NlTvB1H4KaavPr9OXtifRWGyBpZhd
         4RTS1Ii3q9rZPzEXv7pjrIuX0WiyIwNmB0j8UYGYKgzC0kYLccqV3fHDCbNXMZDtQjmo
         gQiwpG28ZWd1RO5BUKErdyIHmeplvRsTKAfX4KMeT2vNdi35UdCczvAp47o6gXIuRrEW
         4hAH1yjoEa5fO48bu4rAIl6QTIJptC9r251HxtiEPzW5fHQXTJ+LPtnTCykdnAqZLHG/
         cu9lewA9vJ5uQ6U/VqsrNIjybREuo4VgvovYZorEknE1YhCNECxrNloex32z6/yU791v
         /f6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756714995; x=1757319795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6bOX31TOnXa3mSpUgWZIksoOSQJIo6oigebcMiGpVk=;
        b=Phs9TpA97zaKaWAVL/L1f1nm5fttA9MdbQv6W5NNnisGrS/KfvuYPhGMsZiyW0wj84
         EtzcRjYo4JHNdO7w2zS1JjFO3hKQ7EqJQFe/KmYlyYYfkidXL8AMklRt4SrwVdbmplga
         63bYJydB6zKVqxjbjyQG4kMcMNUYNo6BGLmE68whhD+pP5RlaUho7OTnXfqzCmrcEpfz
         7lxw9FVzMDP8+Q2QKGPtazxOFVwKtEygauOu5BJswT2ie0XeNff7Ws/MTPLRKypGR0BY
         K+MpGtD0+KTXikOllLmROqanGGl3aJh+rpfvZJKijU67LjZ5AaIO3XxEWdycNzD1gocm
         0E+w==
X-Forwarded-Encrypted: i=1; AJvYcCVd2/0zkp8valyO7DRQjHzAtbb1LO/lQNbRyQnLOqTfQfXeF+z6ICzykf6u4cBl5P9LKVTg4NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrxbCTfXIevmG1WMqtp1p2Zi2SNCvp7Zoc+jm3JPosyxQsCH2r
	QSAXyE8DMPv2xf4lTM7Z9Q52c9LgvTZzoScD7gKRD1K5Y766mghK1mXl6MFHgUQJgj88u5FfgzR
	ugao+UMQM7BE5WGYdiCENYGlULeUZkDEIC0zq+8loag==
X-Gm-Gg: ASbGncto0JPFiVIerhU49gtYYkVMNEy70ly+c8Cbx9DJcZfd0mxC4w6ZYsPP61guVru
	knI/gXApkC/2pALt5q8/GZAnLF1QlGu8JJfiwFULejjV2NrW+NDdsXS4fewky4SZVVp9J+fey/r
	P8vsjaqlSH2PdVUh95520hGoPTvyQsx167MkCd/7/0WhywjaPv6GvuYbubd4VTlXxYPuZ70bKza
	CAAMtyDNprH9GohbQ==
X-Google-Smtp-Source: AGHT+IHVwIASRqXdiBtabwQpeTaLvx/MwfpuhWhcvrvqvY8VLXWEY8BeiyfCJbCTfLb/GJ7BJFbdc5bUK1izSWZcw90=
X-Received: by 2002:ac2:4c47:0:b0:55f:6186:c161 with SMTP id
 2adb3069b0e04-55f70a0081cmr1669470e87.49.1756714995167; Mon, 01 Sep 2025
 01:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901073224.2273103-1-linmq006@gmail.com>
In-Reply-To: <20250901073224.2273103-1-linmq006@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 1 Sep 2025 10:23:04 +0200
X-Gm-Features: Ac12FXwOPFvcHfnOB3USWBMbhSfcVlBY0l39KH-IS_467sKxEs3coXt0xb6oRRE
Message-ID: <CACRpkdYVCU3Pb2u3r_G0BY19mbF8m1je696RNP_49rU7G4PvUw@mail.gmail.com>
Subject: Re: [PATCH v2] net: dsa: mv88e6xxx: Fix fwnode reference leaks in mv88e6xxx_port_setup_leds
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 9:32=E2=80=AFAM Miaoqian Lin <linmq006@gmail.com> wr=
ote:

> Fix multiple fwnode reference leaks:
>
> 1. The function calls fwnode_get_named_child_node() to get the "leds" nod=
e,
>    but never calls fwnode_handle_put(leds) to release this reference.
>
> 2. Within the fwnode_for_each_child_node() loop, the early return
>    paths that don't properly release the "led" fwnode reference.
>
> This fix follows the same pattern as commit d029edefed39
> ("net dsa: qca8k: fix usages of device_get_named_child_node()")
>
> Fixes: 94a2a84f5e9e ("net: dsa: mv88e6xxx: Support LED control")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - use goto for cleanup in error paths
> - v1: https://lore.kernel.org/all/20250830085508.2107507-1-linmq006@gmail=
.com/

When I coded it I honestly believed fwnode_get_named_child_node()
also released the children after use but apparently not, my bad :(

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

