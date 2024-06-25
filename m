Return-Path: <netdev+bounces-106654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4729171F9
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 22:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2122F281718
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9408E17E45D;
	Tue, 25 Jun 2024 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ij/BuTPs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE9717D88C
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345335; cv=none; b=hfrDWm+i///aw7hBxp4nEYjfmpNNh0/gyq+kIVXAfQP+QZ4SdcfPsQDJEBOLt4XvDhe0+C/MjLdstBtgOc4hyonmEu/5y99/H4cENh01XaQux2h1rfnodZhrhHzR7uHrLvajgVu9o/n6Mw0lxI4c0mmOswTKiZpgFlTTBp/UYsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345335; c=relaxed/simple;
	bh=yQuDYyahyWrhpTwH6AYOLVPvgn4oGOMD/+riHf/SobE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSk2X1n+wuYR5JRdyZZJM3nwrO8Nd8NYaznuoS6e3BQSiwkX+beo8yu6ON9+La8aCc8SEB2vSY2Kv1qkE68NmY1tzCx3vec8y1v/cumHisAtb9eEOI8YER17Eu/Q7ejqQbmbdry0ycfIxUkrGC8J5ckXnafcVtKRVB2yfnz5yp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=ij/BuTPs; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f480624d0fso46813375ad.1
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 12:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1719345333; x=1719950133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+rHMLF33wUGoT93vAdJCy4YIKyj4oGjqYA3VqFPsY0=;
        b=ij/BuTPsYTck6Cxsm4yhusPShM6e0laEoBzXd0FouQQGrdT4oEpB8ukWwx005vVC4r
         Fl8cLp4RfEn1eB2S79/Vs064o/lG5+CThaWx0HUQLAddrU0Hzc/MnO5EZRJ8l7qcdpEk
         b3MjY2W0o3iZMy3BQ/V00wHllxtpaxgw/r8LfHl4EGDT0QC8rIT66YxA3ZcWPxitFASk
         LhcvYDBfJNlQF6rzshvtTA4fl8qeJPldwthdg7zxelC5KMh3EEVooV3kSvpds8TgGICc
         21hKNfuuf197ZHnrCBOBT/LtJUpANV/UaJ4Y0hB6m0AaMrBDYtGvQicIZeGlt6FRDXlv
         4s/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719345333; x=1719950133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+rHMLF33wUGoT93vAdJCy4YIKyj4oGjqYA3VqFPsY0=;
        b=SQ/aAn0MQ7xm4bgmRK6MJ5eooEcIKGLEhqpXIqiSfbl5bnvyivQAynfO+fKr4UVE59
         ooM8tlNT6KVJ9QWtanC2LgQu9q5R32NMe+wJLYFOsMlsVklspYiRFlEfjJgI95G0niJP
         bk5zTJ9j58qJb9tirDOgIaLDt/hqe/FXnMYaIQjeIzt1jnX8RmQ8TTj0M8GPpaSXfjbH
         36+Cdnm47wV1P036cqSYn7YQ8JezEHDTn0SAkbqE5zUmIQBQl2U2xNyqX5a0bTf7ApAK
         qrUuDD99Zln1L3K3qrhTNbdac13dPmNmPhbtutsi3OUFP0tIuLnTBZU+wP+a7jgTBkXz
         Kx0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKB/1f16xy1x/ibRIEVoAhbglM5N5Eu0y6NOSBKDRQl67cF91X3vbcqBgL7Y8/734oKa3MkfI7fnxltDob0Jx6a3Pkqu9W
X-Gm-Message-State: AOJu0YyPvkPZ5Xwgc5tE8wBYKtPf53JaTrC5/c7t6dUMRF7Pb5T9Mz8f
	klBp5mxNBqrqU0RKGrHVbS3vDQhCcEWfJU171g6Z2IrK9RRgbZRL7iXY2x2TDZ4=
X-Google-Smtp-Source: AGHT+IGosKYvm44LZDXoi8nS+gdZOULLTYynFShPVttc8Av5lY71SvE8tV4MEGet2G9PjWhfyDKngg==
X-Received: by 2002:a17:902:da8f:b0:1f9:dc8d:236c with SMTP id d9443c01a7336-1fa240e7601mr79953595ad.50.1719345333414;
        Tue, 25 Jun 2024 12:55:33 -0700 (PDT)
Received: from localhost (fwdproxy-prn-013.fbsv.net. [2a03:2880:ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb321d4esm85613795ad.67.2024.06.25.12.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 12:55:33 -0700 (PDT)
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
Subject: [PATCH net-next v1 1/2] page_pool: reintroduce page_pool_unlink_napi()
Date: Tue, 25 Jun 2024 12:55:21 -0700
Message-ID: <20240625195522.2974466-2-dw@davidwei.uk>
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

56ef27e3 unexported page_pool_unlink_napi() and renamed it to
page_pool_disable_direct_recycling(). This is because there was no
in-tree user of page_pool_unlink_napi().

Since then Rx queue API and an implementation in bnxt got merged. In the
bnxt implementation, it broadly follows the following steps: allocate
new queue memory + page pool, stop old rx queue, swap, then destroy old
queue memory + page pool. The existing NAPI instance is re-used.

The page pool to be destroyed is still linked to the re-used NAPI
instance. Freeing it as-is will trigger warnings in
page_pool_disable_direct_recycling(). In my initial patches I unlinked
very directly by setting pp.napi to NULL.

Instead, bring back page_pool_unlink_napi() and use that instead of
having a driver touch a core struct directly.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/types.h | 5 +++++
 net/core/page_pool.c          | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 7e8477057f3d..aa3e615f1ae6 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -229,12 +229,17 @@ struct page_pool *page_pool_create_percpu(const struct page_pool_params *params,
 struct xdp_mem_info;
 
 #ifdef CONFIG_PAGE_POOL
+void page_pool_unlink_napi(struct page_pool *pool);
 void page_pool_destroy(struct page_pool *pool);
 void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
 			   const struct xdp_mem_info *mem);
 void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 			     int count);
 #else
+static inline void page_pool_unlink_napi(struct page_pool *pool)
+{
+}
+
 static inline void page_pool_destroy(struct page_pool *pool)
 {
 }
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 3927a0a7fa9a..ec274dde0e32 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1021,6 +1021,11 @@ static void page_pool_disable_direct_recycling(struct page_pool *pool)
 	 */
 	WRITE_ONCE(pool->cpuid, -1);
 
+	page_pool_unlink_napi(pool);
+}
+
+void page_pool_unlink_napi(struct page_pool *pool)
+{
 	if (!pool->p.napi)
 		return;
 
@@ -1032,6 +1037,7 @@ static void page_pool_disable_direct_recycling(struct page_pool *pool)
 
 	WRITE_ONCE(pool->p.napi, NULL);
 }
+EXPORT_SYMBOL(page_pool_unlink_napi);
 
 void page_pool_destroy(struct page_pool *pool)
 {
-- 
2.43.0


