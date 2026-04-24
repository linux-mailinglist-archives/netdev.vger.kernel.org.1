Return-Path: <netdev+bounces-281065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NfiDB3x62nWTAAAu9opvQ
	(envelope-from <netdev+bounces-281065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 00:39:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E59463D71
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 00:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8814E301E6DF
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 22:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C540235CBD7;
	Fri, 24 Apr 2026 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b="NS69Nzir";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b="e618b1sS"
X-Original-To: netdev@vger.kernel.org
Received: from acj35aaf116.lhr1.oracleemaildelivery.com (acj35aaf116.lhr1.oracleemaildelivery.com [130.35.116.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A73A342C98
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.35.116.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777070319; cv=none; b=Zu04VcVn6bVER2ena5BJvp/5xH0pXuZH8Tvm/sA4pcaeFeNt7t4zmHuV+FAslawKHyNWrs1dUcV4oCBmdNYZcryIEJBc+qLRQl0JV7cfjEAfdjzVT8pxVxXJ9XTCY8KcOR3JcgP3axQJfbJHOyGgeCBMzZHg/02r7L1TB8FZRoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777070319; c=relaxed/simple;
	bh=BnZrme+n07vxnx6Gc6WomkLCKWVVXOCV0jCnq3S48zk=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=DJoshqSK0MHemMAxHCJcAZHGlbJB1ZQNMWEMHSu3h3ikxbUYdzoPPiGDLmCQHVpdPwI5zkmTuNcfw9rS565k00vCQln/VtS9EicY8TCsKKQHDBU3lG0LeK2yJ3OAzGXRG8Dz6mxYaSTVOvhnYAZkiS/TfLouDgO54sX/pzmuCFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b=NS69Nzir; dkim=pass (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b=e618b1sS; arc=none smtp.client-ip=130.35.116.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oracle-uk-012026;
 d=raczylo.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=lfGUtghlNG4rWJUxLiL6IFhhntR3JqJG5WwNQAV3PoQ=;
 b=NS69NzirwEBH9m5iSeyXZmrZi1QkTgrlifNjGq7neLbUJ5edDp4lvy4Cp5NYx17XLng0XfmBsh3i
   DrHRITU3iKVLrfGq/N8Uj1UGel4Zes0Agbo9b1NsvMD4W17kXkN2NQkVsKR19DRK/VwchkddTpvp
   DIXD3NyDphGSDo4geBKsLzqRSQ8weWWus8d76N38zHGUI3e4Yj/OLQSKD1vRF6qyYO+ex/NR3VU/
   cAXUlmFSrJEbYnWOnKrjHfUYqpPd8YL2sR1Z1RhGyPdZiGz+TNeHaZkISqFdKLnV8XgrLfcmPv1j
   +GfcBsYaST/xVQ0NFVQWaOxQZDOlgreIzUvNWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-lhr-20191104;
 d=lhr1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=lfGUtghlNG4rWJUxLiL6IFhhntR3JqJG5WwNQAV3PoQ=;
 b=e618b1sSB+z+SH+DOdROdOUHxmmgsFw94VnTfrRaQbXTMv2N154r3MYvva6kSOI7ccB33gFvebJ5
   0G922x14zgj0doQq8uPKLeJi+ohAuhQqGzpHxkP35eEliZ6flhPeJoHBv2jIzbX1a0bWS6KbJJ29
   z881z0C2eRxAjB1SLAiEHoQuW1lKISkL0bJxUwjbvGmS1Qcl3eNNHIvHeNWoEIFfR7lhblGsRMY1
   rin84SZFQhd0kZD3XoxuL3U/nBT0uCfxTxUd41nNVUqsu2OjgcE0bzMFfhjSpnBKSCpkeTugxcIh
   7DAkQ/iSSvcFsARFV+OEaU/aQnAFzEG4czHZEA==
Received: by omta-ad3-fd3-401-uk-london-1.omtaad3.vcndplhr.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20260212 64bit (built Feb 12
 2026))
 with ESMTPS id <0TE000K3RS8A6FE0@omta-ad3-fd3-401-uk-london-1.omtaad3.vcndplhr.oraclevcn.com> for
 netdev@vger.kernel.org; Fri, 24 Apr 2026 22:38:34 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Lukasz Raczylo <lukasz@raczylo.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,	linux-rpi-kernel@lists.infradead.org
Subject: [RFC PATCH net-next 2/3] net: macb: re-check ISR after IER re-enable
 in macb_tx_poll
Date: Fri, 24 Apr 2026 23:38:32 +0100
Message-id:
 <18740f04225a1778e6938ab5ecfe82087d66eb27.1777064117.git.lukasz@raczylo.com>
X-Mailer: git-send-email 2.53.0
In-reply-to: <cover.1777064117.git.lukasz@raczylo.com>
References: <cover.1777064117.git.lukasz@raczylo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFzDiYTuS9jvqSCDQoXiqVnkU2yDl7DFh57yZB8VktRLO86c1eFyO5ekvNWCLwV
 PHyd9gw8WA5srfV/TRAQ0XPcqN0ckK5QcJJwh0hKgoh7Az0U2pIlqjdC/64vKPp9
 xhg6FJXtsugGKA9eKcA6jNKYaIr+1CHVCiugkYOGc/61GNFQAr4Jkydhn5dX2m6x
 ZbTEKM+6EK2caCfgZeWUPZk7AL2k1NrRNF0eFznyXHe5aVJdGFn+XKEAyqWFEKNC
 WrmTOV0MpCLtL7gYWxtqmSDXAh6yw7dRljFgDF9ioQIz6NF3C5RyniySceoV/y0t
 W6MuIDulgIEnpYAEfAsp+KZy3KYvW4dsTpLDrPjfkla1Sn6OjTUlMHZOBAjOEsSp
 FXn8XrAqLv8lQb/9txy73iVkQokcSHWuql+4nqiwnDKzboBIKtzJmX/6TBWUnw==
X-Rspamd-Queue-Id: 87E59463D71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[raczylo.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[raczylo.com:s=oracle-uk-012026,lhr1.rp.oracleemaildelivery.com:s=prod-lhr-20191104];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	TAGGED_FROM(0.00)[bounces-281065-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz@raczylo.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[raczylo.com:-,lhr1.rp.oracleemaildelivery.com:-];
	NEURAL_HAM(-0.00)[-0.775];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[launchpad.net:url,raczylo.com:mid,raczylo.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

macb_tx_poll() runs with TCOMP masked, drains the TX ring, then
calls napi_complete_done() and re-enables TCOMP via IER.  An
existing comment in the function notes:

	/* Packet completions only seem to propagate to raise
	 * interrupts when interrupts are enabled at the time, so if
	 * packets were sent while interrupts were disabled,
	 * they will not cause another interrupt to be generated when
	 * interrupts are re-enabled.
	 */

and mitigates this by calling macb_tx_complete_pending(), which
inspects driver-visible ring state (descriptor->ctrl, after rmb())
and reschedules NAPI if a completion is observable in memory.

On PCIe-attached parts (BCM2712 + RP1 on Raspberry Pi 5 is the
setup we have in front of us), the descriptor DMA write that sets
TX_USED may not have retired to system memory at the point
macb_tx_complete_pending() runs.  The rmb() synchronises the CPU
view of earlier CPU writes; it is not sufficient to retire an
in-flight peripheral DMA write.  Under that ordering the in-memory
descriptor can still read TX_USED=0 when the hardware has in fact
completed the frame; the check returns false; NAPI exits; the
quirk above prevents the re-enabled IER from re-firing; the ring
goes quiescent.

Add an explicit ISR read after the IER write.  The MMIO read
serves two independent purposes:

  (1) It is an architected PCIe read barrier for earlier
      peripheral-originated DMA writes on the same path, so a
      subsequent macb_tx_complete_pending() observes any TX_USED
      write that was in flight at the time of the barrier.

  (2) It samples the hardware ISR directly, so a TCOMP bit that
      the hardware set while TCOMP was masked is visible here,
      independently of whether the descriptor DMA has retired.

If either signal indicates pending work, reschedule NAPI via the
same path as the existing check.

This patch addresses one of three candidate races for the silent
TX stall described in the cover letter.  Whether it is sufficient
by itself, or whether it requires the PCIe posted-write flush in
patch 1/3 to cover the observed behaviour, we have not yet
verified at runtime.

Link: https://github.com/cilium/cilium/issues/43198
Link: https://bugs.launchpad.net/ubuntu/+source/linux-raspi/+bug/2133877
Signed-off-by: Lukasz Raczylo <lukasz@raczylo.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 28 +++++++++++++++---------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b6cca55ad..ea231b1c5 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1973,17 +1973,25 @@ static int macb_tx_poll(struct napi_struct *napi, int budget)
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
 		queue_writel(queue, IER, MACB_BIT(TCOMP));
 
-		/* Packet completions only seem to propagate to raise
-		 * interrupts when interrupts are enabled at the time, so if
-		 * packets were sent while interrupts were disabled,
-		 * they will not cause another interrupt to be generated when
-		 * interrupts are re-enabled.
-		 * Check for this case here to avoid losing a wakeup. This can
-		 * potentially race with the interrupt handler doing the same
-		 * actions if an interrupt is raised just after enabling them,
-		 * but this should be harmless.
+		/*
+		 * TCOMP events that fire while the interrupt is masked do
+		 * not re-fire when IER is re-enabled.  Catch this two ways
+		 * to avoid losing a wakeup:
+		 *
+		 *   (1) Read ISR -- catches completions the hardware flagged
+		 *       but that we did not see as an interrupt.  The MMIO
+		 *       read doubles as a PCIe read barrier, flushing any
+		 *       in-flight descriptor TX_USED DMA writes into memory.
+		 *   (2) macb_tx_complete_pending() inspects the ring after
+		 *       that flush, catching a descriptor whose TX_USED is
+		 *       now visible as a result of the barrier.
+		 *
+		 * This can race with the interrupt handler taking the same
+		 * path if an interrupt fires just after the IER write;
+		 * rescheduling NAPI in that case is harmless.
 		 */
-		if (macb_tx_complete_pending(queue)) {
+		if ((queue_readl(queue, ISR) & MACB_BIT(TCOMP)) ||
+		    macb_tx_complete_pending(queue)) {
 			queue_writel(queue, IDR, MACB_BIT(TCOMP));
 			macb_queue_isr_clear(bp, queue, MACB_BIT(TCOMP));
 			netdev_vdbg(bp->dev, "TX poll: packets pending, reschedule\n");
-- 
2.53.0


