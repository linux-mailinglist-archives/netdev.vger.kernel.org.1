Return-Path: <netdev+bounces-115548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3028946FAF
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 17:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE93F1C20D22
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 15:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6634D9FB;
	Sun,  4 Aug 2024 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRqILuTJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C2A1DFDE;
	Sun,  4 Aug 2024 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722786417; cv=none; b=BqavzQO5tzxpTzbUlrjpW6MVUQ0m6fpX1rmj0pmsG2pfzHcXsS2Cd4LyHLYVzH/OBz2vLMHHDKRoWecQBlZMt9lePyaKjdZy90fR1dk7eXPifYZVtJHTpTHFGbdVkdQ8IaGWGiEvuSrRk+fRsuJjg44PmDgPv8lFvLaU80GI09w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722786417; c=relaxed/simple;
	bh=0roKzM1fRBmXSj0WEesBXbXW+PAoYQryLclvNVrlveY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TMA2UNgeUA+W0nP+5r5nXwNf7pDrR4FGKGN7lIyiUXdKWixYu3rArb/btyyoB48tDG4URb4tjmoGzGkZvnoYQftx8oy9CMqJGo7m2qa/cbaRuonf0Sd0EQyVxrPnD2vzGbB7/sekR1mpserixxHCqj69Pbg+3uxZS5q09jPW0ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRqILuTJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3685a564bafso4913103f8f.3;
        Sun, 04 Aug 2024 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722786413; x=1723391213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mlp/x+HwXkbRiwsuFRhzSuMJwunaJ+O88frp4ecnldM=;
        b=bRqILuTJ9PPp4BLPefQoAouBSRLDTByTXifWJevW0CP6NAJnjodbq/XOo7OMmR4CxS
         AUW7DKTZ9v4r0Rhi9YlYIehtddhlwlLMRjjOmdk3TkyX0gUKcgm9cOS60qb8uMl/ycLm
         N758lwdXAaiZR3gs1iNw8dbnLGtBe9W4VVKFPj7OcU7AShnhW1epgnKDghIRIWVTDtgz
         5sTeE+I3O+nsvY1kMK/5e1MfU7f5RwzWiBS1QfYCfmAnwkrAeQkC5FwwrnkwzYQRTaij
         hP2nNwR7im/EQ/+YIL+rBkwB5SuEVvWRJANwAsQX+km9kqhCe5WcN/rwXkjOgoGtu4Ij
         GZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722786413; x=1723391213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlp/x+HwXkbRiwsuFRhzSuMJwunaJ+O88frp4ecnldM=;
        b=EBi/J+DE6RL1cm974cypfO2l/F4kSV8FI0FtrMvloRuSZDVKWh0oROScc/iHvS5nv0
         umvCNdUMfZjN0zx8Bx0H5aAHX+zUssF81RhcP8941viuHVRrZ6QEy+tfFDrdyc0/O0Jr
         RCfccjNC61iTM5fA38WFnTc3kTNIDWoPvZr7e09PR8KpOXuMbiRDNLJD2FQDX2/sPO6X
         EOfwFIdz7I+x/2lbyIWt5rGJAWhEp49iyxBMzkILwCMhcXr4InuR7sMlI9t5PLldltKa
         C5xF3kdLW9UkxoBIpV3BpqLTfxmljqUvogdXq16gWTuS2k0I7UpFcuJJiWcuHfcIW6DF
         JPdg==
X-Forwarded-Encrypted: i=1; AJvYcCVV/T/EjNKqPZ+079gM0XKJe1qUZBT1Nn4J5ecAoLDkeTFwZ+0coRZsM0Hg4+L37x/zwSuRbwXJWmQCsSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2XCfwCi4D4+7ptdy+UwWwbPVyd8R7KuT5jJBcQnl+Kk+Qr2VA
	MRgHQdTTM9QMKpYitmHPjoimrV8z1Dbu1pwPZrtAdfB8L+X6Z/za8WZQEQ==
