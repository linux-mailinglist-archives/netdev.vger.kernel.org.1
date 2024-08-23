Return-Path: <netdev+bounces-121340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C3D95CCCC
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7EF41C21D75
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 12:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCD6185936;
	Fri, 23 Aug 2024 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJTWUgdC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9231D178372
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417311; cv=none; b=s86pngLDRhqEi7/t49YGyKgn2MtqZG8xH6Pufq6ZWtMC1PzDmbemJV5RCA4RxkmtgvkVrBuet/WaaSTvWnfegnBIfXXCBtzjaoEEnRyZ655z4o/6cySsFSe8LDyY45MxZImzYpfT7JT+qoyEkzb8Z0RVLnAg8AqKXGWbts57lJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417311; c=relaxed/simple;
	bh=YoLIPmNEcaQh8rUPCcdTCoVgNiBhtSd1Ne9F/9dUlsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyOhoWMS5uN0ioYa5GWj83eVeWkxZQJg3BN9eOdOa351gOrQXPTLn43QSD/1oY7CY/3LySHPnfpqhLfOEcSk2PxOzloGwHsTm5d7BIVjP2fLz3u+moeLm3r9KMC+zOkv6CiTCL3IGlQ/63Lx2L60dch9mMqdKOImxBs+mkvnXkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJTWUgdC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71446fefddfso451934b3a.0
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 05:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724417309; x=1725022109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLc1sIScAqLvVq+b9Ry4RgUgr9BTg9RnXWWicvEoy/Y=;
        b=cJTWUgdCW+vh4vSqMMyxprpHP6Cw/AtVy7kBlFlDYXGAZdzpyF8sr//peJLZ0OvFOK
         tlea379l94dTc3jWrC7FnJDFvmM7dv2ikjVFR7O9RR0l/NWNwwM3la/oSRvGlDjdBxiY
         RHoFgumzOr+yPPLOS6Q9x9goy8qTLHlgQPcWFl9XCaZZ6ENLt/hOXboymSpuNqqe/uXX
         iV8jfhL1awkQoCzRaZhIOs/gcHA1ZkyllFSPZbrQcFv12Jf6w3bYk9orGhCfsxa5nJiy
         z9TpMIdLT91DJYD7uOaXjF+45Mshq9sbpiH4R/ejWGDZvRYOhFSL5CkvBn/zV1g6gJMi
         8vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724417309; x=1725022109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLc1sIScAqLvVq+b9Ry4RgUgr9BTg9RnXWWicvEoy/Y=;
        b=oBMpF4LElvFwlRbEguwWrIfUuSRofZi8T3DmWtjiQQB0Sf1DaLVXMojrrHeBp8iR4a
         MVRcMu+dsJvK2wEBU1M6JAl7yOk+TYfDNWij6Cr/xFrnJ5O7lu0hH43P4QBQ9N5EKNcZ
         k7fGFi6dIJA5Ju7tZns9w3Ek3nRPQYqYOYSvWAIQ3lERgqfjxRU38G6NazHTFR1n06/p
         YKQ6bVultZl44r3lin9C7utna5itLStBzEuiXj3elrnfnHq6eLOPIAMnuFotAo5heHg9
         lcgZPRKL/fyXQ+P4O+EAS6Z9IavwjBewoQu7htOIMKRebH6WirMSIzsQy7Ek7AwOu2z2
         Y82Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXaCI6XSAPfEFNqQjQpRa5oqZW40RnmYMkIOpI2tEeqbAdl01afk9nrlg+uzTFuMP4fkshglo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtFgH/bkJEyWUYdTKDzPqoSFfrtavCoY3322995U85aGj4iGkn
	20qg3D0SLv15UTxGd8Lqoc2OL/VVn7Y6dgCayVuH9gVo5KL9meqz
X-Google-Smtp-Source: AGHT+IGKC+p06gRPJt+8EPWiPGsclKBLISE3Gus3C46Uv+UpQZWPPum16h6sfG6PHUBjYHJ1QDQ0Ug==
X-Received: by 2002:a05:6a00:3e11:b0:70b:5394:8cae with SMTP id d2e1a72fcca58-714458c4101mr2813222b3a.28.1724417308712;
        Fri, 23 Aug 2024 05:48:28 -0700 (PDT)
Received: from Laptop-X1 ([182.246.96.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714433cd970sm1394273b3a.60.2024.08.23.05.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:48:28 -0700 (PDT)
Date: Fri, 23 Aug 2024 20:48:21 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCHv3 net-next 2/3] bonding: Add ESN support to IPSec HW
 offload
Message-ID: <ZsiFFX7AizhF-ptV@Laptop-X1>
References: <20240820004840.510412-1-liuhangbin@gmail.com>
 <20240820004840.510412-3-liuhangbin@gmail.com>
 <ZsS3Zh8bT-qc46s7@hog>
 <ZsXd8adxUtip773L@gauss3.secunet.de>
 <ZsXq6BAxdkVQmsID@Laptop-X1>
 <ZsXuJD4PEnakVA-W@hog>
 <ZsaHTbcZPH0O3RBJ@Laptop-X1>
 <ZsbkdzvjVf3GiYHa@gauss3.secunet.de>
 <Zsb34DsLwVrDI-w5@Laptop-X1>
 <ZshHTlUb/BCtvCT0@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZshHTlUb/BCtvCT0@gauss3.secunet.de>

Hi Steffen,
On Fri, Aug 23, 2024 at 10:24:46AM +0200, Steffen Klassert wrote:
> > Thanks for your comments. I'm not familiar with IPsec state.
> > Do you mean something like
> > 
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index f74bacf071fc..8a51d0812564 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -477,6 +477,7 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
> >  	struct net_device *bond_dev = bond->dev;
> >  	struct bond_ipsec *ipsec;
> >  	struct slave *slave;
> > +	struct km_event c;
> >  
> >  	rcu_read_lock();
> >  	slave = rcu_dereference(bond->curr_active_slave);
> > @@ -498,6 +499,13 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
> >  	spin_lock_bh(&bond->ipsec_lock);
> >  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> >  		ipsec->xs->xso.real_dev = slave->dev;
> > +
> > +		ipsec->xs->km.state = XFRM_STATE_VALID;
> > +		c.data.hard = 1;
> > +		c.portid = 0;
> > +		c.event = XFRM_MSG_NEWSA;
> > +		km_state_notify(x, &c);
> 
> The xfrm stack does that already when inserting the state.

Thanks for this info.

> 
> > +
> >  		if (slave->dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
> >  			slave_warn(bond_dev, slave->dev, "%s: failed to add SA\n", __func__);
> >  			ipsec->xs->xso.real_dev = NULL;
> > @@ -580,6 +588,8 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
> >  				   "%s: no slave xdo_dev_state_delete\n",
> >  				   __func__);
> >  		} else {
> > +			ipsec->xs->km.state = XFRM_STATE_EXPIRED;
> 
> I think you also need to set 'x->km.dying = 1'.
> 
> > +			km_state_expired(ipsec->xs, 1, 0);
> 
> Please test this at least with libreswan and strongswan. The state is
> actually not expired, so not sure if the IKE daemons behave as we want
> in that case.

OK, this fix should be not related the current patch set. I will post this fix
after more tests.

Thanks
Hangbin
> 
> Downside of this approach is that you loose some packets until the new
> SA is negotiated, as Sabrina mentioned.

