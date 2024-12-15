Return-Path: <netdev+bounces-152040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 155B99F269E
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 23:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C9D7A1418
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772B31C07C0;
	Sun, 15 Dec 2024 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7F20L5Z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F561E502;
	Sun, 15 Dec 2024 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734302316; cv=none; b=JvvxaBSSFuE2iGL++e28bgOuG//hgv+QmgZsB7Rw8C5l5XQH377Hj2ipKvVyvGn9xbPsL802eQFcL5gtDMLqbzSAlI0obYqmonHrnSssIYIABNkiKbp1OiHAWuYoy4XAyOayO6xgpxowB7gpdGhO395XSWyrVwSHHszfpsK+aeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734302316; c=relaxed/simple;
	bh=DJzqfLQxGe5G83lYAkMGNROuLprTGLPHr/4zHYMfAiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKRGq38eE1RN2yQyiA0uGiXkSpkIwpAVUEr6Uh58ykjEw3XuOQYABQdG/TTNS5qs8jo0WSRw8QUvNZmkLpKxNsbbOECv/TE7jIi/Lk7k/BZJ+FQJTnLMcGb6qKmN2d0U0Bvfh52n1A+8VxDHz2uvF4Lmnkoq9DOGQCHaelDTloQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7F20L5Z; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734302314; x=1765838314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DJzqfLQxGe5G83lYAkMGNROuLprTGLPHr/4zHYMfAiY=;
  b=O7F20L5ZE1bslBRaudvrwJd+uqkdiClYBhFhkn8GajQF3WfgUdUQgWi9
   VcfKw+bEBcCMU4remQi/wC0Z8lEqgVllxqGWXCSGfJJiKlfUtA8BplzFt
   aV4XicwDFyb3bnO2dX20byy1ds/kQWzP/NUpMExlsG7WZXukMLOX21Zlh
   /Vq9RIgJB9y82fwxVFN8T2XtNDf32c1JxmX7V4G2PTTKVcAWzMuTSfyW9
   ukwMGGET+eSZXEH8GFO1h0FWm/2+H1K6ipO3t3o6gH+Z5pcpATa5s1L0y
   QmR36Vznj+7YfU/jNTf2YjOlP6xTbzeTyZIu7PzJSxXTRO9DKyT7/vHCQ
   A==;
X-CSE-ConnectionGUID: SoQp70EQSKWpzuTKGkeuJA==
X-CSE-MsgGUID: IL7q1NqIR/2xa4ctu/sSUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="33979690"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="33979690"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 14:38:33 -0800
X-CSE-ConnectionGUID: P/NU1gctRyGXdPtF38Vflg==
X-CSE-MsgGUID: jMsGun9kQ1WzzwJl+hJiXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="97445581"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 15 Dec 2024 14:38:31 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMxFs-000DtG-1s;
	Sun, 15 Dec 2024 22:38:28 +0000
Date: Mon, 16 Dec 2024 06:38:04 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Buffet <matthieu@buffet.re>, Mickael Salaun <mic@digikod.net>
Cc: oe-kbuild-all@lists.linux.dev, Gunther Noack <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: Re: [PATCH v2 3/6] landlock: Add UDP sendmsg access control
Message-ID: <202412160648.ACrVdKoZ-lkp@intel.com>
References: <20241214184540.3835222-4-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214184540.3835222-4-matthieu@buffet.re>

Hi Matthieu,

kernel test robot noticed the following build errors:

[auto build test ERROR on adc218676eef25575469234709c2d87185ca223a]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthieu-Buffet/landlock-Add-UDP-bind-connect-access-control/20241215-025450
base:   adc218676eef25575469234709c2d87185ca223a
patch link:    https://lore.kernel.org/r/20241214184540.3835222-4-matthieu%40buffet.re
patch subject: [PATCH v2 3/6] landlock: Add UDP sendmsg access control
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20241216/202412160648.ACrVdKoZ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241216/202412160648.ACrVdKoZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412160648.ACrVdKoZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: security/landlock/net.o: in function `hook_socket_sendmsg':
>> net.c:(.text.hook_socket_sendmsg+0x288): undefined reference to `udpv6_prot'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

