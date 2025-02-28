Return-Path: <netdev+bounces-170884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE7CA4A6BA
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 00:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60A1177A65
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 23:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D141DF724;
	Fri, 28 Feb 2025 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvcG70Cx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7F11DEFFE
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740786834; cv=none; b=SLExHw7eDN9E1+y5kScF1QCorHHWHcHBSbQ2V0tPheLz0URF4CWyINV4cNmvM1ASWBWPmNVHhBR6iXdjiczbBDhG6HFEQORmKzr6L25shBy89W8LZ575i80gXEk0pz02DPdl/PtcrNsXsuQhRW5d2hksoilTuy1K8Vkujc1LmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740786834; c=relaxed/simple;
	bh=yaeRMedNlNml6PJw6znLp2IbNdijb8ubNbaC8XrmD28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sxz0atfJhxl8Jsr36D5mOKkOAF87R2LWIY8Y79hZpIFHwvgrIJPrlFLP5HK6jw3OkJznq2JYPeqKlXTsV8BFu9U4w1w/g3q3h+TW+jAYIHV6Y89NO/jZKSxUPZoSbubN+NLkjM3HEMe3VJBrykdjB49ErXAgItONW4Gp9DdCKnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvcG70Cx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22337bc9ac3so53278475ad.1
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 15:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740786832; x=1741391632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lOwxobuX3CulgITr1BS791PiQ2UI7n26nNz9kYAAsK0=;
        b=GvcG70CxtB1m0GmxlAHlb/+Q5OKrjV7pmGWNP0EohUby1ghal5Jg/O18iRV+6mhlYm
         eeb/Flln6f/T6Rqq0FDcSMrCN2aIyR4uzPSRVmg5N01IHzfDXSY4XTOzjDdkakThJhOE
         2rCcCJWIw3www8eDNDiZpgxE1Jsr0RYKwsKI8xyVUSQ2qKf2Wf8Ut8OhdUVMZdGhrrx5
         e4s3bRdQeg9fCBSX0KOlmP8SaSYNa5wynuZTvd2cX5PFEuljiE8HEtO9jlwsycjeHNY6
         m9upYFXHwa09v+pXBNxUSTUCloumQAaLuQuBWY4bw7MuqY3OcnfYb5zv5NGvw+B53YTT
         1PTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740786832; x=1741391632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOwxobuX3CulgITr1BS791PiQ2UI7n26nNz9kYAAsK0=;
        b=lbx2mZrsJ8F6Fm2Z81N17B495PR+2d80XFkMIRChx1bpMC7uLdUvXVW/NMW1tNDbjQ
         iM6WvuYO18eri3+s44VGLC+2U4xlYQebcQ3L8+7wQu8EDPY7rmle8Dwhit6qXEqullzU
         IwtWeguC6fgyfwZI2wXL41yALj57XWkBwUD0Uawpa0VOV5GuUz0k2j3sdf1Nra9XDSgV
         TyEDoQPNO6uFS7129v78YemSWhpadOMuQUZKT3ULpqxyxIbQGbDgwnjJ3WyGgBzw/DK5
         bSK3HB5kjyqg7tZbO9jICkhkP3RI7BOCnj50NS6J7CO2aU+1FpZy6tBzYAgEODh/5dxW
         NzNA==
X-Forwarded-Encrypted: i=1; AJvYcCWDWtaQCcHphgnU/QtcnGoZNiHSHCe8W9TTcLjHZqnOCAe1Eyb3kFMK3fy0lYmXK8iMTeMLRms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW8HTTzbh/vH1ZEfdJM7YrWpo7KDSOQqV7Q8PMnB2zwBN6ykDb
	lam2tn3p8yZ7CvpQUX2B86/t3KiesoX3or+KQWkr9gT7FlrOCzo=
X-Gm-Gg: ASbGncthFqqnZDfCiwl/We7j1JL90o62OmHAERZt+xglIjU2J8HTb/+i8tQ0z7GOPyy
	bRExzOcb9QLI8ihiJpiA1rvXzD/EfGs0PV/cKzpYgDoY6HknVBYXC7Ue0VN12zQfznaJzupytre
	jP7FaSaXVMJjnb3rZW0iRT+9NnYJNxwsybVGZrAXigwZWQnRXB9lhAK9iuj5Rff9pYD/wPM6jvD
	bUroVoG50mp74sUKs4uSIGE0jI6RspkjYGBa2YDejLO/jcb5lkuUknd6oX4did/wrZLUbmH+Zum
	ifDghwcK+g23OkoB88T5xxUm3/XEiwVVSykG8gV4FmEE
X-Google-Smtp-Source: AGHT+IGjqkvPtQ/o1xCg2lNkkctePYeskfl4zgA7UmHJjAM0f1UbWKk1DmOQF7/fh86bbGXwGuxoGQ==
X-Received: by 2002:a17:902:cec1:b0:21f:592b:b4b6 with SMTP id d9443c01a7336-22369244244mr78386805ad.47.1740786831829;
        Fri, 28 Feb 2025 15:53:51 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22350547cddsm38642715ad.259.2025.02.28.15.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:53:51 -0800 (PST)
