Return-Path: <netdev+bounces-154925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3DCA005C4
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819763A0FD8
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB041CDA01;
	Fri,  3 Jan 2025 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rmc4F93g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634E01CCB21;
	Fri,  3 Jan 2025 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735892943; cv=none; b=a0sk+MK4Io0FzsDq07KjO6fI0x7DGBS83RxOiHDN3qyCwFls7meVyUKr3Hz9M/oZ1LJRHsACyWvLBWBdqX+7NZaWo2r94ihKOVyPYsJyYRxXZzsOXgqxUc0Ys3hR/0hAdawUd9V4K7Br4Il1k/iiatr9o3d/XHNShS2MKll7zAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735892943; c=relaxed/simple;
	bh=yqGxIOubvwRH17QFNJ5RBvaCJClBawA5ixmjj4qRnnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rdZ6h+LNg98kT+xT1HL3QRRQ7uq2Zr/eNDosHB/X6ZrMNOdnv68EsWVu0/5y6/oKiwUvUN9urWsD0/e4ZwvQLjBdWz3PxSuzkhgh2vfTqVU59ptWp8lN3kcmV7Ti4HIQpszMmPgs5aUMtAwoxaQwdOpuFdcI/28t98AoA3Vo9hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rmc4F93g; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21654fdd5daso155679705ad.1;
        Fri, 03 Jan 2025 00:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735892941; x=1736497741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n8eP+CVwxe1ePUrPH9cJg1ukAitxpgbSqH95cMNozzE=;
        b=Rmc4F93gBu7XuHO/xu15UpuPt2NMgtOJAy1IACeNCsCAKxJCyU7L0EfpP5/yF8DyeQ
         ob5WuFRcjK0GobCzvDYOA/vR1qt2ZdOJ00LH4Ovp0jRDDgXf0et2alz1mf5GZocJfAMp
         wPcWNbgv1rUEY+g/AFF7jQPDqKcIiktzKF0x4gpOpUGJloWKRmVYChszaJTDv6sI2N33
         HZvSBQCVjuKTjPOmyX30Rr/iKHcC0H9BoeMk9XNu9V8JVhHtihyUMTsEKPtHMztxQ7ca
         OuJWQNES0XXDbbyLaYj2TeXuEU9DsRQPLPdrlLdRlkQi1cV3KiEaEpCBz/Gjkr6Mab+p
         jang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735892941; x=1736497741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8eP+CVwxe1ePUrPH9cJg1ukAitxpgbSqH95cMNozzE=;
        b=l0cy7tYQm4C4Wq1YV91gJ1iiclGB7joHzaBlSq/04KKGhgOB0nKKUsFXDoewbUXFPt
         uLAMWzW8f9kPCkmgEIOlLXdTEXK5JxB55fJCx+6/sD8GEMNkInm5tBWzoqnO6QVE4x1L
         if5apsVCaRUy+XEB/xlTEH6Ect0FMyeEwBi16GTzlCd705ZBREksiRlveVv03Bb7HvVz
         C16SM0P3EsIcRVlBLLH2hmwA6JTjVuQIi8BtGcIiJFFW+3JZeWCnDeCX8EtJfPAJEGuU
         +EcW3xg3JK4jEXhbj+g8m5D0Hay2GAEvIHqg6Px5rFB2T6ZdcW8dW6Vob/iEKBFN2OON
         UF0g==
X-Forwarded-Encrypted: i=1; AJvYcCVcSDBWOE0KuzQdz/9Hkqb9mtjnwYUiCLVUs6GXxKB9UhddwAKGU+XtoPcUQ6QyPEaODMe6bNdA0f+MKSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL1TyYtWof2um6bFb9hMCwKyTkuD4vwJLoJE7sRCuQGOhLx+mL
	Eka1mSJN53onNxU8ZsA1ZE7VDeAEyLy6RZXtFNs1E36i9DN6un7dmma0Rg==
X-Gm-Gg: ASbGncsev+YYL/aSWaCZDC271Fg/XgebiS4QAjyIB8/ifI3YcFDmeccP3JEDYYd3npH
	ZdZcWYJyWV7sPcIOpGz04iaYLIIqkC1i4/ttbQLUpSG8gqssOagjsfNtl9BRzrf248SgB8pTghu
	SVy0AtWk9yHIOw1ys6a49GENtjr+ACYP4QPriG77k9mYx544Gj80F4MYlMy5orRn8Gn7prajBb/
	TVz06YEpADqlrXQJ51Y8ApGdK1BP1V18Z4x+IzNmeUC7AvG1jVqmKsxuG3r6+fwmmMByQ==
X-Google-Smtp-Source: AGHT+IFr7tq0hav74bmJ2wLkeB+Fon+nwjYL2uo6OtQ6g0jqfhnGDQpL/RGFiyYoJEKlip7FfMhGDw==
X-Received: by 2002:a05:6a21:3985:b0:1e1:9662:a6f2 with SMTP id adf61e73a8af0-1e5e07f973dmr84507362637.35.1735892940679;
        Fri, 03 Jan 2025 00:29:00 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-88b8820a5cfsm18658311a12.8.2025.01.03.00.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 00:29:00 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v2] page_pool: check for dma_sync_size earlier
Date: Fri,  3 Jan 2025 16:28:14 +0800
Message-Id: <20250103082814.3850096-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting dma_sync_size to 0 is not illegal, fec_main.c and ravb_main.c
already did.
We can save a couple of function calls if check for dma_sync_size earlier.

This is a micro optimization, about 0.6% overall performance improvement
has been observed on a Cortex-A53 platform.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
V1 -> V2: Add measurement data about performance improvement in commit message
V1: https://lore.kernel.org/r/20241010114019.1734573-1-0x1207@gmail.com
---
 net/core/page_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 9733206d6406..9bb2d2300d0b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -458,7 +458,7 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 			      netmem_ref netmem,
 			      u32 dma_sync_size)
 {
-	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
+	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev) && dma_sync_size)
 		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
 }
 
-- 
2.34.1


