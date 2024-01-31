Return-Path: <netdev+bounces-67559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E7D8440A9
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 14:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7151C2520E
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 13:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799877BB17;
	Wed, 31 Jan 2024 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIqAZQFZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7497D3F5
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708053; cv=none; b=qsDiY5InUjQj+t5kYuncXXpe4xxAP+oMBVulCQtGZFSyTvq6lZGsGTKxug79IasQNCJHm0/gKvsQLrGKAFWXJqQNsEgDWK46xKkMduL0VdkAbm4phDHG3+/KDzc+52a9xnZ69u4xLdSdwMk0yA15UiBQCV9KRN0x/BWUkX02QCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708053; c=relaxed/simple;
	bh=BqE8kepmCSBAbJZsSPek5z7wMZ4AHTFVQZB6ZfEaNmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBaUXAVvXJi6CsJgbNILg4Uk3fExCIZib+rWbWmP80CzNfBBkIcn7yTFjkGWuiO8dAWet/WUUjAyi22WVdYJWZ0tHB59kCThiM6UtYh6vp9ibA2RvlyqP+4Jg7g03Yzn3X61OSkeEMqE8rcRLvYTwr4McGF3SZDThx6nEzoQISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIqAZQFZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fafced20aso12175275e9.0
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 05:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706708049; x=1707312849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vp400XzZiWIixz3QGayYH59DObE0PQbKczBXQSNwlEM=;
        b=CIqAZQFZO5C+5XjHfacbc9CRRxUFbPDejVRsZ5ogXZuHtRYBPMSUCNeTrdJY5kwOq5
         U4uoO2Bsn2d/SK5eX4yNVJfaDgtmxf2jlfsWT+NgMsiee1wFi6wAG/PdLBg0jth1nV++
         y0H6ut6GhRqCypcu81FHz8yXPHWY45UDFb03HFa2EKdkyBuG7B509HVxSqSk/IKEGHJM
         uCb+KS34i5QsyXKZIsVgg1UPnKnXxub64TcOLGBcIDBK5X2FAtoNu6Lx9Pe29MRHdw8v
         lG96a9dloqR2jjtZRs+x8jjL+OMwXaW5sl9S6lvsbB7PkWwHdCruN7+/pgSvY1j97W7v
         Ua8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706708049; x=1707312849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp400XzZiWIixz3QGayYH59DObE0PQbKczBXQSNwlEM=;
        b=F2b/9i8yLnrQMm2votJu403eibefTle/PVSEdBTVIhqnHUGg99tPflxh09TDtTW9Q3
         AN3rHbgXBq+aTarI2v3d3avmhinhbna7ZZutt/NBSVCUv9qYmlXE18rIi8K/T8mUYSVl
         iK1bJ5xt4r/4jXSduVABmzW9jfvoeSv40iBCeBV6R6YM8xcbiPKVukqOtLPfF26wCLX0
         a7KXiQK61NM8eZLzZtgPydyPO8CUn7kUSSCmI/Oe+lgv378cusR7b72ZTxkgn0UT1fZ1
         vEX8dDU59x47YuN1TUPep1ZYuEiZR0eM7wXe7V/RYPhxz3i1l7xlYcolhMUsXdZCEuvE
         5CNg==
X-Gm-Message-State: AOJu0YzTndEY3t5XK3iyXVfTbISYkqe0P824LMjYMfmeYE3v2SZMGMvb
	ZXlus1ouTzZTNTvuqxB4Ch1QG1EAe3aiwxNF3VZFavIX44YZgxaH
X-Google-Smtp-Source: AGHT+IFty9dZG8cdWeueaizA9X3AmtgpCPE3cJCpiH9R7tdkbcIuU6WlHB2qTsD83OIJ3b9pdrW7Og==
X-Received: by 2002:a05:600c:1f19:b0:40e:fbd2:af50 with SMTP id bd25-20020a05600c1f1900b0040efbd2af50mr1292848wmb.26.1706708048754;
        Wed, 31 Jan 2024 05:34:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVJm7Szp5kidqjcwvR847s+ic3hyKk6wNf/sPpFBC6MY/gk/kZMhZvzkNAgnwgt+jSwIPPIPw3dj+c/9zPSycqEckIBkw4dkFz7LvC0TpCNJMojTipS0kH2vXwRA2ZQcwE0PhO6DiWwlb5Cjomga6YZ5IGcoUpl+aoxBTfJtBs52yXVUcZYcizMKMCBfl+xQvsbKB0Jlq0nZ6ov5/J+P7Pq0X6qeyq7o3o5lQ3QH5hfSsIqqalOKiU97dTsUw==
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c459100b0040e527602c8sm1637294wmo.9.2024.01.31.05.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:34:08 -0800 (PST)
Date: Wed, 31 Jan 2024 15:34:06 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com,
	razor@blackwall.org, bridge@lists.linux.dev, netdev@vger.kernel.org,
	jiri@resnulli.us, ivecera@redhat.com
Subject: Re: [PATCH net 1/2] net: switchdev: Add helper to check if an object
 event is pending
Message-ID: <20240131133406.v6zk33j43wy2j7fa@skbuf>
References: <20240131123544.462597-1-tobias@waldekranz.com>
 <20240131123544.462597-2-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131123544.462597-2-tobias@waldekranz.com>

