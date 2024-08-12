Return-Path: <netdev+bounces-117634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C7194EA51
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 11:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D954D1C20305
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 09:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAE716DECC;
	Mon, 12 Aug 2024 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="R9HY0R6/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9F116DED4
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723456427; cv=none; b=Xp3aQgOe1YSrUu2YGpClnnlTwzpHWOnl0F+agyPEAGDgqqMOHxblIqAMcMJJ2XEsm+8+tkwyi6L2L3fjaFU+6qoBUFThWz7Ck2OoAo99FhGg+eYBRs1O/bfytqf7f4wic/4ILFLH1fFRwRSuTdnSszJ7T9W1CBsfGtSC+/yQhRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723456427; c=relaxed/simple;
	bh=8nmof8Pc+ww8wBZvTkB9Gm4efiqxaJ+Ct1IuXI0NKL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bChsK/uucJTU2NqkjkalvEZ99VtYqdRoudOjYDRtcmMwbZoBUSgPrArpQWSiQ2/149TWLBtSpjYlwbz8bNyHdO+HUYFLjj4vOPF+JBstO91ulOKAsgscmVXAjhesTzVrlpilr4QkYfuNyb1HVbT+1QIQy/xaqO6UrUf9gXrCXJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=R9HY0R6/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428243f928cso28795835e9.3
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 02:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723456423; x=1724061223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CG+mQq7189NfEz5+iaNzWQrirMW9z5hC+E5vBs40scM=;
        b=R9HY0R6/exvWbaQ/Dm3lgn6jd814PX1EGh9ZH4iY5s47LRncDEoIL3kjbElCI/yGli
         RonyLo2I0SLgVinNkcHXotphEvYY9KRyBD707wNs0ayzPIYQKx9z4IHdLZBZXYwN47xt
         Fl12csAAfXq4qFJW+nZNRNBdtcHFltaZiqnpT8iNrst9gSZNr9R5K4u7RAoxsDzmVr0s
         +qpLdAXHgU2iuAVljs0lL793zt4WhpLl8n3MaCu11DSn4VLVtuViBoOqzn8Abc+15vG6
         QXpr6o1FAPEcyotjRBsHrVFg/q8RFfN5+WTnXiUFh35yNw2oiaXWvID/UfE4xOWWnTN6
         7sdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723456423; x=1724061223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CG+mQq7189NfEz5+iaNzWQrirMW9z5hC+E5vBs40scM=;
        b=s1gOZqPeAzJGUz+5YrUTMxSewZ4bfVnHX2x0U1WpWB8CFFsQTzs/RCLLmUSo1+u2PX
         ztnPe84tVtRnAE42owa9H96raE6Ecb1HSFu3MzZtO351p1up+zD6Ec0JvsTfsqCvw13K
         x4zJVxGro9ezpVPBS/HzVadwc0wWodSz7QCTGaagyvyXWpuwWn/zZAxxGPcN1FTOIg/v
         5JO3PIRqv68z4B1dHWzdawMQzv8+aAkaoMIDZq4xAUgnZc5CA5j+cJOYR24U9x0WwohH
         e1QI31/8JA8K8b3B2LsPt4ukM/t0Er4grrdqib01SWrHacBU6HdZyKTG678UIslUAUHZ
         pVOw==
X-Forwarded-Encrypted: i=1; AJvYcCVIFGdXAILfkLXiD4JY9EXofbrMO9lr1bAuI3eF+2DNkM6IcCbDyBASrG1piaJhNhpbt99e2T1nwWritqgtYwUBzc+q2Tql
X-Gm-Message-State: AOJu0Ywb0WsZ/hoQLTToDj8vgjqjMGixWZ/uK+3QzztqXH0Jj1Pzy3ta
	C++aFjV5GvjT3orj8MfeGfaQdl4LKBGP0sgbpq5YgfyVKT3Dd+yI8N6qKe43NFI=
X-Google-Smtp-Source: AGHT+IEbDzdoM7wkFXBVS+fh0Ky3i/xkQT/ZXGxNIk47vfC46nxYHjTc9UWGwyDWy3CEaMLOtaDsdA==
X-Received: by 2002:adf:f190:0:b0:367:947a:a491 with SMTP id ffacd0b85a97d-36d5fe77ad1mr5889060f8f.26.1723456422546;
        Mon, 12 Aug 2024 02:53:42 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd2accsm7015102f8f.90.2024.08.12.02.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 02:53:41 -0700 (PDT)
Date: Mon, 12 Aug 2024 11:53:39 +0200
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
Message-ID: <Zrnbo33CvaMzViCY@nanopsycho.orion>
References: <20240808173104.385094-1-anthony.l.nguyen@intel.com>
 <20240808173104.385094-4-anthony.l.nguyen@intel.com>
 <ZrX6jM6yedDNYfNv@nanopsycho.orion>
 <ZrYB2kEieNCIuof1@mev-dev.igk.intel.com>
 <ZrcNvu6cXqQ-ybZu@nanopsycho.orion>
 <ZrmObGTwIw4cDJ7v@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrmObGTwIw4cDJ7v@mev-dev.igk.intel.com>

