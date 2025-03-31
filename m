Return-Path: <netdev+bounces-178349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC51A76ADE
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532F316FD5A
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4155B223710;
	Mon, 31 Mar 2025 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9cbHIRi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFBE2222AD;
	Mon, 31 Mar 2025 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743434997; cv=none; b=EUvdQp0aIYs76Zo7Jrwo6/C/hvo3P1TUx/UP1e1PZIe3e2g7IB5MB+HbLW8WT3j+bqH2+SB1KgbVBmuZHWZLV43RokHFaDUA/hXYYSXSJmb7Zp1Bv+4r0sZDCHt6McRb6u9wLjrI1u9AhBeed8raiX4IFLbXrd2JHcK0K3DCQHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743434997; c=relaxed/simple;
	bh=8LCQGSQB5lHQhmbjBoeptDbrNfiTYc5A4I/V72biIiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKg7r7UJvX/yGtLV8KkThCAYpJ3L1PObX3oQvvLW4Ezb7qRUpy22Q+WzuZJwvJ7WrElMCWeN1cNavDBqUpeuIrVQFj5sRUFkq2aooVAIpoHDHTkntJ0OUKvLsvybdQhTLiD1vM8ovP6iFbKIT5rzXYr4tSofeMVJtY7nM30yoAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9cbHIRi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223fd89d036so97177685ad.1;
        Mon, 31 Mar 2025 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743434995; x=1744039795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M+uHAXI38bgCrnjnadj7DLOLvCOlxtJFouFW+paml7Y=;
        b=G9cbHIRig/XdP4H309ajiPOS5FR8ZN3/EvgaLxlssgXoTdqlr1yvGZJGAdAgSA7kfd
         WB9ZnlLJdniqJnnCwlf7mrV385DofzU1tYR7oBCqSKu8MC+ve2CDUDUiQFfTwuJxEkt7
         SYeDK+7uqQsLqfp7Ix08mnumP502OYGK8CuGUAXrRkq4gdFccRBbXbMmKCbcAN6fhKjK
         J+6BVLaCcZXPS2I5O/pyw6rzRFIeajf2TJc31okZe5CcS7osX1NtkGpw3Byym8/M436H
         9QI0n211CFdb7tWQmMYEQrqVTUmStHLNgfkf2NfRS9omkBYiJLKceCbEvSL2opZL22tw
         gYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743434995; x=1744039795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+uHAXI38bgCrnjnadj7DLOLvCOlxtJFouFW+paml7Y=;
        b=MpmyUZHKmx/JNWa2d3UNVi7YpC4UzldXdBdOLL7gNuzenIZ7Id7xtXzP1S2U+R8aGp
         2xxTz4BIg8biOPh8L+0z8CyKui405oAAdqjSJJ7ucaypq0nmAiMQS0Olg9O9G6qTT6Yd
         wYGz+4TcTjBG4bsf/wQf3vsLDQJ428Yi5oJAc1pVuesRnsZpSyvFydE+r4A3foVP9yTa
         bc3KQuJ5YCpNkjXcZWCt6dDLUn7fNocXUZRXV+z4Z9wuFwlksZpPj2hH1JNsqkEuQj/a
         6ka33CORfeph4q4ygVdX3VPCeyshOWzMpFpRUUpZFwg301VWcsaSqX9ESHzJcRboTg1f
         giQg==
X-Forwarded-Encrypted: i=1; AJvYcCW3a8si9n1u3fN0iugcfzF+0gu7CW9QqMZyG0+6zIniv9Kplv5ieLcv0z8BRt1OfWqdMvoEmipC@vger.kernel.org, AJvYcCXEJwSLkESv0NXrRosspJJfvVJpUJzjycGWdudcYk1H0G7AJs7i2fip6PDdbl3/TtHa8Lik2jTwm4ISukY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypV0BCPto2COI1yZn5EBoiErBusDXn0WKr1VpovymNKksg/QTl
	qEyZ+M11rYe3iVQe0azm1q3XtgYTNxcQ3wCepmJizoACvLqx0wt7MUm9
