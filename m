Return-Path: <netdev+bounces-223582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FD2B59A6C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A333466186
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E9534165E;
	Tue, 16 Sep 2025 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXsJz+PV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50554338F3B
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032822; cv=none; b=Z6TJLJuNzLHBufZC7JFy/WTKALp1MCqZK2kyTAr40as3y3wsyYfI7NsjCQOovH/cpGZ59axbh42UwRet8tTTJ9PeGc4ej+awVWv79aS+k1yiFcoyqf2vNalh065vUUIoLNbttQDlGGR4ulPD5V498blDNpJ+3ahjR6tCqfWALr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032822; c=relaxed/simple;
	bh=StXOhSyFL75NeRitAWeKs5bCicJEc+YXL0Sldl8wGFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzC10jIJ12VvYkfiU/meT1i65u/CCHRCoRsQcFB/tbd1+plw1aVHzgfqAT43pXPbWPQtJy3/lHDJePst7IvQLrUiWyHo/c/2Mg95uaA6EN99xE8hy5c9iB9m0oqeAxBesmqAt0Mnv80nEfOxONjGvo1kT83eRCytR8s8JcPdtLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXsJz+PV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45f2313dd86so37773845e9.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758032820; x=1758637620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wbyZuzv7Pkv9kcTX/Gpz/2kxggq153qwmXmK4qfh5Q=;
        b=iXsJz+PVW4TnIxQn3+J4Ww8t5zUzOCLBWnWSJ5L9ioB4QA+xIXmQ/uNM7VDgm+NONK
         J+ECYxVUt+lNmXGthoUbW8siLX3qKhPwBat/JAfyP4YU5COEGZzOzZ16SPnarohXNTdh
         0TQxIHi+6cvdUS9Zu0xyaS43CLkENpQYKH2CjjzU4mJ6LhLbCJ5u+9xpJRywZKCQD9E3
         nAMesQNxY2FDpIyjaXjQim2Pbj1LgmEq6KBppTZFVzOu6veBkVJeXpf29YXO4R+70u5q
         ffaZ35RraB4Jdry9izOBRGY2SfAJ7YXYCqsxXj9n9Yzzt6Zn2eSDpLLtjc+Lcg1CC1bz
         GnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032820; x=1758637620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wbyZuzv7Pkv9kcTX/Gpz/2kxggq153qwmXmK4qfh5Q=;
        b=CPu55gOCGPK0zGhkxFCiXrA+rCDldGUcpX5S00vOLnJdR347rEHM9qwp2C+6OfFbJg
         06a6BKNapc1AxHHyL12eGmodBhl1sWa/psKkD6XZDfilrGGnguVRaqN0n9IDlZTG6dv2
         9Uj8Hi/lbVQf1mi0cSvhU3oHgOotO7lHtqVFjOXBuiaCrM5MXqUCQAjNLa2PdORG/X7+
         Z3xQJftaXpgIEMRxBSHUrGRaj7GAlzKZv2MFp40BPdk1bwvjGkA/O+x25XN44PlapIx7
         ymqTns31l4AmF0XLRzJf83LJGVCNTYivzPJhYxBsJpjt8kVub25jiujAp6po+mG+kObi
         indw==
X-Forwarded-Encrypted: i=1; AJvYcCVyLihkDopsE6C8Y83JUc0Bv3CcRRolArkgb6J4RY1C12QdaMv9DtTiHh5XE3dZVMnGTwTZWTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLJanJ1m0l3BgXRTGzNEg7LusNQrZj48HVAO+BTk0lqKLwsqO1
	b8Mrsjk+YDCbjwX4ikPr+ihuIzDGSC6uNCaWY/nzqCDibVlhsjq8Xq7N
