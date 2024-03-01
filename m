Return-Path: <netdev+bounces-76760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBBB86ECF8
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 00:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11DF1F234A8
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 23:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEB71DDFF;
	Fri,  1 Mar 2024 23:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VTm+zJzX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479C83C48C
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 23:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709336361; cv=none; b=AdAWHjmCiiAxCQ2EP3i3zggq9P9X8CICCbSsudZo+TbXneD3q9w8M6lLHHANLEdJWFt/f2tumtZX8ezPJUnWizCcztdQce5zgxxPIT7PnN+FUYDmuacPObvKF9m4B32Stt1aixy9pbLpucCN5oRNA2ZEeSsNN+t3VliqisMA8kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709336361; c=relaxed/simple;
	bh=F5BGi56UFoN3qVYxdYvohQcplCXdZ2ZAGQX5Knd7kmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9Xg4Db5Rn54z+75DhybdAm/d+voKkSbItv5IAMs1dh6o5i21NZpVNQUAtmkvJ8Kehst1jajsbxbYBFFMW3Ymx/IgiBTp5cXCWC1Rzsd1HDHPNLutXvB3Hh5mON8sSRMbghbDytalQgfWPeSsAjpKw/fIixGK4rmwv4hyX0CUGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VTm+zJzX; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-608342633b8so27545097b3.1
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 15:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709336359; x=1709941159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5BGi56UFoN3qVYxdYvohQcplCXdZ2ZAGQX5Knd7kmo=;
        b=VTm+zJzXqQkYQOiBLSFiu+/Uvf1NN5hR8Czl7HYRHyKqTewI4qhTvf20XI57x6y5p9
         YVlPhjP4ktAyoU9ZcREOIsSxL8zyxkqJ9w02uz8FeuKwGZSKbEYYi2bEc9qfn1X7XcSb
         wzVD4hhkSMmsyNP+bvgBVdxy7ohKJ8HljTpDvwgHG1uBFTu4KjeoWlrmcVX0e2bT099s
         l3JkeWzn4L7VSSF/liSX+iwKadiTzb3rviX3bX3s/wtNIHp/8vn+p1s3T8Z9y4xUx+K9
         4bKzatERJrismA1SAx8/uDWeh34PmC/FJeG7Vgy8Hjgtgx9EufeSPR4E7CxU3R8Qqfrb
         TqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709336359; x=1709941159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5BGi56UFoN3qVYxdYvohQcplCXdZ2ZAGQX5Knd7kmo=;
        b=ODr+GlTGbUnmzW4PuzF+mPKMlbO87tA3mcLHqwgfcGDU9DwECQM9aE1/0mtW+6pcVC
         +tyzxeNSqO99wMeD5WviRrQkg/2LcZUvYI4Qdwf9A+c533MFaYucXOA0RxPoqP8ZKB9F
         r8hQBw1um+k25QBpee8FhS/yRvocP+59N401vKyGSVG/l/Hyw91QV7sTR5L4LObl/4eL
         m1VnOjC04jRXby4GT0PZbVnJKMu3EgUPugQfNGIeijaaDw81OWAUvsvNNVqWhmPmRvI1
         mYleVrvzj12P1JbbNeMNpM1bxL5l7RvRoAFgLEamue1Qb1v8Bkc4hbkrXSkaOSjrm3FU
         Xz9Q==
X-Gm-Message-State: AOJu0YyXKbFOaWEiwfhih3bRDytV5rNhB0Cki4qn3Y0E0gVHqHaIqAIK
	ay19nD5mmyW+q2K5/ZOuwTLgG+UsDWxYGrhc2RWjKVcyUldXukKpb6RbwJJ08Se/EENXt2AxKhM
	yUZUW2GJXQEGibW7eo8TjeMKRYVHLp/mHit13sw==
X-Google-Smtp-Source: AGHT+IG1wAYpSPeLNV9qhViKFblGzTcZfh1NqTOn+pWqUaXBHkulKIKxW9+v6flCOX17DqHUQ/imyBkcESFu5xOm+Dk=
X-Received: by 2002:a5b:ec8:0:b0:dd0:702:577a with SMTP id a8-20020a5b0ec8000000b00dd00702577amr957219ybs.35.1709336359325;
 Fri, 01 Mar 2024 15:39:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301221641.159542-1-paweldembicki@gmail.com> <20240301221641.159542-5-paweldembicki@gmail.com>
In-Reply-To: <20240301221641.159542-5-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 2 Mar 2024 00:39:08 +0100
Message-ID: <CACRpkdbbR-AyCn19C8-uBVmfTJoYL9c3m8Med+aQJfC6HmGb9w@mail.gmail.com>
Subject: Re: [PATCH net-next v6 04/16] net: dsa: vsc73xx: Add define for max
 num of ports
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 11:17=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> This patch introduces a new define: VSC73XX_MAX_NUM_PORTS, which can be
> used in the future instead of a hardcoded value.
>
> Currently, the only hardcoded value is vsc->ds->num_ports. It is being
> replaced with the new define.
>
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

