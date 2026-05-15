Return-Path: <netdev+bounces-288265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MC3WCOXwBmp+pAIAu9opvQ
	(envelope-from <netdev+bounces-288265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:09:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC37F54D10E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F4B530ECA66
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E0044BC92;
	Fri, 15 May 2026 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="V01Z0WQM"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B3F449EC3
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838960; cv=none; b=LQh5qn+0lqroPgCMWVak8nZORD8J6lhDK+jrLi6zYPBsI1z/8NmdoNQdVRiCwh9Cs0V7oCicWSs3FKl3nUDOJR3uN6FWkdmCa6E+Qahl/9HCT4cGOdPjNncLvVM7nW4fmt4wZcUW7GnpJK8wj3DrzwMtA9oocNL0ixYGQih8Ycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838960; c=relaxed/simple;
	bh=0RJpjeXAAqwOp158cpiKzcEZ6wuDa5+Kv/77ZYm95f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxtvPkbS9GwnG0mdFrKzTo/u4Kon4zgzF0vZtLFeCO1pPwzAIOk2IYXZLPtTUk7M1PKzA8Cm1MQ+5zfNBC1Q4z33IMHlWRNZGJg1g0J5wtwskYxMEdaYSDiGTeZRY9X4G26fJfxrlu2zGXL6drAPM22S4jAwi83vV/YGNn8ZoVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=V01Z0WQM; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778838949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5vHw8qJWEIvBilfY5fBWVPvS5Ezs8Kaj2eIYWlXyjaw=;
	b=V01Z0WQMZR6jNOF1A9Ewe9eDDyqrr14hrivvqZKqu6LlMwhC3AqUmjHB2yXRGPanhotjCu
	66pmmFGXzg7Q1neib2JTWsz46uVSquplZFvM/LRbD/U/T6z/ye0nzngtGhNFihKweDwgz6
	KUK+GV6BM/cOhwWGpzjkztrar6Fih1PQsIzKYHO5+/M/LwBSsJyGQ4fuyTgrl4adKlQR//
	bv74AxTINZYpEpNoyvQN/i9n2U2BcHJATyxEPv0W+/h3NHECCvijcTi3Xnu/vP74cYYX9l
	FxJmBuaQ2zNuzO7ZN5ZWcQ/RvZ35ov+HBblssyE4/IJIEfogUwuAuds0wS1rNA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 03/14] batman-adv: tt: reject oversized local TVLV buffers
Date: Fri, 15 May 2026 11:55:28 +0200
Message-ID: <20260515095540.325586-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515095540.325586-1-sw@simonwunderlich.de>
References: <20260515095540.325586-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AC37F54D10E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288265-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Sven Eckelmann <sven@narfation.org>

The commit 3a359bf5c61d ("batman-adv: reject oversized global TT response
buffers") added a check to ensure that a global return buffer size can be
stored in an u16. The same buffer handling also exists for the local data
buffer but was not touched.

A similar check should be also be in place for the local TVLV buffer. It
doesn't have the similar attack surface because it is only generated from
locally discovered MAC addresses but the dynamic nature could still cause
temporarily to large buffers.

Cc: stable@kernel.org
Fixes: 7ea7b4a14275 ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 05cddcf994f65..06548dae1039d 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -877,12 +877,12 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_meshif_vlan *vlan;
+	size_t change_offset;
 	u16 num_vlan = 0;
 	u16 vlan_entries = 0;
 	u16 total_entries = 0;
 	u16 tvlv_len;
 	u8 *tt_change_ptr;
-	int change_offset;
 
 	spin_lock_bh(&bat_priv->meshif_vlan_list_lock);
 	hlist_for_each_entry(vlan, &bat_priv->meshif_vlan_list, list) {
@@ -900,8 +900,10 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	if (*tt_len < 0)
 		*tt_len = batadv_tt_len(total_entries);
 
-	tvlv_len = *tt_len;
-	tvlv_len += change_offset;
+	if (check_add_overflow(*tt_len, change_offset, &tvlv_len)) {
+		tvlv_len = 0;
+		goto out;
+	}
 
 	*tt_data = kmalloc(tvlv_len, GFP_ATOMIC);
 	if (!*tt_data) {
-- 
2.47.3


