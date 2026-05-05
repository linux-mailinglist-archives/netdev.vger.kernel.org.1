Return-Path: <netdev+bounces-284202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMuqMg54+WnV8wIAu9opvQ
	(envelope-from <netdev+bounces-284202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 06:54:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FFE4C6965
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 06:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 218C0301CFE1
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 04:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B323B9DA9;
	Tue,  5 May 2026 04:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gY4ssn3Z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B3D3B38BD;
	Tue,  5 May 2026 04:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777956874; cv=none; b=p18GyeHOnBv6LYXJgOJdh3uHUUXej1XaQnRk2dlVSGYKsnTe7R9keQKy0F7S637+QZ8NaGzjIXJDZH+UNi0gxNr0AA/r0hLXSqwhWs5YBCA866P6YDhBx4PXuk4ZZxrI/HKd+23bcARtVnkhuwqnZbKnYMM2xrb0v2HjL4BZr2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777956874; c=relaxed/simple;
	bh=haGfBtENmV6eMb2MDh7r4FacDapZcB1kOYJ0JXEc/T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONWLFcEXjXRe2nkldu6In03vecLn/aOSr6TMQhMaYsnVXtbV6y2Hy5fqZwqzubLIx5SuoyJiE6WY9dM6bbXcQRfJupw7vCV7Y42Om2oyMPUJM04CCWLYAPPI7OFf3yQFE0kMb5VS0EOHVYxh2V9MSSEpQP7Z0E+XKwxcTxQreOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gY4ssn3Z; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777956873; x=1809492873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=haGfBtENmV6eMb2MDh7r4FacDapZcB1kOYJ0JXEc/T0=;
  b=gY4ssn3Z8J+99dIKHCt3SGuoswykZe9LnFgBPl1WXM6Z3QK192k/KeuE
   9bTtRKRFGClGLmUsHOmDaZAZIpsoY+xb1iRTR4kr10vbWUFpcZvQJkT/S
   Z1TpQJl65F2qDhzCAvRusKqaMqi+T1/14FXFUps/xjY0QHW4UcwtoVl9t
   24GEJP4ZMFBMU1LLLCCNSXw6jL/JOPz8BMsT3uv/P0vOXYACEoEY8XS45
   LwSKh0CitNzLb9hODsDJk+KB8jpPPmnLZn2beYw6Woq5oJ9hntqZaw9TQ
   ZxNNu7XQTt9B8rkZsM/vjn4aLshLL4xQLDIR4SOss7DFHCjEAp5rnwhtA
   g==;
X-CSE-ConnectionGUID: PjoD6E8uRtW+wyYkC6fkqw==
X-CSE-MsgGUID: UmvSDB8hTYOASVmrT7dHZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78811204"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="78811204"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 21:54:33 -0700
X-CSE-ConnectionGUID: Vqp4Pl8nRO6OlvbL2x0gwg==
X-CSE-MsgGUID: CZ9rPXnqRk6R00egKJMMGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="273829281"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 21:54:29 -0700
Date: Tue, 5 May 2026 07:54:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v1 0/5] net: mdiobus: HIde ACPI implementation
Message-ID: <afl4A48uIZPJmMeG@ashevche-desk.local>
References: <20260504074610.40799-1-andriy.shevchenko@linux.intel.com>
 <aee27459-387c-46ce-9c06-3de66309c8d6@lunn.ch>
 <afij7wOkQUGUN0kM@ashevche-desk.local>
 <28a4ebd7-2670-439d-836b-14559a916ed0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28a4ebd7-2670-439d-836b-14559a916ed0@lunn.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 41FFE4C6965
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-284202-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ashevche-desk.local:mid]

On Mon, May 04, 2026 at 05:16:57PM +0200, Andrew Lunn wrote:
> On Mon, May 04, 2026 at 04:49:35PM +0300, Andy Shevchenko wrote:
> > On Mon, May 04, 2026 at 03:02:54PM +0200, Andrew Lunn wrote:
> > > On Mon, May 04, 2026 at 09:29:51AM +0200, Andy Shevchenko wrote:
> > > > This mini-series is dedicated to hiding ACPI implementation details
> > > > from the wider users as they (as of today) do not need to know that.
> > > 
> > > Please could you expand on that. ACPI != OF. They have different
> > > bindings, so you need different implementations.
> > 
> > As of today the users that want ACPI also have the OF support. Even without
> > that if the device is pure ACPI supported one (and somehow never going to DT)
> > the proposed API (see the first patch) will be no-op in case when CONFIG_ACPI=n
> > or when it's a non-ACPI platform with no support of the device. Hence, the
> > pure ACPI (and actually OF as well) do not need to be exposed. The decision is
> > made based on the type of firmware node.
> 
> I see two different things here:
> 
> You are refactoring code into a helper, so reducing the amount of
> duplicated code. That in itself is good.
> 
> However, we have the problem in general that developers think that OF
> and ACPI do the same thing. And that is not true. OF MDIO busses have
> support for a GPIO used as a reset. In retrospect, that was a bad
> idea. The documented ACPI binding does not have this, and if anybody
> was to suggest adding it, i want to NACK it.
> 
> Having OF code and ACPI code to instantiate the MDIO bus makes it
> clearer they are different things. fwnode gives the impression they
> are the same, which is not true. Hence i don't like fwnode at this
> level.
> 
> Where fwnode makes sense is deeper down in the implementation of the
> bindings, for properties which are the same in both bindings.  Then
> you can use fwnode_ for the shared properties, of_ for the OF only
> properties, and acpi_ for the ACPI only properties.
> 
> So although i like the reduction in duplicated code, i think overall
> it makes the code worse because developers are more likely to wrongly
> understand it.

OK.
Thanks for review.

-- 
With Best Regards,
Andy Shevchenko



