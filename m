Return-Path: <netdev+bounces-152239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4D79F332E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028951887EE1
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA972206270;
	Mon, 16 Dec 2024 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iSAwtSyS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C957206263
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359176; cv=none; b=qDzJ5N/kb3w53c+/CyST5iE2iwgYr7YWr1q9/8LELlalkEYpGK91yQv3lHHYi+MYHeKgFQXQ5xRdsLM0T7BYufvMQCjgIaYYYqp3WotTPRMlRhow6mpoAe0XIuHYZebReeG8uRzuCLoPqFqbkgJIGBxFVEpL5QG9xcW3mRP4kfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359176; c=relaxed/simple;
	bh=sft5cwTzWGq8odCj7y1SQ/Itv2Uve4WrTFgtzG27/Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIAj3ZpSa5wgfV0uPoVlXY+cd7IfBvLVs/qdLbNNGlk1f1qAvuK3Aog5viAOcSj5B5fAobowh/kumIaQrOB9bsxFg7cVzi1TIi2Fvb3m0FQzWdOxbHzeU5o5NB44g6vVebYlCaRl0lDcuo9QYiqvSv5Ok/2tE5kAke+zGMUSbC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iSAwtSyS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734359175; x=1765895175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sft5cwTzWGq8odCj7y1SQ/Itv2Uve4WrTFgtzG27/Mo=;
  b=iSAwtSyStkZ5qMGQdSeYRU+zBGrprooQOlc3v9QRQ8KnORHlui72+INZ
   PC6mqrrMvWYjXhC0r1W5KnVTySi3zkkG+yCY53bnjv06Tq+mOPmEqF3cV
   DRc0Ldjpa3/ljILVkBoSmm8uNa4H0sjNCYVqO6KM+8/JocgIaKdBg3XLc
   k8bMY3v7kZfxhnuUPf6WadW2+e+yrBAvluq31ljUnEnir9n5xhTnxcm9J
   Yz/qX1kRnVzS+K+D3NuWhmmUEHTxYpq/R9aIo6TDE6UjIEqvpaamFgDtu
   0kmUEh3YObfjNDqg3zkXxh7s0IoyUIFEzHjR44uNCIl1TrrdFScuIZdJN
   A==;
X-CSE-ConnectionGUID: hTsZSC2fTHWk+Eelp/cL2g==
X-CSE-MsgGUID: b2lC0UpeT02gmFTKMnxfuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34065631"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="34065631"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 06:26:15 -0800
X-CSE-ConnectionGUID: PczZ55tGQOGUxSLC+ptRyg==
X-CSE-MsgGUID: w7yX0mioQbaU69s0w4Jr0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101355767"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 16 Dec 2024 06:26:12 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tNC2z-000EFc-1H;
	Mon, 16 Dec 2024 14:26:09 +0000
Date: Mon, 16 Dec 2024 22:25:54 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next 2/6] bnxt_en: Do not allow ethtool -m on an
 untrusted VF
Message-ID: <202412162242.yQ3MVnZ5-lkp@intel.com>
References: <20241215205943.2341612-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215205943.2341612-3-michael.chan@broadcom.com>

