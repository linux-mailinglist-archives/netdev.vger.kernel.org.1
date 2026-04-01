Return-Path: <netdev+bounces-274273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMHVK8mszWlRfwYAu9opvQ
	(envelope-from <netdev+bounces-274273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:39:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07214381BA5
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DFB830514AB
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 23:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA073EF0B0;
	Wed,  1 Apr 2026 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="IFu2GVE5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49C13EFD30
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 23:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775086681; cv=none; b=mI09qknH5ka5ku8I6fBWzo7quJQBcxMrAS/E2NPlovWKOS2W3i4dqRan/+iUX3tRIeaPXLMbcsWuVrdAI4fufnW/LD2rW9l6s3RIcrHTLBQCwyCBo65gyzUvEla2gXiq4iDrXMVNcMhk10g6BH8xGNrBc/AEOb5ZQqS/eVebuRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775086681; c=relaxed/simple;
	bh=qqTo0OGVy97q53yKZcD7KVbNbUy3LwcG0BT5l19gi00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUfk7Bz3XlN30zHVNciNXwfAa0a1f/yQmVaNeR1su3+EmOKEaX+ughFHAZvZDUy0qwXgJmraEY+4aQZhgkQuTR0eG2ZxyFbdxzSBxNt7LIEOU5JmYBggKtGMuAO5illKAR2ra01kFlb0gKmPrFIu2ec1K1UPgal43kxw/eGHybw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=IFu2GVE5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b258d93ffeso1348985ad.3
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 16:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1775086680; x=1775691480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifpHKJdUDsXQbmh4bEHFURA21vSlk2ladF+OAXDwL3I=;
        b=IFu2GVE5SzXHx6Q/M8eG0wdhUJXqQtc5HC/u2g+ziy2CbJAmG5qqle5NUcTnq7pX+6
         qbJGDynZdlGas+VtjIdM7pHkEkcOKdjlHGmW7uyK4uXpJXRJ50GPfzNvq7eAPjCr88Fs
         nF33XryfNn8iSG7bJNwcjCEFdEb686zZVWZrygpB3EngrHMsWZn5OE7b397VST8J37Te
         xelWgttHR7+UaariXI9duRDSmwg4ATmq99JsSGhP3ZzngGg3im9mSHi39ol3bE2sK3M8
         cGQCLpev7cYwkPzD+wJNxxygrzzxamoLPdUtjasGyK4ZzdW0+ERdeTElAAvdaAKrN1k/
         M6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775086680; x=1775691480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ifpHKJdUDsXQbmh4bEHFURA21vSlk2ladF+OAXDwL3I=;
        b=CbHH61RvaXx/hCyEYjoCkmFbUfzMMS1NcLI0c0Ro3pF7evtPujfZ6Ws4k7VMa7dZfM
         LqqUXcyuuih1xYxZHzoc0VglwkWw69uBsyKV+O6T0vSSGTyJA2V0cwFmdb2NOGHJM6Hm
         eJuz6CtPjzOk8Gh2qS34a/eDstCCZCUD7TkfAnQ4n/q2GVwnHmgcIlZsy3NBaqJOuelz
         qudiJhHEmUfR4lG8v8AsY/+RaoNkP4t9nocOIFlfdIY8vdlw0IM25o5XQxa4+XzXPojF
         +4xcV/mX3Xt1t+isZcrXvtgShHXo6UDZL7onn/ay+2FhZnn3QUOod7pFGOYE3iJksXDw
         G9AA==
X-Gm-Message-State: AOJu0YxyCuA7g8UJTzMMWWfNlSo/IdfYxe19aBDLYrjVcB+YpEymZi1I
	IePPNXtp6ULEowtjFzvwbIaL81WWEdw4VaN2yrBdZlSjukxCjOmw/RpJQEcpWZnea7knD5xFLnS
	XF0RTF5Q=
X-Gm-Gg: ATEYQzy4e34MWO+8rcPUARPO3bmKFT9eKeeZVu/SMPeqfl6wqV14G7qGXo5Mg+C87Wl
	uEIWPnhV58bp+TkqiuUBU9eXB2y5ZGfqgOiC/+rwCiKZ3IKJ/FJgmrY0phNSecSWHKrgGEu0wM5
	xTirY0kAKPK89upq+QYp328g8ItoLsQFWBKI4+cifpSJ99wZLnrxIUCvJftxL9rOHQ+WwR4pxZc
	NqYEyQewpdi745aZkD2GVl7sbimGMIhydYXYozZut9ZdrSrdHifX+bDcM5ofnsZCSR6osvDrNSo
	bULhMNbMDP8dwnBQ3M1PaVITIG6YWIReryNmtmmq16VryeDdmxi8msZSX119Ui0Q9PLkLpTqSk1
	msx1jlKxN0RJNpBaNIhpBtSnCXOMyfBBVYk9/Gdh4Alri6XqiauX3/7a1vcAXkizSmc+06SIzsG
	kCQLrj
X-Received: by 2002:a17:903:90f:b0:2b0:5ec1:97c1 with SMTP id d9443c01a7336-2b269a950c8mr50391395ad.7.1775086679678;
        Wed, 01 Apr 2026 16:37:59 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:44::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478cb4fsm9202845ad.29.2026.04.01.16.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 16:37:59 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v7 03/10] net: bnxt: Add a helper for tx_bd_ext
