Return-Path: <netdev+bounces-272125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP1oGVRYxWkk9gQAu9opvQ
	(envelope-from <netdev+bounces-272125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:01:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1EF33805F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6A7731718B2
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC87408252;
	Thu, 26 Mar 2026 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tZxqKLlp"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E87407100
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540069; cv=none; b=KDiLuumsMPXPlS01+6bbOohcuL1fDsSUcRfYcfbkjRokUrjkP+f5Cj4Ns7BAmgSVhZMTyVahgQWkSg2MJcvTh4fVCCZUiYbDyn2mhAjo4jcS0Q/OfxTXRoa2WPEq3onLK8wwAqF5FNeR45nZm1U5zFTTVs0o2tdmJsdz26s+oYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540069; c=relaxed/simple;
	bh=FKvTpO1SluKtjSMrTLWTBN3s/9HEwJe1ge0E6tvCeNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vj++LipIaHzF7DW+85G844JxJ2df60RbgdXELTnjROhN6D09xP+OEH7ve4l4RT5VFaam1mx3xAtNYuwyx5MZQhTadyuxwNTtrBWFiGcMnhwiGQrBx9ifiKZYgudsNDSnb4Qye6RhgJflYeyuOL3JquGOviQEvYjvWbNv0TB7A8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tZxqKLlp; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774540066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cz51yi/FiPlzZs1MA69fyINR+7e40BLTFJSWXlWlNIo=;
	b=tZxqKLlpnMFMiGkyy7wCjYYty2duF5RxJ6PSbgKH6vcqidPWgIvQrr/1dbE0E8lobYa/NA
	pXz4A5xThe6frR2BJT1g2Jozc4UATgyW4ogaSpj5QJi/WC7ZeJb11r4B2cEw66+s8NVGlg
	H16JTVtcNiPy5aOTSn8D38Btp0ZqWPo=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	linux-kernel@vger.kernel.org,
	luka.gejak@linux.dev
Subject: [PATCH net-next v2 3/4] net: hsr: require valid EOT supervision TLV
Date: Thu, 26 Mar 2026 16:47:14 +0100
Message-ID: <20260326154715.38405-4-luka.gejak@linux.dev>
In-Reply-To: <20260326154715.38405-1-luka.gejak@linux.dev>
References: <20260326154715.38405-1-luka.gejak@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,vger.kernel.org,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-272125-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC1EF33805F
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
 net/hsr/hsr_forward.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index aefc9b6936ba..d26c7d0e8109 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -110,7 +110,7 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 	}
 
 	/* end of tlvs must follow at the end */
-	if (hsr_sup_tlv->HSR_TLV_type == HSR_TLV_EOT &&
+	if (hsr_sup_tlv->HSR_TLV_type != HSR_TLV_EOT ||
 	    hsr_sup_tlv->HSR_TLV_length != 0)
 		return false;
 
-- 
2.53.0


