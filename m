Return-Path: <netdev+bounces-108802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A062925A23
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E96D1C2480A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 10:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEB91836FF;
	Wed,  3 Jul 2024 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJOnaLoQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3616F136E2A;
	Wed,  3 Jul 2024 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003553; cv=none; b=gkaC98rD9NnWjpzQHGocsnDlVGGFKSkuIlvYUh9jketWyGPDyNU8w13kdt81tgu0XNkVmEpLTRmMvRh8x4sWWR40DF1KiAVZ43i0WZt5RgTFc8QnFHWYswvRx3tQpjYPRumMFqqsNAuMY91JZw5pSapaR4jOXuzcfKIAR2HxbfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003553; c=relaxed/simple;
	bh=ybZI4gJNmFnoEu3H9cWbSOw6kCgX8A39RFgpl/yKhZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JniM/DMu9njpwlGpwkjt2RD3KWHAuU9zo1AQWh+V4iu+mNYOozqOV7hIbOMMNAYCSMuhQN2noTAk1XXU8ERShka5yypo3M7Kvyjckh3RKjBeOUFQ2jXzR87x+yk0p0AeSxTMf2xNC7WsJ7iRraBOrWPYBRodQj7nblLVKEj/GFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJOnaLoQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720003551; x=1751539551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ybZI4gJNmFnoEu3H9cWbSOw6kCgX8A39RFgpl/yKhZE=;
  b=LJOnaLoQAYC1sPRYS76IwwMcMjcbCgIka1AbHykWmJnEYYAdUIa/Xw9d
   yRQNjnqIsVRdiJjT6R4PfnOzHnMjKyrZO8meeSY4jVYvjgzpYkAv+CFLy
   8RX8eR/tqNazKlW19Pagl5MwNzOVHTEjY7j8xq3NufrsUowWfXcKhrpLe
   n0rO84YeKyVXqHz+2pQMbnbm9eixztbjrbHxrpQiOfzecNdD/oKFia4wZ
   HZhJM/tRFc29BoCr5Hvu2LqPhMhQUTyxl5j2Z7ExmDmj4pSyCv8KpB4pW
   djZljblugejhFmiHMxurWa0DA4b1K2DaaDP5zX2pb1FGar61KK8VMXNcH
   A==;
X-CSE-ConnectionGUID: WUia96+hT8mjiJmiChBHcg==
X-CSE-MsgGUID: NqrdvJGpS8SF6Jv8bAenYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="28617588"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="28617588"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 03:45:50 -0700
X-CSE-ConnectionGUID: mGFZsjhpSDavh5I/wmDnYw==
X-CSE-MsgGUID: koyajHxJR5q0JcInXI98ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="76947966"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 03:45:48 -0700
Date: Wed, 3 Jul 2024 12:44:27 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v7 00/10] Introduce RVU representors
Message-ID: <ZoUri0XggubbjQvg@mev-dev.igk.intel.com>
References: <20240628133517.8591-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628133517.8591-1-gakula@marvell.com>

On Fri, Jun 28, 2024 at 07:05:07PM +0530, Geetha sowjanya wrote:
> This series adds representor support for each rvu devices.
> When switchdev mode is enabled, representor netdev is registered
> for each rvu device. In implementation of representor model, 
> one NIX HW LF with multiple SQ and RQ is reserved, where each
> RQ and SQ of the LF are mapped to a representor. A loopback channel
> is reserved to support packet path between representors and VFs.
> CN10K silicon supports 2 types of MACs, RPM and SDP. This
> patch set adds representor support for both RPM and SDP MAC
> interfaces.
> 
> - Patch 1: Refactors and exports the shared service functions.
> - Patch 2: Implements basic representor driver.
> - Patch 3: Add devlink support to create representor netdevs that
>   can be used to manage VFs.
> - Patch 4: Implements basec netdev_ndo_ops.
> - Patch 5: Installs tcam rules to route packets between representor and
> 	   VFs.
> - Patch 6: Enables fetching VF stats via representor interface
> - Patch 7: Adds support to sync link state between representors and VFs .
> - Patch 8: Enables configuring VF MTU via representor netdevs.
> - Patch 9: Add representors for sdp MAC.
> - Patch 10: Add devlink port support.
> 
> Command to create VF representor
> #devlink dev eswitch set pci/0002:1c:00.0 mode switchdev
> VF representors are created for each VF when switch mode is set switchdev on representor PCI device