X-Gm-Gg: ASbGnctQ4v/yMqVMmrEnZsgskUTypK6sOOLuEa8WyWDxa5sHogebvXzWcANPeQg96nJ
	ZHUSeCuNmljhbpZHMFicquD+ip6ALM7BNWr+N9w01jyUAObbnKcUgZSBoHS8hoBx9GxeZasC8qC
	nkR3/jwZiFCs8ujYOzzDOY2R3LpqSe28uISs8oxpUoab+kqchalWKqTSufGhZxGnJ/x6mDV6Rb9
	nPQRsLH/XAr91/5eNcl6WjvvbKG/qF2HT1d00b6FQQO4d7136yLdtXAMsEfWivClWE3y9BR2wEx
	tTVXT8n5ceDsKm5eGiybKgodNRKJ+VGyGKokxk4Vt9Mv
X-Google-Smtp-Source: AGHT+IE4vHNyqV97vpt+2TImMzF0K9+WJYTVEUk+esNzhbIfhdczPRt+3E3+pjondKYC3J0W2O6Y7w==
X-Received: by 2002:a17:902:e746:b0:215:9bc2:42ec with SMTP id d9443c01a7336-2292f9fcbccmr145302555ad.47.1743434994901;
        Mon, 31 Mar 2025 08:29:54 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291f1cf86csm70164215ad.139.2025.03.31.08.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:29:54 -0700 (PDT)
Date: Mon, 31 Mar 2025 08:29:53 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, kuniyu@amazon.com,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch, Taehee Yoo <ap420073@gmail.com>
Subject: Re: [PATCH net] bnxt_en: bring back rtnl lock in bnxt_shutdown
Message-ID: <Z-q08YfJMq8Q76ki@mini-arch>
References: <20250328174216.3513079-1-sdf@fomichev.me>
 <Z+qAYXmGY08pQKKb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z+qAYXmGY08pQKKb@gmail.com>

On 03/31, Breno Leitao wrote:
> Hello Stanislav,
> 
> On Fri, Mar 28, 2025 at 10:42:16AM -0700, Stanislav Fomichev wrote:
> > Taehee reports missing rtnl from bnxt_shutdown path:
> > 
> > inetdev_event (./include/linux/inetdevice.h:256 net/ipv4/devinet.c:1585)
> > notifier_call_chain (kernel/notifier.c:85)
> > __dev_close_many (net/core/dev.c:1732 (discriminator 3))
> > kernel/locking/mutex.c:713 kernel/locking/mutex.c:732)
> > dev_close_many (net/core/dev.c:1786)
> > netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
> > bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
> > pci_device_shutdown (drivers/pci/pci-driver.c:511)
> > device_shutdown (drivers/base/core.c:4820)
> > kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
> 
> I've got this issue as well.
> 
> > 
> > Bring back the rtnl lock.
> > 
> > Link: https://lore.kernel.org/netdev/CAMArcTV4P8PFsc6O2tSgzRno050DzafgqkLA2b7t=Fv_SY=brw@mail.gmail.com/
> > Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
> > Reported-by: Taehee Yoo <ap420073@gmail.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Tested-by: Breno Leitao <leitao@debian.org>
> 
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > index 934ba9425857..1a70605fad38 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -16698,6 +16698,7 @@ static void bnxt_shutdown(struct pci_dev *pdev)
> >  	if (!dev)
> >  		return;
> >  
> > +	rtnl_lock();
> >  	netdev_lock(dev);
> 
> can't we leverage the `struct net_device->lock` for the shutdown.
> Basically we have the lock the single device we are turning it down.
> 
> I am wondering if we really need the big RTNL lock. This is my
> understanding of what is happening:
> 
> pci_device_shutdown() is called for a single device
>  - netdev_lock(dev)
>  - netif_close(dev);
>     - dev_close_many(&single, true);
>       - __dev_close_many()
>         - ASSERT_RTNL();
> 
> Basically we ware only closing one device, and the net_device->lock
> is already held. Shouldn't it be enough?

[..]

> Can we do something like this (from my naive point of view):
> 
> 	 static void __dev_close_many(struct list_head *head)
> 	  {
> 		  struct net_device *dev;
> 
> 	-         ASSERT_RTNL();
> 		  might_sleep();
> 
> 		  list_for_each_entry(dev, head, close_list) {
> 	+	  	ASSERT_RTNL_NET(dev);
> 			...
> 		  }

- netif_close adds dev->close_list to the list (if it was up)
- __dev_close_many walks over that list, so your new assert should
  trigger as well

But also in general, it would be nice to keep existing
rtnl+instance_lock scheme for now (except were we want to explicitly opt
out, as in queue apis); we can follow up later to un-rtnl the rest.

