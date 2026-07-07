Return-Path: <netdev+bounces-305277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aQt1BM+STGq3mQEAu9opvQ
	(envelope-from <netdev+bounces-305277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 07:46:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE1F717907
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 07:46:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.s=20251104 header.b=bOYvrGyz;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=iitm.ac.in (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305277-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305277-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D6A730074A3
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 05:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81EB3859DF;
	Tue,  7 Jul 2026 05:46:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72113002DC
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 05:46:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783403206; cv=none; b=WNI7dfbEtWUQZJoFbXW/aA3sJizXG+8Oh01ogKM3SGvZ7DF8+pSnaT+AD7t2zVJmd3+ZSe9SKETOBeh/eyRlccgkEV+f8jo8aRXwhn+hC/tN0DnO6I4q82adnVs05fE+QpCOELm4/mEQF+n17ej5j7VwzHMTnFP1QueIHlc0Y3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783403206; c=relaxed/simple;
	bh=v1M232dO9X7uVE5dOP26dl0Q353P0zYi1E7BcK+8eiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QoxRu+OVDRqQG0pVhyRmBORLateex8czjatqC/odrh3t4rk3kSssEpeIV5rX1U0ZTAlToi3x1Iuc1O1nrS2U/piF4gLI9zdXFy7gwZgJaqIKkov1UuKtwJjG4LmjZ3snxI3DiFsP3bj7WeQraqrN1iyDnrNq6XpYKQXsJw2jJEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=bOYvrGyz; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cacb8416a1so31312695ad.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 22:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1783403203; x=1784008003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W4L7gYHZDRtRjX7hFao4DIYHrV+U5n/xFwuS3PyRV14=;
        b=bOYvrGyzZgle/Swf3SsVSLJnb5duYr8FYlYLt4ERI+3Ay0n7EhUTQerwbUZ+plrXql
         iBKEeuPwK41yHiZDUlN9PPHUHXTu6t/tegrn2XMvXVijESIad6/1Ka7EMrhdn+e51O/D
         b3kk4qMfpYkC0gVaBdNqohxvxFuI7Vp7gIjf+k0vB3eiclD5GGb1SnruNeU8QmjYt9Lt
         B2c6u+wGuFik4h3ASvzNL7ZTm7v/aXRm8rcQjohQKUoNPcH3lzy0w6PNv/pcFQEfNt0V
         wCFmQSopJzilB2O70VRyjUqJMFN3FNhHNjWrM0gSnoONlZaSBGCECnpPtGiqML1KYseh
         75jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783403203; x=1784008003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W4L7gYHZDRtRjX7hFao4DIYHrV+U5n/xFwuS3PyRV14=;
        b=CA2bO033nkm75fYpu6LAbQyCYt0O6kCKTa0F0Det5tDKt1WDx/QBqYeb2YcnexrWDN
         tkUv2MKte3wiEnRw2Vi3D2OoIJT1GBN9XtgiYtVtkqhquZak/KNre65br7ejdF0P3Np6
         dFjmCZS44CZE84HGUA4Vamuo7COkBUdmHx8M9RVnUaTgMLbqn8TcE4mHbTlLS3uG1Ykg
         jzkK1BbFiLKUu40kyvGJw+CAL60zsCzR2Gu7+N26uAWviv/u54IHwuOrBGp1+9C7tvCj
         iPan/3+QWVT3Bpxgimvcx5Q2nB/WDvjFi24UqLWz9TvV4aMFdtKtpP94vqRTx4n78GnP
         bjpA==
X-Forwarded-Encrypted: i=1; AHgh+Rpu3wHqD/M+6dVZBHrKmYpUk9XH+hySKLTHpIhwEpihNJMdjoQwO8Mkb6D5LR74tULLI6qFOlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYh7rxQeX8veO+Ukz5+nzCpY6Smc0AvKUDx8wcPx86+G/YxSol
	YVWxl3ZuS1ufO/A4MIsLkzSy2WO8ts3ls38ASyYPrAlFB7MXjipOD8Q3Q/uqY9JdkWU=
X-Gm-Gg: AfdE7cmVqpYQtZFYXzfxe8v+Ah/HFn6jl5cmbXUuFlGYKjwQMGonzfY+XcEVUnWsYCz
	Si6LnQhlrbtxDL5IO7rDnvhXWDQ2NKExMIgIdWAKNDGkPlf4/KVX3rMrf1mx/72M2EXG2Yksp1m
	hUE6ImL+BTX9UkNqEdc23ke3xg7xybF4PMEm2Qhnz77DoDaiHvPrb+LbNdaWEikwqufjfzhd8QP
	5ntGQpmfORgHCTRtGEzRd+ii7OOry73B9XXS2gPe5q66n1lyu68oa2jqhqSf64VLSn4KF48wxX9
	4BKfMr2g0+a8AepCAm0INE2RpvU6MYtjw3pa3ZDAKmCN8x/IUNsY9g9QqQtIWizEpyfdwmJeHFy
	24CuoR0Hh5VfX3GM5FxSXtL3kKQ3s3BX12EMzqjPP4GLJ0xzna5eOXFgcYlooqoh1WqI//UtR9S
	aVNKwvZSxcNF1LlxBxh6DYoZ7lQxsDVinxQ9nE7BCAOyaH9bbRRT5PatAdBhHOIvKgL23hljVMy
	JQihlx5DGU8K90/xMmXdkcBpWZD2JGcDZAzn5hjh2U=
X-Received: by 2002:a17:903:288:b0:2c7:f12d:5d37 with SMTP id d9443c01a7336-2ccbeb17e6dmr35870015ad.17.1783403202764;
        Mon, 06 Jul 2026 22:46:42 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2ccc9d3bc1fsm5320255ad.55.2026.07.06.22.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 22:46:42 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: skalluru@marvell.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	manishc@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	maciej.fijalkowski@intel.com,
	stable@vger.kernel.org,
	Sashiko AI Review <sashiko-bot@kernel.org>
Subject: [PATCH v2 net] bnx2x: fix null pointer dereference in bnx2x_free_mem_bp()
Date: Tue,  7 Jul 2026 11:16:16 +0530
Message-ID: <20260707054618.932108-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305277-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:skalluru@marvell.com,m:nihaal@cse.iitm.ac.in,m:manishc@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:maciej.fijalkowski@intel.com,m:stable@vger.kernel.org,m:sashiko-bot@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nihaal@cse.iitm.ac.in,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFE1F717907

In one of the error path in bnx2x_alloc_mem_bp(), bnx2x_free_mem_bp()
may be called with bp->fp uninitialized. And so, there could be a null
pointer dereference in bnx2x_free_mem_bp(). Fix that by initializing the
fp_array_size after the bp->fp pointer is correctly initialized.

Fixes: c3146eb676e7 ("bnx2x: Correct memory preparation and release")
Cc: stable@vger.kernel.org
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only.
Thanks to Simon Horman for pointing out the Sashiko review.

v1->v2:
- Add the correct Reported-by tag for Sashiko as suggested by Maciej
  Fijalkowski. Also added Maciej's Reviewed-by tag.
- Simplify the fix by initializing the fp_array_size later, as suggested
  by Paolo Abeni.

Link to v1: https://patchwork.kernel.org/project/netdevbpf/patch/20260701065030.381836-1-nihaal@cse.iitm.ac.in/

 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 5b2640bd31c3..5a9742fd3ddf 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -4742,13 +4742,13 @@ int bnx2x_alloc_mem_bp(struct bnx2x *bp)
 
 	/* fp array: RSS plus CNIC related L2 queues */
 	fp_array_size = BNX2X_MAX_RSS_COUNT(bp) + CNIC_SUPPORT(bp);
-	bp->fp_array_size = fp_array_size;
-	BNX2X_DEV_INFO("fp_array_size %d\n", bp->fp_array_size);
-
-	fp = kzalloc_objs(*fp, bp->fp_array_size);
+	BNX2X_DEV_INFO("fp_array_size %d\n", fp_array_size);
+	fp = kzalloc_objs(*fp, fp_array_size);
 	if (!fp)
 		goto alloc_err;
 	bp->fp = fp;
+	bp->fp_array_size = fp_array_size;
+
 	for (i = 0; i < bp->fp_array_size; i++) {
 		fp[i].tpa_info =
 			kzalloc_objs(struct bnx2x_agg_info,
-- 
2.43.0


