Return-Path: <netdev+bounces-106735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B339175CF
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7761C21B8C
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A427F10958;
	Wed, 26 Jun 2024 01:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BP7NAZkx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B01CFBD
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 01:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366174; cv=none; b=Qvo8aKRAZYK3UyBkzkvduC24QOxxiQKbXDYHYQdWqWTSMIgnEBfvAhZ4teGebakdFw0t9+ezeFcPhKzeP46lq7qA5rSnElPPe3zbKIechkqbK4B1VftRmMnFJaCfcs0vwfjlWefX99tsge3Bj8RFNfvWGQOQBB2QOdlhCEqlB+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366174; c=relaxed/simple;
	bh=hV4MvOzxweAUKa4VU90jHft8NBFZDSb05yQt9fbr/2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XX0ue/JTs6PYT+LDcbtD6jhXHe5ZI/V+KpAAK5GsUsd45nIAbhG7cN0j5+RRdZX/VlCbfVXDhh9KjunBm/h9YhXezWDGYtoiwll1OSnbLKGOP47PSSgIYBF92IfzvWvDLJEiDQuDYGfne9yct553dggiDqX20CcSGhA9lZMnVbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BP7NAZkx; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7eb7a2f062cso247357439f.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 18:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719366172; x=1719970972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VTOTdsCqdIqZV++yC0nnTniqEdQHRUoaMcIDrhkr6KY=;
        b=BP7NAZkxn9OKP5UV9wASALG8DuzDkqpQpTFKWiKMmIAhfdB9rwLiKvAS26b3je79Wd
         XQRrCd88os7ebWQA8cSGrkBfyIJ7l9xn68ZtNdldKWV4R1yMHOuOVTC+bFrOghr4KyEr
         5wZOnjrUaZ9oQ79oDJPyXCMYdRSkR39ebCVBMBEgEhFoJmT1b1PuH6hOMR7PbVO5E5Vh
         qcLR8aL9zn52bhoVSODYGqsYNfd2q2577o0sXMo0+4SzcPZ35+plxX5LeECDHWEhn/Y0
         HYGI9YdvUXGSbf9QK/Z9VMwrvVZYuUI9GDVMekmoQ36ilx3mfrzFHNs42M+zaycI5iZ0
         H4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719366172; x=1719970972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTOTdsCqdIqZV++yC0nnTniqEdQHRUoaMcIDrhkr6KY=;
        b=uILOS+FvlEV2dsfPMt23ENjlkhf316W2no79SNbZQSjSTLr3lTW/O21hWjCKPKTix7
         a30tt5aaX0l12lYjHr8zveqhYwfg3z46hWTE9TkBHJ015G2edOu6dobRWcKLGCrgqI3V
         lQyLdb4rRdz2932GNhPWrMXkdP5cbRQVOy6MCDjm3ut63lNoIe9pozJ4OfNh0zm/gTNT
         dJAVzQpWtt95OeWpAGMxktG9D39d2y43VeH0BsOFLgRLoNfuFflpN17vyzHr8pgbc+R2
         6IMfpaPfmJ/hejzKjMMsi/05ZLW4s7LH5bxABJDdhzrXXaoBT8g2f+SXv9UFx9Ogy4Qz
         OOKw==
X-Gm-Message-State: AOJu0YwwSzaukFLkzRZYBHlvDcM/N8thLpnYCFMOP3PWBvTTH/bEzHF3
	q0oOCzSkuV2arCQGLdirLyDvSU4xv3nRb/Q0iGc0rGH0K/TBNz0q
X-Google-Smtp-Source: AGHT+IGmLsGJ8uOl4LqvgnqNozyAOhDyXOK1CCrqdgny5HaEOP6n9nTZD924xJl86EosjZpAKMJAeQ==
X-Received: by 2002:a05:6602:2dc3:b0:7eb:906e:e3d4 with SMTP id ca18e2360f4ac-7f3a7532be9mr1184327839f.7.1719366172196;
        Tue, 25 Jun 2024 18:42:52 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7069c37b180sm1956910b3a.144.2024.06.25.18.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 18:42:51 -0700 (PDT)
Date: Wed, 26 Jun 2024 09:42:45 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCHv2 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
Message-ID: <ZntyFd3M9OXm_nqr@Laptop-X1>
References: <20240625070057.2004129-1-liuhangbin@gmail.com>
 <13131adc-1e61-46ae-a48e-ab2b51037a98@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13131adc-1e61-46ae-a48e-ab2b51037a98@blackwall.org>

On Tue, Jun 25, 2024 at 10:11:53AM +0300, Nikolay Aleksandrov wrote:
> On 25/06/2024 10:00, Hangbin Liu wrote:
> > Currently, administrators need to retrieve LACP mux state changes from
> > the kernel DEBUG log using netdev_dbg and slave_dbg macros. To simplify
> > this process, let's send the ifinfo notification whenever the mux state
> > changes. This will enable users to directly access and monitor this
> > information using the ip monitor command.
> > 
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> > v2: don't use call_netdevice_notifiers as it will case sleeping in atomic
> >     context (Nikolay Aleksandrov)
> > ---
> >  drivers/net/bonding/bond_3ad.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> > index c6807e473ab7..7a7224bf1894 100644
> > --- a/drivers/net/bonding/bond_3ad.c
> > +++ b/drivers/net/bonding/bond_3ad.c
> > @@ -1185,6 +1185,8 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
> >  		default:
> >  			break;
> >  		}
> > +
> > +		rtmsg_ifinfo(RTM_NEWLINK, port->slave->dev, 0, GFP_KERNEL, 0, NULL);
> >  	}
> >  }
> >  
> 
> GFP_KERNEL still allows to sleep, this is where I meant use GFP_ATOMIC if
> under the locks in my previous comment.

Oh, damn! I absolutely agree with you. I did read your last comment and I plan
to use GFP_ATOMIC. I modified my first version of the patch (that use
rtmsg_ifinfo directly, which use GFP_KERNEL) but forgot to commit the changes...

Sorry for the low level mistake...

> Also how does an administrator undestand that the mux state changed by
> using the above msg? Could you show the iproute2 part and how it looks for
> anyone monitoring?

Do you mean to add the log in the patch description or you want to see it?
It looks like the following:

7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP group default
    link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
    veth
    bond_slave state BACKUP mii_status UP ... ad_aggregator_id 1 ad_actor_oper_port_state 143 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,expired> ad_partner_oper_port_state 55 ad_partner_oper_port_state_str <active,short_timeout,aggregating,collecting,distributing> ...
7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP group default
    link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
    veth
    bond_slave state ACTIVE mii_status UP ... ad_aggregator_id 1 ad_actor_oper_port_state 79 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,defaulted> ad_partner_oper_port_state 1 ad_partner_oper_port_state_str <active> ...
7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP group default
    link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
    veth
    bond_slave state ACTIVE mii_status UP ... ad_aggregator_id 1 ad_actor_oper_port_state 63 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ad_partner_oper_port_state 63 ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ...

You can see the actor and partner port state changes.

Thanks
Hangbin

