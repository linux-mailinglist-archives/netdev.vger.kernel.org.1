Return-Path: <netdev+bounces-277971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEoDBq6b3GkxUAkAu9opvQ
	(envelope-from <netdev+bounces-277971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:30:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 017D23E8424
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A33130074E2
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 07:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC5E37C90A;
	Mon, 13 Apr 2026 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lH+l4kXb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6656337700B
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065443; cv=none; b=dELxx9cNUazm2p3UorY6cpEOIN40VNj8tlxbvu12OoahZPymToBMrRQhO//uT+cob5+iNsbz13npKaOSHqqZxra/O8rXpRqePO2Y1sSWJ1ekydmtjvdzyQk+w0+5svrpeZtah0cGaNgsg+jkoGN85Y5U/1tJu25lWtiABeH3tCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065443; c=relaxed/simple;
	bh=Q2VxeAv+3WTmb5fk+gyYvqLE3UVXnKyqFELWxysd6/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHJruIt+bbo7lIvMuTZwGcN55SZ6PTmCE+HD2T+oqUVRs83Pv/opUHaUT8rFX+7PJdugUs0B2Q56z+UvbqqGGnhf1dGFXchwExCNL8RqMkk/TNTDDzAugnp0vofXwVhAffjyQcDIuQG4ooQHlHEfqRfgMaRRB3t9p0WBJNRRBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lH+l4kXb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776065441; x=1807601441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q2VxeAv+3WTmb5fk+gyYvqLE3UVXnKyqFELWxysd6/o=;
  b=lH+l4kXbJJa/jCb5FPx77z7V80PwFRazN6qOA6Op4DlnC4X5/qQh1aQm
   h9c6VszE+b95Fb5BAiSJw/BEaRdUVKacHQvdHbBctOE+FeSOL+QgB7gfU
   Rv2shCjsn/pYxpi8LzKIcHYk5d2ML8fb3dm5hg7d1DIfANWiuZQlXlSKF
   bhA33m79tryoFPRpQe52opo8VoZ7fcOdFSToXhKX32ICN+BR9mJj/xy21
   rLBbUu0wCzINUgUbLq2ItWASD5spPk7gt7MziLkE1oa9nU9sb4nKlj4Bn
   yzluq/GXPTXFsVKTjsuI89msTJcxBliyoKgeAAu8Gazx1cuIbwuJmtwf4
   g==;
X-CSE-ConnectionGUID: qdyW6K1AT3qGDe1/bMX1eg==
X-CSE-MsgGUID: i6fg9IW1T9ywvJ7095V+Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="80876626"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="80876626"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 00:30:41 -0700
X-CSE-ConnectionGUID: 9TDA8Ro9Qaeqerei148juA==
X-CSE-MsgGUID: 6nEkX4/dQ3elTlU7VBScrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="267700541"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 13 Apr 2026 00:30:40 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net 2/5] iavf: fix error path in iavf_request_misc_irq
Date: Mon, 13 Apr 2026 09:30:32 +0200
Message-ID: <20260413073035.4082204-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
References: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277971-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 017D23E8424
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Piotr Gardocki <piotrx.gardocki@intel.com>

When request_irq() fails the interrupt vector was not registered for
the driver. Calling free_irq() on a vector that was never successfully
requested triggers a kernel warning. Drop the erroneous free_irq()
call from the error path.

Fixes: 5eae00c57f5e ("i40evf: main driver core")
Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index dad001a..ab5f5adc 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -587,7 +587,6 @@ static int iavf_request_misc_irq(struct iavf_adapter *adapter)
 		dev_err(&adapter->pdev->dev,
 			"request_irq for %s failed: %d\n",
 			adapter->misc_vector_name, err);
-		free_irq(adapter->msix_entries[0].vector, netdev);
 	}
 	return err;
 }
-- 
2.52.0


