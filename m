Return-Path: <netdev+bounces-91951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA438B4857
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 23:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71101F220BC
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 21:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E26145FED;
	Sat, 27 Apr 2024 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="tCohlbUg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DDF145B38
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714253351; cv=none; b=OFdDy5eh22AV3nzI7P3xswp6MBkJiNjckbTWeHr/UTXZ2zz992ePDQrI7rQXTE1cHl0DZ5HnqWjFZ1H9HNG+ShlXHkNwI5tQ5wq8POomw5dxr4qkJ370tc9SFm8sazahrZyN69fCZdFYowanaeR4SQjuGaD2bry5YFbMisKKr/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714253351; c=relaxed/simple;
	bh=GEV6jAmDKKMobOcFk+1M3UgSQV/WXqplMVFKtidQPOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E09GbSvkTsVY0UTLX22194LwiNa27dOrI6jHmBHcvPAqXU7DgFy4wtK9NzA1RFZ6DxBYWS8JasCWIW/nC3kB3jjAP1GYjJmi9seg/BYhQ+KzecD0WQ7qlgma0AkwFkS9NVH0YaJs8BftAQBmJrp2RwGdwkHLB8qD13xdHpCAP6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=tCohlbUg; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51b09c3a111so4665552e87.1
        for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 14:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1714253348; x=1714858148; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=soM18mKSg6qprHqdfFnQnDZJvK6yfjFnFHmEdRlY9mI=;
        b=tCohlbUg3rlv7/u/HPy2IwuV+WpSJxeC2jHZjutZDAI3YkZMxOO2EAD2xrKoo4f2nH
         fmiqwasnosvsymWDU1k6Oy/JtqMepGaxF9fSSy+KzWSAA8Eb/hLxpoisBzgqLTaKri9l
         fh5lCsAoyzewj7+uSZBqdIDMSXjJvjjoIP6jlDgZkSXIxZmr1+XxhlEZFBSbMmo3figJ
         Qrft1QysWB3seL6QP44sTG/EmQAzWLHW7woqY674ImiFIh2Oi0nrQ9JS3cCjKZH+64et
         q/Kr0vkYw20IBCx2Ogu+Ae82i8h4gF7kzMsmngnPCh8f8frAbZ9DEnumYd+IZcxRHj+A
         BBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714253348; x=1714858148;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=soM18mKSg6qprHqdfFnQnDZJvK6yfjFnFHmEdRlY9mI=;
        b=Nb6vCp3+i9QsqVJy5qXIwOTF99AGKpZGqoITnOcrNOiEciSStKG5PY14BURiW16Rim
         EOoJBRLMDvVSX6JExTBcqBOq91q9q1Dg8j4tJ6OPxsWIJngWocASq31Nj7CnAQEG9ZsM
         dYx/JF4f6kwAJnrL41FMp2hqhdfzp2VKjjzrY7wqIAifCdyr4rtGkYqXAvnDTvdyUl14
         I/npqyVD5is0eUOGxWUMXsuKNx3RkYmAHR65T6lysgBGhptpZlF6gXefXaKNyg1x2Qet
         CmeoThUHJ1OpVRKf7Gkfa49Vvkahs3n/tl9A7aKN0Vj7pCW/U3McvudHnfQ7GZVt2u0c
         J7Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXfkuoekvartXLAN1sqYwB/eUPNvcNV8BJ8NqceqdzQeYPJiOzYtkEk0VcFp6WWBYF1tjabFco8o7PCC6hdSh7ZxpEixU0L
X-Gm-Message-State: AOJu0YxGxiEi2/uop7R3/7IozyZV809JxYxcJGtNmzNQ9OABkDDSZQE9
	EKIlXdJhRX8XnfESknp7OAV5zHIUymwQQFLlw2wN6ssSH9+ng+27yKeWkfJQT4s=
X-Google-Smtp-Source: AGHT+IESPxsOdn+PAC7uPe8nPrmb8e4czzEHLz2mU4Y3/8jxRUZbDg+lOhef7IoXtvfDyakB7i9Wug==
X-Received: by 2002:a05:6512:3a91:b0:51d:c1b:1708 with SMTP id q17-20020a0565123a9100b0051d0c1b1708mr2724064lfu.31.1714253347934;
        Sat, 27 Apr 2024 14:29:07 -0700 (PDT)
Received: from builder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id e6-20020ac24e06000000b005191c01f505sm3541212lfr.5.2024.04.27.14.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 14:29:07 -0700 (PDT)
Date: Sat, 27 Apr 2024 23:29:06 +0200
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Message-ID: <Zi1uIjoIgzir1cwA@builder>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
 <Zi1Tang5RQMmEFdx@builder>
 <50b7cb69-61c0-45a2-9a48-4160b2d1e24c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50b7cb69-61c0-45a2-9a48-4160b2d1e24c@lunn.ch>

On Sat, Apr 27, 2024 at 10:58:07PM +0200, Andrew Lunn wrote:
> On Sat, Apr 27, 2024 at 09:35:06PM +0200, Ramón Nordin Rodriguez wrote:
> > I'm running a dual lan8650 setup, neither IC passed the sw reset in the
> > oa_tc.c module, I need to pull the reset pin low to reset the pin before
> > the rest of the init stuff happens.
> > 
> > The datasheet recommends not doing a sw reset, excerpt from section
> > 4.1.1.3 Software Reset
> > "Note: The SW_RESET bit of the Clause 22 Basic Control register will reset only the internal PHY, not
> > the entire device. This PHY only reset is not recommended for use. If such a reset is detected, by
> > reading the RESETC bit of the STS2 register, reset the entire device."
> 
> That is not so good. The PHY driver does not know the PHY is embedded
> within another device. It has no idea of RESETC bit in STS2. Looking
> at the phy driver, i don't actually seeing it using
> genphy_soft_reset(). Do you see a code path where this could actually
> be an issue?
> 

I agree with your assesment, the phy won't reset itself, but maybe we
could add some comment doc about not adding it for the lan8670,
so no one trips over that in the future.
Though the phy does not have to be baked with the lan8650 mac, so that
might be tricky to cover all future bases there. But for now I don't
think it matters.

Then regarding doing the soft reset in the oa_tc6 module, I'm not sure
that it matters, since it seems to work fine for me for as long as I do
the hw reset first.
But I can submit a suggestion for how to deal with reset-quirks if we
want to have the soft reset optional.

I'll run a test with and without the soft reset and see if I can spot
any change in behaviour.

Let me know if I missed any nuance in your question.

> Supporting a hardware reset does however make sense. It would be best
> if you submitted a proper clean patch. It can be added to the end of
> this series, keeping you as author.
> 

I'd be happy to. Getting late in scandinavia so I'll clean it up and
submit tomorrow.

R

