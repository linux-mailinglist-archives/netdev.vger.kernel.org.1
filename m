Return-Path: <netdev+bounces-277246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEcxEDCI2GkIewgAu9opvQ
	(envelope-from <netdev+bounces-277246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:18:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF793D2406
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 547FC300ECAC
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFB933262B;
	Fri, 10 Apr 2026 05:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LW/G7e7F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E6322B9F;
	Fri, 10 Apr 2026 05:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775798317; cv=none; b=T5UAgPCBEgolpH92zEetzcaGHK0Nbr4aK/qKVCKGFIhGHulvEJTypNzvlZxT8yxEkHYq49O32tg7s/+Ex4qQ4xDe2/Fa5Xm2McVZmUhNnS2+f+EpEYWFobVu62iaGgrBiNRldhB7t8/8suz/FBNAjLkDgB7k/istW19lnzFuPco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775798317; c=relaxed/simple;
	bh=+VFzieqwPc38woKRp/YU4bLMMVy9GAHhcCD1vG/tSzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJ/bnzarfZFtggnSXOYoRV1nTjTB9cagNr+enKnBAQ/FO9y4dl3SWPrb8OhSpDZB9jaXb0zI7XTtk0fJuDQqAigx80rhtpWpZIhhaRd5kXycR4Wt8FY+pkknr/NV3O9Y1j2Kh6uOuhbVOpdqLdMeE5hxS7LbduEOzy3pQtJTlfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LW/G7e7F; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775798315; x=1807334315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+VFzieqwPc38woKRp/YU4bLMMVy9GAHhcCD1vG/tSzs=;
  b=LW/G7e7Fo4qA2723Yw/aSqEdQPdZyvvMnJrdZe/0NGvNSZQ5iY86kmsg
   thW6Lon8z1krKEhnw/VT9JKTrGxgaPjyB81cF74G4vsE+wIStltWVl0MX
   hMQKkhZbtZYDH1UYoU1qzxM0w2GHeNXj5bTBoXzVGxMt0eIWPhLUDJO9q
   rgzDprPrkmW2J8HDKIjR8w5MdqoUYvUm9oJLz1jDLI80f73tWeXGbhqBi
   68fOMn2dNQP7EA3nf2EoewjYdiWQ/W8TjqIevv72WuLHXhxY02qF71o5X
   9oCToBq0MkrS2p+htid9jhCxhVD0QINDcpuS4oKVfQGPbItGmDVzJ0hLq
   A==;
X-CSE-ConnectionGUID: H9YE4dxWTRGHo1dx+CiFBg==
X-CSE-MsgGUID: SMzOw99jSpigb8m7r/fgJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="87513395"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="87513395"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 22:18:35 -0700
X-CSE-ConnectionGUID: ebBuAvOQS56oQe+1J7RS9g==
X-CSE-MsgGUID: TvHR1cDkTOyP3Ua2IqVpow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="233382321"
Received: from lkp-server01.sh.intel.com (HELO 6449335cace3) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 09 Apr 2026 22:18:32 -0700
Received: from kbuild by 6449335cace3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wB4GD-000000002T3-1TcW;
	Fri, 10 Apr 2026 05:18:29 +0000
Date: Fri, 10 Apr 2026 13:17:25 +0800
From: kernel test robot <lkp@intel.com>
To: Birger Koblitz <mail@birger-koblitz.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Birger Koblitz <mail@birger-koblitz.de>
Subject: Re: [PATCH net-next 2/9] r8152: Add support for RTL8157 SRAM access
 and ADV indirect access
Message-ID: <202604101309.B9mdviRN-lkp@intel.com>
References: <20260314-rtl8157_next-v1-2-9ba77b428afd@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314-rtl8157_next-v1-2-9ba77b428afd@birger-koblitz.de>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277246-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 9BF793D2406
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Birger,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5c9e55fecf9365890c64f14761a80f9413a3b1d1]

url:    https://github.com/intel-lab-lkp/linux/commits/Birger-Koblitz/r8152-Add-support-for-RTL8157-RX-TX-descriptor-format/20260315-014044
base:   5c9e55fecf9365890c64f14761a80f9413a3b1d1
patch link:    https://lore.kernel.org/r/20260314-rtl8157_next-v1-2-9ba77b428afd%40birger-koblitz.de
patch subject: [PATCH net-next 2/9] r8152: Add support for RTL8157 SRAM access and ADV indirect access
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20260410/202604101309.B9mdviRN-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project c80443cd37b2e2788cba67ffa180a6331e5f0791)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260410/202604101309.B9mdviRN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604101309.B9mdviRN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/usb/r8152.c:1682:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1682 |         if (i == 10)
         |             ^~~~~~~
   drivers/net/usb/r8152.c:1685:9: note: uninitialized use occurs here
    1685 |         return ret;
         |                ^~~
   drivers/net/usb/r8152.c:1682:2: note: remove the 'if' if its condition is always true
    1682 |         if (i == 10)
         |         ^~~~~~~~~~~~
    1683 |                 ret = -ETIMEDOUT;
   drivers/net/usb/r8152.c:1672:12: note: initialize the variable 'ret' to silence this warning
    1672 |         int i, ret;
         |                   ^
         |                    = 0
   drivers/net/usb/r8152.c:1757:12: warning: unused function 'rtl_bmu_clr_bits' [-Wunused-function]
    1757 | static int rtl_bmu_clr_bits(struct r8152 *tp, u16 addr, u32 clear)
         |            ^~~~~~~~~~~~~~~~
   drivers/net/usb/r8152.c:1788:12: warning: unused function 'rtl_ip_clr_bits' [-Wunused-function]
    1788 | static int rtl_ip_clr_bits(struct r8152 *tp, u16 addr, u32 clear)
         |            ^~~~~~~~~~~~~~~
   drivers/net/usb/r8152.c:1793:12: warning: unused function 'rtl_ip_set_bits' [-Wunused-function]
    1793 | static int rtl_ip_set_bits(struct r8152 *tp, u16 addr, u32 set)
         |            ^~~~~~~~~~~~~~~
   drivers/net/usb/r8152.c:1810:13: warning: unused function 'sram_write_w0w1' [-Wunused-function]
    1810 | static void sram_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
         |             ^~~~~~~~~~~~~~~
   drivers/net/usb/r8152.c:1824:13: warning: unused function 'sram2_write_w0w1' [-Wunused-function]
    1824 | static void sram2_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
         |             ^~~~~~~~~~~~~~~~
   drivers/net/usb/r8152.c:9807:12: warning: unused function 'r8157_desc_init' [-Wunused-function]
    9807 | static int r8157_desc_init(struct r8152 *tp)
         |            ^~~~~~~~~~~~~~~
   7 warnings generated.


vim +1682 drivers/net/usb/r8152.c

  1669	
  1670	static int wait_cmd_ready(struct r8152 *tp, u16 cmd)
  1671	{
  1672		int i, ret;
  1673	
  1674		for (i = 0; i < 10; i++) {
  1675			u16 ocp_data = ocp_read_word(tp, MCU_TYPE_USB, cmd);
  1676	
  1677			if (!(ocp_data & ADV_CMD_BUSY))
  1678				break;
  1679			usleep_range(1000, 2000);
  1680		}
  1681	
> 1682		if (i == 10)
  1683			ret = -ETIMEDOUT;
  1684	
  1685		return ret;
  1686	}
  1687	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

