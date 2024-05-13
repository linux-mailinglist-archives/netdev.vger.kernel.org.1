Return-Path: <netdev+bounces-95872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 215458C3B84
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13F3281522
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 06:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136E614659C;
	Mon, 13 May 2024 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="B1ELTYSh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A087145B3D
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 06:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715582512; cv=none; b=sT4qHErQl0kZpjpRp/zaFoT8oZJ3goYM6JWK37MZD51YyTwJwi14SoOYIgDA/RZyjP84oJEli6asYzgQP0N0czl8Dy099Aq+8AQDpyvecItAJYJt+gx2xVUjXO7nZCAZk6Fn+bleL5VoR+LYDiQongeTqg4iQJHXdwwNphAISQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715582512; c=relaxed/simple;
	bh=AZDUvNbYds6+BDMS2Gs+L0RuM6sC7odAJpRGoP07xS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoOnH2Iq32QNBB72wLGcnGawSC+PvNDxVcWCbNc/7xx40wlRF5wYpYMWLBZgz1ueI0yw42day4ps9HQO36SVv4M/LirMK4kyuTVcyV8EoxOq1Pao0tLUD/Gk/uj49Dmq0SxHIS6IS/+yKgsrBAAZKmrEqWjsm9E88rQ3TbB11HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=B1ELTYSh; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e564cad1f6so23648381fa.1
        for <netdev@vger.kernel.org>; Sun, 12 May 2024 23:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1715582508; x=1716187308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jgmYXspuQD6m2g2YDHV5QyLok17L1hPzYPTwYzpfjV0=;
        b=B1ELTYSh3jmT5u6rpF71dNBwxlamZq/1yK4Cm+3XE7FrQgXePAi6HN4VxJsUNPHmLz
         Or5TujoCY/gvVzHkG4nSAJK+hhsFB4URSVPdKNrWzFKmjUdHgAAQaQUyzfjRHg6YJCPC
         FpfjBqPFMdD+0ppj7KpaIn2FYSsYH/MBuAo8bIe7jZIT4epGjH2rhNPwCcH4tTgGuHAF
         CXajicjQuucbBrBSwwVG48Dgpgk8WQSFoPn5U2jfpWrw9FkDJMRk8tkDbhTm1wPIuITL
         C+p79FEUtAFL8lgsKLowoQTU8SIXzOoi1elQdd5vINdfwl46kxNjU0p2cFBDQdYRX45Q
         sznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715582508; x=1716187308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgmYXspuQD6m2g2YDHV5QyLok17L1hPzYPTwYzpfjV0=;
        b=e/APoe1ohxvOfuPGubFMr49eJbZCO3BO5GqqzvmyzqGVArjmer7LDNTdptLNisCYsf
         nYQafXaZgiKWPUS7uSs7PukiLYQ6D9Qp2yFgt48Q9H99IdBeHppVDbqg24F3H7+RglpL
         wJ8EsPcyuDsaT3QoyiSvmJ10OXFo1+0sNGbS8dytIsHIbTv8S5ipOEttZ7DlYQzlEdcu
         ror1oYxeTZ6g3hLY9pfmWHl4Kmlns0dePBiVsZOg/JfF82GCw3JylEVNXHwe2zv5LKIV
         2pXa5eivJxTYGqtWhvjt6LwSnkfj6Ee3nAun7KphyvvNND5hBHaYIne9KVv2PEc3OLmD
         2Ibg==
X-Forwarded-Encrypted: i=1; AJvYcCXX8W2qBZuQAwGR9gCTiKOYywIUWUPrOUMF1eZWIn6EvIe3YJngP8mKanguRKi1Otl3SGnmwABCbsuuMM0hpSdF+LOkTxqa
X-Gm-Message-State: AOJu0YzpqPzf6FOs91xFQR7mrYKU0VEgsSe4BxR2w1TXAf569VNFkMlV
	rjkNxlncYFFmxcVK2jzX/kxuMyZfIYGF741vbigoa734ZKBHZJAhnG4fPv80JJw=
X-Google-Smtp-Source: AGHT+IEIkeRxVZ7/wwKjFiJVGfzq6Dh2wr3o8ZQIJjCu0AGpKE+fr3Hj0hV6u+O7KQYjw+iUt7WzAA==
X-Received: by 2002:a05:651c:510:b0:2df:97b1:e21c with SMTP id 38308e7fff4ca-2e520066fa4mr67361691fa.31.1715582508290;
        Sun, 12 May 2024 23:41:48 -0700 (PDT)
