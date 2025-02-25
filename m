Return-Path: <netdev+bounces-169289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E823FA43366
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 04:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8713B2B22
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 03:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387FE21323D;
	Tue, 25 Feb 2025 03:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIHgZqEG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76B93C38;
	Tue, 25 Feb 2025 03:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740453050; cv=none; b=EJWIhpbr49uoOUDSre6UhkBH1CFJHxrhHUTGjQFqw4hFOmGW439rSMt9Qtp8OBoJ3iodDvV4maXJtllP7iKlnuJzVVmAT+mynoQd0L4vwPBFmc/FjCsrFkg5EhscZHy269+oyEPw2QotaeaeRsoEfFJ/AGBUfvCcY3RPDhKAzpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740453050; c=relaxed/simple;
	bh=sbS2idndESK6uIlRWTKAuHHfhhjeCIcNbrN+0pFB9GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYOeZtwb4gzZ2rGbqLNUpfqLZKEyJyjmy/TqectmfikK7Vkn1Jc2Vs6eb22KWX1XYjbA8m2VqzkT/fCEt88W8mQp5h04EGxT9ZcnhPy71f10FxRAiMH21GSRVU4+u7H9p9zL4t3X7R6XzpFWud+eDCHznTUcN/EDiBoGqPvUQIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIHgZqEG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c2a87378so85965485ad.1;
        Mon, 24 Feb 2025 19:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740453048; x=1741057848; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RwaAivTVAfPxjfSB+ftZsaeu+CUh+Id1DP+wiDv5Isg=;
        b=aIHgZqEGcGwy7nIFvEWVz7OU6v6D4ijpa/PkFgHv1IOwmEozc3xVXUF3R4mCGID5ac
         dvXQWA7XBUyhrSnEX/u1AhqM8S7QVXf6JLn2HMyCsi+awBd0mWth+uvSpdm1NZxN9cNm
         UMNS430/ZL9AKL3ozxQAXhJW3njaT6M9O47e1X2wrbdLF/3TjyEkLyCYKylmWz7lIHVF
         p6Cnsf0BbDmGcB5SSSQ796amjuNEaLnKM1EFLj/QKdmGm6q1wNeex/ITjhdCSUs/EZBc
         8fUa9JOAu40oA6+0JiBpgYMQOgPnywnOn+LHwvcoJnI1UhrUF34y8aSbKiApb7LRhZqY
         91tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740453048; x=1741057848;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwaAivTVAfPxjfSB+ftZsaeu+CUh+Id1DP+wiDv5Isg=;
        b=GrE1u9Y6c4JXIxxSbM25ANgvBpeI+iPqSzrC2ywZW7Hi9q36QIfymcmDq2RiSTK8kn
         8mvJgemBo0/rTSnNNz8da5mX6JUB57MvIVUGR0JpZmuEGFTYCgrj4pTtXvXGkwOA+ppO
         JgAd0rfCQTEIRqF7GxoeRcyXSoZ93FjW0GL4T+g5U1I2mBjonPXV+mZSwIII3UPActXd
         +yWvJERlYe9BUL9BNoSyvNnhwkJM/dZ9Krao83thVGdEeBo172Nk0oJhrNTD9K4kOMLx
         oAtn/Pjz4UvpQTlPMOBy/Wp19wJfj6yGGIpnandPUNSmb/J37hkrwsxvgDE2obZcQIT0
         A4Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVZbwk2dQxeV4/8bWT9p+AIShO+UiO8JgCm5jM5mAPd+AFmnj1EBl3pKOCz2UWpqkQfXrbI6ZSXIQMLE94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDnO7xkZ5JWMd0KWm0042nQLrfQZhrjIAOaInAQdIn3X3DA8Rp
	PShtN+OzZXLenOC6OHMICDJCM4piVy6A4OC849mdUVLtuRjhdAcH
