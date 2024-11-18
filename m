Return-Path: <netdev+bounces-145981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83439D183A
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 19:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64A49B22055
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 18:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4AD1E0DFC;
	Mon, 18 Nov 2024 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DM6khD+/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54930126C02;
	Mon, 18 Nov 2024 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731954926; cv=none; b=AW2p9ZzfZyluR369p0aaRy94hhM7hSw/xUCpRIzYF8oaYNdb9PJvhx946cS/mRgMNx86GyT6hJKmDXc8443ZSmok7vMR9lnYrOPWzd0F5F1wNAJXCSI3bm4U+fwZfiLAOm5aKYl6Fs0vk6CFUHR1kqkvbbpG7qBWJIuH1s2oRO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731954926; c=relaxed/simple;
	bh=YBAyZQDeCq6/CCXZbzAL+HTAL2zOtmud1JMUZD40ols=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LN7VCpfNPW+IgV0csW3walAivXfFtn/WbJYiPFQirdPSy5oJnlBQ/7fIOn1uoPZpqLR6uKoWbQCbQ/hCexonF6cPA1GgcLz8Bv6X4Ph932OdWg11KlqaXbZUtsAv3fLsU3/0J6Xis6NE+0DMOx3V7oBceqAWE9/brJte60chkTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DM6khD+/; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-381ee2e10dfso1442016f8f.0;
        Mon, 18 Nov 2024 10:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731954923; x=1732559723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NutJMTMGBpGlg6jc4CAOpY+tUMerhneIWFgqOFsouME=;
        b=DM6khD+/Fincl4UfLHOSQn/e7/Z7LiAwiJPt+A5/7g2DXQzu0PtyreZZI6HnaSZsY/
         aSGLPUlTSeOck4qIodB76l+iiqI7Bqag9Wth/8NaX7Ggoaj/79c3u/q++tWzQXzUEkXT
         WaV0vsRqwdhAmI4K5KbaCpYDVvIYJyUuP2i5fCNPelsafoX83u6TZx6g/3LJU87TANyr
         L/2zYwHjykz7dU87x1/uGg//PgOvagzkmHXfLyQ0qm+wGIn2VeVGrq6ufdNxyfm50IxX
         kgbiBD10cFY/qYfeon5xd7PGcIOgHpf87o6a2vIXNMhEKm1dF1CDkiBKkLQu7iOcAdcR
         EfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731954923; x=1732559723;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NutJMTMGBpGlg6jc4CAOpY+tUMerhneIWFgqOFsouME=;
        b=CFfrgbcm40ib7zYcwvWMZtOmDiDOwKOpZNmKGBPJE6k+FcqwgltC9vtW1F+nJzVfeH
         MOu7FT4k3b/6qI9egeVYchaPua9fm4yMQ0s8MeYlHw/7fmhkiObBl8CGVMgAFrcyrO2T
         K1gSBncZp6OU1FaTPBJB0I+2hlK0xm1q3V7pg8I3LQMjKJHu2nreQihgzo2nKj22KyK+
         c5xkLguveixSAF+1e+pRjHksdk26w5eTGcCmV/2j+1ELmItZbGj/1VZbMkjkiyTkiwws
         b9eKxxPu1vI9xBQUWg8oggm0CTlxk238wvTQ5NObgkI6CDodk4vl+cP2GqvIZZ3+wd6w
         a/LA==
X-Forwarded-Encrypted: i=1; AJvYcCW4iK9GLYC0T0q+dXKb1BFhaJBtKqR5jSSxU0bKsOnXfLRXVdGXe2YDtZu7fsYB/3zynwbA+BwFu854@vger.kernel.org, AJvYcCWbW8qsfoUc2NHCxWSQI2Ripx83H6zuZnFSlaBycFS2QuUkItavbB7wn0WUvRDwSSmiKA+oEH7CGx/4XOIq@vger.kernel.org, AJvYcCX47n5vrtZrQ+XaBY6V4iG2nr9DRai2QhLhABOVBMM2k5rQj/fOC0AOBEKBrGYp0Z+XucAIfLU2@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo1BIWdzF/QXqVoiPGdlXQTxOicaarDZQBbirKxToOelBnjrdt
	2QqwwNbf/hVauqiHH7utspyN7XuvUhC0GQDD/dn5+eN67gV2pYKc
X-Google-Smtp-Source: AGHT+IFjKnwL+BAcS4FvmCWrXf++f05PwJmlO/bTN95oll3IN9DWzzjQsayZ7u1F458KkypWbgNafg==
X-Received: by 2002:a5d:47a4:0:b0:37d:46fa:d1d3 with SMTP id ffacd0b85a97d-38225a931abmr11496928f8f.34.1731954923402;
        Mon, 18 Nov 2024 10:35:23 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae161b5sm13816130f8f.74.2024.11.18.10.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 10:35:22 -0800 (PST)
Message-ID: <673b88ea.5d0a0220.17b04a.bc4b@mx.google.com>
X-Google-Original-Message-ID: <ZzuI5vA-PUWpe5CR@Ansuel-XPS.>
Date: Mon, 18 Nov 2024 19:35:18 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v7 0/4] net: dsa: Add Airoha AN8855 support
References: <20241117132811.67804-1-ansuelsmth@gmail.com>
 <20241118144859.4hwgpxtql5fplcyt@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118144859.4hwgpxtql5fplcyt@skbuf>

On Mon, Nov 18, 2024 at 04:48:59PM +0200, Vladimir Oltean wrote:
> Hi Christian,
> 
> On Sun, Nov 17, 2024 at 02:27:55PM +0100, Christian Marangi wrote:
> > This small series add the initial support for the Airoha AN8855 Switch.
> > 
> > It's a 5 port Gigabit Switch with SGMII/HSGMII upstream port.
> > 
> > This is starting to get in the wild and there are already some router
> > having this switch chip.
> > 
> > It's conceptually similar to mediatek switch but register and bits
> > are different. And there is that massive Hell that is the PCS
> > configuration.
> > Saddly for that part we have absolutely NO documentation currently.
> > 
> > There is this special thing where PHY needs to be calibrated with values
> > from the switch efuse. (the thing have a whole cpu timer and MCU)
> 
> Have you run the scripts in tools/testing/selftests/drivers/net/dsa/?
> Could you post the results?

Any test in particular? I'm working on adding correct support for them
in OpenWrt. Should I expect some to fail?

-- 
	Ansuel

