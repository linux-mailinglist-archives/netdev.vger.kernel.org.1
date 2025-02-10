Return-Path: <netdev+bounces-164582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC025A2E53E
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 08:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1463A5321
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 07:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E4A1A3159;
	Mon, 10 Feb 2025 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrsHcMrW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17286198E8C;
	Mon, 10 Feb 2025 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739172136; cv=none; b=DIXWDRbqyLWkwdvm3c62Z2lWVB1IINfRWm5T8UmewEuSDcHkvQWvb0WYeDv6dke0kh+PnOil0tL7Y0ZfRfpPCjFU64bAz9E4hVOE8GdaRqok9L8nwb4L9gCec30XHtSQkkUI3Cc8XtOzB74ed0wzUoqCwy6hI74DanYEQyelnOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739172136; c=relaxed/simple;
	bh=0F3FlD9Pfc8KQWwxXtSJ8R0axhweOBOY6Fso5tS46b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG4YrihgGmIrA2u5mmexYRresVSJnW3l5pbKstCCIfy14JU4YWqGsgnKdqVGLvWxTATol4bTfeXN+/Y5wKjS8ispGkBupoqsHiVDaPw51yAybNh/QDAVuJpjz+hJXM+oN5HyOt9wlWSY7etsc2lMvcO21j/YnpZ6Eybm6oCeejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrsHcMrW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43622267b2eso40358375e9.0;
        Sun, 09 Feb 2025 23:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739172133; x=1739776933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWhUEOTz7NAjdQTe76b2+gajv13F37YsdelF+ND6FT0=;
        b=SrsHcMrWAOy7ANPposC89rYRcHP0OcVoFwj636MXqGyB1ZjVz9od92qbGDb4y/3mIr
         NBuRVz3gyv9Jv6wvABNukBAcNvkx/TAnydTRsUFUtedFKzCRbUQQaA5wjRv56r87p+hf
         MuiBqHf9/kGplMPU/68vWyd2EyTEUex415Rw+gv7XpO4l9V6y0tMY7Q4N5ECTMZHY1X2
         Ic77jmIdcOQ+ZRJy/wgx7GbI2VuPRzcj9eIv6qMGD0WGsQW/ESjKFZlSbZjjKXwKNFgV
         bd9oLPP5hUQLbSWNRGnpriH2qnlgFqHpuDC6KniZDVfttN8oghuMuCWohHU2H0uk4JlS
         Lu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739172133; x=1739776933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWhUEOTz7NAjdQTe76b2+gajv13F37YsdelF+ND6FT0=;
        b=AQYs5LyS5R4/4tMt8k/EmnE3khJrW4q4smkhAfX0f9Ga5uLnBmAeOPEZ7oWJ8lfccx
         WNg8YRaYUGPSSYAnWZuk5wbX+3WpOzPDF5hvIeWPWZsGlIfXfcg+L5NBBoe2zbLSg8pe
         kHqLQn7CVluhS3aGc5sMSOKp/LuClUdwpvSmlaKpOXjVktSOLBykq4/IqJTGNWwkby5i
         JMZAzCKgaUZYA8+ByFJnoMUti/8Z1OwrJDKnJf32fS+wdZjTpHKtKpYuijadT2bc3M/n
         SytWXS4ETctryhfXAeSqII6bl7+J7nwNoaAGw5i1ZCG3K0zT9DnRTI71pOZBDmBTaAc3
         cM8w==
X-Forwarded-Encrypted: i=1; AJvYcCV7LR+5oiw2qW3fyZE+a9qwn88m95YUU+xKm6bA40phkajMEchsNC1185ZHoVYo/+hCJdsM90qE@vger.kernel.org, AJvYcCWgskVZR2qaJJTgZ3J6V+N85bSKoFkwDm5kksm2fLVBc0MhV5+qsjasV6PaJlzsbr3sKHmC8QwKKtJaBZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb9vmo7JdL5+xiD2Hyt/xNaBwHuvzCGBukXXV/wijeVMi7Ajgj
	5fbnsToebcCYZ1wLluHdATlLEhjr+mgpSRayFwf6cG5/KeInZSdl
X-Gm-Gg: ASbGncuWfvbLwtRiEO0aRaQ2Om6JFlNkoNDHWcpXOdqdg0o1x3Y+5+vwvrYMTmhDaAS
	ia0abpOaFCGOlXKWguiJrKqHvURg8db2fbXumaeuJaluTpl9VXrEPYR6GEtAd4PmyjArzQUz7kr
	B/M/mtycBdIIdvkuSqBoIS4oiAeE5msq6X6yyRCpmbBXfZsXbZL90LvsqLdIXjCpo+jgdLlkdBE
	NnZhY1na4mA8Uv/S5TqPN71atNmcXGAmW3FYnz1dMPEv/d0kIaQXyWWCAymHTq9mZ/ISE72hyue
	3aAcNRT/spJii64=
X-Google-Smtp-Source: AGHT+IEA0jsVCFpxuFcvOyCb0vtOtFd0q4rm1UdtDnrMoG8c+kdWh7Uxs1o4qtTltvMbYSgqTxKA7w==
X-Received: by 2002:a05:600c:5947:b0:439:4706:ae04 with SMTP id 5b1f17b1804b1-4394706af65mr11421595e9.16.1739172133066;
        Sun, 09 Feb 2025 23:22:13 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:1e6d:7190:f4b8:8cea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439471bf782sm11085275e9.39.2025.02.09.23.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 23:22:12 -0800 (PST)
Date: Mon, 10 Feb 2025 08:22:10 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: marvell-88q2xxx: Add support for
 PHY LEDs on 88q2xxx
Message-ID: <Z6mpIpjM1l5vT49W@eichest-laptop>
References: <20250207-marvell-88q2xxx-leds-v2-1-d0034e79e19d@gmail.com>
 <Z6eJ6qPs7ORuOrbt@eichest-laptop>
 <20250209084135.GA3453@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209084135.GA3453@debian>

Hi Dimitri,

On Sun, Feb 09, 2025 at 09:41:35AM +0100, Dimitri Fedrau wrote:
> Hi Stefan,
> 
> Am Sat, Feb 08, 2025 at 05:44:26PM +0100 schrieb Stefan Eichenberger:
> > On Fri, Feb 07, 2025 at 05:24:20PM +0100, Dimitri Fedrau wrote:
> > > Marvell 88Q2XXX devices support up to two configurable Light Emitting
> > > Diode (LED). Add minimal LED controller driver supporting the most common
> > > uses with the 'netdev' trigger.
> > > 
> > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > 
> > Reviewed-by: Stefan Eichenberger <eichest@gmail.com>
> > 
> 
> thanks for reviewing. I just noticed that led0 is enabled in
> mv88q222x_config_init, but I think it should be enabled in
> mv88q2xxx_config_init because LED configuration is same for all
> mv88q2xxx devices. What do you think ?

I think you are right. If you can move that to mv88q2xxx_config_init it
would be great. You can add my Reviewed-by tag to the updated patch.

Thanks,
Stefan

