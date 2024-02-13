Return-Path: <netdev+bounces-71569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CDC853FD4
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 00:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0CC1C27E48
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 23:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BFA62A02;
	Tue, 13 Feb 2024 23:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MCepNLjE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8879629F7
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 23:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866061; cv=none; b=MPqaYwGFTvw2SsH01Hcd2W7kplQDpcWY2l8TjnMacVmvKCstiB91H2m0QrYurnoDwmPDfPnhwisSMXJTFBLUAQoJdw3WzqtpMRfg5zHm8HDqeYIE3Qu+rHcILcyGNZpuYXbI8Dyuyrwh7hnjDoCWFF0vbhpYw/oi3Zg9q1QA634=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866061; c=relaxed/simple;
	bh=eB7RMcMJLJ9Je1NladOcXjy0j4kCuKfh5pdZmU9QjdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qq744i5DELuB9PTZSievVxmhbkt/ZfRFCnlAI6d13E8V98EG6B7buGXIgvoSCQ+s4/Ng8VBJApx/F1Jz3Z+cQwwEpZCshTELOWxAdpTx+MdMyJXlfw34pFCByKCaZ0nLSx8gz1mUOyB7b7qxGAH0gv6yjNwT9/LEkBwNlHOukoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MCepNLjE; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso5105937276.3
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 15:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707866058; x=1708470858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eB7RMcMJLJ9Je1NladOcXjy0j4kCuKfh5pdZmU9QjdM=;
        b=MCepNLjEB3K8Y3i32lhQSc24CzhtemcYLshw3iGhlKoFMJ2fqaWlKH9/+meepFKaRI
         C7mU3/3dYHAaGR3PN8YpPnVT/P7FxmaGZg4umxE6pYs8MWosl/tSvU01nhCU8fniNqeg
         XOCQ7GfqqEPlaFddIGNpe3hiTYP1HbOU3kTQDnH3107gYHtdF9DzLwAfpjTd+FFrbYNo
         GNwTXPpRUF/N5fMwlgE8rY94fPGbaZL2c8vK3OMMYAHMVervJ0aPnZKM1yMhTZy884Np
         Th281kGGMgnFKlWC3tqCHC0XwfXriG6M/JiDAg9y/n05W/zrw10UM5htEogiYj51ghpy
         eC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866058; x=1708470858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eB7RMcMJLJ9Je1NladOcXjy0j4kCuKfh5pdZmU9QjdM=;
        b=lDGcc+GAoQp0IOVPI8LWibNH7d6dZEz533Nw2BZkIAw1ESLSPiLMO6eJni4qYE3wz1
         1ll3yJMyIBgztdIVWSZ0sBtfJdB267RYIKRUcvcgoJUuUCxFIgOhWSqjB+Ot5hXI1zrJ
         zLeHLjBcUvzLkoBI6SKbjg8CIZuI8G8G8vlXqneJXx4VmVVc6Oqvwx3S4vqQ8XZX7f4j
         FfqSDgfqZRTEibFftoqPqpShLh6m5afpK4Cu0PE6wyiDrhnL2rgFzav3d/PL99QykHvQ
         QY3muKL0hYoWFagdU/VDjCJmk2yhNVXFKYDhTQ+rAWrlWwXFdXMa1aqXUgWscjYmbUTd
         7lrQ==
X-Gm-Message-State: AOJu0YxNx3aAu8XOpTEIJ3N3JbTyB8cyp3S/Jg6K6FM7TUvHtxoudX60
	lsgW/CZ8FU3UI7B2xtQlg00ZEPpKZKfG0tIMNVIwjdgIr6MZr4+OrRuBT6Hm0nt7VWCBhvDxg38
	1ik1ZPm66/5vdXs5Janm+JePxXjg6jBci+g2Kf1WUrbnjaqY0zEAH0g==
X-Google-Smtp-Source: AGHT+IF6qQQEQ0WI9EZCWpwSV/Ap9bumw9mqqt3CzdCQT0n0VTNRwQJwa04YBBGHzfyiPpWo7DP1eP08Q81LZwWXqrM=
X-Received: by 2002:a25:ae47:0:b0:dcd:49d0:eece with SMTP id
 g7-20020a25ae47000000b00dcd49d0eecemr623009ybe.60.1707866058733; Tue, 13 Feb
 2024 15:14:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213220331.239031-1-paweldembicki@gmail.com> <20240213220331.239031-8-paweldembicki@gmail.com>
In-Reply-To: <20240213220331.239031-8-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 14 Feb 2024 00:14:07 +0100
Message-ID: <CACRpkdY4d=KaGDo+bmvxZVL0hBWJbMp4E2kNzOq=YqQktRiY4Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 07/15] net: dsa: vsc73xx: Add vlan filtering
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:05=E2=80=AFPM Pawel Dembicki <paweldembicki@gmai=
l.com> wrote:

> This patch implements VLAN filtering for the vsc73xx driver.
>
> After starting VLAN filtering, the switch is reconfigured from QinQ to
> a simple VLAN aware mode. This is required because VSC73XX chips do not
> support inner VLAN tag filtering.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

As far as I can tell it does the right thing! Good work.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

