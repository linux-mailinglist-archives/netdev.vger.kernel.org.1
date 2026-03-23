Return-Path: <netdev+bounces-270800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBXyCODEwWlTWQQAu9opvQ
	(envelope-from <netdev+bounces-270800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:55:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9195E2FE9F5
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85CCF301AA90
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8A6383C91;
	Mon, 23 Mar 2026 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nmw1buHL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A19736DA1A;
	Mon, 23 Mar 2026 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774306525; cv=none; b=qMAw9PtSKVnrghaReT/uNmFe/FGIafbPReIPGOpCrJeA+zcr92cvyyf9lDIJakdZwWpw0SpytGT01qU950iHWGXuNvSjTMNdUfOn19bA8Nr/69td1mRBzSSrHZxp/XGJXRmAEHz6c+PSOExis7Sv4oa6MSjbUF+TEJSHrwpm7Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774306525; c=relaxed/simple;
	bh=obUpamcW4SXV1lZNedXwbRTWMDTBANY2dB2b8QgkLJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HokbIUG5TO4P9rwu3okhuUna+ajGyWvPNTNGlthguUbzYzv9Napz6yym0HbaM/kLOX/FrFaRUqCFzB2SiKUtHEEeCMGJiuMZ2GmDsiT6Q+mkYMwvU4wAms692VsLVJVHQy8Lor0gECRLmuSxXvcj5Tmr1oZB03nIg9YpI7Pazns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nmw1buHL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774306524; x=1805842524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=obUpamcW4SXV1lZNedXwbRTWMDTBANY2dB2b8QgkLJU=;
  b=Nmw1buHLVPC1Ks++670Vu+MuKDtQvIiwkFNbeKc6ooWbzSLso3G8Vb5Q
   Z1+mxNwXY8CJyjXPpXCtsT6RpnZmwyUCU1w9bged7w5FjAw7R1XKnb8p0
   x0C/YAG5oT1v5NSa3+hzG5PV+yFNv7JejXzlJmni50FO06CA1bzQ50I1G
   u1nZ9uQSD4+huk5T6Ex116TjaGqo/w0bJkZZs9LkjcQpc/pv+qSVUPWbk
   fzvWHAuZggZ5hy7SGIzcohAfk6NTgRRnkC+7p6tVJG0ccq3K1X/hHfRX4
   DcE+ikAg3n7BESB+YC4RctfDhP6ClPTVKHjXdCpfJq+WyTyfur6qR2b0+
   A==;
X-CSE-ConnectionGUID: qhpSFG21Q8q+G9TMz7U2nA==
X-CSE-MsgGUID: By3/0100Qe+xDjPKXopv7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75200036"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75200036"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 15:55:24 -0700
X-CSE-ConnectionGUID: rwro3G/aSRygcqgDcCEPkQ==
X-CSE-MsgGUID: ZTQtoYOrRMipHeEYtZ4Geg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="228902325"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 23 Mar 2026 15:55:20 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4oB3-000000003MX-1jgX;
	Mon, 23 Mar 2026 22:55:17 +0000
Date: Tue, 24 Mar 2026 06:55:04 +0800
From: kernel test robot <lkp@intel.com>
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	John Johansen <john.johansen@canonical.com>,
	Simon Horman <horms@kernel.org>, apparmor@lists.ubuntu.com,
	stable@kernel.org
Subject: Re: [PATCH net v2 04/10] list: Move on_list_rcu() to list.h and add
 on_list() also
Message-ID: <202603240650.DP6vwmk9-lkp@intel.com>
References: <20260323150505.3513839-5-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323150505.3513839-5-dhowells@redhat.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270800-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 9195E2FE9F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Howells/rxrpc-Fix-key-quota-calculation-for-multitoken-keys/20260323-234846
base:   net/main
patch link:    https://lore.kernel.org/r/20260323150505.3513839-5-dhowells%40redhat.com
patch subject: [PATCH net v2 04/10] list: Move on_list_rcu() to list.h and add on_list() also
config: arc-randconfig-r071-20260324 (https://download.01.org/0day-ci/archive/20260324/202603240650.DP6vwmk9-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 10.5.0
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260324/202603240650.DP6vwmk9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603240650.DP6vwmk9-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/dwc2/gadget.c:4313:13: error: conflicting types for 'on_list'
    4313 | static bool on_list(struct dwc2_hsotg_ep *ep, struct dwc2_hsotg_req *test)
         |             ^~~~~~~
   In file included from include/linux/module.h:12,
                    from drivers/usb/dwc2/gadget.c:15:
   include/linux/list.h:392:20: note: previous definition of 'on_list' was here
     392 | static inline bool on_list(const struct list_head *entry)
         |                    ^~~~~~~


vim +/on_list +4313 drivers/usb/dwc2/gadget.c

4fe4f9fecc3695 drivers/usb/dwc2/gadget.c      Minas Harutyunyan 2018-12-10  4307  
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks         2009-06-02  4308  /**
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks         2009-06-02  4309   * on_list - check request is on the given endpoint
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks         2009-06-02  4310   * @ep: The endpoint to check.
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks         2009-06-02  4311   * @test: The request to test if it is on the endpoint.
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks         2009-06-02  4312   */
1f91b4cc03556b drivers/usb/dwc2/gadget.c      Felipe Balbi      2015-08-06 @4313  static bool on_list(struct dwc2_hsotg_ep *ep, struct dwc2_hsotg_req *test)
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks         2009-06-02  4314  {
1f91b4cc03556b drivers/usb/dwc2/gadget.c      Felipe Balbi      2015-08-06  4315  	struct dwc2_hsotg_req *req, *treq;
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks         2009-06-02  4316  
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks         2009-06-02  4317  	list_for_each_entry_safe(req, treq, &ep->queue, queue) {
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks         2009-06-02  4318  		if (req == test)
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks         2009-06-02  4319  			return true;
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks         2009-06-02  4320  	}
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks         2009-06-02  4321  
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks         2009-06-02  4322  	return false;
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks         2009-06-02  4323  }
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks         2009-06-02  4324  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