Date: Wed,  1 Apr 2026 16:37:31 -0700
Message-ID: <20260401233745.2333858-4-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401233745.2333858-1-joe@dama.to>
References: <20260401233745.2333858-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-274273-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: 07214381BA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Factor out some code to setup tx_bd_exts into a helper function. This
helper will be used by SW USO implementation in the following commits.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v4:
   - Added Pavan's Reviewed-by tag. No functional changes.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c |  9 ++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a6ff234c2864..6abe4bef8afd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -663,10 +663,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	txbd->tx_bd_opaque = SET_TX_OPAQUE(bp, txr, prod, 2 + last_frag);
 
 	prod = NEXT_TX(prod);
-	txbd1 = (struct tx_bd_ext *)
-		&txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+	txbd1 = bnxt_init_ext_bd(bp, txr, prod, lflags, vlan_tag_flags,
+				 cfa_action);
 
-	txbd1->tx_bd_hsize_lflags = lflags;
 	if (skb_is_gso(skb)) {
 		bool udp_gso = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4);
 		u32 hdr_len;
@@ -693,7 +692,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		txbd1->tx_bd_hsize_lflags |=
 			cpu_to_le32(TX_BD_FLAGS_TCP_UDP_CHKSUM);
-		txbd1->tx_bd_mss = 0;
 	}
 
 	length >>= 9;
@@ -706,9 +704,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	flags |= bnxt_lhint_arr[length];
 	txbd->tx_bd_len_flags_type = cpu_to_le32(flags);
 
-	txbd1->tx_bd_cfa_meta = cpu_to_le32(vlan_tag_flags);
-	txbd1->tx_bd_cfa_action =
-			cpu_to_le32(cfa_action << TX_BD_CFA_ACTION_SHIFT);
 	txbd0 = txbd;
 	for (i = 0; i < last_frag; i++) {
 		frag = &skb_shinfo(skb)->frags[i];
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index ce7291c68370..24a32ba7157a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2836,6 +2836,24 @@ static inline u32 bnxt_tx_avail(struct bnxt *bp,
 	return bp->tx_ring_size - (used & bp->tx_ring_mask);
 }
 
+static inline struct tx_bd_ext *
+bnxt_init_ext_bd(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+		 u16 prod, __le32 lflags, u32 vlan_tag_flags,
+		 u32 cfa_action)
+{
+	struct tx_bd_ext *txbd1;
+
+	txbd1 = (struct tx_bd_ext *)
+		&txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+	txbd1->tx_bd_hsize_lflags = lflags;
+	txbd1->tx_bd_mss = 0;
+	txbd1->tx_bd_cfa_meta = cpu_to_le32(vlan_tag_flags);
+	txbd1->tx_bd_cfa_action =
+		cpu_to_le32(cfa_action << TX_BD_CFA_ACTION_SHIFT);
+
+	return txbd1;
+}
+
 static inline void bnxt_writeq(struct bnxt *bp, u64 val,
 			       volatile void __iomem *addr)
 {
-- 
2.52.0


