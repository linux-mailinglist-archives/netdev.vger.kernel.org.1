Return-Path: <netdev+bounces-274007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCZfD3TmzGk/XwYAu9opvQ
	(envelope-from <netdev+bounces-274007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:33:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34702377B64
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0944730A8065
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 09:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6181A3BBA1D;
	Wed,  1 Apr 2026 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o/oAUJHv"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2453C552E
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035433; cv=none; b=i/+bGyGyigETCmWSxSFfqB8zy4K7nRQWmvih7X9vMT5OVES41zoVjiQ8SdN4AXZwhIQ1VJH3NWCI0Cors+v86cTLaf7k0dhGv4U1i/UxbnRqdJpsUEfPTOdzCCVd0a/lX6z0pSNuImF+9bWdM3/aVWUk0kpXHV5FEZKl0fifkCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035433; c=relaxed/simple;
	bh=wB0tlSP1g25psjkB+6qOGjoE8/RZIQ4gfMP6q2Hry4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/ruEtwkRsKB9k0aYoyg2RlKo253Tg/mIFq8rkp2NZPrN6qBedH6ZNOhgJE4CAoUQ/zUrZ9df5nqha9SOKFbHPcypwHdvqEkrQJlC4WIUTPwpNjM4viHHHOjdMW9JjDGPK2TZ8FjlIZDVdr0bkqazVydEJrBoas7I/rbK0en3dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o/oAUJHv; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775035430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ap/43yYvF16nuIALSD4y46s6U/GmWmaJOmQaXDsh68w=;
	b=o/oAUJHvZUFj76liEp9ptnnRTo0f5hCb1XpndYXuxGFQ1JPGfcfDg+YUlkk5Jb8vmU6uk6
	mcMMCdicYQGrb7ltcldTwCO6PTqk0pyvS4AKGRXGoqInR73C2JNKtlKM9RySApTVWhD76K
	LVN8cWQcVLKJsbXm18T4SHmpbHi6nho=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	fmaurer@redhat.com,
	horms@kernel.org,
	luka.gejak@linux.dev
Subject: [PATCH net-next v4 1/2] net: hsr: require valid EOT supervision TLV
Date: Wed,  1 Apr 2026 11:23:22 +0200
Message-ID: <20260401092324.52266-2-luka.gejak@linux.dev>
In-Reply-To: <20260401092324.52266-1-luka.gejak@linux.dev>
References: <20260401092324.52266-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-274007-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34702377B64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

Supervision frames are only valid if terminated with a zero-length EOT
TLV. The current check fails to reject non-EOT entries as the terminal
TLV, potentially allowing malformed supervision traffic.

Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
with a length of zero.

Reviewed-by: Felix Maurer <fmaurer@redhat.com>
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 net/hsr/hsr_forward.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 0aca859c88cb..17b705235c4a 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -82,39 +82,42 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 	    hsr_sup_tag->tlv.HSR_TLV_length != sizeof(struct hsr_sup_payload))
 		return false;
 
-	/* Get next tlv */
+	/* Advance past the first TLV payload to reach next TLV header */
 	total_length += hsr_sup_tag->tlv.HSR_TLV_length;
-	if (!pskb_may_pull(skb, total_length))
+	/* Linearize next TLV header before access */
+	if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
 		return false;
 	skb_pull(skb, total_length);
 	hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
 	skb_push(skb, total_length);
 
-	/* if this is a redbox supervision frame we need to verify
-	 * that more data is available
+	/* Walk through TLVs to find end-of-TLV marker, skipping any unknown
+	 * extension TLVs to maintain forward compatibility.
 	 */
-	if (hsr_sup_tlv->HSR_TLV_type == PRP_TLV_REDBOX_MAC) {
-		/* tlv length must be a length of a mac address */
-		if (hsr_sup_tlv->HSR_TLV_length != sizeof(struct hsr_sup_payload))
-			return false;
+	for (;;) {
+		if (hsr_sup_tlv->HSR_TLV_type == HSR_TLV_EOT &&
+		    hsr_sup_tlv->HSR_TLV_length == 0)
+			return true;
 
-		/* make sure another tlv follows */
-		total_length += sizeof(struct hsr_sup_tlv) + hsr_sup_tlv->HSR_TLV_length;
-		if (!pskb_may_pull(skb, total_length))
+		/* Validate known TLV types */
+		if (hsr_sup_tlv->HSR_TLV_type == PRP_TLV_REDBOX_MAC) {
+			if (hsr_sup_tlv->HSR_TLV_length !=
+			    sizeof(struct hsr_sup_payload))
+				return false;
+		}
+
+		/* Advance past current TLV: header + payload */
+		total_length += sizeof(struct hsr_sup_tlv) +
+				hsr_sup_tlv->HSR_TLV_length;
+		/* Linearize next TLV header before access */
+		if (!pskb_may_pull(skb,
+				   total_length + sizeof(struct hsr_sup_tlv)))
 			return false;
 
-		/* get next tlv */
 		skb_pull(skb, total_length);
 		hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
 		skb_push(skb, total_length);
 	}
-
-	/* end of tlvs must follow at the end */
-	if (hsr_sup_tlv->HSR_TLV_type == HSR_TLV_EOT &&
-	    hsr_sup_tlv->HSR_TLV_length != 0)
-		return false;
-
-	return true;
 }
 
 static bool is_proxy_supervision_frame(struct hsr_priv *hsr,
-- 
2.53.0


