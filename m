Return-Path: <netdev+bounces-92017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A1F8B4E6A
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 00:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F48BB2136A
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 22:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19307B676;
	Sun, 28 Apr 2024 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="aa+Nj/J2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680433F8EA
	for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341646; cv=none; b=eiaj3O8vy6CVjRjiNfVb5W1vsit7MLVahz9GODR84y/RihYRtmF5Ehbj4P2w2JzRAf2znnhdFJPQXAvDDdqEX+nwLSk/FnV9OVCPEmBpiBK8hkbpH6XBSpNe14K6KhfdyqYDnGgK7iBaCN7dkvO/XFjCk8slzBmsXBcu7PaMM1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341646; c=relaxed/simple;
	bh=VKa5DRK+rov4mOndYM37s5U81Iupu8JcxyUVcg4m+F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVcJOuC+sr/jNh7nE2yKOTSUVJ6vNnPAZhvak6BAgFpdQVp2tB2DZFGg1KrrSeFjOgsw5LbfuVZZ6a3PVwNQt6JMvanctMURimXi2ynUEyUJnhbawnSADl6UmT4xEvHYaDl1/8GPzocYb9gS3G4D4YGc+33tthPZWfVW+MI5Nj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=aa+Nj/J2; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51dc5c0ffdbso255706e87.2
        for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 15:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1714341642; x=1714946442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AWJwQ79KFPwoTQT9Ru/EFPzNPVyElzHVufYRANALvzk=;
        b=aa+Nj/J2tKWrJ7FIFcFte6Vv5kEx/q5fJg4Jv9CmKXn3aSn7maYnaF/1G0xUWylXEP
         UG4mSHUMzp8QDsA+EICzuN/mRBtXPT/0XO11p0jhaDmqTrjmfn1wICdOoRMlaSLmQ4S5
         z8z3qgOK4WnRisytaA7KwtN1Ig7ildDr7p2l9ZJArWBlrNcL+fRjjCWcyhclGomoEE6O
         FZusTxJFN6VbtqaVLFMBVlPZifDi/IGOEpuUPJUkLnqzVKfKF7uzJTmZofTm3VnStMn3
         UVeQG+tmqTh/VaZIqifel++RV0T3CADBwVk7UIl6gci0onmQifzouChIQuUuJlvG4s30
         l3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714341642; x=1714946442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWJwQ79KFPwoTQT9Ru/EFPzNPVyElzHVufYRANALvzk=;
        b=Unq7XJDJBnwFpk8YLpp/BRBuobiochOVAaT/rLZ8Uvw2wOQTfyehX5fBzmtkfvjumg
         qGSXkwA5H85C3j2O+jwNDhR4LNIt0fMyDsop49oWE8MErhQiQ9/ZpbCQ7MxaztW0x27s
         q4RkwY0rCoYtu6cRilE9N3ioBIDobO3lw8qOTSm+UGZb0Ud9MnrQrpiHNxzQqiK8VKEo
         XwUlYYL3+moqc3J5TBRbS811EWPDrsv1SkKRl4RkhaQgq3vfYMl7O6akWxP+HSvJ3yhU
         /6ci9iRnN0Sv5JGKomaUzCSWg82zXfQuMLJL1KJ7j7mQfey5tp9AKniMmI9zjixAXpF1
         s5Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUSeG4dQ9E3uJzDRLsSue4x5+WuE5YV9Za+XxoFxC/4pA2z0iPd2XkG+KeSY7AWmkNfmJaLJgrTLZV2G6ozRPf0oSdVsBUi
X-Gm-Message-State: AOJu0Ywx/Xje9QTl1aSZgxxt8oZMwP+WJ7cBYqCzFzqsM32VX3Cmgn2l
	pFJ6V56pzwwgf312FSrfWNux8O+C5khqf8m8D5qIctAJFrJG2FkG4UggtCKJWt4=
X-Google-Smtp-Source: AGHT+IH+pw1RUW60bhQZcyaY+b3pXcFRtK54hYisJiG7BkigT+/etaKESEap9CmgjFFnDFuPPpiVPQ==
X-Received: by 2002:a05:6512:ba2:b0:516:d448:b42a with SMTP id b34-20020a0565120ba200b00516d448b42amr6329943lfv.26.1714341642522;
        Sun, 28 Apr 2024 15:00:42 -0700 (PDT)
Received: from builder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id j21-20020a056512399500b0051ab68bbb63sm3547485lfu.56.2024.04.28.15.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 15:00:42 -0700 (PDT)
Date: Mon, 29 Apr 2024 00:00:40 +0200
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
Message-ID: <Zi7HCBmpznyQbE_u@builder>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
 <Zi1Tang5RQMmEFdx@builder>
 <50b7cb69-61c0-45a2-9a48-4160b2d1e24c@lunn.ch>
 <Zi1uIjoIgzir1cwA@builder>
 <8e06c952-b5ab-4591-8ab0-7aebf612a67e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e06c952-b5ab-4591-8ab0-7aebf612a67e@lunn.ch>

On Sun, Apr 28, 2024 at 04:25:28PM +0200, Andrew Lunn wrote:
> > I agree with your assesment, the phy won't reset itself, but maybe we
> > could add some comment doc about not adding it for the lan8670,
> > so no one trips over that in the future.
> 
> In the PHY driver, you can provide your own .soft_reset handler. It
> could return -EOPNOTSUPP, or -EINVAL. Maybe check the data sheets for
> the standalone devices supported by the driver. Can you limit this to
> just the TC6 PHY?
> 

Gotcha, I think that should be pretty easy to handle then. The
microchip_t1s.c module handles two phy families 
* lan865x - baked in
* lan867x - standalone 

I need to do some thinking and get a bit more oriented. But pretty sure
there is a simple path for this.

R

