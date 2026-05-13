Return-Path: <netdev+bounces-287465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KSnHT8vBGo/FAIAu9opvQ
	(envelope-from <netdev+bounces-287465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:58:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D499D52F342
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3861E3040C99
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 07:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAB93D4104;
	Wed, 13 May 2026 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.b="8wC3Wexd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259EF3D79F1
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659042; cv=none; b=TNSU7t8O/u4w3RB/ntq1xuClgC62/oNphIgT4yZQsEeC6+ZfmEYx/iMmUUlOB4c5d38sCEvgFzrhRIBpfMndaEdqz+xLk3AO0msBpIVJs5uDM+fyEwQeX6TKsWH/MGUQO/y9BzYyjGeTUbNoZ51nw/o0G7a427EuYl/1VfQUsZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659042; c=relaxed/simple;
	bh=VzFvwyBEsuYeGNB9q3PsG9S/R+X/itiaI5nDCY7lr24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version:MIME-Version; b=cvckk+vApsF2ncGleb0UNPUXFFoTbN0kYzkpLDbcM5lz/kwUjnEeM5IutS7CNZ0EenAWCBzeDWjmi+uUF4N0+W+BL88BB/I+KzGBF7Sc0h2DVv/2LVpPQmDjQwuhC50N/viQhzRz7IfqwhFRlGQ5XVHtsHlFij34+hE69nXyyzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=fail (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.b=8wC3Wexd reason="signature verification failed"; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-CSE-ConnectionGUID: UjAzcxvsQimQmc0P4L5SHg==
X-CSE-MsgGUID: K92DXc4oTS24TFexoACgcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83452604"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="83452604"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 00:57:20 -0700
X-CSE-ConnectionGUID: X9LCdGwwQDqtHAuCPuAuGQ==
X-CSE-MsgGUID: VXISY2OcR9+VfkT7xGEbSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="261759682"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa001.fm.intel.com with ESMTP; 13 May 2026 00:57:18 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	"Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>
Subject: [Intel-wired-lan] [PATCH iwl-net v4 3/5] ixgbe: fix cls_u32 nexthdr path returning success when no entry installed
Date: Wed, 13 May 2026 09:57:08 +0200
Message-ID: <20260415142841.3222399-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260415142841.3222399-1-aleksandr.loktionov@intel.com>
References: <20260415142841.3222399-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Submitter: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Patchwork-Id: 2223538
X-Patchwork-Delegate: anthony.l.nguyen@intel.com
X-Original-To: incoming@patchwork.ozlabs.org
Delivered-To: patchwork-incoming@legolas.ozlabs.org
Authentication-Results: legolas.ozlabs.org; dkim=pass (2048-bit key; unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=8wC3Wexd; dkim-atps=neutral
Authentication-Results: legolas.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=osuosl.org (client-ip=140.211.166.137; helo=smtp4.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=patchwork.ozlabs.org)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384) (No client certificate requested) by legolas.ozlabs.org (Postfix) with ESMTPS id 4fwk6K0MbVz1yHc for <incoming@patchwork.ozlabs.org>; Thu, 16 Apr 2026 00:28:57 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1]) by smtp4.osuosl.org (Postfix) with ESMTP id CE8884B08F; Wed, 15 Apr 2026 14:28:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1]) by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP id a_0oq9ZBiD80; Wed, 15 Apr 2026 14:28:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 561214B2D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org; s=default; t=1776263333; bh=/m6WWzlcLK2jIquH1fBIuBKUUcfgnJ5EDwGzGSrPaig=; h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id: List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe: From; b=8wC3WexdmcGdM8UBu0AzNEgGWej//QJI+9aJHh6V2rIzpugCt4QkEqYDm76TlDgP+ ueeqty94dCqJMvpfLDPSn3ao0du2i2ymyN81n51BIQDPB45JaKSTQungVx7ikEF+6r RnaYkb+0EWepCYF2pKH3Eo9YddJI+/gMJpGemWpADTMrB1aYE374sq97A6825NgWNX fTutWtoCEz7ZbM74OEIXCO6OXqSt/kJrhv+zBqhxjyGZ2IikwooFLf/zUn7P1o1JwN 4sA0jd7BPE8xXs+RogyqQE3kCN2ov/+97sF3k05R2u1/rXY3sjcOF7mJ6Y5juj3kkp BotxYEIVfnJXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142]) by smtp4.osuosl.org (Postfix) with ESMTP id 561214B2D7; Wed, 15 Apr 2026 14:28:53 +0000 (UTC)
X-Original-To: intel-wired-lan@lists.osuosl.org
Delivered-To: intel-wired-lan@lists.osuosl.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138]) by lists1.osuosl.org (Postfix) with ESMTP id 3BA3E283 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1]) by smtp1.osuosl.org (Postfix) with ESMTP id 21E5E825C3 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1]) by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP id tP4tzEwKOlYw for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 119B085475
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 119B085475
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16]) by smtp1.osuosl.org (Postfix) with ESMTPS id 119B085475 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:50 +0000 (UTC)
X-CSE-ConnectionGUID: SypIIIEiRY+OSNJJnm860Q==
X-CSE-MsgGUID: 45EdJcHMRNWpOJRfb0gOPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77423743"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="77423743"
Received: from orviesa003.jf.intel.com ([10.64.159.143]) by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:28:50 -0700
X-CSE-ConnectionGUID: y/EfwaZqQfWVh46NKVJarA==
X-CSE-MsgGUID: qp8XxpSnSuGFks2ZaAeTHA==
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="234467873"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225]) by orviesa003.jf.intel.com with ESMTP; 15 Apr 2026 07:28:48 -0700
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=intel.com; i=@intel.com; q=dns/txt; s=Intel; t=1776263331; x=1807799331; h=from:to:cc:subject:date:message-id:in-reply-to: references:mime-version:content-transfer-encoding; bh=UPq6I5ywuqsWlMV/CExGXVtW7/DyZKY/nvZFhIfzgBM=; b=iHlQJ3lpk+Soo9uJBQhPyL6f+MAGM7HvHd5F3g82p0wQROFseT1Ft9JG Uy6ihuCG4QKux3YwHxN7LOPYNZ1LV6FX1ImfdqXUBoRxTDBXjpq5evQHS 4ZRzckHrKlyI+yO25WuqBdQU0Ui4zKjw35ZsjgYDOEZPw+1pvvB2KinZs IZOPKqNmehaTA8RoATXnEHJGWmCvnvCdzapdEhOzg2HkUgVUSHyUshQwO i0HmW7R5enEPsPTPh8zNylj2lmTGYTB6MxfoMtngurbmWMxIhZJ84Qbgj 6H6uZc2vtlDJJijZtxHy1DwaNt6W+rfqYF6a/pGf6tUI3iU6Z8iuQvg4f w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iHlQJ3lp
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D499D52F342
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.59 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[osuosl.org:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.20)[mailman];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[intel.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-287465-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[osuosl.org:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[15];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.470];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ixgbe_configure_clsu32() returns 0 (success) after the nexthdr loop
even when ixgbe_clsu32_build_input() fails for every candidate entry
and no jump-table slot is actually programmed.  Callers that test the
return value would then falsely believe the filter was installed.

The variable 'err' already tracks the last ixgbe_clsu32_build_input()
return value; if the loop completes with a successful break, err is 0.
If all attempts failed, err holds the last failure code.  Change the
unconditional 'return 0' to 'return err' so errors are propagated
correctly.

Fixes: 1cdaaf5405ba ("ixgbe: Match on multiple headers for cls_u32 offloads")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
v2 -> v3:
 - Add Reviewed-by: Simon Horman; no code change.

v1 -> v2:
 - Add Fixes: tag; reroute from iwl-next to iwl-net (false-success
   return is a user-visible correctness bug, not a cleanup).

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 210c7b9..6e7f8a9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10311,7 +10311,7 @@ static int ixgbe_configure_clsu32(struct ixgbe_adapter *adapter,
 				kfree(jump);
 			}
 		}
-		return 0;
+		return err;
 	}
 
 	input = kzalloc_obj(*input);

