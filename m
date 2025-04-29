Return-Path: <netdev+bounces-186774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 006C3AA107E
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E75162CE3
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893DF221568;
	Tue, 29 Apr 2025 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="FVovNVYu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2C32746A
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940532; cv=none; b=lfwqOsfd8bsWgBHznmdzQmLPv6KBUBEd0oLhtZ0ThaDaHqgOw56qLTdRwktwnmlXq6cUtO2K3bp4CQ38hfgUopW0813p2hH9BDdXAwgrOKqBoV033Qz9DyEyszLU8v1P+9wXzsTdBLQztcgASQvv9lLFXPLljShyYYBX/4n4YFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940532; c=relaxed/simple;
	bh=Ny3E4335luAalOHOPPCkNS5Z39FqrcvQqR8UbwhzE9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWXBf0PO5fYk5c3pDmyd67RNG9NMgLafSmf80XqDmczcuuenk8YditQYybOpZoXqH1bzcPikWMb5Xj0EwLo9TjYgS5UrJ/UA2rTlk7SzTlWBUspA49ZnjL/QSPsZ41UumK7zKxdb8x8XzJUI9P1rA3Pw3MT220h44JnJ90jgS70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=FVovNVYu; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso8767950b3a.2
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745940530; x=1746545330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dN23D6zB25hr1SVfBhzqPNwhFVryWAUmMYoXZFNiS+M=;
        b=FVovNVYu+e8VO28RYwiESaVUavfVbYjb8G3F62ItmZKz9aGD4nneE+/MRda8F8ugZA
         LLavvLJdW0YIG+uHaf4vPTVUUUo9hCaYBVU1Eha2ofGap1yyXRP/kN91+ZyvIuk4n1HO
         A1N6lR7y5zEFf2wxiLzhcrwNivw+Wfm1EfIZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745940530; x=1746545330;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dN23D6zB25hr1SVfBhzqPNwhFVryWAUmMYoXZFNiS+M=;
        b=GWVzp+ZRHZSMIryjIlsWB4ZO9loPvs0AsNKT4UCE7QXWfaIv8cQUTf9Pqc9og+kdUO
         sreC3SMpMF2MwSwH5M5yS0cDj/i7UEOOk955oChULBtHbwkElmHxKFVS/tUcuWv4h09n
         j8v0/TgYYdjsUeSDhvFWDC1B8+TwCMRqUxXqlVNHyVjeB2p+RmZVx4tfqnXG0buAHayc
         IFuurJNVlduE8+XWJvyRh19UkNxenL7ghOXwXSOdwVyXH7c1dxL14Z3BgM/Yz5vVtg0w
         c0+FHdDhd/6lQsHSJcqxtSdUye+0w9eEhhcnOnN9TOiO9bR+u75lUjG8ysU9BM2sySYA
         bwVA==
X-Gm-Message-State: AOJu0YwBYs9fv4vFm/vYykJCFkwMvf3fKBSKIRw+sdr3ZGWAXo8Hcc6d
	6v9x6K8XjWb4OZYOI/10mEWDYs+nZWYWNjqt5+ae0gHkZE6kn1vtCB4wZjmt8kw=
X-Gm-Gg: ASbGnctZH8skcP0m7XR5AUV0ZwEyDGxFhabigADYwWlkqjlBTTVtxS1lRA1zoBfYUzR
	C2hObgoU9ZDQq4szWO6EMnGpMUgaBb//9zf58aDPxk7fjDDDh0gpZI0R46vvSgw2JTuQ7D5OpLg
	f26HHR/n1buD+bz6eBAWSbc5gY1f/9VNg3k9NpN7EEvsLPlYdfn21oBuONm2qmt3/0FPMT5qxXb
	IbDheO43O7e0uEJhj1RUKUgRC+fKHcG9nw7KO7AeHRnujBz3INRd9OD68jmbwj35Qs7oggCnE5C
	yM3YOu50J2me7kJUic+DQU6699PNZgp3n8PoES1XxVkqn11YpNPKTWaSsbsrAXbRqtwzoABDsaI
	jaaIXGyspQrDm
X-Google-Smtp-Source: AGHT+IGVKwZFUZMUI43yYDJXIXBKz4w/3Xamt8U99wafQquFshUtZj+NxTvC6l3XpSlJrTy0uC3sJA==
X-Received: by 2002:a05:6a20:d490:b0:1f5:9d5d:bcdd with SMTP id adf61e73a8af0-2046a3ed5b1mr18815252637.1.1745940530207;
        Tue, 29 Apr 2025 08:28:50 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e259134d5sm10402663b3a.19.2025.04.29.08.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 08:28:49 -0700 (PDT)
Date: Tue, 29 Apr 2025 08:28:47 -0700
From: Joe Damato <jdamato@fastly.com>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1] bnxt_en: add debugfs file for restarting rx
 queues
Message-ID: <aBDwL-XxG-Gvmk10@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250429000627.1654039-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429000627.1654039-1-dw@davidwei.uk>

On Mon, Apr 28, 2025 at 05:06:27PM -0700, David Wei wrote:
> Add a debugfs file that resets an Rx queue using
> netdev_rx_queue_restart(). Useful for testing and debugging.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  .../net/ethernet/broadcom/bnxt/bnxt_debugfs.c | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
> index 127b7015f676..e62a3ff2ffdd 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c

[...]

> +	sscanf(buf, "%u", &ring_nr);

Does sscanf's return value need to be checked to ensure that a match
occurred?

  ret = sscanf(...)
  if (ret != 1)
    return -EINVAL;

or something similar like that?

