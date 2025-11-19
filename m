Return-Path: <netdev+bounces-239920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B84C6DF8D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 072DD2E02E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE042F6180;
	Wed, 19 Nov 2025 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXOzQNez"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8933F346FB8
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763548015; cv=none; b=H6b3VAM73js8er/mqjlsTS0tihbpOGav6x7+WyEYg739GqCxVpsnzIDyxIBximJfYnz+QkVrBD2OslqqgXDLSYBZNX2sZ4fK7smpPNB87PRQ4PSlR+LIfCOCjDvdaYFAT1wOxuc86PNP51LkTJgSNdsS0oZrtFzEMTzDwYzcKB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763548015; c=relaxed/simple;
	bh=oxmzroMvZ5AU/n1HFTCRga/pJwfJ1i0eGYNtmLdrilM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikG5r/3AqCCNE10qUzBW3lnuW4fdal8vEGrm4l1InKFA2s2yxKZjUOrlOQK6gLXYpeY3YYrqizTdq94HJTRfiVn5oAPvBHQax3igJXBP+qw97sP+WF6A6eEGJ84RJC0tbiIF/JEq8OBgZ7T/5FBXfrzrkT0v8BZeJZwV6LbBSjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXOzQNez; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47790b080e4so27958575e9.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 02:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763548012; x=1764152812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oxmzroMvZ5AU/n1HFTCRga/pJwfJ1i0eGYNtmLdrilM=;
        b=VXOzQNezhUDgs6XVo7bO+RblyoW6omBfAA0ike+5QQFUva+Q7lk5WNvBcHU11hJBpn
         hHBdi/6vmQvPyFpuMOE4YGggPv8hkHMzk7K5O9bDpzGn7cUAWodNZRuCZ4xxCYD+lbp3
         GqGAz9uU9StTERsBAEtF5BlTqPY9HaHuqHcw41m8V8TpqpXenyMh1W1cBMrT5nomszFM
         nkE76Kg2pUmWIAuairfLNbKW/QyQurckqkN9kKdopthPPcLlMbdSghhI3C7c0C7XTcO0
         7KCTsegCXQDiL+/fpPNedeWJr9rpb85L+CrD6uzmx2Yfcl+KaMOdTpv2BmHSNfUpk5pb
         8v0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763548012; x=1764152812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxmzroMvZ5AU/n1HFTCRga/pJwfJ1i0eGYNtmLdrilM=;
        b=gmM9zS4lgh1X5XzOta0wpv40tYEFnfGgRABztBLdzIQ7JTSuSHiuCdSyCadDFrISOb
         O/wspWlg1MOXqy2ZARkN3qfUffMVjrnlQiGtNA2i86v8+fbpAMGkAF6yYLy5kbBFBUQu
         b3flduzvhEfTUQS1s/a9zj6va53MrPj+5JqTtba5z/MJhURQhOQrPYIUxnq+oRoWuJ+d
         pFs1Jci5uVizT5ImzhUfTmRGtG5Dic6duye0Y/x7vYnOQnzykIqKpgol66LW5iTqx9ze
         RiCvtLZ0jeCCWK6mDMPqa7dksllxqSH+8D281arcXgn2syoDsBGV+NUzzNBaOTzY7r7H
         Ia9g==
X-Forwarded-Encrypted: i=1; AJvYcCVlxZCiuLLcrNATX+MmV6A/VwE8UabjopwjAH7xX5Z/5BxfSeVcrhZ1il4MjC050jMIe8V4oIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYFQOij3wUQrPJynUM3YP2+7mJMo2gdouos+KCatp0CTkICv84
	lqLSLgG2/NUuBTw4C1Yses4VAZY6Fveww1I4STcJ9j6xOlav8Y5a17ZG
X-Gm-Gg: ASbGncuN8VhnJyMB6rUf64puT03YyKS8D9A7QU53gKrqq5bmfO4/SmSALy8OEKqt758
	hNW9OykQcpQXWYvRO/GxFR/lUqD7u6+SCdX6OEffaOMmzO0A38TX7KK7Y5BUA0Q8Wa7QTBdk3Ii
	nX6XRo0TSJ5fTok0NppXvBU/bkNOp2QfcSVaJWRXU4H4HVKZm5xzl7C44DCPxw6BQ20vUwvEgDr
	i7M9Ijam/VFTbbOHCc391/R5sSbEKZlprzjGkAdZ5nCEgp00CNQ0fWgE2xQRhDCSDwoWAcbImWk
	JXJsc6+Gi58guFHFJ2eflE/b2YwPZO/QdYClqLFEWhvKAT3Evr643ca/qrmq4OlAqkZMKt1Bgtk
	spUnogPM+Yrh41w0ZKjFBIDansB61xNtQYYHwrcivW0NSxiCHcIyCxym+Tu5cgxcz3zm3H7mL45
	KGCOnXZnOl5+vkcBs=
