Return-Path: <netdev+bounces-117388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A0D94DB23
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 08:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E3F1F21D81
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 06:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880D33B298;
	Sat, 10 Aug 2024 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SWeCdthO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A15F21A0B
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723272646; cv=none; b=MNuQFQ4jQ4B2MjZe0OJZCE4DjBJ+Xc7Viaqs6j3b2LG89bOS1w/WcWcSElEoJ/e+CetjCv/Cj1WvqnIMMfNVKUEwasOh5RvK8BZxiygmk4VuIqF6DrCela6+y1m6TisUcMYaQKsXiQRdtbHZybb30EZzJTDARkigAwviyZclVLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723272646; c=relaxed/simple;
	bh=Re4YjhOKm8w5csaYL4/2Tmvx4D6XBt5LteF6PKmHq1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiI552MVba2XulmpPe8/mRtVTFAA5DojaaiPmfs9rjevqVlZwJIhGSkN7YdXDLQf4radhBPJagIOIdFE/jkEVmUJVIF1Kup2ddjG+8e6yrxXDZ9B46vuHjeFq/TQWOmf2sSsgXWyBnanwApRp2vx9QRZyzhlxWBZHotMvi2yAYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=SWeCdthO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso20296985e9.0
        for <netdev@vger.kernel.org>; Fri, 09 Aug 2024 23:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723272642; x=1723877442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V5fMlMfDLr6O083pckRnoiQKMidwxOyaTt5tjvNFEG4=;
        b=SWeCdthOd0iTxdKoKN77NU9qV/JqAbn2lslIrTC2JV6I+EYjGzmk0bruDFVsrgMqjn
         aF89FkWAsaF8Px35S4bt5vbNA0crPPCav5yrM/0yamab2Y3q/z+bU/2UEy31q/YbrtzU
         KpnOFhO3wpmvc07bxuWzHz6PCSXPm+I/QRgMY6B6Yw15S8sbechQMUeEMyw/RWZL6dS1
         nerL0sNcnAgOBUv1r3RjHiOI/ITvc97MCOWhJLzTXkxnWZBQT2XjDRbjeSmk5pbT74IL
         wYk3M//sYrThrIjQ8WphkxtJqxzHW7nHO2Y9sIlId3UmC4a/EK+2WE1pVaZCK8H0tJTQ
         Gf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723272642; x=1723877442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5fMlMfDLr6O083pckRnoiQKMidwxOyaTt5tjvNFEG4=;
        b=MUNBeLvrNq4NwnO23BA/UbaYmedjyxijwr7XfxYpjGqnyruOf3jMcCry4CcttxoqWf
         Na7JawBjLBH9rpCJZXHnMUu+MRDp2wTYQleX6vtLQt4uM4eTc7LssX5vuXhxaXKCM2VQ
         fYkCPmX7GpznXXcOyBnIG8xEse7OctD1fmC0voYHkCOKWNU7cgSdsGGNNpti50PG6rtH
         eKdn1oXkdYnkspgI2+UUGUYyRb2h/ap42rpUR3aiW8bojil7VpyTlG7RaSTk+M9vHmn7
         74nvfGMcRJaEY0V2iqXKf8pm9MuT842s1y0Xv4VGE2wQH5c615uEJ638ZEyrn+Oj3Lr1
         3C6A==
X-Forwarded-Encrypted: i=1; AJvYcCUvmQAh4KYZa9ZChIhJX7FgSxDIiVtHhhdZfq6bBR2HCI+emunQ5rhnZlwS4fDGbcbvuJTOzPqbtx4qANQoX/jBTS5/cFnK
X-Gm-Message-State: AOJu0Yz9nIu4hrnh1Hb3l8MoxJvYi/HzDVzzLtEgfSfwDfe8gjzVVqbi
	jSIioaduwChPs8LD0m9m+L4TX4FIXPbquMuBP8zeypyeeqC+y4eYgNnN/I9tNwM=
X-Google-Smtp-Source: AGHT+IHMfb3/KxvzgtZsnnJ5uK+W8ONQ7bFgGPGv4Dy9oG5YqaZVWGflzMCztokvP8E49+i0zI4Wlg==
X-Received: by 2002:a05:600c:468b:b0:426:55a3:71af with SMTP id 5b1f17b1804b1-429c3a5b3c1mr24023625e9.33.1723272641985;
        Fri, 09 Aug 2024 23:50:41 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c7736b05sm17645255e9.29.2024.08.09.23.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 23:50:41 -0700 (PDT)
Date: Sat, 10 Aug 2024 08:50:38 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, Piotr Raczynski <piotr.raczynski@intel.com>,
	jiri@nvidia.com, shayd@nvidia.com, wojciech.drewek@intel.com,
	horms@kernel.org, sridhar.samudrala@intel.com,
	mateusz.polchlopek@intel.com, kalesh-anakkur.purayil@broadcom.com,
	michal.kubiak@intel.com, pio.raczynski@gmail.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next v3 03/15] ice: add basic devlink subfunctions
 support
