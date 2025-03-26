Return-Path: <netdev+bounces-177694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDB3A714BD
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD0B163E3F
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 10:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF5B1C6FF6;
	Wed, 26 Mar 2025 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEGyM3Id"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABB61AF0CE;
	Wed, 26 Mar 2025 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984588; cv=none; b=VWaBVkBkO2D/hcTLaf4o5mzqzQZo9Vf3UXyr4yoLcjjxRQj9SCoAwoCFaS7JVEDNBeBKFiQLMXmpmLwoTIdquXl9Wr5mE0F6/5XfmBfl8+2V9fiscDN+1LK4ON+cP9iW/C6GtPH5zXX6oW9HkPTvDYBQK3h6QK90x49yDem1csU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984588; c=relaxed/simple;
	bh=4pmQ2y0f7n8L7PyXZ04ncCO+er+ZinWzqA11dpsE8IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVuMriINH54V1geXPSQW3VxLsjtRsNtxHAYcQNTJf8rY2/uF+ffdaACcYYrbbl2Esm966xv9AAeb+V5CBNuaJ5v37Ty3OupJQqrK6z946p3L8zUS5AM8k7O+wltRHtzgri+LygXj2xLFTXupl1rTi3iI63OcuvISYVwSZ5mtjdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEGyM3Id; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-227914acd20so10965065ad.1;
        Wed, 26 Mar 2025 03:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742984586; x=1743589386; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VNHTYKPineowADcTLJe/hNh23Pp93gtIdEBRwu9tXMo=;
        b=bEGyM3IdS0go4ph9P9anawHpk6w6SitfUmd0SCqAhV+tRlyWjbvwG5xMpQO2uXCVv8
         NrSfQzWOhEkYA55/b+gUvd79TVa3hWTFksQr/VwuP+8mcbgH5160GAGzRchEur96addJ
         e0BuD3EE+who4DSxNMuSbHL9z5dI5eqitP8Yp0LBQme6vQcAb1PCBZ0Rk5Dt75vigtdF
         i8jihUiC+OHabvtc3TkOtq1G+5c+wPZVPjGVhwWuNqPOTG60BPKZ/27xlj16lwMDW1TV
         VAmSSkTxFMooskG4k9o22H7nxrcfUnVMdmemyBmuoIhv7uinHhtzqTZttnmL2Ey5R/1n
         cZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742984586; x=1743589386;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNHTYKPineowADcTLJe/hNh23Pp93gtIdEBRwu9tXMo=;
        b=h4zXECFjSbsjiiGSOQ/iwTKqCtq/ShlkKaaUf5WlANZtVASQSi3fEv7pYES5LmXWnL
         3ooMHigMQ4rWID9zxVaB8kyqx6atssH31y0PWo4dydQ/2jFXcAK7uUM/t9PJttH8y8JT
         RLoh7IC+zgBep5h+HsNEAyCI6EJJ0towO7uNVY+QjDdkQkI0L9pbfc/BoZFBnLMxaPFt
         htGlN6H73ZsCzYFK9bkdSITVcTy+Jqy/vFSl2NcYxmRNXhD2HIryPwjioSfIQfqPsz3i
         2FZQTezyzlfyFaMY2q6TmQDa5GVYlvt6ISKBGuVOMh0FCcAsH5k5m4Yedy0yJ6VL8px8
         agdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxmYoHoTDklwC0dr7DSoCNH+E3aIlE2tyE7z3Isn0CvRPH75tJrtY5ZfAJmZl4J1HVrf/ZDfYgxECZQJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw34zvWOYlGG4yC38DymTcbHdNpUjmrPntLMuFzRZ/n5lG91P8f
	URic1Ei87Z4JCDzqrP0YcddiXt2RU9kS7W+N3N6WLHvxRr98xMXr+WWoFT6PN4M=
X-Gm-Gg: ASbGnctmM88UWr3SGheQ7c6RQQbHj/9gbTgirEEceJjm1VY9LVRRhFa95Jbj43pNPTg
	nhNd6gowVbZ+nJuyj/Xcad1VhP1zvW6lWQkAMhVcBHJs6QeoTeVXg35T4sOw7r6/7Yb1ZvAsUzG
	pymlO53V72Dw+zv27Vc/JteH3ePQEZrVQtRB+6et1Y91uUjogbB3wrsA9Tt95dltMxOjFlKAxk0
	KRTMFxsxZVx477ylCzF6iz9Wyy76wSDk59YR1xp6NsYdiSSGULldR4z8Zw7YLvrFnMmJpd64KLG
	OgRXZJQELEcjml2s94bAsvH7EYlzjqLAX22Hpa8tS6covKMocqjhj99qY5Pp
