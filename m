Return-Path: <netdev+bounces-300779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gp7dEiEyNmrz8QYAu9opvQ
	(envelope-from <netdev+bounces-300779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 08:24:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A07976A8692
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 08:24:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.s=20251104 header.b=kgJPyPR1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300779-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300779-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=iitm.ac.in (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53C92302F0F7
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 06:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26BD37266D;
	Sat, 20 Jun 2026 06:24:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6581F3B87
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 06:24:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781936670; cv=none; b=CEwnv7/R33kVsyCGwkjH/3VzZ5kjVBfmrLy9n6md4uuCJIDKG1jX6s2KglgnXoyVNwTvVzsix0ydyRRp5OUxidAGkeg0j4B7++VZG9SAYqhw3pS69x2+X3Zyv7ZPs0EQx5IdydWeD1KFrB9KosuVX/bM5MJDxyRQXETLxIYIBJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781936670; c=relaxed/simple;
	bh=RsSAho1Pzk28o91OKru6XLgpA+3KQiuhOPhWSfAqX6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JUN3BXRl8nH0FbJEIG35RG/EC8Wk6+UpMQOCuUv/qXxxDSf6o3Ej1sFOXerdyeV6s3o8N0EO5u8YS3WRiK52gpOFMriest+AA6NNB2QERWwCoThy8KpZMyOf42In41QzP8NDvjzL32z6gSUqIC0IT6BZ26nbwzE+tvMvVkjia2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=kgJPyPR1; arc=none smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84532e3dbf7so1598243b3a.1
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 23:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1781936669; x=1782541469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/1levBq2VByeRMw4NnVrhw7VKzj5zHwRoGDl6Jxfu4Q=;
        b=kgJPyPR1LZ3XxfSZlvbpQW4cr6Us2+Z90L/t/162JxtCaeeofLduLGilcjzDWLvCKE
         Ubw2ZOG3LHZbl1sUH/neDL5nfWy2JcaLTZjL0jPwQP7vtN9weYi0nsIIr3VzI8Bi0YcO
         OG5nG+Svr8KCokmYfbtlIcuCT1ZtauDefZeMGJJCwMpZtMUQDxn9boG1NzYlRUxmJB5k
         4kz+w+77EgdUbxJqqvGayhFGqd1h0MrOO/of53n9ZtKfY+rv6cwL7RCdpsusTAccWiBX
         klNuWTIi85BoU3yVke/GwfiPdsTgEkKUG7qcJQnRV6Pg2RnlNu1M47gnDbp+DtmIP6Zd
         2bLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781936669; x=1782541469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1levBq2VByeRMw4NnVrhw7VKzj5zHwRoGDl6Jxfu4Q=;
        b=UWdZNTfDr+wFyLPtDYvFrzE9/XS2BE7/4Nlm+jqkLNdW7sjipoCddCj/l3CijFgsGS
         8/nLd+bakplAfVegefQ/259haNKTyj16pZZqabbvYMapQ7IQsYP0YFuRaAePAf4Crpez
         l4jrBBJNMB7kxGvY+M0J0AFETKC7pY/zb62Zb2V+L9coRgDFGu6KIo/1RmO16be1N3Bq
         9XmhH1j2xCr6qIBM9JSjfDcfT1kEkGiC4EbI7wuKQKg8UjJD3mSd+vBdcCqskyXnMQRF
         foXA9kM+SKa+NT/pRLyF2tNspw2VnSx3KaZPJwoluZOHw4Lm8txLb22bJbih5WacfseS
         ncDw==
X-Forwarded-Encrypted: i=1; AFNElJ+IGgU/3HomHsoWMzqVI1vAzbFPCYi2naJSSrU1kctk8o4IJrOVOObrJe9nMTsO1N6F46KBrrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+gvI3+JXZuroixJ7MXP0pQIJYVQ903ekzmrjdb/DEGFiaLcWX
	FG0a2cIZhdzPBtMfxXX1bFPVu+fl4llqoF2YV0gp2KznqolWQ2zI1WbUXgWrKfqAX8Q=
X-Gm-Gg: AfdE7cmY4hOEO3sizzFQLg9FFtW9E+iGhS8uJsqv4TmjOz5YTEELpg7qOB7BYqCD+Fw
	GSYpVGLCuiH/6LwlzGPJUETNgb/pmXRQW7KkaLRB1gkRsiyc2UWhhGlnH2Vyi2BgYs9k9sD91yD
	evLAHV3wpi1G8Qg9QG6tn/g2ryk6Fji7ZYkRYZjgxDzRVnedfVTtiUUyV0nuiesUcNbzbrFhVCe
	UQ2l0fsO7iwVv5PJF7/ss4mTrItXI5yCkMgssMd+6XHDVdMlJmaUW8i1QUA2nKnJNo0PueYFlkM
	WbYsefGwaufpyJokbeAArav/CjH1fm5nen6GaCcMHigA/PETKZVF53w4kvaxlmkhOifFgenIbPr
	LmOyax+e66IxwH/9hEuA/Ygu46sVLrtce3KNhKyTxA/lOk2nz2kq7yfhTnBH7OtB6IgA6eX+ZI5
	UbXQq0caPsCNOpdCwP20eedwp8JDpmqwv3MuYp/S0TcyO/XrG39d5Kz+jWMZhdZLRo+a+huWhoZ
	3vUxD3zjpzvxuD6FC4CyrxWE87g3sTGywPy+LlIO0ZLs7s=
X-Received: by 2002:a05:6a00:9296:b0:842:7296:dba with SMTP id d2e1a72fcca58-8455079fd74mr6874865b3a.7.1781936668977;
        Fri, 19 Jun 2026 23:24:28 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84564d89dd8sm1139652b3a.15.2026.06.19.23.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 23:24:26 -0700 (PDT)
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
	barak@broadcom.com,
	stable@vger.kernel.org
Subject: [PATCH net] bnx2x: fix potential memory leak in bnx2x_alloc_mem_bp()
Date: Sat, 20 Jun 2026 11:53:50 +0530
Message-ID: <20260620062402.89549-1-nihaal@cse.iitm.ac.in>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300779-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:skalluru@marvell.com,m:nihaal@cse.iitm.ac.in,m:manishc@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:barak@broadcom.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nihaal@cse.iitm.ac.in,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[iitm.ac.in:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cse-iitm-ac-in.20251104.gappssmtp.com:dkim,cse.iitm.ac.in:mid,cse.iitm.ac.in:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A07976A8692

If the allocation of fp[i].tpa_info fails, the error path will not free
the struct bnx2x_fastpath allocated earlier, as it is not linked to the
bp structure yet. Fix that by linking it immediately after allocation.

Cc: stable@vger.kernel.org
Fixes: 15192a8cf8a8 ("bnx2x: Split the FP structure")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 19e078479b0d..5b2640bd31c3 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -4748,6 +4748,7 @@ int bnx2x_alloc_mem_bp(struct bnx2x *bp)
 	fp = kzalloc_objs(*fp, bp->fp_array_size);
 	if (!fp)
 		goto alloc_err;
+	bp->fp = fp;
 	for (i = 0; i < bp->fp_array_size; i++) {
 		fp[i].tpa_info =
 			kzalloc_objs(struct bnx2x_agg_info,
@@ -4756,8 +4757,6 @@ int bnx2x_alloc_mem_bp(struct bnx2x *bp)
 			goto alloc_err;
 	}
 
-	bp->fp = fp;
-
 	/* allocate sp objs */
 	bp->sp_objs = kzalloc_objs(struct bnx2x_sp_objs, bp->fp_array_size);
 	if (!bp->sp_objs)
-- 
2.43.0


