Return-Path: <netdev+bounces-131246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E3298DB34
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D33A3B27365
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AAA1D278D;
	Wed,  2 Oct 2024 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzBjnV34"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A391D2200;
	Wed,  2 Oct 2024 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879043; cv=none; b=iOhkX/oYCttVZRe1W5fYYhnSY/6cGAg4Np0ul0NZcMtgsv8LNf2SZM0Fo0hlVf0zVbet3Yu3GGGTY0OV5FR/G0adq0TVD452iGZqQMGxRmdSzoU0662Voq0CBjVjrfSlqDJjqxOHd69XtLrcCYF+TLfH4BPbDLFIb5So/Fuuvbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879043; c=relaxed/simple;
	bh=Uifoq9W+pgwn1gnQ9Gh5rIYiDY0jXPiUILaJrnu2UJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjKeR7MeJALW/HANkl3Sk1c3Lln49T9Ri8QQ2cOY4kLFT/E5mOWgLFo20SroREsEN4yiB35ovwC769yz6nTaISpqqgLTaAzwAmss1u4ur7UwqGLt8H7CmsTojO6nUwcX2g1tZq45ZKDjmjCt7nt8juVG29LaUWYKLmozCqW9xgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzBjnV34; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727879042; x=1759415042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uifoq9W+pgwn1gnQ9Gh5rIYiDY0jXPiUILaJrnu2UJY=;
  b=CzBjnV34CyTEwKZpff5pbhzY1PpDlA78YB37YV9vXQheFxTL8vQ2g4Eo
   9XDdsvj5J7JndRnwxZEUZFMtNFz/2nbiZ9GkZSKcd80CyGgKEZJ42/bB3
   taFw5ICugz9+bDMd6Y6IAB/ALKdMfbHVoh1r/13LkLmNZ/6SBXiG7g4S3
   Erkc6Tzqq3c5uD3VSSeob0AQZ5ENuraceNJSOQM2g+FxdnVFEvM4tmSJH
   OnGPEG2Uja1T3p6uROlUbVO93ckOqfWNCYqjftOxnysb8bKH34bnlNiBj
   gsAOPv51yq/rq+BGm8M84BjPSKjdtVFVeOCXYDQOlRJ8l0WJZ7u1Eveph
   A==;
X-CSE-ConnectionGUID: WGlMmQVtRiqDGow4odV3fQ==
X-CSE-MsgGUID: RRsHmes0R4GIhhDKpg/7ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27175292"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="27175292"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 07:24:01 -0700
X-CSE-ConnectionGUID: 7yzksKgOS7OkL5rW9VAJzw==
X-CSE-MsgGUID: 2m2UcsrNQde4t9xi3GMTkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="74828625"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 02 Oct 2024 07:23:58 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sw0Gh-000TT7-1p;
	Wed, 02 Oct 2024 14:23:55 +0000
Date: Wed, 2 Oct 2024 22:23:25 +0800
From: kernel test robot <lkp@intel.com>
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: oe-kbuild-all@lists.linux.dev, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next] net: Implement fault injection forcing skb
 reallocation
Message-ID: <202410022209.2TB3siPB-lkp@intel.com>
References: <20241002113316.2527669-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002113316.2527669-1-leitao@debian.org>

Hi Breno,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Breno-Leitao/net-Implement-fault-injection-forcing-skb-reallocation/20241002-193852
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241002113316.2527669-1-leitao%40debian.org
patch subject: [PATCH net-next] net: Implement fault injection forcing skb reallocation
reproduce: (https://download.01.org/0day-ci/archive/20241002/202410022209.2TB3siPB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410022209.2TB3siPB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
   Warning: Documentation/userspace-api/netlink/index.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: Documentation/userspace-api/netlink/specs.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>> Warning: net/Kconfig.debug references a file that doesn't exist: Documentation/dev-tools/fault-injection/fault-injection.rst
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

