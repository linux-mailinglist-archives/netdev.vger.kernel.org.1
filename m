Return-Path: <netdev+bounces-283854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FE0qIfmj+GmxxQIAu9opvQ
	(envelope-from <netdev+bounces-283854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 15:49:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B82364BE071
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 15:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D75D300F153
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 13:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685133A7F4D;
	Mon,  4 May 2026 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqyfKn69"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF1875801;
	Mon,  4 May 2026 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902582; cv=none; b=m7jzH5kzrmOe9EbiC6237//9h6V6VaFGfwrXeXi17O95uCSz013AoPZk+r35FYKWw0ESwmC2BeC/JYqSTAjbtucWu43gO1+UcrxoeZkJg+sSswoh4fykfYEH7ZB8Hc2DbVe246aQSZCw7Swpsg0sADlJ6FVAB45reRnGDagq5j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902582; c=relaxed/simple;
	bh=h5lfvYvHa5iWOQPsUWB1WBL92XJ3T6z1qD8PRCx+S8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fi6z/K75yh9WOHqB7665ym4lw5fwal+w5TyKsw4hxAZI8HB5XzNcrR5sv4SUU8bkOFCI+TDhDHi9ZkNic5Us/bRPiHDGdvXFJCr94UjXsACWHuSWWEaRDWmxobhVOLHqZ6tO5hhF1woVhuRyHntbSU0GRKEYgNU1lhICfuchxEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqyfKn69; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777902581; x=1809438581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h5lfvYvHa5iWOQPsUWB1WBL92XJ3T6z1qD8PRCx+S8I=;
  b=ZqyfKn69MWwiklCGgDpkPJ81qw5ZsozCcAFcFwh8elXXqbqzE0x6LJ1D
   piXKjL0mnGCXhkwjwHh/ziJ+CeWNYNwwKtDEThiqVxsxJdnUGRW7+0+NJ
   jNXxvCtO2MxlPskL6ewjikeGYHfPgztif+L/JLomZ5Kms2zy76bJ/GFdt
   I68d7POOmqwX50rYj8izb2Q1nLU9Eo2+OdwaIywwyr5RxWQ7SPcpuVMfB
   3HcS+eJNXNWOfQYZDbc2rbLTl1alY1IrzVy6gw2+fDJilCD08FezmsJhe
   pJ9tt5SHkRMySnCCp7r/Jh8z6VGZWrB0NhSA7XB2J03/GlHKujboVa1lr
   Q==;
X-CSE-ConnectionGUID: l1T5EjRoSnSPeTfUdri4YA==
X-CSE-MsgGUID: OlihfM/VTvis8jyqfrOIXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78749395"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78749395"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 06:49:40 -0700
X-CSE-ConnectionGUID: Euih8xszTKWo0A0m8bQpYg==
X-CSE-MsgGUID: z/pht/E/R3WlwnRBe9e2IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="234494643"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.198])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 06:49:38 -0700
Date: Mon, 4 May 2026 16:49:35 +0300
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
Message-ID: <afij7wOkQUGUN0kM@ashevche-desk.local>
References: <20260504074610.40799-1-andriy.shevchenko@linux.intel.com>
 <aee27459-387c-46ce-9c06-3de66309c8d6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aee27459-387c-46ce-9c06-3de66309c8d6@lunn.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: B82364BE071
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-283854-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,ashevche-desk.local:mid]

On Mon, May 04, 2026 at 03:02:54PM +0200, Andrew Lunn wrote:
> On Mon, May 04, 2026 at 09:29:51AM +0200, Andy Shevchenko wrote:
> > This mini-series is dedicated to hiding ACPI implementation details
> > from the wider users as they (as of today) do not need to know that.
> 
> Please could you expand on that. ACPI != OF. They have different
> bindings, so you need different implementations.

As of today the users that want ACPI also have the OF support. Even without
that if the device is pure ACPI supported one (and somehow never going to DT)
the proposed API (see the first patch) will be no-op in case when CONFIG_ACPI=n
or when it's a non-ACPI platform with no support of the device. Hence, the
pure ACPI (and actually OF as well) do not need to be exposed. The decision is
made based on the type of firmware node.

-- 
With Best Regards,
Andy Shevchenko



