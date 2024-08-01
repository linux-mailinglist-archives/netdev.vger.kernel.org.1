Return-Path: <netdev+bounces-115146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4914E9454EB
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 01:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3FBA1F23542
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 23:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20EB14D2BF;
	Thu,  1 Aug 2024 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTRpCI33"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111F214D2B3;
	Thu,  1 Aug 2024 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722554984; cv=none; b=r9xrtFEoi6+Km0ZEFKACueMqhIEDwlHT1VbyRf+kmYnuud7DHAa0UJJdtUsPc22ZX6RFzElHj5Ol/oxzOeH4wMmcfxnL0DqzrycaG5JaaOcN2kM2XxCbCQxIw2d70be7sQPePMTYWkzX4gzIb0Ejozl0Vf8jIh3/VMXjUtVQmgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722554984; c=relaxed/simple;
	bh=+FeSzzOVz1zyag2Dp60hiutDym+iokOXMNnVcfzTN8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MznenbH+1en3OLyTyZaTAWnSssBLTbe9hTAgOkQEZpXXF/16p2x25o4kXZkTO8YdgkqdsyZIQofzvDNHx4x5p+BbNE9srUXlyED59xJjb640QOKvKhkS445CDWq7ONPiuNjFQi/528KD3o8QhKLDtRZcvba8TLkUNs2p+DOq/Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTRpCI33; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4280bca3960so50684165e9.3;
        Thu, 01 Aug 2024 16:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722554981; x=1723159781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S3baeMLXbo97d1fQpSkYNhS6zDdUNnQMvWphkjrQSd0=;
        b=RTRpCI33gOV2sVwjYhA7pGbAsKNiozNdPvk6RFyJP4laBGAJX0mZp8gTB1vFCyIlcz
         KX5Bo15T/8PYpLgUwyFxy6hxDGVSsglgYx1w8nohn+sIqoXQkdWjyo9FPRbNAZ0IzSFF
         C6pLC0un33ZNa9CMMiy/0VwRcKdfWAoe6LwPgnSQS54dbi853MfAA63FEdhgU7TzCAo8
         FtMgdYhjgRriIiQwUWUR42zSmKA0Pzr/O5lzpZ0LHuLbc6q7DXgBxqoh1unM62Bn+LId
         s4pHpHbw7G47gvVCmGep7ibmBrhu9Bsu3/lvVFl95X8AZT1Kmt+Cz5Ousvxqf1Pmv7g/
         B3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722554981; x=1723159781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3baeMLXbo97d1fQpSkYNhS6zDdUNnQMvWphkjrQSd0=;
        b=jfLZoYBcDnisEDnJOLp0BN+a8WHMpS4jWmShIQdelCZJwhvljskVKEH2IO7YQNsmDJ
         TxZFry0PZVcGsqYgV27cMbrodSH2bcVKpHztsI7w+ogW4KlrY7FXS/oB3dQuVVx8PGsI
         lI3KKOO9bhM2AWljSy/VVwkXqKPYU6asPiAuhGfwMRiQXvu8OmXtYFTgUeUhjrOrRd8A
         X5Xiej+f9YbyF3Ar/lSw83YrqXYHkP5GcJ8VPUGVtF14k1KsxdU/u4j7bpDMjbKQb8RF
         y3Sqn0pxe4foyhFBJgx3uFzLHLbEQ+YB+EyrYoY6uCZRPXKto7XflLuyFMa97sRpop0y
         OSDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNw/69dCZQnJrHnh5q8Cl5eE1ZDFCWSE/vfu0eTVjCvepBGxOBMGamshUkhpnRZxvzC4JqPV0IQIG6VGFxkbjksNhl/qVqzzAxrQtXpE3ozsONYtZSCoPRwTy/IfKTu6jADaJu
X-Gm-Message-State: AOJu0Yy74xmCa2lKD0xStAoJPab9gjSMpNsAVxYSiswtOIuGNZAeUE5D
	jyCPCvJetB0aodVenvrZzBrk0n4ylAntfz3+w5krbb3ptGWh2EVC
X-Google-Smtp-Source: AGHT+IEXPX9rm3NSZIOdjCpUZ485555yJ5pLnsoYLHKaq0ewcpvvtEm0zfRMxyNx/9QoeYLEy/Qyng==
X-Received: by 2002:a05:600c:3587:b0:426:593c:935f with SMTP id 5b1f17b1804b1-428e6ae27f7mr9961945e9.1.1722554981158;
        Thu, 01 Aug 2024 16:29:41 -0700 (PDT)
Received: from skbuf ([188.25.135.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e9cd4esm11200035e9.44.2024.08.01.16.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 16:29:40 -0700 (PDT)
Date: Fri, 2 Aug 2024 02:29:37 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1 3/5] net: stmmac: support fp parameter of
 tc-taprio
Message-ID: <20240801232937.rmkv3er5cc2lykwf@skbuf>
References: <cover.1722421644.git.0x1207@gmail.com>
 <cover.1722421644.git.0x1207@gmail.com>
 <4603a4f68616ce41aca97bac2f55e5d51c865f53.1722421644.git.0x1207@gmail.com>
 <4603a4f68616ce41aca97bac2f55e5d51c865f53.1722421644.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4603a4f68616ce41aca97bac2f55e5d51c865f53.1722421644.git.0x1207@gmail.com>
 <4603a4f68616ce41aca97bac2f55e5d51c865f53.1722421644.git.0x1207@gmail.com>

On Wed, Jul 31, 2024 at 06:43:14PM +0800, Furong Xu wrote:
> tc-taprio can select whether traffic classes are express or preemptible.
> 
> After some traffic tests, MAC merge layer statistics are all good.
> 
> Local device:
> ethtool --include-statistics --json --show-mm eth1
> [ {
>         "ifname": "eth1",
>         "pmac-enabled": true,
>         "tx-enabled": true,
>         "tx-active": true,
>         "tx-min-frag-size": 60,
>         "rx-min-frag-size": 60,
>         "verify-enabled": true,
>         "verify-time": 100,
>         "max-verify-time": 128,
>         "verify-status": "SUCCEEDED",
>         "statistics": {
>             "MACMergeFrameAssErrorCount": 0,
>             "MACMergeFrameSmdErrorCount": 0,
>             "MACMergeFrameAssOkCount": 0,
>             "MACMergeFragCountRx": 0,
>             "MACMergeFragCountTx": 1398,
>             "MACMergeHoldCount": 15783

In order for readers to really understand this output (including me),
could you also post the associated tc-taprio command, please?

You deleted the code that treated the Set-And-Hold-MAC GCL command -
and according to 802.1Q, that is the only source of Hold requests.
I _think_ that as a side effect of your reimplementation, every time the
gate for TC 0 opens, the HoldCount bumps by one. Would that be a correct
description?

The more unfortunate part is that I haven't yet come across a NIC
hardware design that would behave completely as you'd expect w.r.t. Hold
requests. In the case of DWMAC, I would expect that with a taprio
schedule that lacks any Set-And-Hold-MAC command, the HoldCount would
stay at zero. I'm not sure, given the way they piggy back onto gate 0
for Hold/Release, that this is possible :(

At least HoldCount stays constant with a tc-mqprio offload, right?

>         }
>     } ]

