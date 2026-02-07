Return-Path: <netdev+bounces-257796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Cc1GSzQh2mSdQQAu9opvQ
	(envelope-from <netdev+bounces-257796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 00:52:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C575A1076D1
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 00:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67CCB301E97E
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 23:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C722E040D;
	Sat,  7 Feb 2026 23:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iCn1qApq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F85022301
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770508309; cv=none; b=kqRgvRuGEkAjeOnd5AnTjYQhMi4QeTi06KaN1w44nCuSwHXLJx2uxM3mOl2TYaWvN1XBctagRoLy4osNhOTB4+7KUtppmNjQja1v7pdtZKMUCMuoxPpnVywCgucw1cOFnZJMP9LAY4RyZwGP57OxoZmtN/BB1ZxtKXV1FpXJnRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770508309; c=relaxed/simple;
	bh=f3HGV7jW2Nv+ERlujksLgqgIJV5BiEW+2WDEK7pTSZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cX+Wwp9AiBt6pkFWd8JXMvd/LUqsJmPnK1so4sGiTMC3pKDCr72S4jAB5kzl+RDysaXwezU2zTVoXGb+DUQZU2GkyydaKclCZTYNe4mbt2nTecJ19UiG7ciU4uN0DgBlWRaMroEj239i6H4lMI9JtagKzlrWR/csXQzIuqpSlP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iCn1qApq; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-81e8b1bdf0cso2376520b3a.3
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 15:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770508308; x=1771113108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Z6SCsphPXK9ULD8R8Ee3/8N1ZshWsHpnCSm5ZqJrm8=;
        b=jV4Xvz4v8J90/D/rBBg7KOs4p4fBMRzzGvi525n9/WuN7NhN/RNwHEq/sNaMAOrUNp
         MllR2XMMjTenrlboRmyqESKdAddAGtz1Mr3bovEz0k7yCZ/9/NnLr7ZT/Tc30J4PfhF8
         eAZhevkFLYQ+P5WQrG0cSWRuFUy4pnVOP2/SB2YjkzW14vqkkq5BwNGtIWdlzYcSVPUC
         zSXUIggkG6mdPYHbCpJBFYktdewaZ+R8IpGDXrqXmaHbWPjUnuT/g1XQrEtzpG/c882Z
         +/Jp2KH7OFN6KqwqXPU5NlEcV9yqBt0IBXUz0CyJ3XldtylRrDgzBKdlTbF4OK0NCfNO
         Jvww==
X-Gm-Message-State: AOJu0YyA7rBc4XgnXA0QWj5a2c2EeJkpbkx03R+mzilsNrFThkcNIJOa
	byon9TQvVjSdWBMGW4tCXrypeCv4WXrAp604SF02fjmhutAH5XVxE3WuCL6sZ6xOR7IG1ToUdIi
	M3xzER+gCIOXwpuX7mlXpYzVad3U+RKlUHHkk5aqzk5Hy9Pq0MNPMAmVTUmVHNAnZqp0fAzVgcj
	DzlrvQgABE7W/9Rx6l4Yf3GozR0y1ppFRv2BXa1N8MeQADG2XOl9RRrklR8ikjhoKYliS1BD9y0
	lAn3HZ+XCQ=
X-Gm-Gg: AZuq6aL7zAQAvwCZ8OXJhyzaKJ88IkzOVW5SbQiUlL1ZbHbz4qz0FfQCIpo4FW/KSv6
	VDQamlzsGhxqNsJuFkKf2KdoX6X4nPubk9Q5z3ZNDq24pN7i+69LJvSu9EwYdd/J0xEohA4ZXHg
	tUNNOk2FSg7MZCFK8ykedkzEAB2FcFIJhsq++arCJ5LdCCIBvl8BC/ygVQlgFIOwTn64unyMV9m
	pCuD3Ixh4fI40Xfp43AvWqZDUEM6haFRb2pVBj0d9YNqTEbXA9xZO6ShX9r4o0zUV8klch+CEUN
	VD2iMIPKgS0ho/yQeXt955PwjtS0NTJEZI62bOm27uC5Emm3e8z5wle5hBs2k6sAiR9cwzhBTos
	EUEUutWaeubMxVrMktQzt1UZ5O6HsPdYqcTPYM7K2rdVPDQMN1Tk7ICAsoKhax0k4FM4IiqWqxn
	wcgAN0KpaSnEuOqkTSMxL53xCftDu7dF8DNu3GzJPRhDf7
X-Received: by 2002:a17:90b:5188:b0:341:315:f4ed with SMTP id 98e67ed59e1d1-354b3c84188mr5605861a91.10.1770508308190;
        Sat, 07 Feb 2026 15:51:48 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-354b221a6c4sm1079733a91.7.2026.02.07.15.51.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Feb 2026 15:51:48 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b867a3988bso457811eec.0
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 15:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770508306; x=1771113106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Z6SCsphPXK9ULD8R8Ee3/8N1ZshWsHpnCSm5ZqJrm8=;
        b=iCn1qApqItcoA819BWVpOISYMkuQJzd+nd5n1zEkwa6khmQQJhZd6kj61KAwBoEdTH
         ZezontFniyguu6H2rjc4ijxMd79HL+KW+iYqZG+rA2rH+OM6G68DGU9/BD8vYraaLD5O
         /DE6T6ybql96M00xDeKpdi+S2v7iG8mZhsuUc=
X-Received: by 2002:a05:7300:5708:b0:2b7:f809:9c41 with SMTP id 5a478bee46e88-2b856721ea1mr4292565eec.25.1770508306351;
        Sat, 07 Feb 2026 15:51:46 -0800 (PST)
X-Received: by 2002:a05:7300:5708:b0:2b7:f809:9c41 with SMTP id 5a478bee46e88-2b856721ea1mr4292555eec.25.1770508305749;
        Sat, 07 Feb 2026 15:51:45 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c3db30sm4479446eec.21.2026.02.07.15.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 15:51:44 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 1/2] bnxt_en: Refactor bnxt_need_reserve_rings()