X-Google-Smtp-Source: AGHT+IFHDqYGurpdt2uHH5VOa/35juS3aBQUK8rSpUMtqfxD574D5IoNwDyfAoYeqEKbMytDMuEJSQ==
X-Received: by 2002:a05:600c:4f07:b0:477:63b5:6f3a with SMTP id 5b1f17b1804b1-4778fead9a4mr182793745e9.27.1763548011469;
        Wed, 19 Nov 2025 02:26:51 -0800 (PST)
Received: from google.com ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b102bc9csm42675715e9.8.2025.11.19.02.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 02:26:50 -0800 (PST)
Date: Wed, 19 Nov 2025 10:26:49 +0000
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Michael Zimmermann <sigmaepsilon92@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] r8169: add support for RTL8127ATF
Message-ID: <aR2baZuFBuA7Mx_x@google.com>
References: <20251117191657.4106-1-fabio.baltieri@gmail.com>
 <c6beb0d4-f65e-4181-80e6-212b0a938a15@lunn.ch>
 <aRxTk9wuRiH-9X6l@google.com>
 <89298d49-d85f-4dfd-954c-f8ca9b47f386@lunn.ch>
 <ff55848b-5543-4a8d-b8c2-88837db16c29@gmail.com>
 <aRzVApYF_8loj8Uo@google.com>
 <CAN9vWDK4LggAGZ-to41yHq4xoduMQdKpj-B6qTpoXiy2fnB=5Q@mail.gmail.com>
 <aRzsxg_MEnGgu2lB@google.com>
 <CAN9vWDKEDFmDiTuPB6ZQF02NYy0QiW2Oo7v4Zcu6tSiMH5Kj9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN9vWDKEDFmDiTuPB6ZQF02NYy0QiW2Oo7v4Zcu6tSiMH5Kj9Q@mail.gmail.com>

On Wed, Nov 19, 2025 at 08:00:01AM +0100, Michael Zimmermann wrote:
> I've also done some testing with the out-of-tree driver:
> - (my normal setup) a DAC between the rt8127 and a 10G switch works just fine.
> - RJ45 10G modules on both sides works fine, but HwFiberModeVer stays
> at 1 even after reloading the driver.
> - RJ45 1G modules on both sides works after "ethtool -s enp1s0 speed
> 1000 duplex full autoneg on", but you have to do that while connected
> via 10G because that driver is buggy and returns EINVAL otherwise.
> HwFiberModeVer was 1 as well after reloading the driver.

You are right, did some more extensive testing and it seems like
switching speed is somewhat unreliable.

I've also bumped into
https://lore.kernel.org/netdev/cc1c8d30-fda0-4d3d-ad61-3ff932ef0222@gmail.com/
and sure enough this is affected too, it also does not survive suspend
without the wol flag, but more importantly I've found that the serdes
has to be reconfigured on resume, so I need to send a v2 moving some
code around.

> What this means is that the fiber mode is always enabled on these
> cards, which makes sense given that the out-of-tree driver only reads
> it once when loading the driver. I guess it's either a hardware
> variant, configured in the factory or detected using a pin of the
> chip.
> It also means that it doesn't matter to the linux driver what's
> actually connected beyond the speed you want to use since - as others
> have said before - this seems to be fully handled on the NIC.

Yeah but that make sense, it does not really mean *fiber* mode, it
controls the serdes configuration which is used both by fiber
transceiver and DACs or anything else you plug in the SFP port. It's a
good point though I think it may be a good idea to rename it to
something like "sfp_mode" so it's not ambiguous.

Heiner: if I'm reading the room right you are more keen to have a more
minimal initial support patch: I'm sending a v2 anyway to fix up the
standby support, would you like me to rip off the 1g code and keep it
10g only while at it? Then we can have at least that hopefully working
reliably, as you pointed out that's probably what the vast majority of
users of this nic needs anyway.

