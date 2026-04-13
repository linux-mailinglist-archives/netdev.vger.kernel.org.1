Return-Path: <netdev+bounces-277973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Hw8Erub3GkxUAkAu9opvQ
	(envelope-from <netdev+bounces-277973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:31:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B82323E8451
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B3D930173BF
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 07:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8C33939C6;
	Mon, 13 Apr 2026 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ErdtsyzB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7DD3939A4
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065445; cv=none; b=JIn2cjZizJAjLh3PI89TdjiKYXWUTaS2k8Q+cveuMB0JGJUlPUKd4P7yg0r+p3sp9Y3YrdR6K3XwUM1rHBkvujbcn1RMkg4/k7HamTyR6qBxnzj7GBXquBvbj2RE80nDBUDE7MoNlXFlmGM7wkSAJvFvD7kNYcMCUuGyc2negXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065445; c=relaxed/simple;
	bh=L00BtSpnf5+O+MupvLoKyYTpfp5AyA445wZpnSJZRNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RK3ZK9riFiZASGRozu8HSIoQu1TF7TTWTpOV7F/bCLJFJHxtwg18T6bzMzfwccXd1XLz8Ff/HnUBpthl1Vr4ifIA3JdRaSEUCFkGeLlpXByp9CO73yJZpoie35UeaMnYd+5EuPzVXcnW9WpcrzQrnsX/MZrayPdZ54DNyx8ofPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ErdtsyzB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776065444; x=1807601444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L00BtSpnf5+O+MupvLoKyYTpfp5AyA445wZpnSJZRNE=;
  b=ErdtsyzBusgwI1X8wMN6ONqjROx4rhwIvBG8IYWXXOaAB9iNWR2jW4f4
   6plQrfZwGnxszvsDSS9bfzDpTiyjivPy3/ElsXMDyB0bY/zNKOzYTl7xo
   HUMLQ0CLt8JdjSBWuHgfJRfoiFuxm8AYWpCCACG+C8o6Y0QaQ86Q8hMlR
   hMCRVTbQ9BL/6QpauD7U0IheltG9eW4dEAuloZHLcKiUHOGTQfyoEh7+d
   IAyq7qS+M4GvcQ5EyxEsM5SOyqlIvE2aiLz9Zu2kly2jKvoBiyipRqEvy
   YRo6ekHaAEJFWgsynIVfcvyQGk9YRqT7vUQHWkNaNETfdDRIt+8cUbXja
   g==;
X-CSE-ConnectionGUID: 4xxStaumQMaN0kfPJyQo2Q==
X-CSE-MsgGUID: n6hZkhHbRy2ueept0ZEN5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="80876638"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="80876638"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 00:30:44 -0700
X-CSE-ConnectionGUID: +D87Ji+sQViJfGZAY1t3nA==
X-CSE-MsgGUID: NL72vD+0QKiiUNUOzRy8+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="267700558"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 13 Apr 2026 00:30:43 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Avinash Dayanand <avinash.dayanand@intel.com>
Subject: [PATCH iwl-net 4/5] iavf: fix TC boundary check in iavf_handle_tclass
Date: Mon, 13 Apr 2026 09:30:34 +0200
Message-ID: <20260413073035.4082204-5-aleksandr.loktionov@intel.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail,intel.com:server fail];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277973-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B82323E8451
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Avinash Dayanand <avinash.dayanand@intel.com>

The condition `tc < adapter->num_tc` admits any tc value equal to or
greater than num_tc, bypassing the destination-port validation and
allowing traffic to be steered to a non-existent traffic class. Change
the comparison to `tc > adapter->num_tc` to correctly reject
out-of-range TC values.

Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index ab5f5adc..5e4035b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4062,7 +4062,7 @@ static int iavf_handle_tclass(struct iavf_adapter *adapter, u32 tc,
 {
 	if (tc == 0)
 		return 0;
-	if (tc < adapter->num_tc) {
+	if (tc > adapter->num_tc) {
 		if (!filter->f.data.tcp_spec.dst_port) {
 			dev_err(&adapter->pdev->dev,
 				"Specify destination port to redirect to traffic class other than TC0\n");
-- 
2.52.0


