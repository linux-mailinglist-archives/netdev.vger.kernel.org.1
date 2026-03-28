Return-Path: <netdev+bounces-272842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1hJREtdnyGmVlgUAu9opvQ
	(envelope-from <netdev+bounces-272842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 00:44:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C30CC3503E9
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 00:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57A5E30214C0
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 23:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2133101A2;
	Sat, 28 Mar 2026 23:44:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0E239FCE;
	Sat, 28 Mar 2026 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774741458; cv=none; b=NKx0N09m5pyHmJeqchcxs0+ud1KhKSqb/jlLTAYhEs2s4hW1Ksj6iZNAN7BwPInKFuJwVWG2njVG4DW5mIaDBsC0kdSrdQV60EhPkE3y3XMLhBmcxy5YJKvGmwMUp+1X53lpUntrVoz4flOlL2V0ngdii5PrL9E/LVpjW5VAALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774741458; c=relaxed/simple;
	bh=xanrtzOK7hSi1y9nKT64FJ1g8LcHf+6qSWcYYDOFwXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YPtcVWkkBtbu1IUKRUoqn0rj+PCAbdy7Mevvp6hjV6Z0fddUfjNEI0+WBbBFMIrpLrsMg8UWd5ORFoDLoalWgSOW6EujNIGLUHiz9S4pTm5dy0ryztRzRU+7sPuAxE5vdjY/DOmIbOPvSNTRtvTI2zYg/Yi2zhdZdjhS3FJbYLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowAB3G2e9Z8hpwJN6Cw--.22203S2;
	Sun, 29 Mar 2026 07:43:57 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: michael.chan@broadcom.com
Cc: pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH net v7] bnxt_en: set backing store type from query type
Date: Sun, 29 Mar 2026 07:43:56 +0800
Message-ID: <20260328234357.43669-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3G2e9Z8hpwJN6Cw--.22203S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4kCr13Zw4DWw1xAr1UWrg_yoW5XrW5pF
	45WFyaqa18GF4SqayYya18urn8Ww4rt348t345ua1FvF1FvF1jvry0kFyavrn8ZrWxCrya
	qw47Aw15J398WwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272842-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C30CC3503E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bnxt_hwrm_func_backing_store_qcaps_v2() stores resp->type from the
firmware response in ctxm->type and later uses that value to index
fixed backing-store metadata arrays such as ctx_arr[] and
bnxt_bstore_to_trace[].

ctxm->type is fixed by the current backing-store query type and matches
the array index of ctx->ctx_arr. Set ctxm->type from the current loop
variable instead of depending on resp->type.

Also update the loop to advance type from next_valid_type in the for
statement, which keeps the control flow simpler for non-valid and
unchanged entries.

Fixes: 6a4d0774f02d ("bnxt_en: Add support for new backing store query firmware API")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
v7:
- rename the patch to match the new fix
- advance type from next_valid_type in the for loop statement

Link: https://lore.kernel.org/r/20260328060824.8383-1-pengpeng@iscas.ac.cn

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0751c0e4581a..7ed805713fbb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8671,7 +8671,7 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 	struct hwrm_func_backing_store_qcaps_v2_output *resp;
 	struct hwrm_func_backing_store_qcaps_v2_input *req;
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
-	u16 type;
+	u16 type, next_type = 0;
 	int rc;
 
 	rc = hwrm_req_init(bp, req, HWRM_FUNC_BACKING_STORE_QCAPS_V2);
@@ -8687,7 +8687,7 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 
 	resp = hwrm_req_hold(bp, req);
 
-	for (type = 0; type < BNXT_CTX_V2_MAX; ) {
+	for (type = 0; type < BNXT_CTX_V2_MAX; type = next_type) {
 		struct bnxt_ctx_mem_type *ctxm = &ctx->ctx_arr[type];
 		u8 init_val, init_off, i;
 		u32 max_entries;
@@ -8700,7 +8700,7 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 		if (rc)
 			goto ctx_done;
 		flags = le32_to_cpu(resp->flags);
-		type = le16_to_cpu(resp->next_valid_type);
+		next_type = le16_to_cpu(resp->next_valid_type);
 		if (!(flags & BNXT_CTX_MEM_TYPE_VALID)) {
 			bnxt_free_one_ctx_mem(bp, ctxm, true);
 			continue;
@@ -8715,7 +8715,7 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 			else
 				continue;
 		}
-		ctxm->type = le16_to_cpu(resp->type);
+		ctxm->type = type;
 		ctxm->entry_size = entry_size;
 		ctxm->flags = flags;
 		ctxm->instance_bmap = le32_to_cpu(resp->instance_bit_map);
-- 
2.50.1 (Apple Git-155)


