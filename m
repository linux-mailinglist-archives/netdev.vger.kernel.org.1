Return-Path: <netdev+bounces-152686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0839F5623
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 19:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DEC47A39A1
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 18:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF8C1F8932;
	Tue, 17 Dec 2024 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XrHtESlu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5298B1F9412
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460031; cv=none; b=Qm5UL/2iD+uT3tCbK/s63Yfnrb6EghSIruJAEFmKZffDWni6qUqjq6Rx+cxV8/0w24yjKatBzFDTE/stmGPSs8C0KOlM5G8gq2ItO941j9qUd3PJoEMNZprFL6EUHO8mPXwptdZkci4y7tFFvde01LLyMZx7z3SiZtoASl/qR0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460031; c=relaxed/simple;
	bh=3CBZBlfh+56QfJJs99uRlQZjombPvTGum3x0MjVt7pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAHYAwfeFxVPuco0C5SoW9QtXyujBzen7vmCRc1Qy2oYA+AxOr4R9JLtqKdBY9A1UvMuBi46jz+HJ/e9rgjKWmPXPjRi7bnmsCKiGVZKToy7wShEVeIi35WMIHocNcUdfZo/uYXezCImw+Shu8lZoop9/aotI4qIAULR4nhdP80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XrHtESlu; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21644aca3a0so67034495ad.3
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 10:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734460029; x=1735064829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0XQDitWKVq4eNGE0XYTq4nsJajScvFqTYG5pnFykTI=;
        b=XrHtESlugAu096WZCraxIpoQNV/xSUM5s+kishlkacrZNrWS8z0stPx5dQaC0gQz2Y
         pgkYAqsVK8b7G90AJzdQszR1KT096tLBbMcM+kySJihgjIHC2QDc6jwu/rqOoNZjDC5b
         UG/21vkIJ+bKz+kXJVZ3bwv36/C29d6sZJuv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734460029; x=1735064829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0XQDitWKVq4eNGE0XYTq4nsJajScvFqTYG5pnFykTI=;
        b=Nyg/6m8YUtSeKNQPzbS5YPAp0Rag5oFYjHu9NecPJuWoWe9gbdTsF0G0yw4pJ38P+5
         AXYuXJ0qCaPANvY64warfbW06fZWn30UWXyun6cNuPkLlAlg+GD8M6IGN63Nqe0UZ5LM
         eWfl6e9pt+86Z7eTJPxElLxqChwYzdH8gXLbJvGQg7bOlegsiMKogfzEf58eceTIKMfF
         VQURa8sA2c39OKieA35lteZh/FCxpmf8zE8gTgjxBLAxt6B/SUqdshBYOsFMEckriQTe
         NcbfCt4sk2W0Pkve/w9+NJ9hWIbgF+7tcrhHC2gQ2GDwZ8k+rqwP9EDFou9pW2ij3nLa
         CcvQ==
X-Gm-Message-State: AOJu0YxKYoLtsa4WL/ynuvgECb87ICru2L7CStB2jJB4Kp9IlmqkeXC1
	WBx693DpruJq3Pi00hsGYhOwWeUN3nr0RWIvRrCUToMN51Q1mLF1s1i2rRzxzA==
X-Gm-Gg: ASbGnctWEOTnFxu/zAbE3dEHcXmhXQr39f29pAmYVu1EUIhKg9p8xKJo94ZDMKdUIGB
	f+J0S2DWgjO34wz4HEQ6e7xUNUqPq72rDdcpdJahAj+b/VoesDQ9t8lFselFHNxbTrGrNRe7wEw
	oq0L7KnkiecbGof+vzBDafeQSDXXG5wJpPgMdwB/NyireAh9pJr0vWBRLmil1bMX7pnaY5JYViN
	6EpfLx89rI0kPgwUQxFqRMVjM9uoyM2mYkyWpKK8SGsi/adAld21oFxUA2ohdOEOvBtuWeNYVdc
	BJ3L4Pn9G1KvoDhNN4UCdrC8+htElvCW
X-Google-Smtp-Source: AGHT+IGMHNMKEjPlhVfqnJibVGP2lWKCoF0Rj8LBqRvc8ZfXWQnxW5kq7PG8A5ahiFwJR6zz4xz8vQ==
X-Received: by 2002:a17:902:f64b:b0:216:55a1:35a with SMTP id d9443c01a7336-218929ee63cmr259088285ad.30.1734460029557;
        Tue, 17 Dec 2024 10:27:09 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e63af1sm62496595ad.226.2024.12.17.10.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 10:27:08 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v2 6/6] MAINTAINERS: bnxt_en: Add Pavan Chebbi as co-maintainer
Date: Tue, 17 Dec 2024 10:26:20 -0800
Message-ID: <20241217182620.2454075-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241217182620.2454075-1-michael.chan@broadcom.com>
References: <20241217182620.2454075-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6cced90772fc..2c73a3aacafb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4611,6 +4611,7 @@ F:	drivers/net/ethernet/broadcom/bnx2x/
 
 BROADCOM BNXT_EN 50 GIGABIT ETHERNET DRIVER
 M:	Michael Chan <michael.chan@broadcom.com>
+M:	Pavan Chebbi <pavan.chebbi@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/firmware/broadcom/tee_bnxt_fw.c
-- 
2.30.1


