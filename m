Return-Path: <netdev+bounces-105158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1F490FEA5
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2963A1F2146F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EBB190694;
	Thu, 20 Jun 2024 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XMBjNsFH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E234917C238
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871623; cv=none; b=s2890liplCXkrxvo7eVMcCn0c39nY/90Ee+u43jCLa1ozexoLLadixuRvkgXaRWx7jLw5qw3O9cBzujCua0iroCdeiNLfv5Ox4ESywltIPJkoAf0+FqWDrwvYIzGaSjHEgSLzOISKIjAND4E9MrKvyLOU33kzb4AqIvF4gtppks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871623; c=relaxed/simple;
	bh=B7yX7rbJbYr/mTm0lEL9vuk9v/WQvi74pV0s5CSPcDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDjvtq4CXGD3rNQeGrGQymzAkfZKvHFbCiLkLLpKy5+U0xGWJgtB8z/HBiuKio2LvnVG7ALjAqBC2STd4+2588cQm0AM9hoD8wwetGGnAwSimy3Hq1WTcUqj5F/uCj08zVV+DkE3pw2zNzyrCTQ4u9G9R2YO4xwPZtK3C0U96VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XMBjNsFH; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52bc121fb1eso649023e87.1
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 01:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718871620; x=1719476420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7yX7rbJbYr/mTm0lEL9vuk9v/WQvi74pV0s5CSPcDg=;
        b=XMBjNsFHBUenumwD5DnIx1adUHvzgD616LxC82BGFmHLRvyX35B74Az9RK5fsvjJ1T
         T0+O7u8w2IiieexySugHQxyCmglq20KE8kAMzZh5VT8apQsVbQ2J37+y0gIgvc17UULw
         VtDUXyQkiP+51ZEWdS78HuGoYlbnjjPEXy+Uy5EWG0oSPL6VaIuxuT+8Phj5LenD6wKQ
         JQNrKBjYehQNMVfpLxwISSb+Zyu4RIyTX+FE/z111yNEi+nGeIjs7N1IQUM7d+5LNsWP
         MNSf9am8EwviAG2UKxNmaj78uYqdnttvXQXaigJxnvLEWYVWpNrZ5P0kH7hb3efpjrqX
         DsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718871620; x=1719476420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7yX7rbJbYr/mTm0lEL9vuk9v/WQvi74pV0s5CSPcDg=;
        b=VgmvRfYcmtoF8e0ORcOLaJkz+gZ2t7Xh3DyOgbi3NejfFx4Ln8Kj8XetkDf8TFkh2g
         ZoGJSWy0G8KpXkEzz4Wwff6D6t2pk1W5XrCCEc7o7pEKlZiqPapoE3VErRO2t49Kps/r
         ipo3tEc8ph25XHvCBIZWDs3KDJLnV3xq4hP525rgO7RYjT+sTrZ71ZV6xxSWpmGbNJD2
         44dq61XEFkVhlQY1hz+TwnPqZENJycWLDXKRRaxIgeFlD3AKtnTddsjNMxWX8S2XcH4M
         QnUDYTuNEWORN1J12GOY7DHagNaRDArg4bPCPghYi9qbOyu+dJzDjeusPoQuYS+Od3db
         nbIg==
X-Forwarded-Encrypted: i=1; AJvYcCXWyLRNKhkXVdK4lbaGDh3AxtVy8UP18eL/hS/rGq10D2S1ewX7E6Z+v1MmjCj/mwx6SS6kC/8ew45eSZUCBlypu2XcxPrV
X-Gm-Message-State: AOJu0Yyw6xo534Xi8n4BuxOjVTy+/HSYuEIpX/29idEJNkeQ3nXLb7fu
	EG7Yq6hKimCFIcMVzwWv4N4iKMTw5StlBF6nZrowazA6N8rLnlPKDCXMrQmqx+nkTfvbU/kdHUN
	w4LUkhb85qSySBtQfxGt3XlROyvcdVa7hvV6mPg==
X-Google-Smtp-Source: AGHT+IEmop4fSjADk7pSWeD8ON7nqhqCNYoCXWB9xXRFCphWhGBBKaZ3FTBp7MgrIlYFop2ThtyzgoBlAbqZbHjT0uk=
X-Received: by 2002:a05:6512:1182:b0:52c:86d6:e8d7 with SMTP id
 2adb3069b0e04-52ccaa2d4a3mr2435101e87.13.1718871620038; Thu, 20 Jun 2024
 01:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619184550.34524-1-brgl@bgdev.pl> <20240619184550.34524-9-brgl@bgdev.pl>
 <f4af7cb3-d139-4820-8923-c90f28cca998@lunn.ch>
In-Reply-To: <f4af7cb3-d139-4820-8923-c90f28cca998@lunn.ch>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Jun 2024 10:20:08 +0200
Message-ID: <CAMRc=MeP9o2n8AqHYNZMno5gFA94DnQCoHupYiofQLLw03bL6A@mail.gmail.com>
Subject: Re: [PATCH net-next 8/8] net: stmmac: qcom-ethqos: add a DMA-reset
 quirk for sa8775p-ride-r3
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vinod Koul <vkoul@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 9:33=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Jun 19, 2024 at 08:45:49PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > On sa8775p-ride the RX clocks from the AQR115C PHY are not available at
> > the time of the DMA reset so we need to loop TX clocks to RX and then
> > disable loopback after link-up. Use the provided callbacks to do it for
> > this board.
>
> How does this differ to ethqos_clks_config()?
>

I'm not sure I understand the question. This function is called at
probe/remove and suspend/resume. It's not linked to the issue solved
here.

Bart

