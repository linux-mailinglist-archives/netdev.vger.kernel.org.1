Return-Path: <netdev+bounces-71565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB6E853FAE
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 00:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C741F25221
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 23:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F34F629E3;
	Tue, 13 Feb 2024 23:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AuTXopDN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65506281C
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865670; cv=none; b=A8OHkCQ83Ovy5iSOJtNQdnE2GTjxdp53CA87MT2GstUWxGsaqfIrMctlXcw9JsflnbqPQnVMcOuBeX6uQFHmZYc1u6wcaGw1QoFe1E3JpNysgtsmJ+i6Th3QVejeTwe77Zk7mQPoVfiuN81VJQflcOwZUFoPMZxdU2b3Aa0kwDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865670; c=relaxed/simple;
	bh=5r8mGWxqCI6vEgqZTBMkzo4gQvTRqNCArj72zBif0wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7J3tjBPhDBxJj2TbjK/yAgmv3BRqQAfWcNLALSor91IY2mG9AkgDG5bq4regCLA/AVbb2m5WY1GCXW5e2JH6Dlb9yn1xmOzA2CXYpdsErnxhi0ud0NWEsOLbRktzhkfzK2puCWHCHEqOXvTw1Uv/YIYhTcb7etlPDs83T/SrJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AuTXopDN; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso236689276.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 15:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707865667; x=1708470467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5r8mGWxqCI6vEgqZTBMkzo4gQvTRqNCArj72zBif0wU=;
        b=AuTXopDNGeir0vPOFVniMlL+Q3IgzlP4aI3edBaceQW/nNs/uf1Aphs3mW8BNRSa5e
         0uq1pD1eOU04WZ8xeXHqw/XOWrifg5f02yzAvI7mqne0zlJLOxKfXCZUa/JR39MRpaaz
         mYhhzylAU4FQgYgYRjlYbMDQeQ8yiqffqa12BKHQKaJlP3vgDq0tSg16vClgS4IK0MYD
         p20ZVeD+cQQqALkg+CfO/Z0YKynf8YsJs4zuYrbcebPKEMmV8II2e28czbloIfGu/9Si
         uyqDY6jmwA4wLqMkGByrKnCXtfeRYCJj8YCm63JdU+hqUmq/0EbUNLe7CnAKFPzDa5+X
         F6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707865667; x=1708470467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5r8mGWxqCI6vEgqZTBMkzo4gQvTRqNCArj72zBif0wU=;
        b=Tj7IzdY+WSAmAbOrWoQB9vv/bMCDOxxcWR6gjbCJWIvGNDhcLxKkH2EERSc1VjegKl
         tngpjDusYHWb1TJD5Uyoyx+wXUi2VWtoJ+NhVOqzuVsGq4QFXG2ppvBIfhbx2GKeo7A4
         nqRwCJFpot8sGo15nYGeC6jwNgnEmZvS2Ou+EicKxiLqnBzcSDqmL6yw59zK2Y2bZgw0
         RvsYW4X6s2SAI8PjUSodulDYoOsqeL8fr7AeB2gJbv/JhdMAhxKwo919npex6wp7SLlz
         BMiH6XEjsG0BANpmt5WCEQUgccBSRoX/BIU6JxXHBX1rGXu1Vz3D9EL+zuNaEpdGYJ7y
         r9wQ==
X-Gm-Message-State: AOJu0YxG87CLc9Gdd4lrszeK2G4/4Pu2qomNkT36tLrqpoyG3Qgzs+KN
	+gY0x0MYpX/eqm9ziKiLhZ0A/rvfC7b6FlWAACrgbFjjGbJm+qfCUgsiPsQVOpDOBr0o39zyvpZ
	J6XTgNYaxd2kTPJ9UfitjyDxZnkLMclAu3qnfeg==
X-Google-Smtp-Source: AGHT+IED3UnYNv3qZy3wS1gN4YzhWWLxmuPdKWXeZ+oYphZhStOOlt00/JsSZJX3g5VssxQqQbR1ikxzXAYLLUPneCU=
X-Received: by 2002:a25:be54:0:b0:dc2:2d55:4179 with SMTP id
 d20-20020a25be54000000b00dc22d554179mr265190ybm.17.1707865667723; Tue, 13 Feb
 2024 15:07:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213220331.239031-1-paweldembicki@gmail.com> <20240213220331.239031-4-paweldembicki@gmail.com>
In-Reply-To: <20240213220331.239031-4-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 14 Feb 2024 00:07:36 +0100
Message-ID: <CACRpkdYxf-4PGyAcA3146_V==u3q9QYwiN25cRCt-wZrh9xocA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 03/15] net: dsa: vsc73xx: use macros for rgmii recognition
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:05=E2=80=AFPM Pawel Dembicki <paweldembicki@gmai=
l.com> wrote:

> It's preparation for future use. At this moment, the RGMII port is used
> only for a connection to the MAC interface, but in the future, someone
> could connect a PHY to it. Using the "phy_interface_mode_is_rgmii" macro
> allows for the proper recognition of all RGMII modes.
>
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

