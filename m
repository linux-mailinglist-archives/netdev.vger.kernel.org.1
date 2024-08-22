Return-Path: <netdev+bounces-120897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF2595B272
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B241C22F58
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 09:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DDB175D3F;
	Thu, 22 Aug 2024 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="QUdztwlz"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D313A3F2
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320564; cv=none; b=uCZWtfT8NOB+2G0SiFqa1TcD4I5CRvQ4u3BuUUoX5YPuHiUKoLdg5enzd/qCVyabrMgewtHVgb70e9MTTFOMaE6mOyUlwI/ZbaZYecXU4TaGl1giTDYoy69qc+j+mxMGVIn9h33ErPjtUYb9nLJTuv6+4q4DviqpC1zoIlU8yvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320564; c=relaxed/simple;
	bh=noEl+y+iaAUIg85RYvbLh5N1gcDN74kg/JD3kwCOeLE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLQbI6tmTwtB8WWGVRNqr6SqGarc/B3JPR5c1PhPs6k8g7cYO7qtyGm5AuMDsAOysxj72vGwDZdj5VwuAlohlg7suEHEWE8y4eOV1SRQECsnFIl+07BU1O3jEK2ywmL6oMQIGGZDoU3sEMEfUY1mvifh1cLLXPkk7UyIX4CcTF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=QUdztwlz; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 1440B208A9;
	Thu, 22 Aug 2024 11:55:59 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Flxjht2gCB-g; Thu, 22 Aug 2024 11:55:58 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6588220764;
	Thu, 22 Aug 2024 11:55:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6588220764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1724320558;
	bh=MQFzYTAFjwPp0uLvDTBrYJRx3vlQlv7HSKv8+NLtK0Q=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=QUdztwlznawbYvF1xG7LSCysYhyiGKl/yNHyO6LXtOxtW2EiAnEqee1mIWZncSgfD
	 sIlDq4Zr1gt7vSoNflUsiaIdwAFPGzih9WRDuj5yw/FuxDqMatNglwOb7Z0HxkuBu4
	 pFNPl0A0BaRJBpu10zO70iqfWZBpkF6QZVKxl2Hp4t7OaMPgmWHEWNs1jlv1bCcRPV
	 KpcxhJuD1/5zAHlPbFnANXZHidmRxdIBSReTmMiSKjnQ87Q/LI1Cr8L6AgXeXn/PpC
	 f9z+EbS5HHvOzCpiEpPmgKWJ/vcH1hcMfedPZKspn+L6zTMSw+Rl6VYFmLgTs5vx3D
	 7v9s80Z3bbJLw==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 11:55:58 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 11:55:58 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id A86CB31818F6; Thu, 22 Aug 2024 11:55:57 +0200 (CEST)
Date: Thu, 22 Aug 2024 11:55:57 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: Hangbin Liu <liuhangbin@gmail.com>, <netdev@vger.kernel.org>, Jay Vosburgh
	<j.vosburgh@gmail.com>, "David S . Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Nikolay Aleksandrov <razor@blackwall.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Simon Horman
	<horms@kernel.org>
Subject: Re: [PATCHv3 net-next 2/3] bonding: Add ESN support to IPSec HW
 offload
Message-ID: <ZscLLbkZnJmiYViM@gauss3.secunet.de>
References: <20240820004840.510412-1-liuhangbin@gmail.com>
 <20240820004840.510412-3-liuhangbin@gmail.com>
 <ZsS3Zh8bT-qc46s7@hog>
 <ZsXd8adxUtip773L@gauss3.secunet.de>
 <ZsXq6BAxdkVQmsID@Laptop-X1>
 <ZsXuJD4PEnakVA-W@hog>
 <ZsaHTbcZPH0O3RBJ@Laptop-X1>
 <ZsbkdzvjVf3GiYHa@gauss3.secunet.de>
 <Zsb5L-2srQLUpMmn@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zsb5L-2srQLUpMmn@hog>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Aug 22, 2024 at 10:39:11AM +0200, Sabrina Dubroca wrote:
> 2024-08-22, 09:10:47 +0200, Steffen Klassert wrote:
> > On Thu, Aug 22, 2024 at 08:33:17AM +0800, Hangbin Liu wrote:
> > > On Wed, Aug 21, 2024 at 03:39:48PM +0200, Sabrina Dubroca wrote:
> > > > > > > > +	if (!real_dev->xfrmdev_ops ||
> > > > > > > > +	    !real_dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
> > > > > > > > +		pr_warn("%s: %s doesn't support xdo_dev_state_advance_esn\n", __func__, real_dev->name);
> > > > > > > 
> > > > > > > xdo_dev_state_advance_esn is called on the receive path for every
> > > > > > > packet when ESN is enabled (xfrm_input -> xfrm_replay_advance ->
> > > > > > > xfrm_replay_advance_esn -> xfrm_dev_state_advance_esn), this needs to
> > > > > > > be ratelimited.
> > > > > > 
> > > > > > How does xfrm_state offload work on bonding?
> > > > > > Does every slave have its own negotiated SA?
> > > > > 
> > > > > Yes and no. Bonding only supports xfrm offload with active-backup mode. So only
> > > > > current active slave keep the SA. When active slave changes, the sa on
> > > > > previous slave is deleted and re-added on new active slave.
> > > > 
> > > > It's the same SA, there's no DELSA+NEWSA when we change the active
> > > > slave (but we call xdo_dev_state_delete/xdo_dev_state_add to inform
> > > > the driver/HW), and only a single NEWSA to install the offloaded SA on
> > > > the bond device (which calls the active slave's xdo_dev_state_add).
> > > 
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
> 
> It's only used by one device at a time, we only support offload with
> "active-backup" mode, where only the current active slave can send
> packets.
> 
> > Counter mode algorithms have the requirement that the IV
> > must not repeat. If you use the same key on two devices,
> > you can't guarantee that. If both devices use an internal
> > counter (initialized to one) to generate the IV, then the
> > IV repeats for the mumber of packets that were already
> > sent on the old device. The algorithm is cryptographically
> > broken in that case.
> 
> Aren't they basing the IV on the sequence number filled in the header?
> If not, then I guess this stuff has been broken since 2020 :(
> (18cb261afd7b ("bonding: support hardware encryption offload to slaves"))

Linux does that, but it is not guaranteed that other devices do that
too. It is perfectly Ok to use some internal counter (or anything
elase that does not repeat) to generate the IV.

> 
> > Instead of moving the existing state, it is better to
> > request a rekey. Maybe by setting the old state to
> > 'expired' and then send a km_state_expired() message.
> 
> But then you're going to drop packets during the whole rekey?

Yes, I know. That would be the downside of that.