Received: from minibuilder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d183450csm12842611fa.133.2024.05.12.23.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 23:41:47 -0700 (PDT)
Date: Mon, 13 May 2024 08:41:45 +0200
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	"Parthiban.Veerasooran@microchip.com" <Parthiban.Veerasooran@microchip.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
	"ruanjinjie@huawei.com" <ruanjinjie@huawei.com>,
	"Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	"Thorsten.Kummermehr@microchip.com" <Thorsten.Kummermehr@microchip.com>,
	Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>,
	"Nicolas.Ferre@microchip.com" <Nicolas.Ferre@microchip.com>,
	"benjamin.bigler@bernformulastudent.ch" <benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Message-ID: <ZkG2Kb_1YsD8T1BF@minibuilder>
References: <Zi1Xbz7ARLm3HkqW@builder>
 <77d7d190-0847-4dc9-8fc5-4e33308ce7c8@lunn.ch>
 <Zi4czGX8jlqSdNrr@builder>
 <874654d4-3c52-4b0e-944a-dc5822f54a5d@lunn.ch>
 <ZjKJ93uPjSgoMOM7@builder>
 <b7c7aad7-3e93-4c57-82e9-cb3f9e7adf64@microchip.com>
 <ZjNorUP-sEyMCTG0@builder>
 <ae801fb9-09e0-49a3-a928-8975fe25a893@microchip.com>
 <fd5d0d2a-7562-4fb1-b552-6a11d024da2f@lunn.ch>
 <BY5PR02MB678683EADBC47A29A4F545A59D1C2@BY5PR02MB6786.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR02MB678683EADBC47A29A4F545A59D1C2@BY5PR02MB6786.namprd02.prod.outlook.com>

> The RXBOE is basically a warning, indicating that for some reason the SPI host is not fast enough in retrieving frames from the device.
> In my experience, this is typically caused by excessive latency of the SPI driver, or if you have an unoptimized network driver for the MACPHY.
> 
> Thanks,
> Piergiorgio
> 
> 
> > [  285.482275] LAN865X Rev.B0 Internal Phy spi0.0:00: attached PHY 
> > driver (mii_bus:phy_addr=spi0.0:00, irq=POLL) [  285.534760] lan865x 
> > spi0.0 eth1: Link is Up - 10Mbps/Half - flow control off [  
> > 341.466221] eth1: Receive buffer overflow error [  345.730222] eth1: 
> > Receive buffer overflow error [  345.891126] eth1: Receive buffer 
> > overflow error [  346.074220] eth1: Receive buffer overflow error
> 
> Generally we only log real errors. Is a receive buffer overflow a real error? I would say not. But it would be good to count it.
> 	Andrew

Hi,

I've been busy throwing stuff at the wall until something sticks. I've
managed to narrow a few things down.
First and foremost, when running a periodic udp6 multicast in the
background I don't get a hang in the driver, or it becomes considerably
harder to provoke.

When I make sure that the bespoke Ferroamp upd server is not started
(which just joins a mcast group and sends a less than MTU packet every
~500ms and listens for incoming multicast messages in the same group),
it becomes very simple to get to a live-lock.

My steasp of reproducing is setting a ipv4 address on both ends of the
link, then running the follwing script on both ends using the other ends
ip as argument.

#!/bin/env python3
import socket
import sys

if __name__ == '__main__':
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    while True:
        sock.sendto(b'0'*2048, (sys.argv[1], 4040))

Neither ends opens a listening socket. I get to the live lock in 10s or
less.
I've enabled some debugging options but so far nothing seems to hit.
What I've been able to conclude is that there still is SPI
communication, the macphy interrupt is still pulled low, and the cpu
does the ack so that it's reset to inactive.
But from there it seems no data is passed up the network stack. Some
symptoms are

* net_device stats are no longer incremented
* can't ping
* can't connect to sockets on the board etc.
* cpu usage jumps to and stays at 100% for the worker thread

The worker thread is released by the irq handler and it does some of the
expected work, but not all.
I'm adding some instrumentation to the code in an effort to figure out
where things break apart.
It might be possible to catch it in gdb as well, but I think you only
get one try as the timing will be pretty borked after the first break.

R

