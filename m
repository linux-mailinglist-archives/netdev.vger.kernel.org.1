Return-Path: <netdev+bounces-67863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A28845224
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A7828DA25
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F131586E2;
	Thu,  1 Feb 2024 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TFgc6iJB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907ED15703D
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706773234; cv=none; b=J+uJX38aPCxxbFD9LvlrAPhQatU83AShDEdlQ8uoPcx8AZipx6OqjEAFUAq3Cs5OOqa86wzw3nqgL1/7/zMPMzEAsfMojyj/WOdDajnuU2ihvKlHsTzvDn5XZpMjYJAVmrp4wLKBpKWYiO2rFJ9hlc7W/AlsQOL3gOJTI6R/d18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706773234; c=relaxed/simple;
	bh=Jz5zT0EJWFPNzRd0qEdL7OJFDc1gsg6xawO/pb8lUeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlXeIntQxvfjijvgMd6lmS2iyRVHc9s3lqyyTvbtYUZp1hpRh8r7sLXiATPNNlLRMpZNiW8yQnVNHC7wg02upGL2QEsE4mjFoOmIq2t2aHEV+fUYEK+b+ijMiX1poaSiy782Z3ylkfKACIEe8554oXNnFL46ZhEaEID88j8hls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=TFgc6iJB; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-2cf2fdd518bso8509861fa.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 23:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706773228; x=1707378028; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8+2hWgqEGa1ik5p7kIXAag508wrtryRn7JUB1Ap3pFg=;
        b=TFgc6iJB4E5Kdp1aZWjF+hoEd5v+5PClpflAjJojtodbhussQBf9Z5B8tyPxG4pNvp
         Zz3BqBBQPwi0J6e7E6xqDk5J2QgrOadOLprhPs/iwfPnZWe2Q5k2/CQnp7G3tZvF0yWA
         6ZxZOx3L/B4B637jSGbnMxGCKgrnys1yqSWxpQwdnpWMkwjXoTTmYvxlRKa+ZnO1gG5G
         VROXHBCISw26qv/BuJ4+O4CTYYR/1P0VOgBONp7/vyuPpQkbGeVO8w/4hOlSXZzD7G11
         eiL70bVWBzv+E5qAIzk46psInir3/30e0HrcE0MtehY//d2SKkNKcz6x1tLo82PLueCk
         bvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706773228; x=1707378028;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+2hWgqEGa1ik5p7kIXAag508wrtryRn7JUB1Ap3pFg=;
        b=kpO1t3n0xKMLljZAxdIi4SuwNMczemurHP0W9f++TRGLq5QfwAPwdqpWqEhFWuwxEh
         eos+yA48nqsNNeAw+FqPURyh0lglb8mtgo1rX4jHUgTldoIoEL/VQeB4XHue8p2Vx0eK
         mNlNF5f7eICQ4vFJgiI+waoi+uv9xSAHfu8jb94dCSHn5nUYCeCKY65JqntU+BwxQkd7
         Wm2mfdJGRM1JbzqwDbVAqaBiR5caAovx5f/cABxiQ+aevnxkrY9oMTpeLTsqRLZb6/20
         5V2SEgRNScKIDoNWU+nRzNmolDHrnQouNu/hEYzKmFcrsCy2/cnbRGUAO5j00U51QWEk
         aBtQ==
X-Gm-Message-State: AOJu0YyCFS9Uf72lJ8u1Lpnu3ztMszKHVsltVO4BtxIJwNNOU/l0nxkw
	rF57/dINgvi7D9MCYn9qMkq9hr9cOCx1oIHbs4Y4EWuDhgDf+XhU7cqe8PFoZv0=
X-Google-Smtp-Source: AGHT+IFoNPg5KzMKro6fCiGuoPk0P1yrwaX8gjGPGV6/S5rk+mRzPU+3mFhHYYcGLWJ85O8Kw9Ddkw==
X-Received: by 2002:a2e:8847:0:b0:2cd:cd28:beea with SMTP id z7-20020a2e8847000000b002cdcd28beeamr818829ljj.35.1706773228316;
        Wed, 31 Jan 2024 23:40:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUeu0JlMUgDbweYXKiU8+IJF44zqT5tVI1dbOYAdWYgDhhINQeXlZxKfEiQfJv+owTP6v3QMPs5Sn6n9oUf8969yJ5dRfVBC+eaTqfYx5+ayw0cka+E4WMX3DGeKXpbhtWszDtcVndmJ6LKaeGhvbxc83mvlaXhHdKRlkXlsRL2HUGKVsTmQ7HjHBkBU5oi2OrjBY79W+5exkcHUoFA2VYQcjWROlhp2k/X59rm7Etqckb2kAB4TJkCcYHS0R1g4F6iDW4J6HjDaC+qN9HuIpQb6jFgXi5wP43WOLjqIb9odVX18UiFChTfSsPEXtHT/Gg5J7KB9CbwZV9mDUrx911sjfwyKvdUC552SSdse3Zsnvm5zDwcD1xDAQbyM2CDviVZ8HLvSJcdmuMbNtZfJRy2tQpLUdw3Sc3sqws9PQAbswW1EFI3+Bq6RNxfzuVvcbdZGDVL6uIMRxWLJFh71gowMZwU/DSSC6biBoiuqgvBww==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d440b000000b0033b17e18df8sm410990wrq.12.2024.01.31.23.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 23:40:27 -0800 (PST)
