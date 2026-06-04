Return-Path: <netdev+bounces-295354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yreODkKsIWoWLAEAu9opvQ
	(envelope-from <netdev+bounces-295354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:48:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDC4642064
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:48:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=NXFlboor;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295354-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295354-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F23C315D9E3
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AABC3932E9;
	Thu,  4 Jun 2026 16:37:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15F934DB46
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 16:37:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591069; cv=none; b=ptL3OnpLnzOO6y5S/ZaNyX0dmgUfFO8Znt6cSwY5W3bF4B3OQVDywVtM/fb72TzhqbqBsdk3O2jUileiTwE5Hsas14zRQZSqgcAWwklciLmKRwyXSL2+gVZlnhHZQWDEVWxYHTrPTmnkbFgCxU2yasAP3n9ampIwQOkvo0IDV/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591069; c=relaxed/simple;
	bh=0Y0Sjy44RdkBzYSdAeUlWQZAogOV193vCQin/KVtbQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3kSiR+klcxuQnYv3KK3DDkeZXmfug/m3yoSUILLPxGBG9dJrGMnbl0dg1z2mGiYD98Ftom6ePzomQ3IgSJth73gKLEHl+AJ/PQ5U9nYS7AspILaRxNGCDZsGO/LtXyckacsp+8/hAr3elQs/ol9+BY/S8XCxotwprwBESMvtbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NXFlboor; arc=none smtp.client-ip=74.125.224.97
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-6605c3453f2so1134368d50.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 09:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780591067; x=1781195867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dA1YjKYHZBhklMysioMr6OFl2p5kCNCILPwzpCesPi8=;
        b=ojcEAoDScWN5yMBX5rwsSQhflxFWPeOXiJvikX8oLs0Z9rifCxF6zF4GmPWD+zSX5q
         xKqjXI2JS9muAzmLsa4CgKt3fu0Pf6jJX7+aAADvsboGY1t1okuAxHO+30Ztzh15ao7D
         vrmltqJNMzwX9jDTl4zsOqdQoPVVevL2IvISF5w4UFYgW/hUGtqQDnlp1O6Dxz3G57Hx
         +1PWjTSuRC0Fqpo6krIwqgxiZnHJegslegzkhLhfc3HEQqABT5oC/amXjOxDsRKFrNEF
         wt4zptzepUKDK0QcwI9L7W9RfIaJ0uo4ht/dkbZ8GRFsdqiJsNzqaaSX6xfqe3Et8fJA
         2uTQ==
X-Gm-Message-State: AOJu0YypcWR9L5hWGoj5EMccDf42oAKfor/LDv7xp7yIgTI0OCq4jxgh
	otudjQ6F6l58boqzNgqwxEB9H+DTIY1z74iEZCQ8dVEj7OlBnTkwj2Vwhd8/b8SkXqlfhzCXsiI
	KsUQif6E50Zq1i2oczUdcFwshKNFThbwLxP7L+Wr8gVxBTaqSnbMyBpajnx5IxgBlFZ4KDmkDed
	+G4TrBXw41fY6K/0T2Thi4b/M5JrizbpH1gXNfQlL8iO/I35rWSQZ2IypJfxp+dSH6GsnzztXpq
	4hbsnz5fZGS
X-Gm-Gg: Acq92OGW500meNBzmM+X8qNCWgOadtBOidYewAybPb5Hc2ZZx+GMV+sZN/2vkZK+IIB
	oiVZaWpFEvhUbWX+afdhBFDLUTrRBoK15HNX07gB+yKcuic3kvRJLpKg/C9xHxs0LOesgpfRmSh
	Clmmfw89FcMtPl7z3ejJeSRe56io+wQjoL2WcFBeicoVv6cRWhN/njVClRKOOj5aFwBorpVwU+i
	e5VhAbWCfSdR8r4Ws145ZreGTBMlTcIQj4pM5z2itziWjRk6+cY6C85KPkZJKLva+xn+fntEK7P
	xwq3juqcjLDPuBx+/HhPlCf3QVS6mCty6qLnqfCnL/y2rBGwCZfzh27o7zKG4uMj26g8N69MZkI
	8NpxI91GZSd0opW6ij8oLAxFNrOCf3zhx+ISGCxUb8B+Rz/aU/mWH/aLEKEyLu0CFdFofcGz2f/
	vYmw0CBgVjdue8Km55ku/O7DVWUJficnbwqNlC5f8n/dHQZK+YZzLrVyar8cRI5zOLZ/jo
X-Received: by 2002:a53:d006:0:b0:660:8253:b84d with SMTP id 956f58d0204a3-660dc2a6eb4mr7774081d50.31.1780591066611;
        Thu, 04 Jun 2026 09:37:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-660d61ea17fsm521040d50.15.2026.06.04.09.37.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2026 09:37:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0c36f4b76so9940545ad.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 09:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1780591065; x=1781195865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dA1YjKYHZBhklMysioMr6OFl2p5kCNCILPwzpCesPi8=;
        b=NXFlboorQJmHlG/5Nvo5AXFclF3OghgXlKHr42GmNVQi++XBUtz6aSpGLfpNDKoIla
         6WkVCajspctAJmrdClDazsoBI0CHIdczoosaBcFFkjemaBmCnk70bpmIbE+VvDGOzONj
         uPhmQaOx+VdmVNALAqMkXV5HJ1LSyFaT4KbW0=
X-Received: by 2002:a17:902:c602:b0:2c0:a555:80d6 with SMTP id d9443c01a7336-2c163a14eb7mr56838815ad.2.1780591065303;
        Thu, 04 Jun 2026 09:37:45 -0700 (PDT)
X-Received: by 2002:a17:902:c602:b0:2c0:a555:80d6 with SMTP id d9443c01a7336-2c163a14eb7mr56838585ad.2.1780591064803;
        Thu, 04 Jun 2026 09:37:44 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629c08bsm64746735ad.61.2026.06.04.09.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 09:37:44 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vsrama-krishna.nemani@broadcom.com,
	bhargava.marreddy@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	dharmender.garg@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net] bnge: fix context mem iteration