X-Gm-Gg: ASbGncsN+q1vI8i8xPZD/qqU2nkxf/C5lWfqZ7hruwKi1ZO9tyWw/cmo6wA29VU/7Vz
	zdZ5qegs8vUenCuRgIajOmnqfBpoWzn7NvLeYkqX00AplpNMa4u6bYjRYRvj4LlhUOFzGmZvK/b
	il0Etem82foQxvykUwfgFcsEtaLvbNyZWRWQghmXIwN12wHn9/ebfYK7JkimSFI2LlZTkFhV62G
	X4AsT9hc4GNYRmiXHDIrw/+sty/rJSNfptc5TrD0JDro1hpmGv6hhvZuFFbjq+Qq8fQ/usbDwln
	ke8CH0rQxaAm7MJpN80VE23O6ojhmTQ=
X-Google-Smtp-Source: AGHT+IFx4sPgeARzSxw1BUYY3TeFk6utRjQgIomRcUkS1u01ORqFXsd5sMF8tm0Tg9qy8W0IA3Wnbw==
X-Received: by 2002:a05:6a00:b86:b0:730:937f:e838 with SMTP id d2e1a72fcca58-73426d8fa97mr23852033b3a.22.1740453047742;
        Mon, 24 Feb 2025 19:10:47 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81ecd3sm396994b3a.132.2025.02.24.19.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:10:47 -0800 (PST)
Date: Tue, 25 Feb 2025 03:10:40 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] bonding: report duplicate MAC address in all
 situations
Message-ID: <Z700sKO3sBkxf8Ra@fedora>
References: <20250219075515.1505887-1-liuhangbin@gmail.com>
 <20250224141008.3ee3a74b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224141008.3ee3a74b@kernel.org>

Hi Jakub,
On Mon, Feb 24, 2025 at 02:10:08PM -0800, Jakub Kicinski wrote:
> On Wed, 19 Feb 2025 07:55:15 +0000 Hangbin Liu wrote:
> > Normally, a bond uses the MAC address of the first added slave as the
> > bond’s MAC address. And the bond will set active slave’s MAC address to
> > bond’s address if fail_over_mac is set to none (0) or follow (2).
> > 
> > When the first slave is removed, the bond will still use the removed
> > slave’s MAC address, which can lead to a duplicate MAC address and
> > potentially cause issues with the switch. To avoid confusion, let's warn
> > the user in all situations, including when fail_over_mac is set to 2 or
> > in active-backup mode.
> 
> Makes sense, thanks for the high quality commit message.
> 
> False positive warnings are annoying to users (especially users who
> monitor all warnings in their fleet). Could we stick to filtering out
> the BOND_FOM_ACTIVE case? Looks like this condition:
> 
> 	if (bond->params.fail_over_mac != BOND_FOM_ACTIVE ||
> 	    BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) {
> 
> exists a few lines later in __bond_release_one()


You are right. The bond will change the mac address later if
bond mode is active_backup and fail_over_mac is active

        if (oldcurrent == slave)
                bond_change_active_slave(bond, NULL);

With the upper mode and parameter, during the slave_warn(), bond is still
using the same mac addr with the first join and released slave's mac address
and cause false positive warn.

I will update the if condition. Thanks for your review.

Regards
Hangbin
> 
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index e45bba240cbc..ca66107776cc 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -2551,13 +2551,11 @@ static int __bond_release_one(struct net_device *bond_dev,
> >  
> >  	RCU_INIT_POINTER(bond->current_arp_slave, NULL);
> >  
> > -	if (!all && (!bond->params.fail_over_mac ||
> > -		     BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)) {
> > -		if (ether_addr_equal_64bits(bond_dev->dev_addr, slave->perm_hwaddr) &&
> > -		    bond_has_slaves(bond))
> > -			slave_warn(bond_dev, slave_dev, "the permanent HWaddr of slave - %pM - is still in use by bond - set the HWaddr of slave to a different address to avoid conflicts\n",
> > -				   slave->perm_hwaddr);
> > -	}
> > +	if (!all &&
> > +	    ether_addr_equal_64bits(bond_dev->dev_addr, slave->perm_hwaddr) &&
> > +	    bond_has_slaves(bond))
> > +		slave_warn(bond_dev, slave_dev, "the permanent HWaddr of slave - %pM - is still in use by bond - set the HWaddr of slave to a different address to avoid conflicts\n",
> > +			   slave->perm_hwaddr);
> -- 
> pw-bot: cr

