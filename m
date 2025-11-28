Return-Path: <netdev+bounces-242575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 867F6C922C0
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 14:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB1704E4842
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 13:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824641F4631;
	Fri, 28 Nov 2025 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L95J4cpz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F6C1C5D6A
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764337576; cv=none; b=TG6a7LHTC7wgxHUG6N3zOZDvMxUp9B493de6A9osb6vVGTfBv5mejaxhl3ExDLQwRzaFiEDzMi/syRnA/XYNEKTFWD0nG/E9gPwn8abeNPTjICUgCsDrhCUXohFxet7K2S55LdoLb2La3FFhlFKOBGUHtZ+wc0twtTII85mOSeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764337576; c=relaxed/simple;
	bh=zlvW/jN0idui1pFEaPCILXLEB6Pz7MYxpVsI6cS6zyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ibYLrQ4SJIoAC2+GwNPnTiQbSIGqd89xZ1dKtmeijrWkdJApYprrk1Kj5qp9Gpk/jujYZcxJF/XQim6YZm+LNybZLUylukcmfnw17g3adcFZo99Wvln78Ci3xFsucxbYdLXZ3Juypxd/ArgadLyuEayJ6oayzkTPvna1khMx2xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L95J4cpz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-343684a06b2so1740607a91.1
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 05:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764337574; x=1764942374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IekuUIo821t9wwHs/lSRsb8eGj/j82qutdOJ8AF9uIQ=;
        b=L95J4cpzZs+eEo/mp9daf5xxXMfuUc7mFs2tOrr+DwQKtu81IYh35HxPqfsOEpUBP8
         E1sqxNQrzsLcJJSd4apddnx23PmN/W1NhosSkELooZCmDUgNAKYf05at7trEgj+Rbfwv
         V3HATyuwb/y1P23SrPXMnW89YtSufh3+Jga2yP0gPGDiH4XDWzDr6z9eET9Ko8TcFPWK
         /hVMoTJ15oz0zZXTxdtRlOCOif2Ox3GXJ5xdDSNMng9M1sAtrePHaV2vwxn5zNrC/KfB
         s4dTbg28T78n9XxK7f0yI/k1WjgYlNfJmv9yqte+468qTh0L+SzjaWIDoE9EfGJZrQTf
         HWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764337574; x=1764942374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IekuUIo821t9wwHs/lSRsb8eGj/j82qutdOJ8AF9uIQ=;
        b=oDResWyRFeOpBpbcJgNa27V/5/a66lYaZfg8CmljEBvYzlEy1/YaF0zGLApzNjA5su
         MbItcCZApAQKtVf6kuSPLq9RKaZESn2W72EfK8DmiflKm/uFoh0BLxqQ5ynG/sbb3lyG
         J+gmO78MVQin743Kn5hXJoDslBNOgPe+QOm5kBdCTz13Td6djQKpJEgH/f1W9rySZS6M
         zoUdhZLitRmQWiLKUHDjGe3YYEOKFUlbMiIV3cHEqwPckVBXqfDnv/nk4AV4uPYm0f3f
         tyqn86d9fPZ38+t+C2Pn7XKR76mt319SKuA1zJIrtF7JuOQJD1ePCZs/LuUx9x9fEIak
         t6ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHWgmWUt4fAVx2QZwn1p55ZcRxXN7FohPnoUGmRD+11jNAwy3yO6nt0DZCVuV0D9t10mTNVEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGqooLA5P1p8XfhmAF8QzdWEBSZhDjjhqCButfVueYEXcWpgId
	EegmlJLjmqr10ky5wjHJXhoErEJF8j0VXEJ7t4dSknWESYjz7xU2iMok
X-Gm-Gg: ASbGncsmB4KjAKBbQCIc32z0d5QNN0I3Dnx1Rx8Vd3QswBig8rHQS+uEV70we71WuVi
	rM45GvJAm7uNe/lEDC6X2qG4KgdXtn708Mk6Njs+O5/CGBLsEszbE6H97vuS/mKQJPYmhCe0G/W
	hu62auaLH1VWoOxQYV8hfpmADECFGI5bdtjwXwytm3pwV95RJWaeAvXCMkewniOKHR4aSKH81PG
	DtwwcPI0pXkj2fMJgeoErzTr2pkfWY5ABmfsv+L0EvlPOBsT3chnt796N+pQ/AeA6yekuWnujkb
	qNuxRawcAkhdTLUp7QLTYZH8W+ZXexkEorAcJo8txLkjQOE3lB6MnhqvMN2xygX7mdadQlMiCtD
	RXiYBAjvcTV/NlaVHEpnFCiu3gwYmIz9TDA3TA2n+LL2Yb7ydNiW9zDTfH+jZo8y5MZSLRc66uW
	5j6DOJh3D/rHY8uzm09pAkgM7Z9fUvgjXZlSb4fUCnOUG1st7b
X-Google-Smtp-Source: AGHT+IGjh2qVKM3LjOZ/aC5vAnRiCgrHQG0X7v0g3hocbg6GKpT+EUtZNTece8yiB/ANMOyGcYW5XQ==
X-Received: by 2002:a17:90b:3502:b0:341:8bdd:5cf3 with SMTP id 98e67ed59e1d1-34733e55015mr31024244a91.7.1764337574026;
        Fri, 28 Nov 2025 05:46:14 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([114.253.35.215])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fbde37d7sm4792674a12.13.2025.11.28.05.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 05:46:13 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 1/3] xsk: add atomic cached_prod for copy mode
Date: Fri, 28 Nov 2025 21:45:59 +0800
Message-Id: <20251128134601.54678-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251128134601.54678-1-kerneljasonxing@gmail.com>
References: <20251128134601.54678-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Add a union member for completion queue only in copy mode for now. The
purpose is to replace the cq_cached_prod_lock with atomic operation
to improve performance. Note that completion queue in zerocopy mode
doesn't need to be converted because the whole process is lockless.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk_queue.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 1eb8d9f8b104..44cc01555c0b 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -40,7 +40,11 @@ struct xdp_umem_ring {
 struct xsk_queue {
 	u32 ring_mask;
 	u32 nentries;
-	u32 cached_prod;
+	union {
+		u32 cached_prod;
+		/* Used for cq in copy mode only */
+		atomic_t cached_prod_atomic;
+	};
 	u32 cached_cons;
 	struct xdp_ring *ring;
 	u64 invalid_descs;
-- 
2.41.3


