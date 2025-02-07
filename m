Return-Path: <netdev+bounces-164092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD97A2C923
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E41188772C
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E17F18DB0C;
	Fri,  7 Feb 2025 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgL7g8p2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98E223C8DE;
	Fri,  7 Feb 2025 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738946648; cv=none; b=kehyrXJLcsqH5/LXMMU3UiYqrFDXLpe7q0TzJ2DDwkqwjo6FNFK+bG/51G1FEgfB52hLu/HAV9u5kIEULURDT8pmBWeCSTZmz6H72xE1t655PhFyFVt+fMZWdB+mjBvmKBln5HzHRPfyI8OaOGeQjY5Aj95330MP8rjb2BhYjpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738946648; c=relaxed/simple;
	bh=2x8YH7UX2qAhD4V59FweuHIOMl/p+Qb21KQFd3jGD9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itg8ycXEjBjJjAJOi2zBvlHPdRjiolIcPpdCOy5KOPa91TSl1iEN6KkOeZqoIhjP3F6dS2wwaZZxHGnu6et5Pq7n9dnoIZK/HV6OjR5GKxiuh3l/dxCkfwrinh8hzNX2GkIbICMm6mvU/IGpLgLWIV31lRQBJ7vvLcJQC+7LJLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgL7g8p2; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5de459b79ddso212867a12.0;
        Fri, 07 Feb 2025 08:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738946645; x=1739551445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eYt9zEq2uTN42PpE2KerymI/xM/Tffg4zFTM6kV6KmM=;
        b=GgL7g8p27qZZkUQfa38U5vVPfeNfqw7zWYIYEkmBxPa1NiEz4Nh/W2kOYjbx+mekBh
         /LNS5YcdAXhWiPbOkSyZKD9jFmvnnnVqilVm/b0hBMwuBClVvu6Rxd1jAyYIjvErU/6S
         CH7PBP/zRot8Z7psU+zvbCopzD9j0gdyWNuDqT0huSVo0dlewGerH6vtva5XhXQ7ZTvZ
         m2u1cvEO7tcJj+itMctbDbUZMfuVVsr9grVbqsLECiKzYGc5i7uHZZ0NJOVCfCn6HHrf
         oZFry6vKyN2W8ho56wzdLwQamwE+Kq2BGWBtRSuQK/1CXmEL0x9RQ4tpKsWmWkA7yn5L
         rERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738946645; x=1739551445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYt9zEq2uTN42PpE2KerymI/xM/Tffg4zFTM6kV6KmM=;
        b=wqFvJlrAFr6sEtPfUIa9WOvkXZi35TwMLvw3/fA3bpgPSd6q2+CLPHM05/GgGx8FNn
         HJag3mmgT6yibfzH2e4grqqwwM/yzFQZ3mx16jw4vkcAaByPA8iBXz9bH9/zqyEwWD2E
         NIWaUq1tVhSTScUAnF6uqmYMvfokP4pa629+8QcsoKTO7BfS+scrEUMQ/camfsoi+aTO
         ld4ZEQ22LCibjbyxo9emsKAvgL4zMFY38oaqfnzfqot4g4tEhcoORliIfv2nMU3/EDl2
         oowE7s54UF99xJ09Frum/2i1qVEYMoeeLaJWmuQVFBeYx8sGUbudWxJ+57RESs/fkXA9
         Xp7A==
X-Forwarded-Encrypted: i=1; AJvYcCV/CWWrrComW3oTYhZGK/UBZKryt12fX47/e4a65VBJlrte+abtwjb1qZCjLvOh1EMJ/MbdiLMfArdterg=@vger.kernel.org, AJvYcCXwBDz6AX+A7mxWG6rK6u2XeEnJSoQxsKenXQpP1s4VkyWFZnN3gg72pEphXtFQx/ISagDZbmwI@vger.kernel.org
X-Gm-Message-State: AOJu0YyC4zFQFC1GpW3qen2qUtZwc9+oaSWgAWcF/ZGno9CInOzwuaWp
	u3K4YQy0+AKYR0l8U+G6OrjQDe6y0PARPl+6wJDKakaSVp8cgWta
X-Gm-Gg: ASbGncsxxrF56eMIE9ChrumZmtC8FbGYieVEKhAKrVGN12+/pVDrWzV7JBV1hlr6oRn
	Wuik30JRUJpSNXuU82P2H9gxlEYGOB5kZcnu5jWohzzK9IDCh4Y2kbi8i6HDHo8QdhH88KxgpRS
	+p00zs9cynfDuxF6t2RSu6WQYniagMGbU5dvCp4d0X6rXjg0srC73/Puqg0a3ArbFNPhD85mQ4i
	YIUC7yCTghISCmTHjAmp44m8bVPv38BkR2qZ4Xf87bqKzKIDUCXhY3T9lIStYtsR1ykXtsnnSJJ
	C/I=
X-Google-Smtp-Source: AGHT+IEGw2Il/V7x/MJTsaTutvOMVEPAejMjGCruncfxQtoi6CZFpQMmX5c2XSv6GXZocDlpfjv4pA==
X-Received: by 2002:a05:6402:34c8:b0:5dc:882f:74b1 with SMTP id 4fb4d7f45d1cf-5de45046dd9mr1634028a12.3.1738946644941;
        Fri, 07 Feb 2025 08:44:04 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf1b85a4dsm2807030a12.47.2025.02.07.08.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 08:44:04 -0800 (PST)
Date: Fri, 7 Feb 2025 18:44:00 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Kyle Hendry <kylehendrydev@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] net: dsa: b53: Enable internal GPHY on BCM63268
Message-ID: <20250207164400.x2fobtcblr7g3dil@skbuf>
References: <20250206043055.177004-1-kylehendrydev@gmail.com>
 <1317d50b-8302-4936-b56c-7a9f5b3970b9@broadcom.com>
 <9bd9c1e4-2401-46bd-937f-996e97d750c5@lunn.ch>
 <a804e0a4-2275-41c3-be3b-7dd79c2418cd@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a804e0a4-2275-41c3-be3b-7dd79c2418cd@gmail.com>

On Thu, Feb 06, 2025 at 05:41:19PM -0800, Kyle Hendry wrote:
> On 2025-02-06 12:17, Andrew Lunn wrote:
> > On Thu, Feb 06, 2025 at 10:15:50AM -0800, Florian Fainelli wrote:
> > > Hi Kyle,
> > > 
> > > On 2/5/25 20:30, Kyle Hendry wrote:
> > > > Some BCM63268 bootloaders do not enable the internal PHYs by default.
> > > > This patch series adds functionality for the switch driver to
> > > > configure the gigabit ethernet PHY.
> > > > 
> > > > Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
> > > So the register address you are manipulating logically belongs in the GPIO
> > > block (GPIO_GPHY_CTRL) which has become quite a bit of a sundry here. I
> > > don't have a strong objection about the approach picked up here but we will
> > > need a Device Tree binding update describing the second (and optional)
> > > register range.
> > Despite this being internal, is this actually a GPIO? Should it be
> > modelled as a GPIO line connected to a reset input on the PHY? It
> > would then nicely fit in the existing phylib handling of a PHY with a
> > GPIO reset line?
> > 
> > 	Andrew
> The main reason I took this approach is because a SF2 register has
> similar bits and I wanted to be consistent with that driver. If it
> makes more sense to treat these bits as GPIOs/clocks/resets then it
> would make the implementation simpler.

This has not always been clear, but we prefer handling components
unrelated to Ethernet switching outside of DSA, if at all possible.

