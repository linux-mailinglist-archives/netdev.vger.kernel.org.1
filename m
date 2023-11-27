Return-Path: <netdev+bounces-51348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C5B7FA4C0
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 16:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE095B20FEC
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 15:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E65328BA;
	Mon, 27 Nov 2023 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="TdaqAdOH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377B2C3
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 07:30:38 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507a3b8b113so5700316e87.0
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 07:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1701099036; x=1701703836; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0nEvDUTA+VvuaYc5IvEcHoTln/14hfyXc63Vrf+U23o=;
        b=TdaqAdOHGHRUQIQ58Zzi1ivA/gkcWgUKlHkgv2qJRjAfz0y1u6k2xlua3CjJeQMnCN
         jAm7bQuvGMU5gTCbNwLI2n4XMuWJR6iHumE009SlERLd+8eI40jXcL4ZVd9jaD/yipbY
         A/7LEA+EHylsqz9MxCV7O/e0YKqelB7ktAHP93NJ9s8m/V2KawJpUj02pbqb8Fh6cxgB
         +iFVNha29qee0qGnEIOBhmtOR6rjVZwosdWjAqq8pGednvkjMGlZoLKoGGIlcGD3Ncs+
         JbfGSs0YlAgflFyd7TDU9yZH3SW3xTSVsK7YVfIxOabqry2641OjInXswVtmGnfLp6SV
         o3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701099036; x=1701703836;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0nEvDUTA+VvuaYc5IvEcHoTln/14hfyXc63Vrf+U23o=;
        b=mOSSoGhvlQ9d+cEeD81mFT6jVHAr6WcnE/K1VREFsaajiGtNzuWkWWXT3HoyNHPPhh
         7+1I3uJ9bel7u7wPecr/Oi+fDd2A9FVaQNr2Z6FIDi6t48BtwAQEMWmWsNXscoQEfwA+
         AcNGFBWzj+0RIwhV9xru37lH5JMusHc3Jgq4yFuB7s6zc+AJniVOgq2HGPWiEPhw8TXE
         GCxV9enjQYMeAqfXyLbzEN66iIVvpkxjX9sw7Wzfkihuwe1uh/aMYhH1ZmuNz6s1Podh
         zV5HlAJVPHOtomrp1EKbLZJD/iaZGf94EHqWtB84DsG1eKqABD7jEPT7+Q+WtaDYjdjH
         P+kA==
X-Gm-Message-State: AOJu0YwTS8MGXqzeXcsUz3J/ZBGh1HZufBDKfxwxRYEvvMVzxE10O/ki
	2EblhlkTp8IABxW6Cxz/SF4JoA==
X-Google-Smtp-Source: AGHT+IFIdQDsSEv3RzXM31ZIHh3gafChRm3GIc3+5CtX1YMLD/gJ44pyECWYXqOtlO0mWzBletRSiA==
X-Received: by 2002:a05:6512:31ce:b0:50b:aedd:6d53 with SMTP id j14-20020a05651231ce00b0050baedd6d53mr4159551lfe.62.1701099036331;
        Mon, 27 Nov 2023 07:30:36 -0800 (PST)
Received: from debian ([185.117.107.42])
        by smtp.gmail.com with ESMTPSA id x5-20020a19f605000000b0050aa491e86esm1510684lfe.83.2023.11.27.07.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:30:35 -0800 (PST)
Date: Mon, 27 Nov 2023 16:30:33 +0100
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] net: microchip_t1s: additional phy support and
 collision detect handling
Message-ID: <ZWS2GYBGGZg2MS0d@debian>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
 <d79803b5-60ec-425b-8c5c-3e96ff351e09@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d79803b5-60ec-425b-8c5c-3e96ff351e09@lunn.ch>

On Mon, Nov 27, 2023 at 02:58:32PM +0100, Andrew Lunn wrote:
> > Collision detection
> > This has been tested on a setup where one ARM system with a LAN8650
> > mac-phy is daisy-chained to 8 mcus using lan8670 phys. Without the patch we
> > were limited to really short cables, about 1m per node, but we were
> > still getting a lot of connection drops.
> > With the patch we could increase the total cable length to at least 40M.
> 
> Did you do any testing of collision detection enabled, PLCA disabled?
> 

In our dev system we've only tested with PLCA enabled, bit too tricky
changing internals on the microcontrollers.
But I have a lot of usb eval dongles that I can test with.

> You say you think this is noise related. But the noise should be the
> same with or without PLCA. I'm just thinking maybe collision detection
> is just plain broken and should always be disabled?
> 

I don't have access to the equipment to measure noise or reflections,
I've looked at the link with an oscilloscope and it looked fine to me.
The reason I'm mentioning noise is just me parroting the datasheet, for
context I'll quote the footnote here

"No physical collisions will occur when all nodes in a mixing segment are properly
configured for PLCA operation. As a result, for improved performance in high noise
environments where false collisions may be detected leading to dropped packets, it is
recommended that the user write this bit to a ‘0’ to disable collision detection when PLCA
is enabled. When collision detection is disabled, the PLCA reconciliation sublayer will still
assert logical collisions to the MAC as part of normal operation."
LAN8650 datasheet 11.5.51

> I've not read much about T1S, but if we assume it is doing good old
> fashioned CSMA/CD, with short cables the CS bit works well and the CD
> is less important. CD was needed when you have 1000m cable, and you
> can fit 64 bytes on the 1000m cable. So always turning of CD might be
> appropriate.
> 
> 	Andrew

As you assume when PLCA is disabled the phy runs in CSMA/CD mode.

I'll do some tests with both PLCA and CD off/disabled. My thinking is that a
adequate test bench would look like

* 3-4 nodes (depending on how many usb ports and dongles I have)
* run iperf with long cables and CSMA/CD
* run iperf with long cables and CMSA/No CD

I'll report back the results. Anything you'd like to add/focus on with
evaluation?

Ramón

