Return-Path: <netdev+bounces-129218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A5B97E459
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 02:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D0F281102
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 00:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBCC1FA4;
	Mon, 23 Sep 2024 00:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0J4B0Ul"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8A41854;
	Mon, 23 Sep 2024 00:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727051199; cv=none; b=nBHY2G8Cv/hlCp7PAbRcyP9ktD0ITAr1dRjypOFLIhPva5Gcyu1neGl45Ww6TtVaWAvN0NAtqWZw1XcnL0jYAkTq9ssQ/ATa0kYRr2MqGQV5ddaQ1v41+LKLBu9cjPMi3IChgMO9CpmtBjWes5uLoXeKK2KF2MBJfwb7sK6jAQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727051199; c=relaxed/simple;
	bh=r9eZSjpPPRZxuaTB8vAtuP+JbDLZI+RKHFsHrPdgMvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPTdmXXb6gDct4s4niuBTs0gziMkSDTt1x4rrU8QhnAUI+li2+LFlxoZZnrQiPpO59kFqa9K/FAI5hwA9fEgcjLfnvxYIM2qztTVcJCZhM9oOnXZe3SBBZMGvTl0tphJYacrJcGHEvvxk/sbQ+p1FUjk8wzpaaHhl9IJ3A2+Y04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0J4B0Ul; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727051198; x=1758587198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r9eZSjpPPRZxuaTB8vAtuP+JbDLZI+RKHFsHrPdgMvw=;
  b=C0J4B0UlDTLyWarNEmnZnCqSLqX8nGPrUXKHVS7IDuiDusm1ybE3j9hS
   OMlcbOuQXjUXcOymYPtYBYhOluqPbX2aScqoUbCwPwICtsCb9F6t2dkBq
   DpLmQxBjL8HTUg2qJAb6cglX/b/7eiDgJU/OGQJTI0Zgk6UPk/TJMpUfl
   Cm/2BpPrrJWsi91QY7K0NefRW+6c31kjFN73iKkE+3DTmA86vdqdIrhE7
   YZbZDm4m2wgYIfEx+9XAvtayB8wjg179Ip78jSxGEmfbPjR2jqNgSFnlE
   3AZkDgmnMAg0DbyL9Oia9XXT0R5viycLz9qSL4/xuX78Lwv4fysMVjfqp
   Q==;
X-CSE-ConnectionGUID: lKgS9WfuRx66WUzYGRUOXA==
X-CSE-MsgGUID: HnlGu9nORNSWTYPzggezLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="26136445"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="26136445"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 17:26:37 -0700
X-CSE-ConnectionGUID: Aux9It25RsqZ1Y4jrXdx1g==
X-CSE-MsgGUID: Ah3+FQaFS6KkFoPqV8L0XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="71338470"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 22 Sep 2024 17:26:34 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssWuN-000Glc-2K;
	Mon, 23 Sep 2024 00:26:31 +0000
Date: Mon, 23 Sep 2024 08:26:19 +0800
From: kernel test robot <lkp@intel.com>
To: Dipendra Khadka <kdipendra88@gmail.com>, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, Dipendra Khadka <kdipendra88@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: net: nic: Add error pointer check in
 otx2_flows.c
Message-ID: <202409230844.gM9kqV79-lkp@intel.com>
References: <20240922185235.50413-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922185235.50413-1-kdipendra88@gmail.com>

Hi Dipendra,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Dipendra-Khadka/Staging-net-nic-Add-error-pointer-check-in-otx2_flows-c/20240923-025325
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20240922185235.50413-1-kdipendra88%40gmail.com
patch subject: [PATCH] Staging: net: nic: Add error pointer check in otx2_flows.c
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240923/202409230844.gM9kqV79-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240923/202409230844.gM9kqV79-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409230844.gM9kqV79-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c: In function 'otx2_alloc_mcam_entries':
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:124:39: error: 'bfvf' undeclared (first use in this function); did you mean 'pfvf'?
     124 |                         mutex_unlock(&bfvf->mbox.lock);
         |                                       ^~~~
         |                                       pfvf
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:124:39: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c: In function 'otx2_mcam_entry_init':
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:207:31: error: 'bfvf' undeclared (first use in this function); did you mean 'pfvf'?
     207 |                 mutex_unlock(&bfvf->mbox.lock);
         |                               ^~~~
         |                               pfvf


