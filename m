Return-Path: <netdev+bounces-254311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFijF0glemlk3QEAu9opvQ
	(envelope-from <netdev+bounces-254311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:03:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CF0A378B
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A25003012407
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5B2369965;
	Wed, 28 Jan 2026 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CD01nf6J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE43369993;
	Wed, 28 Jan 2026 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769612601; cv=none; b=Ypo4pi5lojDj1p/EbXNdq/+N1oHHB+MwMmmpIUL8UMI6u3SmmuB0puV72rS0/eSDd/Fi+G69LoFL1tBo66pc2kQOluu1cdQrHsHKlUD72G2UlodZeoj7P9J15YKMEnF3L2eWTygMMhHCvs7rqd/G50iOsAFccfwyGTwDzSC8h24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769612601; c=relaxed/simple;
	bh=QuVKlB6eN8V1XIu3FelRKHG398FLmSIM21NyvBg5vYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifskQdz8KThZ85ju/0NaAlqwCcZHQLk1oK3Q4FFn4Qazxi+KsbFiNmJjFh3xgXN3wVIfWTii7A4Wdrsz+MWiJqP3vqcEgJYUQFu1NDVYUtXcFqsJkFxvqT5CiJOxLyO/EVWE+mwhWFIgk5e8iyy3POGKamqfb4LLDfYKjjGCkX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CD01nf6J; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769612589; x=1801148589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QuVKlB6eN8V1XIu3FelRKHG398FLmSIM21NyvBg5vYw=;
  b=CD01nf6JTQVAD9bFhFLWeRNHKeCOZO6BSr9+7pCPHSM7no5XgXmr8CI5
   mgiBNb+y1MMrN4gREdlwGTf+Wx+GaB7jwKnb/nTy83nbP7pzCyrtEJJcy
   SSqCjyfuieV/BKa9H22zWC+elht02Qx87Hs/Sz7Yo2XEzlvs4U1DeVhu4
   JmaAT/+hUua+Xv8XQp81JsLkfFy4P1ArKZ9fZoTswN4fs2Ck7jFGf3WMR
   hb6dEP7sInVj2XkgbxI7biQa9svhIHnujA47bgIR5arv8nX/jGOV1AG39
   hKMwW7T/jI7LllyHbwOQc9JzEferB9hcZ9+yXhM+j4iTxzLdWv7eiKIDo
   w==;
X-CSE-ConnectionGUID: kL2vQfAcSE2FRgj1XF6Anw==
X-CSE-MsgGUID: 1YXmMBvjQ1ytE+Pm4Bc50w==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="96287143"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="96287143"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 07:02:53 -0800
X-CSE-ConnectionGUID: 36iywvRTRNGbF61rZgnJXQ==
X-CSE-MsgGUID: RmydpcKVS8Cigw5XJGfpMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="213259839"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO kuha) ([10.124.220.19])
  by orviesa005.jf.intel.com with SMTP; 28 Jan 2026 07:02:50 -0800
Received: by kuha (sSMTP sendmail emulation); Wed, 28 Jan 2026 17:02:22 +0200
Date: Wed, 28 Jan 2026 17:02:22 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Matt Johnston <matt@codeconstruct.com.au>,
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] i2c: SMBus ARP support
Message-ID: <aXokxtlFTeZK8lP8@kuha>
References: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
 <30ad166e2b3d7f10080356ec232e604f3ac9ea2e.camel@codeconstruct.com.au>
 <aXdyll4KVOF6SWni@kuha>
 <6ca4bc87620bb0c2e5bfb264ec88189f32b53757.camel@codeconstruct.com.au>
 <aXjDENOsmWe5_VqS@kuha>
 <189d4a03f32ace3fd995596e8b5415ced6ae9c3a.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <189d4a03f32ace3fd995596e8b5415ced6ae9c3a.camel@codeconstruct.com.au>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254311-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 01CF0A378B
X-Rspamd-Action: no action

Hi Jeremy,

