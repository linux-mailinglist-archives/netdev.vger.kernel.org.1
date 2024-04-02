Return-Path: <netdev+bounces-84021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5154895580
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3E5BB2B7CD
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C5283CD8;
	Tue,  2 Apr 2024 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="woYu/9YX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65274262
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064602; cv=none; b=QjucrYB9EhW5+XFcHbKBnX5xpxmmXVZAwnxxEDV13/zdIiD+1f1EIKZXtpZ09Pu+8sW375hZG8jpyjtfGu6p4jpDTLCwIvre+EW6pyqYPD600aT1e5w95QHHtxFkhUExEUz7Ap8Dg/eRUjfPBM6nDJ3sZ90CP/Pqqo3ioU+3YJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064602; c=relaxed/simple;
	bh=Rsf4Hmc7EDYpsM//x1hgr83P1rDRhRAlcJu2Zk3nTCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDXRkRw7R5x8RAuCW9upCAiCdCloktB9P7QDk542jRrnsd/WhXGOx56YqC8XstrTmx/AaKd1BppdYS0iihv6KuR8BUle+6hxVfgdYsJjFNp//Hky5Wxs37sWERJtzIEyHb8H8457ZrT609OR+VqW8uPLBu2xqZC/8c2L79N/iNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=woYu/9YX; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6114c9b4d83so37288367b3.3
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 06:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712064600; x=1712669400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rsf4Hmc7EDYpsM//x1hgr83P1rDRhRAlcJu2Zk3nTCI=;
        b=woYu/9YXSb60X2ootZrB1VmfxbjbMgLW7Fy9fHUPrTY4eP/5RSTsGqxDewVPhTw/kf
         k1psm7lNmPJzvdEU7g87iuBAKv8D4vYKqvINhxBZyn/ML+eyn3610Gd79tlPyQuJVVFY
         M4FCWwHmzHRoe0Ch4QlFbwleBBzQ2nP8gdN8fLC2s/GEifGt8+dupAhW5YqTnRu7MIou
         w6zf3CTFi+Qw+t6n42FMZ25VpF8mB4so8WiVmVvt9GK4Ygmt4tGFG4HuMv3HbqrUvfQF
         Hcp8+EKffmi6c0Odqht5e3rqPKdjMs68xlw0S2F4I6VG5HRFSmOnrwYXoh2fmk9FZPNs
         hdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712064600; x=1712669400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rsf4Hmc7EDYpsM//x1hgr83P1rDRhRAlcJu2Zk3nTCI=;
        b=WghvFxFL/BFzmdxPhIDRRsQaK+Yy51XyRYAhApB4hkIwcNM5BMvE12nD00rFgQ4E80
         XG5FRyu8msJe0Ni9KAHF/V43l6uSas1UVvBtzX2ZqnFEgzc0Wp5Z05qfkCYroG0CvN4P
         5dyJLQVLH87VXpJJc40P6H4lj53S3srAf0OlbKAefyVNmJFQ/O5d6pUuSBKEc8QYKDFz
         7+yDjIgNgW1FqwJ4xE/1bclh6iJiIrGvLvR+ficAxoq2JGoKGh4z7+9oIf6a0qJ7HqV7
         hunZWJEHmPwHKrMTqAs4UrKlitIjOwI3ZOHblsRUmIDW+rMOZuKPcTiYtWCs11qngaQI
         bKLg==
X-Gm-Message-State: AOJu0Yyu6hDZimrIEdzlkA3sQ1+rE5pvqpal4o9LW1Q8gJTWSmQ7IQAu
	ueM/M50wQuDJc6UOfnT3sSxtosAlt9m7WGy0C7TBf/8YKoFx1LBzeP9tB6GdUoVegpYiyxMQbRk
	6zrNmX0lU/aW0MLlUDQKAVRYblYFvTZ2gwWZ7cPZiMRapNwNi
X-Google-Smtp-Source: AGHT+IFLJO8J2fFfhy698GFEfXDi3jvJf3a6TN+kjIFjbSxpGgHCRCMV4mzFo3tqzFMXkC9wbzCSEw9BhXR+zLg9a/A=
X-Received: by 2002:a25:c05:0:b0:dd0:bb34:1e77 with SMTP id
 5-20020a250c05000000b00dd0bb341e77mr8834023ybm.53.1712064600135; Tue, 02 Apr
 2024 06:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325204344.2298241-1-paweldembicki@gmail.com> <20240325204344.2298241-13-paweldembicki@gmail.com>
In-Reply-To: <20240325204344.2298241-13-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 2 Apr 2024 15:29:48 +0200
Message-ID: <CACRpkda0+eEig-jzVtZ4oB5q2TNYdGVyGuwpqJH6dvSdqaASAQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 12/16] net: dsa: vsc73xx: introduce tag 8021q
 for vsc73xx
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 9:45=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> This commit introduces a new tagger based on 802.1q tagging.
> It's designed for the vsc73xx driver. The VSC73xx family doesn't have
> any tag support for the RGMII port, but it could be based on VLANs.
>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

