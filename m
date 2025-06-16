Return-Path: <netdev+bounces-198137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B2BADB5D3
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD690188FB61
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B9526A0F2;
	Mon, 16 Jun 2025 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="1hVYtNBo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6871320F09A
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088771; cv=none; b=ew9D+EhDhscn/8/x4gnXJCPrBW5oboqgV9xaAX8cK9aSUFkyshWXbfP7fsIuZLuk7nqM7XYP3kZWWcM17Rrs0671auOrm8RTvXevkx6UvPDDSyPa5SbaE+dnDzUXIsdXC/IodfmG37m+/5HKVcb17ppNqXL1PG1nthpQ1Er1WRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088771; c=relaxed/simple;
	bh=jYvKBBGoQsaB69Pl1Nz9L1WYoE9u5ZPj5WCOapiu2K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sx0OuE6HKSkNxrfq2KCo1GE2aESQY39FaZdqttJHisJk7QxEKjxfyl1nEjyZE2noO1irDALrZDEN+PZFOd8Q5vI55mULzDFRM0dHV8UYUsY+rE2Oi+3N/CHYG47lAIWpIEHzoKFKWgqhT7cJ5uhiMOUuZLXYgWyHGvd4uMn/QkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=1hVYtNBo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4f379662cso4114327f8f.0
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750088767; x=1750693567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFZY7ivm1a6iFjbcG8oxzsLPAoqgNHYn501cBEjAinc=;
        b=1hVYtNBo9/vyPjFVnwfK3qe6nfWjWp2eJWglirTyGyHlh9cPRwigq5oS4dTGVIT2pE
         +h57KhSqXVLMEF0lW/KAeS4CB2BY3LhmK6Y+t2bCWqIohy9XPcLP+EP4bUrkC6PBMyyA
         bJ35KAsLgOW5Tw4n2396BHcx0zZ81Mz/I2mOr1H5H+G6RUfzp9oFSIR5igwB5ui0jXLI
         zujHgjIXDcgKlqfm3lO3+jR2IKFjUbnAbJzsz1gPwXa9Ki3Y/QO170CzxGdeWzWrLAcC
         v5aoCmBaEKJaZbO/fYYBZc6LgQOHpjakSm268YunjOPZqtVTWACdCr9JKTJCYpKhVLqw
         GCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750088767; x=1750693567;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFZY7ivm1a6iFjbcG8oxzsLPAoqgNHYn501cBEjAinc=;
        b=kvM8bOGy39tF1qf5hX6kUkXs80U9fQYJTwzCxNUO9C1a46kr7LZNQ5+fstDqvnhfGS
         fYTokzlKlq630VDgJh04WFL8maA7J1iXs35e2sKOlNn7j9aq21LSvzjLd0oMl26VsA8C
         npeaSC/h7wCNsIezSpzRpSWJJlZpJxh0ryH7PYVANCy09yqcAWQtxtt89qm3k2hpSGmq
         Cs3McmqMVmYo9L7Z2rJMVcYE8uQxjEqM/TXNiqxEGnSjn4NfhUHe7orzQwKVLNvkmDgC
         Ny+dHht+jRjl5iIizTPfxE1/tplb3QVEvs+BJFfLY3RzogTRpOmxuxMJHFwomozu2vvM
         aVng==
X-Forwarded-Encrypted: i=1; AJvYcCWBpV7ninUp7GXVgZj8VrD+GyBKJmwkd/q/dZcj3Y3bvNLbKhMUihMyfOuDTSKmpgsBEOOII5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHjyrOBxoPTvw9GjfaWd8jpnN0L1QIltybfifNLyagDt0QveFG
	gUSlJTqp1WTozBTki4UGI6Qdm9ss7eDdl8vKjs54MpLSCCrElvo47ErdVBTYxZ26rQo=
X-Gm-Gg: ASbGncv4wAs/G+V+DChoSvsZjYm28kL9O0q5QLSx41tAK1DZUiTUXKvNzN0+rkjqI2r
	Y0kfeTcW2zcaC6pfjq1PiG97Vcf3kvOrohw05FgDgXbroA3aaxbwgWsNBKLMNSS8IYkuzCsGgwC
	sJp/5q03g1CZ06w85Pt6ITV4H7wXFaj5556lwOaIYusOQZNveoohx5uvOgUEnl0aBBV3XCDX3L7
	swE8mtx4PAf21faoP7BxS9o/698mRcZA14KWFlq26cy++cTt/o4Wk+pxyq8v+nGFb5B7pTxXHau
	KVeTy0EdlzRZdx5KelrPaMzrwa20o13VGryooWgFRunrdrGSfcWuhAD2y05GoUDJWZQ=
X-Google-Smtp-Source: AGHT+IEt/30I++Du4WLml4SC2pgcz2vdPzvcuBNh0U+CmdXoLVZMp5wzQZkp7cbhCbobFlfshCULrg==
X-Received: by 2002:a5d:5889:0:b0:3a4:cfbf:5199 with SMTP id ffacd0b85a97d-3a572367ab7mr8439463f8f.9.1750088767639;
        Mon, 16 Jun 2025 08:46:07 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c4b1sm151608895e9.2.2025.06.16.08.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 08:46:07 -0700 (PDT)
Date: Mon, 16 Jun 2025 18:46:04 +0300
From: Joe Damato <joe@dama.to>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, jdamato@fastly.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v2 2/2] rtase: Link queues to NAPI instances
Message-ID: <aFA8PEZCAInzMZnM@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, horms@kernel.org, jdamato@fastly.com,
	pkshih@realtek.com, larry.chiu@realtek.com
References: <20250616032226.7318-1-justinlai0215@realtek.com>
 <20250616032226.7318-3-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616032226.7318-3-justinlai0215@realtek.com>

On Mon, Jun 16, 2025 at 11:22:26AM +0800, Justin Lai wrote:
> Link queues to NAPI instances with netif_queue_set_napi. This
> information can be queried with the netdev-genl API.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  drivers/net/ethernet/realtek/rtase/rtase.h    |  1 +
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 19 +++++++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

