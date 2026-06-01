Return-Path: <netdev+bounces-293644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGF3NAdSHWpfYwkAu9opvQ
	(envelope-from <netdev+bounces-293644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:33:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BE561C833
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF37E300BC44
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93413909A7;
	Mon,  1 Jun 2026 09:32:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1AD39099C;
	Mon,  1 Jun 2026 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306323; cv=none; b=mJU0+BhnPllWau3aaNcVEm0iYlJGKU5VYBDR6n+ezMquv/MyqQFBZGmOTBfDgQlz6ybrV+Cl5G8hmCe3en1RmCjlxKPNFZYFGx7CqVvS0KPZtm8VCc/NLQPhyXlyNXZGGe3timBa+Px0FdS3eeAwYon+up/wNdVJyMs5Xxsbhqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306323; c=relaxed/simple;
	bh=Wpb7UQdLQSSZiOTebhvWRboGp80MvbXMXuM4pNQnRcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O4bCh+lcwCqnpjpQ19gNVtqM8szH1CX5TD+fy9btu6MKznP+pdL4NmwqFDTLN2tdnx8jLeOaPxeeZAvR5s8yFsjfxAQzA/c4IBHLv2GovJ9whaGVFpjYUgFwWbqzRHTbvjq1Gy4Fkd5PQJEKTyKfz+yD9IIFMADEU3KLULA6Dso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.115058|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.114224-0.0105365-0.87524;FP=455425243944060466|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.hlxxkWC_1780306312;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.hlxxkWC_1780306312 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 01 Jun 2026 17:31:53 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v17 net-next 00/11] nbl driver for Nebulamatrix NICs
Date: Mon,  1 Jun 2026 17:31:33 +0800
Message-ID: <20260601093149.25905-1-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293644-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nebula-matrix.com];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.961];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nebula-matrix.com:mid,2.ai:url,illusion.wang:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D3BE561C833
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series represents the first phase. We plan to integrate it in
two phases: the first phase covers mailbox and chip configuration,
while the second phase involves net dev configuration.
Together, they will provide basic PF-based Ethernet port transmission and
reception capabilities.

After that, we will consider other features, such as ethtool support,
flow management, adminq messaging, VF support, debugfs support, etc.

changes v16->v17
Link to v16:https://lore.kernel.org/netdev/20260526035453.2359-1-illusion.wang@nebula-matrix.com/
AI review issues
changes v15->v16
Link to v15:https://lore.kernel.org/netdev/20260520032950.4874-1-illusion.wang@nebula-matrix.com/
AI review issues
changes v14->v15
Link to v14:https://lore.kernel.org/netdev/20260513011649.4404-1-illusion.wang@nebula-matrix.com/
AI review issues
changes v13->v14
Link to v13:https://lore.kernel.org/netdev/20260428114910.2616-1-illusion.wang@nebula-matrix.com/
AI review issues
changes v12->v13
Link to v12:https://lore.kernel.org/netdev/20260415033608.2438-1-illusion.wang@nebula-matrix.com/
AI review issues
changes v11->v12
Link to v11:https://lore.kernel.org/netdev/20260408093739.56001-1-illusion.wang@nebula-matrix.com/
AI review issues
changes v10->v11
Link to v10:https://lore.kernel.org/netdev/20260401022318.28550-1-illusion.wang@nebula-matrix.com/
1.Issues found by Mohsin
2.AI review issues
changes v9->v10
Link to v9:https://lore.kernel.org/netdev/20260325040048.2313-1-illusion.wang@nebula-matrix.com/
1.Issues found by Jakub
2.AI review issue
changes v8->v9
Link to v8:https://lore.kernel.org/netdev/20260317034533.5600-1-illusion.wang@nebula-matrix.com/
1.Issues found by Jakub
2.AI review issue
Changes v7→v8
Link to v7:https://lore.kernel.org/netdev/20260310120959.22015-1-illusion.wang@nebula-matrix.com/
1.Issues found by Paolo
Changes v6->v7
Link to v6:https://lore.kernel.org/netdev/20260306033451.5196-1-illusion.wang@nebula-matrix.com/
1.Issue found by Jakub
2.AI review issue
Changes v5->v6
Link to V5:https://lore.kernel.org/netdev/20260226073840.3222-1-illusion.wang@nebula-matrix.com/
1.put all standard linux includes files the .c file which needs it & others
--Andrew
2.AI review issue
Changes v4->v5
Link to V4:https://lore.kernel.org/netdev/20260206021608.85381-1-illusion.wang@nebula-matrix.com/
1.change nbl_core to nbl & change ** pointers to *pointers & others
--Andrew
2.AI review issue
Changes v3->v4
Link to v3: https://lore.kernel.org/netdev/20260123011804.31263-1-illusion.wang@nebula-matrix.com
1.cut down to part of a mini driver(mailbox and chip init)
--Jakub Kicinski Simon Horman(some sort of staged approached)
2.modify issues found by ai.
3. Reverse Christmas tree/nbl_err/devm_kfree/remove some macros/
void type to real type/others
--Andrew Lunn
4.change deprecated pci_enable_msix_range to pci_alloc_irq_vectors
5.delete service layer
6.the style of kconfig---Randy Dunlap
7.add to Documentation/networking/device_drivers/ethernet/index.rst
--Simon Horman
Changes v2 →v3
Link to v2: https://lore.kernel.org/netdev/20260109100146.63569-1-illusion.wang@nebula-matrix.com/
1.cut down to a mini driver:
    delete vf support
    use promisc mode to cut down flow management
    drop patch15 in v2
    delete adminq msg
    delete abnormal handling
    delete some unimportant interfaces
