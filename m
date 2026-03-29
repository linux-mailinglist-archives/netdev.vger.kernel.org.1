Return-Path: <netdev+bounces-272879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLsnOEgMyWkHtwUAu9opvQ
	(envelope-from <netdev+bounces-272879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:26:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3725E351CC8
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DF8E304C7E1
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 11:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7C435C1AA;
	Sun, 29 Mar 2026 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e1KEBXTa"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38FC35B632
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774783422; cv=none; b=G90xmXbr/V/U/GTlWtHBZI7l7MnjBz2tK44HmCy3QRtE2XMAB7hjdWnrmhuh5cLsYhb/n+38IBveRGiLZCCn+0P1MfVNjyHRoJgcjzDJ4/cRXBE1YyEC+i4WACy2MbyC7lUkIRSQdyqGt4f8iX44bQHBfAqxMpac3ddaa2t/BiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774783422; c=relaxed/simple;
	bh=FKvTpO1SluKtjSMrTLWTBN3s/9HEwJe1ge0E6tvCeNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcM+hf95wuR77cmq7IhsG5sXylTk/6/6jaAVFGS121hOAMDoun7+sZl1u3pX2gQ+GYqh1WCQnGkjqOMupBHG29NuKGAr6k0MuyrZM8nmedxV8HtkUzT4NCjw/Dyus8FOpogZF7judnAImpiKUl8ePb62eiQD8QRzITKROoRxpqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e1KEBXTa; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774783419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cz51yi/FiPlzZs1MA69fyINR+7e40BLTFJSWXlWlNIo=;
	b=e1KEBXTajsVUm7rZ9TVIPSVJ72GiNPMrClmEJOv2GWWt4Km/nKIae5418LliSuJrOGCHa1
	ibnuKCuAMwU5gaj9XJ9Q35Yyv2ZXdsLDG1ZGtYi8VS/UHyA+tzmcF+ip0BVGjfIc22iuaw
	SG/6GRsg7l/JSWzK4HBL2OywfTw3siw=
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
Subject: [PATCH net-next v3 3/4] net: hsr: require valid EOT supervision TLV
Date: Sun, 29 Mar 2026 13:23:12 +0200
Message-ID: <20260329112313.17164-4-luka.gejak@linux.dev>
In-Reply-To: <20260329112313.17164-1-luka.gejak@linux.dev>
References: <20260329112313.17164-1-luka.gejak@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,vger.kernel.org,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-272879-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 3725E351CC8
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


