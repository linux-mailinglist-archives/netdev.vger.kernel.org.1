Return-Path: <netdev+bounces-262581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL4EIUBXpWlR9wUAu9opvQ
	(envelope-from <netdev+bounces-262581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:24:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FD71D57F7
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFF1B302A2F8
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 09:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B9C38756A;
	Mon,  2 Mar 2026 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HB4PLUD6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D680377546;
	Mon,  2 Mar 2026 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772443171; cv=none; b=ifLv7L9lII53zlCRgHZqpYZy+75+Eo06neUiPTumpjdk6Su02o7zoPMvaQUr+3Mw8dQOXkuNnO0RA+EL6GEPuInbeVbVvx1yUHP9NkIAQGe9lc85oQbExeSrUTg7i4L71tF5OsODCx97p1Dq7RC5Ht66yb4G1wF8wbP26nMCyKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772443171; c=relaxed/simple;
	bh=YM8tNg/Z31mqUp9nCyhNI5i22biy1kDUHa7E9+5pBEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSvzI15Ch6vIPDSVxBqqixz6/OQc/MpAmMKBiNallAmPKvio6RyMZc4IjDRvKoZNmSTkLxPLChdSfmXJYW8QbdQgVd0YPfqT6FkGrF3t+1iEQJ38iR6PN0aZTJhX1p3lF/1yhJF4gBfbRdo72mdTjTX57QfvRx/XST8/mCHUJmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HB4PLUD6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772443170; x=1803979170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YM8tNg/Z31mqUp9nCyhNI5i22biy1kDUHa7E9+5pBEU=;
  b=HB4PLUD6YoEgtzUUI0EQcWF4b/bXC2OqS5Bj5E2dqY1U9WiaJs6gfE0z
   wiMBzN/l3XiHhhfRO7jGmRb2fJZq9tpAgOQOCHopWL9nEPdAi3YPew0Gl
   tMMEu5PKH5os8LCfjFOdgGgZC15U9aZM4anw6hgXW97BsjpgIAFnASHgO
   /aE8c7Caharc8efg1JU6apmba5LgwJa7e9O3OA319OluD01QLRYY04hq4
   VuwySGKZ36zbvH35/NRxsT+KmwoQQ8OuVD5mq7C/QhuD15W6s/9rduSBw
   0gXDbNh54NBBj7aGFF+K0xoBbPxZtWhHaNQidle+pB5yjvMkI5sCCQDXV
   w==;
X-CSE-ConnectionGUID: 3Pamhp9sRpCrOdlBjermXw==
X-CSE-MsgGUID: aBc/v9+sQEKK8AzCNXAagg==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="73314177"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="73314177"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 01:19:30 -0800
X-CSE-ConnectionGUID: jFUXfjS9R22YWTwjdAdCRg==
X-CSE-MsgGUID: lEpMcT/2QaGeea64a/3xUQ==
X-ExtLoop1: 1
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 01:19:27 -0800
Date: Mon, 2 Mar 2026 11:19:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v1 1/1] i40e: Add missing
 header
Message-ID: <aaVWHBraQAE4zHJv@ashevche-desk.local>
References: <20260302090305.2193349-1-andriy.shevchenko@linux.intel.com>
 <a58053f0-9780-4226-87ea-d4cf9bf32383@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a58053f0-9780-4226-87ea-d4cf9bf32383@molgen.mpg.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262581-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,mpg.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8FD71D57F7
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 10:10:52AM +0100, Paul Menzel wrote:
> 
> Thank you for the patch. In the summary/title I’d add the header name.
> Should you resend, maybe:
> 
> i40e: Include missing wordpart.h header

Done in v2!

> Am 02.03.26 um 10:03 schrieb Andy Shevchenko:

> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thanks!

-- 
With Best Regards,
Andy Shevchenko



