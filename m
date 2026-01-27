Return-Path: <netdev+bounces-253734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAASCvRoeGkopwEAu9opvQ
	(envelope-from <netdev+bounces-253734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:27:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 405CE90BA1
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A5B03031B0D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658E9326D4D;
	Tue, 27 Jan 2026 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JepuUEF3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E643C25D1E9;
	Tue, 27 Jan 2026 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769498863; cv=none; b=OzP7XrMyVIooEmBjqkhNn+Xo6PVRqD9ZA1bFLbq6ZqutjTF9luzeZbB5zlRmXp/o8rMFg5CFEjtxc67WucJeVlAgRtHS+ziwtzsfZsEAfairtqnzbtiFkAU03n8w0j1EfE8EEIkDkSN+E/TpSInhN+iXcuxO5Eh9JJBYM86YZrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769498863; c=relaxed/simple;
	bh=w26CVxumWvLmQH1eL3SSR2Q79MSI1rZOjjpcVGD0jTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvQD121jWi6PhjA5zzpn9SqkuLYDd0GgXAS38vkVtJunsTHbRYFNwwKtL42QSC7zgBU3Al5qnNkuXEEs57bRZYVwlsjVmfKGJW0DC09fBFDlTqMOD3Km8sIn05gxwYLWrWnZ/vp3VdxIl1RGEvC6AUqxTZ5AMOobwqZhJbf3Pko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JepuUEF3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769498863; x=1801034863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w26CVxumWvLmQH1eL3SSR2Q79MSI1rZOjjpcVGD0jTk=;
  b=JepuUEF3QzuY80ePwBCnANe9OvKKOmDIGsbaOPtGpnSPuPify22IOh5Q
   vl1Osc+m4gbWDuZrjQdz4c8ubSrLJSDGznyfcyMKIkwR7sKBIyvetyqmn
   jo6ShUNx9vVTUjX7XCfmQcIAc7laJPlu8KoYeIn98sdXzPBOXSuTfTmSL
   Nil+9UW3396cZERFS4ba9kHta+jXcQL5+BvojOGItOixNti15lDLAzuak
   5yRiv8E+L1GQw5RLk41qQAATqVtowXgps5Y/uRJkX5w3QPArcSnPrWqjC
   JLgD04cFwfoJ/i6+Y1xe17j8rd5kVpB/5mDh+9+eouSvswFbaOaCXrShU
   g==;
X-CSE-ConnectionGUID: qXVI0HS/QjuBYG4zFtx2NA==
X-CSE-MsgGUID: KEACBC2qRxW1uK1/JPvFMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70728242"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="70728242"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 23:27:42 -0800
X-CSE-ConnectionGUID: UQ9jyd1BQsusAeiGIqBxKw==
X-CSE-MsgGUID: 47IAGrLGTtqbubLNVc14vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="208146706"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 23:27:32 -0800
Date: Tue, 27 Jan 2026 09:27:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	UNGLinuxDriver@microchip.com, Petko Manolov <petkan@nucleusys.com>,
	Oliver Neukum <oneukum@suse.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Foster Snowhill <forst@pen.gy>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH net-next] net: usb: switch to two-argument strscpy
Message-ID: <aXho4UtIhBn4Rb9c@smile.fi.intel.com>
References: <20260126035052.31216-1-enelsonmoore@gmail.com>
 <aXc89lDpfHQFVX-7@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXc89lDpfHQFVX-7@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,nucleusys.com,suse.com,fintech.ru,piap.pl,gmail.com,pen.gy];
	TAGGED_FROM(0.00)[bounces-253734-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 405CE90BA1
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 12:07:57PM +0200, Andy Shevchenko wrote:
> On Sun, Jan 25, 2026 at 07:50:15PM -0800, Ethan Nelson-Moore wrote:
> > All instances of strscpy in the USB network drivers use the size of the
> > destination. If given only two arguments, strscpy will automatically
> > use the size of the destination. Make the code more concise by
> > switching to the two-argument form of strscpy.
> > 
> > Also add a blank line after a variable declaration in catc.c to adhere
> > to kernel code style, since the surrounding code is being touched.
> 
> It should go after your patch that drops some of the strscpy():s.
> Hence make a v3 as a series of two patches.

FWIW, your v3 missed this patch... What's your plan with it?

-- 
With Best Regards,
Andy Shevchenko



