Return-Path: <netdev+bounces-306699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lNfUJdZpUWomEQMAu9opvQ
	(envelope-from <netdev+bounces-306699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:53:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9E473F2C1
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:53:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=OfMxnKjI;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306699-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306699-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AFD33018BC2
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433E83AFD18;
	Fri, 10 Jul 2026 21:53:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1D030567C;
	Fri, 10 Jul 2026 21:53:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783720403; cv=none; b=lpTqQegllt5sQd1vANFcHVF1ZfW6gyCRrB7glRzuDQZRU3BWePAtlCHiagNGfJ+1UeyfXOQn2rSjPH0+H43i7FrKcfOq/M159a7maH2E3S5pcjmH3qXUtOMeF6a8V5buZr3qiM6GkftweAGfhMLm4scscQZJ3PDliQIicsuS5TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783720403; c=relaxed/simple;
	bh=6BoU1Q9AHRZz56zPu7yOCSHAbp5seCNimVQupDnva20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SMeqAplH8bgbCJONoI3C44rYzXCwvA0j2JZwxxJBZ0K9wsGIdlt2dwuEO2s84E0yRkEPXIB7JbMYAqXptbCzTln8tFkXhgCGMEmKphf5d/lx70tl945HlHwAylnl8ynuF9DY7x+UIAgL30dElmIo/pzpGdDHcE5vEQG3Id5fQuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfMxnKjI; arc=none smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783720402; x=1815256402;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6BoU1Q9AHRZz56zPu7yOCSHAbp5seCNimVQupDnva20=;
  b=OfMxnKjIQvHSqmnGhCW7B4MH05+Y+nB6WA0bJSj5nDt9StMEk2Tnt1+X
   ntouspMBxwIj+VIhsL5ZSgxmiBnNm+Us+uoft5NgALEZLNCdq++yS+yGW
   dmAHukOgVHAKVTj6JQyHWz7Vq4K7KUfE/EB1xwVk971gSO9CorILtyvuC
   N18irKV0Lb1+jy6X8xNS/u3Li3Vc4tO83C/Hdt4SVc9ubR9o/x+/YFhUm
   USE3oiYr9L+csCHLu7tsTxb4fptOnpmC4MyXBTV2Go22vY446ZyEi5JeK
   zibU0XpDy0qg8hUK0WRTFx/NV5JGLrRt70fMWVb/1WCjrWATh1hz8K5GV
   w==;
X-CSE-ConnectionGUID: 2mz7+7X+Sd6ATF016kus5g==
X-CSE-MsgGUID: EykyifdBQx+QzwwFia1TvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="107220695"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="107220695"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 14:53:21 -0700
X-CSE-ConnectionGUID: x9FLI9bTS+SFP8+82oZUvw==
X-CSE-MsgGUID: 7tB5Zp02QZu6FyXPeTWxKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254494609"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 10 Jul 2026 14:53:20 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	larysa.zaremba@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	anjali.singhai@intel.com,
	michal.swiatkowski@linux.intel.com,
	maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com,
	madhu.chittim@intel.com,
	joshua.a.hay@intel.com,
	jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	richardcochran@gmail.com,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v4 00/15][pull request] Introduce iXD driver
Date: Fri, 10 Jul 2026 14:52:57 -0700
Message-ID: <20260710215313.1475803-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306699-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:larysa.zaremba@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:anjali.singhai@intel.com,m:michal.swiatkowski@linux.intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:madhu.chittim@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:dkim,intel.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE9E473F2C1

Larysa Zaremba says:

This patch series adds the iXD driver, which supports the Intel(R)
Control Plane PCI Function on Intel E2100 and later IPUs and FNICs.
It facilitates a centralized control over multiple IDPF PFs/VFs/SFs
exposed by the same card. The reason for the separation is to be able
to offload the control plane to the host different from where the data
plane is running.

This is the first phase in the release of this driver where we implement the
initialization of the core PCI driver. Subsequent phases will implement
advanced features like usage of idpf ethernet aux device, link management,
NVM update via devlink, switchdev port representors, data and exception path,
flow rule programming, etc.

The first phase entails the following aspects:

1. Additional libie functionalities:
Patches 1-5 introduce additional common library API for drivers to
communicate with the control plane through mailbox communication.
A control queue is a hardware interface which is used by the driver
to interact with other subsystems (like firmware). The library APIs
allow the driver to setup and configure the control queues to send and
receive virtchnl messages. The library has an internal bookkeeping
(XN API) mechanism to keep track of the send messages. It supports both
synchronous as well as asynchronous way of handling the messages. The
library also handles the timeout internally for synchronous messages
using events. This reduces the driver's overhead in handling the timeout
error cases.