Date: Thu, 1 Feb 2024 08:40:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: karthiksundaravel <ksundara@redhat.com>, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, rjarry@redhat.com,
	aharivel@redhat.com, cfontain@redhat.com, vchundur@redhat.com
Subject: Re: [Intel-wired-lan] [PATCH] ice: Add get/set hw address for VF
 representor ports
Message-ID: <ZbtK6PwsYLosTem8@nanopsycho>
References: <20240131080847.30614-1-ksundara@redhat.com>
 <64c36525-9177-48b1-abbb-c69dbdeb6d79@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64c36525-9177-48b1-abbb-c69dbdeb6d79@molgen.mpg.de>

Wed, Jan 31, 2024 at 05:15:46PM CET, pmenzel@molgen.mpg.de wrote:
>Dear karthiksundaravel,
>
>
>Thank you for your patch.
>
>
>Am 31.01.24 um 09:08 schrieb karthiksundaravel:
>> Changing the mac address of the VF representor ports are not
>
>Do you mean “is not possible”?
>
>> available via devlink. Add the function handlers to set and get
>> the HW address for the VF representor ports.
>
>How did you test this? It’d be great if you documented it.
>
>> Signed-off-by: karthiksundaravel <ksundara@redhat.com>
>
>Is “karthiksundaravel” the official spelling of your name. If not, you can
>change it with
>
>    git config --global user.name "Your Name"
>    git commit -s --amend --author="Your Name <ksundara@redhat.com>"
>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_devlink.c | 134 ++++++++++++++++++-
>>   1 file changed, 132 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
>> index 80dc5445b50d..56d81836c469 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>> @@ -9,6 +9,8 @@
>>   #include "ice_eswitch.h"
>>   #include "ice_fw_update.h"
>>   #include "ice_dcb_lib.h"
>> +#include "ice_fltr.h"
>> +#include "ice_tc_lib.h"
>>   static int ice_active_port_option = -1;
>> @@ -1576,6 +1578,134 @@ void ice_devlink_destroy_pf_port(struct ice_pf *pf)
>>   	devlink_port_unregister(&pf->devlink_port);
>>   }
>> +/**
>> + * ice_devlink_port_get_vf_mac_address - .port_fn_hw_addr_get devlink handler
>> + * @port: devlink port structure
>> + * @hw_addr: Mac address of the port
>> + * @hw_addr_len: length of mac address
>
>Mac/mac is spelled differently. (Also below.)
>
>> + * @extack: extended netdev ack structure
>> + *
>> + * Callback for the devlink .port_fn_hw_addr_get operation
>> + * Return: zero on success or an error code on failure.
>> + */
>> +
>> +static int ice_devlink_port_get_vf_mac_address(struct devlink_port *port,
>> +					       u8 *hw_addr, int *hw_addr_len,
>> +					       struct netlink_ext_ack *extack)
>> +{
>> +	struct net_device *netdev = port->type_eth.netdev;
>> +
>> +	if (!netdev || !netdev->dev_addr)
>> +		return -EADDRNOTAVAIL;
>> +
>> +	ether_addr_copy(hw_addr, netdev->dev_addr);
>> +	*hw_addr_len = ETH_ALEN;
>> +	return 0;
>> +}
>> +
>> +/**
>> + * ice_devlink_port_set_vf_mac_address - .port_fn_hw_addr_set devlink handler
>> + * @port: devlink port structure
>> + * @hw_addr: Mac address of the port
>> + * @hw_addr_len: length of mac address
>> + * @extack: extended netdev ack structure
>> + *
>> + * Callback for the devlink .port_fn_hw_addr_set operation
>> + * Return: zero on success or an error code on failure.
>> + */
>> +static int ice_devlink_port_set_vf_mac_address(struct devlink_port *port,
>> +					       const u8 *hw_addr,
>> +					       int hw_addr_len,
>> +					       struct netlink_ext_ack *extack)
>> +{
>> +	struct devlink *devlink = port->devlink;
>> +	struct net_device *netdev = port->type_eth.netdev;
>> +	struct ice_pf *pf = devlink_priv(devlink);
>> +	struct ice_vsi *vsi = *pf->vsi;
>> +	struct ice_hw *hw = &pf->hw;
>> +	struct device *dev = ice_pf_to_dev(pf);
>> +	u8 old_mac[ETH_ALEN];
>> +	u8 flags = 0;
>> +	const u8 *mac = hw_addr;
>> +	int err;
>> +
>> +	if (!netdev)
>> +		return -EADDRNOTAVAIL;
>> +
>> +	if (!is_valid_ether_addr(mac))
>> +		return -EADDRNOTAVAIL;
>> +
>> +	if (ether_addr_equal(netdev->dev_addr, mac)) {
>> +		dev_dbg(dev, "already using mac %pM\n", mac);
>> +		return 0;
>> +	}
>> +
>> +	if (test_bit(ICE_DOWN, pf->state) ||
>> +	    ice_is_reset_in_progress(pf->state)) {
>> +		dev_err(dev, "can't set mac %pM. device not ready\n", mac);
>> +		return -EBUSY;
>> +	}
>> +
>> +	if (ice_chnl_dmac_fltr_cnt(pf)) {
>> +		dev_err(dev, "can't set mac %pM. Device has tc-flower filters, delete all of them and try again\n",
>> +			mac);
>> +		return -EAGAIN;
>> +	}
>> +
>> +	netif_addr_lock_bh(netdev);
>> +	ether_addr_copy(old_mac, netdev->dev_addr);
>> +	/* change the netdev's MAC address */
>
>The comment seems redundant.
>
>> +	eth_hw_addr_set(netdev, mac);
>> +	netif_addr_unlock_bh(netdev);
>> +
>> +	/* Clean up old MAC filter. Not an error if old filter doesn't exist */
>> +	err = ice_fltr_remove_mac(vsi, old_mac, ICE_FWD_TO_VSI);
>> +	if (err && err != -ENOENT) {
>> +		err = -EADDRNOTAVAIL;
>> +		goto err_update_filters;
>> +	}
>> +
>> +	/* Add filter for new MAC. If filter exists, return success */
>> +	err = ice_fltr_add_mac(vsi, mac, ICE_FWD_TO_VSI);
>> +	if (err == -EEXIST) {
>> +		/* Although this MAC filter is already present in hardware it's
>> +		 * possible in some cases (e.g. bonding) that dev_addr was
>> +		 * modified outside of the driver and needs to be restored back
>> +		 * to this value.
>> +		 */
>> +		dev_dbg(dev, "filter for MAC %pM already exists\n", mac);
>> +		return 0;
>> +	} else if (err) {
>> +		/* error if the new filter addition failed */
>
>The comment seems redundant.
>
>> +		err = -EADDRNOTAVAIL;
>> +	}
>> +
>> +err_update_filters:
>> +	if (err) {
>> +		dev_err(dev, "can't set MAC %pM. filter update failed\n", mac);
>> +		netif_addr_lock_bh(netdev);
>> +		eth_hw_addr_set(netdev, old_mac);
>> +		netif_addr_unlock_bh(netdev);
>> +		return err;
>> +	}
>> +
>> +	dev_dbg(dev, "updated MAC address to %pM\n", netdev->dev_addr);
>
>Should it be level info?
>
>> +
>> +	/* write new MAC address to the firmware */
>> +	flags = ICE_AQC_MAN_MAC_UPDATE_LAA_WOL;
>> +	err = ice_aq_manage_mac_write(hw, mac, flags, NULL);
>> +	if (err) {
>> +		dev_err(dev, "can't set MAC %pM. write to firmware failed error %d\n",
>> +			mac, err);
>> +	}
>> +	return 0;
>> +}
>> +
>> +static const struct devlink_port_ops ice_devlink_vf_port_ops = {
>> +	.port_fn_hw_addr_get = ice_devlink_port_get_vf_mac_address,
>> +	.port_fn_hw_addr_set = ice_devlink_port_set_vf_mac_address,
>> +};
>> +
>>   /**
>>    * ice_devlink_create_vf_port - Create a devlink port for this VF
>>    * @vf: the VF to create a port for
>> @@ -1611,7 +1741,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
>>   	devlink_port_attrs_set(devlink_port, &attrs);
>>   	devlink = priv_to_devlink(pf);
>> -	err = devlink_port_register(devlink, devlink_port, vsi->idx);
>> +	err = devlink_port_register_with_ops(devlink, devlink_port,
>> +					     vsi->idx, &ice_devlink_vf_port_ops);
>>   	if (err) {
>>   		dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
>>   			vf->vf_id, err);
>> @@ -1620,7 +1751,6 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
>>   	return 0;
>>   }
>> -
>
>Unrelated whitespace change.
>
>>   /**
>>    * ice_devlink_destroy_vf_port - Destroy the devlink_port for this VF
>>    * @vf: the VF to cleanup
>
>Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Paul. It looks a bit weird you put in multiple comments that require
changes and then the Reviewed-by tag. Usually, you put the tag only if
you are 100% happy with the patch as it is.

It is also weird you put in a tag in this case when the patch
is completely wrong, as I pointed out in my first reply. Did you miss
it?


>
>
>Kind regards,
>
>Paul
>

