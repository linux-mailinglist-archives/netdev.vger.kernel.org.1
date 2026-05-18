Return-Path: <netdev+bounces-289057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIB2N7cPC2rL/gQAu9opvQ
	(envelope-from <netdev+bounces-289057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:10:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7B156D56F
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ADFB630474C2
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CF94657E8;
	Mon, 18 May 2026 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PpzoK914"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D23E450909
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108953; cv=none; b=kefNnNtSwJ2/8/+umBAoJYh//cJgKN1et8AiC6SBqOhQHfhVp2qLau/xEa2izyhR/oQwbxzziUS0CEt38wW/WPwkMAbVGE+tkpOKEQ+cMzBNDHOalsOc1uo/zoEN7RVoj/nNGwHUyBIg3SKF9btab8Ggci8PxoUo5W4nNxHLIVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108953; c=relaxed/simple;
	bh=BFuutE3qkTv/oXLlNpQchnO9o31EmkQdBPy5A9Bo62A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aOl075dGSqe9mloPYn2UEhFtPzLfuyIUOHe3gZMN4e5/cSzI5NFcUPI8megNh+W2CMEMOrpLRCwUf64T/BZDZCNCZcHnqoB7/im/4sQVRa+SX8jvTFshQWlo9/lvHEHId3yH1zrLXCHqXRnH7mSUU9AbYkSqXySwroVGmHDMBec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PpzoK914; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779108952; x=1810644952;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BFuutE3qkTv/oXLlNpQchnO9o31EmkQdBPy5A9Bo62A=;
  b=PpzoK914d5P2z7enMYGsb/xl6Rgd756VqD136WFVQfy2Vh/FPDzAXH1T
   JuNywFJbBcfpYR8wNMyfcOYXF94zuXaHydAxaoRZeOMktdi/zbzqSWdJF
   ah0C8oY46zXo1OAXULmK6F2nB3SHfZRlu0ltLa9l8xxksUItxjgLi0UTr
   tw26Tv4W3WCijf1cM5JI0vrcjd41VJE3VJArV2hCtyQzpWUY0YUFh1R8U
   52DjmghzNlWSwzHn5AKPRpWf8x1Xi9IVKKwY8uk7+CeSdTZxIWrJTF9b6
   INjJiMFxDwWuXquUuHbWuGbGYhSsge/NgK54CE0yQ3NiFf179T3ata50I
   g==;
X-CSE-ConnectionGUID: nxao9qX9Tw6LVdhaCFm//w==
X-CSE-MsgGUID: 7F7HX07iRPi/1sXPxFi+9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="82524119"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="82524119"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 05:55:51 -0700
X-CSE-ConnectionGUID: 7U3DXN9IRvuKX0NtwMAqSw==
X-CSE-MsgGUID: QJYoVvjOS52DG3GdncfscA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="277520202"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa001.jf.intel.com with ESMTP; 18 May 2026 05:55:49 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v1] ixgbe: LinkSec deprecated macros cleanup
Date: Mon, 18 May 2026 14:36:11 +0200
Message-Id: <20260518123611.2252139-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DF7B156D56F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289057-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

