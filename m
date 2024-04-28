Return-Path: <netdev+bounces-92018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0B08B4E75
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 00:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6D71C208E1
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 22:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BF2BA50;
	Sun, 28 Apr 2024 22:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="x69P09HD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C39C144
	for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341900; cv=none; b=BIXim+FX6U1sVNbrLCjWZpL9IvoWuCp/jtjUn3LXrrc2Gq1cgkfp1NeBr81XJaohrgrFjxrSQmVJkJRYGTzjsOkfV4cXgiCbVCegtd4r5bumIrewPN3gBGBdS8ZAKKQnp8MrvgFoxcs8KWmavesQF4KYb9Yg2STgWvm0OImFvZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341900; c=relaxed/simple;
	bh=4RqsDjz6bW3uKuO0Fsvr3+kThoLZuoIPu0ISXkKrTyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJBfjY6g1GQUohCD3fRyjP4TFux+3nirftTL57fdOVW35w2PMlcmIiyncHxM4LuCG59taxebjSPxnR+yBbiQxPj41EyerlSU5plclyLa8g3FJ5//mXi7gQCg8MMvwyEO3aBc+iR75OZ2AWwze9xPwQcZQ5VuFKVNgUxe4P75YVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=x69P09HD; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-518a56cdc03so4222792e87.1
        for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 15:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1714341897; x=1714946697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H1dBr2tBHwkZy3R1A5ZSprdad8ekfhB+9jofNOvQ5fE=;
        b=x69P09HDqj18ZyhohC3t9ioNl3G/T7Z05fJnLDxHMnHKU/CrzSFEeLkrriCO1dri+e
         lS8P99CTC4dapjY/qpnsbe8u7iwnE1U0glIaPnej8sk/lS0YKqCgkHxkX7Yn7O3UkQnh
         5OnY/8uirQgSUF7RK5hr3NT5mmhmLDV7lz/fdATjRXIK5fnECMF8j5DyZLOeDcCQH1XF
         r758vnNfKGCzQz5frBzNlCziqFw4m1NjTUgVgWkk/AGlSAj66sLzLdqJcXNOlFmX1/VM
         dZjM6O1PnpBc3MtSKY8aGudcQKADRNm43jAFSFh5qP/8G3VyOs0WbTl02PNRZxDtso9x
         cdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714341897; x=1714946697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1dBr2tBHwkZy3R1A5ZSprdad8ekfhB+9jofNOvQ5fE=;
        b=NlvNhrgaWyksqcYy38M4by/kuiB+iS/ZMi4aqPjW+ord14I7SUW84n+FwtMK8pXJS+
         PXJj0BCJ2H+ZRE6RQgejnPqtRgsoOwOOWcmgtg6X7QMzFn+jytBK7pyCxX4wZ435yVOt
         3wripzlEq0HqEsLBrPWOBSk1HoqaoebXJzifh4Z2hz0hQDDChgLsAfKprBUNeHIjzC2p
         BMaDNua7mue6/KBcXM5v5EpO5o4chVFnBMzn3y+Tl0bP2eNLexbZfmAAGcJ0BjYT3WvE
         mTOSGy/03iyM5fSKuxDB67yUYvl4tXRljcn5bSf8ydkA8G6TXzOiwq+BD94WB9r5rt32
         NzLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1TZh/Qu7//U44c5zN3JVFaFlhk4hPHDSj8zV4PlPaclHtBQ4v+RvdhaeOhM4vbSGfq8BMHP7S49qn5lyLWaxCiiYGLg6/
X-Gm-Message-State: AOJu0YytY7EcMUxjsvH4DdeUnHqJ8n6IhknpeAJqI45L67yxbkUHHv4X
	2V8d8NLHL8I4+9evYQM4hx75QdhPyM4wMgR5yEY33sYZghIFzSWAS+lU+vGEEY8=
X-Google-Smtp-Source: AGHT+IGsfdQ5hwxsPrYlKFP4rOafGl9ZX1COj2lhKabxTOxWM5ZO2gZkVWsJ4WnGwxMJE16O6x9P0Q==
X-Received: by 2002:a05:6512:3294:b0:51d:4473:48eb with SMTP id p20-20020a056512329400b0051d447348ebmr2172432lfe.38.1714341897439;
        Sun, 28 Apr 2024 15:04:57 -0700 (PDT)
Received: from builder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id o2-20020ac25e22000000b0051cc6cd306fsm901709lfg.168.2024.04.28.15.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 15:04:57 -0700 (PDT)
Date: Mon, 29 Apr 2024 00:04:55 +0200
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
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Message-ID: <Zi7IB_uKdFkJLtCS@builder>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-6-Parthiban.Veerasooran@microchip.com>
 <Zi1Xbz7ARLm3HkqW@builder>
 <77d7d190-0847-4dc9-8fc5-4e33308ce7c8@lunn.ch>
 <Zi4czGX8jlqSdNrr@builder>
 <874654d4-3c52-4b0e-944a-dc5822f54a5d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874654d4-3c52-4b0e-944a-dc5822f54a5d@lunn.ch>

On Sun, Apr 28, 2024 at 04:59:40PM +0200, Andrew Lunn wrote:
> > n  |  name     |  min  |  avg  |  max  |  rx dropped  |  samples
> > 1  |  no mod   |  827K |  846K |  891K |      945     |     5
> > 2  |  no log   |  711K |  726K |  744K |      562     |     5
> > 3  |  less irq |  815K |  833K |  846K |      N/A     |     5
> > 4  |  no irq   |  914K |  924K |  931K |      N/A     |     5
> > 5  |  simple   |  857K |  868K |  879K |      615     |     5
> 
> That is odd.
> 
> Side question: What CONFIG_HZ= do you have? 100, 250, 1000?  Try
> 1000. I've seen problems where the driver wants to sleep for a short
> time, but the CONFIG_HZ value limits how short a time it can actually
> sleep. It ends up sleeping much longer than it wants.
> 

Good catch, had it set to 250. I'll rebuild with CONFIG_HZ=1000 and
rerun the tests.

