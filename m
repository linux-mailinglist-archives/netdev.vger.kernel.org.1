Return-Path: <netdev+bounces-297304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TQ4rAhCJKGp1FwMAu9opvQ
	(envelope-from <netdev+bounces-297304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:43:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0A36644FA
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:43:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=WnAh0v8G;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297304-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297304-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCFD230FA26F
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 21:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B564E48AE04;
	Tue,  9 Jun 2026 21:36:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C817403B15
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 21:36:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040978; cv=none; b=chG3pp7PIEIIr8aRaGiv65G4YGjq36ijGrLVmPAPQWu+1YQwnaoWUAfRWfa1zB4uIdI1xzHRCtsHrMorW5ITFPimwqeB1dz9F97k9EhKGlyX/cxw/Snu9tKHsDP5VNEJnfPLQfKujwNv/2J3W7tguWg6fssc5NWTwdIW3/zGopw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040978; c=relaxed/simple;
	bh=MFWyt9HcWrYutHYiGP1u2/Xd12ayw+m8UijtWvHMy4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4D6/aTCvymiCAsM/DlQ1OE9n6O1RdJ9rvprgpzdXzNvL8054yEkBSIpnb5EfsBmS5fEfL8eRFqqlCZ0TDI58TpjflmTHKQv2TzyYQPRQlUqrhAHXkMU6KxGRINq2yRwNdt8T+qXgxeC8aLzpwtiQK1oqYfZR7aBQ/yx3dssUKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnAh0v8G; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781040974; x=1812576974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MFWyt9HcWrYutHYiGP1u2/Xd12ayw+m8UijtWvHMy4o=;
  b=WnAh0v8GM5Y2OgJWovPWjTbmPFLubwSdUMkm3mDt8xT0chP47nPW0PEf
   MCrL5OVeag6pJs/E0gomt70FR248euXdhNb44cwnLAFaSnZ2sMh9olVe9
   cDiVfV/v3p3jN89/1mqD6H1Gup57mh1SW4dSwln0R1DHogmfTjkpuSkvD
   y4s2AVDb9ILTELnJSwvVWfKZlCMjSqFTy5DW3qlSOqb57lPG/qBeVWnDP
   tYo7dKBHKfz1NeS0Nqza8aAwaBbrFTTDfjU9kFG68WignXy0YGoE9o7jO
   WA9CUL5RbgIzXbS+DKR+jNC6V7Reno8jhOQr2+iPk0/HO5A5miDz4+EQZ
   Q==;
X-CSE-ConnectionGUID: k0v5YpmZTBaQKxBJHU+TAw==
X-CSE-MsgGUID: Nyg2BMVwS7el251GiajRHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81568576"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81568576"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:36:09 -0700
X-CSE-ConnectionGUID: aZ6JcDhmSeGcz13869SOFg==
X-CSE-MsgGUID: dlGuoHAWRSCaYGXFuCsUpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245838594"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Jun 2026 14:36:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Daiki Harada <daiky0325@gmail.com>,
	anthony.l.nguyen@intel.com,
	Kohei Enju <kohei@enjuk.jp>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 09/15] igb: use napi_schedule_irqoff() instead of napi_schedule()
Date: Tue,  9 Jun 2026 14:35:50 -0700
Message-ID: <20260609213559.178657-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
References: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
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
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,enjuk.jp];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:daiky0325@gmail.com,m:anthony.l.nguyen@intel.com,m:kohei@enjuk.jp,m:aleksandr.loktionov@intel.com,m:sx.rinitha@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297304-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A0A36644FA

From: Daiki Harada <daiky0325@gmail.com>

Replace napi_schedule() with napi_schedule_irqoff()
in the interrupt handler path in igb driver

Tested on QEMU with igb NIC emulation (-nic user,model=igb)

Suggested-by: Kohei Enju <kohei@enjuk.jp>
Signed-off-by: Daiki Harada <daiky0325@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 17eff90af9e3..056a5546956e 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7157,7 +7157,7 @@ static irqreturn_t igb_msix_ring(int irq, void *data)
 	/* Write the ITR value calculated from the previous interrupt. */
 	igb_write_itr(q_vector);
 
-	napi_schedule(&q_vector->napi);
+	napi_schedule_irqoff(&q_vector->napi);
 
 	return IRQ_HANDLED;
 }
@@ -8198,7 +8198,7 @@ static irqreturn_t igb_intr_msi(int irq, void *data)
 	if (icr & E1000_ICR_TS)
 		igb_tsync_interrupt(adapter);
 
-	napi_schedule(&q_vector->napi);
+	napi_schedule_irqoff(&q_vector->napi);
 
 	return IRQ_HANDLED;
 }
@@ -8244,7 +8244,7 @@ static irqreturn_t igb_intr(int irq, void *data)
 	if (icr & E1000_ICR_TS)
 		igb_tsync_interrupt(adapter);
 
-	napi_schedule(&q_vector->napi);
+	napi_schedule_irqoff(&q_vector->napi);
 
 	return IRQ_HANDLED;
 }
-- 
2.47.1