X-Google-Smtp-Source: AGHT+IEiSTEs0O8Mqeelaa+ngbOSwLPNg7gFv6CbASrOTDFDQntYeOFMI3S6U+086acQ0TeURM9fdQ==
X-Received: by 2002:a05:6a20:76a5:b0:1fe:90c5:7cf4 with SMTP id adf61e73a8af0-1fe93927fb1mr3490603637.19.1742984586274;
        Wed, 26 Mar 2025 03:23:06 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a28003b2sm10630763a12.28.2025.03.26.03.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 03:23:05 -0700 (PDT)
Date: Wed, 26 Mar 2025 10:22:58 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kernel@vger.kernel.org, Liang Li <liali@redhat.com>
Subject: Re: [PATCH net] bonding: use permanent address for MAC swapping if
 device address is same
Message-ID: <Z-PVgs4OIDZx5fZD@fedora>
References: <20250319080947.2001-1-liuhangbin@gmail.com>
 <20250325062416.4d60681b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250325062416.4d60681b@kernel.org>

On Tue, Mar 25, 2025 at 06:24:16AM -0700, Jakub Kicinski wrote:
> > 1) ip link set eth1 master bond0
> 
> nit: 2)
> 
> >    eth1 is added as a backup with its own MAC (MAC1).
> > 
> > 3) ip link set eth0 nomaster
> >    eth0 is released and restores its MAC (MAC0).
> >    eth1 becomes the active slave, and bond0 assigns MAC0 to eth1.
> 
> I don't know much about bonding, but this seems like a problem already
> to me. Assuming both eth0 and eth1 are on the same segment we now have
> two interfaces with the same MAC on the network. Shouldn't we override
> the address of eth0 to a random one when it leaves?

Can we change an interface mac to random value after leaving bond's control?
It looks may break user's other configures.

> 
> > 4) ip link set eth0 master bond0
> >    eth0 is re-added to bond0, but both eth0 and eth1 now have MAC0,
> >    breaking the follow policy.
> > 
> > To resolve this issue, we need to swap the new active slave’s permanent
> > MAC address with the old one. The new active slave then uses the old
> > dev_addr, ensuring that it matches the bond address. After the fix:
> > 
> > 5) ip link set bond0 type bond active_slave eth0
> >    dev_addr is the same, swap old active eth1's MAC (MAC0) with eth0.
> >    Swap new active eth0's permanent MAC (MAC0) to eth1.
> >    MAC addresses remain unchanged.
> > 
> > 6) ip link set bond0 type bond active_slave eth1
> >    dev_addr is the same, swap the old active eth0's MAC (MAC0) with eth1.
> >    Swap new active eth1's permanent MAC (MAC1) to eth0.
> >    The MAC addresses are now correctly differentiated.
> > 
> > Fixes: 3915c1e8634a ("bonding: Add "follow" option to fail_over_mac")
> > Reported-by: Liang Li <liali@redhat.com>
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> >  drivers/net/bonding/bond_main.c | 9 +++++++--
> >  include/net/bonding.h           | 8 ++++++++
> >  2 files changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index e45bba240cbc..9cc2348d4ee9 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -1107,8 +1107,13 @@ static void bond_do_fail_over_mac(struct bonding *bond,
> >  			old_active = bond_get_old_active(bond, new_active);
> >  
> >  		if (old_active) {
> > -			bond_hw_addr_copy(tmp_mac, new_active->dev->dev_addr,
> > -					  new_active->dev->addr_len);
> > +			if (bond_hw_addr_equal(old_active->dev->dev_addr, new_active->dev->dev_addr,
> > +					       new_active->dev->addr_len))
> > +				bond_hw_addr_copy(tmp_mac, new_active->perm_hwaddr,
> > +						  new_active->dev->addr_len);
> > +			else
> > +				bond_hw_addr_copy(tmp_mac, new_active->dev->dev_addr,
> > +						  new_active->dev->addr_len);
> >  			bond_hw_addr_copy(ss.__data,
> >  					  old_active->dev->dev_addr,
> >  					  old_active->dev->addr_len);
> > diff --git a/include/net/bonding.h b/include/net/bonding.h
> > index 8bb5f016969f..de965c24dde0 100644
> > --- a/include/net/bonding.h
> > +++ b/include/net/bonding.h
> > @@ -463,6 +463,14 @@ static inline void bond_hw_addr_copy(u8 *dst, const u8 *src, unsigned int len)
> >  	memcpy(dst, src, len);
> >  }
> >  
> > +static inline bool bond_hw_addr_equal(const u8 *dst, const u8 *src, unsigned int len)
> > +{
> > +	if (len == ETH_ALEN)
> > +		return ether_addr_equal(dst, src);
> > +	else
> > +		return (memcmp(dst, src, len) == 0);
> 
> looks like this is on ctrl path, just always use memcmp directly ?
> not sure if this helper actually.. helps.

This is just to align with bond_hw_addr_copy(). If you think it's not help.
I can use memcmp() directly.

Thanks
Hangbin

