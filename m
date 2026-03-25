Return-Path: <netdev+bounces-271383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GaiDYlgw2m1qQQAu9opvQ
	(envelope-from <netdev+bounces-271383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 05:11:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E405A31F82A
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 05:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3EE9318E8AE
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15D72FFDC4;
	Wed, 25 Mar 2026 04:01:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-17.us.a.mail.aliyun.com (out198-17.us.a.mail.aliyun.com [47.90.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2372E9ED8;
	Wed, 25 Mar 2026 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774411275; cv=none; b=QtjwSZYejVTuoXCf8+LtsKw/DgwCAEC1O5FVRFCnPc94BMW9UGgFdvlrjgmL3OHHzpj3Z6qsBNSS9jIuomd8YqXtQraln1U0uM+uu/gsDZ+KMHck4/lKO0yW4RBHtcNRkJrmN8FdVa4tR+vyUaSXjf67kg3dWHPcUyh8+KAwYf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774411275; c=relaxed/simple;
	bh=p8YlDlgKwKT32enU1gPDYQ/H4JJbA2fcMtYTvAuY/Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KTIUIdP1KFdNtmvdOpeQFOnRqvj2syE2Z9J2BZfhH0h6eTSQkvZ1KUpGaFnppRgyYJkpIVDTV+7NZugxigKwR96MsRfINQM/4HeJmCKsTBuzt7b5cgyvXey9i8UY4nlXEvPufNI1QZv4LdZtCWO1A4jmzjirj0Ct4pcBWuqsbwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.8364356|0.08951011;CH=green;DM=|AD|false|;DS=CONTINUE|ham_alarm|0.114224-0.0105365-0.87524;FP=5076624236572317234|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.gzTMET5_1774411251;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gzTMET5_1774411251 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 25 Mar 2026 12:00:53 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 net-next 00/11] nbl driver for Nebulamatrix NICs
Date: Wed, 25 Mar 2026 12:00:32 +0800
Message-ID: <20260325040048.2313-1-illusion.wang@nebula-matrix.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271383-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[nebula-matrix.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,illusion.wang:url,nebula-matrix.com:mid,2.ai:url]
X-Rspamd-Queue-Id: E405A31F82A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series represents the first phase. We plan to integrate it in
two phases: the first phase covers mailbox and chip configuration,
while the second phase involves net dev configuration.
Together, they will provide basic PF-based Ethernet port transmission and
reception capabilities.

After that, we will consider other features, such as ethtool support,
flow management, adminq messaging, VF support, debugfs support, etc.

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
 .../ethernet/nebula-matrix/nbl.rst            |   27 +
 MAINTAINERS                                   |   10 +
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/nebula-matrix/Kconfig    |   34 +
 drivers/net/ethernet/nebula-matrix/Makefile   |    6 +
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   16 +
 .../nbl/nbl_channel/nbl_channel.c             |  853 +++++
 .../nbl/nbl_channel/nbl_channel.h             |  158 +
 .../nebula-matrix/nbl/nbl_common/nbl_common.c |  209 ++
 .../nebula-matrix/nbl/nbl_common/nbl_common.h |   34 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   47 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      |  438 +++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |   58 +
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c |  486 +++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |   56 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  815 +++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  493 +++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c | 2901 +++++++++++++++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h |   11 +
 .../nbl_hw_leonis/nbl_resource_leonis.c       |  256 ++
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   10 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     |   68 +
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  |  243 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |   12 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   |  135 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  118 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.c        |   51 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.h        |   11 +
 .../nbl/nbl_include/nbl_def_channel.h         |  361 ++
 .../nbl/nbl_include/nbl_def_common.h          |   76 +
 .../nbl/nbl_include/nbl_def_dev.h             |   14 +
 .../nbl/nbl_include/nbl_def_dispatch.h        |   42 +
 .../nbl/nbl_include/nbl_def_hw.h              |   54 +
 .../nbl/nbl_include/nbl_def_resource.h        |   36 +
 .../nbl/nbl_include/nbl_include.h             |   79 +
 .../nbl/nbl_include/nbl_product_base.h        |   18 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  321 ++
 39 files changed, 8560 insertions(+)
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