Hi Michael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Chan/bnxt_en-Use-FW-defined-resource-limits-for-RoCE/20241216-050303
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241215205943.2341612-3-michael.chan%40broadcom.com
patch subject: [PATCH net-next 2/6] bnxt_en: Do not allow ethtool -m on an untrusted VF
config: riscv-randconfig-002-20241216 (https://download.01.org/0day-ci/archive/20241216/202412162242.yQ3MVnZ5-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241216/202412162242.yQ3MVnZ5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412162242.yQ3MVnZ5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:8287:7: warning: variable 'flags' is uninitialized when used here [-Wuninitialized]
                   if (flags & FUNC_QCFG_RESP_FLAGS_TRUSTED_VF)
                       ^~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:8269:11: note: initialize the variable 'flags' to silence this warning
           u16 flags;
                    ^
                     = 0
   1 warning generated.


vim +/flags +8287 drivers/net/ethernet/broadcom/bnxt/bnxt.c

  8264	
  8265	static int bnxt_hwrm_func_qcfg(struct bnxt *bp)
  8266	{
  8267		struct hwrm_func_qcfg_output *resp;
  8268		struct hwrm_func_qcfg_input *req;
  8269		u16 flags;
  8270		int rc;
  8271	
  8272		rc = hwrm_req_init(bp, req, HWRM_FUNC_QCFG);
  8273		if (rc)
  8274			return rc;
  8275	
  8276		req->fid = cpu_to_le16(0xffff);
  8277		resp = hwrm_req_hold(bp, req);
  8278		rc = hwrm_req_send(bp, req);
  8279		if (rc)
  8280			goto func_qcfg_exit;
  8281	
  8282	#ifdef CONFIG_BNXT_SRIOV
  8283		if (BNXT_VF(bp)) {
  8284			struct bnxt_vf_info *vf = &bp->vf;
  8285	
  8286			vf->vlan = le16_to_cpu(resp->vlan) & VLAN_VID_MASK;
> 8287			if (flags & FUNC_QCFG_RESP_FLAGS_TRUSTED_VF)
  8288				vf->flags |= BNXT_VF_TRUST;
  8289			else
  8290				vf->flags &= ~BNXT_VF_TRUST;
  8291		} else {
  8292			bp->pf.registered_vfs = le16_to_cpu(resp->registered_vfs);
  8293		}
  8294	#endif
  8295		flags = le16_to_cpu(resp->flags);
  8296		if (flags & (FUNC_QCFG_RESP_FLAGS_FW_DCBX_AGENT_ENABLED |
  8297			     FUNC_QCFG_RESP_FLAGS_FW_LLDP_AGENT_ENABLED)) {
  8298			bp->fw_cap |= BNXT_FW_CAP_LLDP_AGENT;
  8299			if (flags & FUNC_QCFG_RESP_FLAGS_FW_DCBX_AGENT_ENABLED)
  8300				bp->fw_cap |= BNXT_FW_CAP_DCBX_AGENT;
  8301		}
  8302		if (BNXT_PF(bp) && (flags & FUNC_QCFG_RESP_FLAGS_MULTI_HOST))
  8303			bp->flags |= BNXT_FLAG_MULTI_HOST;
  8304	
  8305		if (flags & FUNC_QCFG_RESP_FLAGS_RING_MONITOR_ENABLED)
  8306			bp->fw_cap |= BNXT_FW_CAP_RING_MONITOR;
  8307	
  8308		if (flags & FUNC_QCFG_RESP_FLAGS_ENABLE_RDMA_SRIOV)
  8309			bp->fw_cap |= BNXT_FW_CAP_ENABLE_RDMA_SRIOV;
  8310	
  8311		switch (resp->port_partition_type) {
  8312		case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_0:
  8313		case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_5:
  8314		case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR2_0:
  8315			bp->port_partition_type = resp->port_partition_type;
  8316			break;
  8317		}
  8318		if (bp->hwrm_spec_code < 0x10707 ||
  8319		    resp->evb_mode == FUNC_QCFG_RESP_EVB_MODE_VEB)
  8320			bp->br_mode = BRIDGE_MODE_VEB;
  8321		else if (resp->evb_mode == FUNC_QCFG_RESP_EVB_MODE_VEPA)
  8322			bp->br_mode = BRIDGE_MODE_VEPA;
  8323		else
  8324			bp->br_mode = BRIDGE_MODE_UNDEF;
  8325	
  8326		bp->max_mtu = le16_to_cpu(resp->max_mtu_configured);
  8327		if (!bp->max_mtu)
  8328			bp->max_mtu = BNXT_MAX_MTU;
  8329	
  8330		if (bp->db_size)
  8331			goto func_qcfg_exit;
  8332	
  8333		bp->db_offset = le16_to_cpu(resp->legacy_l2_db_size_kb) * 1024;
  8334		if (BNXT_CHIP_P5(bp)) {
  8335			if (BNXT_PF(bp))
  8336				bp->db_offset = DB_PF_OFFSET_P5;
  8337			else
  8338				bp->db_offset = DB_VF_OFFSET_P5;
  8339		}
  8340		bp->db_size = PAGE_ALIGN(le16_to_cpu(resp->l2_doorbell_bar_size_kb) *
  8341					 1024);
  8342		if (!bp->db_size || bp->db_size > pci_resource_len(bp->pdev, 2) ||
  8343		    bp->db_size <= bp->db_offset)
  8344			bp->db_size = pci_resource_len(bp->pdev, 2);
  8345	
  8346	func_qcfg_exit:
  8347		hwrm_req_drop(bp, req);
  8348		return rc;
  8349	}
  8350	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

