Return-Path: <netdev+bounces-293824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHzxJTmsHWoLdAkAu9opvQ
	(envelope-from <netdev+bounces-293824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:58:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1046222A8
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28E2830098A7
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 15:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18A53D9028;
	Mon,  1 Jun 2026 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/WfevG2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB5A3DB33F
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329507; cv=none; b=Mew1CMO84rw4FKIpov5wZNMEN0bRPyw25b9aV03LpX8u+uKNzpzEdbzEgFUF4XdWWele08rG4yUdBpUvRzMinJ13ag+8rmQ5Ve8U5DflyI1ZPllKM0IjLnImkdchKtHqfNK1kwpcn9NFIeozqWUcBRjMry8obemII5qJK8qnUmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329507; c=relaxed/simple;
	bh=aRhaKae58+1QBvbwOSJcWCuAqsvjo0niW7gM5sWatCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V62XkBh9KhdiFbwf4xnpaOiQyMq2K7urETCYqUs4+iYeMWizc4jonrWpt15C+PV+1KRlh3Zp993YixvmSBF6czCdGrzbnqYgAdR6Q6q6e310oSmA0MWxPM1cs4DC19nhtxxyUJyv2ZA7rGopCSyWWaURSWFoy7E2ZxOrV1XtfVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/WfevG2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so2529047f8f.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 08:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780329504; x=1780934304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VlW+vbYF7482TYDjWIvi4SeVFQEvJrBhEHeIE/y06pY=;
        b=k/WfevG2yeDqDhOHZUk8CeuRcLMi76y5AL0oxYXwNaiMKO78pF/P513rpZWm22STsY
         4vzx8y7muWz3zlbwW/xvcGsvDo5stVvTk6L5P4tTUuF79w4eyAZalQgB7IVjxyU6kTIf
         aNJg1kasE5b/NQBzw8Qj0AyivWI6zC6jaiuDPUL/oTCwTRP+H6g8MKRoWSTD2HF4lnbY
         W5+5YjSEIVZcNfmlvwdP0pFDAabJBAhpa41WV6RBkrtjO1eNmULZaELFTvs8oGgjoXFd
         VNWticDruWpu57RigQuDYnSvCtFScS26SIuzNI50porUOwzf6iO/JkYMQgrZ8B0pfOAc
         h/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780329504; x=1780934304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlW+vbYF7482TYDjWIvi4SeVFQEvJrBhEHeIE/y06pY=;
        b=miFOPqs9DHskXUHbk1hVtHgntiGSJC8+QKsjx/ZNBC50IOR8XNzry9LviIVRQJGcLd
         ZH59UVuFYvTRT+t6I2oXrc0GDQ0JvfyJf4BMm9dk5kVdpDTwp4usyagUkN2+R3b+3pcM
         m35Wi/XOXeMCKg+mbbKCTdmLJibucG6WJdy/OsyZdo5MlbOv39tw3Qaqd0zz9IR+7hJu
         kn0eYJUH8Ga8A6W1+SlBW6u8bpmIRLeesPkFCUxaMQry2Tuf0lT8F7Euul3EFiPLAjzE
         aSPmltX5HeKnYmwQlXExWwURkpJ420J1KIDfHwRFYwpgwth5MPRSHi7kEdd19rukbi+j
         dOQQ==
X-Gm-Message-State: AOJu0YyrxO8bw6N3DoG9KN2oYIlPR4bqFJmTd1tlNyX8PJGPvn8nXDnn
	o7KMoPH5KyZH1j+nyr4Cp6u8sipYt2dzIC+ikCU9yF+SYWfXcXhMUAkMDNAGrxL6
X-Gm-Gg: Acq92OHqRl3RzW7W09VWwpbkBqXYhxEOZXeFcagHGRGnpDJGAGhhfSwRCNNEfVLQuJf
	0Fq6iggF478SZtH82EdpzsJCyJ6RVBVsLkUqK27ATkV/GM52sTbcbVazRqxwZI3KudG9ElpBhQs
	9/yPbks0IM8LbJrAav45ZeTAOzsII1wrcSK7mk9yPsxuu4kcG2L1Bvx7/Mmq/4v4OvicVgUT4Hu
	A8v3gbofrh+qXipJ7W5Ruy4NQdHhbCaElNLzsxpXhFgBdoJkaa5OkGglAQT24r8eCFY7Elg89MZ
	uLeFi+hA8RbYA6QGZaXP18w9KvqlrgSSvfhbZ3hgYtSvwUjPipJB12CfP1AV/KNjssitIg8t4FA
	kJLgM7W/jOsyeC+05ASg490X4HbkZ+9NMOAxlQ1CuObuqNt7xqXiJtxcStXbqro5XFNW0lFrpWh
	9vf85E+fqsKyrULUxXxiyzfdX14G3QLlyJwDQtF8wC+sF60YKTYQFu9hb1/Hepr9X1z+Cyywyjj
	ZVSx/qg1ULB8O7G7csFHgp1
X-Received: by 2002:adf:e389:0:b0:45e:f5b6:7bf9 with SMTP id ffacd0b85a97d-45ef6b79a95mr16907141f8f.31.1780329504324;
        Mon, 01 Jun 2026 08:58:24 -0700 (PDT)
Received: from ipsec-VMware-Virtual-Platform (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354bb7asm25549621f8f.20.2026.06.01.08.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:58:23 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: netdev@vger.kernel.org
Cc: sd@queasysnail.net,
	steffen.klassert@secunet.com,
	pabeni@redhat.com,
	edumazet@google.com,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH net v3] xfrm: propagate -EINPROGRESS from validate_xmit_xfrm()
Date: Mon,  1 Jun 2026 17:58:22 +0200
Message-ID: <20260601155822.20954-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[queasysnail.net,secunet.com,redhat.com,google.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293824-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,queasysnail.net:email]
X-Rspamd-Queue-Id: 3E1046222A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

validate_xmit_xfrm() returns NULL both when a packet is dropped and
when it is stolen by async crypto (-EINPROGRESS from ->xmit()).
Callers cannot distinguish the two cases.

f53c723902d1 ("net: Add asynchronous callbacks for xfrm on layer 2.")
changed the semantics of a NULL return from "dropped" to "stolen or
dropped", but __dev_queue_xmit() was not updated.  On virtual/bridge
interfaces (noqueue qdisc) __dev_queue_xmit() initialises rc=-ENOMEM
and jumps to out: when skb is NULL, returning -ENOMEM to the caller
even though the packet will be delivered correctly via xfrm_dev_resume().

Return ERR_PTR(-EINPROGRESS) for the async case so callers can tell
it apart from a real drop.  Update validate_xmit_skb_list() to track
skbs stolen by async crypto and return ERR_PTR(-EINPROGRESS) when all
skbs in the list were taken by async crypto.  Update both
__dev_queue_xmit() and __dev_direct_xmit() to handle ERR_PTR correctly.

Fixes: f53c723902d1 ("net: Add asynchronous callbacks for xfrm on layer 2.")
Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
---
Changes in v3:
 - Fix validate_xmit_skb_list(): set stolen=true only for -EINPROGRESS,
   not for all IS_ERR() cases (Sabrina Dubroca)
 - Update __dev_direct_xmit() to handle ERR_PTR(-EINPROGRESS) from
   validate_xmit_skb_list() before kfree_skb_list() which would crash
   on an ERR_PTR (Sabrina Dubroca / sashiko)

Changes in v2:
 - Only reset rc to NET_XMIT_SUCCESS when PTR_ERR(skb) == -EINPROGRESS,
   not for any IS_ERR() result (Sabrina Dubroca)
 - Add comment explaining why rc is reset and the async delivery path
 - Fix validate_xmit_skb_list(): track stolen skbs and return
   ERR_PTR(-EINPROGRESS) when all skbs in the list were stolen by
   async crypto, not NULL (Sabrina Dubroca)

 net/core/dev.c         | 19 ++++++++++++++++---
 net/xfrm/xfrm_device.c |  2 +-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0c6c270d9..b77364f83 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4078,6 +4078,7 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
 struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *dev, bool *again)
 {
 	struct sk_buff *next, *head = NULL, *tail;
+	bool stolen = false;
 
 	for (; skb != NULL; skb = next) {
 		next = skb->next;
@@ -4087,8 +4088,11 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *d
 		skb->prev = skb;
 
 		skb = validate_xmit_skb(skb, dev, again);
-		if (!skb)
+		if (IS_ERR_OR_NULL(skb)) {
+			if (IS_ERR(skb) && PTR_ERR(skb) == -EINPROGRESS)
+				stolen = true;
 			continue;
+		}
 
 		if (!head)
 			head = skb;
@@ -4099,6 +4103,8 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *d
 		 */
 		tail = skb->prev;
 	}
+	if (!head && stolen)
+		return ERR_PTR(-EINPROGRESS);
 	return head;
 }
 EXPORT_SYMBOL_GPL(validate_xmit_skb_list);
