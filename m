Return-Path: <netdev+bounces-246197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 962A7CE585D
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 23:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F9483004F75
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 22:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D8B29AAF7;
	Sun, 28 Dec 2025 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrvU2ZKk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FDA274B44
	for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 22:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766962210; cv=none; b=UP94RVasQSIwthg77gsGTqd1ocXwEARAkIMjW6y6D0wedTZHbu3oa5OWspkaygJwOSWT37ohtYuiZISxgZZTzsJVSRvhSd6zp293LQo99PyCWpLUpSWwc6C3YfxReDt3+pSiZhEcbC7MhmIrlgpl2+maUutlYYk6P5kYS5NDgSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766962210; c=relaxed/simple;
	bh=9KgZlOWCyyz97q21E9W8EANe41Dc0IJ33MJtTZbxqmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kht8GQ7JUdsROZSYJmsh7YCd8hKLY71UwvZsHDLmiYcUOx3eURQIaAGbTH1ruCkvxZ7EKf91yj5bihxjFp1E2HDZTtvseJTHz5lI8fWnmlRa55ogwL7mHJNUrs6qgH3W9TowMrKjY4jj21JyOn08MPwL8d2OZIl9KYVgFqtdz2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrvU2ZKk; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-430f57cd471so4236823f8f.0
        for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 14:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766962207; x=1767567007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLa9rIWMcGJ8cd3NrQlUFNZ6zmYa0bxNCj5XPgKm3rs=;
        b=WrvU2ZKkHWaMlv7oRkd+S+QEtyC1YuhJKXO7LueTJvIn//5dwNhQ4G8JtP2icFhnPx
         Gz4/ji3vdh/OTs91Ww+RboZbn9yTv0bdQCUtdEDeffvUG6mJAZpUywRn4THuOIsQlWku
         wSpjJgwH3siDX0WafPL4SJFBMeaFj93tfsHooD4ra27hvT2UZdYtr76tks1s+1EPIGMe
         /5Y8CtNk5G84L5xS21viUSTYS5jyXajv95Tj2typ46M9gB6LPYA74QkiWXlR6ldxVKUi
         diEpWgSyO+pI88uWaTW6oH1XBjTw3A4LpcaBn6bb8DMRux2uTTAJ2YTtbyLO7x1a8Iob
         l4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766962207; x=1767567007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dLa9rIWMcGJ8cd3NrQlUFNZ6zmYa0bxNCj5XPgKm3rs=;
        b=QP2MatNiz1x19KcKuHyRrrYxE8diuPMJyl5/11cUPYgnjCUWKoOoH3RJcJF8IujkPe
         FycmW6ci4bD7BZnUojC5VNYuu0gmpIlAYUzmtUG3COICYQZifhyxtO03q4wRSqgxwv/Z
         TKEysjdp/jMpjEpbCUpuxvC0TmEH3+ONewdpnz0mIU9f4HC35Q9VZ5SyAQ3XeuoTPXHd
         RovELXqm75C7oR9nMsKPRLFCmykJwY7zQ339yKtqt5kGpN5fIZGZpJMxMwOyV4ql3Mpy
         7Vyfj/Dd3VSrm95JN8WoUHKaO8InUwHt5LF2A8FkX8uAg9Ewt82ho1BGwUstp6zP8gF2
         eIxg==
X-Forwarded-Encrypted: i=1; AJvYcCXbWxU85no18BP7TJZIjF0f5ntsr29bP8emchdgZO19uTIHj85a51lDVuqSwxs/SnUJB6mtFCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkvmIjLAi9RdIA+aWE/87i9DSLgA1g645v4Hwj+BTMqK08WYmp
	Vrx5RSe+IR4bM1si6lHO+PwY3WPEGdx36thYS+rzXomSVEDZ+ZRYKdSR
