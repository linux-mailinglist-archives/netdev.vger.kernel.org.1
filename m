Return-Path: <netdev+bounces-52697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405897FFBEF
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 21:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BACCEB21180
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 20:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B0253E1B;
	Thu, 30 Nov 2023 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="JWvcC1pa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C99610F8
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 12:04:51 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-423e8145018so7840061cf.1
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 12:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701374690; x=1701979490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJ0QwjQQA2sBtrYbspl5aVVUOMzblP9BjaUBDTeLH4Y=;
        b=JWvcC1pal6xpzSMiXVKZ3LQWZozJh6A68OUbhMc5HRIydkr2zGclYGsoJMJXTZz/xs
         wBvXNrKMp+st2rF2sSrc4rm64ugrwZ6ftqedxwvgQcvemmg79FRklmKg33ZLoCybcAah
         DZSHbV3+bEYb0cFvieT7waWSk8+wi90inMdP+q29IYSfY6KgOjSDqdiENr34B2XtYvtm
         yB2gTK51h0fqJ8z31ZAhb7BcO3laOA0FGB1xwfLTh2Y2aa3hxOjBdgjdTXVGkqcpu7d0
         hDN/QRI+D7KA543aO91anP+nM0HHk5+pcVBuHKEDF0RgAohC9rYWJHld/+m1ZSoHeDiA
         bWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701374690; x=1701979490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJ0QwjQQA2sBtrYbspl5aVVUOMzblP9BjaUBDTeLH4Y=;
        b=BdG4CmUkezX4ZnSxWANGK8b0uWQUDnGpVQpjezIAwc3bYDNlOKJrpxbmHXA1LG1Z/D
         hx7r3bKjUjTfqi4iJCTto+bpMdJSudDfgizq1xQVLxc5ijC9u1C6wGPTnuaSow80mXPQ
         yal/EWNzXiLGTwXf6CcohKg6QrjZI7j/x78GNDras//BuqigFnE/G3PWTUka6Rw5pKxK
         nFgzbmLRv0TQOoYCMb6lrl+qILGauv2r4YH2BwC3zfBh+qBeXFdBXx1zIQq9lZn0dwAO
         f53W37+fdN8tbN5bUdx/1zlCh2A5zKnmbWH1Beqa6lsmzKrr3GY+jKi06YHRQeyqvfbn
         aTIg==
X-Gm-Message-State: AOJu0Yy78N0K23eMUa26Xklb6VJ8lqJp5rnnv/zi/JsVbPTLx4Pdxh90
	U8SXk4i7nsuYH+CcAVUx+ezgbA==
X-Google-Smtp-Source: AGHT+IFTod/Py9hcH5oQn6ff5l7Gu58O8B3tXKspAhOROVnCb0qH7k4XfRrSgp2nr3dD/2mySscuWA==
X-Received: by 2002:ac8:7c46:0:b0:423:8e6a:f7a with SMTP id o6-20020ac87c46000000b004238e6a0f7amr26732427qtv.64.1701374690104;
        Thu, 30 Nov 2023 12:04:50 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id f27-20020ac86edb000000b0041ea59e639bsm787447qtv.70.2023.11.30.12.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:04:49 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	mst@redhat.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost-vdpa: account iommu allocations
Date: Thu, 30 Nov 2023 20:04:47 +0000
Message-ID: <20231130200447.2319543-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu allocations should be accounted in order to allow admins to
monitor and limit the amount of iommu memory.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/vhost/vdpa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

This patch is spinned of from the series:
https://lore.kernel.org/all/20231128204938.1453583-1-pasha.tatashin@soleen.com

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index da7ec77cdaff..a51c69c078d9 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -968,7 +968,8 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 			r = ops->set_map(vdpa, asid, iotlb);
 	} else {
 		r = iommu_map(v->domain, iova, pa, size,
-			      perm_to_iommu_flags(perm), GFP_KERNEL);
+			      perm_to_iommu_flags(perm),
+			      GFP_KERNEL_ACCOUNT);
 	}
 	if (r) {
 		vhost_iotlb_del_range(iotlb, iova, iova + size - 1);
-- 
2.43.0.rc2.451.g8631bc7472-goog


