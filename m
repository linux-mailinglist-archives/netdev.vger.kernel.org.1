Return-Path: <netdev+bounces-96439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8C58C5CB1
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 23:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FD71F227C6
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 21:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196A6181B92;
	Tue, 14 May 2024 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A92yoeoJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A602A1D4
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 21:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715721237; cv=none; b=OdcATqHtXstjS2mnJTQQAbMIxyw/Th/x8VP9xTVp76IUzoo5Fo7gt0LrskSyfiN6Zr2quK528C5m13oXfct/6zHIgjSrIOj2eKFtqq/P4rfRJjtS+2xUXSfD70SCakhhXpU4AhdjSMV2sVXhQN2HkDryD4kF5avnSM2mvCCazQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715721237; c=relaxed/simple;
	bh=cpovCrBNBM+TQokCqv4LUClGqwVBb/IiZ6wJnC78cEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQYQcvysuVAGpICDjzc8xNcxlMLc0k9dQbfUMFJtzWNqFyhf8DccRl87jQoVv0XBO6obsfp5oDM1V+RXpXW6rd7nh6LkhcjREGuHUcw+EYw1x6f7ZMZeU6+NvSeFS3d70Tjz8aBFlxcEbGaZSKiqnr98WhZJ6NC5ajAkKDezvik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A92yoeoJ; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61af74a010aso58212027b3.0
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 14:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715721234; x=1716326034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpovCrBNBM+TQokCqv4LUClGqwVBb/IiZ6wJnC78cEc=;
        b=A92yoeoJT3gBfmk7cSRHc+m58Qjqja7EfEntAgqPev0LLfApn18/mLIh55bvHCYJU+
         hVRo3mnUTgnpXo5Ft593897f/hbKc9YKItc3kDXjc1xwSFO9NtAuJbCaKhbAqC9c7BN5
         Aznxtc8Ho3P8VyFsllCoxBWkWaVDruh3dq7UX9qIdzP+8TohEnwEPNPlVi46gonUIzSB
         1x2LyIhs7mIuG6/2bldSXxjpxhqWFGqRj/MIezOzRjT3A9925VzVvjx3jDLqPL3c+ko2
         8rnNkU91cnq5STqLkcP02PfFnJ8VZleVI+L7oB5ecF0eDGN2N6SaN4gwqsu661EKdjFK
         WgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715721234; x=1716326034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpovCrBNBM+TQokCqv4LUClGqwVBb/IiZ6wJnC78cEc=;
        b=rKo55ume+2JueBYLB1cIpx9IjfZDgedNXEW3ReP4sQ/d+630WVOflF65vI5qS1Y8Iu
         1iq+kYh64pGYRoSdLuqvym2HWCzVJewW3l1YBJKpe9/KWlvSesEWbPWpYthX/QR5Xde2
         +dMzh2HT7CQe8x4rB3f4RnlG+XR8uzZoFhiZXUzHURaHzmcNy+2ojLDIgrf+0RkkBrWH
         DqX93gH/eFXOi3x0BdMWIxo+PUH7I88TGhCFrNpgaajsKXAn7SGB/bTfmpumkHxfpT7U
         jr8JFg3gX8pTO+5p3m4jcSu34kvGZn4Apme/5qlkw1WwmVqfZ4nmTaqoaSPZTP/5mqI1
         gKDA==
X-Forwarded-Encrypted: i=1; AJvYcCUkaCQlBw4RW2aMhFEa2ho366nsFa7xju2OkeMtHoIkv1UhUlAmealos0D87sXTFXbCUUzJ+Cnywt6nZL8QsHYBPQ7hh7WG
X-Gm-Message-State: AOJu0YxE+s8qNqIWVzE2dxNTDfxYCUUdXv9emNw14z8btqhq+74HLBOf
	bNqxGgzgYNSD+YAgkKVLTz/jvMzd0By6fQOw1vgWESc1EpKdAn0LI7/oj7nk1vTX+WWtAP7mJnj
	iHqSsY4jwWSgdD861tqzUqeOtPCJCCLeuEOhbEw==
X-Google-Smtp-Source: AGHT+IGatPlnnrbmpkj4lBwfXYoCnxy+BkRyekhsrq16sblxiMenQPwLCmLFqWq0nD7XKpne5zqouooFWUjbCUzdRQc=
X-Received: by 2002:a0d:ca01:0:b0:618:8bc1:ad9f with SMTP id
 00721157ae682-622affa82c6mr136648667b3.13.1715721234224; Tue, 14 May 2024
 14:13:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org>
 <20240513-gemini-ethernet-fix-tso-v3-5-b442540cc140@linaro.org>
 <9d7d7e8b-8838-410b-a694-2f2da21602c1@lunn.ch> <CACRpkdZnhH=OvivSK0=e_NUEB3M--v+MawjuZZOPNoRCWn1NhA@mail.gmail.com>
 <c086a2e5-87e7-4926-bf80-c0b406c2c8e9@lunn.ch>
In-Reply-To: <c086a2e5-87e7-4926-bf80-c0b406c2c8e9@lunn.ch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 May 2024 23:13:43 +0200
Message-ID: <CACRpkdanJ+qaJNLEfSuOe6ricjOQ9+KyRdbYueK176ASh0t6BQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/5] net: ethernet: cortina: Implement .set_pauseparam()
To: Andrew Lunn <andrew@lunn.ch>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 4:32=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
> On Tue, May 14, 2024 at 10:55:18AM +0200, Linus Walleij wrote:

> > I don't know if I don't understand the flow of code here...
> >
> > The Datasheet says that these registers shall be programmed to
> > match what is set up in the PHY.
>
> I expect the registers should match what the PHY has negotiated, not
> what it is advertising. So i would expect to see
> gmac_set_flow_control() only in the adjust link callback once
> negotiation has completed.

I get it, you are right of course. I'll send a new iteration dropping
this setting after net-next opens again in two weeks. (also split
off these three patches separately.)

Yours,
Linus Walleij

