Return-Path: <netdev+bounces-276082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GdKCM4w1WmU2AcAu9opvQ
	(envelope-from <netdev+bounces-276082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:29:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0C73B1D96
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9D353011C74
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AE53C457A;
	Tue,  7 Apr 2026 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="caYmmjHy"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB38361DB1
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579147; cv=none; b=IHLWRxfdCGmkur8NYmWHPkEUac4KW2DxwFTOEIac71E34aabvr6FleiUKOrw/g6ahCfpFZofS+mJ4Yie/N8LaCnnJVPL+QDEi49yXYkyKWJMwdgUAokMJbUgTNZ0gUQWySAt0Ymc9Tp1MObHuer97uW5PAHiozw74bcAK32D3iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579147; c=relaxed/simple;
	bh=J4nuPbygasSv6WB+I3vBOzRCUh4K19UW4rHzOH2fxug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXAOwD/t/EBF0RKS6WTDTCjxa5yASOVbv5v7x7tm1DCXdHY7EKSUwECrs/6vBCCS2ptsdytcsaV5v5a7y91Qyfg2PRCbrbkc5Uijv0qQJMozUhffz8S6IqLHVMV4trbsi2VCCLTc/1WERyDWoA9mi9CWJKwZxDEv4N97ce84xHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=caYmmjHy; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775579143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CF5rT1sWcVnt7Ab2JwXioerPCXaF1CM+aWRkfBWwrC0=;
	b=caYmmjHy9keHgC1vDjaipAsgl5/oiMoT3thL9uEwcZ+SRZtR0jDDMbp0UBjcah25xNhHEN
	V1j4L1oKsCXb6O85vqZq3zIiKSSTXwyFc+DTd7D/JzO/L7HA9T/AnRGcU4vR47bUeecBvm
	EzJUdpED6uWpFtUo57HHp0QKSR4IwC4=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	fmaurer@redhat.com,
	horms@kernel.org,
	luka.gejak@linux.dev
Subject: [PATCH net-next v5 1/2] net: hsr: require valid EOT supervision TLV
Date: Tue,  7 Apr 2026 18:25:01 +0200
Message-ID: <20260407162502.19462-2-luka.gejak@linux.dev>
In-Reply-To: <20260407162502.19462-1-luka.gejak@linux.dev>
References: <20260407162502.19462-1-luka.gejak@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-276082-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE0C73B1D96
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
 net/hsr/hsr_forward.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 0aca859c88cb..eb89cc44eac0 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -82,35 +82,33 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 	    hsr_sup_tag->tlv.HSR_TLV_length != sizeof(struct hsr_sup_payload))
 		return false;
 
-	/* Get next tlv */
+	/* Get next TLV */
 	total_length += hsr_sup_tag->tlv.HSR_TLV_length;
-	if (!pskb_may_pull(skb, total_length))
+	if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
 		return false;
 	skb_pull(skb, total_length);
 	hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
 	skb_push(skb, total_length);
 
-	/* if this is a redbox supervision frame we need to verify
-	 * that more data is available
-	 */
+	/* If this is a RedBox supervision frame, verify additional data */
 	if (hsr_sup_tlv->HSR_TLV_type == PRP_TLV_REDBOX_MAC) {
-		/* tlv length must be a length of a mac address */
+		/* TLV length must be the size of a MAC address */
 		if (hsr_sup_tlv->HSR_TLV_length != sizeof(struct hsr_sup_payload))
 			return false;
 
-		/* make sure another tlv follows */
+		/* Make sure another TLV follows */
 		total_length += sizeof(struct hsr_sup_tlv) + hsr_sup_tlv->HSR_TLV_length;
-		if (!pskb_may_pull(skb, total_length))
+		if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
 			return false;
 
-		/* get next tlv */
+		/* Get next TLV */
 		skb_pull(skb, total_length);
 		hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
 		skb_push(skb, total_length);
 	}
 
-	/* end of tlvs must follow at the end */
-	if (hsr_sup_tlv->HSR_TLV_type == HSR_TLV_EOT &&
+	/* Supervision frame must end with EOT TLV */
+	if (hsr_sup_tlv->HSR_TLV_type != HSR_TLV_EOT ||
 	    hsr_sup_tlv->HSR_TLV_length != 0)
 		return false;
 
-- 
2.53.0