@@ -4858,8 +4864,13 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 			goto recursion_alert;
 
 		skb = validate_xmit_skb(skb, dev, &again);
-		if (!skb)
+		if (IS_ERR_OR_NULL(skb)) {
+			/* -EINPROGRESS: packet stolen by async xfrm crypto,
+			 * delivered via xfrm_dev_resume(). */
+			if (PTR_ERR(skb) == -EINPROGRESS)
+				rc = NET_XMIT_SUCCESS;
 			goto out;
+		}
 
 		HARD_TX_LOCK(dev, txq, cpu);
 
@@ -4920,7 +4931,9 @@ int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 		goto drop;
 
 	skb = validate_xmit_skb_list(skb, dev, &again);
-	if (skb != orig_skb)
+	if (IS_ERR(skb))
+		return PTR_ERR(skb) == -EINPROGRESS ? NET_XMIT_SUCCESS : NET_XMIT_DROP;
+	if (!skb || skb != orig_skb)
 		goto drop;
 
 	skb_set_queue_mapping(skb, queue_id);
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 550457e4c..bb0c0fafa 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -182,7 +182,7 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 		err = x->type_offload->xmit(x, skb, esp_features);
 		if (err) {
 			if (err == -EINPROGRESS)
-				return NULL;
+				return ERR_PTR(-EINPROGRESS);
 
 			XFRM_INC_STATS(xs_net(x), LINUX_MIB_XFRMOUTSTATEPROTOERROR);
 			kfree_skb(skb);
-- 
2.51.0


