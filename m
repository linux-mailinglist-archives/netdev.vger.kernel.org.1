Return-Path: <netdev+bounces-162515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8825DA27279
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFFAA1660D4
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202D120FA9C;
	Tue,  4 Feb 2025 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtO+sQmg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E4A20DD79
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673457; cv=none; b=slXKORt6PbSzH4jPXRv2mEikInYmP6cd7TzJ0LNLwiGjlRPDk3k0yVbg7BHuo3jokDyKh7jJAwJWUHNUvvHz8DQoz8Otfo3gyyM0bLyp1g6DUWO8VMLN+FVgIIqlbxc4LuIWG98/zcbcMqowb5nW7twT+8LD/FHC/BxoiyYkMyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673457; c=relaxed/simple;
	bh=o0pZF95c3eQVMxFpSfGyBlaFMnlh66Oow+2st4B1qMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bgrh851zN9wyKfkdISRZ1TUW+FJdUKnZEKitWU3UUZ9fAK4brahsSWF/8dMGCjezdBDPNH9caVFnpQ0maWPoT9Fxr6skH3qmZe2VmNvLST0RnN7+mJCxaVeO85E+NkhgQaQJoDgcq8HxxX84fOtThMsKn0QqOuDvMGJ51FgJR3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtO+sQmg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43658c452f5so7331695e9.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 04:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738673453; x=1739278253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6i8m47zZLnIhTCRayjNJf7P3F95rlcL8kITVf7it4s=;
        b=RtO+sQmgz3vANPhkf/lBG1Xz8uyloeInen3E5dYZhY988p1scOlG2V7tz5jglT5mpa
         R9Mi83vAd+48mzGbPL9B+KF9ehOCcLIbeBLyH8MQKGVuEnaOOWFJGiqko7N/tHKNT+Fc
         LLv6HcU0JSgtXohS+o9Qba3I2GUkODwgBjfvyu+twmvjKtu/1tF7FyIqvW844Bw39lxK
         0BDryim2Od6UdN+HFDLo7i8iFqJuPaPSJmlrMs9BPPUvPUfuTbpUKgXF4vOFXS8BW6ZU
         eBteEoC4yD3lZSRoYV4m5S6eeb8LSuWSVtJ3UdzmvgwuiHjwGa1AXX6G7aQ0KDAXbysV
         rBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738673453; x=1739278253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6i8m47zZLnIhTCRayjNJf7P3F95rlcL8kITVf7it4s=;
        b=M4gZnyyRrM0Y1mNxHLwloAYwNaraUqNHgJNI+LhM9Rf1BJF2DcgJGxW2lmfN3lo2T0
         9zzh2ZSEgFO/7YpXIPftzbjf1smZiFuooFZB8GGtAJGQTcrpcGjJPSabuKIAS+TpSjWr
         keChJ3X2uWT0xXLYAbc9bcGR573n0C8RJQa5wGwmYNrGktQWGlxiBa81252EZh+7f/T/
         ZmvRUPX+CrOimyrkx+XWRXqciREXoyYiRyxpoI2g2Ya5Frz+mCUMeqsknxpI+YZpaDwG
         0FRry4dDT/RSMVw/+VL+R7scxEMCLwJg4/Q5xfZ76ZupgoK3YDc8kJDYDH8TbNu68/66
         iaTw==
X-Gm-Message-State: AOJu0Yx1go26p4qpewe6y2MFjG3nccJr9s7GHzGPSOg/+MaLUPuTZmcY
	fTv7Wkt/y6XB51oLlDKykKvrc//AnHRhIkrSNmFpUFdqaXLqdW0FkVgcJw==
X-Gm-Gg: ASbGncuitEnHxqzjCo7dD8aulUIfMKPbhv36OWfz2+/9gpqWe+BVqNHSVB/5Qmj+Dfr
	KcXyrExsBJcwzRD2NlD6u/x/POV5JHKKRz3krG9aTzJk8dsAlN77J4tpGpnkQRZkMIwg6/PpbBl
	zspGb70XRbBFpSoJZB5zpacq6x2UQkgHzHnrKTwlcb8D0G5cDMss6PNfw8CunqNx96Ex3PzVZq4
	UitHidFxWkLvtMPbCmW9QLaJVvt3bpYL1baOwxLeNp8OGyPeiiP10UOuNeH62uKB2EwcElRt2GI
	Dns=
X-Google-Smtp-Source: AGHT+IHihMJUOfRD2xrDfFtYt0BG/Aj6WTc8kjACmL9qp6WE5z7Bu0TF0+7j0LAc1fIrmeKX0Drzdg==
X-Received: by 2002:a05:6000:270f:b0:38d:a726:d5ba with SMTP id ffacd0b85a97d-38da726d7acmr515621f8f.12.1738673453273;
        Tue, 04 Feb 2025 04:50:53 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38da59470b2sm2272412f8f.40.2025.02.04.04.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 04:50:52 -0800 (PST)
Date: Tue, 4 Feb 2025 14:50:50 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: DT options for DSA user port with internal PHY
Message-ID: <20250204125050.lny3ldp7wwc3g3km@skbuf>
References: <d1243bdc-3c88-4e15-b955-309d1917a599@kontron.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1243bdc-3c88-4e15-b955-309d1917a599@kontron.de>

On Tue, Feb 04, 2025 at 09:30:23AM +0100, Frieder Schrempf wrote:
> Hi,
> 
> I'm using a KSZ9477 and I'm configuring the DSA user ports in the
> devicetree.
> 
> Due to the hardware implementation I need to use some options that
> currently seem to be unsupported by the driver.
> 
> First the user ports are physically limited to a maximum speed of
> 100MBit/s. As the MAC and the PHYs are capable of 1G, this also what
> gets advertised during autoneg.
> 
> Second the LEDs controlled by the PHY need to be handled in "Single
> Mode" instead of "Dual Mode".
> 
> Usually on an external PHY that gets probed separately, I could use
> "max-speed" and "micrel,led-mode" to achieve this.
> 
> But for the KSZ9477 the PHYs are not probed but instead hooked into the
> switch driver and from the PHY driver I don't seem to have any way to
> access the DT node for the DSA user port.
> 
> What would be the proper way to implement this? Any ideas?
> 
> Thanks
> Frieder
> 

I don't believe your assessment your correct. The internal KSZ9477 PHYs
are probed either way using the standard device model and phylib, it's
just that their MDIO bus is not backed by an OF node. Looking at
/sys/bus/mdio_bus/devices/ will show that this is the case.

DSA has that shorthand way of describing user ports connected to
internal copper PHYs, but it is for compatibility with legacy drivers
and device trees. For all new device trees is recommended to describe
the "mdio" subnode of the switch, the "ethernet-phy" nodes for the
internal PHYs, and create "phy-handle" references from each user port to
an internal PHY, as you normally would with any other Ethernet PHY.
The schema at
Documentation/devicetree/bindings/net/dsa/microchip/microchip,ksz.yaml
clearly says that an "mdio" child node of the switch is supported.

Also see previous discussions where the same thing has been said:
https://lore.kernel.org/netdev/20241219173805.503900-1-alexander.sverdlin@siemens.com/