Date: Sat,  7 Feb 2026 15:51:17 -0800
Message-ID: <20260207235118.1987301-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260207235118.1987301-1-michael.chan@broadcom.com>
References: <20260207235118.1987301-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257796-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C575A1076D1
X-Rspamd-Action: no action

bnxt_need_reserve_rings() checks 6 ring resources against the reserved
values to determine if a new reservation is needed.  Factor out the code
to collect the total resources into a new helper function
bnxt_get_total_resources() to make the code cleaner and easier to read.
Instead of individual scalar variables, use the struct bnxt_hw_rings to
hold all the ring resources.  Using the struct, hwr.cp replaces the nq
variable and the chip specific hwr.cp_p5 replaces cp on newer chips.

There is no change in behavior.  This will make it easier to check the
RSS context resource in the next patch.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 45 +++++++++++++++--------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7d63d6b0d2c2..4745063d2f5c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7946,13 +7946,27 @@ static int bnxt_get_total_vnics(struct bnxt *bp, int rx_rings)
 	return 1;
 }
 
+static void bnxt_get_total_resources(struct bnxt *bp, struct bnxt_hw_rings *hwr)
+{
+	hwr->cp = bnxt_nq_rings_in_use(bp);
+	hwr->cp_p5 = 0;
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
+		hwr->cp_p5 = bnxt_cp_rings_in_use(bp);
+	hwr->tx = bp->tx_nr_rings;
+	hwr->rx = bp->rx_nr_rings;
+	hwr->grp = hwr->rx;
+	hwr->vnic = bnxt_get_total_vnics(bp, hwr->rx);
+	if (bp->flags & BNXT_FLAG_AGG_RINGS)
+		hwr->rx <<= 1;
+	hwr->stat = bnxt_get_func_stat_ctxs(bp);
+}
+
 static bool bnxt_need_reserve_rings(struct bnxt *bp)
 {
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
-	int cp = bnxt_cp_rings_in_use(bp);
-	int nq = bnxt_nq_rings_in_use(bp);
-	int rx = bp->rx_nr_rings, stat;
-	int vnic, grp = rx;
+	struct bnxt_hw_rings hwr;
+
+	bnxt_get_total_resources(bp, &hwr);
 
 	/* Old firmware does not need RX ring reservations but we still
 	 * need to setup a default RSS map when needed.  With new firmware
@@ -7962,25 +7976,26 @@ static bool bnxt_need_reserve_rings(struct bnxt *bp)
 	if (!BNXT_NEW_RM(bp))
 		bnxt_check_rss_tbl_no_rmgr(bp);
 
-	if (hw_resc->resv_tx_rings != bp->tx_nr_rings &&
-	    bp->hwrm_spec_code >= 0x10601)
+	if (hw_resc->resv_tx_rings != hwr.tx && bp->hwrm_spec_code >= 0x10601)
 		return true;
 
 	if (!BNXT_NEW_RM(bp))
 		return false;
 
-	vnic = bnxt_get_total_vnics(bp, rx);
-
-	if (bp->flags & BNXT_FLAG_AGG_RINGS)
-		rx <<= 1;
-	stat = bnxt_get_func_stat_ctxs(bp);
-	if (hw_resc->resv_rx_rings != rx || hw_resc->resv_cp_rings != cp ||
-	    hw_resc->resv_vnics != vnic || hw_resc->resv_stat_ctxs != stat ||
-	    (hw_resc->resv_hw_ring_grps != grp &&
+	if (hw_resc->resv_rx_rings != hwr.rx ||
+	    hw_resc->resv_vnics != hwr.vnic ||
+	    hw_resc->resv_stat_ctxs != hwr.stat ||
+	    (hw_resc->resv_hw_ring_grps != hwr.grp &&
 	     !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS)))
 		return true;
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
+		if (hw_resc->resv_cp_rings != hwr.cp_p5)
+			return true;
+	} else if (hw_resc->resv_cp_rings != hwr.cp) {
+		return true;
+	}
 	if ((bp->flags & BNXT_FLAG_CHIP_P5_PLUS) && BNXT_PF(bp) &&
-	    hw_resc->resv_irqs != nq)
+	    hw_resc->resv_irqs != hwr.cp)
 		return true;
 	return false;
 }
-- 
2.51.0


