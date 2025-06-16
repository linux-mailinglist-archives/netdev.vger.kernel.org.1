Return-Path: <netdev+bounces-198124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CF3ADB553
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 703B57AB087
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EC420A5EA;
	Mon, 16 Jun 2025 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="2b2v7ODu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF1F264634
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087544; cv=none; b=UrEwXLcZeGkQ5xaQX/1J9Q+cHV1xTqfKN94/EKd3pygSgnyxUoy82M6lSxTI0305XE4a4PhacaYL0fNHUk10GisCZKnogFO4NBH9l/FGwBwAHtTXqrtxKYxOubcb00SLi6VMt1eQhjjkU2tbF5dUZPhAIQ+3ivNioE8YQSDDdSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087544; c=relaxed/simple;
	bh=oXuJUB4ChUgrbm7h9taNhnfJzydKsNCTX8MW/YGh//k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNRCHaaZ5Nm4Nf5B1nerpSTKkB6QU3eS5Vsog08kusCQeamJuUDRnTz91s6Y7APSzsNclP/qWPEMTZ4ZwgXvotwIl6GZEpobi7myhORdixaEzFXElA6reHrekCt1dA9XfbWtfngMbSVvjLa9azuWrs6/vJeCoAuFFSwhfYQbHX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=2b2v7ODu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a528243636so2687948f8f.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 08:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750087541; x=1750692341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHuEtxvP5CQwH09EDUcVI9pu4VR3Rvg+g2yAszHQh0A=;
        b=2b2v7ODu+i7H1wnaqrmAhlGFAMgo6QGWMZL+XYuqP3Z0Jc7vp+Irq6y/C14X4AD703
         K6IgE0o/IUH3xBT2lmekPCRKQgmZ97mnZuwkUOxixB8f5VkmRJd/q17SBUG9JXfzU3z/
         qwEaPfCSy9UtbRnbHRSMZd2rmxoYbQifYGxLpghYSMhTleeIrRnUhvRotU1OZyQzfaAv
         fVIOXhHtznQNxNLiUOdV1gehNTEc2kI+SGLtpnaWWCP080nrCMfmrBh3sY+WaRShA+OJ
         4s/lG3L4sAjV42ABBEL1/4D5lJiDsXHQ8oZWg/hpLfDVqY3nTEM4adqCg7CIEsQcKsDl
         1ZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750087541; x=1750692341;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kHuEtxvP5CQwH09EDUcVI9pu4VR3Rvg+g2yAszHQh0A=;
        b=DhuwjbEcghzP0JeM3N7uia3JZw2IH0uIk4JmrPy5wW7//Ud0U3/BulumpbOdi1V+12
         wYa3ga4oRwZybF3BQ/fFMy5NWC/uS4G3wxp92UoD8WBzjYK9tRGL3MYlWUNC50cIkdf0
         w6Ym9K4S1Ls+NzAVtuA4obgyAOJiybJFEVZnEEV/ds1E3pv75MfH7ysqBqiyd7xygxQ2
         63u3evBCZLyJqfxZntdTWTestbLjtWfrmtsLXg7dPrpHqQ9sAH18Xr1peeTAV/OwQH3p
         b72jw4LYEbJ20TWizSOhsIPxlIG43ai/0TtZDVm5V7Ma2nm1dMugI3l9rP93cicLz8tn
         BoGw==
X-Forwarded-Encrypted: i=1; AJvYcCW6Kcmvu8/Q88QYq3DXK97DIDKc0Jlf7Q3M8/snaQZV/oSApbTfhRj1QWYmS5F1RnHTiecRGYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzh8/+uIVuGrkz6oOFHinz/FEftZk3GfZhaf1mqn5an/zLO0No
	tk7ToEV84XHNuoftJlvgeJmlYalgQZmHqQSZyopHbBBXzgfIpNStlMEox8PPm4lWjG8=
X-Gm-Gg: ASbGnctXb9Z033+y3mrZGwg0bLUGcnpcnXlmgvBgmn3EGypL9rHw6lOQ93cNMztbpLo
	myfs9TeAtsEaxHYb+fm7lHXLLP95NvaUFO8sqlDJ05X/x2lqv9MLwKAD/94elk1l9cIwx5seB8p
	vangUVYFbU1DK2Vdh6+kGBaryZ/zmlUdVrgfmDQJS7w7xrYGYncNSZ7lGxRKX8UsbrPGsAicZFZ
	/ByW4R0DFxyDKWg28QhELBat6XnDKe97b/0rRKDXx7gnxVBEX4Y1uEu3fwbO1eRf00wUJghT3RM
	WuR1EiJeTWbs55DFM3ACBMUjgi5Ozl7knIMROw7nuxWWZbbDaA7UcOxazFVw/xuep7vDmvg1KrS
	ulg==
X-Google-Smtp-Source: AGHT+IEjdQ2eXcXa1tg11zwUYlrBcZhvY0FHRnP9f6gECsYozFCvtG8tbBbfziJjX0k7hPLCRfFRDQ==
X-Received: by 2002:a05:6000:402a:b0:3a5:2cb5:6429 with SMTP id ffacd0b85a97d-3a572e92000mr7965291f8f.43.1750087541046;
        Mon, 16 Jun 2025 08:25:41 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b70d77sm11494831f8f.94.2025.06.16.08.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 08:25:40 -0700 (PDT)
Date: Mon, 16 Jun 2025 18:25:37 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v2 3/7] eth: ixgbe: migrate to new RXFH callbacks
Message-ID: <aFA3caDNfOaNVYM8@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20250614180907.4167714-1-kuba@kernel.org>
 <20250614180907.4167714-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614180907.4167714-4-kuba@kernel.org>

On Sat, Jun 14, 2025 at 11:09:03AM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - add callbacks to ixgbe_ethtool_ops
> v1: https://lore.kernel.org/20250613010111.3548291-4-kuba@kernel.org
> ---
>  .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 22 ++++++++++---------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>

Good catch on the other ethtool_ops struct.

Reviewed-by: Joe Damato <joe@dama.to>

