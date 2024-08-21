Return-Path: <netdev+bounces-120611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A33959F39
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 16:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98CEEB2235F
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B27A1B1D57;
	Wed, 21 Aug 2024 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="wwb/OO/7"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141E21AF4EE
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724248988; cv=none; b=ZHXSXRjf5bXZlf/Iep20oMRKBFf9gaLJBBijTT5Kc2zXYk53MzyqvukCLPPtyD6LzfzmCptFE2eUlcDNZPGBN3oS1zUZsoZ7e0Z8HbvXJqTHxFZ5BCfrXjuh4pUQ3jsAI2+L/nhRHAPKlTS66zw4d6pz6t5V8JN6/jU8YJpC+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724248988; c=relaxed/simple;
	bh=x7WZnnWv3HtVb6+7egCVuPRH9ReRe+5SJ97qmPWeLSU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqzU54PgW4U81sFK5cx1bpbbEVO72/xFtsSm0TCODrD/Ero1NNSw1nYKTnhd9y7/NP5POBTnrN46DtyEvGMCPTDL2JClTW8Xb/sNnm6pAdwknhCzMqMOyOOzKazyiOi2PDXwrK0tX4m4SH8TEOHwDiw3MKmGOitJWCpkDrWrocA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=wwb/OO/7; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id F2AE6208B0;
	Wed, 21 Aug 2024 16:03:02 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5H37G0_8W0K4; Wed, 21 Aug 2024 16:03:02 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 63988208AA;
	Wed, 21 Aug 2024 16:03:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 63988208AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1724248982;
	bh=2KipRSTjy1f+yZK0K2r7B5rc8gFuRPH5HOp2Xrz9VWE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=wwb/OO/7QX0ccN86kc2sTC0dFbTdhT1qpk9TKRB5ehyyM2+tF+ocew2k2YvZoyaOr
	 WbQAfYZ1TSQUOsKYFYnRYA1zBQTT7VNx3HVYcdvI64lWV7kdUqagpKgPm0xNSxl/KF
	 WobKthnI6zuABi0HgYWkSqF+BjvVMDFp9hNWvA+FOWceESGqUs5av3EoK1Cu/0Nkra
	 8gso6O5gGjD94YgiE5FxHx9usOlfEjsob8Zh/5GDqL6HXgunzmc1VEU71xuGSycPV/
	 webKbj3sIL3x7FtKGRIYfssLepYJ/ifclyw0vLVy3Xvbk8LQaUkcT+dKtWx+g8ad1o
	 Fs5navFCQ9C3A==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 16:03:02 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 16:03:01 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 74C9C3183CDE; Wed, 21 Aug 2024 16:03:01 +0200 (CEST)
Date: Wed, 21 Aug 2024 16:03:01 +0200
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
Message-ID: <ZsXzlQQjMNymDkhJ@gauss3.secunet.de>
References: <20240820004840.510412-1-liuhangbin@gmail.com>
 <20240820004840.510412-3-liuhangbin@gmail.com>
 <ZsS3Zh8bT-qc46s7@hog>
 <ZsXd8adxUtip773L@gauss3.secunet.de>
 <ZsXq6BAxdkVQmsID@Laptop-X1>
 <ZsXuJD4PEnakVA-W@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZsXuJD4PEnakVA-W@hog>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Aug 21, 2024 at 03:39:48PM +0200, Sabrina Dubroca wrote:
> 2024-08-21, 21:26:00 +0800, Hangbin Liu wrote:
> > On Wed, Aug 21, 2024 at 02:30:41PM +0200, Steffen Klassert wrote:
> > > > > +/**
> > > > > + * bond_advance_esn_state - ESN support for IPSec HW offload
> > > > > + * @xs: pointer to transformer state struct
> > > > > + **/
> > > > > +static void bond_advance_esn_state(struct xfrm_state *xs)
> > > > > +{
> > > > > +	struct net_device *real_dev;
> > > > > +
> > > > > +	rcu_read_lock();
> > > > > +	real_dev = bond_ipsec_dev(xs);
> > > > > +	if (!real_dev)
> > > > > +		goto out;
> > > > > +
> > > > > +	if (!real_dev->xfrmdev_ops ||
> > > > > +	    !real_dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
> > > > > +		pr_warn("%s: %s doesn't support xdo_dev_state_advance_esn\n", __func__, real_dev->name);
> > > > 
> > > > xdo_dev_state_advance_esn is called on the receive path for every
> > > > packet when ESN is enabled (xfrm_input -> xfrm_replay_advance ->
> > > > xfrm_replay_advance_esn -> xfrm_dev_state_advance_esn), this needs to
> > > > be ratelimited.
> > > 
> > > How does xfrm_state offload work on bonding?
> > > Does every slave have its own negotiated SA?
> > 
> > Yes and no. Bonding only supports xfrm offload with active-backup mode. So only
> > current active slave keep the SA. When active slave changes, the sa on
> > previous slave is deleted and re-added on new active slave.
> 
> It's the same SA, there's no DELSA+NEWSA when we change the active
> slave (but we call xdo_dev_state_delete/xdo_dev_state_add to inform
> the driver/HW), and only a single NEWSA to install the offloaded SA on
> the bond device (which calls the active slave's xdo_dev_state_add).

Maybe I miss something, but how is the sequence number, replay window
etc. transfered from the old to the new active slave?

