Return-Path: <netdev+bounces-173366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC301A58787
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 20:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDDA1169614
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 19:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5E61E5205;
	Sun,  9 Mar 2025 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XSUrHM+A"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67A16A959;
	Sun,  9 Mar 2025 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741548419; cv=none; b=l578v+JZQhBvpBUTsea7SlK83Wy4DBH1AtrNvNVWarbbCY1EwhOVw7zfq64tjuhR3L12MGYpla1JAs9oL7HeK2viGOi4heRYEN79IiIpkt9e7+Bk7xwGx1KCDJzxDETyU3rArvdu6W9O+18+nWD5s4Zm3AbtjWlMJyuuSLdQDQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741548419; c=relaxed/simple;
	bh=Dk3dyE0dtJPnVxAV4n6omrRWpps5/OsjqC9n7SUzIAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpSTyFgyQJAtXQ+POHxHm+iQ+CkpBiiW9j3YQy30TQqX1bXF/k8LqmKnoSeOwFwnnFtUf4ExOJD//NHruhwuLGpEB3W6WuUJMFPmgHqbkTrZMdL/2TCP6oT5d6mDmNyoutMA0hMJNbpAuWGcGYZCAOhwsx4cj/zsFNG7L/LRirU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XSUrHM+A; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741548417; x=1773084417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dk3dyE0dtJPnVxAV4n6omrRWpps5/OsjqC9n7SUzIAY=;
  b=XSUrHM+AvsgTkyH0jGb22UiXdwXBsmFvcXnT3sZ22xM5Ul1w6rEkEPge
   YwRKUryn52j66sBKjF+qpOtILcJdV79HgdC8srvwuPs3bW8sXA6Zj3VUg
   jsNwkNLe+qXh/fKZkDOTmgHeZXyCT23F1loDFzizOFPYyNTCi1AveU2RU
   5QwcnSn9RWbYS7DjqSjZJ0a5mWTvZ89bIVYGQQYQlC/ZcAL989ug8vWkW
   iROywfm8lleMk7HvHLnnVii6RO9n+O+cwZdJkcn5BtNPtSIh+LpvtKcgg
   E++5g1ZUcQxsIbxwqqQ3tfGjwqbk/x7NVYFLugZoxVFSMT8GO/bxQuqVz
   Q==;
X-CSE-ConnectionGUID: HCja15hSQ/m3UipVP6OQwg==
X-CSE-MsgGUID: ghOLCTDiSx6uq0puh8hl2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42414966"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42414966"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 12:26:56 -0700
X-CSE-ConnectionGUID: UsC/pV4tTLOMuh37iVyUtw==
X-CSE-MsgGUID: 5kmuBSalTDaAtTsev3gd4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="120288769"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 09 Mar 2025 12:26:52 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trMIT-0003PE-1U;
	Sun, 09 Mar 2025 19:26:49 +0000
Date: Mon, 10 Mar 2025 03:26:18 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, upstream@airoha.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v12 05/13] dt-bindings: mfd: Document support
 for Airoha AN8855 Switch SoC
Message-ID: <202503100331.nksmBPCd-lkp@intel.com>
References: <20250309172717.9067-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309172717.9067-6-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-nvmem-Document-support-for-Airoha-AN8855-Switch-EFUSE/20250310-013306
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250309172717.9067-6-ansuelsmth%40gmail.com
patch subject: [net-next PATCH v12 05/13] dt-bindings: mfd: Document support for Airoha AN8855 Switch SoC
reproduce: (https://download.01.org/0day-ci/archive/20250310/202503100331.nksmBPCd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503100331.nksmBPCd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/translations/ja_JP/SubmittingPatches references a file that doesn't exist: linux-2.6.12-vanilla/Documentation/dontdiff
   Warning: Documentation/translations/zh_CN/admin-guide/README.rst references a file that doesn't exist: Documentation/dev-tools/kgdb.rst
   Warning: Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
   Warning: Documentation/translations/zh_TW/admin-guide/README.rst references a file that doesn't exist: Documentation/dev-tools/kgdb.rst
   Warning: Documentation/translations/zh_TW/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/mfd/airoha,an8855-mfd.yaml
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml
   Warning: lib/Kconfig.debug references a file that doesn't exist: Documentation/dev-tools/fault-injection/fault-injection.rst
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

