Return-Path: <netdev+bounces-109114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47CF92705A
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 09:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF28A1C2278F
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 07:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE601A0AFA;
	Thu,  4 Jul 2024 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+04g6wU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1866170836;
	Thu,  4 Jul 2024 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720077371; cv=none; b=nJtC4dbCAGL8jGZkkX+ajlxaR7GS5jPjvmt0ExTQC7pNS/wwLnS2t/z00Ev8cd+fe1f3fdv3SAN7u7XQDBGmD/0A+sg6qdaejJrjmzyHG3xwvtZMaZainKH14YuYowB09Lcl/Eo116ftPaL4bzKd7F0kT9+ASRmAHwi1QF8GH4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720077371; c=relaxed/simple;
	bh=ykK2NmqiAhRxDgi+CJocifOaQpjFRrk4m3nuxZ7ne5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R72CjNNTgsHpx2wVAP6etwwVeliAQ/lXtWRRWLfcjLLSwTo7hIA3ut6GpH4dnGt0cTnqTN8d/f+A6BgWDAFDEhMOm3/mn9xgeIWBDxpf82XIvWpYvb4fPETaHSNnFHmscjiWl3I2u1Z3fTyocXVzDRLIahqtfKK8Se6Df7+YpEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+04g6wU; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720077370; x=1751613370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ykK2NmqiAhRxDgi+CJocifOaQpjFRrk4m3nuxZ7ne5s=;
  b=S+04g6wUgG0iE/PKYJtsLity3nipXCCi2Ob3OAapSYwAE+x51oCM/2pf
   JEPC89+IL8ZO6dGrwRz8C40unsIqJZClYcJK2N4hn14D7hsfMN7U+D0Zg
   kU0CigaqI5Qe5QrSjOrirxyCeovhsOCAItthqK+okWvqAAleren+ssPM3
   MidW5Y5Jv7KnNaVZdiRpo2G3Xuc7XsxY0Z5yT0lvF/z0pF057bKhXtRXJ
   Og+8uKse4gLOzHXKOHipge6t/KiO31xsu1Kk/9OBwXvCUw/Yn+pU2kCEG
   mnEwSJ273fQ32xXmdKLNz8XZ3Er2QnyxKtYA/0FQUwJdSEMpvnL6Dro5Y
   Q==;
X-CSE-ConnectionGUID: uyCLFcZ0TyCSssg0GgIwIg==
X-CSE-MsgGUID: sWEDoBatSkKVbED4LFowYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17174898"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17174898"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 00:16:10 -0700
X-CSE-ConnectionGUID: pevV34pxT9WgreqQaTK5og==
X-CSE-MsgGUID: dh3meRwSR3mxkmSNK3eLxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="77246664"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 00:16:06 -0700
Date: Thu, 4 Jul 2024 09:14:52 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Geethasowjanya Akula <gakula@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [EXTERNAL] Re: [net-next PATCH v7 00/10] Introduce RVU
 representors
Message-ID: <ZoZL7Hc5l3amIxIs@mev-dev.igk.intel.com>
References: <20240628133517.8591-1-gakula@marvell.com>
 <ZoUri0XggubbjQvg@mev-dev.igk.intel.com>
 <CH0PR18MB4339D4A85FA97B2136BF7E1CCDDD2@CH0PR18MB4339.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR18MB4339D4A85FA97B2136BF7E1CCDDD2@CH0PR18MB4339.namprd18.prod.outlook.com>

On Wed, Jul 03, 2024 at 02:34:03PM +0000, Geethasowjanya Akula wrote:
> 
> 
> >-----Original Message-----
> >From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >Sent: Wednesday, July 3, 2024 4:14 PM
> >To: Geethasowjanya Akula <gakula@marvell.com>
> >Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
> >davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> >Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> ><sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> >Subject: [EXTERNAL] Re: [net-next PATCH v7 00/10] Introduce RVU representors
> >On Fri, Jun 28, 2024 at 07:05:07PM +0530, Geetha sowjanya wrote:
> >> This series adds representor support for each rvu devices.
> >> When switchdev mode is enabled, representor netdev is registered for
> >> each rvu device. In implementation of representor model, one NIX HW LF
> >> with multiple SQ and RQ is reserved, where each RQ and SQ of the LF
> >> are mapped to a representor. A loopback channel is reserved to support
> >> packet path between representors and VFs.
> >> CN10K silicon supports 2 types of MACs, RPM and SDP. This patch set
> >> adds representor support for both RPM and SDP MAC interfaces.
> >>
> >> - Patch 1: Refactors and exports the shared service functions.
> >> - Patch 2: Implements basic representor driver.
> >> - Patch 3: Add devlink support to create representor netdevs that
> >>   can be used to manage VFs.
> >> - Patch 4: Implements basec netdev_ndo_ops.
> >> - Patch 5: Installs tcam rules to route packets between representor and
> >> 	   VFs.
> >> - Patch 6: Enables fetching VF stats via representor interface
> >> - Patch 7: Adds support to sync link state between representors and VFs .
> >> - Patch 8: Enables configuring VF MTU via representor netdevs.
> >> - Patch 9: Add representors for sdp MAC.
> >> - Patch 10: Add devlink port support.
> >>
> >> Command to create VF representor
> >> #devlink dev eswitch set pci/0002:1c:00.0 mode switchdev VF
> >> representors are created for each VF when switch mode is set switchdev
> >> on representor PCI device
> >
> >Does it mean that VFs needs to be created before going to switchdev mode? (in
> >legacy mode). Keep in mind that in both mellanox and ice driver assume that
> >VFs are created after chaning mode to switchdev (mode can't be changed if
> >VFs).
> No. RVU representor driver implementation is similar to mellanox and ice drivers. 
> It assumes that VF gets created only after switchdev mode is enabled. 
> Sorry, if above commit description is confusing. Will rewrite it.
>   

