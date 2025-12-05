Return-Path: <netdev+bounces-243819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E582ECA7E59
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 15:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C7883203A9E
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 14:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEEA330B3E;
	Fri,  5 Dec 2025 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI0qeUry"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6A329AB15
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764943627; cv=none; b=k2hXvzzNB/bP3d3XBLpDlaAbHQV7yy2bVzE7d6HMEVGOgF03kAI/mF2nGtlBVGwzlih89/lGKQ7JQ/G3LxazMF2fgE85SSCtyibjcqQTkJttBOOpsoRh6DyJ4gIKsCFq2yX2OHb+t5sOVMSrGVgru/2rS1+Sc1P7nUjzMcRCNmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764943627; c=relaxed/simple;
	bh=v0aLSz6eztCCXc5Q60HoWtsEgndbijRcO8K/h9nqE18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrCX9gB/sgeoEUigG5/duMectzuUepQa5thchbAFXQJMBXj8nqBjROpuK1OZqoITzjrVj2H7WRt3iRei2iTa+G8UQUyr2STWpWsJh/+HkMgQoG1vNArBdgILKFCgRQ7Fz+ekvoMF2g39Z3maTMuxXjQcrUtxrSSR0bFKVoUAJ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TI0qeUry; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4775dbde730so2875025e9.3
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 06:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764943621; x=1765548421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q9++XxvnUn686kk2ddDofJD+D0ZU/VRf4pIN8y4vJ3I=;
        b=TI0qeUrypK/wyM0Fqaq91N5G4cxxF+ZjIB5JRJFIlGtmU21c5xWpjDtVb90bUPMVEs
         u6CqwaXs+MKG5uW94Qpy59OI0ffkL1SV/fWT6oU9xaiKtQ4Gu1piS5df8LBw/YG85PuI
         BPRgmgOdwvtXL07tXfIaADWXamxIurrr9skDhE8u4iRYZGVLmnQgyGkfFSo4NpQihOu2
         RpyPlimWZwQRrGJ66pjSTBWSGed9bHJBPTHGa3ERL0lxwhZ0awqKPNOiw31VZhROXQQs
         n7952aJwZqEOfV5SeyFJl/zylhXlM6COV4TgHnotxDCcvoScv28ZcXHHgLwv9cNrWFWU
         uGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764943621; x=1765548421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9++XxvnUn686kk2ddDofJD+D0ZU/VRf4pIN8y4vJ3I=;
        b=Kj78bKcFjDuKzzo/JIyjkHN6TFOCLGsbgfWub6rceA6bnnpXNr51WWrrj+d68fyYPU
         bQKtgPfaYU8aK7xWs60xkTetnPVCqrJvfiMNBAjckgS0O6LbyAzAJuCAyHhxAG8wtpIx
         Gtf2UfI8h2unR8Ng709pRoyP+bqGKM5l2Mw3elx0/VUyfGH/9tqufLEt6UEtCTCNbfAy
         8ntJ5t6fV4It0q8OT47QbVHToUniHQjYjGJqkTG0ZO7SafMPq7blLYvQxLdSdCLQ4ZVk
         CR1Rfn2mWFZCYPO+oKhzb/x2MzOi67TEcnkrgotnKP4naZBqu8HoLJMcilwaLBqlqdhj
         GouQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSyEAWkhUPi2lu2AlFXKXkM+v085sLuDtZZ2QYRPiu1BS4jYr6+NyqLuLwOeWpQJZBxMPueNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyImfKdH26U2wOtrrgVKqfbbGZNxKSXTaA1qDaTrxq58Mo9oBd
	eBk4ipvsFX5hMzukTU8b+AomI7Cj0UF/voQLxB/VD5O2OgexdIEUT2qz
X-Gm-Gg: ASbGncvGzbNPCoc0d+I+RdxOKL/ECG6hM3FD/OqOW/l9prJEXQqnIUZDO5QzCNrCTGa
	SwL7zWAlwnWcITOGih2OHUMyoHMP2EmoQXNaL1lYUTt7a+G38aer2Nu+YBoEo5sEPn9IeRHJdQU
	IOWZn4BdXmIz+ETESDjRvWZEiDO1L7247OS1jIKg7ahCIZYOL97aDKI8sq4DIyaRzlJpUaB8s/k
	1OM800UClPAZaRgQ8q6hN0GA89YZammEyFI88sSrqsHtzC5HiKJUx+49JTQhucTsbcmP+RPW3Rp
	xoUITNfCdVfGgPTHumjWGwihtW1vRnywcrdtgVZQHkdBBMWWknD3+smc4g79aAh5SFrtPAinLPZ
	UnGUyCKi2pvmHaEI84YVdUAb7L7QLfdJ3H/PTN3gcOBi6bd5nboMfKHGgGnS4fYoRBqrSq/QpB+
	32kw==
X-Google-Smtp-Source: AGHT+IG0wT+8z7qTds8v5+fhOTpqMvzgVhp1qMAUU1xLhi0SRHqu+YGYMW+KXhxXqSyk0JI3SZhWpQ==
X-Received: by 2002:a05:600c:630e:b0:477:9c40:2fa1 with SMTP id 5b1f17b1804b1-4792c8f9e58mr46567795e9.4.1764943621044;
        Fri, 05 Dec 2025 06:07:01 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:456d:8d57:7a7:f1e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b17588asm60066835e9.17.2025.12.05.06.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 06:06:58 -0800 (PST)
Date: Fri, 5 Dec 2025 16:06:55 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Hauke Mehrtens <hauke@hauke-m.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net] net: dsa: mxl-gsw1xx: manually clear RANEG bit
Message-ID: <20251205140655.mxe32abnagpvjuri@skbuf>
References: <ab836f5d36e3f00cd8e2fb3e647b7204b5b6c990.1764898074.git.daniel@makrotopia.org>
 <97389f24-d900-4ff0-8a80-f75e44163499@lunn.ch>
 <aTLkl0Zey4u4P8x6@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTLkl0Zey4u4P8x6@makrotopia.org>

On Fri, Dec 05, 2025 at 01:56:39PM +0000, Daniel Golle wrote:
> On Fri, Dec 05, 2025 at 02:45:35PM +0100, Andrew Lunn wrote:
> > On Fri, Dec 05, 2025 at 01:32:20AM +0000, Daniel Golle wrote:
> > > Despite being documented as self-clearing, the RANEG bit sometimes
> > > remains set, preventing auto-negotiation from happening.
> > > 
> > > Manually clear the RANEG bit after 10ms as advised by MaxLinear, using
> > > delayed_work emulating the asynchronous self-clearing behavior.
> > 
> > Maybe add some text why the complexity of delayed work is used, rather
> > than just a msleep(10)?
> > 
> > Calling regmap_read_poll_timeout() to see if it clears itself could
> > optimise this, and still be simpler.
> 
> Is the restart_an() operation allowed to sleep?

Isn't regmap_set_bits() already sleeping? Your gsw1xx_regmap_bus
accesses __mdiobus_write() and __mdiobus_read() which are sleepable
operations and there's no problem with that.

