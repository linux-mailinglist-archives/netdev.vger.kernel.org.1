Return-Path: <netdev+bounces-227034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC4FBA75B4
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 19:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F35A3B8E07
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 17:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5B5254841;
	Sun, 28 Sep 2025 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb0zuWnG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C4D253932
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759081685; cv=none; b=jCsSfLHCScn6qLq/DTUK6QRTX92CyduFLFA4bx0nnwrNvovQY2Ud/XdAikk2FmXwLrDjmN7J5nMFcJpaGdTM9MDu9VthBK/kHFgGh96jShS0XNFLbk366FZQjxBxP0b+2QN1DDnu7QNgqBrqCHnyGqFpvC847+tSt6bwptmQZBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759081685; c=relaxed/simple;
	bh=bb144XaT3ozq0w1qVMTiSOGlsjiwTNHYJ14plQdks2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqqu/H04to7LgibgJbF5EC6XWEFaXvEDnoeHkTqr8D2JctpPYw5V2JYEwnCORjdd7ej2NylS9xQjFEWwPGvWrBkzkg82fEq+S882qMgxuNMcDRT4nFkg2ILSvxzsPUtZCNXDMvZe/DPV68BVlXl54niof9YbjPxycxAR6AULKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qb0zuWnG; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b5526b7c54eso2359160a12.0
        for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 10:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759081682; x=1759686482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bb144XaT3ozq0w1qVMTiSOGlsjiwTNHYJ14plQdks2w=;
        b=Qb0zuWnG7QsrX/EU9TbJnVXw4X5o8e31mNf+on9sXdE1YI5XWKrRTWkEjS7IM+9RVW
         uechN8gGX5DTdFPKQjG+mzpbae0lYH+ScjU7crsVuW5yOZ0RMpM30ev9cYR6cmj8AfoF
         ywfs/kfzrjRChzNR4vaRfotI9XMCcZ/zSTWccbByOnWDZUNPE/QDzvpcc3jTIwAPHVFt
         nzGcOwB3vIZCZNmAMZ2xS+nNJ0kuD7ZbRW6f77tLn8vBiqqWkE55buYvHvRa2jsn3BFP
         QS9h3/i3xvQ7kr+uhwC8wqFD5mItEKAE+JW9WogderX7yim21ES9H1W6rLcPK5rDW8TR
         prcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759081682; x=1759686482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bb144XaT3ozq0w1qVMTiSOGlsjiwTNHYJ14plQdks2w=;
        b=wWd2m44qMcztavziFn6Z1Kj+XXDy5qw86WN/Mr0FSh1WfbKw7m8k1Y9+4HUP5vuzLw
         oacxEBKpTNjPUMrO5MNbcOgSlU0KfCQcySAMvzk8LOGi2TlvArgLAZ/B34yhNHi6P4Kd
         SKA8pgs7cMfhP9OvXz6kKXkwoxEv60wsKsqyvtlnhWTzvw4QZXnVr8MeeOQhzLROskpO
         RzoOYxFDDlCqfeAQ+O21yabOAsQFFy92yQp8Sm6BaMmonp+/2RAUPqAOcz2aprDcjKJO
         rZ6g89B2vwCyIZC0aZBY33NFZ2rnSmOjbdxxv19W7tuPiA7vIiJQBvnyMHr4KmhJM+HP
         USXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtCk3djYXrfi9xDvq/h3gL1cVXj7GHe3wJnqF8Skfrajm8zLA66msgRNoLHcUDYqFROM6gFyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD623LIw1mrp11V+WcdFQn4VZKPs9yjkwWxA2PFThYfCuUfvxq
	kkhEm6siX3DLBIFl0DUX69Vdt47DfFen3pS5EBf1nJ54+JwRRwDIDa/kM4P1DEvwcn8OvK5l26z
	Z26dYKIfbnMIHT+X4qxcybVo4DWctfcQ=
X-Gm-Gg: ASbGnctB6uamVg+2duAxOabWHdNf0FUUOWgOaFfIhk7jhiVd/6xEzG3LWYgQPgsetLl
	LWsBRsNtYY0rNXNQXm8KwQOOrz1Ls+ytgGfpCZvUMN7WvFlx5gXREcA7MJBswfFNbdFKS6/Vp2k
	/DtMEbJlt6rDLZgnARHQ9/dplmF24AsxddvQqC9LZIWbrkBO4lmqgG5jqre202BI98gsbI/K0vq
	EWLs5I6KO59Hqu16wQ=
X-Google-Smtp-Source: AGHT+IGIhTRX0vPWXRnKGbM7/t9PfWgMfG3icRhXm/bikRRYDgSLLR3zWm4hL7da1xUZ+6JNLVBVdbp7N1oWnUBqBMY=
X-Received: by 2002:a17:902:cf0d:b0:27d:69bd:cc65 with SMTP id
 d9443c01a7336-27ed4a96a83mr141161955ad.45.1759081681919; Sun, 28 Sep 2025
 10:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOprWosSvBmORh9NKk-uxoWZpD6zdnF=dODS-uxVnTDjmofL6g@mail.gmail.com>
 <20250919-lurking-agama-of-genius-96b832-mkl@pengutronix.de>
 <CAOprWott046xznChj7JBNmVw3Z65uOC1_bqTbVB=LA+YBw7TTQ@mail.gmail.com>
 <20250922-eccentric-rustling-gorilla-d2606f-mkl@pengutronix.de> <CAOprWoucfBm_BZOwU+qzo3YrpDE+f-x4YKNDS6phtOD2hvjsGg@mail.gmail.com>
In-Reply-To: <CAOprWoucfBm_BZOwU+qzo3YrpDE+f-x4YKNDS6phtOD2hvjsGg@mail.gmail.com>
From: Alexander Shiyan <eagle.alexander923@gmail.com>
Date: Sun, 28 Sep 2025 20:47:49 +0300
X-Gm-Features: AS18NWDPKklTiLrxKFeYvofRAgeM8OwBQfBPUfJA357z4XaPxxHtrQTv3DSxvMw
Message-ID: <CAP1tNvTD2uhK79VB_PT0JByv_VVy245WH-3a1ZaG1-Khw5_vaw@mail.gmail.com>
Subject: Re: Possible race condition of the rockchip_canfd driver
To: Andrea Daoud <andreadaoud6@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello.

> > > Could you please let me know how to check whether my RK3568 is v2 or v3?
> >
> > Alexander Shiyan (Cc'ed) reads the information from an nvmem cell:
> >
> > | https://github.com/MacroGroup/barebox/blob/macro/arch/arm/boards/diasom-rk3568/board.c#L239-L257
> >
> > The idea is to fixup the device tree in the bootloader depending on the
> > SoC revision, so that the CAN driver uses only the needed workarounds.
> >
>
> Thanks, it is not easy to correlate this because I am currently not using
> barebox. I'll try this later.

I think this can be done from the userspace.
Build the driver as a module, get the SoC version, then modprobe it
with an alias for the desired version.

