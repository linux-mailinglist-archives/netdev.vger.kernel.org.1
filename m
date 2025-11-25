Return-Path: <netdev+bounces-241458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 394E8C8414F
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DA03AEC3D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDE22FE58E;
	Tue, 25 Nov 2025 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAFX7zUp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541C02FE577
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764060884; cv=none; b=Dhx0XgTj8sK1E/T19+nQh547QRLOKAs22yLYe2lHcuAOYXEznKkR/S4Fmv+zkdobGQDk5Ldy8uQ40yW79kPUp2v1lxCMpkXcxvqCkfHZvhcGe9M/v4inXrvZgt7TuOCb2KMloOpUZpB8Xdh0ZYsQRvjmEaDHvkRcHFsNpymtE3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764060884; c=relaxed/simple;
	bh=zlvW/jN0idui1pFEaPCILXLEB6Pz7MYxpVsI6cS6zyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dn2SvBhFQyrhalhJGybFUIB0bvNz4e2BJWxWI5PArRfdN1Oo99I5YvmdXkKjGvfrTQs+yMAoglNl3vzZfTPy8X21X8yV3qEDlJrWRTRg9gBBXyegMBO7C0u3jhCAwKtNp4ZF51Gdlc6x6RJ6nK4146E5w7shRf0lzOQ+y9Yh5nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAFX7zUp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-295548467c7so62046525ad.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 00:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764060883; x=1764665683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IekuUIo821t9wwHs/lSRsb8eGj/j82qutdOJ8AF9uIQ=;
        b=jAFX7zUpXUaoBnAccsKHemfTLM/vr54Dl1c8CnrqVwMTa7YwEBT5RFVm5/loKyOgkJ
         l0VrBg3qUiQI8p15AmlfweNP3VaU9aD89hQYrNlt0ec05FTEFEvFWmUqEkI3qEdZfLmY
         YRwLRz/bBh5WUOmjKqwsnwXkwvsRpqm95iGJ5WkcHMcYeTWehOHfH25KBhszSTCQh/wT
         fiKzx300R3KA2LQ7CvcIAy5Apq50nrU4umRzEtUTzMBkgZGEEcQPtmLXEp6UA62V8qMZ
         KvY5QEix9W2GhMRrlzNs5urIabewGThXU6E+701yRbQkigbX0rnvVClKmyQIkvYlEBn1
         zOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764060883; x=1764665683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IekuUIo821t9wwHs/lSRsb8eGj/j82qutdOJ8AF9uIQ=;
        b=s0Bx4jFkzUCYnKAquKDAWB1U6P5fC6Dxt6bQ3M37kYRz/f7X5/9J70ttB5PR24bijx
         0umULBLeP1OE7njgsVuv0YQn89DGPi5HWl2mSMUJ5P7wwRl8q9bKoI6HlDFX60l0aHZx
         gVhRNeYwpcivrzReQ+FX4OkDOQ/qDjCv3UZymhXiwY22LHCvHPv9Z0oCqqLWsqrLwiVv
         n9DMzjD4rGtgWHxDRpXnt3AF3u8CCZUj+533Tin0Oh6yd3w3z64ZS0hFCHhQM350Rg46
         23JWb8fSHiHuUYQwguficFMa2en6KVSaOkES9jWw0pW+sgId/4J63XFt0XtxoCuMJQOa
         gb+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxRvsvJAYi9eo/5Q0PEzjk6EvGN1WH8KP63Vwju3WkBVS1NIfl6DGYHY6ovvZztIVtsyQ50gU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOcjaRPOceUs5XugHxxxsW6UhRjA3DNWx5dLtXFGSV19HcDf0W
	ercMCt8FRYdwg6MvjedNE9BursqAcXb+xZxVafanll1neQNJJp9+25sQ
X-Gm-Gg: ASbGncvq57izKN8FZfwPgyJk6OL7JUdBtmNqsrD6cT74tLlcIqK0toCGLxzOVZym03A
	KAXAwKoUAiX73t+DOdJMYkM2OJpqWvhSg0+xp9LZ7VQFIpKVDi9Yzen8s2I5z7gaiEd5sNJfM3u
	HwUwcC9sW/okpy/S+vDg9Gof8V2X/mMbfmxO75piKj03AWtLDTcyBbt+EweZKQi1SONQcn+Qhka
	7fnTe+5kbK0YVXrEvsRzTmXt6vJgJBjs8ECQ6/yJZsFER+zEtL07AnLuDv4XaEFUC2wh+bim71t
	qdaXqM2pZjYn1jgSCemE6cfasM3nc1mgPC+jkinh/wzi+x6544x1o2b9fhr2emjj7PVXdeFkF7a
	smME2kzumlGtrnB73m22NSMLH8BPN87lx4JOrfSijAo3ipeDfAJQeMlLEMQDClrRb+10WFIUq+p
	8LHhvXq9vutlHmntE5BGNxrrCeeFQ75xMV9n2zJytqGiWNa8ZuVmuQwWjajw==
X-Google-Smtp-Source: AGHT+IEUTSLU2oYVPIwSsEjWflDd9IGMsrVIcelAzJ8gBctRSLwGtqB5UoE7FsnYSZS1DbFxFLrydQ==
X-Received: by 2002:a17:903:2346:b0:297:f2f1:6711 with SMTP id d9443c01a7336-29b6bfa0f47mr173777705ad.56.1764060882555;
        Tue, 25 Nov 2025 00:54:42 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760fafe6dsm15192263a12.34.2025.11.25.00.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 00:54:42 -0800 (PST)
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
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 1/3] xsk: add atomic cached_prod for copy mode
Date: Tue, 25 Nov 2025 16:54:29 +0800
Message-Id: <20251125085431.4039-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251125085431.4039-1-kerneljasonxing@gmail.com>
References: <20251125085431.4039-1-kerneljasonxing@gmail.com>
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