Mon, Aug 12, 2024 at 06:24:12AM CEST, michal.swiatkowski@linux.intel.com wrote:
>On Sat, Aug 10, 2024 at 08:50:38AM +0200, Jiri Pirko wrote:
>> Fri, Aug 09, 2024 at 01:47:38PM CEST, michal.swiatkowski@linux.intel.com wrote:
>> >On Fri, Aug 09, 2024 at 01:16:28PM +0200, Jiri Pirko wrote:
>> >> Thu, Aug 08, 2024 at 07:30:49PM CEST, anthony.l.nguyen@intel.com wrote:
>> >> >From: Piotr Raczynski <piotr.raczynski@intel.com>
>> >> >
>> >> 
>> >> [...]
>> >> 
>> >> >+static int
>> >> >+ice_devlink_port_new_check_attr(struct ice_pf *pf,
>> >> >+				const struct devlink_port_new_attrs *new_attr,
>> >> >+				struct netlink_ext_ack *extack)
>> >> >+{
>> >> >+	if (new_attr->flavour != DEVLINK_PORT_FLAVOUR_PCI_SF) {
>> >> >+		NL_SET_ERR_MSG_MOD(extack, "Flavour other than pcisf is not supported");
>> >> >+		return -EOPNOTSUPP;
>> >> >+	}
>> >> >+
>> >> >+	if (new_attr->controller_valid) {
>> >> >+		NL_SET_ERR_MSG_MOD(extack, "Setting controller is not supported");
>> >> >+		return -EOPNOTSUPP;
>> >> >+	}
>> >> >+
>> >> >+	if (new_attr->port_index_valid) {
>> >> >+		NL_SET_ERR_MSG_MOD(extack, "Port index is invalid");
>> >> 
>> >> Nope, it is actually valid, but your driver does not support that.
>> >> Please fix the message.
>> >>
>> >
>> >Ok
>> >
>> >> 
>> >> >+		return -EOPNOTSUPP;
>> >> >+	}
>> >> >+
>> >> >+	if (new_attr->pfnum != pf->hw.bus.func) {
>> >> 
>> >> hw.bus.func, hmm. How about if you pass-through the PF to VM, can't the
>> >> func be anything? Will this still make sense? I don't think so. If you
>> >> get the PF number like this in the rest of the driver, you need to fix
>> >> this.
>> >>
>> >
>> >I can change it to our internal value. I wonder if it will be better. If
>> >I understand correctly, now:
>> >PF0 - xx.xx.0; PF1 - xx.xx.1
>> >
>> >I am doing pass-through PF1
>> >PF0 (on host) - xx.xx.0
>> >
>> >PF1 (on VM) - xx.xx.0 (there is one PF on VM, so for me it is more
>> >intuitive to have func 0)
>> >
>> >after I change:
>> >PF0 - xx.xx.0; PF1 - xx.xx.1
>> >
>> >pass-through PF1
>> >PF0 (on host) - xx.xx.0
>> >
>> >PF1 (on VM) - xx.xx.0, but user will have to use 1 as pf num
>> >
>> >Correct me if I am wrong.
>> 
>> Did you try this? I mean, you can check that easily with vng:
>> vng --qemu-opts="-device vfio-pci,host=5e:01.0,addr=01.04"
>> 
>> Then in the VM you see:
>> 0000:00:01.4
>> 
>> Then, by your code, the pf number is 4, isn't it?
>> 
>> What am I missing?
>
>I didn't know about addr parameter. I will change it to always have the
>same number so.

Please make sure this is fixed in other ice places:

$ git grep "bus.func" drivers/net/ethernet/intel/ice/
drivers/net/ethernet/intel/ice/devlink/devlink_port.c:  attrs.phys.port_number = pf->hw.bus.func;
drivers/net/ethernet/intel/ice/devlink/devlink_port.c:  attrs.pci_vf.pf = pf->hw.bus.func;
drivers/net/ethernet/intel/ice/ice_debugfs.c:   if (pf->hw.bus.func)
drivers/net/ethernet/intel/ice/ice_fwlog.c:     if (hw->bus.func)
drivers/net/ethernet/intel/ice/ice_fwlog.c:     if (hw->bus.func)
drivers/net/ethernet/intel/ice/ice_main.c:      hw->bus.func = PCI_FUNC(pdev->devfn);

Calls for a -net/stable fix IMO.

Also, check other intel drivers as well. I see this is a pattern.

Thanks!


>
>> 
>> 
>> 
>> >
>> >> 
>> >> 
>> >> >+		NL_SET_ERR_MSG_MOD(extack, "Incorrect pfnum supplied");
>> >> >+		return -EINVAL;
>> >> >+	}
>> >> >+
>> >> >+	if (!pci_msix_can_alloc_dyn(pf->pdev)) {
>> >> >+		NL_SET_ERR_MSG_MOD(extack, "Dynamic MSIX-X interrupt allocation is not supported");
>> >> >+		return -EOPNOTSUPP;
>> >> >+	}
>> >> >+
>> >> >+	return 0;
>> >> >+}
>> >> 
>> >> [...]
>> >> 
>> >> 
>> >> >+int ice_devlink_create_sf_port(struct ice_dynamic_port *dyn_port)
>> >> >+{
>> >> >+	struct devlink_port_attrs attrs = {};
>> >> >+	struct devlink_port *devlink_port;
>> >> >+	struct devlink *devlink;
>> >> >+	struct ice_vsi *vsi;
>> >> >+	struct ice_pf *pf;
>> >> >+
>> >> >+	vsi = dyn_port->vsi;
>> >> >+	pf = dyn_port->pf;
>> >> >+
>> >> >+	devlink_port = &dyn_port->devlink_port;
>> >> >+
>> >> >+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_SF;
>> >> >+	attrs.pci_sf.pf = pf->hw.bus.func;
>> >> 
>> >> Same here.
>> >> 
>> >> 
>> >> >+	attrs.pci_sf.sf = dyn_port->sfnum;
>> >> >+
>> >> >+	devlink_port_attrs_set(devlink_port, &attrs);
>> >> >+	devlink = priv_to_devlink(pf);
>> >> >+
>> >> >+	return devl_port_register_with_ops(devlink, devlink_port, vsi->idx,
>> >> >+					   &ice_devlink_port_sf_ops);
>> >> >+}
>> >> >+
>> >> 
>> >> [...]

