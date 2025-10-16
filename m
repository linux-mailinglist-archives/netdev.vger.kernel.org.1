Return-Path: <netdev+bounces-230129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CACBE43E4
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2A154FD0F8
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23F2345743;
	Thu, 16 Oct 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo5InIkx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E342E62D4
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628629; cv=none; b=s9Q7zvp8/m5BFBjDUPJ7IbDyTokiCUB8qXQ6qt5LdmyWtTRkyFNwkU2xeSrg5FAqa3sM4YLfmWrlQMUrYJd8fPCy4h5jUmLO6zaGJSIAo3T05Ndsnd+AEDNuPOsAuweV8lR+ju0NwX4KyirEE0GvsVXb3MaBOuG50L4jO5BO6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628629; c=relaxed/simple;
	bh=JR0IPU7PxFXpfgWYzXY12lPBiLM1O9zhJ5yP9OtWp3U=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+PuUnKbbjsWT5Wesh56RWDsauKfkSQQByjcRB50EeH5x9CTYsIPC+CFzj0gkaEPTdgp1Kfw+P5efTLIwHvGDHN50PRfFlYl8qIDv4m2eT7+oOHppwqT1+Cdn4gmzw+TeCyGun8QUBQsxCz9pvihU7i/PN7cnCewMNGfLngUn64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lo5InIkx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47100eae3e5so8885515e9.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 08:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760628626; x=1761233426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ietOkeWTDnClykDeSgCRmDi1+eHw6qsXZBfGYbeOrE8=;
        b=Lo5InIkx0iWn8NLs4ifoap7z/6chVScpDsrnX8aTw7wZRA6q0rKmnYaxqCDSX/FGeP
         BHPevq0P2K1FfFaodTdfgGbEWlNNP+bP3oioNY4frzUk9mtqGtXdtu+cJZQba/CfmoaK
         4zP0in8F9eUqeCHS4P15r3gFuxbc9pReIWaYGNg9kAQxD7FArQFrF/DlXTXH3TJFxkAc
         27TCuzpUqldZkWZXdwT0zwxRGJp8a05d2YK2qydYrB+pr3xCuRlGC4ESz8PgNdgANEdt
         WdLihxXtPdQAIDabPMV6jQAOHnBuVVq6BFuc/VJp6gr1uxFwkg3rG2JW7MUQtgcg4WpN
         TJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760628626; x=1761233426;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ietOkeWTDnClykDeSgCRmDi1+eHw6qsXZBfGYbeOrE8=;
        b=jSLPe3B6Boz/YpYWolDik48AGX8STQseyesrHYZyu7dVM+Qb90yh7KhDZCtwBHLTdH
         OW4j18Kk2n0HUBbjrrJ54aSNEZ5h+sUNMpG9r2LYC0hKeCMz2qPrfmY4CKJQQkepZKrj
         CmNCqHjbWdDCcK7ACAc6O0nmtObDBn69lyeaRFv0x9u/clHm08WwbpUvr6MoYyAouIKY
         NnG8fMjrMy+C/iE+lfBE5dkAsUOorv/aGTN0l7QAMrN5g++bbKDGP1a2c64BDi/TyIjV
         ezwFAoEfmrNem95vuNfTpE8bY+gmh8q848m1XhtjUZ2dZxfUBbRX3C6CQjyfY3QN4MRr
         U24A==
X-Forwarded-Encrypted: i=1; AJvYcCW8rllM3nKqMp624kknCigS1+JqkstvAwMD+7fxZXnXKn7HtHKz/XmY1iQtzV9mvF/ro1DTo2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMhaezGXeqfvelt/eGvY/DQe/UTUJDTgTqZr6CuVZ85dXGbzFP
	S6eBylIuNyJKwkUq5EnxtAH7l6UCuCxmOjbtBB9h3UvJnlxIc8ZMjNbx
X-Gm-Gg: ASbGncvvi7HWyVtqVjGKlhn/JEDQfe+90pTShVZkwSPgkSkIIQPzXcjUQpH76yNFYBq
	vcLBisEcDEdrFgPbvDU35hD/fBpUQu5duDOv7nJ1+na09lZTeBZRZKmOaRR0Al55jDIGXWlYSHl
	RI/u4R+MN3Q76pXr8fveycCtGyW/P1YIgAOZESX9G0DghaD0+8tXi5sKcZaq0YavbpJEf50bt/R
	K4b5ECIwclMTkWFw0jxzj4AtGX9jQBZ3YyacHpEhykjuQxTPNevvcCBY27r/gbT69gGGd+rztBF
	VabzEq1WV8RBtwIYfSxEvTAZps1bnhWCmkbMQyat+9cVvGIFCMXgTtaDVTjOLRttoWO28xXPxrS
	bw/n6Bd+r3zw5vKw6MyJS2SGGhC8e1DOc2cBgyAdz/Qv+eSY9tt5X6s87xmPV9YPe8PRexcS/FS
	5uXjCE3+xHN4nvLYAvUgmvuinjP8ym5KubF3r21AJ5/g==
X-Google-Smtp-Source: AGHT+IE83L633qvtvU9yjysbdYdlIQn21EV/wagnBNKOZgnU2CqBGKS2iMtK+HobtWHJlzyFyVaiQQ==
X-Received: by 2002:a05:600c:45c9:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-47117913764mr3709145e9.31.1760628626015;
        Thu, 16 Oct 2025 08:30:26 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c82b8sm31899495e9.15.2025.10.16.08.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:30:25 -0700 (PDT)
Message-ID: <68f10f91.050a0220.3778ad.a4b3@mx.google.com>
X-Google-Original-Message-ID: <aPEPj0R2k64GH7kW@Ansuel-XPS.>
Date: Thu, 16 Oct 2025 17:30:23 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frank-w@public-files.de>
Subject: Re: [net-next PATCH] net: phy: as21xxx: fill in inband caps and
 better handle inband
References: <20251016152013.4004-1-ansuelsmth@gmail.com>
 <aPEOBRytURg6vKqN@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPEOBRytURg6vKqN@shell.armlinux.org.uk>

On Thu, Oct 16, 2025 at 04:23:49PM +0100, Russell King (Oracle) wrote:
> On Thu, Oct 16, 2025 at 05:20:07PM +0200, Christian Marangi wrote:
> > +static int as21xxx_config_inband(struct phy_device *phydev,
> > +				 unsigned int modes)
> > +{
> > +	if (modes == LINK_INBAND_ENABLE)
> > +		return aeon_dpc_ra_enable(phydev);
> 
> So what happens when phylink requests inband to be disabled?
> 
> I really don't like implementations that enable something but then
> provide no way to disable it.
>

On firmware load it's disabled by default. Can phylink ask to disable
inband at runtime?

I will try to check if there is a way to disable it.

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
	Ansuel