Date: Fri, 28 Feb 2025 15:53:50 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v9 01/12] net: hold netdev instance lock during
 ndo_open/ndo_stop
Message-ID: <Z8JMjmqvct6rbidn@mini-arch>
References: <20250228045353.1155942-1-sdf@fomichev.me>
 <20250228045353.1155942-2-sdf@fomichev.me>
 <Z8I1iw4Dq8f2ghLW@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8I1iw4Dq8f2ghLW@x130>

On 02/28, Saeed Mahameed wrote:
> On 27 Feb 20:53, Stanislav Fomichev wrote:
> > For the drivers that use shaper API, switch to the mode where
> > core stack holds the netdev lock. This affects two drivers:
> > 
> > * iavf - already grabs netdev lock in ndo_open/ndo_stop, so mostly
> >         remove these
> > * netdevsim - switch to _locked APIs to avoid deadlock
> > 
> > iavf_close diff is a bit confusing, the existing call looks like this:
> >  iavf_close() {
> >    netdev_lock()
> >    ..
> >    netdev_unlock()
> >    wait_event_timeout(down_waitqueue)
> >  }
> > 
> > I change it to the following:
> >  netdev_lock()
> >  iavf_close() {
> >    ..
> >    netdev_unlock()
> >    wait_event_timeout(down_waitqueue)
> >    netdev_lock() // reusing this lock call
> >  }
> >  netdev_unlock()
> > 
> > Since I'm reusing existing netdev_lock call, so it looks like I only
> > add netdev_unlock.
> > 
> > Cc: Saeed Mahameed <saeed@kernel.org>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> > drivers/net/ethernet/intel/iavf/iavf_main.c | 14 ++++++-------
> > drivers/net/netdevsim/netdev.c              | 14 ++++++++-----
> > include/linux/netdevice.h                   | 23 +++++++++++++++++++++
> > net/core/dev.c                              | 12 +++++++++++
> > net/core/dev.h                              |  6 ++++--
> > 5 files changed, 54 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> > index 71f11f64b13d..9f4d223dffcf 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> > @@ -4562,22 +4562,21 @@ static int iavf_open(struct net_device *netdev)
> > 	struct iavf_adapter *adapter = netdev_priv(netdev);
> > 	int err;
> > 
> > +	netdev_assert_locked(netdev);
> > +
> > 	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED) {
> > 		dev_err(&adapter->pdev->dev, "Unable to open device due to PF driver failure.\n");
> > 		return -EIO;
> > 	}
> > 
> > -	netdev_lock(netdev);
> > 	while (!mutex_trylock(&adapter->crit_lock)) {
> > 		/* If we are in __IAVF_INIT_CONFIG_ADAPTER state the crit_lock
> > 		 * is already taken and iavf_open is called from an upper
> > 		 * device's notifier reacting on NETDEV_REGISTER event.
> > 		 * We have to leave here to avoid dead lock.
> > 		 */
> > -		if (adapter->state == __IAVF_INIT_CONFIG_ADAPTER) {
> > -			netdev_unlock(netdev);
> > +		if (adapter->state == __IAVF_INIT_CONFIG_ADAPTER)
> > 			return -EBUSY;
> > -		}
> > 
> > 		usleep_range(500, 1000);
> > 	}
> > @@ -4626,7 +4625,6 @@ static int iavf_open(struct net_device *netdev)
> > 	iavf_irq_enable(adapter, true);
> > 
> > 	mutex_unlock(&adapter->crit_lock);
> > -	netdev_unlock(netdev);
> > 
> > 	return 0;
> > 
> > @@ -4639,7 +4637,6 @@ static int iavf_open(struct net_device *netdev)
> > 	iavf_free_all_tx_resources(adapter);
> > err_unlock:
> > 	mutex_unlock(&adapter->crit_lock);
> > -	netdev_unlock(netdev);
> > 
> > 	return err;
> > }
> > @@ -4661,12 +4658,12 @@ static int iavf_close(struct net_device *netdev)
> > 	u64 aq_to_restore;
> > 	int status;
> > 
> > -	netdev_lock(netdev);
> > +	netdev_assert_locked(netdev);
> > +
> > 	mutex_lock(&adapter->crit_lock);
> > 
> > 	if (adapter->state <= __IAVF_DOWN_PENDING) {
> > 		mutex_unlock(&adapter->crit_lock);
> > -		netdev_unlock(netdev);
> > 		return 0;
> > 	}
> > 
> > @@ -4719,6 +4716,7 @@ static int iavf_close(struct net_device *netdev)
> > 	if (!status)
> > 		netdev_warn(netdev, "Device resources not yet released\n");
> > 
> > +	netdev_lock(netdev);
> > 	mutex_lock(&adapter->crit_lock);
> > 	adapter->aq_required |= aq_to_restore;
> > 	mutex_unlock(&adapter->crit_lock);
> > diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> > index a41dc79e9c2e..aaa3b58e2e3e 100644
> > --- a/drivers/net/netdevsim/netdev.c
> > +++ b/drivers/net/netdevsim/netdev.c
> > @@ -402,7 +402,7 @@ static int nsim_init_napi(struct netdevsim *ns)
> > 	for (i = 0; i < dev->num_rx_queues; i++) {
> > 		rq = ns->rq[i];
> > 
> > -		netif_napi_add_config(dev, &rq->napi, nsim_poll, i);
> > +		netif_napi_add_config_locked(dev, &rq->napi, nsim_poll, i);
> > 	}
> > 
> > 	for (i = 0; i < dev->num_rx_queues; i++) {
> > @@ -422,7 +422,7 @@ static int nsim_init_napi(struct netdevsim *ns)
> > 	}
> > 
> > 	for (i = 0; i < dev->num_rx_queues; i++)
> > -		__netif_napi_del(&ns->rq[i]->napi);
> > +		__netif_napi_del_locked(&ns->rq[i]->napi);
> > 
> > 	return err;
> > }
> > @@ -452,7 +452,7 @@ static void nsim_enable_napi(struct netdevsim *ns)
> > 		struct nsim_rq *rq = ns->rq[i];
> > 
> > 		netif_queue_set_napi(dev, i, NETDEV_QUEUE_TYPE_RX, &rq->napi);
> > -		napi_enable(&rq->napi);
> > +		napi_enable_locked(&rq->napi);
> > 	}
> > }
> > 
> > @@ -461,6 +461,8 @@ static int nsim_open(struct net_device *dev)
> > 	struct netdevsim *ns = netdev_priv(dev);
> > 	int err;
> > 
> > +	netdev_assert_locked(dev);
> > +
> > 	err = nsim_init_napi(ns);
> > 	if (err)
> > 		return err;
> > @@ -478,8 +480,8 @@ static void nsim_del_napi(struct netdevsim *ns)
> > 	for (i = 0; i < dev->num_rx_queues; i++) {
> > 		struct nsim_rq *rq = ns->rq[i];
> > 
> > -		napi_disable(&rq->napi);
> > -		__netif_napi_del(&rq->napi);
> > +		napi_disable_locked(&rq->napi);
> > +		__netif_napi_del_locked(&rq->napi);
> > 	}
> > 	synchronize_net();
> > 
> > @@ -494,6 +496,8 @@ static int nsim_stop(struct net_device *dev)
> > 	struct netdevsim *ns = netdev_priv(dev);
> > 	struct netdevsim *peer;
> > 
> > +	netdev_assert_locked(dev);
> > +
> > 	netif_carrier_off(dev);
> > 	peer = rtnl_dereference(ns->peer);
> > 	if (peer)
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 26a0c4e4d963..24d54c7e60c2 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -2753,6 +2753,29 @@ static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
> > 		netdev_assert_locked(dev);
> > }
> > 
> > +static inline bool netdev_need_ops_lock(struct net_device *dev)
> > +{
> > +	bool ret = false;
> > +
> > +#if IS_ENABLED(CONFIG_NET_SHAPER)
> > +	ret |= !!dev->netdev_ops->net_shaper_ops;
> > +#endif
> > +
> > +	return ret;
> > +}
> > +
> > +static inline void netdev_lock_ops(struct net_device *dev)
> > +{
> > +	if (netdev_need_ops_lock(dev))
> > +		netdev_lock(dev);
> > +}
> > +
> > +static inline void netdev_unlock_ops(struct net_device *dev)
> > +{
> > +	if (netdev_need_ops_lock(dev))
> > +		netdev_unlock(dev);
> > +}
> > +
> > void netif_napi_set_irq_locked(struct napi_struct *napi, int irq);
> > 
> > static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index d6d68a2d2355..5b1b68cb4a25 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -1627,6 +1627,8 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
> > 	if (ret)
> > 		return ret;
> > 
> > +	netdev_lock_ops(dev);
> > +
> 
> Hi Stan,
> 
> Just started testing this before review and I hit a deadlock when applying
> the patch that implements qmgmt in mlx5.
> 
> deadlock:
> _dev_open() [netdev_lock_ops(dev)] ==> 1st time lock
>   dev_activate() ->     attach_default_qdiscs()->
>       qdisc_create_dflt()->
>         mq_init()-> mq_offload() ->
>           dev_setup_tc(dev) [netdev_lock_ops(dev)] ==> 2nd :- double lock
> 
> I am not sure how to solve this right now, since the qdisc API is reached
> by callbacks and it's not trivial to select which version of dev_setup_tc()
> to call, locked or non locked, the only direction i have right now is that
> attached_default_qdiscs is only called by dev_activate() if we can assume
> dev_activate() is always netdev_locked, then we can somehow signal that to
> mq_offload().

Oh, oh, thanks for the report! I'm a bit surprised I haven't seen it
on my side with bnxt.

I'm thinking about moving the locking part up into tc_modify_qdisc layer (and
keep DSA/NFT as is). Let me try to see if it's gonna work..

