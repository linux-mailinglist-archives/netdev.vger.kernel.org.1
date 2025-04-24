Return-Path: <netdev+bounces-185507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D45CA9ABE6
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68AB4A4FEA
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E236522A4F1;
	Thu, 24 Apr 2025 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ub17vUfq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D38229B01;
	Thu, 24 Apr 2025 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745494374; cv=none; b=MRYC8mDwGQw4VLNcW90+pQQFVTN8ChBtEiGsEcj5x5Gv89WFGvpgJoD7el8EdnrRccQCyJ+q/Vq5EMT85+810AHSwadgfgYRZiq/A9nDbXStDrhf2jIsPvbJJj7mkTpM9uDZxBNIyynIY3FagFozopouEW3iDDfY6NZz5lhywGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745494374; c=relaxed/simple;
	bh=JGwozXvGLUYRAhQYuo/5Es9lkizURDNr3Wu4FgAGM3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JktPtfDlJ/lQIHk7SNmBu+/BmOUuGMETCJAxYgihES8T8GfGnyRPAzkKMI2wWUenPC4lPw7DPiH1lK0OkzOqEG1EeOpwd9KJ7M5TcE6+o8rNN2oh1UpwMNTHlW1Q9LaSuzKXZ4nEuTa7YshR33VenCJbKVccuNeftjDHPweX1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ub17vUfq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745494372; x=1777030372;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JGwozXvGLUYRAhQYuo/5Es9lkizURDNr3Wu4FgAGM3A=;
  b=Ub17vUfqn+pmoPLA+LQPqLP3hVVOf4ptsuRXCXQlZam/jWDOteArWY0F
   xbTXiVvB/ddashyRRvmZmCBJno1eiuIh1f7nQyp15Dhd0FAKQVMimQgNw
   mRORDIjllAEcEMWbcmysWO6qOHHaCTdKxqquip6Ad+rBa4xtknNoGV3Ot
   I/vxNtmyxsDs2rz5kE9JCun9aAHP728L6O5RFLNNIG81r/+RCy9dWPtF/
   DLZRuiX6e8Z3i5MS9olxuERMqdQL/LaqM/X5nWR7t5997uN46tHNSnwxM
   yl6svLs1i0p4UI28uozKAF/6Az3a6CIisFEt8BDIzTtMI66KbKNXhc2Qn
   w==;
X-CSE-ConnectionGUID: QPNPcAJ8S+CjPox0YX93Pw==
X-CSE-MsgGUID: snRgH8XqRWyFYu7n0ieR1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="57771139"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="57771139"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 04:32:51 -0700
X-CSE-ConnectionGUID: JPMUmLKPRn+4S9U5ER2PNw==
X-CSE-MsgGUID: Y3oAZrOUSzOaE2+/OsrqeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="137389329"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 24 Apr 2025 04:32:45 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2A3CE33E9B;
	Thu, 24 Apr 2025 12:32:42 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Lee Trager <lee@trager.us>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	pavan.kumar.linga@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>
Subject: [PATCH iwl-next v2 00/14] Introduce iXD driver
Date: Thu, 24 Apr 2025 13:32:23 +0200
Message-ID: <20250424113241.10061-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Patches 1-6 introduces additional common library API for drivers to
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

The modules above are not supposed to be linked witn the main libie library,
but do share the folder with it.

2. idpf :
Patches 7-10 refactor the idpf driver to use the libie APIs for control
queue configuration, virtchnl transaction, device initialization and
reset and adjust related code accordingly.

3. ixd:
Patches 11-14 add the ixd driver and implement multiple pieces of the
initialization flow as follows:
* Add the ability to load
* A reset is issued to ensure a clean device state, followed by
  initialization of the mailbox
* Device capabilities:
  As part of initialization, the driver has to determine what the device is
  capable of (ex. max queues, vports, etc). This information is obtained from
  the firmware and stored by the driver.
* Enable initial support for the devlink interface

v1->v2:
* rename libeth_cp and libeth_pci to libie_cp and libie_pci respectively,
  move them into an appropriate folder
* rebase on top of recent PTP changes, this alters idpf refactor
* update maintainers after moving headers
* cast resource_size_t to unsigned long long when printing
* add ixd devlink documentation into index
* fix xn system kdoc problems
* fix indentation in libeth_ctlq_xn_deinit()
* fix extra kdoc member vcxn_mngr in idpf_adapter

Amritha Nambiar (1):
  ixd: add devlink support

Larysa Zaremba (5):
  idpf: make mbx_task queueing and cancelling more consistent
  idpf: print a debug message and bail in case of non-event ctlq message
  ixd: add basic driver framework for Intel(R) Control Plane Function
  ixd: add reset checks and initialize the mailbox
  ixd: add the core initialization

Pavan Kumar Linga (3):
  libeth: allow to create fill queues without NAPI
  idpf: remove 'vport_params_reqd' field
  idpf: refactor idpf to use libie controlq and Xn APIs