2.modify issues found by ai review
Changes v1->v2
Link to v1: https://lore.kernel.org/netdev/20251223035113.31122-1-illusion.wang@nebula-matrix.com/
1.Format Issues and Compilation Issues
- Paolo Abeni
2.add sysfs patch and drop coexisting patch
- Andrew Lunn
3.delete some unimportant ndo operations
4.add machine generated headers patch
5.Modify the issues found in patch1-2 and apply the same fixes to other
patches
6.modify issues found by nipa

illusion.wang (11):
  net/nebula-matrix: add minimum nbl build framework
  net/nebula-matrix: add our driver architecture
  net/nebula-matrix: add chip related definitions
  net/nebula-matrix: channel msg value and msg struct
  net/nebula-matrix: add channel layer
  net/nebula-matrix: add common resource implementation
  net/nebula-matrix: add intr resource implementation
  net/nebula-matrix: add vsi resource implementation
  net/nebula-matrix: add Dispatch layer implementation
  net/nebula-matrix: add common/ctrl dev init/reinit operation
  net/nebula-matrix: add common dev start/stop operation

 .../device_drivers/ethernet/index.rst         |    1 +
 .../ethernet/nebula-matrix/nbl.rst            |   28 +
 MAINTAINERS                                   |   10 +
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/nebula-matrix/Kconfig    |   34 +
 drivers/net/ethernet/nebula-matrix/Makefile   |    6 +
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   16 +
 .../nbl/nbl_channel/nbl_channel.c             | 1014 ++++++
 .../nbl/nbl_channel/nbl_channel.h             |  175 +
 .../nebula-matrix/nbl/nbl_common/nbl_common.c |  229 ++
 .../nebula-matrix/nbl/nbl_common/nbl_common.h |   33 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   59 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      |  449 +++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |   58 +
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c |  509 +++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |   43 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  862 +++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  548 ++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c | 2887 +++++++++++++++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h |   11 +
 .../nbl_hw_leonis/nbl_resource_leonis.c       |  283 ++
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   12 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     |   74 +
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  |  282 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |   21 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   |  134 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  110 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.c        |   26 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.h        |   12 +
 .../nbl/nbl_include/nbl_def_channel.h         |  361 +++
 .../nbl/nbl_include/nbl_def_common.h          |   80 +
 .../nbl/nbl_include/nbl_def_dev.h             |   16 +
 .../nbl/nbl_include/nbl_def_dispatch.h        |   42 +
 .../nbl/nbl_include/nbl_def_hw.h              |   55 +
 .../nbl/nbl_include/nbl_def_resource.h        |   37 +
 .../nbl/nbl_include/nbl_include.h             |   79 +
 .../nbl/nbl_include/nbl_product_base.h        |   19 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  336 ++
 39 files changed, 8953 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst
 create mode 100644 drivers/net/ethernet/nebula-matrix/Kconfig
 create mode 100644 drivers/net/ethernet/nebula-matrix/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c

-- 
2.47.3


