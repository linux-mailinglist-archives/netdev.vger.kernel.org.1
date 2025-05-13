Return-Path: <netdev+bounces-190236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84158AB5D27
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E863B3377
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 19:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0A62BF965;
	Tue, 13 May 2025 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVe7CnqG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3592BEC2E;
	Tue, 13 May 2025 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747164422; cv=none; b=XXPOzv8yMijf5aRVCcTJ/yEnMmNXBGXJGQUsSamJBh4wqNrOCOM3nz3daib9eIehbgyoZMqWPu+MSmlh4MOeNOtvyf08Edwv7AybVyV8Art8XQAg7T4cYcw6pDlQwehGYEFWL9Kmg2ojA93YvtCTIAZFUMwdAVnCzXnn1+OUpJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747164422; c=relaxed/simple;
	bh=sxa/prH5hNdWqoNn9frg0ARcUx+mIrBF2G1dxXjD2j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvmssS9Wsn706Uv1uoeEa5VhQDWu0wzgZgwY/k4rpUEKUYj299gZun7KaaLlI/OwIl3WdVSGA40QmyQx2GMrOjQTw9+2L3mQj+vfr55SF3MNbSGBfTmmMkM9m8EXgSx0m8Mp5T/piZs7aNTqqkt4U6abakgFhuy6zASQ786Pao0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVe7CnqG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a0b291093fso133240f8f.0;
        Tue, 13 May 2025 12:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747164419; x=1747769219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OE9JQzi+/SgWFaUtA3nS2GLJcK6WZU2GyasTp+Ernb0=;
        b=CVe7CnqG+uYFZOIt9gnxMiTgyTOn5+8jJmXqf/63Zc5mBkmWGe2pjS8AkVunaZyrK2
         ZVODN5xFr5Nmfgb1AQoUAgFqnn+OGnTaQ7vln0D2b2ba0Rn8IcCSYW6LgkvsX+4OHh3n
         ZGrJh6ARQiZYGZysUgFt2/MSvyKezLFoqzupz7Z3F4Mj7Ryw16ne5kahgLHpm9RYCURy
         G4Q0A6lRJdG0Il+Qg+IIPkW4fmj4gC0B7zkD2SnuhS/4peaslSKZg994gd9JTLVfbhJP
         CxOPIYqyW3qW2IFaZ4FUooGJQiNJEFqz60Qy14st+844Ws4UFFkhR5PJWghGgFrqj/g/
         LrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747164419; x=1747769219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OE9JQzi+/SgWFaUtA3nS2GLJcK6WZU2GyasTp+Ernb0=;
        b=ZTEzCPnc+mx7m6qInBxaDrZpaZF9GGJl6ITLYK6Ak+YnysSotwwIKI6AaXCj/XBMAx
         CXVsKD3HeKtuZuOJ+zHBgKDmvSR6NjnaJG0j3sI50bXm4RytgDxHk5aIyVK+JkYV7Ivi
         xA5YiJe5URJsqbRY6LBzd1r9LJPUGsXAUnesVFCeZRNes6iG6fJ1Xj4qtTCuG0RVSofG
         V34SuXyLYuvzeBaNRF98Ji/DNXTNl/vOj/8atLwqHOm9D6MtLLE2FoLtsgnBPl8/7rt7
         mwGxhY4nHaH/cGvTy9ZysWHOnJWINhERE+o8bdlnRM6M7/AapO60aulvZmaaP2uOY+vk
         vp5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8LAVi8JSGIQACqvL/Q00ymEESISr/o6UF2vdHak/rS5YqEujxOeTPqUV5Cnbou6deaZXJR8mANH2fzBY=@vger.kernel.org, AJvYcCWSKFAAhWS8hT8TguZD9qTZHcjKgq/WNoTe42HnCzlJNbCaYSDqAi1O9PcG+BKZ5UqBw5VZYqqy@vger.kernel.org
