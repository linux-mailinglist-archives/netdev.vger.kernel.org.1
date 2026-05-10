Return-Path: <netdev+bounces-286299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCWXHsOhAGqTLAEAu9opvQ
	(envelope-from <netdev+bounces-286299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:18:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F51504C57
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C98C3002F6E
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DAF3A1685;
	Sun, 10 May 2026 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="jJsNvSfM"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550C539B497;
	Sun, 10 May 2026 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778426277; cv=none; b=TBrC3aKhGedAvauAYJDnkwOVftqxfxMCj3NtKd7QTZTgIgbZsTJIVHN/eIkyZ7ZYjUEhIcicKDOpSiRyZxOxa4FIhZ1miunBUx5XOFjTn16t2UsElwnHegdUwKcVG7XUrp5QKiPMYZcTdsR1LKYt1X+1yK/7UMEqo/uwcwGVPBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778426277; c=relaxed/simple;
	bh=inU863N1S0Wz3nqs95hMQKdZEMGNYnr8+oPFXullAts=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvSjGWK2V3b9Hr0XO5iWnNxMM63BcVM/bTHPc2djXBTNw+SayQU2N4cywZ6jc5gkG45lns+w4YJR8owKUgKAmoVMlzLDprZ5ONfzRVOw19f2cxiq5tS5PHLVAwC+UFHKqqLIiPrpKTxmcVsLt4fjKHQ3piZ3rgzCcjHVjQ1FT/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=jJsNvSfM; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1778426259;
	bh=inU863N1S0Wz3nqs95hMQKdZEMGNYnr8+oPFXullAts=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=jJsNvSfM1u/55cJHMCjd0w8FjyGAUuYmAoweCEMWll+4zjXdkxYTVNYEXebtPZyRU
	 H/efAbVXvEM9+ytW2NuHjkiDu2i8U/nqreNeGXSTWXWJNOX0DqlBwDeFIW92uoK3OJ
	 F9zzxOVdevlny9FPGHsONtGYetfAXFgSEaoe3KcY=
Received: from simon-Latitude-5450.fritz.box (pd9eaa57d.dip0.t-ipconnect.de [217.234.165.125])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 64AFHaTE009831
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 17:17:39 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
Subject: [PATCH net-next v12 3/4] ptr_ring: move free-space check into separate helper
Date: Sun, 10 May 2026 17:15:28 +0200
Message-ID: <20260510151529.43895-4-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260510151529.43895-1-simon.schippers@tu-dortmund.de>
References: <20260510151529.43895-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 69F51504C57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-286299-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This patch moves the check for available free space for a new entry into
a separate function. Existing callers that only check for a non-zero
return value are unaffected; __ptr_ring_produce() now returns -EINVAL
for a zero-size ring and -ENOSPC when full, whereas before both cases
returned -ENOSPC. The new helper allows callers to determine in advance
whether subsequent __ptr_ring_produce() calls will succeed. This
information can, for example, be used to temporarily stop producing until
__ptr_ring_check_produce() indicates that space is available again.

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 include/linux/ptr_ring.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index d2c3629bbe45..c95e891903f0 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -96,6 +96,20 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
 	return ret;
 }
 
+/* Note: callers invoking this in a loop must use a compiler barrier,
+ * for example cpu_relax(). Callers must hold producer_lock.
+ */
+static inline int __ptr_ring_check_produce(struct ptr_ring *r)
+{
+	if (unlikely(!r->size))
+		return -EINVAL;
+
+	if (data_race(r->queue[r->producer]))
+		return -ENOSPC;
+
+	return 0;
+}
+
 /* Note: callers invoking this in a loop must use a compiler barrier,
  * for example cpu_relax(). Callers must hold producer_lock.
  * Callers are responsible for making sure pointer that is being queued
@@ -103,8 +117,10 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
  */
 static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
 {
-	if (unlikely(!r->size) || data_race(r->queue[r->producer]))
-		return -ENOSPC;
+	int p = __ptr_ring_check_produce(r);
+
+	if (p)
+		return p;
 
 	/* Make sure the pointer we are storing points to a valid data. */
 	/* Pairs with the dependency ordering in __ptr_ring_consume. */
-- 
2.43.0


