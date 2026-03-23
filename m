Return-Path: <netdev+bounces-270401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CSnDh33wGkwPAQAu9opvQ
	(envelope-from <netdev+bounces-270401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:17:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2A62EE314
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BAC830D408A
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C277372ECE;
	Mon, 23 Mar 2026 08:08:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886A2370D47;
	Mon, 23 Mar 2026 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253339; cv=none; b=JUZ4XMXiTnFpSVTzjXTxiknrOSjIG3XHYpsBPfVLP5tbsWH6qOrKxSBmpwhWzwZ9GK/nAyJHdf9MI84yCZTZvo+HxCXVMtqUFg9bXPpBgHNlOJp90yoRi7Vk1TWiwVyE1E6aSIMxIh6Sjre1gYTBr3fo7qgQmecRRpoADaIP0PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253339; c=relaxed/simple;
	bh=J5pALpBg2dh7ONIB4aTvF9E3cdXjk9ivru91yK9RYzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XxEgccRFboXAXaB5OrtaY/8cq0mk1wtU2LGC9AARQCvYMBbQf/jUvNvhIdTiuXBPzsQkamVfrOHlmzJ5R7lwdeCDY1RRyGlxDgtz4mw0eCW+n/tr+wN0AEhnO/jMQMcgq8MHGNOb6RQjRxQgqpJdJDL7p3QE+OXYM82Qzh/DyJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-03 (Coremail) with SMTP id rQCowAB3ldwN9cBpPEeHCw--.12178S2;
	Mon, 23 Mar 2026 16:08:46 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2] bnxt_en: validate firmware backing store types
Date: Mon, 23 Mar 2026 16:08:45 +0800
Message-ID: <20260323080845.40044-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3ldwN9cBpPEeHCw--.12178S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trW8Kw45Xr47Kr4DKFW3Jrb_yoW8ArW5pF
	Z8JFy3Ww18GF13tayftF48ZFn8uw4xt348Gry7CwnYvF1YvFyUXr9akF90qryDZF48Crya
	qF45ZFW5AFWDWwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU0GYpUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270401-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 8F2A62EE314
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bnxt_hwrm_func_backing_store_qcaps_v2() trusts resp->type from the
firmware response and stores it in ctxm->type. That value is later used
to index fixed backing-store metadata arrays such as ctx_arr[] and
bnxt_bstore_to_trace[] without a local range check.

Validate the returned type before storing it and abort the query when
firmware reports a type outside BNXT_CTX_V2_MAX. This keeps the fix at
the point where the untrusted value enters driver state.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
v2:
- add commit message context and fix rationale
- no code changes

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0751c0e4581a..d0446f851d66 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8692,6 +8692,7 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 		u8 init_val, init_off, i;
 		u32 max_entries;
 		u16 entry_size;
+		u16 resp_type;
 		__le32 *p;
 		u32 flags;
 
@@ -8715,7 +8716,15 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 			else
 				continue;
 		}
-		ctxm->type = le16_to_cpu(resp->type);
+		resp_type = le16_to_cpu(resp->type);
+		if (resp_type >= BNXT_CTX_V2_MAX) {
+			netdev_warn(bp->dev,
+				    "invalid backing store type %u returned by firmware\n",
+				    resp_type);
+			rc = -EINVAL;
+			goto ctx_done;
+		}
+		ctxm->type = resp_type;
 		ctxm->entry_size = entry_size;
 		ctxm->flags = flags;
 		ctxm->instance_bmap = le32_to_cpu(resp->instance_bit_map);
-- 
2.50.1 (Apple Git-155)