X-Gm-Gg: ASbGncuKO0Q3gp8btOINnoVHSx5cEZRG0oIPBZamUOoZLfVvCU5RobRU4S95C77fZI8
	klSM5fPQ/6iwH5i4m/DGgxb97INYZhNVQ2K2eIkIczvdTe96WpmlsO5zs6Mm0H1q6crmKoTI99G
	g1uuau2y490+kUf0S47oD3Hq1lnju7ho5otHJ9ou/2UByDl/MI5yF+YTM5vfmXKtcY8WkgDEb/V
	LNt4MCfyt0mr6oNuThJ95gPjwjuZMBMNZsatr6FgUR7hs7oES8GvcQx/L5HUWKUlexH4QRs9xcB
	dxS7w7pSpNJRhd52zub6/nC11kEk8XbaVJermK1mgPn33k5o0VJvCevsIxVKgPSPX/MoctW8T4E
	1bmL48Q==
X-Google-Smtp-Source: AGHT+IF11D7Z39SuGn1mAS2KcDTQWn4IURGhKXMmsIQr9LAEX/FjyeAVRFuj2datvLInyrHX0lQ4bw==
X-Received: by 2002:a05:6000:1846:b0:3e7:45c7:828e with SMTP id ffacd0b85a97d-3e7659d3b19mr16438038f8f.33.1758032819511;
        Tue, 16 Sep 2025 07:26:59 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc967411sm327971f8f.46.2025.09.16.07.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:26:58 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring for-6.18 10/20] io_uring/zcrx: remove dmabuf_offset
Date: Tue, 16 Sep 2025 15:27:53 +0100
Message-ID: <249a6bd973c8e3d8e35fcb6ac338b4928f06e394.1758030357.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1758030357.git.asml.silence@gmail.com>
References: <cover.1758030357.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was removed from uapi, so now it's always 0 and can be removed
together with offset handling in io_populate_area_dma().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 13 ++-----------
 io_uring/zcrx.h |  1 -
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index bba92774c801..bcefb302aadf 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -53,7 +53,7 @@ static inline struct page *io_zcrx_iov_page(const struct net_iov *niov)
 
 static int io_populate_area_dma(struct io_zcrx_ifq *ifq,
 				struct io_zcrx_area *area,
-				struct sg_table *sgt, unsigned long off)
+				struct sg_table *sgt)
 {
 	struct scatterlist *sg;
 	unsigned i, niov_idx = 0;
@@ -61,11 +61,6 @@ static int io_populate_area_dma(struct io_zcrx_ifq *ifq,
 	for_each_sgtable_dma_sg(sgt, sg, i) {
 		dma_addr_t dma = sg_dma_address(sg);
 		unsigned long sg_len = sg_dma_len(sg);
-		unsigned long sg_off = min(sg_len, off);
-
-		off -= sg_off;
-		sg_len -= sg_off;
-		dma += sg_off;
 
 		while (sg_len && niov_idx < area->nia.num_niovs) {
 			struct net_iov *niov = &area->nia.niovs[niov_idx];
@@ -149,7 +144,6 @@ static int io_import_dmabuf(struct io_zcrx_ifq *ifq,
 		goto err;
 	}
 
-	mem->dmabuf_offset = off;
 	mem->size = len;
 	return 0;
 err:
@@ -269,7 +263,6 @@ static void io_zcrx_unmap_area(struct io_zcrx_ifq *ifq,
 
 static int io_zcrx_map_area(struct io_zcrx_ifq *ifq, struct io_zcrx_area *area)
 {
-	unsigned long offset;
 	struct sg_table *sgt;
 	int ret;
 
@@ -283,13 +276,11 @@ static int io_zcrx_map_area(struct io_zcrx_ifq *ifq, struct io_zcrx_area *area)
 		if (ret < 0)
 			return ret;
 		sgt = &area->mem.page_sg_table;
-		offset = 0;
 	} else {
 		sgt = area->mem.sgt;
-		offset = area->mem.dmabuf_offset;
 	}
 
-	ret = io_populate_area_dma(ifq, area, sgt, offset);
+	ret = io_populate_area_dma(ifq, area, sgt);
 	if (ret == 0)
 		area->is_mapped = true;
 	return ret;
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 109c4ca36434..24ed473632c6 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -20,7 +20,6 @@ struct io_zcrx_mem {
 	struct dma_buf_attachment	*attach;
 	struct dma_buf			*dmabuf;
 	struct sg_table			*sgt;
-	unsigned long			dmabuf_offset;
 };
 
 struct io_zcrx_area {
-- 
2.49.0


