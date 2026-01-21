Return-Path: <netdev+bounces-251778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCegE+JmcGkVXwAAu9opvQ
	(envelope-from <netdev+bounces-251778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 06:40:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 828C1519D4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 06:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB27E46584F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 05:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0538D37BE92;
	Wed, 21 Jan 2026 05:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jq1KAf4q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC38D3ECBC5;
	Wed, 21 Jan 2026 05:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768974043; cv=none; b=nRKV0MSVHCSiMg98qTZ8Rl+NmSryaheXxBLYBBTnkGIANrHai7WTDIaOv2gDnCLEVie5erI9ws4E5T7tm+PruHdV7eKD3eJjrU2twWvidx7HtZmu3W86kjXIhQN/OhAmaoMAz/DW4gqRTHXz7ccfK2w2xU5DMKN236l46SurBIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768974043; c=relaxed/simple;
	bh=Zx+SBvi0ayiSjILiYD+XZDq1nslSNFB+Y/17FI4keB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGP67ngLSL2Vn/jDAZNqdjug18CMnYsPBFinuRozYZscZGzpxQyHQzHgzfTffv7UfA5cwVaFKpDMvG26jDYV7l7leIey5Q6sqiyWZ6U1OoA1RQFALRNwSPSueENEjPv0Tuuc5eXGIA71noFl4ViLeZzU8KcwPQqMkkGdPRn/eyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jq1KAf4q; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768974041; x=1800510041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zx+SBvi0ayiSjILiYD+XZDq1nslSNFB+Y/17FI4keB4=;
  b=Jq1KAf4q66IAYsdr/DZ8L0xiOU+NT5aMlkLig9U99TFEOkVopF6Pa/ee
   8VlrCAXon+krdUYTApe2TI3DqI8nLSDk5QshNxHHIkoL5nbIa8vGbFGxA
   K8s1x4y3rvoCEbVjIV+MLxMB6KDI3CDSndisbjagLFb41Tz+ZRJeuFe5y
   fTtHUsNy6r8kmCHmoHc1P7Nw63L81MwmnqXIR6edfCHAgrLKlAsPHsWnK
   0/8YlMLTMwMqcE+JsZuH+fSwF9wzCRoJH+gLGY2Eyc9UCOI906GC0FfWI
   sisOYB60zxbo57k7UR3UyAK55TSDzzVMH8J9C8VkHvzFy5GM024SvClqT
   w==;
X-CSE-ConnectionGUID: k5gTnfsURMyTVvd0QzmhjA==
X-CSE-MsgGUID: +ptonkJtTci0ilEEF5mbsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="87608238"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="87608238"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 21:40:39 -0800
X-CSE-ConnectionGUID: yIdPUrdgSiybgm4rI91ngg==
X-CSE-MsgGUID: HUtRvEKGQIavCBzlQuTQmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="210796208"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 20 Jan 2026 21:40:34 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viQxD-00000000Q27-2Z5X;
	Wed, 21 Jan 2026 05:40:31 +0000
Date: Wed, 21 Jan 2026 13:40:30 +0800
From: kernel test robot <lkp@intel.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	pmladek@suse.com, john.ogness@linutronix.de
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
	gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
	mpdesouza@suse.com, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 4/5] netconsole: Use printk context for CPU
 and task information
Message-ID: <202601211304.r9ecHy9L-lkp@intel.com>
References: <20260120-nbcon-v2-4-b61f960587a8@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120-nbcon-v2-4-b61f960587a8@debian.org>
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251778-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,kvack.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 828C1519D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Breno,

kernel test robot noticed the following build errors:

[auto build test ERROR on 956f569c90ab507559342d289f4c923adfbf06f5]

url:    https://github.com/intel-lab-lkp/linux/commits/Breno-Leitao/printk-Add-execution-context-task-name-CPU-to-printk_info/20260121-033457
base:   956f569c90ab507559342d289f4c923adfbf06f5
patch link:    https://lore.kernel.org/r/20260120-nbcon-v2-4-b61f960587a8%40debian.org
patch subject: [PATCH net-next v2 4/5] netconsole: Use printk context for CPU and task information
config: csky-randconfig-r134-20260121 (https://download.01.org/0day-ci/archive/20260121/202601211304.r9ecHy9L-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260121/202601211304.r9ecHy9L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601211304.r9ecHy9L-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/netconsole.c: In function 'sysdata_append_cpu_nr':
>> drivers/net/netconsole.c:1365:31: error: 'struct nbcon_write_context' has no member named 'cpu'
    1365 |                          wctxt->cpu);
         |                               ^~
   drivers/net/netconsole.c: In function 'sysdata_append_taskname':
>> drivers/net/netconsole.c:1373:31: error: 'struct nbcon_write_context' has no member named 'comm'
    1373 |                          wctxt->comm);
         |                               ^~
   drivers/net/netconsole.c: In function 'sysdata_append_cpu_nr':
>> drivers/net/netconsole.c:1366:1: warning: control reaches end of non-void function [-Wreturn-type]
    1366 | }
         | ^
   drivers/net/netconsole.c: In function 'sysdata_append_taskname':
   drivers/net/netconsole.c:1374:1: warning: control reaches end of non-void function [-Wreturn-type]
    1374 | }
         | ^


vim +1365 drivers/net/netconsole.c

  1359	
  1360	static int sysdata_append_cpu_nr(struct netconsole_target *nt, int offset,
  1361					 struct nbcon_write_context *wctxt)
  1362	{
  1363		return scnprintf(&nt->sysdata[offset],
  1364				 MAX_EXTRADATA_ENTRY_LEN, " cpu=%u\n",
> 1365				 wctxt->cpu);
> 1366	}
  1367	
  1368	static int sysdata_append_taskname(struct netconsole_target *nt, int offset,
  1369					   struct nbcon_write_context *wctxt)
  1370	{
  1371		return scnprintf(&nt->sysdata[offset],
  1372				 MAX_EXTRADATA_ENTRY_LEN, " taskname=%s\n",
> 1373				 wctxt->comm);
  1374	}
  1375	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

