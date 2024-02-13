Return-Path: <netdev+bounces-71295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A289852F49
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC331C22AFE
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C330838DD9;
	Tue, 13 Feb 2024 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="sZrPcc+k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD9C38DD0
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823649; cv=none; b=CNTTlxFdgV97HOaoKqM313edujLmOjvBv1hqkAqvly5Tvtl12H30tFJz3sWihAHj6Ggeg4RZSZDVLdtk6xgRywAj2FcrkxmkBLnIGZMT23Bf9C9UGZ/rJP4kZb+g1+/ooqTH9ymhrAaU0uvjFkcNuAWR9aDawZlUFWmmqQE4q3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823649; c=relaxed/simple;
	bh=8Uq9pIetVraNyzB/yc0rr+vrlWMwD/izNuiuTaT+bwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXiVf/t6saaiSsyD0wsp4XEYY1U2FMQILc5vcrMJvdeUJFoc5lO8PDsIkuYoO2Jh3ick2jyFC+JzgvT4lrsQ7Zm3eWSvMtbKvaD6JD3qyC8IMMOUgIPcQ7XtfeRXZiIqqdUWq/1ET2BmIi62a27rffmU7bq1nNs0oCtQsiz97jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=sZrPcc+k; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fd2f7ef55so29655585e9.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 03:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707823644; x=1708428444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s0oFTV7M7pCTGeqj600LQdU9PccVXar4+hpgoAPCV2o=;
        b=sZrPcc+kqwIrfgaNYI+X7OriHc5BSfAp0H2kF8OVtDFruzVuJ1A0JfNohvHEXwjQC2
         Henn4Pgyk2WJmcymL8kVfW5FwhMhDAYLfHBwK5k71Fjpf7QhwQSrAtjK6olnE9xrJDt9
         PTdXevENf+heAnYNB8GR6Uhz9hSZoHCWrLi+LoP7AvQ+kbqav9k/c/+r1n8dEvXmSARl
         vhNMgGDwfriGAoGTw4TILm1T7D7NB3PMYc5VsN/1ks7KQKZyv/+qVEoW/ygGoxIp02rW
         avqRZzwJJbEJQebweZLwfYhnHf3gbyz/O7BDBgkQOgDhHA4o4fcH+e9Q6KIgVi/HzUkH
         ImNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707823644; x=1708428444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0oFTV7M7pCTGeqj600LQdU9PccVXar4+hpgoAPCV2o=;
        b=QHYvJcXR8kBnHB6YUjChU2vRO05fdY18vR7bad5qfVFkebobZ+biO6c3l5FbIJb8yE
         xQmluMUv/XB8sCzh+QZXClynlEJ97GiauuQVBdNv9KqZ8s80s8g7Rleu7KT/oSBcCB8F
         6G0ykb0nWSbkwuj5/xV8DTLO3nQtCWMx2+oKkC+WH93LGDTYgnMLyBl0gRj+rp5Cobdk
         WybxM70A4cQrOWzuVO23b3F+zh7WgsZacnDRddvijpS1p0WX2RvLtL09CfPxZ4V3wYcP
         MrXA2pbQSATHnnrYuu/hNqTO+OL5LrnkYh0tCCzGeXZO5XS7nNHcVP9BdCvt1VnBsZZ6
         bzaw==
X-Forwarded-Encrypted: i=1; AJvYcCWVkD7nyEbHBqFhCkm40GE3DtzM8Jz+1sBmWjSqbstMo2pqTTkUeylgP8IfNKyaa+t/9s4ykjCrPJGX/YdGSZG38id8ZUWG
X-Gm-Message-State: AOJu0YxFvbBDmDLugXpjYRNjirPTHCt+1NF7CE+OunxJngK4DIoU+B+z
	OeGPwwxqkREzxUrH6YqTFzDFsQLVWQI39aCl1odqjVlBHrl5vahlXw9asys7DyU=
X-Google-Smtp-Source: AGHT+IGLMTKSyUTDt/yFpKqUIDeJUe1926b29O5oL5iorvrPw1kAFJ4zr5130/7FelDHRuSgEOZjQg==
X-Received: by 2002:a05:600c:3554:b0:40f:c2f0:7ed3 with SMTP id i20-20020a05600c355400b0040fc2f07ed3mr1993044wmq.18.1707823644495;
        Tue, 13 Feb 2024 03:27:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXShbnh8qEn/BJU9R9Ar0jEimSrsjJfcQkCNwBAdlTQJl+0JOps2h4xKacHyjpe0r1PM4c8/OiXNPaAOCv4K1aCL6f1PZ6GBegSS2z01fbifApH6ZAA39mCublAYEoo6X9V5vzNScktjyqO6BB7QEHw2zUNlr3ZPUtO9Q9Iel4XvfDUAqvsreTCbF6nckd6CV4r16JENKWfN/H4PR40RSbtbPBriPtnJr0d6oHjavY8NQgBVasZEjgJErBKksRbnZT1qgIDVCW3hvvcPI4jZ71wyT7Tj0y8pVFlBRd+YbpYNX+iHbbBvZ3qxVebi6pxi5Nh8WiNN24H7F48wW/laCqJgAmast2L/RnWpOJCkWOQkWJKCejSnn1zuL45fPIPfKlsqon5gaBjHmlonzzPT93NVJu7jEzmVQ==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id iv15-20020a05600c548f00b004107686650esm11592367wmb.36.2024.02.13.03.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 03:27:23 -0800 (PST)
Date: Tue, 13 Feb 2024 12:27:20 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: maciej.fijalkowski@intel.com, netdev@vger.kernel.org,
	michal.kubiak@intel.com, intel-wired-lan@lists.osuosl.org,
	pio.raczynski@gmail.com, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, wojciech.drewek@intel.com,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	przemyslaw.kitszel@intel.com
