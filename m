Return-Path: <netdev+bounces-197337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F6FAD82AD
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 07:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11B73B6770
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 05:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DB424EA85;
	Fri, 13 Jun 2025 05:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="p3DsEhLd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FDF23BD09
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 05:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749793362; cv=none; b=P6D4RAcm+lrauY7gK/oa21c9IxlxUCre7uE6CP7MS22oYrE3f6CijH3PFXAKoRkiniCAfx764WqBrS7fMTlK/RcvrKBgbZKWWzYV1HvytI2u1Abrfc1ZVLq1CenVHhFED1SUVsxIsC5LKGPOiBpJjip5YqIFssxwctJ38ijXrGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749793362; c=relaxed/simple;
	bh=rwJ46fDsisHcZlPYuwEI+nd115knoVkwcADd1UMbkZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4tgGuT8tGzH8g9idljUg791lUoXmKF4QC/dl8k6jowuHH3Wz3gsT1/tKm0/Rv6/CWVn9IgU/ih7hcJVNra9Z1xa9fUDMexl5QOUflkoLHKUtalBRrBT8DYYA9TqkNmxvR5VKGZqb3Jijk654qsKqAGJhZKTetLZhh70CXNiI3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=p3DsEhLd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-441ab63a415so18860965e9.3
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 22:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749793358; x=1750398158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWWAL+VbrkpZ6XEFuM8I74/gE+9nSHvII7fIBjxxM/w=;
        b=p3DsEhLdvM1K7ijntKNOcVM4Bs0QWbs67K/yUBD2E9QxWn4M0f0D3EiElfUw8DulOd
         g/LJRvxxWsWY2SUGkqayp+Zd33OwN7OHS3NF7y1MdOV/GkI89tFfqaJG3jVuLfc1Ealz
         2VojL4QLORzWGcW3cUHwxn24Gz9RLV1jEXQCiIc2aEnKDuVBJZUUCfsGAmGV7loxdyVl
         8yIIUxr+1IMgVn2ywVlPCymEr5bq2Icwg9Puzt3clPEcDtagcFWIqVb65Ca2b7hSazB/
         bc7M+sVAQYWtjULKls6pL0ZccHKV1iZckgIDRNaGmadOeA4afvkpUZsjo9AKj0UZ+rC5
         lx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749793358; x=1750398158;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWWAL+VbrkpZ6XEFuM8I74/gE+9nSHvII7fIBjxxM/w=;
        b=MQMSoYERE9UHf73i0d2FhRrxwGo7XV5upEIlhF0+Rik5JkS/h9y3pVSCoPlYo/bldu
         fjC6/Ka4WxAzTRcm2Nl41up4EDWXbFfh/0sxKR1XZaYqPSdwrKMloI5xnWrmTg2mAlX9
         uh8biVrgA34LOq5yrumO/YMoN7yJh8ses78sPVejCVQM647AXZE6R4K1BqkZf6mTJ/hc
         JRo6vsMFEMlyuw0dcDVww3r4fYrTZnVJNfGpay9jHqz3YNiW+qr1eiwNYwRpJl6A3wFz
         8k0NXFjSkzTsl6p6F2uuqfSjrpKvuJMrZyfXtJOh1ndEZHBmJELEfcfXjO4JEt1IUWkz
         scdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRAuRKWDonUDuX9zPpgDEjVkjlw5YNr1+5LdyeUNgUde6qcVLKtS/AWLx8yw5tRww3UJY8ur4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN6gQMPQf0JduZXVUPMGcr4eHEveNg+aOhhoXrPC+YrFhYskoP
	BpGeUpqTDH08K7SmazOi5jNaTzsJZv+Z8K7LQWw2g9GuF+SnMXtSbGEKqz2MibZD8C0=
X-Gm-Gg: ASbGncs1Q2huuC97kXIsI8PKFKN+FOw3pLBq3cS9VXKT2fFtcDH+BfSdCzsUoU3M/9Q
	R94xCi8GmEMG3/XfqxpLFWktvrZ0rHH/45CD1epLxCZE1P6LNDIsEgz2wCFonMU/oJYwZHQ+CTX
	eBJ3+rBobGAHH7mNr6jH/e8pTtTERBgWbGaSj82OcaGjEed7P5fvuPNgrcAy6gshyiOqCwKfutU
	nh9pzoyQghhralFBnI+QNW7MiiQUjgmmVf0orgj23BS3qkGplZrZo9/TE03rnJbj8PWCJdcu0xr
	t4Ke9efBq5pFKKR2UehxNpR0lwXspFNAQygSf9IX9g6yY9mj8lb5hALbOIcpiijkLhk=
X-Google-Smtp-Source: AGHT+IG84uiDT4+CauM9tguckCETuGhZolZLjTHippDm6PpPYkpCe5j3nAJMU5AMWProksAHkDncGg==
X-Received: by 2002:a05:600c:1386:b0:442:f4d4:546 with SMTP id 5b1f17b1804b1-45334a6d158mr12403025e9.1.1749793357591;
        Thu, 12 Jun 2025 22:42:37 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b087a9sm1273702f8f.55.2025.06.12.22.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 22:42:37 -0700 (PDT)
Date: Fri, 13 Jun 2025 08:42:33 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	bharat@chelsio.com, benve@cisco.com, satishkh@cisco.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
	xiaoning.wang@nxp.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, bryan.whitehead@microchip.com,
	ecree.xilinx@gmail.com, rosenp@gmail.com, imx@lists.linux.dev
Subject: Re: [PATCH net-next 1/6] eth: cisco: migrate to new RXFH callbacks
Message-ID: <aEu6ScZdFW9Dlc2X@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, bharat@chelsio.com,
	benve@cisco.com, satishkh@cisco.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	bryan.whitehead@microchip.com, ecree.xilinx@gmail.com,
	rosenp@gmail.com, imx@lists.linux.dev
References: <20250613005409.3544529-1-kuba@kernel.org>
 <20250613005409.3544529-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613005409.3544529-2-kuba@kernel.org>

On Thu, Jun 12, 2025 at 05:54:04PM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> This driver's RXFH config is read only / fixed so the conversion
> is trivial.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/cisco/enic/enic_ethtool.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

