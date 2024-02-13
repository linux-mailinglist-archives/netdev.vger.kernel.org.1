Return-Path: <netdev+bounces-71417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF9F8533ED
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 16:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D443A1C27BB8
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A935F54C;
	Tue, 13 Feb 2024 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vaZ6wsNQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECBB5F460
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836289; cv=none; b=V/04v6RVwxWOmXkHcikbOqMYCgK+YfGKNRExODj+2YjT7Mhuf3PnShoInEJDIGi2c4xBQiyghJ7Ix0TMMlmqxntAYx6Zp4fVtRx7HNY+UWaYvIOamkKYJQCpPUB8zCroLv379Cvurercj8QdJWKe68VoiWstS8j3tXXJEdFuXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836289; c=relaxed/simple;
	bh=snbMnXn1pPysBOadYVc6jAlGE801lR6xHV5kfaG1uio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WW1SiM1fydsBlVd9RqQUYb6GRBTHwnpd/AJKFbjZPTsaan6lYKk2HivntlUEoRVSiAs3gzMfY6q1UVm59itNqIAip8Ui4lyTSfsjhQEO6HY59IifiOlJvZnlx8vR+8/oqfkUb+CeCXI7lc8R+inQDhN9k4Exq4CNzqE4uWLYWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=vaZ6wsNQ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5116b540163so6541719e87.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707836283; x=1708441083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0gWtVFT531L8n8wHnh3G/M8myD+YA+zSGr3tIuusgcc=;
        b=vaZ6wsNQPOWsbfMx0Djr5fqHHHdWPlwWlZn0nr4E5NS1HxWJ3ybNXD8Q0Im7D1rDLU
         U0SnQdS+ndtNzRRIjUYVtH0eOJamf0QfghmcQFHqJS8TdLhLsbHdRwRfaNOiHwWc9sZB
         bVFZMO0IinASINeu/mDCQ5/yD2eIduw8RQWuNeTP/502M20ZS4N1D3021xnYucYBCQ+k
         GzyswTjk9WSB5KFVlUVK43lidHrOmO/u7VxVkJuS7mpyTdK6W8jjSUL2hWYO9NDIFVMa
         DgFIcZROaCHjwt3dOVpHxFhNKp/si5qaA42jj7URc8lr2qtBegZTvQ1xYAY31DBFLZEV
         hVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707836283; x=1708441083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gWtVFT531L8n8wHnh3G/M8myD+YA+zSGr3tIuusgcc=;
        b=EA3CvF4rev7ACfC6ktbOiKQ80v9qaKOY5vpI0d/g5E+SbQsiHYMPPrTFnOhjNSNvcQ
         mMBazi5JrVduO0wqH/V8QV1kcdyDl2sWqeU+Xjv+5D0ksJ59cfleg9Nf5u3O75EIkD9A
         woDt4XdvtWLVFu+YiZ+8p4iZtUiUHT1TNPj9jb1uwAxfL3MR/LBLJj99mZAUetTjyjn1
         mn3wKMKx97cGOuodWBzk/CFLdxB2jEE/WDaZkcAdgaBMhCJHNEPloLrUNnnJBSWOvar1
         J1CVdnuwQl19rEuURAPFC38v4hz0YeoH7Z5MSvcJGeIIzkIXILMqSKfjlX7Ca778Yqm4
         vBWA==
X-Forwarded-Encrypted: i=1; AJvYcCXuXd8vXMCScfMN1KYI2Z4B55pFi4DLOun8e22aiDOH2Qk+avQD0F3WSXpmO9oewGz30EgmzeMmulYfZOvpLxh4/x6Firu7
X-Gm-Message-State: AOJu0Yyo4R0VooK2t20rNL7C1VCRoJMjEqYmgZjDlRe70wqydDs1Ne2h
	P9L1o5IBjMVDoZ7pce6RLbuWeyM+XupqDQwrVvAI7bRlEeSz1CnxzopmFpOABdI=
