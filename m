Return-Path: <netdev+bounces-223589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A274B59A5D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD194A3C0B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B04932A822;
	Tue, 16 Sep 2025 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxS1agps"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8A334575A
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032833; cv=none; b=AOLQrsmQwZs5HBmu9GZ6F1fy5SYCFTIT9ZwnWi5V65NDwJjpm7ZASwtpc62EQDEmEFfllj/3QQnhqJrsSUu51SMgJB6vOebBr8IoLvLF6PXXOlEUmfLRZmCDHI5TUe4AMH+LwIOEJyDhdZS26/TVB3roEoJx8eBtIrOZgjjd8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032833; c=relaxed/simple;
	bh=yKWiCvQRgC3J0KI96aLqLNQbheMmdbJ5Kiatr/clvKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCpUlu/WwKDKJHGD7BsLnqClJY5M/Xn4D/0TcgsvThG4dim91tu5i67/8U5wTtxnZIZETPQZn2OpFFlTHzfNoHoB+Q9kGrKaEe6XMiAFJYw/LOhMN0VaH8TMiCk46S3YYIwwaenIhTycgjFrlLLAk8/IMNDQQabIrP3mOUqfqvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxS1agps; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so53105415e9.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758032830; x=1758637630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08P5zo8MaqfJgIUNTWkT/44OqoALzq49oTtRNEBcbRY=;
        b=DxS1agpsblfYxay/jzcNsqjGtWnyC5SkKKEHoj0BnH0OSmWOpS0tREqQ3VjqZQXQYG
         vPdo5WU5n5Z72oO6RlG3LfE19jADefSY5K1poAm5EGtpPePQSuHiRSkLle07DP6reoSb
         F4nNVHW5vdxtfmaA25gapwzSujoc1Km18B1buIQ0Tf4L4lp+HPKDRHXKkhtTXRsV7HHf
         5khPSfYriWiesCIaAo88WhRObWoXa4kFg21HmHNBte2PTzFc8SjbUX3b50ZUtBzuKs/x
         ZELt9h4PzGagIxMPw/3NigQ3mlmXhHzIJvzqAcyMQNVBDw3uB90ui4cZnP/yiM1VSFx9
         Ivug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032830; x=1758637630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08P5zo8MaqfJgIUNTWkT/44OqoALzq49oTtRNEBcbRY=;
        b=OS0SU3TS+/F4KsqF/qrcH4rgD/PBzOwcZ7350X3dxKobexipCqa9mxDTsAnQXX52Wg
         IUEMVGsGmv4rxa0MOZuEJT4YyXDj2sUTyFlLfI0JVcwM2GlLj8hzZGyuAA78gvH36J0S
         hbF8aWunFUdI9N6s3GmfpGVcQBYkRXhj82UM3XDnianLigR40+mKmnctTJNk3H8CZgUa
         s7i00wLLepfxABTUekl6SJyS90J/N7MHgbKOzG8NmruHM6ECZsxKDELYz8Q2seIY0QeY
         AkDdDoPvu0c2D0c6b94WS18SZrS3PWKXYAYuh+DLzCCkhi5WwvUD55CgoxWc4/OVdZs8
         6jRw==
X-Forwarded-Encrypted: i=1; AJvYcCUMIljeiwwAyx9DsWBuZ/4Kx4CcP7+XNUxA3hZOFmrE8dQ9qfa+1MQ0EaQ0/9CJj4ur9caouwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJHVDcki7mlTM6bvzSfYcCqeI3z17e63g0qF8y37TLZ5xPXDAJ
	2jIPkF/8cwdZe3GxvZa9zbphX/1b81+gD1MnKblgeRpTmkfCEG2j/lLD5b7a2g==
X-Gm-Gg: ASbGnctXxACUa1r6zOpmjoT4wQ+5rBg/XI/bcEXILR2sfj5jbw0+TqJQp0KZPiIBSuU
	DF+pyXz22d0jy58NEP8EGEAfEe1PJfb3SDWX0tnLL7+GverZww/Uaetm+eo//L05+uYGzEI87Z2
	e+BaWl3IxM8TZDS6q+Cwr8qx09D7H8XkCtW8fFalJVp6N3jPxMDRntOmZdROteseMK8/JkiAgoP
	W6qc/40Co2SlVqoU13Sgvb+oTzfHEaFjsBLG5FVg+Cze/1rtQ4VG3/t5//on7Rg3EZkbWvUcnVR
	zt1N/yciEIQczN+lJWOPl6zXo1EgtuBHgVL3lBhrKh3WMIOUcT2sl4dd0ZkAGtG8HsnfwrRBdUs
	pMxtMRw==
X-Google-Smtp-Source: AGHT+IGqmqB83o1JvC+5Bh4Kf+5yZu+SXX9PvhWr/n7pxlsSvficK31Mxnms0yQNMFSzRtbz3/q3WQ==
X-Received: by 2002:a05:600c:6288:b0:45b:7b00:c129 with SMTP id 5b1f17b1804b1-45f211fc263mr136531775e9.35.1758032829487;
        Tue, 16 Sep 2025 07:27:09 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc967411sm327971f8f.46.2025.09.16.07.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:27:08 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring for-6.18 17/20] io_uring/zcrx: don't adjust free cache space
Date: Tue, 16 Sep 2025 15:28:00 +0100
Message-ID: <c8e94ec4b524bb2efb91b8ae2636d830d6b56f0c.1758030357.git.asml.silence@gmail.com>
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

The cache should be empty when io_pp_zc_alloc_netmems() is called,
that's promised by page pool and further checked, so there is no need to
recalculate the available space in io_zcrx_ring_refill().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 630b19ebb47e..a805f744c774 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -759,7 +759,7 @@ static void io_zcrx_ring_refill(struct page_pool *pp,
 	guard(spinlock_bh)(&ifq->rq_lock);
 
 	entries = io_zcrx_rqring_entries(ifq);
-	entries = min_t(unsigned, entries, PP_ALLOC_CACHE_REFILL - pp->alloc.count);
+	entries = min_t(unsigned, entries, PP_ALLOC_CACHE_REFILL);
 	if (unlikely(!entries))
 		return;
 
-- 
2.49.0