Message-ID: <ZrcNvu6cXqQ-ybZu@nanopsycho.orion>
References: <20240808173104.385094-1-anthony.l.nguyen@intel.com>
 <20240808173104.385094-4-anthony.l.nguyen@intel.com>
 <ZrX6jM6yedDNYfNv@nanopsycho.orion>
 <ZrYB2kEieNCIuof1@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrYB2kEieNCIuof1@mev-dev.igk.intel.com>

Fri, Aug 09, 2024 at 01:47:38PM CEST, michal.swiatkowski@linux.intel.com wrote:
>On Fri, Aug 09, 2024 at 01:16:28PM +0200, Jiri Pirko wrote:
>> Thu, Aug 08, 2024 at 07:30:49PM CEST, anthony.l.nguyen@intel.com wrote:
>> >From: Piotr Raczynski <piotr.raczynski@intel.com>
>> >
>> 
>> [...]
>> 
>> >+static int
>> >+ice_devlink_port_new_check_attr(struct ice_pf *pf,
>> >+				const struct devlink_port_new_attrs *new_attr,
>> >+				struct netlink_ext_ack *extack)
>> >+{
>> >+	if (new_attr->flavour != DEVLINK_PORT_FLAVOUR_PCI_SF) {
>> >+		NL_SET_ERR_MSG_MOD(extack, "Flavour other than pcisf is not supported");
>> >+		return -EOPNOTSUPP;
>> >+	}
>> >+
>> >+	if (new_attr->controller_valid) {
>> >+		NL_SET_ERR_MSG_MOD(extack, "Setting controller is not supported");
>> >+		return -EOPNOTSUPP;
>> >+	}
>> >+
>> >+	if (new_attr->port_index_valid) {
>> >+		NL_SET_ERR_MSG_MOD(extack, "Port index is invalid");
>> 
>> Nope, it is actually valid, but your driver does not support that.
>> Please fix the message.
>>
>
>Ok
>
>> 
>> >+		return -EOPNOTSUPP;
>> >+	}
>> >+
>> >+	if (new_attr->pfnum != pf->hw.bus.func) {
>> 
>> hw.bus.func, hmm. How about if you pass-through the PF to VM, can't the
>> func be anything? Will this still make sense? I don't think so. If you
>> get the PF number like this in the rest of the driver, you need to fix
>> this.
>>
>
>I can change it to our internal value. I wonder if it will be better. If
>I understand correctly, now:
>PF0 - xx.xx.0; PF1 - xx.xx.1
>
>I am doing pass-through PF1
>PF0 (on host) - xx.xx.0
>
>PF1 (on VM) - xx.xx.0 (there is one PF on VM, so for me it is more
>intuitive to have func 0)
>
>after I change:
>PF0 - xx.xx.0; PF1 - xx.xx.1
>
>pass-through PF1
>PF0 (on host) - xx.xx.0
>
>PF1 (on VM) - xx.xx.0, but user will have to use 1 as pf num
>
>Correct me if I am wrong.

Did you try this? I mean, you can check that easily with vng:
vng --qemu-opts="-device vfio-pci,host=5e:01.0,addr=01.04"

Then in the VM you see:
0000:00:01.4

Then, by your code, the pf number is 4, isn't it?

What am I missing?



>
>> 
>> 
>> >+		NL_SET_ERR_MSG_MOD(extack, "Incorrect pfnum supplied");
>> >+		return -EINVAL;
>> >+	}
>> >+
>> >+	if (!pci_msix_can_alloc_dyn(pf->pdev)) {
>> >+		NL_SET_ERR_MSG_MOD(extack, "Dynamic MSIX-X interrupt allocation is not supported");
>> >+		return -EOPNOTSUPP;
>> >+	}
>> >+
>> >+	return 0;
>> >+}
>> 
>> [...]
>> 
>> 
>> >+int ice_devlink_create_sf_port(struct ice_dynamic_port *dyn_port)
>> >+{
>> >+	struct devlink_port_attrs attrs = {};
>> >+	struct devlink_port *devlink_port;
>> >+	struct devlink *devlink;
>> >+	struct ice_vsi *vsi;
>> >+	struct ice_pf *pf;
>> >+
>> >+	vsi = dyn_port->vsi;
>> >+	pf = dyn_port->pf;
>> >+
>> >+	devlink_port = &dyn_port->devlink_port;
>> >+
>> >+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_SF;
>> >+	attrs.pci_sf.pf = pf->hw.bus.func;
>> 
>> Same here.
>> 
>> 
>> >+	attrs.pci_sf.sf = dyn_port->sfnum;
>> >+
>> >+	devlink_port_attrs_set(devlink_port, &attrs);
>> >+	devlink = priv_to_devlink(pf);
>> >+
>> >+	return devl_port_register_with_ops(devlink, devlink_port, vsi->idx,
>> >+					   &ice_devlink_port_sf_ops);
>> >+}
>> >+
>> 
>> [...]

