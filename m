Return-Path: <netdev+bounces-183109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AED5A8AE4F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 04:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD9317FDB5
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2081221423F;
	Wed, 16 Apr 2025 02:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUrh/Pva"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABF620487E;
	Wed, 16 Apr 2025 02:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744771976; cv=none; b=D6ytEoMa1SPOGsBmqq/o1LpVGWfan+qByoco7DrMczDgmVr2JmURu7qpZAcMdOs9XHvDhe3dYgTr6S651vddDRdKFSOhOMT59GO06sRvpKxReon2ppKckKvxc/L/6EZkvVkA/5TjCpdJoKNjE8L+4G0H2Xw2/ZKAX3y6qPGNFCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744771976; c=relaxed/simple;
	bh=FbL8NLaGqlZNMJY74u/4vebO2ecT5FtLstkf64QxpTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eewoPiweIpgYGi4WvHQM6kD4B5VyCXxugpp/O8B8SO6XG9iRw6BbhK4SOKr/oEOxWPGXPBr7M9LQT5fbsZZVbJyRqT0QisnAysU0lJBRph+RgCPoWp2DRCqZA7+r5RIDrV8bmm+Dl36Ib2KWZxI4NktDcaG7yLiPaf06QfQih7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUrh/Pva; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227a8cdd241so74271705ad.3;
        Tue, 15 Apr 2025 19:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744771974; x=1745376774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2m+RYOCFGQ/RWQvmq2IGkFKFEncRhD1UjWtjt40z9Rg=;
        b=hUrh/Pvaa5bjMuCBmLVSAMRPH57ujbdHYkIqVimYD5/jIaszJXNq8OH9WO8lMWhddn
         o+wrYzFp7he7UO0UB9rA50/7wo8JNAAJbBdhOvExfy9V+oQA4G7bcu17cOnOna6l8PBH
         u1aJNL3Lm5N5JXKYr6d0H6Itn9zIRAdJtetwA1VdJZe6ZxI5ILocpOeLNTECkOx1l4wX
         CQZFtPIoJctncnziUN0TQ1alp7Y1k5KPTx6kNgHjkMrrjh79gyk6pON5zzQzLm/vqP93
         4tJrQ7Ghovi5PsFnFkFJSD6E+wtGyHm7FtgJ1RH5jLpP4DmIASorhl40a49WLEfh+8CY
         /Uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744771974; x=1745376774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2m+RYOCFGQ/RWQvmq2IGkFKFEncRhD1UjWtjt40z9Rg=;
        b=w4wGxCRz9Z8+5oLXaq9qVxJk+7jzf+neVD+cjuAMMgqX7hc0Tamr4EC9+tApXu4kKs
         sZFO9baTe2D7byFuUen+TaRjzYtwstC+rjWqUqt0QpMWY8BfDhVGpzFDwqSizl71cAKX
         fp3y9PooF62kuRuTZI9dkIl0y1yKgmCdhhvNxrsEe0DunYxEKTGvo6XPvl0/2gy5gNnX
         +EtZwnbawcXX0QYHmPix5hifQysN3miwLZ/4aH8V8LHckyqw/e/psRx5xVoETdDpzeHy
         KUci1N9rTarCLJrFizxZN+/qNwHREkngOaQmmsCPiP4mL0aXMDnNH4hFhomrI1GmncI2
         sHfw==
X-Forwarded-Encrypted: i=1; AJvYcCWF/YvbGIjvtZS7DUlzLaolPp6yQQjTga/4S1DN2Tqw0CWnSmX4MZPODA2HFBgdo1wTmGb/fVWP9sJslec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI8kS4t/ArybDH4O9nP5A+D2gOyQH3tC7IfTfQ06GcIrvI+b8B
	J49PcPWVRU7CYxHNj2iAmllF3OucVIHHhmg/P424GfFUnd+Aq8MY
