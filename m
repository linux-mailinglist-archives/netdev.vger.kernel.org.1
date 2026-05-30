Return-Path: <netdev+bounces-293308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDrBLMiAGmrJ4wgAu9opvQ
	(envelope-from <netdev+bounces-293308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 08:16:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D06360B678
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 08:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 616833017276
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 06:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1172C2C032E;
	Sat, 30 May 2026 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfAWUpFD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7932F280CD5
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 06:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780121796; cv=none; b=LVjIwoZhyOfuH8BxPeVsowm5F/6B6NoNgxLf1W8xGBd4B4s5rLaeFVAU9oqLI1WwgeJ22F0Cvpx9BK12uCJGE6ezNPDetFeneXkE1G2e32qiM5bX5TbO9ohUY/1geiOoOMaHtfAnGPmcwTNc6RMGeM+ClIRMc3TNipFBCCjR96o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780121796; c=relaxed/simple;
	bh=bC0wUWHFL7U7X1agdUwUWr4t3hqqf76i/gbDg9f3a6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ltVARmVuDGaSdCcFjW9Ms/DkTVaM6f5cZvBCcjdTdLfwrWk1hs0c+zmuvdX08Xek/f8yJA1rpzpIHU+gRSQgW8QshGcGex+bTtMRcxFXXuqdaz7jTTvSuoBYhW+bAwnhneNt7hpapbU8HFNqkolFUie77Cw/WnzQUUul4VpS4SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfAWUpFD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so1069276f8f.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 23:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780121793; x=1780726593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3zGExtjvsNMHWQ1BxnTLAs/3EDuafyS4jxSsvDCCUXs=;
        b=LfAWUpFD9mrg8mHS24MR/WPC5OB/eTJiqUF84a+ePLwZb36i+PVGzbI64Shu154TiO
         p1yVsYcwdE7deZAbe7nnqfm3koHQFbSfyqGE6yKigKlqePRgODJbYaIrDod9lHGCaOX4
         2yKQB6laots7/BhC4kOHkAUI7ST2gcfMMA9f+bFNWzswne8AY75hXncVPhanEoaVA7bl
         f3aCZOz6q/HYheDnjyzKJ3sU5/2fjL2aDE+psnZ0SCee0KJdWBVM+2hven1p/hImGtEu
         bfu0J66XTscgRTM+PpeP5yib+60xzaZOMMIBZJL/yvDcGssN+R3fzFY/8XTYkDzKISlL
         dBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780121793; x=1780726593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zGExtjvsNMHWQ1BxnTLAs/3EDuafyS4jxSsvDCCUXs=;
        b=SwvXz1bz8nkuJVTXlPry3dQXVN8k9hpjMb1vUFXyhn/1MoB1cHQvqiQMppGYIFq0jn
         ICZsi/n7Mozda8+zIefgjw3u0jNiBfNn2Sr5TKnc+ivbj9YjFgcseExV1w5A2ZH0FLIx
         K+0NbaVe4/Ce+KaL1VjRAyCFu+AjMyWkHjE18/ONmW/46jM4HNv1YVUKE6X/ckZvZLjc
         +EGh3+P4BmyKa+cVpYfilAwnmMy+1Y0VW7qfE28l/mDubDGUR6HebrN6UZm3iYJ8UjLN
         VsUbK6DNr/cabmUo+d3HvFbyEguQDQQ2Fb1LXe865fxwXWCkcYMP7v18gPnBrLOgYXVf
         1YBA==
X-Gm-Message-State: AOJu0Yyz1RqUIa+YWwDlsF0obA0eLaHHJ95ptd007hFchnJKnFcnf5sD
	qy69IRcTcLLamub17BTjvDHhg96n/GJKJ0PwEiK+Foe4wramspsYW3Ywd8BPFg==
X-Gm-Gg: Acq92OET5+Yxc63DoFoJBEU4j5csLBAFv2Zc/zmSHLgb4Kecb+R2m/lY7qQmsOi8x3c
	6IiXB91Yxnwdosz1WiAk8FmFE9oiOeDDQSsFRm/mnYRnSaWyojMdqbvaepeQTjWeHI/mI6jk6tl
	wJIdAjwdv1AKhuBRaKYR5/54eNYpXNTfuYcCYCMf87dliKg6NHCoL78Wpaf/bya0xUgXpZGgVLz
	u1UbEaik0ahVi+/9akbawSkVtOQ765S/nyvs61RUHcYohZj9eNi4gcBNWkhrQzUqjbu7Rk3wHXr
	9HdAYixGMBeWvRxJQ2Ze+R8lKBi1cQnuUe4mZqo9KF5EoAOMx47rLZ9CR4m2K4cW3TFY/bY20j+
	YOzspTv/xSTzTC392S/dZqCCBWFxmuEFNuE31arnjO651PBEfb+1XMr+PmarVMvKR1COD2eAtGk
	979NAmfhxKJV3jzEp/G1cJ+GgxyrDHtFaxuqEA/4RaDI+P6dAFxcSRXscEPhI6HgPjPyuK6M00c
	JFfLgpPByjTmdMZtrykWzs0Ds9a
X-Received: by 2002:a05:600c:3587:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-490a2941425mr45818935e9.29.1780121792623;
        Fri, 29 May 2026 23:16:32 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6f3612sm89382875e9.12.2026.05.29.23.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 23:16:31 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: netdev@vger.kernel.org
Cc: sd@queasysnail.net,
	steffen.klassert@secunet.com,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH net v2] xfrm: propagate -EINPROGRESS from validate_xmit_xfrm()
Date: Sat, 30 May 2026 08:16:19 +0200
Message-ID: <20260530061619.2239-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-293308-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,queasysnail.net:email]
X-Rspamd-Queue-Id: 1D06360B678
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
stolen skbs and return ERR_PTR(-EINPROGRESS) when all skbs in the
list were taken by async crypto.  Update __dev_queue_xmit() to return
NET_XMIT_SUCCESS in that case.

Fixes: f53c723902d1 ("net: Add asynchronous callbacks for xfrm on layer 2.")
Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
---
Changes in v2:
 - Only reset rc to NET_XMIT_SUCCESS when PTR_ERR(skb) == -EINPROGRESS,
   not for any IS_ERR() result (Sabrina Dubroca)
 - Add comment explaining why rc is reset and the async delivery path
 - Fix validate_xmit_skb_list(): track stolen skbs and return
   ERR_PTR(-EINPROGRESS) when all skbs in the list were stolen by
   async crypto, not NULL (Sabrina Dubroca)

 net/core/dev.c         | 15 +++++++++++++--
 net/xfrm/xfrm_device.c |  2 +-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 804e8ad25..618e6299f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4079,6 +4079,7 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
 struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *dev, bool *again)
 {
 	struct sk_buff *next, *head = NULL, *tail;
+	bool stolen = false;
 
 	for (; skb != NULL; skb = next) {
 		next = skb->next;
@@ -4088,8 +4089,11 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *d
 		skb->prev = skb;
 
 		skb = validate_xmit_skb(skb, dev, again);
-		if (!skb)
+		if (IS_ERR_OR_NULL(skb)) {
+			if (IS_ERR(skb))
+				stolen = true;
 			continue;
+		}
 
 		if (!head)
 			head = skb;
@@ -4100,6 +4104,8 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *d
 		 */
 		tail = skb->prev;
 	}
+	if (!head && stolen)
+		return ERR_PTR(-EINPROGRESS);
 	return head;
 }
 EXPORT_SYMBOL_GPL(validate_xmit_skb_list);
@@ -4859,8 +4865,13 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
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
 
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 5454be0b2..7702cca2b 100644
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


