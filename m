Return-Path: <netdev+bounces-106655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB689171FA
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 22:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763A6281468
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8622D17E8E4;
	Tue, 25 Jun 2024 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="qGbC8jwP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3379A17D8B7
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 19:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345336; cv=none; b=INQPv1Dq9XrseLTELFKbUdH2i0gdyAX9I/riEkSoKXwH8RWdW8r+evNzlZNdCdgb4eQ2vvKyocXyBl+27eLvZMsUT6VhSgR5zKL/puyChXUC1cTajegc9DJ/eyewLPsV643pas2afbNV2MoSDMXEDtSA92xu/dObAeACf3JZL/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345336; c=relaxed/simple;
	bh=+jQIvwSRoD2qY2EtGn1rH9DqSSCqa6kNGRg+qbb9NNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjBs0y2oIJeT9JxLowrIjSaiu87L6b/QeCRA5GXeNqamaqoN7bJNzgHZ6NKb6KrEYfZG16ErpDnzL5vFNtYXM29SSh8QeTr51+Z7iSqLKeqM8G/PbLiyamE6Zdn9rDyxT22Q5ijdOs0CRdYrSvso5DoqWlxc+9EoUxv8LPLrMSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=qGbC8jwP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fa55dbf2e7so17590945ad.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 12:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1719345334; x=1719950134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjBM8oO+wqXY9IZv7wSH+DBIVvI3nq0lFFqufk9e3T4=;
        b=qGbC8jwPHI3OS1i0FK4f8+Wy+wEJMVUcV+uCamJCUmRzrTibjKs5LWTLicYkOnjrN9
         IvWoTr9Gi4XpL59O2NgeF+9WI6UU9P6QstUl4B8AUC9yRaZCcBIJEddMHIKNPMVUt132
         urOVQucFLq5XThBTT4Brb7Yyr9ogXbaCv3POMimfBYU4hVJ3p+pgpI3vqsISY9xxf+GC
         cIyaCR01gj0xuCu0fjYvW6Ao5dV/pj3r1RTkx+XrXdJzgsGyimNegbW0HDDwZ/2s4V6x
         Dz0zOSudgN73hPJfUqTZyqamuDEWf5sATEdHAE1Qe8dz4LV48mu1y5x4Up8UTjGJ0skL
         oe5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719345334; x=1719950134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjBM8oO+wqXY9IZv7wSH+DBIVvI3nq0lFFqufk9e3T4=;
        b=NyfyTKGm87J1+gC1mJW1Nr/uJbfC8LGzqwt2LvPhD3PbTxoVr7ZFROAeFIU0ZBbsXs
         4qVexUb83jgjKOCV5/E0aq5bwt4PBCIR0unAbYtChF3oUWS0qKo4YRKa4BOSF5lgqKsJ
         wyWLp0NaFsqVcXnRtMWbYX6le0nqv1n8lU3Sa1Qvn4ZHJaPfPlVbpVqiwR1AwyHo2z9C
         Dpwjn4SB3gLXyuc5TVbJkaWNAYHIX/Yjak2i2yGscsXBaFbKYWlI1nNsDBCwEqD7Hj1u
         pIVcNbIvHFU/bKdI7yxZpU8iTCUIxdd7Kq/qDeRf+oj74Mbyk3vQw5FeJOf3zRpsfE+U
         JLCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAQfhnIcjo6UmhrJnvJ6bs+TGRzsIOuJZDSUTnANPKppl4w1WFAuZmMQDeXZRBl2OHNQgwhzng+cxiVAK9OwplU+YmLbqM
X-Gm-Message-State: AOJu0Ywr8AxXac0UDW3Bhs/TUBCVKv+bgtUoU+o0UqkXzoclFQVRujDv
	23jw6HxZYAMKptK2av2YK4TWvu+xmUVai0oe+7mVaa9yjPIb5M4gt8gYBFP8QxI=
X-Google-Smtp-Source: AGHT+IEcJlL5Sp1GtvcZ1zjWQMCjEtqpSh/sk2hyiDkiigbG9qAdeHvVoLfa2RT37d23WvmwWJYouQ==
X-Received: by 2002:a17:902:e5cf:b0:1f8:68b8:373e with SMTP id d9443c01a7336-1fa158de8f9mr98387385ad.20.1719345334409;
        Tue, 25 Jun 2024 12:55:34 -0700 (PDT)
Received: from localhost (fwdproxy-prn-027.fbsv.net. [2a03:2880:ff:1b::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb329a33sm85180955ad.116.2024.06.25.12.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 12:55:34 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1 2/2] bnxt_en: unlink page pool when stopping Rx queue
Date: Tue, 25 Jun 2024 12:55:22 -0700
Message-ID: <20240625195522.2974466-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625195522.2974466-1-dw@davidwei.uk>
References: <20240625195522.2974466-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Have bnxt call the restored page_pool_unlink_napi() to unlink the old
page pool when resetting a queue, instead of setting a core struct to
NULL directly.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1bd0c5973252..2884ab006ea2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15049,11 +15049,6 @@ static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
 	bnxt_free_one_rx_ring(bp, rxr);
 	bnxt_free_one_rx_agg_ring(bp, rxr);
 
-	/* At this point, this NAPI instance has another page pool associated
-	 * with it. Disconnect here before freeing the old page pool to avoid
-	 * warnings.
-	 */
-	rxr->page_pool->p.napi = NULL;
 	page_pool_destroy(rxr->page_pool);
 	rxr->page_pool = NULL;
 
@@ -15173,6 +15168,7 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	bnxt_hwrm_rx_ring_free(bp, rxr, false);
 	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
 	rxr->rx_next_cons = 0;
+	page_pool_unlink_napi(rxr->page_pool);
 
 	memcpy(qmem, rxr, sizeof(*rxr));
 	bnxt_init_rx_ring_struct(bp, qmem);
-- 
2.43.0