There seems to be another a bit more severe issue with ARP and
i2c-dev. Right now it seems that anything that can access the i2c
character devices can silently (without the kernel having any idea
what's going on) assign a conflicting address to a dynamically
addressed ARP-device. Perhaps more importantly, the user space can
remove access to an ARP-device by silently assigning a new address to
it or simply by resetting its state with Prepare to ARP.

That can happen accidentally, but it can also be done intentionally.

Unless I've missed something, this really is a major threat that we
have to solve. Right now the only idea that I have is that we simply
prevent the i2c-dev from using the SMBus Default Address.

Wed, Jan 28, 2026 at 06:28:24PM +0800, Jeremy Kerr wrote:
> > Uh, no. You should only use interfaces like new_device with the
> > devices that really can't be detected in kernel, which isn't the case
> > here.
> 
> Who is deciding this "you should only" case? If the facility works, it's
> suitable. You raise some good points that may mean it is not a suitable
> approach for an ARP implementation, but we should still make sure we're
> taking the right approach.
> 
> [You seem pretty defensive here? I'm not saying no to the kernel
> implementation, just doing our homework before agreeing to it]

I'm sorry if I sounded arrogant, it was not my intention. We don't
control the user space, so we can not rely on it to enumerate devices
like this. We will not be always even able to wait for user space with
them. The kernel will also still need to be in full control of the
device, also with the ARP protocol, in order to deal with things like
conflicts. So consider for example hotplugged devices that are not
ARP-capable. If the device has a conflicting address with a
dynamically addressed ARP-device, then kernel really has to be able to
assign new address to the ARP-device completely independently.

> > So why would you want involve the user space at all since it would
> > just add complexity and limitations without any benefits?
> 
> Because we have fewer risks implementing this in userspace.
> 
> As an example, you currently seem to have a stack information leak in
> the proposed Get UDID implementation, which would be much less of an
> issue for the equivalent protocol handling implemented in userspace.

If there are bugs in the code then we need to fix them. Can you please
comment to the patch that has the problem?

> > - You still need to deliver the UDID to the kernel because of things
> >   like the PEC flag, and the drivers will also need information from
> >   it.
> 
> That seems like the main reason for requiring a kernel approach, in that
> we need more information than just the assigned address. It's not
> possible (at present) to specify the PEC flag through existing
> interfaces, right?
> 
> For me, this would be the deciding factor to go for a kernel approach,
> in that we otherwise cannot properly describe ARPed devices to the i2c
> subsystem. We *could* push a new_device with a UDID, but I'm not sure
> that's a great idea.
> 
> > - With the static (not hotplugged) devices you need to assign the
> >   correct ACPI node (or what ever fwnode) to the ARP-device.
> 
> Is that possible at present? how are you planning to represent ARPed
> devices in the DT - or more importantly, correlate DT (or other fwnode)
> nodes to discovered devices?

I don't know about DT, but with ACPI the devices are expected to
either be fixed address devices or just use target address that
matches to the address in the I2C Serial Bus Connection Resource
Descriptor. The mapping is not yet done, but the idea is to just
assign the detected UDID to the i2c-client that was already created
from the fwnode.

> > - When the device is hotplugged, you would need new ABI, like I think
> >   you already noticed, but this really does not make any sense. We
> >   simply don't need it, because the kernel can process this
> >   information on its own very simply.
> 
> Even this "very simple" implementation may have bugs.
> 
> Assuming we go with a kernel approach: For the MCTP case, for full ARP
> support of MCTP endpoints, we would still need to consume a hotplug
> event that indicates that the device is available at its new address
> - there is no kernel driver bound for the remote MCTP endpoints. This
> event would be consumed by the (existing) MCTP infrastructure in order
> to start MCTP enumeration. Is this something you have looked at
> already? If so, if you can send an example of an actual event, I will
> look at the mctpd part of this.

We will have the address attribute file that the user space can use.
If the address changes uevent will be send it.

thanks,

-- 
heikki

