Return-Path: <netdev+bounces-55615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 740B180BA95
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 13:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03A87B209C0
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 12:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C582D8C0A;
	Sun, 10 Dec 2023 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="gOYbznck"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344D8102
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 04:10:25 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50be4f03b06so3375080e87.0
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 04:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1702210223; x=1702815023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TVZLGDwnFrSoZzbSshy6/E7v2T5vetFvtKyVzmesIKY=;
        b=gOYbznckZxS+4ftN5Y1dYYVfIRfXlnUpIYI8KAmuVayget4bJUKp1PPutfJyd0TVOL
         IZxA+q2p6pd4qcNSybfm2QjItYLKuCIaIGwxFt+1wKoVFdwWEUe7bur+kbzZrBbBZ5xU
         71jVTCV92Dhb7MXWE7lgMfqjZTQBZF1BEitx8TAMbesWveNGltyWOB1KXBvs1JHV0CKc
         UjfGvDEJ9GY5mBGBPqkjFvA8xghfw+OVKIoQxt8VJgu1aIpuCIb02DjAnmITGVltPcmQ
         VCSJjNme5CCko7VUc92MqXtZxZ+dQZo7yIUmFANtBJ7HjXYQ/+N02QPMtbL2EiiVB2Cl
         NPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702210223; x=1702815023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVZLGDwnFrSoZzbSshy6/E7v2T5vetFvtKyVzmesIKY=;
        b=tO+w4uUDvteRV48N1Z2i0tCCfv+drKQ7LtZPHo56maN8E8QlQlpUeG2i0Yd0ggn0dQ
         HCeEVuC/NtJ/DfWFR60Ll4MzYPQS01YKuLCYP46azzPBVaOsYceJdXMMXI4U6VBFz3xq
         k5YbfRQEcDXYGwJQHVwc5IRXQVWG/nfSkJJR0+EaFk+BUPcdnmj3MpDSekk8JRceEu88
         eS2p1U7yLG/VFG8znva+FVH/GtZqfz43XQMvcv3Bce1OlPTM2wvyBRzSu0ep1rrJWfRS
         IdGpy3F5Qxv/YOITxXCf6GD5FXr3Y85LngtBHTWzIsQYRkV8dp7nV83pNBlNv2/50IYs
         mvpw==
X-Gm-Message-State: AOJu0Yx36CO7ximZzUk+tyfeDlklEvhE2PUlrQTslVUnCfn6Ydkr1rKP
	Q+u+PpRhElDQienWII3opyahsg==
X-Google-Smtp-Source: AGHT+IFB80l7EyfYVJx9mjj/NoIh9j2du4/mUd4EDhNv2r6WZu64qOIGdc7jpotjPNfe3Po0CpR7vQ==
X-Received: by 2002:ac2:598d:0:b0:50b:fdc5:dec5 with SMTP id w13-20020ac2598d000000b0050bfdc5dec5mr627566lfn.75.1702210223371;
        Sun, 10 Dec 2023 04:10:23 -0800 (PST)
Received: from builder (c83-248-56-68.bredband.tele2.se. [83.248.56.68])
        by smtp.gmail.com with ESMTPSA id t23-20020ac24c17000000b0050bed700f5esm792527lfq.91.2023.12.10.04.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 04:10:22 -0800 (PST)
Date: Sun, 10 Dec 2023 13:10:20 +0100
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
Message-ID: <ZXWqrPkaJD2i5g-d@builder>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
 <d79803b5-60ec-425b-8c5c-3e96ff351e09@lunn.ch>
 <ZWS2GYBGGZg2MS0d@debian>
 <270f74c0-4a1d-4a82-a77c-0e8a8982e80f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <270f74c0-4a1d-4a82-a77c-0e8a8982e80f@lunn.ch>

On Mon, Nov 27, 2023 at 05:03:54PM +0100, Andrew Lunn wrote:
> > * 3-4 nodes (depending on how many usb ports and dongles I have)
> > * run iperf with long cables and CSMA/CD
> > * run iperf with long cables and CMSA/No CD
> > 
> > I'll report back the results. Anything you'd like to add/focus on with
> > evaluation?
> 
> Humm, thinking about how CSMA/CD works...
> 
> Maybe look at what counters the MAC provides. Does it have collisions
> and bad FCS? A collision should result in a bad FCS, if you are not
> using CD. So if things are working correctly, the count for CD should
> move to FCS if you turn CD off. If CD is falsely triggering, FCS as a
> % should not really change, but you probably get more frames over the
> link?
> 

# setup

Andrew suggested that I try to get statistics from the MAC, I did some
investigation here but could not figure it out.

Using iperf3
Client: Arm based system running lan865x macphy 
Server: PC running lan867x revB usb dongle


# test results

The results below should be considered fairly represenative but far from
perfect. There was some bounce up and down when rerunning, but these resutls
are an eye-ball average.

No meaningful difference was seen with short (2m) cables or long (12m).

## with collision detection enabled

iperf3 normal
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  5.54 MBytes  4.65 Mbits/sec    0             sender
[  5]   0.00-10.01  sec  5.40 MBytes  4.53 Mbits/sec                  receiver

iperf3 reverse
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   929 KBytes   761 Kbits/sec  293             sender
[  5]   0.00-10.00  sec   830 KBytes   680 Kbits/sec                  receiver


## with collision detection disabled

iperf3 normal
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  6.39 MBytes  5.36 Mbits/sec    0             sender
[  5]   0.00-10.04  sec  6.19 MBytes  5.17 Mbits/sec                  receiver

iperf3 reverse
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.27  sec  1.10 MBytes   897 Kbits/sec  268             sender
[  5]   0.00-10.00  sec  1.01 MBytes   843 Kbits/sec                  receiver

# Conclusions

The arm system running the lan865x macphy uses a not yet mainlined driver, see
https://lore.kernel.org/all/20231023154649.45931-1-Parthiban.Veerasooran@microchip.com/

The lan865x driver crashed out every once in a while on reverse mode, there
is definetly something biased in the driver for tx over rx.
Then again it's not accepted yet.

Disabling collision detection seemes to have an positive effect.
Slightly higher speeds and slightly fewer retransmissions.

I don't have a black and white result to present, but things seems to work
slightly better with CD disabled, so I'm leaning towards just unconditionally 
disabling it for the lan865x and lan867x phys for the v2 patch.

I'll wait with submitting v2 for a day so anyone interested gets a
chance to weigh in on this.

R

