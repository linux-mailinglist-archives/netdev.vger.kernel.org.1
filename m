Return-Path: <netdev+bounces-263068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCWLCamVpmnmRQAAu9opvQ
	(envelope-from <netdev+bounces-263068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 09:02:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF291EA805
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 09:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2897B30387CB
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 08:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43810386C08;
	Tue,  3 Mar 2026 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0fg4x5d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8FE375ADC
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772524965; cv=none; b=QSvIvQCivIDrg4btBqNWEc7BjjHYvC/1Zyp1JHcZXk6bD1Yt15j+q4kWAIoN4efYDJzdJur8vrqXamp78cgaolgpu+QcVRa9b4rlyqDxY88TSYVh3hgF0w5xsl8o7+dOb13I86YbLy7DtAw3HgvAA96qdf75hCDMcMKWVOxkchY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772524965; c=relaxed/simple;
	bh=jhRlGfBhb489U8ltCUEQB1pbYFEqF9EJuEmdtzSaZLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5Q7z6wAtjCbbDkvI3WqjTbjhQZ54WxUmnqb6XhTafqOgCVcs10J8WAFLVcsr+Q95tDRm+JbaMYoOi9lBqzY7yJvf8CXoZWdLsXr5txSp7Xo30l3E/TBAgHj+MM46JoclFKMLDuRXUSDZQ+7YK4+4qUm/ul4CnXzhb8b6APZfwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0fg4x5d; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772524964; x=1804060964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jhRlGfBhb489U8ltCUEQB1pbYFEqF9EJuEmdtzSaZLc=;
  b=j0fg4x5dIw/mpKESjuq5u4qCSuZ3oqnCDzk2c9sQp30aQQZheL8K6I8k
   zRln229xYzZrlL8iNzGdQKHHYpwbcNx63qE4+RS6oAIbGwL8Md4tHDLuu
   gD/xaVkp0DQT1DhH6FBoRQ7zdJiJwT7kNe4nVino3KRjRpuw9+QGS7uV5
   D0L+02lRfBm4QEj6uV9lrFHYZ83ChMOEqE6mZCedkj5fM5RE+3LhWik/Q
   sYZHOIP0CwzQwNSYgDUlkNUdMxPzUhuqEVstiMXyXTuz/93v0EAQU8Rpc
   VaE40Ubpmt1WFDAfYTKXcsOh2EKkISE8M+VZRakjpfBkICQP5afex/oKz
   Q==;
X-CSE-ConnectionGUID: FVpY8wEpTfGbRfwjl5yb7A==
X-CSE-MsgGUID: N9Ddo6mRRiyBkra/xsYhpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="90948395"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="90948395"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 00:02:43 -0800
X-CSE-ConnectionGUID: fLrkU2CHRky8S1ml9zMRag==
X-CSE-MsgGUID: 1ZrI5mT2SqChC88s7QAIyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="218030943"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 00:02:41 -0800
Date: Tue, 3 Mar 2026 10:02:38 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next 3/4] i40e: Add missing header
Message-ID: <aaaVnmx_QHcpiVbG@ashevche-desk.local>
References: <20260302234105.2658400-1-anthony.l.nguyen@intel.com>
 <20260302234105.2658400-4-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302234105.2658400-4-anthony.l.nguyen@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 0BF291EA805
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263068-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ashevche-desk.local:mid,intel.com:dkim]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 03:41:01PM -0800, Tony Nguyen wrote:

> When cleaning up another header I have met this build error:
> 
> drivers/net/ethernet/intel/i40e/i40e_hmc.h:105:22: error: implicit declaration of function 'upper_32_bits' [-Wimplicit-function-declaration]
>   105 |         val1 = (u32)(upper_32_bits(pa));                                \
> 
> This is due to missing header, add it to fix the possible issue.

There was a v2 with the other (missing here) tag is added (it was given against
v1 conditionally) and Subject amendeded.

-- 
With Best Regards,
Andy Shevchenko