X-Gm-Gg: ASbGncsV8Hl7qvGcIFhXWjL2edTsa+euMZ+Sgte91su7f4S9ROEar79g2YIovMLxEjN
	B5SLUlHm57bm5GcvPwhc2tCdTYSOyDTA/CG6rqNb0WPvsaaKKi+3+kZ1zcfAtFg32OMxwj7NSIV
	xyIlq5HsWVZVeEmoRyk+S4FRC5CxtVoRARtJyflCFI3p9owB3Sf2tsIrgcyyvm7FckgpFYSJnrT
	5enjtNxGjhhdXbZNq8rV9J21NoD6oGQfPtp05j4TIUlh6eidfu3GRcCPm9MCnf+RA1Ds69jkziE
	n2mkkmZIGbQP46e+bUu9q4o1uExnTPCJAU/CDwE0bKfKug==
X-Google-Smtp-Source: AGHT+IEadRBBwYn12pQkXBfMgHtcp2x3xKPvWEqhGRutDsyqiAniSKiTzFSyil4ONY78ijFTJk1vPA==
X-Received: by 2002:a17:903:2451:b0:220:c067:7be0 with SMTP id d9443c01a7336-22c358c5221mr2450595ad.6.1744771973744;
        Tue, 15 Apr 2025 19:52:53 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2198a56sm9287243b3a.25.2025.04.15.19.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 19:52:53 -0700 (PDT)
Date: Wed, 16 Apr 2025 02:52:46 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net] bonding: use permanent address for MAC swapping if
 device address is same
Message-ID: <Z_8bfpQb_3fqYEcn@fedora>
References: <20250401090631.8103-1-liuhangbin@gmail.com>
 <3383533.1743802599@famine>
 <Z_OcP36h_XOhAfjv@fedora>
 <Z_yl7tQne6YTcU6S@fedora>
 <4177946.1744766112@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4177946.1744766112@famine>

On Tue, Apr 15, 2025 at 06:15:12PM -0700, Jay Vosburgh wrote:
> >> 
> >> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> >> index 950d8e4d86f8..0d4e1ddd900d 100644
> >> --- a/drivers/net/bonding/bond_main.c
> >> +++ b/drivers/net/bonding/bond_main.c
> >> @@ -2120,6 +2120,24 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> >>  			slave_err(bond_dev, slave_dev, "Error %d calling set_mac_address\n", res);
> >>  			goto err_restore_mtu;
> >>  		}
> >> +	} else if (bond->params.fail_over_mac == BOND_FOM_FOLLOW &&
> >> +		   BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
> >> +		   memcmp(slave_dev->dev_addr, bond_dev->dev_addr, bond_dev->addr_len) == 0) {
> >> +		/* Set slave to current active slave's permanent mac address to
> >> +		 * avoid duplicate mac address.
> >> +		 */
> >> +		curr_active_slave = rcu_dereference(bond->curr_active_slave);
> >> +		if (curr_active_slave) {
> >> +			memcpy(ss.__data, curr_active_slave->perm_hwaddr,
> >> +			       curr_active_slave->dev->addr_len);
> >> +			ss.ss_family = slave_dev->type;
> >> +			res = dev_set_mac_address(slave_dev, (struct sockaddr *)&ss,
> >> +					extack);
> >> +			if (res) {
> >> +				slave_err(bond_dev, slave_dev, "Error %d calling set_mac_address\n", res);
> >> +				goto err_restore_mtu;
> >> +			}
> >> +		}
> 
> 	Is this in replacement of the prior patch (that does stuff
> during failover), or in addition to?
> 
> 	I'm asking because in the above, if there is no
> curr_active_slave, e.g., all interfaces in the bond are down, the above
> would permit MAC conflict in the absence of logic in failover to resolve
> things.

Hmm, then how about use bond_for_each_slave() and find out the link
that has same MAC address with bond/new_slave?

Thanks
Hangbin