The current patch series supports only APIs that are needed for device
initialization. These include APIs in the libie_pci module:
* Allocating/freeing the DMA memory and mapping the MMIO regions for
  BAR0, read/write APIs for drivers to access the MMIO memory

and libie_cp module:
* Control queue initialization and configuration
* Transport initialization for bookkeeping
* Blocking and asynchronous mailbox transactions

Once the mailbox is initialized, the drivers can send and receive virtchnl
messages to/from the control plane.

The modules above are not supposed to be linked with the main libie library,
but do share the folder with it.

2. idpf:
Patches 6-11 refactor the idpf driver to use the libie APIs for control
queue configuration, virtchnl transaction, device initialization
and reset and adjust related code accordingly.

3. ixd:
Patches 12-15 add the ixd driver and implement multiple pieces of the
initialization flow as follows:
* Add the ability to load
* A reset is issued to ensure a clean device state, followed by
  initialization of the mailbox
* Device capabilities:
  As part of initialization, the driver has to determine what the device is
  capable of (ex. max queues, vports, etc). This information is obtained from
  the firmware and stored by the driver.
* Enable initial support for the devlink interface
---
v4:
* use check_add_overflow() for MMIO offset+size bounds check in libie_pci
* replace iounmap() with pci_iounmap() for MMIO regions in libie_pci
* fix missing rx_buf->offset when constructing ctlq Rx message address
* always zero Rx descriptor before reallocation
* do not call complete() inside spinlock, theoretical use-after-free
* reset async xn state to IDLE before freeing in libie_ctlq_xn_shutdown()
* zero control queue Tx descriptor before freeing memory
* remove unused ctx field from struct libie_ctlq_xn_clean_params
* roll back merging of idpf_deinit_dflt_mbx() and xnm shutdown,
  those calls are separate again (so idpf refactoring becomes more trivial)
* introduce idpf_send_vf_reset_msg() for one-way VF reset message bypassing
  XN manager, which is shut down by now
* guard libie_ctlq_xn_shutdown() against NULL xnm in idpf_vc_event_task(),
  this is needed if reset fails and reschedules