Date: Thu,  4 Jun 2026 22:07:09 +0530
Message-ID: <20260604163709.497649-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-295354-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vsrama-krishna.nemani@broadcom.com,m:bhargava.marreddy@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:ajit.khaparde@broadcom.com,m:dharmender.garg@broadcom.com,m:rahul-rg.gupta@broadcom.com,m:vikas.gupta@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFDC4642064

The firmware advertises context memory (backing store) types
through a linked list, with BNGE_CTX_INV serving as the
end-of-list sentinel.
However, the driver incorrectly assumes that the list is strictly
ordered and prematurely terminates traversal when it encounters
an unrecognized type (>=BNGE_CTX_V2_MAX). As a result, any valid
context types that appear later in the chain are silently skipped,
leading to incomplete memory configuration and eventual driver load
failure.

Fix this by traversing the entire list until the BNGE_CTX_INV sentinel
is reached, while safely ignoring only those context types that fall
outside the supported range.

Fixes: 29c5b358f385 ("bng_en: Add backing store support")
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index eb11800f5573..1c9cfec1b633 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -277,7 +277,7 @@ int bnge_hwrm_func_backing_store_qcaps(struct bnge_dev *bd)
 	struct hwrm_func_backing_store_qcaps_v2_output *resp;
 	struct hwrm_func_backing_store_qcaps_v2_input *req;
 	struct bnge_ctx_mem_info *ctx;
-	u16 type;
+	u16 type, next_type;
 	int rc;
 
 	if (bd->ctx)
@@ -294,8 +294,8 @@ int bnge_hwrm_func_backing_store_qcaps(struct bnge_dev *bd)
 
 	resp = bnge_hwrm_req_hold(bd, req);
 
-	for (type = 0; type < BNGE_CTX_V2_MAX; ) {
-		struct bnge_ctx_mem_type *ctxm = &ctx->ctx_arr[type];
+	for (type = 0; type < BNGE_CTX_INV; type = next_type) {
+		struct bnge_ctx_mem_type *ctxm;
 		u8 init_val, init_off, i;
 		__le32 *p;
 		u32 flags;
@@ -304,8 +304,14 @@ int bnge_hwrm_func_backing_store_qcaps(struct bnge_dev *bd)
 		rc = bnge_hwrm_req_send(bd, req);
 		if (rc)
 			goto ctx_done;
+
+		next_type = le16_to_cpu(resp->next_valid_type);
+		if (type >= BNGE_CTX_V2_MAX)
+			continue;
+
+		ctxm = &ctx->ctx_arr[type];
 		flags = le32_to_cpu(resp->flags);
-		type = le16_to_cpu(resp->next_valid_type);
+
 		if (!(flags &
 		      FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_TYPE_VALID))
 			continue;
-- 
2.47.1


