Return-Path: <netdev+bounces-241689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA07C875AB
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8557E3AB2B9
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD28933AD95;
	Tue, 25 Nov 2025 22:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5U9bIAR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5274C33ADA3
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764110207; cv=none; b=arSF3B7HoHcubllJ9RweY5cO0IPmUUAqVpFpDZSPU3PK1Nd/qZUqGhnzmzkXtD/cTgfcniA9X+lxAvrJxAprLqrftI9j22e/S5gA5gIvcXmbI6I2Rl1AvVvk+kKYnFFaB7bLn/2UoMeNqEDVRP+jwCGfNLSAtUHPHgZIhhiBjM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764110207; c=relaxed/simple;
	bh=Xn4rYUfKfv7eHrUG3b73kpjt7Jb+G243l4NcKXypfSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZCgSrGB97VpvACur51yXnpiBJM8l5FmtziArcwec3mmbFVRDdmwfkZx4iEzQzP7jZWWxJ9V+2QhMeG2/TJLF5AursgoIMoqX3DhIv+paUGsly9gB7kNQZH+8sVC/rjNEPnGQWQNkkr86NMPmYhEzDSdJo+xpHSU+L67oCrs8VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5U9bIAR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764110206; x=1795646206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xn4rYUfKfv7eHrUG3b73kpjt7Jb+G243l4NcKXypfSo=;
  b=B5U9bIARaruqzyPSvajEkpOrHwG4EKkSJe9d8H7JNZ2AY9YoXAYaGuln
   dWm6/Nvf+SHXEgBoZ/Y57LN8EXVscV7Xyfcynvg4i2BQGsybypbb/qfm4
   ff3E6LjVYGr7lpPLtbr0K08j8SZmxLCDQ6UHFeLZem1xu8t2P1aUq1LXn
   y8icH19TM1MXuBtVD+WsiS11o9Ni1lQ1ZRmsqzSVVlUOxmx0q/ArZimaT
   fcugz9Q2/wzCEofLr1emYIZvWMLm3CxjYYCOcSk34wcUuZUJKqNF2z5ER
   iKIJ9MQapCDwBNlq9xGYJP5E8X/74rXYdNiXK+Z2iJoFrg+LqZdhG2DOZ
   g==;
X-CSE-ConnectionGUID: 8DmHJh2BTlWYNS1coa+iVQ==
X-CSE-MsgGUID: FOxzVBlKSImz2wLOxmRaiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="68729920"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="68729920"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 14:36:42 -0800
X-CSE-ConnectionGUID: biXaRtKjQQKMdZY1QqyBAw==
X-CSE-MsgGUID: iPejNe2FSXeKAADUavhvyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="193209570"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 25 Nov 2025 14:36:41 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>,
	anthony.l.nguyen@intel.com,
	alok.a.tiwarilinux@gmail.com,
	aleksander.lobakin@intel.com,
	Simon Horman <horms@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 09/11] idpf: correct queue index in Rx allocation error messages
Date: Tue, 25 Nov 2025 14:36:28 -0800
Message-ID: <20251125223632.1857532-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
References: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alok Tiwari <alok.a.tiwari@oracle.com>

The error messages in idpf_rx_desc_alloc_all() used the group index i
when reporting memory allocation failures for individual Rx and Rx buffer
queues. This is incorrect.

Update the messages to use the correct queue index j and include the
queue group index i for clearer identification of the affected Rx and Rx
buffer queues.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index e2b6b9e26102..1d91c56f7469 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -922,8 +922,8 @@ static int idpf_rx_desc_alloc_all(struct idpf_vport *vport)
 			err = idpf_rx_desc_alloc(vport, q);
 			if (err) {
 				pci_err(vport->adapter->pdev,
-					"Memory allocation for Rx Queue %u failed\n",
-					i);
+					"Memory allocation for Rx queue %u from queue group %u failed\n",
+					j, i);
 				goto err_out;
 			}
 		}
@@ -939,8 +939,8 @@ static int idpf_rx_desc_alloc_all(struct idpf_vport *vport)
 			err = idpf_bufq_desc_alloc(vport, q);
 			if (err) {
 				pci_err(vport->adapter->pdev,
-					"Memory allocation for Rx Buffer Queue %u failed\n",
-					i);
+					"Memory allocation for Rx Buffer Queue %u from queue group %u failed\n",
+					j, i);
 				goto err_out;
 			}
 		}
-- 
2.47.1


