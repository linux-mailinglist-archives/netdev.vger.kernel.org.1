Return-Path: <netdev+bounces-74629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4827986200D
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 23:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AABC1C20C5E
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 22:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB001419B3;
	Fri, 23 Feb 2024 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DxidgVnm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A0424211
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708728652; cv=none; b=M4Ku24YI0bv54S+2TqRk5ijjHzm3UVeX3vOi976iR7X4vws2FfuBuHXQsaY2KQEobuDdmYuhcO9TXxbm6HkiVr7CUR+cGzGH+BEzOYGl6UgCdKzF0teKouutIhC5otmH5eQra+x06CCGQHiCWYXoKI2tV3cSHewOBsp8RjQFgxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708728652; c=relaxed/simple;
	bh=7MnTsaQms1KvFyh/w0ZQeuJlEeSO2RTHjAhsELHK+yI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsboa6Hfs90aj6rX08mw0e4I5CTd0s6X8FPaVh/l9g5s0FJyZdYreEKbU9hFddmA+yD4lTzCa7le5Uo3DFGBPsuMtatv9N6X6wqh+fd4yu/891tNaDI66W/pRzOACcH1SfPq0o8lv6XFDr70i9SLs5+gxpumSACKP/Nautw8E80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DxidgVnm; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so1292081276.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 14:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708728649; x=1709333449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MnTsaQms1KvFyh/w0ZQeuJlEeSO2RTHjAhsELHK+yI=;
        b=DxidgVnmK93+EwBq2GRKMVqAyWHkrT91EVYe3FtSKEnV6M+H5Kux24wd7WA3mlb9v3
         GybMonD5kUaiBrIYqvZu0FYs9dA5fIisreYk6RNKvJxxe6HChuu5SynNOJUI/PqSf5JP
         Ifvr7dUdYAoMbcOpkFA4irA47VRY9eKYEcGdFm3DISvQJD/ZEmOaLqZaoh2kQ8apLELK
         rNhTys6NxiZpiPeFiDdqlUJiphXKQDrcsNUtdBKfXBcrY7ha2GLhdROx+cJUD252Uu3m
         2hfAzbgd+D2h8/MZt+y+TCQ+Zt7wOAHVOiunrJjnxAmNhqdTXZbaUFSoyW37m7LFoh2U
         TB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708728649; x=1709333449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MnTsaQms1KvFyh/w0ZQeuJlEeSO2RTHjAhsELHK+yI=;
        b=EjqkdfDkhSdoRGwAWDEAXD5PSgT25cegPZaEiviU6vbbYSSRCwUVxEOWrJtdFXtSwK
         EgWaPpODs1sHAjhkDHhYiciweo6HgKhLAXWuXdAsc7KOIHaeAHLor4YzoLXDHW6SyT6I
         enFMbh0biXOoBx6RLtAZYq7lpZFL/oHBbgQetn5tuFfv3plr/zsUh+Yrp3bwVyIgB0je
         X2Z9zC7nLFeEryLPI6WhXfZEGY/hwiuej0IQRGoyg0RFoWjJrZTOKMOHrFBcl7thjsgy
         QFUZsv9ZHh6azop9H3IXjrhG6HTMI0nYlnrfhyHqkRcxTKlK6qkPg6xXW5KFK93V/WPL
         kWsw==
X-Gm-Message-State: AOJu0YwFP7kC3AYIELUqV6HOsodk0bTmmQa/x7H1yCJNX4DjkR3hVkKp
	vLuXOzOY9m1kkT8eiFVGOd8Ui3OVns0vlOz2tOS9QyXUg2OK2tIVKn0HHIJKWPjmmtAu5z3ItnI
	XczbB04Ktk2OaQbsDV+dmCuEUh3RrvAe9a+sP5g==
X-Google-Smtp-Source: AGHT+IFTs0JlBH1nBVrpRsCUQ7Qs24Jlivb9KAozhT9oChbcK9RqRaCyl+EWEnBjEsScON9SN0G1wSa0+UobEX4abiE=
X-Received: by 2002:a25:ceca:0:b0:dc2:279f:f7e with SMTP id
 x193-20020a25ceca000000b00dc2279f0f7emr1239658ybe.10.1708728649493; Fri, 23
 Feb 2024 14:50:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223210049.3197486-1-paweldembicki@gmail.com> <20240223210049.3197486-5-paweldembicki@gmail.com>
In-Reply-To: <20240223210049.3197486-5-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Feb 2024 23:50:37 +0100
Message-ID: <CACRpkda7=DeUTcCc1_nee7kv8A7UA8DV8sWCOjJH2OSNZRsahg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 04/16] net: dsa: vsc73xx: Add define for max
 num of ports
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 10:02=E2=80=AFPM Pawel Dembicki <paweldembicki@gmai=
l.com> wrote:

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

