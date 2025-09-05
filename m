Return-Path: <netdev+bounces-220434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E060DB45FE0
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 19:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A51A43FD1
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 17:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC68313286;
	Fri,  5 Sep 2025 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P5u6h584"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CD8313293
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092824; cv=none; b=BHc3+N6d8LyFo0B4UuE3h5TnRQIXXc1wIWSC7IHi+J7aByFr+KLSuahsSnkARsYxZ+QucyJ7EVe1YA4dxvgU/PdkwwzoTUmzXFqiFlCZpQArqpmXNmJkOdR4kqz0Zw4Tfxad+KAmQJ4zKxbVBIr/tXMHGN76oc0wnHimIS7hw4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092824; c=relaxed/simple;
	bh=G1NiFDz8oZhTB5nWROQ4ml+rvTNq7sXuFIg0das2/hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3N584SC3kN25OI9Le1uByrdL4aCffkexTdOfh1mIHSGrxhPFz6cHK6sr62xpv3E8luS8Ae9qzMktA5zfDqBpxzllZm+/wCLhKoeWWmJZCVtnDVsrFx/4A0bPQdnTvHH4U9DBJbocKuj5siOjn2Ujj5ASU5HBVi3gK3YGxwekog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P5u6h584; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-3f0651cb971so13849015ab.3
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 10:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092822; x=1757697622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUECdZ3lR6R7TzQiSPdeZzqdUGndQHKhb6XoefEvstI=;
        b=Ql7qFaus4VxWpjJjovICA2Npj2/LAOtRBfsJWecwWbnWBGPxw7e70TwGgVGqHaaFzx
         lFXWd36p9PJkMtuVy/e2j+sM1USRL2k0vrx3xNtBouGgt4eEpBxK3VKf6bT3vlI7GZza
         1Ip1p2Az5mkAiOwExQAh6N7u5Y93z2OT3jGeaZkfKXT3fTb1y9ThZvdquZq9/oyeJx0R
         vvNBvcGT+UdXR0qHV9gzKyGLstl2EAG5wbqj7gUkw4ercHlu5Er09jEGS6aRGguR3aHX
         iaXUTaf42080I+yhljFt9TRd4f5Dxs7ldtbxFRmMMfaNj4NxHnxVbfz4lPj2jskfveHB
         VMWQ==
X-Gm-Message-State: AOJu0Yypw37D0We0N0dhZI2OJBtbpgDozWyhGEOfHCBs4zSk7zF0KMlN
	+X07Eq3UItkZi94HQqhH9vIXrl1jRfLUg7kbNv/f6h4SrUdRT5YxbJd/ng7Fvs726wuKlj6iEIQ
	GGywveI1hiWFCgUAxPUmdNmrnUVZw9zlO8oRGzKZI4+bxRKnXNT40mjsvF3IeQuxWHIPG1irTTi
	x6/022+t7nzM2wiT00VmBLd489QUdWXTca876xCi68jaqD/t+dkjA6oPlv4sgtOIfTqBDJA8gK3
	ezO2jL+VwsxKxo5xfy2
X-Gm-Gg: ASbGncsHnSS2UgdSeARglsBqxjC/nuoGfkHBKJ8BGasTemXGqqpao6jMuH0kN3y0g18
	AyOJzFFB8Ju+j6jNkj/4osriZB7gML9sOoBEXwseCld1BzSdSKhRSqKuIf/M6GvxnH7Jy3a5Cwq
	E8a7J5/J3jUIVIFJJdnvy2Y5IQy+VBcGyu0DE0lOK6V4mFvBVerV0cw317AkTxHtfsGl2cGx/6I
	ikvQS4e+6BlYIvLD8NEcxKGHL5gvqOjP6aec1IdUdlhYvEKvDaTrqp9zct4bnQJOfUZ9KL4u5VP
	b75G/wqlvBm3nPfFoY9f06w6NEdXqhY96610kIeQmAIkfs9I4M6+8HshgNwo7lY8GZ3e6Rf9SKi
	95YrvQD+xZYsCb1E49nRfWpFpe581mys03YWKVndyU3JcdDx7Yq6Jz+cJUfi+WL2Sf3k7qsbE76
	s5Cy5ong==
X-Google-Smtp-Source: AGHT+IH/CBRUSn/31ILR2d2cD2tE20FRVY3YEPK+DHH+g2VCto7LQmqpVhMipu5VSfUARYZEe/thxKCN8hrN
X-Received: by 2002:a05:6e02:380e:b0:3f7:8b02:285c with SMTP id e9e14a558f8ab-3f78b022abemr68606515ab.29.1757092817853;
        Fri, 05 Sep 2025 10:20:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3f3df49a448sm15615615ab.31.2025.09.05.10.20.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:20:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7724487d2a8so4228014b3a.1
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 10:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757092816; x=1757697616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUECdZ3lR6R7TzQiSPdeZzqdUGndQHKhb6XoefEvstI=;
        b=P5u6h584MGrEZ+k8XMvAO0xatcR7ErlkQ8mP8z/LvPmX5jWRRZYFl2vlEZLYYVH1C+
         l4+OIB/TyWSU+/MyxOMGL9yt7oDZLd8fEHgtjrTOFWYOEAN3LjR/ieckdlBE655r4X4Z
         Cncyn1+rc0M1TUtaw7EEYYoa2ZyHr/IaJ375o=
X-Received: by 2002:a05:6a00:3d01:b0:772:736e:6573 with SMTP id d2e1a72fcca58-772736e6857mr16862098b3a.22.1757092816148;
        Fri, 05 Sep 2025 10:20:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d01:b0:772:736e:6573 with SMTP id d2e1a72fcca58-772736e6857mr16862077b3a.22.1757092815722;
        Fri, 05 Sep 2025 10:20:15 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b78d7sm22678001b3a.30.2025.09.05.10.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:20:14 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v6, net-next 01/10] bng_en: make bnge_alloc_ring() self-unwind on failure
Date: Fri,  5 Sep 2025 22:46:43 +0000
Message-ID: <20250905224652.48692-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
References: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Ensure bnge_alloc_ring() frees any intermediate allocations
when it fails. This enables later patches to rely on this
self-unwinding behavior.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_rmem.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
index 52ada65943a..98b4e9f55bc 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
@@ -95,7 +95,7 @@ int bnge_alloc_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem)
 						     &rmem->dma_arr[i],
 						     GFP_KERNEL);
 		if (!rmem->pg_arr[i])
-			return -ENOMEM;
+			goto err_free_ring;
 
 		if (rmem->ctx_mem)
 			bnge_init_ctx_mem(rmem->ctx_mem, rmem->pg_arr[i],
@@ -116,10 +116,13 @@ int bnge_alloc_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem)
 	if (rmem->vmem_size) {
 		*rmem->vmem = vzalloc(rmem->vmem_size);
 		if (!(*rmem->vmem))
-			return -ENOMEM;
+			goto err_free_ring;
 	}
-
 	return 0;
+
+err_free_ring:
+	bnge_free_ring(bd, rmem);
+	return -ENOMEM;
 }
 
 static int bnge_alloc_ctx_one_lvl(struct bnge_dev *bd,
-- 
2.47.3