* validate response sizes in idpf more
* fix MAINTAINERS glob pattern for include/linux/net/intel/
* roll back linux/{net/intel -> intel}/* change (1st patch)
* use pci_iomap_range() to map regions in libie_pci
* improve libie_pci commit message
* remove broken dead code for getting RSS from idpf (new patch!)
* use maximum alignment for control queue stack buffer in ixd
* fix ixd_ctlq_clean_sq() usage
* do not register ixd devlink prematurely
* improve receive buffer size validation in idpf

v3: https://lore.kernel.org/netdev/20260515224443.2772147-1-anthony.l.nguyen@intel.com/
- lock libie ctlq transaction earlier on Rx path
- improve ctlq Rx buffer size validation both in idpf and libie
- fix RSS LUT buf size (will also go to stable separately)
- improve xnm shutdown handling
- skip zero-sized BAR regions instread of returning error in idpf
- unify treatment of initialized and uninitialized ctlq messages

v2: https://lore.kernel.org/netdev/20260403194938.3577011-1-anthony.l.nguyen@intel.com/
- improved failure handling and input validation
- removed cp version from devlink in ixd

v1: https://lore.kernel.org/netdev/20260317230905.847744-1-anthony.l.nguyen@intel.com/

The following are changes since commit 23dad2d088dfc82cae1f5a936f8ff7ffebb38dd9:
  tun: no longer rely on RTNL in tun_fill_info()
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE

Amritha Nambiar (1):
  ixd: add devlink support

Larysa Zaremba (6):
  idpf: remove unused code for getting RSS info from device
  idpf: make mbx_task queueing and cancelling more consistent
  idpf: print a debug message and bail in case of non-event ctlq message
  ixd: add basic driver framework for Intel(R) Control Plane Function
  ixd: add reset checks and initialize the mailbox
  ixd: add the core initialization

Pavan Kumar Linga (4):
  libeth: allow to create fill queues without NAPI
  idpf: remove 'vport_params_reqd' field
  idpf: refactor idpf to use libie_pci APIs
  idpf: refactor idpf to use libie control queues

Phani R Burra (3):
  libie: add PCI device initialization helpers to libie
  libie: add control queue support
  libie: add bookkeeping support for control queue messages

Victor Raj (1):
  virtchnl: move virtchnl and virtchnl2 headers to
    'include/linux/net/intel'

 .../device_drivers/ethernet/index.rst         |    1 +
 .../device_drivers/ethernet/intel/ixd.rst     |   39 +
 Documentation/networking/devlink/index.rst    |    1 +
 Documentation/networking/devlink/ixd.rst      |   30 +
 MAINTAINERS                                   |    3 +-
 drivers/net/ethernet/intel/Kconfig            |    2 +
 drivers/net/ethernet/intel/Makefile           |    1 +
 drivers/net/ethernet/intel/i40e/i40e.h        |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c |    2 +-
 .../net/ethernet/intel/i40e/i40e_prototype.h  |    2 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |    2 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c |    2 +-
 .../net/ethernet/intel/iavf/iavf_prototype.h  |    3 +-
 drivers/net/ethernet/intel/iavf/iavf_types.h  |    4 +-
 drivers/net/ethernet/intel/ice/ice.h          |    2 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |    2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |    2 +-
 .../net/ethernet/intel/ice/virt/virtchnl.h    |    2 +-
 drivers/net/ethernet/intel/idpf/Kconfig       |    1 +
 drivers/net/ethernet/intel/idpf/Makefile      |    2 -
 drivers/net/ethernet/intel/idpf/idpf.h        |   99 +-
 .../net/ethernet/intel/idpf/idpf_controlq.c   |  621 ------
 .../net/ethernet/intel/idpf/idpf_controlq.h   |  144 --
 .../ethernet/intel/idpf/idpf_controlq_api.h   |  177 --
 .../ethernet/intel/idpf/idpf_controlq_setup.c |  169 --
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  101 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   28 +-
 drivers/net/ethernet/intel/idpf/idpf_idc.c    |   38 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   69 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  115 +-
 drivers/net/ethernet/intel/idpf/idpf_mem.h    |   20 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |    4 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |    4 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   96 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1879 +++++++----------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  107 +-
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  312 +--
 drivers/net/ethernet/intel/ixd/Kconfig        |   15 +
 drivers/net/ethernet/intel/ixd/Makefile       |   13 +
 drivers/net/ethernet/intel/ixd/ixd.h          |   59 +
 drivers/net/ethernet/intel/ixd/ixd_ctlq.c     |  146 ++
 drivers/net/ethernet/intel/ixd/ixd_ctlq.h     |   34 +
 drivers/net/ethernet/intel/ixd/ixd_dev.c      |   89 +
 drivers/net/ethernet/intel/ixd/ixd_devlink.c  |   97 +
 drivers/net/ethernet/intel/ixd/ixd_devlink.h  |   50 +
 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |   68 +
 drivers/net/ethernet/intel/ixd/ixd_lib.c      |  174 ++
 drivers/net/ethernet/intel/ixd/ixd_main.c     |  147 ++
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c |  178 ++
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.h |   12 +
 drivers/net/ethernet/intel/libeth/rx.c        |   12 +-
 drivers/net/ethernet/intel/libie/Kconfig      |   14 +
 drivers/net/ethernet/intel/libie/Makefile     |    8 +
 drivers/net/ethernet/intel/libie/controlq.c   | 1223 +++++++++++
 drivers/net/ethernet/intel/libie/pci.c        |  209 ++
 include/linux/net/intel/libie/controlq.h      |  424 ++++
 include/linux/net/intel/libie/pci.h           |   56 +
 include/linux/{avf => net/intel}/virtchnl.h   |    0
 .../linux/net/intel}/virtchnl2.h              |    0
 .../linux/net/intel}/virtchnl2_lan_desc.h     |    0
 include/net/libeth/rx.h                       |    4 +-
 62 files changed, 4226 insertions(+), 2896 deletions(-)
 create mode 100644 Documentation/networking/device_drivers/ethernet/intel/ixd.rst
 create mode 100644 Documentation/networking/devlink/ixd.rst
 delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.c
 delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.h
 delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
 delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_setup.c
 delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_mem.h
 create mode 100644 drivers/net/ethernet/intel/ixd/Kconfig
 create mode 100644 drivers/net/ethernet/intel/ixd/Makefile
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_ctlq.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_ctlq.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_dev.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_devlink.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_devlink.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_lib.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_main.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_virtchnl.h
 create mode 100644 drivers/net/ethernet/intel/libie/controlq.c
 create mode 100644 drivers/net/ethernet/intel/libie/pci.c
 create mode 100644 include/linux/net/intel/libie/controlq.h
 create mode 100644 include/linux/net/intel/libie/pci.h
 rename include/linux/{avf => net/intel}/virtchnl.h (100%)
 rename {drivers/net/ethernet/intel/idpf => include/linux/net/intel}/virtchnl2.h (100%)
 rename {drivers/net/ethernet/intel/idpf => include/linux/net/intel}/virtchnl2_lan_desc.h (100%)

-- 
2.47.1