X-Gm-Gg: AY/fxX4S/Z8kr3DTVjAc8wEx3PSf7mGG2OjlQ+grAR5rHpbrV6lNfZ5PKu89eSUKxoP
	yVlR1ZnshJNnLlmjndCocXlgc9L5H/kQ8omTTUHljuGjXrm88Mv0yZOmVREon4d68TwmfwEBB2+
	BN25+WL4C6muLlrqQG6NuZgsPvOcFG0FtAoliGMT6aKr9TvG2GtyDHEBfki4ua8iZXkSPONJk0o
	yFREEr/T5ze2HQy24KD0wwPZn87s4t+ZKhq+2T66GYYzYIw8UIn00cAPML/BNwYhC6SMMEm7r4F
	7aqkcwm8ekIlA7qsTyY1vnNv7fYk2C5xOfaN8iOrgRM9bQXQdj0jYGweUF8t7ztj1haZj43Wc+B
	Qav4DrJxAYjLStlmZOTrlmBCdzj0pKR9A+7FmrMg5cxfUJMsQnt3M8fAi93h5ocpH46l9ng15QA
	0zrRAaAnJk6NhwhK3/qCOQ7dgI6gjrxGk1e4ds2qbsQPZCbBsaJFh9
X-Google-Smtp-Source: AGHT+IGDmQFJXpTex84Sjvl3OcjyzaSsuGGpBNcSV45EAoewFsb1Yr42jHw1dToXppS6Ot5xXmfiDQ==
X-Received: by 2002:adf:f70b:0:b0:432:5c43:64 with SMTP id ffacd0b85a97d-4325c4302c7mr23626302f8f.41.1766962206674;
        Sun, 28 Dec 2025 14:50:06 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab33f5sm59078509f8f.41.2025.12.28.14.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 14:50:06 -0800 (PST)
Date: Sun, 28 Dec 2025 22:50:04 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Geert Uytterhoeven
 <geert+renesas@glider.be>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Crt Mori <cmo@melexis.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Luo Jie <quic_luoj@quicinc.com>, Peter
 Zijlstra <peterz@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Andreas Noever
 <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v2 08/16] bitfield: Simplify __BF_FIELD_CHECK_REG()
Message-ID: <20251228225004.69a6972f@pumpkin>
In-Reply-To: <aVF8uQxjz9trZAHY@smile.fi.intel.com>
References: <20251212193721.740055-1-david.laight.linux@gmail.com>
	<20251212193721.740055-9-david.laight.linux@gmail.com>
	<20251217102618.0000465f@huawei.com>
	<20251217223155.52249236@pumpkin>
	<aVF8uQxjz9trZAHY@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Dec 2025 20:53:45 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Dec 17, 2025 at 10:31:55PM +0000, David Laight wrote:
> > On Wed, 17 Dec 2025 10:26:18 +0000
> > Jonathan Cameron <jonathan.cameron@huawei.com> wrote:  
> > > On Fri, 12 Dec 2025 19:37:13 +0000
> > > david.laight.linux@gmail.com wrote:  
> 
> ...
> 
> > > > +	BUILD_BUG_ON_MSG((mask) + 0U + 0UL + 0ULL >			\
> > > > +			 ~0ULL >> (64 - 8 * sizeof (reg)),		\    
> > > 
> > > Trivial.  sizeof(reg) is much more comment syntax in kernel code.  
> >                                      (common)
> > 
> > Hmm. sizeof is an operator not a function.
> > Its argument is either a variable/expression or a bracketed type
> > (I don't usually put variables in brackets).
> > So 'sizeof(reg)' is nearly as bad as 'return(reg)'.  
> 
> Yet, it's a style used de facto in the Linux kernel. I am with Jonathan on this.

Not hard to change :-)

There is a more interesting question as to whether that check is
needed at all?
It is only really the sanity checks (and the fact that __builtin_ffs() is
sub-optimal) that stop the functions being 'reasonable' for non-constant
values.

	David

