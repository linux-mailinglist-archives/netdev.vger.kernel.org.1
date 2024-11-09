Return-Path: <netdev+bounces-143562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F03E79C2FDB
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 23:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8237A1F21A94
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 22:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39D914B976;
	Sat,  9 Nov 2024 22:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="YtPy1bZt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9992142069
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 22:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731192820; cv=none; b=Z8vmGITDBScB/aO931ToFw3KrQgaDSb0XXZV4BLUyfN7OuihzzUGgjJJ+NjBiSLnn8JPUXZ+Z02uEtjhJfv9jr9QKRVn42o3rHHZGplrQLHCHEvraIOynSGwFeNbmr7mJ2zAAVW614grnqlfS0wtpUtAxFImYSE0lRUKDkwCUAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731192820; c=relaxed/simple;
	bh=Pi08cL6UT2iPFeaNLLpN9s5O5h6FedmR3QRx8YXCeRw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpRNIae2ZUcNi+SV/c3Fd9wiT4mIDLnd4yoBYvjqva1NAtUO9tp+SqFt7E8ny8UXULEDhJggbYb2Ins/hdduGMbazyZqi2au7JXZsSJZNVg/JQYxlYdmx+a+2cQmfFqFTVmth8b4ZaB5FiTxR1xBwPBwuAT0JNidrmmABXt6xNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=YtPy1bZt; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7eab7622b61so2354335a12.1
        for <netdev@vger.kernel.org>; Sat, 09 Nov 2024 14:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1731192818; x=1731797618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c83l856eT3b/6CKBxaox0d4BCkWDrxh3vN6+Tak2So0=;
        b=YtPy1bZtByzttfWhsEAgQcUtknSRO0P2n4F42rILx7EWFT/2hJznhe3x77MveoafgW
         qTQmYU++7H3g94YI4Lti/VwonfII/8z7PRqZC9BYbJ6OjApuxBIeHf15we4SOLq55Svk
         zW2eHRDomroVwpj9ykj2BjJecdh36d8GGA2vUXyhFDYxY45eznMeNeK2boB6W2sfpQVQ
         Yd3HNBDPbq4WhsDqA6ZBAWXmldfwtvmqxh46L6KgaWRxrQhHZ9y8v7PJ31qVUqHys0JB
         ShR+rVMGBVZPl1k/xOKG1NldHAXas7/8o6REZpB2ogX4tJWK4c6Tj8e3G7RD0J+R2yYl
         umgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731192818; x=1731797618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c83l856eT3b/6CKBxaox0d4BCkWDrxh3vN6+Tak2So0=;
        b=LP/NFKjsJ/V0b0y61Uhzsi/r+WqTx1DehqBLzK2e51K4JVxuk75kqvX1XRgqQ1Mb6G
         QMIzr+/foFZjI2tSb26lSC31J0TYnbLgQIWm9kmooI6s+WDSfGAZbab+2CvQptn84LRu
         OtXost5wSIkgm5GvFc7F0xdfjIFiOJs1dr/xd9kr2F9cMgBtap/J3h2DX0CwG340wmf7
         r2AdMLbfezUmUu9AGQ+OSrkOgDJdGkXGYYz7xj1rD1F0O7MBekWmjMKXVIqjh1CqQGhG
         Ojj483GQMnu8025eHVxf/QYqq8sexKOHoQhvfkd0ALakfl5v9+ivqFEhsmTBzakyBHwX
         +FBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvhdWo7kd/K5HI0rZPHtzEemLKUVQTbUANwMQ/AODvWqXPJdQ6IEMliNwHL70+LNszHK6I9IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzm2AQQIqr0EpNsV9V8qve18IFud8srlPDxsPZEsU/i2DnkqPH
	vEY9Ic8S4biB/gaZAibkqH2QnKi+jYQR1jsX57fc89UujXhYV5fxuiBoxUT7UWY=
X-Google-Smtp-Source: AGHT+IGFiW2+v299mc81luN4YcHwQ6dVJTJSDQNij5dhPvHLfWfh6H5nBV3A9hHUrtCee6xbbNnYYw==
X-Received: by 2002:a17:902:d508:b0:210:f6ba:a8c9 with SMTP id d9443c01a7336-21183c8cc59mr111975505ad.17.1731192817777;
        Sat, 09 Nov 2024 14:53:37 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e68960sm51173425ad.220.2024.11.09.14.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 14:53:37 -0800 (PST)
Date: Sat, 9 Nov 2024 14:53:35 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Matt Muggeridge <Matt.Muggeridge@hpe.com>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net 0/1] net/ipv6: Netlink flag for new IPv6 Default
 Routes
Message-ID: <20241109145335.0e9f3f62@hermes.local>
In-Reply-To: <20241105031841.10730-1-Matt.Muggeridge@hpe.com>
References: <20241105031841.10730-1-Matt.Muggeridge@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Nov 2024 22:18:38 -0500
Matt Muggeridge <Matt.Muggeridge@hpe.com> wrote:

> This is the cover letter and provides a brief overview of the change.
> 
> Add a Netlink rtm_flag, RTM_F_RA_ROUTER for the RTM_NEWROUTE message.
> This allows an IPv6 Netlink client to indicate the default route came
> from an RA. This results in the kernel creating individual default
> routes, rather than coalescing multiple default routes into a single
> ECMP route.
> 
> This change also needs to be reflected in the man7/rtnetlink.7 page. Below is
> the one-line addition to the man-pages git repo
> (https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git):
> 
> diff --git a/man/man7/rtnetlink.7 b/man/man7/rtnetlink.7
> index 86ed459bb..07c4ef0a8 100644
> --- a/man/man7/rtnetlink.7
> +++ b/man/man7/rtnetlink.7
> @@ -295,6 +295,7 @@ if the route changes, notify the user via rtnetlink
>  T}
>  RTM_F_CLONED:route is cloned from another route
>  RTM_F_EQUALIZE:a multipath equalizer (not yet implemented)
> +RTM_F_RA_ROUTER: the route is a default route from an RA
>  .TE
>  .IP
>  .I rtm_table
> 
> 
> Signed-off-by: Matt Muggeridge <Matt.Muggeridge@hpe.com>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: linux-api@vger.kernel.org
> Cc: stable@vger.kernel.org
> 
> Matt Muggeridge (1):
>   net/ipv6: Netlink flag for new IPv6 Default Routes
> 
>  include/uapi/linux/rtnetlink.h | 9 +++++----
>  net/ipv6/route.c               | 3 +++
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> 
> base-commit: 5ccdcdf186aec6b9111845fd37e1757e9b413e2f

Please send this to Linux man page maintainers.
It isn't really a linux-api type change.

Not sure if man pages project does a stable tree.

https://www.kernel.org/doc/man-pages/maintaining.html#:~:text=Maintaining%20Linux%20man-pages%20The%20current%20man-pages%20maintainer%20is,2020%2C%20Alejandro%20Colomar%20%28alx.manpages%40gmail.com%29%20has%20joined%20as%20comaintainer.

