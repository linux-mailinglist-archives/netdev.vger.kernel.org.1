Return-Path: <netdev+bounces-265626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGAVISbyrmnZKgIAu9opvQ
	(envelope-from <netdev+bounces-265626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:15:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4D423C902
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53E15303EB83
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 16:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C453D669D;
	Mon,  9 Mar 2026 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcZ9WbkQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6763E5EED;
	Mon,  9 Mar 2026 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072818; cv=none; b=eu2j+Meea4FQhP304bCEeDatPr43kSDKDtNbIVB5qSA15VmF+eMF/ZIiHG5yuhxAVxAVD/b2o7VjJU2YXv4L2NuKk/1tLfRQo/H4dTzd16UeGpV5TlF5WLEGxi1Rm7Lx343xpSuOTP32s0S4UIKjj4IItXKGqEwT6jjYDELVNEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072818; c=relaxed/simple;
	bh=vkXbPMABoqin4Xj7FN7xR9mSU62rBEDTwcvdOzhLT3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9ERdyQnmvVfxEEwXWRFNwbjp6XjcMtSLX+qmRkDt75oeMhGg18gN833VW0dt4Tpk1BJTl+P51hW4ZllDQdvpRXFBTy4IqgTQMsytEgWMKwDX6IXieZuDxNuJSH8SSk6B8wvHgztWPIPr0I1Zx+dnPBMnTZBTxl5dIY2+rZ0E/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcZ9WbkQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773072813; x=1804608813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vkXbPMABoqin4Xj7FN7xR9mSU62rBEDTwcvdOzhLT3s=;
  b=gcZ9WbkQtPYgXByzfaw70FRmzwhS4DWGUbIkHaHTvP4pE77SJuD1V4/L
   d3fAq2IzSQHlZFYDWOMKgHUxXIMUhQOk3MW1rgH+dhcqa8M/HkFqQBVpr
   vgPDigsUWjz7bqpv2Ojb76Cua/l7A4Adyn5KjGqPb13wLHZL7i4cMMBX+
   dzx9eh53kodNUk7JtRezF6TzxebZillis12TYK0CYfq+bmPSv0ZJ5n2Ze
   VKTKFBnakyCJ+AnhD44fmkP04Q/nGL7m7/nwWbQ91grFNZ9Qd23TFZrpZ
   HBc5SGC01HbylN1c7ktUivSnxhf4uXA+mSvqm1df7u6IzYHlzRRYaqOdp
   w==;
X-CSE-ConnectionGUID: rWOyaJnUR2OsrRfZHzsZww==
X-CSE-MsgGUID: zEQA4ZZRRHmFyrs2eyaQAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="84429300"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="84429300"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 09:13:32 -0700
X-CSE-ConnectionGUID: mEmOaK6mR6GoAlY+7tTfFg==
X-CSE-MsgGUID: 1R1Ncd4LSLeZ+ab+ivsKRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="219738644"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 09:13:29 -0700
Date: Mon, 9 Mar 2026 18:13:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Brian Masney <bmasney@redhat.com>
Subject: Re: [PATCH v4 1/1] clk: baikal-t1: Remove not-going-to-be-supported
 code for Baikal SoC
Message-ID: <aa7xpZhZ440x8Kmt@ashevche-desk.local>
References: <20260224111821.3491352-1-andriy.shevchenko@linux.intel.com>
 <2b9b5702-1b30-415f-b734-8af9d1aef27c@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b9b5702-1b30-415f-b734-8af9d1aef27c@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: EC4D423C902
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,baylibre.com,kernel.org,gmail.com,pengutronix.de,redhat.com];
	TAGGED_FROM(0.00)[bounces-265626-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,infradead.org:email,ashevche-desk.local:mid]
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 11:08:07AM -0800, Randy Dunlap wrote:
> On 2/24/26 3:17 AM, Andy Shevchenko wrote:
> > As noticed in the discussion [1] the Baikal SoC and platforms
> > are not going to be finalized, hence remove stale code.

> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks!

Stephen, can we get this being applied?

-- 
With Best Regards,
Andy Shevchenko



