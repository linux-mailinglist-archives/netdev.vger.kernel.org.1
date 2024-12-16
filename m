Return-Path: <netdev+bounces-152362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56FC9F3A57
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 20:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329C01639DF
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 19:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621D420CCD0;
	Mon, 16 Dec 2024 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRueQ+P2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC36C20C481;
	Mon, 16 Dec 2024 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734378924; cv=none; b=Ag5rAfCDA0HHlW7ZL4+oADNwrzKL8v6Ihj1xwBAGFcE/WDIksXZ5RObHOJBKYzwpZidJ1qqcIrdSLw/G4qHIHFMMr8l/6lbGXe6jEucHjtQq/XaL+jhV1vg0xkty7+RlpOnO4wdsbKo6D/JxoaozlEr8AR2eFEiFgVjK0aIzSoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734378924; c=relaxed/simple;
	bh=Ix+OStVvszHNAz69L80aX5rSRrohehl4XpnZY9rnZY4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dw1EL/F1Cm9NGrZg4mgBcMXokJmr0wNf04mg6YQfwEpDtNCaE6p1rh9YDEDnCI0/1PlEBXDBfipYjyJ1YPnGBzRL6zQ6pg7XcjnxPIr7z8gwAQNX1dqdViMGjJWCILEnWIW5eUFRxNkkk8fECpZuqHUKI2vmkHzzTpa98YdY3Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRueQ+P2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso44376235e9.0;
        Mon, 16 Dec 2024 11:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734378921; x=1734983721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W98OVW28vlCYxfnu1q41kdPB6ICNjulMnB1+GiRL7VU=;
        b=TRueQ+P2VHq4nHR6kCq2mJzXgHDigVeRAzxosCMNNTxoY2oZ33dmFXtTfURbHbxseE
         8/gB3hI+lH466G2Nrzg0en2iFII/YeaLHqXcvfvMt0PQdNy4bFslh5pL44j4zdt6NW2p
         tQ1fKSnt9sWw+hV4eTqG7KYH8vxBFFILVpkyJAGMei8uZWWYfYlxW75Ni/cCfWCadK6M
         Pjf+0jzMP3z1+FS04rJnczW7Ri7dXqdMtwY3NS1QMTAU8RDpomN4m6gstZ5PrmA8GjFT
         TNGPNcmCVj6dzL04m3N6Ju6RZJY/3lRTRd5sdCOS33EEw1Qdpka0tjt10/A0apVho0xU
         8lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734378921; x=1734983721;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W98OVW28vlCYxfnu1q41kdPB6ICNjulMnB1+GiRL7VU=;
        b=d30o47uQofK7ZXW3pR84fDYou5C3LMQvFkygMcmxzRul63XJNywcn98pQ1Y05/thE7
         7ILm9c4izbpdot+I95v2gABwaamFAdZQg6H0+d502YRhjTsduaYloHDs1KMNBEQa8Ov/
         AZpQnJGK07Y0H7UeiOrKSJzrEe2mIsUq5hjAaI4TPYV3/6Pj1cIt6NDPEvffTi5fKIAS
         OtknkUv4k/qD3W91WJSTkfoPn+ntBmMCAHXac7ITBLor9YE/v7SiG3M+7ifmzV4GlvWr
         CluyapgHgcC6m1eOdg72lHSDmy6W7kTQJhjW79aBpiRulPVOAR/FpYwQRl8SbMsdFf3E
         krxA==
X-Forwarded-Encrypted: i=1; AJvYcCUbr8yxBg7WVZ5Fb+HEAP3shp0aMO/s/wUXnC+haESymksdUJZylMhZydicL810LiW+wy66Lyen@vger.kernel.org, AJvYcCWCyvW3gyvWwB94MV41k4NV5OpnzYMq0opAvaj7LNYq/U3puiD2AWR3wfpnP7U00UT8NtziEWUaJFSN//c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFLYpUzrHoEDevPogtQPLgtHQ0fC30iv0caMu2u7+EZTCdH7IA
	8RR9eptWUCW73oY8yCupci/+Ww7Hm9xdjvvk6L1MR7inpSC8RtzS
X-Gm-Gg: ASbGnctMumbe5gkS3ZkcWJHB2rzaibzv4MascoW4vttFKcLpELdFXJPXECW0nUCvAdj
	fXCav8tO9cEpa1EronKqJYszq4ErFcatRoacriUJ1EOQJEgV+/SwVp13uuhV/OxT88yew99KFUZ
	oS9pFV9natLuITtNca1bha0o0AfC+dBJ9xBWyWG98jk9wd3ynMnnJn3H+VAG+5wPe0jgIXN5Hic
	RJ53kslOZrKgWKp6Mz2wtJ+NU2WfDO5iM/QB3YeNLfKbs/l1i6Rv1XXEBsfEIH2i3H0mC76gkPp
	n32/fINzLG6o
X-Google-Smtp-Source: AGHT+IELnzR0viSji2/pIpUSmP64URG2MdrjxLFfFnvniU2WwXuHh4pwu5JvQWBZe7h7C9cHgcqbEw==
X-Received: by 2002:a05:600c:a4f:b0:435:21a1:b109 with SMTP id 5b1f17b1804b1-4362aa26d8dmr141570455e9.2.1734378920660;
        Mon, 16 Dec 2024 11:55:20 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706cc6sm149972175e9.30.2024.12.16.11.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 11:55:19 -0800 (PST)
Message-ID: <676085a7.050a0220.1e6031.2193@mx.google.com>
X-Google-Original-Message-ID: <Z2CFoZPnnSztWnzc@Ansuel-XPS.>
Date: Mon, 16 Dec 2024 20:55:13 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: qca8k: Fix inconsistent use of
 jiffies vs milliseconds
References: <20241215-qca8k-jiffies-v1-1-5a4d313c76ea@lunn.ch>
 <20241215231334.imva5oorpyq7lavl@skbuf>
 <87195b12-6dfa-4778-b0c0-39f3a64a399e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87195b12-6dfa-4778-b0c0-39f3a64a399e@lunn.ch>

On Mon, Dec 16, 2024 at 10:21:12AM +0100, Andrew Lunn wrote:
> On Mon, Dec 16, 2024 at 01:13:34AM +0200, Vladimir Oltean wrote:
> > On Sun, Dec 15, 2024 at 05:43:55PM +0000, Andrew Lunn wrote:
> > > wait_for_complete_timeout() expects a timeout in jiffies. With the
> > > driver, some call sites converted QCA8K_ETHERNET_TIMEOUT to jiffies,
> > > others did not. Make the code consistent by changes the #define to
> > > include a call to msecs_to_jiffies, and remove all other calls to
> > > msecs_to_jiffies.
> > > 
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > ---
> > 
> > If my calculations are correct, for CONFIG_HZ=100, 5 jiffies last 50 ms.
> > So, assuming that configuration, the patch would be _decreasing_ the timeout
> > from 50 ms to 5 ms. The change should be tested to confirm it's enough.
> > Christian, could you do that?
> 
> I've have an qca8k system now, and have tested this patch. However, a
> Tested-by: from Christian would be very welcome.
>

Hi need 1-2 days to test this, hope that is O.K.

-- 
	Ansuel