There are some unused LinkSec macros. Get rid of them.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 61 -------------------
 1 file changed, 61 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 61f2ef67defd..1f77b6eb86a1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -620,67 +620,6 @@ struct ixgbe_nvm_version {
 #define IXGBE_SECRXSTAT_SECRX_OFF_DIS   0x00000002
 #define IXGBE_SECRXSTAT_ECC_RXERR       0x00000004
 
-/* LinkSec (MacSec) Registers */
-#define IXGBE_LSECTXCAP         0x08A00
-#define IXGBE_LSECRXCAP         0x08F00
-#define IXGBE_LSECTXCTRL        0x08A04
-#define IXGBE_LSECTXSCL         0x08A08 /* SCI Low */
-#define IXGBE_LSECTXSCH         0x08A0C /* SCI High */
-#define IXGBE_LSECTXSA          0x08A10
-#define IXGBE_LSECTXPN0         0x08A14
-#define IXGBE_LSECTXPN1         0x08A18
-#define IXGBE_LSECTXKEY0(_n)    (0x08A1C + (4 * (_n))) /* 4 of these (0-3) */
-#define IXGBE_LSECTXKEY1(_n)    (0x08A2C + (4 * (_n))) /* 4 of these (0-3) */
-#define IXGBE_LSECRXCTRL        0x08F04
-#define IXGBE_LSECRXSCL         0x08F08
-#define IXGBE_LSECRXSCH         0x08F0C
-#define IXGBE_LSECRXSA(_i)      (0x08F10 + (4 * (_i))) /* 2 of these (0-1) */
-#define IXGBE_LSECRXPN(_i)      (0x08F18 + (4 * (_i))) /* 2 of these (0-1) */
-#define IXGBE_LSECRXKEY(_n, _m) (0x08F20 + ((0x10 * (_n)) + (4 * (_m))))
-#define IXGBE_LSECTXUT          0x08A3C /* OutPktsUntagged */
-#define IXGBE_LSECTXPKTE        0x08A40 /* OutPktsEncrypted */
-#define IXGBE_LSECTXPKTP        0x08A44 /* OutPktsProtected */
-#define IXGBE_LSECTXOCTE        0x08A48 /* OutOctetsEncrypted */
-#define IXGBE_LSECTXOCTP        0x08A4C /* OutOctetsProtected */
-#define IXGBE_LSECRXUT          0x08F40 /* InPktsUntagged/InPktsNoTag */
-#define IXGBE_LSECRXOCTD        0x08F44 /* InOctetsDecrypted */
-#define IXGBE_LSECRXOCTV        0x08F48 /* InOctetsValidated */
-#define IXGBE_LSECRXBAD         0x08F4C /* InPktsBadTag */
-#define IXGBE_LSECRXNOSCI       0x08F50 /* InPktsNoSci */
-#define IXGBE_LSECRXUNSCI       0x08F54 /* InPktsUnknownSci */
-#define IXGBE_LSECRXUNCH        0x08F58 /* InPktsUnchecked */
-#define IXGBE_LSECRXDELAY       0x08F5C /* InPktsDelayed */
-#define IXGBE_LSECRXLATE        0x08F60 /* InPktsLate */
-#define IXGBE_LSECRXOK(_n)      (0x08F64 + (0x04 * (_n))) /* InPktsOk */
-#define IXGBE_LSECRXINV(_n)     (0x08F6C + (0x04 * (_n))) /* InPktsInvalid */
-#define IXGBE_LSECRXNV(_n)      (0x08F74 + (0x04 * (_n))) /* InPktsNotValid */
-#define IXGBE_LSECRXUNSA        0x08F7C /* InPktsUnusedSa */
-#define IXGBE_LSECRXNUSA        0x08F80 /* InPktsNotUsingSa */
-
-/* LinkSec (MacSec) Bit Fields and Masks */
-#define IXGBE_LSECTXCAP_SUM_MASK        0x00FF0000
-#define IXGBE_LSECTXCAP_SUM_SHIFT       16
-#define IXGBE_LSECRXCAP_SUM_MASK        0x00FF0000
-#define IXGBE_LSECRXCAP_SUM_SHIFT       16
-
-#define IXGBE_LSECTXCTRL_EN_MASK        0x00000003
-#define IXGBE_LSECTXCTRL_DISABLE        0x0
-#define IXGBE_LSECTXCTRL_AUTH           0x1
-#define IXGBE_LSECTXCTRL_AUTH_ENCRYPT   0x2
-#define IXGBE_LSECTXCTRL_AISCI          0x00000020
-#define IXGBE_LSECTXCTRL_PNTHRSH_MASK   0xFFFFFF00
-#define IXGBE_LSECTXCTRL_RSV_MASK       0x000000D8
-
-#define IXGBE_LSECRXCTRL_EN_MASK        0x0000000C
-#define IXGBE_LSECRXCTRL_EN_SHIFT       2
-#define IXGBE_LSECRXCTRL_DISABLE        0x0
-#define IXGBE_LSECRXCTRL_CHECK          0x1
-#define IXGBE_LSECRXCTRL_STRICT         0x2
-#define IXGBE_LSECRXCTRL_DROP           0x3
-#define IXGBE_LSECRXCTRL_PLSH           0x00000040
-#define IXGBE_LSECRXCTRL_RP             0x00000080
-#define IXGBE_LSECRXCTRL_RSV_MASK       0xFFFFFF33
-
 /* IpSec Registers */
 #define IXGBE_IPSTXIDX          0x08900
 #define IXGBE_IPSTXSALT         0x08904
-- 
2.31.1


