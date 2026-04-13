Return-Path: <netdev+bounces-278030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPjoMwHI3GmcWQkAu9opvQ
	(envelope-from <netdev+bounces-278030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:40:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F183EABC1
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72AE3303EC12
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254073370FF;
	Mon, 13 Apr 2026 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W/hFENTL"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844301A08A3
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776076525; cv=none; b=Rjf+xZ2dgt8dJ6WQ2V6ZYDEIyrI04K2fq0Kr4fTLeb7l+fkAlfWbABB9Nbr6GTZvTBUNIuJpYR50R3QRj1zFRkyTrRj3DyE2JCWbnTZYsFZExPQTN2hwPBUwuFw/7/QJ9L6ujKd46ixn8Kmh4mxbmOcHphmtYC9GH34neYQmQzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776076525; c=relaxed/simple;
	bh=wpjN+RGXgqlQnmx04rMsajg2yRYQms5G25hV8udFr7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqwMmWeCbDJVfT+eMIt2rsA7dt6ZCNoaSJM77gJ1capgIpcIStYe8GFVHNwWAu30aVKtHIw2QIg5c88rEaBUHa9Mp/xMP0p+eMdYHe7IOPMWjbW6nneJNAwg8Jgffpa2GNbOYL6WxziXLuWD5eIckPC+LAIF8s45lhsEDrAqqY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W/hFENTL; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776076521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TlNyc17gw2Ti7/hBMrFLpptKaPycSsdcm8axofbmVWA=;
	b=W/hFENTLT9d2g0It2bekA0mUQ+e9Yj+jEnMfyMioMF772M7OL/M4RnaSev8X9D6ufrBudJ
	446Bv4pAvi0SR1wggLD3xbxobMWU+DnVJNbvzGK4h5QkkWYLIjIcuF/3loR86YKO7vO/rV
	6Bcf5146y5G8i7Y1BEIvPBs1pFptQhk=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	fmaurer@redhat.com,
	horms@kernel.org,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH net-next v6 1/2] net: hsr: require valid EOT supervision TLV
Date: Mon, 13 Apr 2026 12:34:48 +0200
Message-ID: <20260413103449.169913-2-luka.gejak@linux.dev>
In-Reply-To: <20260413103449.169913-1-luka.gejak@linux.dev>
References: <20260413103449.169913-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278030-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38F183EABC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

Supervision frames are only valid if terminated with a zero-length EOT
TLV. The current check fails to reject non-EOT entries as the terminal
TLV, potentially allowing malformed supervision traffic.

Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
with a length of zero, and properly linearizing the TLV header before
access.

Assisted-by: Gemini:Gemini-3.1-flash
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 net/hsr/hsr_forward.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 0aca859c88cb..0774981a65c1 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -84,7 +84,7 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 
 	/* Get next tlv */
 	total_length += hsr_sup_tag->tlv.HSR_TLV_length;
-	if (!pskb_may_pull(skb, total_length))
+	if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
 		return false;
 	skb_pull(skb, total_length);
 	hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
@@ -100,7 +100,7 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 
 		/* make sure another tlv follows */
 		total_length += sizeof(struct hsr_sup_tlv) + hsr_sup_tlv->HSR_TLV_length;
-		if (!pskb_may_pull(skb, total_length))
+		if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
 			return false;
 
 		/* get next tlv */
@@ -110,7 +110,7 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 	}
 
 	/* end of tlvs must follow at the end */
-	if (hsr_sup_tlv->HSR_TLV_type == HSR_TLV_EOT &&
+	if (hsr_sup_tlv->HSR_TLV_type != HSR_TLV_EOT ||
 	    hsr_sup_tlv->HSR_TLV_length != 0)
 		return false;
 
-- 
2.53.0


