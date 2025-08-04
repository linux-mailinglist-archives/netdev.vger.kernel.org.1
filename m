Return-Path: <netdev+bounces-211535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CFAB19FBF
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 12:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380243AFC8A
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 10:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6373523D2B4;
	Mon,  4 Aug 2025 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8fNn+pU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49EA111BF;
	Mon,  4 Aug 2025 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754303459; cv=none; b=D67vMuwXtFjHB4DuLnNyZEhbZo8zUupnw/ceOaNXZb2PFRF2rjOxc0TUJMOhkV143dbIo643NxZ6Weg7ArN+i3wfq5cFf6kqUttN/CcyrvkdYboXPtd6VlmkkNq/AZ2/9QT7cOyZamrgbT3lP6GhBPazK7Zg3xLmSiuj3R4Ys8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754303459; c=relaxed/simple;
	bh=J1jdNlvrUSRlxzKkMDDekGnrpMkwd6C9+Od2BAbalvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3ZGK61U+7jJhQpVxENaKTCkWSQYodSmgkrPWlV98F+iaO0dHzu+zq3TPurSk+IdFkSniSm2YCVWNLjxuJUoj2seT7cTnsg9W+w45j6iVjA17FI8UCWFTqhJXJxTUeIyC/FYd6+hyJIvev61eb7cgKvE7Uz4bAFB72C6YrpZZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8fNn+pU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4535fc0485dso8651275e9.0;
        Mon, 04 Aug 2025 03:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754303456; x=1754908256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LgnEf0MqZyks+yJGYj1BbFoFnXRpHITiqweCxnwWqWw=;
        b=L8fNn+pU9Ew+xtdP/YhVWopyPYsVXmHjOz6L7C8mlNGFCdLhZZiHLnKpaLBlg7WBiQ
         8XaEWCpwpKY7jAxkkpgHzP9VHN/vAp9pt9zK5DRZr+wNGWm4RAp1qtqvR8OFqMysahfo
         5P2Jmv+FSYGHlriYlDGoE+LmlaV0uesIL478ewm79x+JCZ700D9hzyCOSOrc8Huzxy/N
         RF3iJygxvhBjYJkGEDoug4DF1jXT1yx/YlZ5zzIOiuM3eFRT+OHUfipzWzBv9JUQQIY7
         gvt/1QWSK0Djei5scod9rY++3WPCU8YxPrP+Lk1b8PL9GYfDQ2JZNSNXcgh6mnQehkns
         Zhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754303456; x=1754908256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgnEf0MqZyks+yJGYj1BbFoFnXRpHITiqweCxnwWqWw=;
        b=GBaHCY326CFqTGN4XRoU5BtRweH1wPAkc+TiaIoiP41G5LQpDCUgDjaB13yyLS3GPM
         0sMUiGg+8cUF+SaT0Od6/dexjr2/3ybeLP7LGTSukXhqkjMjD0u0xG2oYZMpQwbyIPCN
         CxlkTGAoyrW+BQ84ETdGswI9E4XXsN/kiBi3xcY6zTCFL3M7F7EwhswWNRXmybHL1Bv3
         f9Skklp+G+SMDWS21FaP6p+wZQ9ukIydR40B06n+eyQ5X6ClaeU1fRD2+XQZnQa9y1Zd
         O6CSAxHjjlBAcO5GKaSFaNKAY6l6wlBx9Jh3MvzzlCnh8UI+iR3odmvarzE/Fljyd2wC
         JJvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCiuUQGU6Kc1dftHpGN9venW5RXRLQA1UVTuPKVgryuQ7FJhCfOzmxGEjAcVPr9yZ30S5oJoVGk7RQoOA=@vger.kernel.org, AJvYcCWCJU9iYhD3DXqzrbBvSwFfTbARsuiF6Q6Tt5u/G/roKECJ/bFX3Fi2OO7sZNTwAphtWnYPaV7r@vger.kernel.org
X-Gm-Message-State: AOJu0YxagBLVqe691HA5P2ImA0pQKcmYEYKr7F6tMzE00D4ni1iy+c1T
	avVaeiD1Np1TREiMVRPZghGO03nvyQcPdqOUbgc5tLQIKpKgLOcTvKZn
X-Gm-Gg: ASbGncv+3psviQL/9fkcbU2fYH6pa7hEBRfcgJqPEjtzP8nIvSXv5FW0nLE8e+jZQLO
	J59bzv+LjFQJkmkS++1JnR51lMdidF+f5knEEeSbRM4xnZIJcC3zIfkdB1/kCjBC5rhPGZW95Qf
	NoxccdJoG/ZXNIHjUFxtfFLZ3wMFZYgP1Sr6rlKu+dDMSu66J/8+N4iM9MiLCSBSdyvuLOC9LA3
	kl1EhNgrODwEbOmxw2tsImZQX1MV2UVAeS64hkZ8uR0d48Bf7IN8VW3MmnLDb/5xsktcY1vJGMc
	xNud6+L4Ccwl2F2aWO0h6d6TMST1D73VhargucY3d9QsulcbJyhKkg8l4dRulh6j7O+kkhIKYtD
	XvXcRQTtmqUqSBto=
X-Google-Smtp-Source: AGHT+IFvt8vSNOolVnnL0sorpSR3BsDuwnU6GPRvV6+xiNBrXazCnqvMOVTSfvDSf4XNYiWZAvsXuA==
X-Received: by 2002:a05:600c:c170:b0:451:dee4:cd07 with SMTP id 5b1f17b1804b1-458b68726f9mr24211425e9.0.1754303455716;
        Mon, 04 Aug 2025 03:30:55 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d30d:7300:1652:4e3c:1b0b:e326])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589edfcdd0sm161502065e9.10.2025.08.04.03.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 03:30:55 -0700 (PDT)
Date: Mon, 4 Aug 2025 13:30:52 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com,
	viro@zeniv.linux.org.uk, quentin.schulz@bootlin.com,
	atenart@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] phy: mscc: Fix timestamping for vsc8584
Message-ID: <20250804103052.nhpboyqcybwhomzl@skbuf>
References: <20250731121920.2358292-1-horatiu.vultur@microchip.com>
 <20250731121920.2358292-1-horatiu.vultur@microchip.com>
 <20250801112648.4hm2h6n3b64guagi@skbuf>
 <20250804073940.4wgpstdm53atrbbq@DEN-DL-M31836.microchip.com>
 <20250804102432.lv7pfistwfbql64q@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804102432.lv7pfistwfbql64q@skbuf>

On Mon, Aug 04, 2025 at 01:24:32PM +0300, Vladimir Oltean wrote:
> On Mon, Aug 04, 2025 at 09:39:40AM +0200, Horatiu Vultur wrote:
> > I think it is a great idea. I can map struct vsc8531_skb directly on
> > skb->cb and then drop the allocation.
> 
> Ok.
> 
> Another set of suggestions on the patch, all regarding list processing:

One more: skb queues (struct sk_buff_head) have their own API
(skb_queue_tail() etc), and more importantly, they have a spinlock
already. You should probably use that.