X-Google-Smtp-Source: AGHT+IEezCcCjJ/kHEdUKrURcd9JboOtK0pJV49pF+mIsfjLELi4ryVv/+0pkHWdRe11tJvGc2X72A==
X-Received: by 2002:adf:dd87:0:b0:367:f104:d9e8 with SMTP id ffacd0b85a97d-36bbc16102bmr6211959f8f.47.1722786413330;
        Sun, 04 Aug 2024 08:46:53 -0700 (PDT)
Received: from localhost.localdomain (93-103-32-68.dynamic.t-2.net. [93.103.32.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0cc58sm7291079f8f.2.2024.08.04.08.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 08:46:52 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2] net/chelsio/libcxgb: Add __percpu annotations to libcxgb_ppm.c
Date: Sun,  4 Aug 2024 17:46:09 +0200
Message-ID: <20240804154635.4249-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compiling libcxgb_ppm.c results in several sparse warnings:

libcxgb_ppm.c:368:15: warning: incorrect type in assignment (different address spaces)
libcxgb_ppm.c:368:15:    expected struct cxgbi_ppm_pool *pools
libcxgb_ppm.c:368:15:    got void [noderef] __percpu *_res
libcxgb_ppm.c:374:48: warning: incorrect type in initializer (different address spaces)
libcxgb_ppm.c:374:48:    expected void const [noderef] __percpu *__vpp_verify
libcxgb_ppm.c:374:48:    got struct cxgbi_ppm_pool *
libcxgb_ppm.c:484:19: warning: incorrect type in assignment (different address spaces)
libcxgb_ppm.c:484:19:    expected struct cxgbi_ppm_pool [noderef] __percpu *pool
libcxgb_ppm.c:484:19:    got struct cxgbi_ppm_pool *[assigned] pool
libcxgb_ppm.c:511:21: warning: incorrect type in argument 1 (different address spaces)
libcxgb_ppm.c:511:21:    expected void [noderef] __percpu *__pdata
libcxgb_ppm.c:511:21:    got struct cxgbi_ppm_pool *[assigned] pool

Add __percpu annotation to *pools and *pool percpu pointers and to
ppm_alloc_cpu_pool() function that returns percpu pointer to fix
these warnings.

Compile tested only, but there is no difference in the resulting object file.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
v2: Limit source to less than 80 columns wide.
---
 drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
index 854d87e1125c..2e3973a32d9d 100644
--- a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
+++ b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
@@ -342,10 +342,10 @@ int cxgbi_ppm_release(struct cxgbi_ppm *ppm)
 }
 EXPORT_SYMBOL(cxgbi_ppm_release);
 
-static struct cxgbi_ppm_pool *ppm_alloc_cpu_pool(unsigned int *total,
-						 unsigned int *pcpu_ppmax)
+static struct cxgbi_ppm_pool __percpu *
+ppm_alloc_cpu_pool(unsigned int *total, unsigned int *pcpu_ppmax)
 {
-	struct cxgbi_ppm_pool *pools;
+	struct cxgbi_ppm_pool __percpu *pools;
 	unsigned int ppmax = (*total) / num_possible_cpus();
 	unsigned int max = (PCPU_MIN_UNIT_SIZE - sizeof(*pools)) << 3;
 	unsigned int bmap;
@@ -392,7 +392,7 @@ int cxgbi_ppm_init(void **ppm_pp, struct net_device *ndev,
 		   unsigned int iscsi_edram_size)
 {
 	struct cxgbi_ppm *ppm = (struct cxgbi_ppm *)(*ppm_pp);
-	struct cxgbi_ppm_pool *pool = NULL;
+	struct cxgbi_ppm_pool __percpu *pool = NULL;
 	unsigned int pool_index_max = 0;
 	unsigned int ppmax_pool = 0;
 	unsigned int ppod_bmap_size;
-- 
2.45.2


