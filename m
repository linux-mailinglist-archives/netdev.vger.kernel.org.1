Return-Path: <netdev+bounces-296131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gt9gEkdpJGpa6AEAu9opvQ
	(envelope-from <netdev+bounces-296131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 20:39:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8314464E096
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 20:39:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296131-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296131-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=chelsio.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29BE03012E85
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 18:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C6E305694;
	Sat,  6 Jun 2026 18:39:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B443A30C615
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 18:38:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780771140; cv=none; b=lqb8ev8NZbWz7m0VmKM4yu/OL8Cq0EYcRxzblLpFmrK//ecRc/IKwOFl90+z9UGB/b1cOYjQKeW9eEcdAFv2HwxRCJdvzp4WiRYD5eanEIAxg3SZ7M+k3fbzVS3fqyv4wLUWhhJ83+W4jVEkJIqAssnlPkMwndiqMFhVp/E3j4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780771140; c=relaxed/simple;
	bh=41yhIfqRRGMQAWPlJEONlFvioE9Yi1hb0eckHpSlzOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cX58udCbHlQdwf4MyYT7eu79USc75XzR7EetFLRh3yXM9RN65vYzjubXQs4aLB0mD0b21bzGmPzpxhyS/EPMh1zsDQumpzHiTaBXqYOtyk+H18NLtXVCoel0omv8hG+ZK+cDVhwaw71YmTPTUBKdKncKLOA7xAupsFz64n7Egrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 656IKSGA029679;
	Sat, 6 Jun 2026 11:20:29 -0700
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com
Subject: [PATCH net-next v1 0/10] cxgb4: Add Chelsio T7 support
Date: Sat,  6 Jun 2026 23:52:10 -0400
Message-Id: <20260607035220.528439-1-bharat@chelsio.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: add header
X-Spamd-Result: default: False [7.04 / 15.00];
	DATE_IN_FUTURE(4.00)[9];
	DMARC_POLICY_REJECT(2.00)[chelsio.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296131-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:bharat@chelsio.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER(0.00)[bharat@chelsio.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bharat@chelsio.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chelsio.com:from_mime,chelsio.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8314464E096
X-Spam: Yes

This patch series introduces base support for the next-generation Chelsio
T7 adapter family into the cxgb4 driver. 

T7 follows the previous T6 architecture, bringing significant performance
upgrades to the platform. The new chip comes in single, dual, and 4-port
variants, introducing capabilities for hardware link speeds up to
400Gbps alongside native PCIe Gen5 bus support.

To accommodate the expanded features, multi-core architecture.
This series refactors core driver subsystems while preserving backward 
compatibility for legacy hardware:

1. Foundational registers, chip identification tokens, and hardware
   constants are introduced to handle expanded microprocessor tracking,
   larger SGE contexts, and flexible flash memory configurations.
2. CPL structures and firmware command layouts are upgraded to support the
   wider traffic processor filter tuples and high-speed link profiles.
3. The driver's modular design is improved by moving bus-specific setup
   routines out of cxgb4_main.c into a dedicated cxgb4_pci module.
4. The core hardware abstraction layer, SGE processing pipelines,
   filtering engine, and ethtool management layouts are extended to
   correctly target T7 interfaces and configuration profiles.
5. The cudbg library and debugfs diagnostic components are refactored
   to output versioned structural dumps, ensuring user-space tools can
   seamlessly process T7 operational telemetry.

This series has been tested for compilation and NIC traffic on T7 Chip.
Please review.

Potnuri Bharat Teja (6):
  cxgb4: Add T7 register definitions and core structures
  cxgb4: Add T7 chip type identification and HW constants
  cxgb4: Add T7 CPL messages, FW constants, and PCI IDs
  cxgb4: Add versioned structures and scratch buffs
  cxgb4: Add T7 indirect regs and update library
  cxgb4: Move PCI initialization logic to cxgb4_pci.c

 drivers/net/ethernet/chelsio/cxgb4/Makefile   |    2 +-
 .../net/ethernet/chelsio/cxgb4/cudbg_common.c |   30 +
 .../net/ethernet/chelsio/cxgb4/cudbg_entity.h |  147 ++-
 drivers/net/ethernet/chelsio/cxgb4/cudbg_if.h |   54 +-
 .../ethernet/chelsio/cxgb4/cudbg_indir_reg.h  |   43 +
 .../chelsio/cxgb4/cudbg_indir_reg_t7.h        | 1113 +++++++++++++++++
 .../net/ethernet/chelsio/cxgb4/cudbg_lib.c    |  902 +++++++++++--
 .../net/ethernet/chelsio/cxgb4/cudbg_lib.h    |   50 +-
 .../ethernet/chelsio/cxgb4/cudbg_lib_common.h |    4 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |  194 ++-
 .../net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c  |   16 +
 .../net/ethernet/chelsio/cxgb4/cxgb4_pci.c    |  370 ++++++
 .../net/ethernet/chelsio/cxgb4/cxgb4_pci.h    |   36 +
 .../net/ethernet/chelsio/cxgb4/t4_chip_type.h |   10 +
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.h    |  136 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_msg.h   |  109 +-
 .../ethernet/chelsio/cxgb4/t4_pci_id_tbl.h    |   21 +
 drivers/net/ethernet/chelsio/cxgb4/t4_regs.h  |  478 ++++++-
 drivers/net/ethernet/chelsio/cxgb4/t4_tcb.h   |   16 +
 .../net/ethernet/chelsio/cxgb4/t4_values.h    |   15 +-
 drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h |   82 +-
 .../net/ethernet/chelsio/cxgb4/t4fw_version.h |    9 +
 22 files changed, 3609 insertions(+), 228 deletions(-)
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/cudbg_indir_reg.h
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/cudbg_indir_reg_t7.h
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.c
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.h

-- 
2.39.1