Phani R Burra (3):
  libie: add PCI device initialization helpers to libie
  libie: add control queue support
  libie: add bookkeeping support for control queue messages

Victor Raj (2):
  virtchnl: create 'include/linux/intel' and move necessary header files
  virtchnl: introduce control plane version fields

 .../device_drivers/ethernet/index.rst         |    1 +
 .../device_drivers/ethernet/intel/ixd.rst     |   39 +
 Documentation/networking/devlink/index.rst    |    1 +
 Documentation/networking/devlink/ixd.rst      |   35 +
 MAINTAINERS                                   |    6 +-
 drivers/infiniband/hw/irdma/i40iw_if.c        |    2 +-
 drivers/infiniband/hw/irdma/main.h            |    2 +-
 drivers/infiniband/hw/irdma/osdep.h           |    2 +-
 drivers/net/ethernet/intel/Kconfig            |    2 +
 drivers/net/ethernet/intel/Makefile           |    1 +
 drivers/net/ethernet/intel/i40e/i40e.h        |    4 +-
 drivers/net/ethernet/intel/i40e/i40e_client.c |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c |    2 +-
 .../net/ethernet/intel/i40e/i40e_prototype.h  |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |    2 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |    2 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |    2 +-
 .../net/ethernet/intel/iavf/iavf_prototype.h  |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_types.h  |    4 +-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |    2 +-
 drivers/net/ethernet/intel/ice/ice.h          |    2 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |    2 +-
 drivers/net/ethernet/intel/ice/ice_idc_int.h  |    2 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |    2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |    2 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |    2 +-
 drivers/net/ethernet/intel/idpf/Kconfig       |    1 +
 drivers/net/ethernet/intel/idpf/Makefile      |    2 -
 drivers/net/ethernet/intel/idpf/idpf.h        |   47 +-
 .../net/ethernet/intel/idpf/idpf_controlq.c   |  624 ------
 .../net/ethernet/intel/idpf/idpf_controlq.h   |  130 --
 .../ethernet/intel/idpf/idpf_controlq_api.h   |  177 --
 .../ethernet/intel/idpf/idpf_controlq_setup.c |  171 --
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   91 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   60 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   87 +-
 drivers/net/ethernet/intel/idpf/idpf_mem.h    |   20 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |    4 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   89 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1670 ++++++-----------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   89 +-
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  303 ++-
 drivers/net/ethernet/intel/ixd/Kconfig        |   15 +
 drivers/net/ethernet/intel/ixd/Makefile       |   13 +
 drivers/net/ethernet/intel/ixd/ixd.h          |   56 +
 drivers/net/ethernet/intel/ixd/ixd_ctlq.c     |  148 ++
 drivers/net/ethernet/intel/ixd/ixd_ctlq.h     |   33 +
 drivers/net/ethernet/intel/ixd/ixd_dev.c      |   86 +
 drivers/net/ethernet/intel/ixd/ixd_devlink.c  |  105 ++
 drivers/net/ethernet/intel/ixd/ixd_devlink.h  |   44 +
 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |   68 +
 drivers/net/ethernet/intel/ixd/ixd_lib.c      |  166 ++
 drivers/net/ethernet/intel/ixd/ixd_main.c     |  150 ++
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c |  178 ++
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.h |   12 +
 drivers/net/ethernet/intel/libeth/rx.c        |    9 +-
 drivers/net/ethernet/intel/libie/Kconfig      |   14 +
 drivers/net/ethernet/intel/libie/Makefile     |    8 +
 drivers/net/ethernet/intel/libie/controlq.c   | 1186 ++++++++++++
 drivers/net/ethernet/intel/libie/pci.c        |  184 ++
 drivers/net/ethernet/intel/libie/rx.c         |    2 +-
 include/linux/{net => }/intel/i40e_client.h   |    0
 include/linux/{net => }/intel/iidc.h          |    0
 include/linux/intel/libie/controlq.h          |  421 +++++
 include/linux/intel/libie/pci.h               |   54 +
 include/linux/{net => }/intel/libie/rx.h      |    0
 include/linux/{avf => intel}/virtchnl.h       |    0
 .../idpf => include/linux/intel}/virtchnl2.h  |    6 +-
 .../linux/intel}/virtchnl2_lan_desc.h         |    0
 include/net/libeth/rx.h                       |    4 +-
 73 files changed, 3976 insertions(+), 2684 deletions(-)
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
 rename include/linux/{net => }/intel/i40e_client.h (100%)
 rename include/linux/{net => }/intel/iidc.h (100%)
 create mode 100644 include/linux/intel/libie/controlq.h
 create mode 100644 include/linux/intel/libie/pci.h
 rename include/linux/{net => }/intel/libie/rx.h (100%)
 rename include/linux/{avf => intel}/virtchnl.h (100%)
 rename {drivers/net/ethernet/intel/idpf => include/linux/intel}/virtchnl2.h (99%)
 rename {drivers/net/ethernet/intel/idpf => include/linux/intel}/virtchnl2_lan_desc.h (100%)

-- 
2.47.0


