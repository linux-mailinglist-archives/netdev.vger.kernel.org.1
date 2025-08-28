Return-Path: <netdev+bounces-217788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A55AFB39D73
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD7E463AD9
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3702430F55F;
	Thu, 28 Aug 2025 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA+Hblvl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6EC154425;
	Thu, 28 Aug 2025 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384714; cv=none; b=NPYBgjfjC/KOMNb9GcfcRdVKSGLDhUPIK9rxCT28WfWzS3v4GlCE6NwuHHOKGHBh8yeKUoSAroW2gGwImUXdkgodkqKOLCA0RHPdPla8l4l9CtDhLTpYND49IlmRISF/tsTJdUKqktUcpXrGYAk0v7+MUgQ7bh0XCK/5/votJuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384714; c=relaxed/simple;
	bh=h2qTtRFRSDxrsUZkUWdMz+uhv67j6rqIh4Hl2/EL6zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFwhpmdxa4zqIz9WJpLrR1nq4FQZc8orGW/4+Br3guySZ3ldY67xPDm9osV8gaSCDec9mnCJjL3nww6/Khop2EZEQp0UjY2XB9D2LsJMMKsF8k3fxUJtiu3uXdTUyTWkbbhRQXb6hvUA3GtWbM3+2WJ7du/J0V+joeDof6a99o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EA+Hblvl; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74382015df5so210087a34.3;
        Thu, 28 Aug 2025 05:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756384712; x=1756989512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJClskWj/Yo+5yigeUe4lqV+RJq4jkVMM8DmVAlE+mY=;
        b=EA+HblvlTweFeLm8Qpd1QOeIuBOUbQqXKmI7sRX7XayTGrfb+EVG4RzIZ2C1lyB7nM
         KhNUDSfHu6cM8kFLfCyQpw4nqF/x097QBKHtZ9x+qB8HaMBJY8+37SMtqfCUL8wdwZwR
         NqT1EoCxLX3ctrSgtCDmpiQSJzkzYKKQMTG6VVKgTPZPKx1PcQH19GYMInvhq2GFaq5k
         n0/LMVo2rAE4iCRLKLRPVLPNbXbCCyzW6cuWdmADzo1w8FMDra3+h6HN0ONAWARJnJ1p
         suAnxpP8X/3LikkP/eLcaKoqJOIge8guxLtadxgCe2tx+4HDmttWMbxFJoLyVCzsvCoz
         OMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756384712; x=1756989512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJClskWj/Yo+5yigeUe4lqV+RJq4jkVMM8DmVAlE+mY=;
        b=Wj9F7quuCMnTisT1WiK1s5w4odKeCKAzOgbfjIaQyecgy4gLE+zP+YdWEQioTT8b7F
         4Zgc/1bnAThmiy74jlHA+Bjs6b/DxIVwCXrikAuERZWB/l+VhgBkfqVKhO5nA5R4o5xE
         a9Xy/7bgcJo/gG6X6AqQdrumpdqf2+4RpCnAI7+xZQ7bdww7iwM5FOOGPCMfF3MKG17j
         /Mn2QJwRRtCEbNzUM2s9FX3BgruXPhQlq2MrqudePTiXbGMK/c7j1RK9DNFv2g8Iqbql
         bwvybCDc0Q1EVvTWQavwidelAh75OqJvEmYuuJGbAoV28JOGA0V5DPyBEqkGShbylllX
         +gEw==
X-Forwarded-Encrypted: i=1; AJvYcCUmpgMR4bUT+nEF2zlxuqBJCssD1Gftgvpj3w7N08GPUbf1MBDEBLMIdlOMDIykg0+aOUW1MYz8aJqeTrw=@vger.kernel.org, AJvYcCXhz6rhaoDO0rnOW4Zr9WTOd9rhdXFGNFdNl0Qixfl6lZsaY/kEhQ3/A6kD+FkjxsxnUiDowViU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/QoDcj2YmNlyCI+In7CGD4GfrP0OqR/ymRe0glDAXjbzHfuZT
	WiPBJVKWkK1pKr1CIoSt+h5Hn80zekGa4PUFogzRr3YcQ32u4IkcfH0ng30JHyh7N/5gWmw4T5q
	B04zdzyIwQw9q4kgwLUcjobB7PWERNjA=
X-Gm-Gg: ASbGncvaHnq93x0KhcNy98b1mWNBSX/8kIJ3aRZq2x4AiLD+/EodgOQDq9Eu8KUwcrb
	2YyM4+cH9sKXP1/0oSaQAwh6ECmxRma3Co1UkG6jll9wlZNAZDAWoe4L2asawXSeEmcvGFvnaZR
	+mlyY24y4JYC5CgvSchn0m4qmMRIGsXtYJQ7wkdOexcYPdr00wg6aG71ILXmrtdFcturWSu2WjZ
	ul7HjI2L74u+CNyhrENEyNAvv8yTY6hvrzii+kudKAhtdoJYlkCu7txGQCZFWyinZvpsroxwZ5M
	qgWQag==
X-Google-Smtp-Source: AGHT+IF/GS0+mZiRHKPdFjRYR4nPczi7RTJNOvB33F+iBv1N/jZpN3PGk5i7rC3Y8dBBwD1JyXEFIJfGQ/0/V0o5aQ0=
X-Received: by 2002:a05:6808:21a0:b0:437:e44a:29b7 with SMTP id
 5614622812f47-437e44a2bafmr206189b6e.42.1756384711890; Thu, 28 Aug 2025
 05:38:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828092224.46761-1-linmq006@gmail.com> <11d46e56-b8d9-4776-9969-d3767d8cda41@linux.dev>
In-Reply-To: <11d46e56-b8d9-4776-9969-d3767d8cda41@linux.dev>
From: =?UTF-8?B?5p6X5aaZ5YCp?= <linmq006@gmail.com>
Date: Thu, 28 Aug 2025 20:38:20 +0800
X-Gm-Features: Ac12FXzMEl9C0sc3SP4SKTkgGYa89sXNbErY56BFYrau2jcKn0zmozLXTXzcXTg
Message-ID: <CAH-r-ZH+0rsji1f9eEaVDtG3XcMCD_EnAHAMwr8DuqO4D4Ps=w@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: ti: Prevent divide-by-zero in cpts_calc_mult_shift()
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Grygorii Strashko <grygorii.strashko@ti.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Vadim

Vadim Fedorenko <vadim.fedorenko@linux.dev> =E4=BA=8E2025=E5=B9=B48=E6=9C=
=8828=E6=97=A5=E5=91=A8=E5=9B=9B 20:06=E5=86=99=E9=81=93=EF=BC=9A
>
> On 28/08/2025 10:22, Miaoqian Lin wrote:
> > cpts_calc_mult_shift() has a potential divide-by-zero in this line:
> >
> >          do_div(maxsec, freq);
> >
> > due to the fact that clk_get_rate() can return zero in certain error
> > conditions.
>
> Have you seen this happening in the real environment, or is it just
> analysis of the code? I don't see a reason for these "certain error
> conditions" to happen...

This is from code analysis, not from real environment.
The !CONFIG_HAVE_CLK version of clk_get_rate() returns zero.
With CONFIG_COMPILE_TEST && !CONFIG_HAVE_CLK could have the problem.
This may be theoretical.

