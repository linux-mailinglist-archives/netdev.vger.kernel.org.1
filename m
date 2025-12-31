Return-Path: <netdev+bounces-246463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7786ACEC873
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 21:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D97A7300100A
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 20:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA5C30C61C;
	Wed, 31 Dec 2025 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSSO/8lg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FD82046BA;
	Wed, 31 Dec 2025 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767212096; cv=none; b=snItqKPJ/4DpWjq7HdO/iGfybn0LGd4p+f+7S5HQFMNaGBd2PbxBnlmk2J6LoMTRWUgsn9riwIO4VGGc077kQXoB3cW5xrUPvxbfWw1hLFtv8JEvf1+ql8XSzhHpIP5a+UhtYL3pmauXl4SfDNC/gBMrw27X4kV3OwiTUYdBUow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767212096; c=relaxed/simple;
	bh=GOzOwFsLJwxo7U0O+JtlVQvdQc2MkjpmioNT7jq13aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErixVbbE6KiveDIBK0gREZBJkwu6T0ZsrSNAix7Pls8fctyXDdGygiI4OotjzQKN9iowOVnOdk1WAYfIUEyuHXqkL4QbXH0EmgaYC7PNxmkeVcakKhCSIFn5YVzg8QNAXiCNXs48iw3Fv4oxaR4XHcfUx+F0ia7MPZtdpaYzMEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSSO/8lg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767212095; x=1798748095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GOzOwFsLJwxo7U0O+JtlVQvdQc2MkjpmioNT7jq13aA=;
  b=BSSO/8lgcvM0+emJMjbkcw+RlAtEdL0GRpz4j+xkpdhiKQAfgF4cTwld
   bufYt6LMQPwScvJ11m4RQH6RjKVwae22+pBRVwHIoOvPTgWzNIpmljOsa
   CIDOw1AFB8K3ovyeIgzle7ePQpN14JopzQj5PEZewzNluFCsyg3nr3yTo
   z7ymAyaGS7XBCOXCdGX4SnrdMSffxKs3q4Tuaxmf2OkIUhElk2AEg2F8G
   zNRqApbmAj1KucwtyHcvaW829EBZ6Vy7ZA5nIuM1lKuhKXXbGx+4vl+c1
   SE3xNlV1cIizXT8KOytQuAMbK2sqJSpTV/8SVwamkTXHK8WgZ7Bel6xeV
   Q==;
X-CSE-ConnectionGUID: 9/G53y7bTliwP/++/QBYhw==
X-CSE-MsgGUID: MmwvT8vLTU+GXGa1qYFl3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="67782310"
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="67782310"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 12:14:54 -0800
X-CSE-ConnectionGUID: 7QLl3a/sQWSG9bz+5mVaBg==
X-CSE-MsgGUID: 5JINwghiRRqR/M/6oY+ViQ==
X-ExtLoop1: 1
Received: from igk-lkp-server01.igk.intel.com (HELO 92b2e8bd97aa) ([10.211.93.152])
  by fmviesa003.fm.intel.com with ESMTP; 31 Dec 2025 12:14:51 -0800
Received: from kbuild by 92b2e8bd97aa with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vb2am-0000000006b-3lFa;
	Wed, 31 Dec 2025 20:14:48 +0000
Date: Wed, 31 Dec 2025 21:13:57 +0100
From: kernel test robot <lkp@intel.com>
To: Slark Xiao <slark_xiao@163.com>, loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mani@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>,
	Muhammad Nuzaihan <zaihan@unrealasia.net>,
	Qiang Yu <quic_qianyu@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [net-next v3 4/8] net: wwan: add NMEA port support
Message-ID: <202512312143.W82zclxI-lkp@intel.com>
References: <20251231065109.43378-5-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231065109.43378-5-slark_xiao@163.com>

Hi Slark,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Slark-Xiao/net-wwan-core-remove-unused-port_id-field/20251231-145913
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251231065109.43378-5-slark_xiao%40163.com
patch subject: [net-next v3 4/8] net: wwan: add NMEA port support
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20251231/202512312143.W82zclxI-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251231/202512312143.W82zclxI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512312143.W82zclxI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/net/wwan/wwan_core.c:98 struct member 'gnss' not described in 'wwan_port'
>> Warning: drivers/net/wwan/wwan_core.c:98 struct member 'gnss' not described in 'wwan_port'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

