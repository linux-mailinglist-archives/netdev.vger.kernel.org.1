Return-Path: <netdev+bounces-282439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMH9F8s48mlGpAEAu9opvQ
	(envelope-from <netdev+bounces-282439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 18:58:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB21E497D76
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 18:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36C62302A07C
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7C7388380;
	Wed, 29 Apr 2026 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K4shjnWq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7623890F3
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777481854; cv=none; b=QgEP+EIfDApATbUg7L4owIExmF2uQp0NVK06LSCf2Uqdj+wTCGGmWmXo5sX3pmlFq4VhTQjgOxFj99SiUrBVmZoInOj57ajf8TphsfjAxJtywUFDsKmE6RzeCGFdxV0yZ5QGshDIegxs80+3RP49ViTCx0ozwyVYcS+EPCqdRX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777481854; c=relaxed/simple;
	bh=ZzZdYuQzicOF7riulmApfgFBX6nMhvpUxcuakE6yjvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKB5nPCB3F6SXkwnn3fnq9Vw93PWSPRcRPZR9x4NRiPA30qvBkzGMmmsBShBlsgzXPtl0OFEpoW/rKX3smT2KZXwqV8dS9kVA5AE2GX2C0VFWGQOUeM7/Pdo2laqXAE6egnxOx+BnwW6oOUU/eM0Xc6bhnSScse07jjOnOT6nJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K4shjnWq; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777481853; x=1809017853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZzZdYuQzicOF7riulmApfgFBX6nMhvpUxcuakE6yjvA=;
  b=K4shjnWqOZOzrw+arRlIFk8pW7+N9v3cF5C1Z0d10PvOaepD7W4OTXqN
   Dbo2XRb0F7CTsn11MuhQr25QxpQ+I9Bn8B94KvU7JrBU4RikyFTUDwjQL
   DZFxcvLXIyLqj1XsnmDlUQV6arxpXpUMnSa7gu7GG4eENP+IrQvWbUYra
   gsijdHCJs1GF+Nc4CS0YQ60Z3Pf2Qfvsx4ZLKyIC/7YoxzkpcjybEM75N
   nW45J+VTBkIEWE07H8PSqLSjsLt5aBRVAN2Fd97E5WD/L9jWczYwwGxpr
   rfQINl/RGZ2THl536R0V87Sd+b/Hw824qt1DcpSsYkKIYxD/YBF40BV2W
   Q==;
X-CSE-ConnectionGUID: F1A/ysbETC+hFCQv8lDEow==
X-CSE-MsgGUID: moKEVuPOS62Itj2gB5iDbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78437257"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78437257"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 09:57:32 -0700
X-CSE-ConnectionGUID: wTxOLz3PSC2oVUD5QSRT8A==
X-CSE-MsgGUID: I44Jrqw/T0iGF9jaP9WTFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="236090927"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 29 Apr 2026 09:57:30 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 40EFB98; Wed, 29 Apr 2026 18:57:29 +0200 (CEST)
Date: Wed, 29 Apr 2026 18:57:29 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	YehezkelShB@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH 1/2] net: thunderbolt: Call tbnet_stop() upon shutdown
Message-ID: <20260429165729.GC557136@black.igk.intel.com>
References: <20260427081623.2338179-1-mika.westerberg@linux.intel.com>
 <20260429011224.1505785-1-kuba@kernel.org>
 <20260429053046.GZ557136@black.igk.intel.com>
 <8a52ab2d-9cfa-4478-bbda-c910c2b0f726@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8a52ab2d-9cfa-4478-bbda-c910c2b0f726@lunn.ch>
X-Rspamd-Queue-Id: DB21E497D76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-282439-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]

On Wed, Apr 29, 2026 at 03:31:43PM +0200, Andrew Lunn wrote:
> On Wed, Apr 29, 2026 at 07:30:46AM +0200, Mika Westerberg wrote:
> > On Tue, Apr 28, 2026 at 06:12:24PM -0700, Jakub Kicinski wrote:
> > > This is an AI-generated review of your patch. The human sending this
> > > email has considered the AI review valid, or at least plausible.
> > > ---
> > > net: thunderbolt: Call tbnet_stop() upon shutdown
> > >     
> > > This commit updates the shutdown callback for the Thunderbolt network service
> > > driver to call tbnet_stop() if the interface is running. This ensures the
> > > service drivers release the rings upon shutdown.
> > > 
> > > > diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> > > > index 7aae5d915a1e..631af237998d 100644
> > > > --- a/drivers/net/thunderbolt/main.c
> > > > +++ b/drivers/net/thunderbolt/main.c
> > > > @@ -1417,7 +1417,10 @@ static void tbnet_remove(struct tb_service *svc)
> > > >  
> > > >  static void tbnet_shutdown(struct tb_service *svc)
> > > >  {
> > > > -	tbnet_tear_down(tb_service_get_drvdata(svc), true);
> > > > +	struct tbnet *net = tb_service_get_drvdata(svc);
> > > > +
> > > > +	if (netif_running(net->dev))
> > > > +		tbnet_stop(net->dev);
> > > 
> > > Does calling tbnet_stop() directly bypass the network stack teardown sequence?
> > 
> > This is called when the machine is rebooted or shut down to quiesce the
> > device. I don't think the network stack has anything similar?
> 
> You mean that network interfaces are left running while the machine
> reboots, potentially DMAing receive packets over the bootloader or
> freshly loaded kernel? Does that seem reasonable? 

Hey! 20+ years ago I spent quite amount of time to investigate an issue
exactly like that where ramdisk randomly corrupted. Not fun.

> Don't you think the core will somehow call the .close function? I cannot
> point to the code doing that without a bit if searching, but i think it
> probably exists.

If I do 'reboot -f' .ndo_stop (I think that's what you mean by .close) is
not called.

If I do just 'reboot' it is called. I suspect based on my added WARN_ON()
that it is done by userspace shutdown scripts.