Ok, but why the rvu_rep_create() is called in switching mode to
switchdev function? In this function you are creating netdevs, only for PF
representor? It looks like it doesn't called from other context in this
patchset, so where the port representor netdevs for VFs are created?

Thanks,
Michal

> >
> >Different order can be problematic. For example (AFAIK) kubernetes scripts for
> >switchdev assume that first is switching to switchdev and VFs creation is done
> >after that.
> >
> >Thanks,
> >Michal
> >
> >> # devlink dev eswitch set pci/0002:1c:00.0  mode switchdev # ip link
> >> show
> >> 25: r0p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode
> >DEFAULT group default qlen 1000
> >>     link/ether 32:0f:0f:f0:60:f1 brd ff:ff:ff:ff:ff:ff
> >> 26: r1p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode
> >DEFAULT group default qlen 1000
> >>     link/ether 3e:5d:9a:4d:e7:7b brd ff:ff:ff:ff:ff:ff
> >>
> >> #devlink dev
> >> pci/0002:01:00.0
> >> pci/0002:02:00.0
> >> pci/0002:03:00.0
> >> pci/0002:04:00.0
> >> pci/0002:05:00.0
> >> pci/0002:06:00.0
> >> pci/0002:07:00.0
> >>
> >> ~# devlink port
> >> pci/0002:1c:00.0/0: type eth netdev r0p1v0 flavour pcipf controller 0
> >> pfnum 1 vfnum 0 external false splittable false
> >> pci/0002:1c:00.0/1: type eth netdev r1p1v1 flavour pcivf controller 0
> >> pfnum 1 vfnum 1 external false splittable false
> >> pci/0002:1c:00.0/2: type eth netdev r2p1v2 flavour pcivf controller 0
> >> pfnum 1 vfnum 2 external false splittable false
> >> pci/0002:1c:00.0/3: type eth netdev r3p1v3 flavour pcivf controller 0
> >> pfnum 1 vfnum 3 external false splittable false
> >>
> >> -----------
> >> v1-v2:
> >>  -Fixed build warnings.
> >>  -Address review comments provided by "Kalesh Anakkur Purayil".
> >>
> >> v2-v3:
> >>  - Used extack for error messages.
> >>  - As suggested reworked commit messages.
> >>  - Fixed sparse warning.
> >>
> >> v3-v4:
> >>  - Patch 2 & 3: Fixed coccinelle reported warnings.
> >>  - Patch 10: Added devlink port support.
> >>
> >> v4-v5:
> >>   - Patch 3: Removed devm_* usage in rvu_rep_create()
> >>   - Patch 3: Fixed build warnings.
> >>
> >> v5-v6:
> >>   - Addressed review comments provided by "Simon Horman".
> >>   - Added review tag.
> >>
> >> v6-v7:
> >>   - Rebased on top net-next branch.
> >>
> >> Geetha sowjanya (10):
> >>   octeontx2-pf: Refactoring RVU driver
> >>   octeontx2-pf: RVU representor driver
> >>   octeontx2-pf: Create representor netdev
> >>   octeontx2-pf: Add basic net_device_ops
> >>   octeontx2-af: Add packet path between representor and VF
> >>   octeontx2-pf: Get VF stats via representor
> >>   octeontx2-pf: Add support to sync link state between representor and
> >>     VFs
> >>   octeontx2-pf: Configure VF mtu via representor
> >>   octeontx2-pf: Add representors for sdp MAC
> >>   octeontx2-pf: Add devlink port support
> >>
> >>  .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
> >>  .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
> >>  .../ethernet/marvell/octeontx2/af/common.h    |   2 +
> >>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |  74 ++
> >>  .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
> >>  .../net/ethernet/marvell/octeontx2/af/rvu.c   |  11 +
> >>  .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
> >>  .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
> >>  .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
> >>  .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  81 ++-
> >>  .../marvell/octeontx2/af/rvu_npc_fs.c         |   5 +
> >>  .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   4 +
> >>  .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 464 ++++++++++++
> >>  .../marvell/octeontx2/af/rvu_struct.h         |  26 +
> >>  .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
> >>  .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
> >>  .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
> >>  .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
> >>  .../marvell/octeontx2/nic/otx2_common.c       |  56 +-
> >>  .../marvell/octeontx2/nic/otx2_common.h       |  84 ++-
> >>  .../marvell/octeontx2/nic/otx2_devlink.c      |  49 ++
> >>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 305 +++++---
> >>  .../marvell/octeontx2/nic/otx2_txrx.c         |  38 +-
> >>  .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
> >>  .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  19 +-
> >> .../net/ethernet/marvell/octeontx2/nic/rep.c  | 684 ++++++++++++++++++
> >> .../net/ethernet/marvell/octeontx2/nic/rep.h  |  53 ++
> >>  27 files changed, 1834 insertions(+), 227 deletions(-)  create mode
> >> 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> >>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> >>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h
> >>
> >> --
> >> 2.25.1
> >>

