Return-Path: <netdev+bounces-268710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCJKMbqguWmiLQIAu9opvQ
	(envelope-from <netdev+bounces-268710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:43:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 439A72B10D7
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59AC7306827B
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 18:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919AD37C0E7;
	Tue, 17 Mar 2026 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iK9sn039"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6413EFD1A
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773772897; cv=none; b=RJuAeAtIuTfIto+wTcTyeOnlU399MIXavwt3mUywY1Pw6iWb3KIfZqfjXqSrvVokRsaJPWu/ksgDKQJBACmry582hOUNkUoYQWUKyACwt3TD+RhQQJuoby41AJUhOPHvGcsJD+rFIA6FC8itt6zPqg3gm7OFfFywUC+smv0wYIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773772897; c=relaxed/simple;
	bh=uTWfqk6Ebi8CoYpNJEFKkfF7211leHYOFJR95rDk0MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwZQw46E61mMkfqKFs+34kNcxvOJ9FWRqmi7e5qIWrgrw+/aeS+HkoFsgdDznnzbuxRiS9fl3ggXqjLL32IkwSR46zpqub4OZTDzKfq8uVqTBdZRwXGjrlik7eIEDrgSGTxxXNxlIlX7uBcQe3hufPSD2Ld3nmOikUTHKwbByvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iK9sn039; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773772891; x=1805308891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uTWfqk6Ebi8CoYpNJEFKkfF7211leHYOFJR95rDk0MA=;
  b=iK9sn039H2iWWCXrE+ClTptewx4T/4Ak3T/t1JvqRqbtkbR1mhNWkwS1
   TSwfSJXsx1cC0HiMx1wWkzyzXCbHRD6mx/8dV6gCZMrbuk0Ti06IuzVEg
   25e/8VdCp5eZEl+r6HmDnkc0ir3E5CWUQOwBQz/MTFJXzi0G7FSOTDLpc
   o9qVqH7Mc2rB6rBZghR9TfnSefykIM7FQ4U+U2FCYWwwyt6MOzjkA8dG7
   FBUT4PAjmNAqavUqiQm6O20W02LZmbfPyLS+5g4ZnkVnHgSftRfbQglae
   v0ly+L8pflNpE0rJJfAHKPycies7Od/fSnkXYoOx0qRfK1RVwGdoT9VsZ
   A==;
X-CSE-ConnectionGUID: HzlCM/NbRfOB4j2MZsoW9A==
X-CSE-MsgGUID: 0lPc0Bl8TOWvUk+hCCTnQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74704439"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="74704439"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 11:41:31 -0700
X-CSE-ConnectionGUID: 5A2o8ipkSdiBD/17C5EjAg==
X-CSE-MsgGUID: n5uz3BV4TWSfpC/UfZUYgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="245377332"
Received: from lkp-server01.sh.intel.com (HELO 63737dd503cb) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 17 Mar 2026 11:41:28 -0700
Received: from kbuild by 63737dd503cb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2ZM5-000000001of-3clQ;
	Tue, 17 Mar 2026 18:41:25 +0000
Date: Wed, 18 Mar 2026 02:40:37 +0800
From: kernel test robot <lkp@intel.com>
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, pabeni@redhat.com, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: Re: [PATCH net-next v17 01/14] net: homa: define user-visible API
 for Homa
Message-ID: <202603180251.ApKBYL2x-lkp@intel.com>
References: <20260316223228.2611-2-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316223228.2611-2-ouster@cs.stanford.edu>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268710-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 439A72B10D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/net-homa-define-user-visible-API-for-Homa/20260317-070659
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260316223228.2611-2-ouster%40cs.stanford.edu
patch subject: [PATCH net-next v17 01/14] net: homa: define user-visible API for Homa
config: hexagon-randconfig-r071-20260317 (https://download.01.org/0day-ci/archive/20260318/202603180251.ApKBYL2x-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 4abb927bacf37f18f6359a41639a6d1b3bffffb5)
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260318/202603180251.ApKBYL2x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603180251.ApKBYL2x-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/homa.h:11:10: fatal error: 'netinet/in.h' file not found
      11 | #include <netinet/in.h>
         |          ^~~~~~~~~~~~~~
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

