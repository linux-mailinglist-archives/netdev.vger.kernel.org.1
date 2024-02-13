Return-Path: <netdev+bounces-71564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16754853FA7
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 00:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD6C28C3B1
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 23:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B9F6281C;
	Tue, 13 Feb 2024 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M0ya3bvw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660EA6280B
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865635; cv=none; b=qylbjNvetV6ea+yBlsW1TjbYNkM+1Ratklb9a7uNyQx9+lRJrZhmm0Id3s8wA3lZaszLKEL6SnWQSAuH8S1xe+hVjbfLTyhRAoTcFQy2EO/JTg/LprBx/4Z15VyqmsLchcP4ExZz3cXe5Ah2l9iqU6q+bztyDbso4oPipYlsIZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865635; c=relaxed/simple;
	bh=MjAOKycBPzBk4VO9jkOkv9nBTectr6pmu0X6Zna2BAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoW7zd2Fy7cTGbXuJ4G+X7MUjEZjfC7rfoGJdw3J7sEt1KXa9V9NJWOD+qO2sk74CDUny5naEp1vjDKF/5+yr7QX9/a/xvt4kjTnq8SRh0VVeT73enmUyfg6U1gCKaTR8LANyKzggoC/vkGPTuGw7O7LW9BOiM4DP9x9IM2UJqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M0ya3bvw; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc7472aa206so4194627276.2
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 15:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707865632; x=1708470432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjAOKycBPzBk4VO9jkOkv9nBTectr6pmu0X6Zna2BAc=;
        b=M0ya3bvwdjzmfbQmWgeeOPVTgAmATTw/AiXusdZXqHr87FBmqE3yJcAb36e7/dW73r
         rkHaB4dQGzBwpztpthLfnK9yeM2PmCpRoVSo9DTKTZodwsx5w/Dt5LXuND+76+zMKTX+
         E6A02VHP1FhCYWolYnUyXkNeuAXJnqsYmctJdpKt1LITjJUWRODA9s4bxNgGkbutb5HF
         qBoAVjiR4Ig+M2sgxkkaaPBzarXe5/gkIBeyNB+7Kpfe8xx/K1f7RHuzfCA//AWkr0cI
         ru86TZY+WZa8ierXsqezE8DD6V+XddnSYEvEXohoChDfIFyZ48dYPHpbWlbcFAqzOWOu
         m96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707865632; x=1708470432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjAOKycBPzBk4VO9jkOkv9nBTectr6pmu0X6Zna2BAc=;
        b=vDd8l+Qe4GVturMOJ5Eda2raZf0ablhZditDwDyH5lY5DhDezu6UpUBXz8b5KJ61bJ
         MLCRpsWISG0TwN6Gj0w7Va5qmTBE1BELhqZVZALsl/wcln0H+2KLcT78sYAAoW4ru7kx
         KoMSB8aWifG0njjUVvia7JrcudN240VNLWGV9pgJXcJ3RuFAiklsTU6QPLG3NauNL8X4
         VrCztIzdof027GNcyA0riO3VHYr22DzC1khWdSNlrUj3zv6sQQfVsoz7owza6WHHnK2N
         lmDoro915XcQY7LZbevZHGOzjGqUYn04uLDJ5+d929JpVG9ipDks5fPjLi/UZPKn0CVo
         5gvA==
X-Gm-Message-State: AOJu0Yw1Fyza0SWJ4cgrzwdOarWh9NL4XBCE3Wg0/Qwi1t1EowMHJoCK
	T96KG+G0nxxOlwHXWz4bNzXWGDsGzk4xzUM+OlsnZLIfWu6nG8il5rOCKV4lPE67K4mdJYLb7qm
	BR2U86owaIOhrOHVXzhQcO+Gj9zZxD3XLDL6gZw==
X-Google-Smtp-Source: AGHT+IH0A57JXze3tzIP18mqi1HPtHwASPch1852QaRs+J14eOrw3rz4b87JD/2SNy7XjqOkxXDiVmzM6XYJUMCpeIY=
X-Received: by 2002:a25:8691:0:b0:dc2:232d:7fde with SMTP id
 z17-20020a258691000000b00dc2232d7fdemr792874ybk.13.1707865632236; Tue, 13 Feb
 2024 15:07:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213220331.239031-1-paweldembicki@gmail.com> <20240213220331.239031-2-paweldembicki@gmail.com>
In-Reply-To: <20240213220331.239031-2-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 14 Feb 2024 00:07:00 +0100
Message-ID: <CACRpkdaKRPV=mRkTcOMGgnozxNS=fojWJ4nSnK1GEBSGSM9NMQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 01/15] net: dsa: vsc73xx: use
 read_poll_timeout instead delay loop
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:04=E2=80=AFPM Pawel Dembicki <paweldembicki@gmai=
l.com> wrote:


> This commit switches delay loop to read_poll_timeout macro during
> Arbiter empty check in adjust link function.
>
> As Russel King suggested:
>
> "This [change] avoids the issue that on the last iteration, the code read=
s
> the register, test it, find the condition that's being waiting for is
> false, _then_ waits and end up printing the error message - that last
> wait is rather useless, and as the arbiter state isn't checked after
> waiting, it could be that we had success during the last wait."
>
> It also remove one short msleep delay.
>
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

