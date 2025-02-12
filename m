Return-Path: <netdev+bounces-165388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD9CA31D10
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 04:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930E3164BF2
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6A31D63DD;
	Wed, 12 Feb 2025 03:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jvp9H/Ez"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E51271838
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 03:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739332134; cv=none; b=moYFBVn1+Cg63A3biXNF01QOKmHnUejZhkx+bQKXoEzz3XZt7ls9Oj2p4LMHGOa9YFwh8ntOhAiskG9PxNfc2PJlhNXgXauA/oRjIHtlCao+cjp5G1FEjp85QCo2L5kCahpI15+HUF8HTGMNp7s5zt/y3YzwJUxLI421M1pKot0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739332134; c=relaxed/simple;
	bh=SfDxJjMWuHY5xvqJCY/O0Yz6x59nb/eqslg6PQVVZiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0EBhC7oo6YccEFho0GGp5tVHAxcqOAJH465lSYj2cKRShwokGqBHy2GKAajShuAE3GUAmaIbAE9DsOxE3QlyKIQip7Fj5EkDeJr+MgaCU/cNgTz88UBGCrkYW1yTs7ThEfzIc4aKTpdP3TGLl8OrNOOfH6wQphe+tajxdHzW4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jvp9H/Ez; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f4a4fbb35so6181105ad.0
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739332132; x=1739936932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wMWJoNbAPs4jmPej1sd/2yxOghVdzz7wgtSlJIBv6F0=;
        b=Jvp9H/Ezh6GYJGaLb7ZdooE40rVbbbrrP5AwnsZ37zM1yO06dOWd+DEbUUdoDs2KIX
         jeoNs60/hsf/csbPPRlfiRBYtD7H216YOWlqT+o5qQC+iCYiEbLs0+f2qCi+kfa3CaF9
         AzoysdxchFpSDNC2dGaPNVSCCfE80hP1T4DIz0DW0URDZQ2fZJQigfAF6QJvTTY/9iAH
         Nteb8zi6gOskrBP9VmxRnuiA/wSWcO/As3/VpdO1NBqUvOtgPjFc9q+n/O0+tbW5meYf
         h/NbcooZkyK1wTgECAd0sTtxcK57h0EcA7RJuASLcuoN1FyOCUo2TAe+Uq63hIbZcDtk
         Nmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739332132; x=1739936932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMWJoNbAPs4jmPej1sd/2yxOghVdzz7wgtSlJIBv6F0=;
        b=ieCz9Z5t+Y5C/2mJBPJ5gB4TofuKkPZBqITAUAz+N61u+zUShuyJ/eWr/0EidcRJne
         cGX7THnGW0WfYIYoADK6MnZyXwPqYSLROnOX7gUlWYOdTTTEbSycVjGpZNlPbnTTXr3G
         OZ1FvGqyP4MuXr07XEXq7am7Ryq1ZK+RhW2LDlNtfxlMkspoVSB6sIUYur0b0Qlox2mu
         iR/eKOs3InINNX50KF2rCIEWxw9FhBmwxlDnH4zPZggnW/bM3Mrt+A2SeaPQjhmG9PQN
         BfBUdJwKaBLSI26I+x1wnOd2CpT1wnCMZnswXeBExWlONobBzJa8yRaY9LJpqGOQaT0r
         DuaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw/SdRV/Oc3cNNiv4rHnU0A0NqOcPs+jVGa6hZNWLXXXmNsfYqpgPHL8+wLo180m2ntjz38v8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5/nFvBLumj8oBxXzTu4uncNwVEOoM8Ux40Mu47BfvyHa9d5MC
	TQk73Dc8GnWCTaoHjq/KKp1UfohASwSOZ7gq2qzdRkJQug1E0e8=
