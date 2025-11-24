Return-Path: <netdev+bounces-241107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B74BBC7F5C2
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 09:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 930FA4E41EF
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 08:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921FD2EBDD6;
	Mon, 24 Nov 2025 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcbWx2aP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ACB2EBBB8
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763971758; cv=none; b=VpFcs40mym9x4rNL79suUiALsZ34CCxJXkCYY005sXvmYmcfoR6cWA8aZ+AYcMDbRQ1ZEBHD3W1e2lUuvdB2FyWCK3GQhiis5VoTM9cjqq0E+XlHio7O1YcdG0fucSASckFs2BVOMicGw7ycO30eCcmDwMFi1WuBLQNA3Kx/MKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763971758; c=relaxed/simple;
	bh=zlvW/jN0idui1pFEaPCILXLEB6Pz7MYxpVsI6cS6zyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HrO5S3tsXFWkTl3msBgCheWcMA4tDvtK0jKyJdfUOTvvbJEx0hSFlDDP7h+IjHoPfAYfGBjirZcdsPXYfuaPWTsVlZt6e1uNEW5PcCOmnrRWdZuKGYekcJKPwAbvXncKVleA5vhxN0+dbuE2/9H5kNYERN2vBWcNbRReowYayOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcbWx2aP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-298145fe27eso64488985ad.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 00:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763971756; x=1764576556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IekuUIo821t9wwHs/lSRsb8eGj/j82qutdOJ8AF9uIQ=;
        b=WcbWx2aPqWyghoIoEL3YGn0+N0MkjycZbPH0B9X6+YLy5ZRmtPdSghoGEGMAnFaSaN
         l4Huty4mDHZIlkKmT4rkrpKyU0mT8Jt9qdoJshw9wOuN0JBq4u7fDWU1FyMPJzaqPcTl
         +b9oix0uOvUrXaQJl7rSOzVLvwsq34dCD78btZZxk6TjUACqBg1ulvP9rP5XfaOT1ffF
         Dz9gncNwTwEd3/ryopi+ZDmSIo+QMosTbEZ0n97kzoWvCGeiv6d2AvOqLznri0N47F3I
         YgOGGccbjrTQlASCNy1ErZXJDosMG5iKjBX1fc2cqXfTLFymV0vVCugi/F9jLirnBA9Q
         10Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763971756; x=1764576556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IekuUIo821t9wwHs/lSRsb8eGj/j82qutdOJ8AF9uIQ=;
        b=GAJo16V3qP5ZdJu1cu1YQ0D4vLhNoVgf3TiMciaXB71rkG8jv0ZuF3TxE3vj38vtcp
         yt2UjbM20PKpmRIguIFrcGCSjYcl8fCcq2z/aqSU0Ke4FlFOzNx91ldEis2FxUTfsHlz
         FAziEQRi7gIalLdvrrRWEVJtS6XDFyxzvvXUrLeyVFZ/SoOYTB2eNWycjw9LxN1HawB0
         RQL9jo7fWg1mSuYYS/nKntlA4kpo67xRivjZMJyZU+c1r0pHTwa1Pwblr3A8iMfCpRXA
         FXtZ6Slrrhzm83eQa1RxJx5iqtNrL9kCiF9+2rrOORou90R4UfMQkepi6tlsWtDmJo5e
         2UnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7AurXsKmDUT3XbqqhksfOSxILGC4QhEHiJHBE1AOTZObPo/0HpyLYCamGVy34v7vGJyoS7kI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVmmh8Plfheb+kq+yIyhH4XMTc5tUms5xmoQjE44oG+xYOalZZ
	O9VpsCN5MSMjpwh63z/mS5+qD8B97+ImqWp/r6QiH2wl4cXmRqPl/GfU
X-Gm-Gg: ASbGncvkqA3h6p6JWp8x3p+UJUPLCyE8RatEhtqFXb4xuy8KWUGY3ZSzc36+2QkYT8X
	FSysrkqJ3zvn3F7DjLk9ntz7cwLtPLnvv+2SuBfnRwNTyxhV6oSb5wsdbJ3vrD4G7jL1M23KZ+c
	5NPte7C3m717v8mMvZSOD0JigZM1rrrEVLjikX5G4Du6QCmmG8bv/0OMXMfSWjAHCGpkQeCXHbE
	ggTYz6vsFqPr+6xfOIqDqkcZuiLCB4/DEkZxpPpLNIIWpI/JsrBAVKpyqWHKEBH2QPU46gxc8Um
	UWI9i1qxEA2MI14b6Wn2lsKPdGL/wx8PmNKzjUgvPznJE1oyDXgNyfO+SWAw30dfwcoeBH4fr49
	1iLzdHqPKV76dUbewvOSzFYvq7dbYAGgzaPwekVDo0Aw0xIK96NJ2yh32yKtiwt9uKc2tfcNp4V
	KRBRwm8vGU8jXoabca4fz3Nj+MHZ8HdTFMh21FaqpuPxgMaohSCm3Ge+MjxCK260kZad+48pWi
X-Google-Smtp-Source: AGHT+IHfln41jit+BGWi7eDfn0SqiKQon4rcNv96vXLGd9L0YhJIDpWhyj95ZxZ7enF1SbdriLcfig==
X-Received: by 2002:a17:903:3c43:b0:298:1156:acd5 with SMTP id d9443c01a7336-29b6bf1a67fmr121100965ad.39.1763971756226;
        Mon, 24 Nov 2025 00:09:16 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75b61c29dsm12343837a12.0.2025.11.24.00.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 00:09:15 -0800 (PST)
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
Subject: [PATCH net-next 1/3] xsk: add atomic cached_prod for copy mode
Date: Mon, 24 Nov 2025 16:08:56 +0800
Message-Id: <20251124080858.89593-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251124080858.89593-1-kerneljasonxing@gmail.com>
References: <20251124080858.89593-1-kerneljasonxing@gmail.com>
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


