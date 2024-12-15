Return-Path: <netdev+bounces-152042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDCD9F26EE
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 23:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8828B164DAD
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27271C07C0;
	Sun, 15 Dec 2024 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5bMeS+u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4052B1B2194;
	Sun, 15 Dec 2024 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734303557; cv=none; b=oFsazhE2fSDCN5P8oI7UDgpEPpYFhnzzWvcka3386vYIy0pOVT2+U2P0tWifE/L4TpyqpxmasOmRAT0a1d6e9b1Y0jldK7YhVIfvq6W6Rsi0KotNILbLRbI/2Qq2uelpwp181atGw3bcsGwNmh3by/o26bcq5LzRj4+uQ4xcBCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734303557; c=relaxed/simple;
	bh=jOiAt0FFVAODdlR4nBQCvuwfcvnXZJmqMHcsluJaWhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE6rzbtcHsNcJfWDZwaOtocqoKCo13X1rJ7o4pTkfIj23QZc1euEaRIzZXfwkYpU81Cdb9yJtWUHGkkGZabEpQ5UuMYdUAlxbsZloyz4jMYGvX5p9v5nKsvZdQbHJSQ/5ycRvQ5YH/AvHmFFiy50oZCf5v4vNUj5kwQ6/h7eFxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5bMeS+u; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa67bc91f87so62363866b.1;
        Sun, 15 Dec 2024 14:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734303554; x=1734908354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o8v9+vx6+xOazPLAc3kEkq1Nldt/fUvK0TpKIO0FOlI=;
        b=b5bMeS+uwwnyHwEbHWMpAfee4TjnTgYA/iae+mp2q2DNmUrNhq4fRo8+d6zKn2eT3H
         6Vt53WJxUMxbu4faYQn7k54A3iualpEvxQAlSwnx77hmhIZnXOmctOwXct5/0Q0FZ7jg
         Gluzl8Bk7aP9PRA4sjyoeY2QNTOUIWnBhRA09m31I4L/39DM8uusgyMCAknQOwtoQscL
         U2YFRE5aIiVxufUM23OSl0cVM7PdDjp585wzTjLYLOiPx2BDGUkIjUQY0bya7VgOmA09
         lF8yrVd0vgbE0wEWsXGqTwbEPsZCd/LyWA4M6jcM/MpSV5MLHLHxsQLHkP0XqgZjMwFT
         dHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734303554; x=1734908354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8v9+vx6+xOazPLAc3kEkq1Nldt/fUvK0TpKIO0FOlI=;
        b=ZUiZhRVsxmn7mswnIFrv42OhmcqAU904OApPR3VqYsg4HynMM0R401e65XrXTuPx2J
         XAS58v8B5bi57Dh7bdPdbEX1/PCvLnME/+vora+itWxq/my6tfabK5aAdI+IO7Y6prrx
         rwW5cFSjq6EFREynG4ZoO+XGiJjXECnt2mYNVnTZA098iOghLFF8pypNjYAV5+DN3lpz
         0mYtuGAI92t5hbC2HiVqIyp/zzMvBmzXb+KBXxQmXAEptdKoEqy3HHmawXoSVJLwJKsy
         8+3Ur8OC7Lsd8OZOeiYppCPcCNe0Jz6VZcgp1+VhABNAenTD4DVNjmALnHLNLt1LpW7C
         +RNA==
X-Forwarded-Encrypted: i=1; AJvYcCU/iBoQpQQl30TCaq4qu5nxofVvvyDLon6gjAwUytgOxU6RbMVG3xya4udd00SuKU0YRY6+JhYN/nUqJnY=@vger.kernel.org, AJvYcCUNNNAtRNj2nffmhKzV28rgg1qHADSaxwhc7sAEkCrBG3kTIXhTjz/0IJsMFMPS6dIkujpIaw/r@vger.kernel.org
X-Gm-Message-State: AOJu0YwIsqhk0NZXyYxK7VSehbZ0204W7GcK316vi9Jr3x69zKjoB8xC
	yePUgs9S+zgVgKTQ4JRQZL5Y4Owl/BwRtegqIjhIlh21qHhkAjre4/d4HkgD
X-Gm-Gg: ASbGncuyKJsxQD4ZH0VOxSHf1tMxzIROeyaXLv37qC+heRspLn9964ZOVdbSG87b1qL
	oODpBCpqvwhn2LiYV2GWDIetjXQPoyr72njrRSC4qSYyA8EvG5wvVeA0MguLY1O1guAKsgtdDL2
	RwJvm+EUcODSoXBVCncziq3isazi6yz44zUF/GMz0OY8O5cRShM0p5oVtAO/XwYaTyEJ/Xjyzo8
	4iYC+djeSBBSOrWWL2ZJ1+ysiT0dH4Dz/QvOLACpaXn
X-Google-Smtp-Source: AGHT+IF99cAVkDOYkgK1uxKEKBnHjC+hB/3Kck0b4KRo94f282ERAjq/jZfQKPBED3oQRXuzQR7QVg==
X-Received: by 2002:a05:6402:3489:b0:5d4:35c7:cd70 with SMTP id 4fb4d7f45d1cf-5d63c302364mr3874928a12.4.1734303554303;
        Sun, 15 Dec 2024 14:59:14 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652f25a39sm2438433a12.69.2024.12.15.14.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 14:59:13 -0800 (PST)
Date: Mon, 16 Dec 2024 00:59:10 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mattias Forsblad <mattias.forsblad@gmail.com>
Subject: Re: [PATCH 0/3] dsa: mv88e6xxx: Add RMU enable/disable ops
Message-ID: <20241215225910.sbiav4umxiymafj2@skbuf>
References: <20241215-v6-13-rc1-net-next-mv88e6xxx-rmu-ops-v1-0-87671db17a65@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215-v6-13-rc1-net-next-mv88e6xxx-rmu-ops-v1-0-87671db17a65@lunn.ch>

Hi Andrew,

On Sun, Dec 15, 2024 at 05:30:02PM +0000, Andrew Lunn wrote:
> Add internal APIs for enabling the Remote Management Unit, and
> extending the existing implementation to other families. Actually
> making use of the RMU is not included here, that will be part of a
> later big patch set, which without this preliminary patchset would be
> too big.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---

How big is the later patch set? Too big to accept even one more patch?

There is a risk that the RMU effort gets abandoned before it becomes
functional. And in that case, we will have a newly introduced rmu_enable()
operation which does nothing.

Could you splice the first patch of this set, providing rmu_enable() for
some switches but not all, with the set that integrates the RMU with DSA?
If the big set is accepted, a trivial follow-up will be necessary to
complete the support. If it is not accepted, we don't end up with merged
code that we don't need.