X-Google-Smtp-Source: AGHT+IFXsxdkcczDpJXTBI0muZ5CDM2FYK3viHjsOY0zPiYzkCLn1Nu/bm9w1zHJhiA8JQ69NGI8rw==
X-Received: by 2002:a05:6512:3494:b0:511:29ee:83b8 with SMTP id v20-20020a056512349400b0051129ee83b8mr6073711lfr.62.1707836282895;
        Tue, 13 Feb 2024 06:58:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmZQFi0ghf7a2CqxMqQRV8gXeUQULXl+AMAM+/OPRQ72Jfes173Cn6T2nwaBl1nzZk9aEZkMgAxYRfaFLwxQKNcbX463wboz3qzbHXE9mDzFHz2RebRis4yvVtGHCLCgjpS268/Zg+7Nf+rfZUXb3NJvflJAQAHcm80AWH05nKTNaESNY9qQDcNpGvWpG6tSo95iMLfovL6wPHCB7h1YlwmNZ+i8UM+csl3JDjpibiwlm1UXoVqgqsLZPmvY+1A86eXsMxKN4NL7C5TXJVyYVfRtWQmJKERUvBNQInaaQEvnHzGlvHkRBvFz63/AVt00Lf4nPCQlCVY8be07ZqWZFBWz/32OKgUY+CKQKKZSyUazJXaNZwcYrHea8srUetcaxNct4/YkHd7V91gwZZEFRAqxh6P2MhCg==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ll5-20020a170907190500b00a3d120e311asm466717ejc.117.2024.02.13.06.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:58:02 -0800 (PST)
Date: Tue, 13 Feb 2024 15:57:59 +0100
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
Message-ID: <ZcuDd4ajkQnxJz77@nanopsycho>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
 <20240213072724.77275-5-michal.swiatkowski@linux.intel.com>
 <ZcsueJ1tr-GdseIt@nanopsycho>
 <Zcs442A/+nuLJw6j@mev-dev>
 <ZctSGPf6v0QlfMUu@nanopsycho>
 <ZctaY7AfjS/N2J9X@mev-dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZctaY7AfjS/N2J9X@mev-dev>