vim +124 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c

    71	
    72	int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
    73	{
    74		struct otx2_flow_config *flow_cfg = pfvf->flow_cfg;
    75		struct npc_mcam_alloc_entry_req *req;
    76		struct npc_mcam_alloc_entry_rsp *rsp;
    77		int ent, allocated = 0;
    78	
    79		/* Free current ones and allocate new ones with requested count */
    80		otx2_free_ntuple_mcam_entries(pfvf);
    81	
    82		if (!count)
    83			return 0;
    84	
    85		flow_cfg->flow_ent = devm_kmalloc_array(pfvf->dev, count,
    86							sizeof(u16), GFP_KERNEL);
    87		if (!flow_cfg->flow_ent) {
    88			netdev_err(pfvf->netdev,
    89				   "%s: Unable to allocate memory for flow entries\n",
    90				    __func__);
    91			return -ENOMEM;
    92		}
    93	
    94		mutex_lock(&pfvf->mbox.lock);
    95	
    96		/* In a single request a max of NPC_MAX_NONCONTIG_ENTRIES MCAM entries
    97		 * can only be allocated.
    98		 */
    99		while (allocated < count) {
   100			req = otx2_mbox_alloc_msg_npc_mcam_alloc_entry(&pfvf->mbox);
   101			if (!req)
   102				goto exit;
   103	
   104			req->contig = false;
   105			req->count = (count - allocated) > NPC_MAX_NONCONTIG_ENTRIES ?
   106					NPC_MAX_NONCONTIG_ENTRIES : count - allocated;
   107	
   108			/* Allocate higher priority entries for PFs, so that VF's entries
   109			 * will be on top of PF.
   110			 */
   111			if (!is_otx2_vf(pfvf->pcifunc)) {
   112				req->priority = NPC_MCAM_HIGHER_PRIO;
   113				req->ref_entry = flow_cfg->def_ent[0];
   114			}
   115	
   116			/* Send message to AF */
   117			if (otx2_sync_mbox_msg(&pfvf->mbox))
   118				goto exit;
   119	
   120			rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp
   121				(&pfvf->mbox.mbox, 0, &req->hdr);
   122	
   123			if (IS_ERR(rsp)) {
 > 124				mutex_unlock(&bfvf->mbox.lock);
   125				return PTR_ERR(rsp);
   126			}
   127	
   128			for (ent = 0; ent < rsp->count; ent++)
   129				flow_cfg->flow_ent[ent + allocated] = rsp->entry_list[ent];
   130	
   131			allocated += rsp->count;
   132	
   133			/* If this request is not fulfilled, no need to send
   134			 * further requests.
   135			 */
   136			if (rsp->count != req->count)
   137				break;
   138		}
   139	
   140		/* Multiple MCAM entry alloc requests could result in non-sequential
   141		 * MCAM entries in the flow_ent[] array. Sort them in an ascending order,
   142		 * otherwise user installed ntuple filter index and MCAM entry index will
   143		 * not be in sync.
   144		 */
   145		if (allocated)
   146			sort(&flow_cfg->flow_ent[0], allocated,
   147			     sizeof(flow_cfg->flow_ent[0]), mcam_entry_cmp, NULL);
   148	
   149	exit:
   150		mutex_unlock(&pfvf->mbox.lock);
   151	
   152		flow_cfg->max_flows = allocated;
   153	
   154		if (allocated) {
   155			pfvf->flags |= OTX2_FLAG_MCAM_ENTRIES_ALLOC;
   156			pfvf->flags |= OTX2_FLAG_NTUPLE_SUPPORT;
   157		}
   158	
   159		if (allocated != count)
   160			netdev_info(pfvf->netdev,
   161				    "Unable to allocate %d MCAM entries, got only %d\n",
   162				    count, allocated);
   163		return allocated;
   164	}
   165	EXPORT_SYMBOL(otx2_alloc_mcam_entries);
   166	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

