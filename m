Return-Path: <netdev+bounces-255867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNWHM+yngGlNAAMAu9opvQ
	(envelope-from <netdev+bounces-255867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 14:34:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DC0CCC6D
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 14:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CFBC3038511
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 13:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD5E367F48;
	Mon,  2 Feb 2026 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/0KRZek"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BA3367F3A;
	Mon,  2 Feb 2026 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770039000; cv=none; b=DrLoNia1q0P/s7Lt3gRAi2pEhfFvzx/XZl47TU+FUTkSnYF363TLbyfZGRJn4RKFGrzRF5UmCc0T7moVljHIxySCR1a854cK1XokhdYNroITLcLEdfMG41zluw7YT146zE/D6OxZlbA6HXDma3Hj0kqYxOwnPLrnJYNiVIWlMvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770039000; c=relaxed/simple;
	bh=Po4XURyEzCW8smpz/DmF0VKvnXajycyLgM7X+skVhFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZROhbA065oE+F6QMuCTe0yIYZqhrJ/nUG+7ItuS9QGdbEycx6smsZqUgjlfmxb62R+sBzzE+8IaaCnZqoC3FQJCpFbgzwuisGAXj4D9iL/QqY0Wn+BUegB+MP4hA8hFMnGd4vIbGgzi5LWvHzIvRerTib3KHwjaVC4ITs3WF2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/0KRZek; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770038998; x=1801574998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Po4XURyEzCW8smpz/DmF0VKvnXajycyLgM7X+skVhFU=;
  b=U/0KRZekQNjIenTlHjmSICTXHvakT6d2/JcvnXkVA3wtdEP2z1GYL7Lc
   UCFjJ1DdgtwgRKTalSuSSL65rLYUrtQqnPl9JVfuAGurGjwuv1jLOKqQg
   aOPWH0CvERrlTTwM5WAa0rSA7O8uXX4u8ymDEe7ClUn+yZYmaeg13r6aq
   9kx2bJ9/JrI2GTegNj1Ss0VyWHy6ckEqtPNbqCpwKzpP4BQFNV78bZTtP
   +UfELfjt401S8AntAsr0WzBlMw7A9/lzBmnp0IgNHpOwkmDnFTz15gsro
   qlC71dkjrvF60twcjWCq9fXhJx5qyNLMz3PUVf2Sq99qh6DgsnZe4U9RD
   w==;
X-CSE-ConnectionGUID: Xykm/tHeTX6aojYrTLWWHA==
X-CSE-MsgGUID: +PuUh3KnRRKWjY/WFmWZKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="58775899"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="58775899"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 05:29:58 -0800
X-CSE-ConnectionGUID: ZYPY+pYURVuRlB3Zf8gDvQ==
X-CSE-MsgGUID: 90mJWH+vQrC4SbdR7ZitkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="232445658"
Received: from vverma7-mobl3.amr.corp.intel.com (HELO kuha) ([10.124.221.53])
  by fmviesa002.fm.intel.com with SMTP; 02 Feb 2026 05:29:55 -0800
Received: by kuha (sSMTP sendmail emulation); Mon, 02 Feb 2026 15:29:27 +0200
Date: Mon, 2 Feb 2026 15:29:27 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Matt Johnston <matt@codeconstruct.com.au>,
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] i2c: SMBus ARP support
Message-ID: <aYCmt6Jnn9uieXwy@kuha>
References: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
 <30ad166e2b3d7f10080356ec232e604f3ac9ea2e.camel@codeconstruct.com.au>
 <aXdyll4KVOF6SWni@kuha>
 <6ca4bc87620bb0c2e5bfb264ec88189f32b53757.camel@codeconstruct.com.au>
 <aXjDENOsmWe5_VqS@kuha>
 <189d4a03f32ace3fd995596e8b5415ced6ae9c3a.camel@codeconstruct.com.au>
 <aXokxtlFTeZK8lP8@kuha>
 <547a1a5fd7238897b35b26e83ac27db452e6a5f7.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <547a1a5fd7238897b35b26e83ac27db452e6a5f7.camel@codeconstruct.com.au>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255867-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 31DC0CCC6D