X-Gm-Gg: ASbGncsvSAhfUjgZNDGdgMiKaWW+LoiK23yYlnYRWgmHxrw3x3AqHx2dFm6FXKGl+op
	UgZ/ue94CqTFU6k/pzOQgOgdsq0pDkJbxqnz+JuL4sTIggegwNmkvW73iBITjXPC+r2ALieLbjS
	IEYnTuNKZ0l+A5GllEgRh5jJXI97gzO6IsxpTw9OPgNBUH2rrcS1I60XL69J66wgIc7wVdwVld4
	Y2NPi8/wguqT3Nri0coDTlG27FBLyEbckEMpowlc81bKEyzSwoiVrIf9uiSSlasCdA09thEFRgW
	SUCFWx695YlsuLU=
X-Google-Smtp-Source: AGHT+IEE7n/RnCCS5YnAr99ueWEyNQM1vfKbFJPHfydnqlD7VoYbN6PmeWbdNMjK+sifjoEnZuXGNQ==
X-Received: by 2002:a17:902:f68b:b0:21f:97c3:f885 with SMTP id d9443c01a7336-21fb6f3a562mr104854215ad.18.1739332131988;
        Tue, 11 Feb 2025 19:48:51 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f368b4fcasm102950565ad.230.2025.02.11.19.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 19:48:51 -0800 (PST)
Date: Tue, 11 Feb 2025 19:48:50 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next 02/11] net: hold netdev instance lock during
 ndo_setup_tc
Message-ID: <Z6waIoWA8EBllLVk@mini-arch>
References: <20250210192043.439074-1-sdf@fomichev.me>
 <20250210192043.439074-3-sdf@fomichev.me>
 <20250211182016.305f1c77@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211182016.305f1c77@kernel.org>

