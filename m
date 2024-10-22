Return-Path: <netdev+bounces-137705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4ACF9A968F
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 05:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2F928345D
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 03:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D84D13A256;
	Tue, 22 Oct 2024 03:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dLcX4Qe3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45828E8;
	Tue, 22 Oct 2024 03:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566734; cv=none; b=XUxj2yoX+iA4382rZExWHIiyOsCUurKY5RD3WKPo7Fuwo/39sRzZrOq5tUFxqwlk8/wXJUuYu9pR7JaQcr2AaTqtqrEigRCeCCAyDyuZQFvtVcEqKaliI6WKfJUWg8s2Y26WdtX1D63T08nVk7q2ToneDWnXwVucaEO1nTo3svA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566734; c=relaxed/simple;
	bh=3YHkXyk0hl2jqIBCwCWhBOAYI/fCkzb2NdRgpLLCU5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMj75lPwmzJRePg7m/Xod5WXBe7i9KOLCOiu1bjKwI0c5l5hhzZz+fTWoB8tb6mcUkbglHn6QUUPVwdBs5FQxevABBblBFkCIqBCnjAx043dE8l+v38jWEUICgh+vgEhIgem+qQP5WRN8rE8BLbzkKcBaYwL6afzLuu+UuFyflA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dLcX4Qe3; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729566733; x=1761102733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3YHkXyk0hl2jqIBCwCWhBOAYI/fCkzb2NdRgpLLCU5Q=;
  b=dLcX4Qe3T27mS9qDsMSyWCHuafBfO1MN0ORHc/1Pub+B/MyvtIzdBnL2
   78pkaG/ig8KbTCgPPVZDc5eW4f2xXqDHfT/h+dL/OGP4FQ0xu4YD4FCdZ
   ix6xxTXogC81uUkqM3MbtD8IiAxGQhXM5lfTQ+BxZTvtR6ZKL2vD0mzAh
   B6xCc4upQfOxS3eJpuuSPrgcKfO/iasVqwefhI7e3/2v58X8W/CPTfWTI
   RJQ0UOn3J+Nw5RURHIEzbHKTAbmh8I5/85xMWAKsGq7u3VMvLPd0OzXZE
   DWyE9A+9qlH2D3kaF8/A6aHOuUHerVbrcrTTRBqRy3aTYgX9Z8fzvG0T2
   g==;
X-CSE-ConnectionGUID: VSrXkCD4RZChtE/HVp1aQQ==
X-CSE-MsgGUID: yE/SnpRBTGe5NfAqpzvUag==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="40466009"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="40466009"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 20:12:12 -0700
X-CSE-ConnectionGUID: zsn6Wc6LS9eHXrxUcRxjlg==
X-CSE-MsgGUID: r+4nQiC/R4m76eLBFmS8XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="80082482"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 21 Oct 2024 20:12:08 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t35JW-000Syw-2R;
	Tue, 22 Oct 2024 03:12:06 +0000
Date: Tue, 22 Oct 2024 11:11:33 +0800
From: kernel test robot <lkp@intel.com>
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: dsa: vsc73xx: implement transmit via
 control interface
Message-ID: <202410221001.KrzTEU3A-lkp@intel.com>
References: <20241020205452.2660042-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020205452.2660042-1-paweldembicki@gmail.com>

Hi Pawel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Pawel-Dembicki/net-dsa-vsc73xx-implement-packet-reception-via-control-interface/20241021-050041
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241020205452.2660042-1-paweldembicki%40gmail.com
patch subject: [PATCH net-next 1/3] net: dsa: vsc73xx: implement transmit via control interface
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20241022/202410221001.KrzTEU3A-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241022/202410221001.KrzTEU3A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410221001.KrzTEU3A-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/dsa/vitesse-vsc73xx-core.c: In function 'vsc73xx_inject_frame':
>> drivers/net/dsa/vitesse-vsc73xx-core.c:766:30: warning: argument to 'sizeof' in 'memset' call is the same expression as the destination; did you mean to dereference it? [-Wsizeof-pointer-memaccess]
     766 |         memset(buf, 0, sizeof(buf));
         |                              ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +766 drivers/net/dsa/vitesse-vsc73xx-core.c

   750	
   751	static int
   752	vsc73xx_inject_frame(struct vsc73xx *vsc, int port, struct sk_buff *skb)
   753	{
   754		struct vsc73xx_ifh *ifh;
   755		u32 length, i, count;
   756		u32 *buf;
   757		int ret;
   758	
   759		if (skb->len + VSC73XX_IFH_SIZE < 64)
   760			length = 64;
   761		else
   762			length = skb->len + VSC73XX_IFH_SIZE;
   763	
   764		count = DIV_ROUND_UP(length, 8);
   765		buf = kzalloc(count * 8, GFP_KERNEL);
 > 766		memset(buf, 0, sizeof(buf));
   767	
   768		ifh = (struct vsc73xx_ifh *)buf;
   769		ifh->frame_length = skb->len;
   770		ifh->magic = VSC73XX_IFH_MAGIC;
   771	
   772		skb_copy_and_csum_dev(skb, (u8 *)(buf + 2));
   773	
   774		for (i = 0; i < count; i++) {
   775			ret = vsc73xx_write_tx_fifo(vsc, port, buf[2 * i],
   776						    buf[2 * i + 1]);
   777			if (ret) {
   778				/* Clear buffer after error */
   779				vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
   780						    VSC73XX_MISCFIFO,
   781						    VSC73XX_MISCFIFO_REWIND_CPU_TX,
   782						    VSC73XX_MISCFIFO_REWIND_CPU_TX);
   783				goto err;
   784			}
   785		}
   786	
   787		vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MISCFIFO,
   788			      VSC73XX_MISCFIFO_CPU_TX);
   789	
   790		skb_tx_timestamp(skb);
   791	
   792		skb->dev->stats.tx_packets++;
   793		skb->dev->stats.tx_bytes += skb->len;
   794	err:
   795		kfree(buf);
   796		return ret;
   797	}
   798	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