Tue, Feb 13, 2024 at 01:02:43PM CET, michal.swiatkowski@linux.intel.com wrote:
>On Tue, Feb 13, 2024 at 12:27:20PM +0100, Jiri Pirko wrote:
>> Tue, Feb 13, 2024 at 10:39:47AM CET, michal.swiatkowski@linux.intel.com wrote:
>> >On Tue, Feb 13, 2024 at 09:55:20AM +0100, Jiri Pirko wrote:
>> >> Tue, Feb 13, 2024 at 08:27:13AM CET, michal.swiatkowski@linux.intel.com wrote:
>> >> >From: Piotr Raczynski <piotr.raczynski@intel.com>
>> 
>> [...]
>> 
>> 
>> >
>> >> 
>> >> >+}
>> >> >+
>> >> >+/**
>> >> >+ * ice_dealloc_dynamic_port - Deallocate and remove a dynamic port
>> >> >+ * @dyn_port: dynamic port instance to deallocate
>> >> >+ *
>> >> >+ * Free resources associated with a dynamically added devlink port. Will
>> >> >+ * deactivate the port if its currently active.
>> >> >+ */
>> >> >+static void ice_dealloc_dynamic_port(struct ice_dynamic_port *dyn_port)
>> >> >+{
>> >> >+	struct devlink_port *devlink_port = &dyn_port->devlink_port;
>> >> >+	struct ice_pf *pf = dyn_port->pf;
>> >> >+
>> >> >+	if (dyn_port->active)
>> >> >+		ice_deactivate_dynamic_port(dyn_port);
>> >> >+
>> >> >+	if (devlink_port->attrs.flavour == DEVLINK_PORT_FLAVOUR_PCI_SF)
>> >> 
>> >> I don't understand how this check could be false. Remove it.
>> >>
>> >Yeah, will remove
>> >
>> >> 
>> >> >+		xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
>> >> >+
>> >> >+	devl_port_unregister(devlink_port);
>> >> >+	ice_vsi_free(dyn_port->vsi);
>> >> >+	xa_erase(&pf->dyn_ports, dyn_port->vsi->idx);
>> >> >+	kfree(dyn_port);
>> >> >+}
>> >> >+
>> >> >+/**
>> >> >+ * ice_dealloc_all_dynamic_ports - Deallocate all dynamic devlink ports
>> >> >+ * @pf: pointer to the pf structure
>> >> >+ */
>> >> >+void ice_dealloc_all_dynamic_ports(struct ice_pf *pf)
>> >> >+{
>> >> >+	struct devlink *devlink = priv_to_devlink(pf);
>> >> >+	struct ice_dynamic_port *dyn_port;
>> >> >+	unsigned long index;
>> >> >+
>> >> >+	devl_lock(devlink);
>> >> >+	xa_for_each(&pf->dyn_ports, index, dyn_port)
>> >> >+		ice_dealloc_dynamic_port(dyn_port);
>> >> >+	devl_unlock(devlink);
>> >> 
>> >> Hmm, I would assume that the called should already hold the devlink
>> >> instance lock when doing remove. What is stopping user from issuing
>> >> port_new command here, after devl_unlock()?
>> >>
>> >It is only called from remove path, but I can move it upper.
>> 
>> I know it is called on remove path. Again, what is stopping user from
>> issuing port_new after ice_dealloc_all_dynamic_ports() is called?
>> 
>> [...]
>> 
>What is a problem here? Calling port_new from user perspective will have
>devlink lock, right? Do you mean that devlink lock should be taken for
>whole cleanup, so from the start to the moment when devlink is
>unregister? I wrote that, I will do that in next version (moving it

Yep, otherwise you can ice_dealloc_all_dynamic_ports() and end up with
another port created after that which nobody cleans-up.

>upper).
>
>> 
>> >> 
>> >> >+	struct device *dev = ice_pf_to_dev(pf);
>> >> >+	int err;
>> >> >+
>> >> >+	dev_dbg(dev, "%s flavour:%d index:%d pfnum:%d\n", __func__,
>> >> >+		new_attr->flavour, new_attr->port_index, new_attr->pfnum);
>> >> 
>> >> How this message could ever help anyone?
>> >>
>> >Probably only developer of the code :p, will remove it
>> 
>> How exactly?
>>
>I meant this code developer, it probably was used to check if number and
>indexes are correct, but now it should be removed. Like, leftover after
>developing, sorry.
>
>> [...]
>> 
>> 
>> >> >+static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port)
>> >> >+{
>> >> >+	struct net_device *netdev;
>> >> >+	struct ice_vsi *vsi = dyn_port->vsi;
>> >> >+	struct ice_netdev_priv *np;
>> >> >+	int err;
>> >> >+
>> >> >+	netdev = alloc_etherdev_mqs(sizeof(*np), vsi->alloc_txq,
>> >> >+				    vsi->alloc_rxq);
>> >> >+	if (!netdev)
>> >> >+		return -ENOMEM;
>> >> >+
>> >> >+	SET_NETDEV_DEV(netdev, &vsi->back->pdev->dev);
>> >> >+	set_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
>> >> >+	vsi->netdev = netdev;
>> >> >+	np = netdev_priv(netdev);
>> >> >+	np->vsi = vsi;
>> >> >+
>> >> >+	ice_set_netdev_features(netdev);
>> >> >+
>> >> >+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
>> >> >+			       NETDEV_XDP_ACT_XSK_ZEROCOPY |
>> >> >+			       NETDEV_XDP_ACT_RX_SG;
>> >> >+
>> >> >+	eth_hw_addr_set(netdev, dyn_port->hw_addr);
>> >> >+	ether_addr_copy(netdev->perm_addr, dyn_port->hw_addr);
>> >> >+	netdev->netdev_ops = &ice_sf_netdev_ops;
>> >> >+	SET_NETDEV_DEVLINK_PORT(netdev, &dyn_port->devlink_port);
>> >> >+
>> >> >+	err = register_netdev(netdev);
>> >> 
>> >> It the the actual subfunction or eswitch port representor of the
>> >> subfunction. Looks like the port representor. In that case. It should be
>> >> created no matter if the subfunction is activated, when it it created.
>> >> 
>> >> If this is the actual subfunction netdev, you should not link it to
>> >> devlink port here.
>> >>
>> >This is the actual subfunction netdev. Where in this case it should be
>> >linked?
>> 
>> To the SF auxdev, obviously.
>> 
>> Here, you should have eswitch port representor netdev.
>> 
>Oh, ok, thanks, will link it correctly in next version.
>

