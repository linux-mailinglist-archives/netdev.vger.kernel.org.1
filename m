Return-Path: <netdev+bounces-121272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778AB95C7FF
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 10:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4971C21D60
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 08:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382481442EA;
	Fri, 23 Aug 2024 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="C4gz7A9u"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6A93D552
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401499; cv=none; b=GqFgJQ3CIne7/L0VfkAX1jQMF3g3RzFiMMZw1Tbu8P0l/qyjjmbUmIDsRUptnr+gV7YgG42Sk/WMnjVouMcMRfu+koXS+6m9fNddkpF81aqtWMGC6bPCj0mJ9ILfqa6otjWg9TGzvxpDk/R1O48JsDuRXvZ5VR5NQnGlkfav5G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401499; c=relaxed/simple;
	bh=X/LZYP81K2LZaFEZe4ZyB0s/LHkjdzjWUL/41g4Be6c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKnc8DHi8HAlxuzjEesy3NlHTSP8LvFTV6o6Rbu6HXY3Gflr1/R7pb/p/K6WqtGY3Fga2IfA3hqGNGC4QI94qeYsGgur67h4H3fJv+TtQG/qSOxD74kxsK8Z0mT6Wm36N3YoHcUjsmHGIwomMkZc4S841OGhcbw5umKHNuXuxr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=C4gz7A9u; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 2877F208AB;
	Fri, 23 Aug 2024 10:24:48 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R_MVa2PWKIWH; Fri, 23 Aug 2024 10:24:47 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 877B0207D8;
	Fri, 23 Aug 2024 10:24:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 877B0207D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1724401487;
	bh=fME3CfSoZsYRHqqE9lJKqVoD13BcYf4yLe50SqulWTA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=C4gz7A9ugdQ13Q4K1ENE6CFdtB8TuvQNhCgzMymb8JxpbQIEb4GNpHAcRB3PrzIjL
	 vcpLmKe/5g2PI+iBsiwdtXcFNP5EcP9uj4inmfe8EHIkIXyI7fg8LDpkGrn4aEr3YT
	 Tja415zJwdDVcS2F7sFM0xbNWOg8gy0bkPsLFJytvYGnBQCo8I6GJ645FGxUTFJSU2
	 8l82oIBk0878vjVhrdGbQHfYK+L/HCMENlJVJvUcBkGPmjhLS5HFtji2zwjRxc6oz8
	 oYHms0ZrnxjoTn4q9WCx1WerJbjYp56nKD9QBIv3qVylhIyXCb0mrA27pZDLPpygl0
	 gcvksRT1Wnzfg==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 10:24:47 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Aug
 2024 10:24:46 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 7CEEE3181477; Fri, 23 Aug 2024 10:24:46 +0200 (CEST)
Date: Fri, 23 Aug 2024 10:24:46 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Hangbin Liu <liuhangbin@gmail.com>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>, "Jay
 Vosburgh" <j.vosburgh@gmail.com>, "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>, Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, "Simon
 Horman" <horms@kernel.org>
Subject: Re: [PATCHv3 net-next 2/3] bonding: Add ESN support to IPSec HW
 offload
Message-ID: <ZshHTlUb/BCtvCT0@gauss3.secunet.de>
References: <20240820004840.510412-1-liuhangbin@gmail.com>
 <20240820004840.510412-3-liuhangbin@gmail.com>
 <ZsS3Zh8bT-qc46s7@hog>
 <ZsXd8adxUtip773L@gauss3.secunet.de>
 <ZsXq6BAxdkVQmsID@Laptop-X1>
 <ZsXuJD4PEnakVA-W@hog>
 <ZsaHTbcZPH0O3RBJ@Laptop-X1>
 <ZsbkdzvjVf3GiYHa@gauss3.secunet.de>
 <Zsb34DsLwVrDI-w5@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zsb34DsLwVrDI-w5@Laptop-X1>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Aug 22, 2024 at 04:33:36PM +0800, Hangbin Liu wrote:
> Hi Steffen,
> On Thu, Aug 22, 2024 at 09:10:47AM +0200, Steffen Klassert wrote:
> > > Yes, thanks for the clarification. The SA is not changed, we just delete it
> > > on old active slave
> > > 
> > > slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
> > > 
> > > And add to now one.
> > > 
> > > ipsec->xs->xso.real_dev = slave->dev;
> > > slave->dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)
> > 
> > Using the same key on two different devices is very dangerous.
> > Counter mode algorithms have the requirement that the IV
> > must not repeat. If you use the same key on two devices,
> > you can't guarantee that. If both devices use an internal
> > counter (initialized to one) to generate the IV, then the
> > IV repeats for the mumber of packets that were already
> > sent on the old device. The algorithm is cryptographically
> > broken in that case.
> > 
> > Instead of moving the existing state, it is better to
> > request a rekey. Maybe by setting the old state to
> > 'expired' and then send a km_state_expired() message.
> 
> Thanks for your comments. I'm not familiar with IPsec state.
> Do you mean something like
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index f74bacf071fc..8a51d0812564 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -477,6 +477,7 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>  	struct net_device *bond_dev = bond->dev;
>  	struct bond_ipsec *ipsec;
>  	struct slave *slave;
> +	struct km_event c;
>  
>  	rcu_read_lock();
>  	slave = rcu_dereference(bond->curr_active_slave);
> @@ -498,6 +499,13 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>  	spin_lock_bh(&bond->ipsec_lock);
>  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
>  		ipsec->xs->xso.real_dev = slave->dev;
> +
> +		ipsec->xs->km.state = XFRM_STATE_VALID;
> +		c.data.hard = 1;
> +		c.portid = 0;
> +		c.event = XFRM_MSG_NEWSA;
> +		km_state_notify(x, &c);

The xfrm stack does that already when inserting the state.

> +
>  		if (slave->dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
>  			slave_warn(bond_dev, slave->dev, "%s: failed to add SA\n", __func__);
>  			ipsec->xs->xso.real_dev = NULL;
> @@ -580,6 +588,8 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>  				   "%s: no slave xdo_dev_state_delete\n",
>  				   __func__);
>  		} else {
> +			ipsec->xs->km.state = XFRM_STATE_EXPIRED;

I think you also need to set 'x->km.dying = 1'.

> +			km_state_expired(ipsec->xs, 1, 0);

Please test this at least with libreswan and strongswan. The state is
actually not expired, so not sure if the IKE daemons behave as we want
in that case.

Downside of this approach is that you loose some packets until the new
SA is negotiated, as Sabrina mentioned.