X-Gm-Message-State: AOJu0YwkqTaJSOifiDllRZTU/RURzALg23rjQyc2Y3aPCRN4SYiKTY5V
	M/Xbj7J9Ho1uHkSM9RSEpnBV6TENx6/d/acWdFKN11kvtDhyjL5uloZU4h/n+mRcKepApCNOA6h
	mMxF6bJCh1y/Aj5nlJzYEz/gP//TGITvwtko=
X-Gm-Gg: ASbGncvhiQRQSMEwYzCeqDXVnlurT/+gjtbgqAr8US7j+5NvZXP9Q1p0YM4l4Krn0vt
	nXooYgrV5Xb6bwBmBW2oOmNi/JszKrbgbb3CSpR2h9ejZ5zQJur0hcTqs4J+bCKAg5PK4C5E+as
	jZMbtfLsawFwf97R5N6YvM9hiU9FGLBJcRulyNWoECyErSE9uiYU0iDve7XEqGMa662qMyFjWVG
	IIp4g==
X-Google-Smtp-Source: AGHT+IGRCMWiPYMni2MtmodQU1dny8pskt5D+U0g7V8aWc5CsS7j8NkOpaZOIgzjx4i26vlsiCp1tjoCB0AR5Io1bLQ=
X-Received: by 2002:a05:6000:228a:b0:3a0:b735:2ee6 with SMTP id
 ffacd0b85a97d-3a348dba36amr746979f8f.20.1747164418918; Tue, 13 May 2025
 12:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512101521.1350-1-zakkemble@gmail.com> <20250513094501.GX3339421@horms.kernel.org>
In-Reply-To: <20250513094501.GX3339421@horms.kernel.org>
From: Zak Kemble <zakkemble@gmail.com>
Date: Tue, 13 May 2025 20:26:47 +0100
X-Gm-Features: AX0GCFvhtl1MTrCbJ0tOViZBQ_pjwZtMZHzJqcpbLCptQgjfF2Xoqq26Dj7ciX8
Message-ID: <CAA+QEuT0tPd0Qxjy0LP2zXhRhAe_bRv5omFPaFdbHVzoBAO-Yw@mail.gmail.com>
Subject: Re: [PATCH v2] net: bcmgenet: tidy up stats, expose more stats in ethtool
To: Simon Horman <horms@kernel.org>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey Simon, sorry I'm still figuring out mailing lists lol. This v2 was
submitted after the kernel test bot had replied about a warning, but
before anyone else had a chance to reply. Latest version is here
https://lore.kernel.org/all/20250513144107.1989-1-zakkemble@gmail.com/

On Tue, 13 May 2025 at 10:45, Simon Horman <horms@kernel.org> wrote:
>
> On Mon, May 12, 2025 at 11:15:20AM +0100, Zak Kemble wrote:
> > This patch exposes more statistics counters in ethtool and tidies up the
> > counters so that they are all per-queue. The netdev counters are now only
> > updated synchronously in bcmgenet_get_stats instead of a mix of sync/async
> > throughout the driver. Hardware discarded packets are now counted in their
> > own missed stat instead of being lumped in with general errors.
> >
> > Changes in v2:
> > - Remove unused variable
> > - Link to v1: https://lore.kernel.org/all/20250511214037.2805-1-zakkemble%40gmail.com
>
> Hi Zak,
>
> nit: These days it is preferred to put Changes information, such as the
>      above, below the scissors ("---"). That way it is available to
>      reviewers (thanks!) and will appear in mailing list archives and so
>      on. But is omitted in git history as the commit message is
>      truncated at the scissors.
>
> >
> > Signed-off-by: Zak Kemble <zakkemble@gmail.com>
>
> This does not appear to address the review of Andrew and Florian of v1.
> I think the way forwards is to engage with them on the preferred way
> forwards. Or somehow note that you have done so.
>
> --
> pw-bot: changes-requested

