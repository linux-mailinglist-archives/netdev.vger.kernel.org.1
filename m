Return-Path: <netdev+bounces-171029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FFDA4B389
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 17:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7828D1697F4
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 16:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31EE1E9B2E;
	Sun,  2 Mar 2025 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtDcSe7J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09C018D65E
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740934314; cv=none; b=ueBvsQ6YPusoZBv4ZQbdFllfJukELP0PQWHCVSfz2OUwB474G2p353U+ytG+atd67dq5gpPZ16iFgWh4Yztn17h6F8XD3rGdZTqI5sYHP3CY/j+QfHwoPZQ6McGalfOh2IwXBUAeA/8KsJo2M1z9XJldAAkmodCSj7VCYGxNj2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740934314; c=relaxed/simple;
	bh=as69cqRYwnP/h+X+9ax/t0ZGZCPA7bDUvqdhcRJHS1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIUyPh4qxAy7In5UXGl+4iHrkjehP3PWpMi/ObSLyhZWaMAQGDvCUQ3Na6Dk4E7WzxrnxsUDqkBXxivTNF6+rJokXHL2XWUynG74718ODjo0DmMzJ0ZiLSSkGcGIl7uh8Ef7GW0q99XShDJOBICrlr3QYHFo+OUXpZjbqGREcxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtDcSe7J; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-520847ad493so3623888e0c.1
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 08:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740934311; x=1741539111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=as69cqRYwnP/h+X+9ax/t0ZGZCPA7bDUvqdhcRJHS1w=;
        b=mtDcSe7JnE4T3UOwRc2caxv3muEtRtvQwDA5pzU+rXe+JqYyMiyodOm9IpAc7FEuEk
         KPQ/p9WA2sbP+NAwxUeliBKwS6BL7W7bjpD4JBbE0uJ/RfP8g4tmYD70/YeNoUCAE+5N
         kv8Y7KMup2s70MET3tz+uTr/p4lmkmYshDnpxO4Y+RTu61BIAZvsguCba3wWRnObBCzj
         58EEGq5BZaHXa2LoW7fxuiUwZpVaM43T8KO2LD1oMVwczbEH66L8wJAvn4rRB8pf9yQq
         NMyYgOe0+ZhsuNHTOOn+3Bsi1y7jf+4bS9CSa/IfjGK2NTsI6SdNaS/uPZH4yicoliVz
         Q76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740934311; x=1741539111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=as69cqRYwnP/h+X+9ax/t0ZGZCPA7bDUvqdhcRJHS1w=;
        b=OUPhhG7zPqbImqOEDImSnTSnPYgfwFGZdkUzR5gNCOZf/i0s53MNc04kaUjfiDG9VT
         Plfer7l/6nBrruS3E7wyFhtcc27LOQknTue3CiENOKiJmJChh0mANS6blLAxqtCfkZT3
         nhwCFQUQsu+TtKtlGaqWEGKX/EYLuqn5lo944ZzCF9tXvaJTmMhxvurwMAId+ljL6p5F
         0ARXy+AN6APU+dckZS6gXh6D0uP7yropa7FeDme6mS1dPSpZDWNZXPNu4xEYlvwiuRrc
         242dctHoDRC5v3CSql9+0oicPOyXgq8/QlwKIrFu2yUJ0Nvg+ss2KBrUm0QrNZBcPHFd
         g0yw==
X-Forwarded-Encrypted: i=1; AJvYcCX6KMRPqaPMqEGXZjHhToP+/8pxpnedMHAzlhFm9gW13uI6nyKla0fznR5d1DqhGlILIWrNnA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFFnGHj6wEruCsM26xHnMhv0DMMdR9wF+KH9jTxyE3zSudmLK2
	lX5cw0drKeRoh3PHQF3EVEhh6belNvtGqXWbnHTN1tFyiX3WZkLJMmQHvEHils5mt+cAz/jgAXY
	GpLa6/M90jNPj0ZPZT+Q5EPXHC1Q=
X-Gm-Gg: ASbGncvhglZlMSdd+YfkIg8MAksxKTYRlkOG98+4muqPM39iy+rxzrEKld1WLBjD3UJ
	07op/FvABoE996GOvV/HgSmNS+sjulKbE9HMQNItLyanf7MVPq782w0BQ2MNp5hEeOYPzctIxTT
	7j6Z/7OaZM9/5lt8E8HGkloD9LL9MK6FAYGBpMHs3mZmBJNjJ8Rs3XFb5/Dkw=
X-Google-Smtp-Source: AGHT+IHkVpFk6ckEsvNZMniXzAGvjzD+qTT1IxBQkVl76sSlYPwaYujg+IJDf5DiGEeK4CS3IdB8ZqHPxxFKX/TryqY=
X-Received: by 2002:a05:6122:3d4b:b0:522:1d6f:2b4d with SMTP id
 71dfb90a1353d-5235b773432mr6038327e0c.1.1740934311094; Sun, 02 Mar 2025
 08:51:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+V-a8u04AskomiOqBKLkTzq3uJnFas6sitF6wbNi=md6DtZbw@mail.gmail.com>
 <84b9c6b7-46b1-444f-b8db-d1f6d4fc5d1c@lunn.ch>
In-Reply-To: <84b9c6b7-46b1-444f-b8db-d1f6d4fc5d1c@lunn.ch>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Sun, 2 Mar 2025 16:51:22 +0000
X-Gm-Features: AQ5f1Jpfswj3v3flUMX3V8q19roDFMt_dMemWx51XFT1sVnR_Rikm_i4a-YF8a4
Message-ID: <CA+V-a8tyZAAYeBoxaUM+7Cnha4+_pGHa4dBC+voHNk1PX+VfGw@mail.gmail.com>
Subject: Re: [QUERY] : STMMAC Clocks
To: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@armlinux.org.uk>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, 
	netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Feb 28, 2025 at 11:38=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Fri, Feb 28, 2025 at 09:51:15PM +0000, Lad, Prabhakar wrote:
> > Hi All,
> >
> > I am bit confused related clocks naming in with respect to STMMAC drive=
r,
> >
> > We have the below clocks in the binding doc:
> > - stmmaceth
> > - pclk
> > - ptp_ref
> >
> > But there isn't any description for this. Based on this patch [0]
> > which isn't in mainline we have,
> > - stmmaceth - system clock
> > - pclk - CSR clock
> > - ptp_ref - PTP reference clock.
> >
> > [0] https://patches.linaro.org/project/netdev/patch/20210208135609.7685=
-23-Sergey.Semin@baikalelectronics.ru/
> >
> > Can somebody please clarify on the above as I am planning to add a
> > platform which supports the below clocks:
> > - CSR clock
> > - AXI system clock
> > - Tx & Tx-180
> > - Rx & Rx-180
>
> Please take a look at the recent patches to stmmac for clock handling,
> in particular the clocks used for RGMII
>
Thank you for the pointer, Ive rebased my changes on this.

> For the meaning of the clocks, you need to look at the vendors binding
> document. Vendors tend to call the clocks whatever they want, rather
> than have one consistent naming between vendors. The IP might be
> licensed, but each vendor integrates it differently, inventing their
> own clock names. It might of helped if Synopsis had requested in there
> databook what each clock was called, so there was some consistency,
> but this does not appear to of happened.
>
Thanks, I will have a look at vendors binding.

Cheers,
Prabhakar