X-Rspamd-Action: no action

Hi,

> > There seems to be another a bit more severe issue with ARP and
> > i2c-dev. Right now it seems that anything that can access the i2c
> > character devices can silently (without the kernel having any idea
> > what's going on) assign a conflicting address to a dynamically
> > addressed ARP-device. Perhaps more importantly, the user space can
> > remove access to an ARP-device by silently assigning a new address to
> > it or simply by resetting its state with Prepare to ARP.
> > 
> > That can happen accidentally, but it can also be done intentionally.
> > 
> > Unless I've missed something, this really is a major threat that we
> > have to solve. Right now the only idea that I have is that we simply
> > prevent the i2c-dev from using the SMBus Default Address.
> 
> I don't necessarily see this as an issue; access to the chardev somewhat
> implies full access to the i2c bus, and so arbitrary interactions with
> devices to alter device states. Including the i2c address as part of the
> affected state doesn't seem like a huge difference in access.
> 
> There may be a specific case that is interesting though:
> 
>  - an ARP-able device is in use by a kernel driver, which excludes
>    access through the chardev
> 
>  - interactions with that device are possible using ARP commands to
>    address 0x61 over the chardev
> 
>  - so, the device may be re-addressed, now allowing accesses through
>    the chardev
> 
> However, I am not sure there are existing cases where access to the
> chardev is a distinct privilege domain to not just unbind the driver
> anyway.

Thanks for the answer. I don't think this is necessarily a major
problem either, but since it was raiced (internally) I had to make a
note. Let's not worry about this for now.

> I would have a few requests:
> 
>  - that ARP is enabled explicitly. I'd be interested in having a DT
>    property on the controller node that allows us to enable ARP on a
>    per-bus basis.
> 
>    Otherwise, I'm pretty sure we'll break someone's existing platform
>    by assuming we can start interactions on the SMBus default address.
> 
>    Is there some equivalent facility for ACPI based config?

With ACPI systems, we just don't know what the platform is going to be
used for in the end. This is a bit tricky with ACPI.

But I'll make the registration of the feature conditional somehow in
any case.

> > > Is that possible at present? how are you planning to represent ARPed
> > > devices in the DT - or more importantly, correlate DT (or other fwnode)
> > > nodes to discovered devices?
> > 
> > I don't know about DT, but with ACPI the devices are expected to
> > either be fixed address devices or just use target address that
> > matches to the address in the I2C Serial Bus Connection Resource
> > Descriptor. The mapping is not yet done, but the idea is to just
> > assign the detected UDID to the i2c-client that was already created
> > from the fwnode.
> 
> OK, but how do you map the UDID to the resource descriptor? I don't know
> much about ACPI, but the descriptor seems to be only keyed on a target
> address, which is now dynamic.
> 
> (same with DT, devices are keyed by target address)

I don't know how a dynamically addressed device, that does not return
any kind of target address with the UDID, could be mapped to the
fwnode.

> > > Assuming we go with a kernel approach: For the MCTP case, for full ARP
> > > support of MCTP endpoints, we would still need to consume a hotplug
> > > event that indicates that the device is available at its new address
> > > - there is no kernel driver bound for the remote MCTP endpoints. This
> > > event would be consumed by the (existing) MCTP infrastructure in order
> > > to start MCTP enumeration. Is this something you have looked at
> > > already? If so, if you can send an example of an actual event, I will
> > > look at the mctpd part of this.
> > 
> > We will have the address attribute file that the user space can use.
> > If the address changes uevent will be send it.
> 
> Sounds good, but for MCTP there is no struct device bound to the remote
> i2c device/address. Are you proposing we change that?

I'm sorry, I'm probable missing something here. If the address gets
changed, then you have to inform the remote endpoint about the new
address somehow in any case, right? So how did you do that with the
user space approach?

Br,

-- 
heikki

