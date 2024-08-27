Return-Path: <netdev+bounces-122542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C9D961A56
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 01:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8B01F259FD
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CB61D45EB;
	Tue, 27 Aug 2024 23:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOlYz5rw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E011D1F51
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 23:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800464; cv=none; b=nkp9IIEM7aGHTfIBlylFo3lsWP4FSu4Xj5sinM1l+q2ORSvNj9Q7x5ziHnjxtSViWttmZGaLGVSzRuH/SDxflml3YRljJTD4OCR8pFcdHP60JJDSS4KjTMn5cgtyl8gZMzYXUXA5CN3W9zdFo0dyQWcapx5f5XwMxfKBaSSm590=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800464; c=relaxed/simple;
	bh=d2xw+MKXUlAGJzl40PtsI6mqCR3vfnryuHkt2MNP7GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOpHEVc0jxe7wESDRWyCG3MqSxI9AmE30WEqTpbZ2I6TtF8xm9Uz0Ak7byQJbU+/hbsbW+T4f8lky7NKCOPLC10JovwuWWIoR3hn3QAHTLMsMRXzWAVQ29LoG0cpo2glA3/LZduHqe6HE4JdolsFaW/hIz+5FD1km+fhMdbt5E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOlYz5rw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724800463; x=1756336463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d2xw+MKXUlAGJzl40PtsI6mqCR3vfnryuHkt2MNP7GA=;
  b=WOlYz5rw844l6q5kRTsQKzMl9myyJ9k8ZwagsdN1YNkhARwJwNgvov/u
   zMsfRg8DljQkBMLfyMvhCMnDdfIcw34AN1g7Hx7Iy4XixbcUG1Gw8fg1d
   ubfbS/87i2OlzIt6snSmlyISRoAnhSCIjtZZwYDE1XF2Yqm71JxfjkNDb
   VZ4FJtE0eZzBvOJKluFxlmUpGlNd7opxEbCcBrN1NNVUus7RPCsu3iSQ8
   /yDBx9Kxfd3OdbawhsCLgAXpDY/jn8tDVlQPjBD+BuVaButxdvuXINpKB
   c8QJEuujzjkN8n0t/iP7XsWxLuu93iCVw5D7zJMmIzJ4MHjT+DO4mwZLf
   Q==;
X-CSE-ConnectionGUID: Pe6BH7jOQa+IKdpJ+Ls9kQ==
X-CSE-MsgGUID: aaMpRmUBRpi3pszn68HvVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="48690602"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="48690602"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 16:14:22 -0700
X-CSE-ConnectionGUID: JqZ9HEmVTpW9X6PGADDbEQ==
X-CSE-MsgGUID: /CvRBK0mS7+/DPOk8F0C8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63541487"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 27 Aug 2024 16:14:21 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sj5OE-000KB8-16;
	Tue, 27 Aug 2024 23:14:18 +0000
Date: Wed, 28 Aug 2024 07:13:57 +0800
From: kernel test robot <lkp@intel.com>
To: Matt Johnston <matt@codeconstruct.com.au>, jk@codeconstruct.com.au
Cc: oe-kbuild-all@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: mctp-serial: Add kunit test for
 next_chunk_len()
Message-ID: <202408280734.ioysUDjL-lkp@intel.com>
References: <20240827020803.957250-2-matt@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827020803.957250-2-matt@codeconstruct.com.au>

Hi Matt,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Matt-Johnston/net-mctp-serial-Add-kunit-test-for-next_chunk_len/20240827-101656
base:   net/main
patch link:    https://lore.kernel.org/r/20240827020803.957250-2-matt%40codeconstruct.com.au
patch subject: [PATCH net 1/2] net: mctp-serial: Add kunit test for next_chunk_len()
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240828/202408280734.ioysUDjL-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240828/202408280734.ioysUDjL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408280734.ioysUDjL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/mctp/mctp-serial.c: In function 'test_next_chunk_len':
>> drivers/net/mctp/mctp-serial.c:541:40: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     541 |         struct test_chunk_tx *params = test->param_value;
         |                                        ^~~~


vim +/const +541 drivers/net/mctp/mctp-serial.c

   534	
   535	static void test_next_chunk_len(struct kunit *test)
   536	{
   537		struct mctp_serial devx;
   538		struct mctp_serial *dev = &devx;
   539		int next;
   540	
 > 541		struct test_chunk_tx *params = test->param_value;
   542	
   543		memset(dev, 0x0, sizeof(*dev));
   544		memcpy(dev->txbuf, params->input, params->input_len);
   545		dev->txlen = params->input_len;
   546	
   547		for (size_t i = 0; i < MAX_CHUNKS; i++) {
   548			next = next_chunk_len(dev);
   549			dev->txpos += next;
   550			KUNIT_EXPECT_EQ(test, next, params->chunks[i]);
   551	
   552			if (next == 0) {
   553				KUNIT_EXPECT_EQ(test, dev->txpos, dev->txlen);
   554				return;
   555			}
   556		}
   557	
   558		KUNIT_FAIL_AND_ABORT(test, "Ran out of chunks");
   559	}
   560	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

