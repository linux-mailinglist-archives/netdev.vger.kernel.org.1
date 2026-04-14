Return-Path: <netdev+bounces-278540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OTJEe9p3ml6EAAAu9opvQ
	(envelope-from <netdev+bounces-278540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:23:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C73C53FC819
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9CA130AF1D0
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFD23ED5A3;
	Tue, 14 Apr 2026 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VNKHyQ15"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA2C3ED119
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183527; cv=none; b=WFSp/h5hdaunBtXVyEaa5BDIbhEH2pCtnP9/2syNrlc+adS4IqKXMjh/b4a4jLReltVWid2BqLQ7XzfvL8+o2yEmad77RMJ7xFTKaOw+c/kgZfUcjsxmVo8Cgaz2wjhPS2NX3SvZPBmTcgJFyH3glqIUPHpQpui4q72RdhFC7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183527; c=relaxed/simple;
	bh=GCgDDpu2B53/qUhZyvshhcXz2298Bd+Oje9z+1iRt9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EY85xutdhWX5giAIKKDCAk/thtvwIFwb6tSfG+k7up5T2IgKHYlJrCsZw8gRFDlF8peCcMBtzoOT/qnvzcSoxOb79kDsAvCcYfr0Zq5LHW/eV4U5kPL8tNpY4lMaDpuug+dRwZ8/PhtJ1HBtDmpYS0yJ+fGgHQJBDHr6QiMCJjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VNKHyQ15; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2b458ca2296so18098545ad.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776183525; x=1776788325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3zw7X0VqXssjVHJZjNzeBf7bZ6UNYJogP4btvXmnLlo=;
        b=IvXQknLqs++8W1zPFPau/JcTDzjapR6/f2Kxn5D9dEZVEs4yYUd4jHyV0dAXQzo8fp
         jbnJDIu+2CDDPZvu1zVEhaLm+CnnzxDUtjB3CXoGZ4tw8txueIphMDl5DGIO994kQ6oK
         CDNPYsQjf1jazKwAKVvrc+mkxxAs3bsZDjaMJVcNjHsMDzT3kkVQOPX/JHodGnkp7SbN
         2BWMbFIsa4ESBdon8v2hlyW7uUj+xX8Gd1E9VGGcuemYOkVcXOknyabHGS7yFViBF/GY
         XQdaUaNtPSWLqp/dAdVeLXEAuZ2uXypRQ3x0L959Fc5N3bIfE4z7JCZidE6soCems1RI
         CjzA==
X-Gm-Message-State: AOJu0YzfibCLFYCkWI3SprB8u6sCDg8q2Z9b7N0bRbsaqmOULHyoMHFh
	zEhAuyT2ZRd4etfhMno1izl/H8QFHOFOBwJvfL6XaavLr2duy5w7692iffKUTnJyZpmhIkfvJgz
	Jcxsbqxf2E6ldme4H96VkZ+aoTkdTmlmMzwTOe29+SwJbKPTJdR0UnOxjZ001dhcpCv1TwZxRJK
	qezuopc8kN8p5I0ceO9J1gWqN9ymL93wkzHSn9z7XyRz/vgofo2twK4e+3WQ8GZTcn349o25HuP
	JsHH/EyQA==
X-Gm-Gg: AeBDiessouUeCJA29LulW6wvTy8os6bIrsiY7hjYfNhdyJKlFgF6fD08PL2f20PnpED
	V+1/OD2H8eVmo6HDnGF8Rg/3WwPid3YDvRqXjwSNixr2oSQvdLg+zHBTfyG8NQ7pV6Lk1qZYTYp
	g5vQWfFTZtd/WVWFYHz4vpfSnjN09ycgfpUSac0DN9D9UffCRonLyVvna61LKm+e+bn1ZGGqWCx
	TLs5MQ6dfUTn1e+unPHhoz6BhjMdBbRNXB2myBwTYtbK74wQxNEHLxOzJlPKwALmoMuDFvSSnC2
	3EZCG9irUKPr9UOcTUCKRHNJ8r/IWEwXSzYTQpxCD01rHC/efdE5qhNEHHwIgLQd6pwQKS+U0KI
	u5UzC/cRNCTNGw39J8zoIsn0CAShYwhtg8sgBNgTwdWUM+3E/qw6DnkuI1wdDSSeVt3jrV1WW1F
	RC2HPn70VesYOHOx2moM1QqzmLAEurFA7sPo8lGwB4H4KHBIOifKbAzWU=
X-Received: by 2002:a17:903:98c:b0:2b4:5b1a:d09c with SMTP id d9443c01a7336-2b45b1ad1ddmr97768705ad.15.1776183525141;
        Tue, 14 Apr 2026 09:18:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b2eaeccbdfsm7303535ad.36.2026.04.14.09.18.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2026 09:18:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c7424d91b2dso3039798a12.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776183523; x=1776788323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zw7X0VqXssjVHJZjNzeBf7bZ6UNYJogP4btvXmnLlo=;
        b=VNKHyQ15TGxGCLegdxdXnuMT5r12wPOxnla5f/2VgLqBJEcgeGot8j+G8BTH5Qdrmq
         Q6XTEKebPNYY8g1RiOkdZ99bzsjAlI2Z+5fYKvdM6X0650aaFX7LprrxbR7OwgZ0gpkw
         FgzPHVXrKLO2E1QNZ5uJOw7l/7uQ7hCTDItAM=
X-Received: by 2002:a05:6a20:12ce:b0:398:c0ba:9cfd with SMTP id adf61e73a8af0-39fe3c2d400mr19264368637.1.1776183523208;
        Tue, 14 Apr 2026 09:18:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:12ce:b0:398:c0ba:9cfd with SMTP id adf61e73a8af0-39fe3c2d400mr19264331637.1.1776183522630;
        Tue, 14 Apr 2026 09:18:42 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79219cbc21sm12042656a12.17.2026.04.14.09.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:18:41 -0700 (PDT)
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
Subject: [PATCH net 2/2] bnge: remove unsupported backing store type
Date: Tue, 14 Apr 2026 21:48:22 +0530
Message-ID: <20260414161822.742382-3-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260414161822.742382-1-vikas.gupta@broadcom.com>
References: <20260414161822.742382-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278540-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C73C53FC819
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The backing store type, BNGE_CTX_MRAV, is not applicable in Thor Ultra
devices. Remove it from the backing store configuration, as the firmware
will not populate entities in this backing store type, due to which the
driver load fails.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_rmem.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
index 94f15e08a88c..b066ee887a09 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
@@ -324,7 +324,6 @@ int bnge_alloc_ctx_mem(struct bnge_dev *bd)
 	u32 l2_qps, qp1_qps, max_qps;
 	u32 ena, entries_sp, entries;
 	u32 srqs, max_srqs, min;
-	u32 num_mr, num_ah;
 	u32 extra_srqs = 0;
 	u32 extra_qps = 0;
 	u32 fast_qpmd_qps;
@@ -390,21 +389,6 @@ int bnge_alloc_ctx_mem(struct bnge_dev *bd)
 	if (!bnge_is_roce_en(bd))
 		goto skip_rdma;
 
-	ctxm = &ctx->ctx_arr[BNGE_CTX_MRAV];
-	/* 128K extra is needed to accommodate static AH context
-	 * allocation by f/w.
-	 */
-	num_mr = min_t(u32, ctxm->max_entries / 2, 1024 * 256);
-	num_ah = min_t(u32, num_mr, 1024 * 128);
-	ctxm->split_entry_cnt = BNGE_CTX_MRAV_AV_SPLIT_ENTRY + 1;
-	if (!ctxm->mrav_av_entries || ctxm->mrav_av_entries > num_ah)
-		ctxm->mrav_av_entries = num_ah;
-
-	rc = bnge_setup_ctxm_pg_tbls(bd, ctxm, num_mr + num_ah, 2);
-	if (rc)
-		return rc;
-	ena |= FUNC_BACKING_STORE_CFG_REQ_ENABLES_MRAV;
-
 	ctxm = &ctx->ctx_arr[BNGE_CTX_TIM];
 	rc = bnge_setup_ctxm_pg_tbls(bd, ctxm, l2_qps + qp1_qps + extra_qps, 1);
 	if (rc)
-- 
2.47.1