Does it mean that VFs needs to be created before going to switchdev
mode? (in legacy mode). Keep in mind that in both mellanox and ice
driver assume that VFs are created after chaning mode to switchdev (mode
can't be changed if VFs).

Different order can be problematic. For example (AFAIK) kubernetes
scripts for switchdev assume that first is switching to switchdev and
VFs creation is done after that.

Thanks,
Michal

> # devlink dev eswitch set pci/0002:1c:00.0  mode switchdev 
> # ip link show
> 25: r0p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 32:0f:0f:f0:60:f1 brd ff:ff:ff:ff:ff:ff
> 26: r1p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 3e:5d:9a:4d:e7:7b brd ff:ff:ff:ff:ff:ff
> 
> #devlink dev
> pci/0002:01:00.0
> pci/0002:02:00.0
> pci/0002:03:00.0
> pci/0002:04:00.0
> pci/0002:05:00.0
> pci/0002:06:00.0
> pci/0002:07:00.0
> 
> ~# devlink port
> pci/0002:1c:00.0/0: type eth netdev r0p1v0 flavour pcipf controller 0 pfnum 1 vfnum 0 external false splittable false
> pci/0002:1c:00.0/1: type eth netdev r1p1v1 flavour pcivf controller 0 pfnum 1 vfnum 1 external false splittable false
> pci/0002:1c:00.0/2: type eth netdev r2p1v2 flavour pcivf controller 0 pfnum 1 vfnum 2 external false splittable false
> pci/0002:1c:00.0/3: type eth netdev r3p1v3 flavour pcivf controller 0 pfnum 1 vfnum 3 external false splittable false
> 
> -----------
> v1-v2:
>  -Fixed build warnings.
>  -Address review comments provided by "Kalesh Anakkur Purayil".
> 
> v2-v3:
>  - Used extack for error messages.
>  - As suggested reworked commit messages.
>  - Fixed sparse warning.
> 
> v3-v4: 
>  - Patch 2 & 3: Fixed coccinelle reported warnings.
>  - Patch 10: Added devlink port support.
> 
> v4-v5:
>   - Patch 3: Removed devm_* usage in rvu_rep_create()
>   - Patch 3: Fixed build warnings.
> 
> v5-v6:
>   - Addressed review comments provided by "Simon Horman".
>   - Added review tag. 
> 
> v6-v7:
>   - Rebased on top net-next branch.
> 
> Geetha sowjanya (10):
>   octeontx2-pf: Refactoring RVU driver
>   octeontx2-pf: RVU representor driver
>   octeontx2-pf: Create representor netdev
>   octeontx2-pf: Add basic net_device_ops
>   octeontx2-af: Add packet path between representor and VF
>   octeontx2-pf: Get VF stats via representor
>   octeontx2-pf: Add support to sync link state between representor and
>     VFs
>   octeontx2-pf: Configure VF mtu via representor
>   octeontx2-pf: Add representors for sdp MAC
>   octeontx2-pf: Add devlink port support
> 
>  .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
>  .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
>  .../ethernet/marvell/octeontx2/af/common.h    |   2 +
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |  74 ++
>  .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
>  .../net/ethernet/marvell/octeontx2/af/rvu.c   |  11 +
>  .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
>  .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
>  .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
>  .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  81 ++-
>  .../marvell/octeontx2/af/rvu_npc_fs.c         |   5 +
>  .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   4 +
>  .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 464 ++++++++++++
>  .../marvell/octeontx2/af/rvu_struct.h         |  26 +
>  .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
>  .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
>  .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
>  .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
>  .../marvell/octeontx2/nic/otx2_common.c       |  56 +-
>  .../marvell/octeontx2/nic/otx2_common.h       |  84 ++-
>  .../marvell/octeontx2/nic/otx2_devlink.c      |  49 ++
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 305 +++++---
>  .../marvell/octeontx2/nic/otx2_txrx.c         |  38 +-
>  .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
>  .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  19 +-
>  .../net/ethernet/marvell/octeontx2/nic/rep.c  | 684 ++++++++++++++++++
>  .../net/ethernet/marvell/octeontx2/nic/rep.h  |  53 ++
>  27 files changed, 1834 insertions(+), 227 deletions(-)
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h
> 
> -- 
> 2.25.1
> 

