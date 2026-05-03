Return-Path: <netdev+bounces-283601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD1mFQU/92k2dwIAu9opvQ
	(envelope-from <netdev+bounces-283601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 14:26:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A39774B5BB8
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 14:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F5B0301693B
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 12:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913203B19CC;
	Sun,  3 May 2026 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="xr/hJnZN"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354803B19C0;
	Sun,  3 May 2026 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777811012; cv=none; b=RfUPTmQVBYeqLlpxT9YHmypivjMF6yLDaCoGfC0rQOvhPrQe19BViG7wrML8PXGHY39t7wgM2ZvtM58S6jGXW6D9w+kMlNHWa6OctHQNPJzCPbD8R01RQO34xwzVfT8hzWoIul0Ez1HstMfNC3mu84zvvis2ZA5iJ8At4TW8+8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777811012; c=relaxed/simple;
	bh=l+L76yAQhUzV6/M374uvOPJNw5UvXliEJ0luu1nNMwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QYygbhUyiHDAvqX6BplJYtdxky3ZyiMIw+RByMUwTx28AABd8Jw8fW90UiGpvLYlc7FEACFGwa9anF9auzdjnaLdDVVOjr/k/5gJ8W6spzQo9H1EoXzkoQ64nw+9iZsozjUf69VHKO+Nd+nW9AdEoLfBsy7GLycnwQiS8onbC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=xr/hJnZN; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 406FE20D39;
	Sun, 03 May 2026 12:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777811009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSyX5MT+xkx/hCaIOWcjkKX9ZFfOmihuKJssQ1j3tks=;
	b=xr/hJnZNQ2+6FAuEXL7UOsZ/deQGwk4U4YyaCSkuAJlHGL7c0GgnlSsOq+bOpTluzW7x+r
	qXQeKodZiHUjPae7uIUENdfVUcqatilXfKElSyDryUFuuO6+Ll2Ufhq0TioefrEw8ojJmI
	YQwaHNXVfw9aOA17KqWj2665uzLCQxA=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 May 2026 14:22:38 +0200
Subject: [PATCH batadv 5/8] batman-adv: tt: reject oversized local TVLV
 buffers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-fixes-followup-v1-5-4313278918d3@narfation.org>
References: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
In-Reply-To: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>, 
 Simon Wunderlich <sw@simonwunderlich.de>, 
 Antonio Quartulli <antonio@mandelbit.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ao Zhou <n05ec@lzu.edu.cn>, 
 Haoze Xie <royenheart@gmail.com>, Jiexun Wang <wangjiexun2025@gmail.com>, 
 Juefei Pu <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>, 
 Ren Wei <n05ec@lzu.edu.cn>, Ruide Cao <caoruide123@gmail.com>, 
 Xin Liu <bird@lzu.edu.cn>, Yifan Wu <yifanwucs@gmail.com>, 
 Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>, 
 stable@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1820; i=sven@narfation.org;
 h=from:subject:message-id; bh=l+L76yAQhUzV6/M374uvOPJNw5UvXliEJ0luu1nNMwU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJnf7WQzwh+sjpy778ST2Yvfx/+fPulkK0t0+5EYxSWnX
 okEvQu61FHKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYiPR9hn+2vWvEuLavexey
 wFRu7uZr0tprzJad2iTzQvm5dS5n5lYPhv+ub0Ki6yzENn0KK/rVJ/9b17ooVLNCTPH6gRb9hkk
 JSmwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
X-Rspamd-Queue-Id: A39774B5BB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283601-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.open-mesh.org,vger.kernel.org,lzu.edu.cn,gmail.com,narfation.org,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[narfation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,narfation.org:email,narfation.org:dkim,narfation.org:mid]

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
---
 net/batman-adv/translation-table.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 05cddcf994f6..06548dae1039 100644
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