On 02/11, Jakub Kicinski wrote:
> On Mon, 10 Feb 2025 11:20:34 -0800 Stanislav Fomichev wrote:
> > Introduce new dev_setup_tc that handles the details and call it from
> > all qdiscs/classifiers. The instance lock is still applied only to
> > the drivers that implement shaper API so only iavf is affected.
> 
> > +int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
> > +		 void *type_data)
> > +{
> > +	const struct net_device_ops *ops = dev->netdev_ops;
> > +
> > +	ASSERT_RTNL();
> > +
> > +	if (tc_can_offload(dev) && ops->ndo_setup_tc) {
> > +		int ret = -ENODEV;
> > +
> > +		if (netif_device_present(dev)) {
> > +			netdev_lock_ops(dev);
> > +			ret = ops->ndo_setup_tc(dev, type, type_data);
> > +			netdev_unlock_ops(dev);
> > +		}
> > +
> > +		return ret;
> > +	}
> > +
> > +	return -EOPNOTSUPP;
> 
> Why the indent? IMHO this would be cleaner:
> 
> 	if (!tc_can_offload || !ops...
> 		return -ENOPNOTSUPP;
> 	if (!netif_device_present(dev))
> 		return -ENODEV:
> 
> 	netdev_lock_ops(dev);
> 	...

I was trying to keep consistent style with existing
dev_siocbond/dev_siocdevprivate/dev_siocwandev. Agreed that non-indented
flow looks much nicer, will use it for dev_setup_tc.

> > diff --git a/net/dsa/user.c b/net/dsa/user.c
> > index 291ab1b4acc4..f2ac7662e4cc 100644
> > --- a/net/dsa/user.c
> > +++ b/net/dsa/user.c
> > @@ -1729,10 +1729,7 @@ static int dsa_user_setup_ft_block(struct dsa_switch *ds, int port,
> >  {
> >  	struct net_device *conduit = dsa_port_to_conduit(dsa_to_port(ds, port));
> >  
> > -	if (!conduit->netdev_ops->ndo_setup_tc)
> > -		return -EOPNOTSUPP;
> > -
> > -	return conduit->netdev_ops->ndo_setup_tc(conduit, TC_SETUP_FT, type_data);
> > +	return dev_setup_tc(conduit, TC_SETUP_FT, type_data);
> 
> The netfilter / flow table offloads don't seem to test tc_can_offload(),
> should we make that part of the check optional in dev_setup_tc() ?
> Add a bool argument to ignore  tc_can_offload() ?

Let me dig into it... I was assuming that tc_can_offload() is basically
a runtime way to signal to the core that even though the device has
ndo_setup_tc defined, the feature can't be used.

I don't understand why some places care only about ndo_setup_tc
while other test for both ndo_setup_tc/tc_can_offload. Do you by
chance have any context on this? Does tc_can_offload cover only
a subset of (TC_SETUP_BLOCK) the offload types?

The easiest way is probably just to keep calls to tc_can_offload outside,
as is, but I was thinking that doing both ndo_setup_tc and tc_can_offload
is a bit more safe.

> > @@ -855,10 +853,7 @@ void qdisc_offload_graft_helper(struct net_device *dev, struct Qdisc *sch,
> >  	bool any_qdisc_is_offloaded;
> >  	int err;
> >  
> > -	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
> > -		return;
> > -
> > -	err = dev->netdev_ops->ndo_setup_tc(dev, type, type_data);
> > +	err = dev_setup_tc(dev, type, type_data);
> 
> Probably need to handle -EOPNOTSUPP here now?

Ah, yes, thanks!

> >  	/* Don't report error if the graft is part of destroy operation. */
> >  	if (!err || !new || new == &noop_qdisc)
> 
> > -	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
> > +	err = dev_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
> >  	if (err < 0)
> >  		pr_warn("Couldn't disable CBS offload for queue %d\n",
> >  			cbs.queue);
> > @@ -294,7 +289,7 @@ static int cbs_enable_offload(struct net_device *dev, struct cbs_sched_data *q,
> >  	cbs.idleslope = opt->idleslope;
> >  	cbs.sendslope = opt->sendslope;
> >  
> > -	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
> > +	err = dev_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
> 
> $ for f in $(git grep --files-with-matches TC_SETUP_QDISC_CBS -- drivers/ ); do \
> 	d=$(dirname $f); \
> 	git grep HW_TC -- $d || echo No match in $d; \
> done
> 
> No match in drivers/net/dsa/microchip
> No match in drivers/net/dsa/ocelot
> No match in drivers/net/dsa/sja1105
> drivers/net/ethernet/freescale/enetc/enetc_pf.c:        if (changed & NETIF_F_HW_TC) {
> drivers/net/ethernet/freescale/enetc/enetc_pf.c:                err = enetc_set_psfp(ndev, !!(features & NETIF_F_HW_TC));
> drivers/net/ethernet/freescale/enetc/enetc_pf_common.c:         ndev->features |= NETIF_F_HW_TC;
> drivers/net/ethernet/freescale/enetc/enetc_pf_common.c:         ndev->hw_features |= NETIF_F_HW_TC;
> drivers/net/ethernet/intel/igb/igb_main.c:              netdev->features |= NETIF_F_HW_TC;
> drivers/net/ethernet/intel/igc/igc_main.c:      netdev->features |= NETIF_F_HW_TC;
> drivers/net/ethernet/microchip/lan966x/lan966x_main.c:                   NETIF_F_HW_TC;
> drivers/net/ethernet/microchip/lan966x/lan966x_main.c:  dev->hw_features |= NETIF_F_HW_TC;
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:              ndev->hw_features |= NETIF_F_HW_TC;
> drivers/net/ethernet/ti/am65-cpsw-nuss.c:                                 NETIF_F_HW_TC;
> drivers/net/ethernet/ti/cpsw_new.c:                               NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_TC;
> 
> 
> Looks like some the these qdiscs will need to ignore the features too :(

Hmm, so TC_SETUP_QDISC_CBS is not influenced by NETIF_F_HW_TC? I guess
it's the same discussion as above... LMK if you have more details.

Thank you for the review, will incorporate the rest of the feedback
from the other replies as well!

