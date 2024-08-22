Return-Path: <netdev+bounces-120826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16EB95AE71
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 09:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55EF51F21D39
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 07:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DDF3D0D5;
	Thu, 22 Aug 2024 07:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="bfb6taAM"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7223D33EA
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310654; cv=none; b=a4xFK/weYkEQYSivYYSYq4Hm7UwCtnC5jrpXHNf/ezKLOCvnuYlR8G2AOxeztXw/DwLkBB6Ocz2xBHFNKLcfNw0kv4r5lnWexH2T4D9chiHIMIhTi5MH+YagFHH6qW29sRmBvhtlS4glKJpiwFP4oeXfi8UN2F9ogBqvnmNxh7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310654; c=relaxed/simple;
	bh=9GqLy4MRJnCIeIebz7LyC3oYFJzlUKLfcGEa2YAhVrA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J09reQWo9VaB5NCZ+JpPbZENkTcqIb6VI54GkjuOzwWp4CEHWqbzBUDPe2np4GWyCx/eTHTsxVAG5EUhb6DKh7YVdM1vmSx7G88l0+34zUB8t/YtJB4oMdFn6LWIvUPgruLIdtMEJuevkZZerIUDSs9bTspHaEX1inv1BhVFsug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=bfb6taAM; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 138CD208A9;
	Thu, 22 Aug 2024 09:10:49 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bgmXGK-bPvFI; Thu, 22 Aug 2024 09:10:48 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 75779208A2;
	Thu, 22 Aug 2024 09:10:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 75779208A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1724310648;
	bh=rBFQec11xX5jMwLUoQsJoEsvesxi1Gk7geKlrwKUFCg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=bfb6taAMgyPUkYy2Durypid5S0rc2k/mGq+gejlnsIx/vo64rFmRjMAQCsgM81Zz4
	 xt7xG1DAyJ7psB3xLY1UJyH2G65B61OVNDq0wCEzf7IW9uegD31aif/X7y1jAjXRUB
	 V/wnebLt3VgSVsa/kEA/s6Xp/5wXyNwAzYBrSGVvnbsty+duzcvA3xvklp0TZzIbHd
	 3zUpf7Pp3IWNJjZWWBLIrgQS3U4Ag3a6w1ZIMNoMbZI9j7KZyg0eggfo0rxKzq7j/Z
	 feN6sI/RTR44pj6z/Gfkc+rJWnU0sfYAQQnjay7VKKaIjZ50YBGNECyUUXxkzz5FMk
	 Y71cvC+Uk7s5w==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 09:10:48 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 09:10:47 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 7D9F53181005; Thu, 22 Aug 2024 09:10:47 +0200 (CEST)
Date: Thu, 22 Aug 2024 09:10:47 +0200
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
Message-ID: <ZsbkdzvjVf3GiYHa@gauss3.secunet.de>
References: <20240820004840.510412-1-liuhangbin@gmail.com>
 <20240820004840.510412-3-liuhangbin@gmail.com>
 <ZsS3Zh8bT-qc46s7@hog>
 <ZsXd8adxUtip773L@gauss3.secunet.de>
 <ZsXq6BAxdkVQmsID@Laptop-X1>
 <ZsXuJD4PEnakVA-W@hog>
 <ZsaHTbcZPH0O3RBJ@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZsaHTbcZPH0O3RBJ@Laptop-X1>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Aug 22, 2024 at 08:33:17AM +0800, Hangbin Liu wrote:
> On Wed, Aug 21, 2024 at 03:39:48PM +0200, Sabrina Dubroca wrote:
> > > > > > +	if (!real_dev->xfrmdev_ops ||
> > > > > > +	    !real_dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
> > > > > > +		pr_warn("%s: %s doesn't support xdo_dev_state_advance_esn\n", __func__, real_dev->name);
> > > > > 
> > > > > xdo_dev_state_advance_esn is called on the receive path for every
> > > > > packet when ESN is enabled (xfrm_input -> xfrm_replay_advance ->
> > > > > xfrm_replay_advance_esn -> xfrm_dev_state_advance_esn), this needs to
> > > > > be ratelimited.
> > > > 
> > > > How does xfrm_state offload work on bonding?
> > > > Does every slave have its own negotiated SA?
> > > 
> > > Yes and no. Bonding only supports xfrm offload with active-backup mode. So only
> > > current active slave keep the SA. When active slave changes, the sa on
> > > previous slave is deleted and re-added on new active slave.
> > 
> > It's the same SA, there's no DELSA+NEWSA when we change the active
> > slave (but we call xdo_dev_state_delete/xdo_dev_state_add to inform
> > the driver/HW), and only a single NEWSA to install the offloaded SA on
> > the bond device (which calls the active slave's xdo_dev_state_add).
> 
> Yes, thanks for the clarification. The SA is not changed, we just delete it
> on old active slave
> 
> slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
> 
> And add to now one.
> 
> ipsec->xs->xso.real_dev = slave->dev;
> slave->dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)

Using the same key on two different devices is very dangerous.
Counter mode algorithms have the requirement that the IV
must not repeat. If you use the same key on two devices,
you can't guarantee that. If both devices use an internal
counter (initialized to one) to generate the IV, then the
IV repeats for the mumber of packets that were already
sent on the old device. The algorithm is cryptographically
broken in that case.

Instead of moving the existing state, it is better to
request a rekey. Maybe by setting the old state to
'expired' and then send a km_state_expired() message.