Subject: Re: [Intel-wired-lan] [iwl-next v1 04/15] ice: add basic devlink
 subfunctions support
Message-ID: <ZctSGPf6v0QlfMUu@nanopsycho>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
 <20240213072724.77275-5-michal.swiatkowski@linux.intel.com>
 <ZcsueJ1tr-GdseIt@nanopsycho>
 <Zcs442A/+nuLJw6j@mev-dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcs442A/+nuLJw6j@mev-dev>

Tue, Feb 13, 2024 at 10:39:47AM CET, michal.swiatkowski@linux.intel.com wrote:
>On Tue, Feb 13, 2024 at 09:55:20AM +0100, Jiri Pirko wrote:
>> Tue, Feb 13, 2024 at 08:27:13AM CET, michal.swiatkowski@linux.intel.com wrote:
>> >From: Piotr Raczynski <piotr.raczynski@intel.com>

[...]


>
>> 
>> >+}
>> >+
>> >+/**
>> >+ * ice_dealloc_dynamic_port - Deallocate and remove a dynamic port
>> >+ * @dyn_port: dynamic port instance to deallocate
>> >+ *
>> >+ * Free resources associated with a dynamically added devlink port. Will
>> >+ * deactivate the port if its currently active.
>> >+ */
>> >+static void ice_dealloc_dynamic_port(struct ice_dynamic_port *dyn_port)
>> >+{
>> >+	struct devlink_port *devlink_port = &dyn_port->devlink_port;
>> >+	struct ice_pf *pf = dyn_port->pf;
>> >+
>> >+	if (dyn_port->active)
>> >+		ice_deactivate_dynamic_port(dyn_port);
>> >+
>> >+	if (devlink_port->attrs.flavour == DEVLINK_PORT_FLAVOUR_PCI_SF)
>> 
>> I don't understand how this check could be false. Remove it.
>>
>Yeah, will remove
>
>> 
>> >+		xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
>> >+
>> >+	devl_port_unregister(devlink_port);
>> >+	ice_vsi_free(dyn_port->vsi);
>> >+	xa_erase(&pf->dyn_ports, dyn_port->vsi->idx);
>> >+	kfree(dyn_port);
>> >+}
>> >+
>> >+/**
>> >+ * ice_dealloc_all_dynamic_ports - Deallocate all dynamic devlink ports
>> >+ * @pf: pointer to the pf structure
>> >+ */
>> >+void ice_dealloc_all_dynamic_ports(struct ice_pf *pf)
>> >+{
>> >+	struct devlink *devlink = priv_to_devlink(pf);
>> >+	struct ice_dynamic_port *dyn_port;
>> >+	unsigned long index;
>> >+
>> >+	devl_lock(devlink);
>> >+	xa_for_each(&pf->dyn_ports, index, dyn_port)
>> >+		ice_dealloc_dynamic_port(dyn_port);
>> >+	devl_unlock(devlink);
>> 
>> Hmm, I would assume that the called should already hold the devlink
>> instance lock when doing remove. What is stopping user from issuing
>> port_new command here, after devl_unlock()?
>>
>It is only called from remove path, but I can move it upper.

I know it is called on remove path. Again, what is stopping user from
issuing port_new after ice_dealloc_all_dynamic_ports() is called?

[...]


>> 
>> >+	struct device *dev = ice_pf_to_dev(pf);
>> >+	int err;
>> >+
>> >+	dev_dbg(dev, "%s flavour:%d index:%d pfnum:%d\n", __func__,
>> >+		new_attr->flavour, new_attr->port_index, new_attr->pfnum);
>> 
>> How this message could ever help anyone?
>>
>Probably only developer of the code :p, will remove it

How exactly?

[...]


>> >+static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port)
>> >+{
>> >+	struct net_device *netdev;
>> >+	struct ice_vsi *vsi = dyn_port->vsi;
>> >+	struct ice_netdev_priv *np;
>> >+	int err;
>> >+
>> >+	netdev = alloc_etherdev_mqs(sizeof(*np), vsi->alloc_txq,
>> >+				    vsi->alloc_rxq);
>> >+	if (!netdev)
>> >+		return -ENOMEM;
>> >+
>> >+	SET_NETDEV_DEV(netdev, &vsi->back->pdev->dev);
>> >+	set_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
>> >+	vsi->netdev = netdev;
>> >+	np = netdev_priv(netdev);
>> >+	np->vsi = vsi;
>> >+
>> >+	ice_set_netdev_features(netdev);
>> >+
>> >+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
>> >+			       NETDEV_XDP_ACT_XSK_ZEROCOPY |
>> >+			       NETDEV_XDP_ACT_RX_SG;
>> >+
>> >+	eth_hw_addr_set(netdev, dyn_port->hw_addr);
>> >+	ether_addr_copy(netdev->perm_addr, dyn_port->hw_addr);
>> >+	netdev->netdev_ops = &ice_sf_netdev_ops;
>> >+	SET_NETDEV_DEVLINK_PORT(netdev, &dyn_port->devlink_port);
>> >+
>> >+	err = register_netdev(netdev);
>> 
>> It the the actual subfunction or eswitch port representor of the
>> subfunction. Looks like the port representor. In that case. It should be
>> created no matter if the subfunction is activated, when it it created.
>> 
>> If this is the actual subfunction netdev, you should not link it to
>> devlink port here.
>>
>This is the actual subfunction netdev. Where in this case it should be
>linked?

To the SF auxdev, obviously.

Here, you should have eswitch port representor netdev.