On Wed, Jan 31, 2024 at 01:35:43PM +0100, Tobias Waldekranz wrote:
> When adding/removing a port to/from a bridge, the port must be brought
> up to speed with the current state of the bridge. This is done by
> replaying all relevant events, directly to the port in question.
> 
> In some situations, specifically when replaying the MDB, this process
> may race against new events that are generated concurrently.
> 
> So the bridge must ensure that the event is not already pending on the
> deferred queue. switchdev_port_obj_is_deferred answers this question.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

I don't see great value in splitting this patch in (1) unused helpers
(2) actual fix that uses them. Especially since it creates confusion -
it is nowhere made clear in this commit message that it is just
preparatory work.

> ---
>  include/net/switchdev.h   |  3 ++
>  net/switchdev/switchdev.c | 61 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
> index a43062d4c734..538851a93d9e 100644
> --- a/include/net/switchdev.h
> +++ b/include/net/switchdev.h
> @@ -308,6 +308,9 @@ void switchdev_deferred_process(void);
>  int switchdev_port_attr_set(struct net_device *dev,
>  			    const struct switchdev_attr *attr,
>  			    struct netlink_ext_ack *extack);
> +bool switchdev_port_obj_is_deferred(struct net_device *dev,
> +				    enum switchdev_notifier_type nt,
> +				    const struct switchdev_obj *obj);

I think this is missing a shim definition for when CONFIG_NET_SWITCHDEV
is disabled.

>  int switchdev_port_obj_add(struct net_device *dev,
>  			   const struct switchdev_obj *obj,
>  			   struct netlink_ext_ack *extack);
> diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
> index 5b045284849e..40bb17c7fdbf 100644
> --- a/net/switchdev/switchdev.c
> +++ b/net/switchdev/switchdev.c
> @@ -19,6 +19,35 @@
>  #include <linux/rtnetlink.h>
>  #include <net/switchdev.h>
>  
> +static bool switchdev_obj_eq(const struct switchdev_obj *a,
> +			     const struct switchdev_obj *b)
> +{
> +	const struct switchdev_obj_port_vlan *va, *vb;
> +	const struct switchdev_obj_port_mdb *ma, *mb;
> +
> +	if (a->id != b->id || a->orig_dev != b->orig_dev)
> +		return false;
> +
> +	switch (a->id) {
> +	case SWITCHDEV_OBJ_ID_PORT_VLAN:
> +		va = SWITCHDEV_OBJ_PORT_VLAN(a);
> +		vb = SWITCHDEV_OBJ_PORT_VLAN(b);
> +		return va->flags == vb->flags &&
> +			va->vid == vb->vid &&
> +			va->changed == vb->changed;
> +	case SWITCHDEV_OBJ_ID_PORT_MDB:
> +	case SWITCHDEV_OBJ_ID_HOST_MDB:
> +		ma = SWITCHDEV_OBJ_PORT_MDB(a);
> +		mb = SWITCHDEV_OBJ_PORT_MDB(b);
> +		return ma->vid == mb->vid &&
> +			!memcmp(ma->addr, mb->addr, sizeof(ma->addr));

ether_addr_equal().

> +	default:
> +		break;

Does C allow you to not return anything here?

> +	}
> +
> +	BUG();
> +}
> +
>  static LIST_HEAD(deferred);
>  static DEFINE_SPINLOCK(deferred_lock);
>  
> @@ -307,6 +336,38 @@ int switchdev_port_obj_del(struct net_device *dev,
>  }
>  EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
>  
> +bool switchdev_port_obj_is_deferred(struct net_device *dev,
> +				    enum switchdev_notifier_type nt,
> +				    const struct switchdev_obj *obj)

A kernel-doc comment would be great. It looks like it's not returning
whether the port object is deferred, but whether the _action_ given by
@nt on the @obj is deferred. This further distinguishes between deferred
additions and deferred removals.

> +{
> +	struct switchdev_deferred_item *dfitem;
> +	bool found = false;
> +
> +	ASSERT_RTNL();

Why does rtnl_lock() have to be held? To fully allow switchdev_deferred_process()
to run to completion, aka its dfitem->func() as well?

> +
> +	spin_lock_bh(&deferred_lock);
> +
> +	list_for_each_entry(dfitem, &deferred, list) {
> +		if (dfitem->dev != dev)
> +			continue;
> +
> +		if ((dfitem->func == switchdev_port_obj_add_deferred &&
> +		     nt == SWITCHDEV_PORT_OBJ_ADD) ||
> +		    (dfitem->func == switchdev_port_obj_del_deferred &&
> +		     nt == SWITCHDEV_PORT_OBJ_DEL)) {
> +			if (switchdev_obj_eq((const void *)dfitem->data, obj)) {
> +				found = true;
> +				break;
> +			}
> +		}
> +	}
> +
> +	spin_unlock_bh(&deferred_lock);
> +
> +	return found;
> +}
> +EXPORT_SYMBOL_GPL(switchdev_port_obj_is_deferred);
> +
>  static ATOMIC_NOTIFIER_HEAD(switchdev_notif_chain);
>  static BLOCKING_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
>  
> -- 
> 2.34.1
> 

